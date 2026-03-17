Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37517FF6E9E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dlK-0003wV-38; Tue, 17 Mar 2026 19:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlI-0003vv-Pl
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlH-0006Rw-7k
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773789822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PN63kHSkiGklfAkICvLJCg4I6fSHLpVorWEfRkM9FZU=;
 b=iUelgLXHp6nXM+6upe2nwk7xSBshRn5RO32fxhns0xRnp0FbYUMyedOG8RfODeRZsXun4p
 MNjXg+iogtEAaVoJ+sAbh1+6/V8OU9i6vbNwGYMX9IQGTX1/Ph5SZCuAuxBcxsbs0sGAxv
 GNjzZ3klGghZofZjzfoumgJltD+rCX8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-PEJrET97P7anVQf27T9HNA-1; Tue, 17 Mar 2026 19:23:41 -0400
X-MC-Unique: PEJrET97P7anVQf27T9HNA-1
X-Mimecast-MFC-AGG-ID: PEJrET97P7anVQf27T9HNA_1773789820
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89c56300e64so106186636d6.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 16:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773789820; x=1774394620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PN63kHSkiGklfAkICvLJCg4I6fSHLpVorWEfRkM9FZU=;
 b=BtVm1dVSp2KLgKosQd70/dsJPBR8sE1TOwvDdwwOYtsn++rM14sGYPTv+zJP7A4raR
 q5c+ALbWsC/VCTxolHXxEhyUY2eRW51QTXChep7w0Ulu51Zq5GSe5iTX27zHVtOFXx1j
 9cNU78SPr+TFlozfR9v1jH/Up/Cr2+THc09YoCT6OEUcOax1fTSpAt67R5FWOFlGW57n
 oEtFfReqy7juq5A4tu1Dc2CWCaWsfeRZbt0Q8ZoziXFv/CU2+8I3Bow8U1X7YEnInnBS
 NDttbhvsPU0u22LZIRy+MM9QGfU6I6CjfugTY8aihXs0r+M7dUA0v8g1SBxK0Agyfs5x
 JoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789820; x=1774394620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PN63kHSkiGklfAkICvLJCg4I6fSHLpVorWEfRkM9FZU=;
 b=DrfsJ24tKDna4aImP8TSac3dAQkr3scRYwN99ZjREW1STubkE6s60WRmzwY/eMzyJB
 Pis2BYxzXAru6qWUVBhAzEFKjyZbJ8Zy1luzdte+gWccoehc+5ydgkmLyyZb972+wIIb
 IvRQ9vSmicZZduxJQPpAKzmahwNfbwrW7sdDL4dXr+uFF4adCzW7X3odgpl3/INMMlsk
 0uq7q5vuchPXdElEtivXFytfRMIJkr2otLLeo3H9iADCFiONmLt9aiNtcpHV8UDflt+x
 0InCXOR1qGqNao8m3rM0SOuRW4gY9OmIyjpwSAjFx6CHeyQNPeoMM3V7vXtuCOblbjrB
 NVLQ==
X-Gm-Message-State: AOJu0Yz0UoDVd4WPDggLwp5G+1a25lQT57CqdIwsRuu/DoQss3D0Mk84
 sS2skhH2FJs96g53QugONcr4MV3aSB3C43PLAzWio+CQYHgE06vVgBtJU7fx6w2w5HLYZHIxTJy
 uf0fmcmWlcGVOWXckQOWu5KN58b3MveV7qQeWAIkSHB8ULFJFZA6Zy+J6OM5c2i9HYwCoqKlXQW
 E/I7qsA1q2TCMT9jZ+j+/8lyJutxKdScKJVQx0Dg==
X-Gm-Gg: ATEYQzy9mPsHwYurtDMQb1uQ7BdvThwgY/Q6m5Xm9dCJKGk9jQ7Hj7KlBo1M+hRz9ry
 s1EDiu19QMVgYfEP0RbtWaei/ua8CCUFMAJuXGb1OGkdSD22fFXoLFWsWcYADY/m0Qp7K3JOcy3
 H/VnoFbqDlWZjwDQMEfefnmNpHS2+ml9vvCU3H2ldPg1CM94076+psiz1ahH/KFSUnQp+uX+jZZ
 25l1UMjTPdpxIZ943HLASCrdvPm4KTUA+ez2AesqIrG77LNLDgmbN/0XHdXtWHZvHB7gmunkYDr
 Qn+/9pKUTbcHm9wBMl9bWeKq/deqMZcYzlKbys3Xie3OVmYguzTxMtdcR11wacWbtWSOrk6SWjl
 yjXIvU9ZE6pez7w==
