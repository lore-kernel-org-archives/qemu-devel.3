Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1825810AB829
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 21:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5rtj-00047Y-RX; Thu, 26 Mar 2026 17:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rti-00047H-4K
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtg-00035s-H9
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774559143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ubb/xNXuD8MO8IRZHm3DHAIE1nzess2O6rBQSwmPzBQ=;
 b=CpBEGPcLh9mf58XEnnrxAK0itfroDBDXzQIW9w91dn4/pjfdu1jU/EJMGr7R8wUOl2Goss
 0XIXov9k/j+5++SlIeb8WjT0UUtkjMvaE5FywR6cuMVw8yZFVR+4tazHtg3K96PL5qhAmO
 AaCQxje7Sj74RfosMttA6VAAX+N3vTY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-jq_vj9EcP_K1SOr8RUe7aA-1; Thu, 26 Mar 2026 17:05:42 -0400
X-MC-Unique: jq_vj9EcP_K1SOr8RUe7aA-1
X-Mimecast-MFC-AGG-ID: jq_vj9EcP_K1SOr8RUe7aA_1774559141
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cfcf23c0e1so377141785a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774559141; x=1775163941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ubb/xNXuD8MO8IRZHm3DHAIE1nzess2O6rBQSwmPzBQ=;
 b=o/vx4a9z4M/cmeED2hz6EaX5+RrhGDmxFqRL5WpLeh7wLw6LYr5uwGc5m+nff524/r
 GVCehSGLMQhLrhokFwwbo/NEexwEqienkJGk0qQAAWBy1Zlool/xkngy+gEssACOpYqJ
 SbYtpSQGynZA8cYilY+nE0uUZKgxXKQN/uo89V6tXucd55eD6zorLSOO78C5uvlGJlAR
 OBBRe3nrRZh1CWqpApde45ivuqcuquf0VmKpihXHaA/lpd9kdbcOv43EU1Z+9WujDpC4
 ndtcxyfnq78Gr3ZyKdfb/DjyN78j1ZPVzDWT1K/0np+UQAd5Tt5hbzcaPIRUaB1QvBt2
 0wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774559141; x=1775163941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ubb/xNXuD8MO8IRZHm3DHAIE1nzess2O6rBQSwmPzBQ=;
 b=IbMPjMzJEiLrEuU7KBuIFBCmvLRnuAUSDZwmZ/BNEKvXv+NboXfYnYEvYNaBwK9aaL
 R/JGR9BWxFT0tCu9KTa1Y7H+lu6ZOQHd0kYbSl25V60DybZAnV9SYMBvsDPc1/bxyZFB
 4xzZVydzcJg1SHTrf18Pbbl4xAqVRKvbFffQhlz3YnOBAlz3gSsvVDEIT85DQInZ6vLA
 RXGYzHxoFh2awqhkABi19zEcHbwxoJHWDQ7h6mrFlc8muIUH07bxsNwPLbW8325M+b9U
 qTxr3juJSEDbC2Xe71uUkABbk4t1drASBygXoBRceXxuN7n6mLQseN03YlEQpZ9qBxBl
 y5jg==
X-Gm-Message-State: AOJu0YzehAa2U1cJ/uZlDLVZIYPlTxkEutk4B1jhcOEAeKK2S0PY3B79
 bCdG0o8H0nq6LzsyPGbGe3SmjMBZp3X6Xz90H8k3LMSSRQEyMtV1IygfDQwYpc+wV/tDqX4x4iJ
 HPjo8HZALHJ6MtXAIaGfMPjidP62SWlZO44LmGBbi/V0yE2O6wooi8zTVHI3rFl8vwwOX3V7ahC
 KIN2IaLjGhwrV6DBo9YcaTCoolHI/oAmuKfXqXog==
X-Gm-Gg: ATEYQzxYUh28Aqp+2zpbfzTN7FPhngWwK2GIyD/zS38essBn/TfOKofz0BWjW+7vqVx
 lieaW7UA+ucEtSWIQbNnujPsgLzA5J7VgBCPxsS25yJfoMZ8Uv+dZr4pSwCk3ZCGEEqSC/K/Pzf
 AJSCq45VGeQM0wOFiJG8YUXNJkIMH0yy20FT57m/gM94T4AO2p8zvT0ijFzhCJUK8f3L6qjkGWm
 mL9hJLjjlAGn4APS0PTzx/IugDjTsjYJnT4kHs056gi1j/eeXW0OoyRaUfvExls4oleJRArpfno
 GbQLzxSN46fjVV+MsMu26sr/LBDJVhFFH43rLvluBNPJX9sE6mWRnxw62HUNAQWeWcKQsBo6daP
 WZWNQDygBvRA=
X-Received: by 2002:a05:620a:7014:b0:8cd:982d:4122 with SMTP id
 af79cd13be357-8d0010074b7mr1097938085a.39.1774559140969; 
 Thu, 26 Mar 2026 14:05:40 -0700 (PDT)
X-Received: by 2002:a05:620a:7014:b0:8cd:982d:4122 with SMTP id
 af79cd13be357-8d0010074b7mr1097931585a.39.1774559140226; 
 Thu, 26 Mar 2026 14:05:40 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e4fa7d9sm353479785a.32.2026.03.26.14.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 14:05:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH RFC v2 03/11] vmstate: Do not set size for VMS_ARRAY_OF_POINTER
Date: Thu, 26 Mar 2026 17:05:24 -0400
Message-ID: <20260326210532.379027-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326210532.379027-1-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
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


