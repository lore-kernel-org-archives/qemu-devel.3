Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105B4CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOvj0-0006ah-L1; Mon, 18 May 2026 07:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOviw-0006YN-PL
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:01:26 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOvit-0005hy-6x
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1779102076; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=oli3TV2O+h3vqz3L6ihhLNIlHjx7t0sun6devc9rBO4=;
 b=SlROCCkpTXB3cWLe+QK3+vix5MHdCuPJn4bs9kztoLoxPkQOFnEQDdVz4craM+66mxKiT97pHxJPooORf4FWJAOhjnZ2oc0rECCs6k/4Zab5v31XNS9KYHtpF5S424SPD/6a1vgjTOXI22A5RUGbTdbphfviS8WeQtPotyMr3p8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X38-onF_1779102075; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X38-onF_1779102075 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 18 May 2026 19:01:15 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 3/8] migration/vmstate: avoid per-element heap churn in vmsd
 ptr marker field
Date: Mon, 18 May 2026 19:01:07 +0800
Message-ID: <20260518110112.21395-4-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260518110112.21395-1-guobin@linux.alibaba.com>
References: <20260518110112.21395-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

For every NULL slot in a VMS_ARRAY_OF_POINTER (or every entry of a
dynamic array), the saver allocates a 1-element fake VMStateField via
g_new0 and frees it again right after the save. For arrays of
thousands of entries this is thousands of malloc/free pairs on the
hot save path.

Replace the heap-allocated marker with a stack-resident field
populated by an init helper. The caller passes a pointer to a local
VMStateField, the helper fills it in (still asserting the
precondition), and no g_free is needed.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/vmstate.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 2f13b48a37..9ced78532f 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -59,29 +59,23 @@ vmstate_field_exists(const VMStateDescription *vmsd, const VMStateField *field,
  * array of a VMS_ARRAY_OF_POINTER VMSD field.  It's needed because we
  * can't dereference the NULL pointer.
  */
-static const VMStateField *
-vmsd_create_ptr_marker_field(const VMStateField *field)
+static void
+vmsd_init_ptr_marker_field(VMStateField *fake, const VMStateField *field)
 {
-    VMStateField *fake = g_new0(VMStateField, 1);
-
     /* It can only happen on an array of pointers! */
     assert(field->flags & VMS_ARRAY_OF_POINTER);
 
-    /* Some of fake's properties should match the original's */
-    fake->name = field->name;
-    fake->version_id = field->version_id;
-
-    /* Do not need "field_exists" check as it always exists */
-    fake->field_exists = NULL;
-
-    /* See vmstate_info_ptr_marker - use 1 byte to represent ptr status */
-    fake->size = 1;
-    fake->info = &vmstate_info_ptr_marker;
-    fake->flags = VMS_SINGLE;
-
-    /* All the rest fields shouldn't matter.. */
-
-    return (const VMStateField *)fake;
+    /* See vmstate_info_ptr_marker - 1 byte represents ptr status */
+    *fake = (VMStateField) {
+        .name = field->name,
+        .version_id = field->version_id,
+        /* Marker always exists, no field_exists callback needed */
+        .field_exists = NULL,
+        .size = 1,
+        .info = &vmstate_info_ptr_marker,
+        .flags = VMS_SINGLE,
+        /* All other fields stay zero-initialised */
+    };
 }
 
 static int vmstate_n_elems(void *opaque, const VMStateField *field)
@@ -680,6 +674,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
                 const VMStateField *inner_field;
+                VMStateField marker_field;
                 /* maximum number of elements to compress in the JSON blob */
                 int max_elems = vmsd_can_compress(field) ? (n_elems - i) : 1;
                 bool use_marker_field, is_null = false;
@@ -693,7 +688,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 use_marker_field = use_dynamic_array || is_null;
 
                 if (use_marker_field) {
-                    inner_field = vmsd_create_ptr_marker_field(field);
+                    vmsd_init_ptr_marker_field(&marker_field, field);
+                    inner_field = &marker_field;
                 } else {
                     inner_field = field;
                 }
@@ -730,11 +726,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                                                     inner_field, vmdesc_loop,
                                                     i, max_elems, errp);
 
-                /* If we used a fake temp field.. free it now */
-                if (use_marker_field) {
-                    g_clear_pointer((gpointer *)&inner_field, g_free);
-                }
-
                 if (!ok) {
                     goto out;
                 }
-- 
2.50.1 (Apple Git-155)