X-Received: by 2002:a05:6214:5d0f:b0:89c:5557:88b9 with SMTP id
 6a1803df08f44-89c6b58d971mr21984206d6.48.1773789820023; 
 Tue, 17 Mar 2026 16:23:40 -0700 (PDT)
X-Received: by 2002:a05:6214:5d0f:b0:89c:5557:88b9 with SMTP id
 6a1803df08f44-89c6b58d971mr21983916d6.48.1773789819542; 
 Tue, 17 Mar 2026 16:23:39 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b9ea39asm8203806d6.37.2026.03.17.16.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:23:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH RFC 03/10] vmstate: Do not set size for VMS_ARRAY_OF_POINTER
Date: Tue, 17 Mar 2026 19:23:25 -0400
Message-ID: <20260317232332.15209-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260317232332.15209-1-peterx@redhat.com>
References: <20260317232332.15209-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When VMS_ARRAY_OF_POINTER is specified, it means the vmstate field is an
array of pointers.

The size of the element is not relevant to whatever it is stored inside: it
is always the host pointer size.

Let's reserve the "size" field in this case for future use, update
vmstate_size() so as to make it still work for array of pointers properly.

When at this, provide rich documentation on how size / size_offset works in
vmstate.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h | 20 ++++++++++++++++----
 migration/savevm.c          |  3 +++
 migration/vmstate.c         | 10 +++++++++-
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 68fd954411..b4bc69486d 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -183,11 +183,26 @@ typedef enum {
 struct VMStateField {
     const char *name;
     size_t offset;
+
+    /*
+     * @size or @size_offset specifies the size of the element embeded in
+     * the field.  Only one of them should be present never both.  When
+     * @size_offset is used together with VMS_VBUFFER, it means the size is
+     * dynamic calculated instead of a constant.
+     *
+     * When the field is an array of any type, this stores the size of one
+     * element of the array.
+     *
+     * NOTE: even if VMS_POINTER or VMS_ARRAY_OF_POINTER may be specified,
+     * this parameter always reflects the real size of the objects that a
+     * pointer point to.
+     */
     size_t size;
+    size_t size_offset;
+
     size_t start;
     int num;
     size_t num_offset;
-    size_t size_offset;
     const VMStateInfo *info;
     enum VMStateFlags flags;
     const VMStateDescription *vmsd;
@@ -547,7 +562,6 @@ extern const VMStateInfo vmstate_info_qlist;
     .version_id = (_version),                                        \
     .num        = (_num),                                            \
     .info       = &(_info),                                          \
-    .size       = sizeof(_type *),                                   \
     .flags      = VMS_ARRAY|VMS_ARRAY_OF_POINTER,                    \
     .offset     = vmstate_offset_array(_state, _field, _type*, _num), \
 }
@@ -557,7 +571,6 @@ extern const VMStateInfo vmstate_info_qlist;
     .version_id = (_v),                                              \
     .num        = (_n),                                              \
     .vmsd       = &(_vmsd),                                          \
-    .size       = sizeof(_type *),                                    \
     .flags      = VMS_ARRAY|VMS_STRUCT|VMS_ARRAY_OF_POINTER,         \
     .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
 }
@@ -567,7 +580,6 @@ extern const VMStateInfo vmstate_info_qlist;
     .version_id = (_version),                                             \
     .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),     \
     .info       = &(_info),                                               \
-    .size       = sizeof(_type *),                                          \
     .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
     .offset     = vmstate_offset_pointer(_state, _field, _type *),          \
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index 8115203b51..f5a6fd0c66 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -868,6 +868,9 @@ static void vmstate_check(const VMStateDescription *vmsd)
 
     if (field) {
         while (field->name) {
+            if (field->flags & VMS_ARRAY_OF_POINTER) {
+                assert(field->size == 0);
+            }
             if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
                 /* Recurse to sub structures */
                 vmstate_check(field->vmsd);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index e98b5f5346..e29a8c3f49 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -110,13 +110,21 @@ static int vmstate_n_elems(void *opaque, const VMStateField *field)
 
 static int vmstate_size(void *opaque, const VMStateField *field)
 {
-    int size = field->size;
+    int size;
 
     if (field->flags & VMS_VBUFFER) {
         size = *(int32_t *)(opaque + field->size_offset);
         if (field->flags & VMS_MULTIPLY) {
             size *= field->size;
         }
+    } else if (field->flags & VMS_ARRAY_OF_POINTER) {
+        /*
+         * For an array of pointer, the each element is always size of a
+         * host pointer.
+         */
+        size = sizeof(void *);
+    } else {
+        size = field->size;
     }
 
     return size;
-- 
2.50.1


