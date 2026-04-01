Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DBED35154
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82BT-0004MC-80; Wed, 01 Apr 2026 16:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BM-0004Il-T2
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BK-000385-IY
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775075333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPQP5b/pynpHzfsBPX6i6Pduta9C+EPL3oVh5IQ70nQ=;
 b=Y1Y+1bKXw8yj01VYKp/gseaS3KwkQ5PHbXEberGM8zzDah8WgrWM+R1fxVpD5OSQesKuDl
 gISac504pbLWUDr1uotwRUdI2Iss61BTBy+v4vfk88JgPLTSIMutQLQ84ZxQKqf/iAyyJ1
 ZSibjjjLYiuE9a4j1zzoDCgSgzMZvfk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-ID8bNQYnP5KlbrnI47Ssqg-1; Wed, 01 Apr 2026 16:28:52 -0400
X-MC-Unique: ID8bNQYnP5KlbrnI47Ssqg-1
X-Mimecast-MFC-AGG-ID: ID8bNQYnP5KlbrnI47Ssqg_1775075332
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cdae902bccso50843385a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775075332; x=1775680132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPQP5b/pynpHzfsBPX6i6Pduta9C+EPL3oVh5IQ70nQ=;
 b=B+j5p3pN8IDNDH+7fSjCzNZzSOB7qAvj/D4P1mXvLsZq8OU+s27SWN0T1nIIVUMzHL
 vw7KOMHoG2qyVtko7bJAwpixcJz54fWoqA7H4HZRW1F5njXYZX17JbM5VrGX697eWmHv
 e6OV+W30Ao4+WyF6FTz4k5ipEQeOT7kZsCmCTtVwerQ2ZCqEjS07rx8WuFzoRxp19BZ4
 MgmGNjChT76mlt/m3AYcXiiumwUdec86HxL7tFXX2JVZkWC0uIGFUx580oQeaIZv5WYY
 kEpTLJH/M1kpbYG3C28pyzMq2RRkle77Xg0hTBbCKOp57IECmb0QtrDmaxPLv87tFk1V
 MKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075332; x=1775680132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hPQP5b/pynpHzfsBPX6i6Pduta9C+EPL3oVh5IQ70nQ=;
 b=WrJ7JTn25DOOGraXukB+TkyRtuKyTq1P5NTCM4dnyqkC/0wbvaN7RJkI+KE80KCGFr
 th5aFA9n5nGf5w18t3q0UiPb6LogfmAExqpos5EMJA2sLvjntMpR9xwwJpYNWzyrHI2I
 lCZyf0QZuKqPQJKumdcASJMm3FOlB3dfzbHHbPqzV1OgnSDCgY1zdgvpbMMmWQEbmcsh
 vUsJ4K1sKGzGFaj5qUB7ktz62on5VYoq7b1Bgvw7bsp/9IE7KTcRj9kWTx5HJRzkDjiL
 dp0bBlaKmU6yJ4HjxkBxqBKLXhgI9TMhraRPKlT1Ki1ASOyk3bXwbu99Trzq7ToAiMHV
 j4cQ==
X-Gm-Message-State: AOJu0YzfM5EgukJV4oxRPMM/V2fBkkoSkjWyPMcBzNPB2OxURDtYEKmJ
 bPhB6iUoqsCI/uJrciXgq9GeUYiL6Dq0MMReEaHtp4qbQVjjh+ECjYGVxeJw9L2e3TNvM4jtiTN
 a93mN7peTuVPKJl7NAykYNeFU7PCZZuYp06o5dr42KrELE0yyVUiPGV/Fh1TJsYBvfusgbMIewl
 jmWa0cmACAdbyko3ge2l0gt2vLOiWRhIYQdUHszQ==
X-Gm-Gg: ATEYQzyDtpBy2t9SLQaWuhR4/tUvqin+7F5SSXF07RCn4mqtSZvyeygzmnN7ZzF7JCK
 mNp0tKT1j/a7HvcwwqeuwiWtHbXfm8DTv9ffqwJjp1U/ZEs5SBTo9ARbpQui8vl72sCniRZxyim
 t339/Zn99j4sg8UT2oLJNI6o20/GKMEcHJpBeitRzQylSw2GTws9ByfE8jJnqBRJ3sm6tSbHPZ5
 1BXf2C37cb5MrSFXGAN1Dho1PtBR76XUO/V6K7bSgfjBsXNIbWJmsV4LOywX5Rv2xPSd6GHtqHw
 HyJi1t7Dp+cd+hR6BuiO6ubeYkjQn+BO3AJMBx85KgnkF3FqM8tXZaRzXzMx8PugU3fymarzNTt
 gRU2RGfEY1uefkZ5qb5/ZVan0E8htlODcg83y6IE8XIA=
X-Received: by 2002:a05:620a:7001:b0:8cd:9599:b7c7 with SMTP id
 af79cd13be357-8d2aba26606mr169963785a.23.1775075331636; 
 Wed, 01 Apr 2026 13:28:51 -0700 (PDT)
X-Received: by 2002:a05:620a:7001:b0:8cd:9599:b7c7 with SMTP id
 af79cd13be357-8d2aba26606mr169956985a.23.1775075330673; 
 Wed, 01 Apr 2026 13:28:50 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a548a4efsm68194085a.8.2026.04.01.13.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:28:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/11] vmstate: Do not set size for VMS_ARRAY_OF_POINTER
Date: Wed,  1 Apr 2026 16:28:36 -0400
Message-ID: <20260401202844.673494-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401202844.673494-1-peterx@redhat.com>
References: <20260401202844.673494-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h | 20 ++++++++++++++++----
 migration/savevm.c          |  3 +++
 migration/vmstate.c         | 10 +++++++++-
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 32bb8e8ebc..350e62a55a 100644
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
     .offset     = vmstate_offset_array(_state, _field, _type *, _num), \
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


