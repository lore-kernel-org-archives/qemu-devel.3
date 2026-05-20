Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445C6CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoZG-00026q-87; Wed, 20 May 2026 17:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZD-00025A-Se
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZB-0007ND-Tp
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vml5oXTZ9MrvSa1XsBg97dBeXhlvCAKh8L30LlX7siE=;
 b=GYW6oWfHHNtGnFvqhh6G6NvV+1Q1vSWZJR8cZSkjNxZFWpx7mRrzDa5SvxprnfBQkbErnC
 bwt2mN04fUu8DJI+rV9x9aq9Gp65tE9Sh7wDlqQqg9G7B+GifQiBZzhUKxp+P/WEJNKvyr
 8/ACy9LMCYqmch2h+sHg0qBHhXA/GRM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-rhWMDk74PMebnlhkm2-KGw-1; Wed, 20 May 2026 17:34:59 -0400
X-MC-Unique: rhWMDk74PMebnlhkm2-KGw-1
X-Mimecast-MFC-AGG-ID: rhWMDk74PMebnlhkm2-KGw_1779312899
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5162ee45a77so140809141cf.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312899; x=1779917699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vml5oXTZ9MrvSa1XsBg97dBeXhlvCAKh8L30LlX7siE=;
 b=lTffJxlYyPoLj57fHVh82di+Duh3OW/1J5L5PvjeGgGa7j++yrFvRDWwVPZbfqXj/k
 /ZGlSpuJHMpmGNXzENH8nnxOha2cKgV/KozrSB3cImQJHgaxTzfL6MD92AsHT90PqNxG
 2B2nZG9s8wTdDHg4Ubd7c2rtBKrBmcTQQ0W4vTjWgbc6soaGAuoCziLZEQRDWXRkupeQ
 4kLpvI4BTU4jMmjGvngpVkom4KqvzlpGMzeL2dfo4muXTodz1BkfmI42j3vB0KmJkKfF
 sDM66nu0nRfqspQaiuzcu6RBT/c9fTvu88x0hxR848F2yZiUJ6/dM/X+eHHSxacFcOTd
 Pxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312899; x=1779917699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vml5oXTZ9MrvSa1XsBg97dBeXhlvCAKh8L30LlX7siE=;
 b=hSiefdpoEq2rXgH4AkptQfg6xctZ1AWHJqFa76iW2qg0vNIqaGHJzizvAPw4ST8gWH
 2bmSoJVw4JZsQcqmaDeEOd8M717xqoNSUcFhPB9yXWB3upPeY66YD03CCAFLrymL8GCe
 6zjgi/X6snE/J/51hAo/48HCw4R2XiTeVB7op3x5OxYSjJ9obharBrBBhwPc2W+/NfNx
 ObDx9GP0lFIVomizc8SrdGNLLoUbmIgOskNUmVIgAhpkug+PMGgQc2rIsjgmO5LrhNeR
 JORNQzqR7zyTFUb7w6mZRT6O57O6mWZ+aM96ZM/sVLoUgssgjeRPrCgJuhO9HlwT+clz
 j3Cw==
X-Gm-Message-State: AOJu0Yx4WLO4jS0IisZPKGbNjaf6I+eV0s4NiCwuvhoVzHC59o2nN4tV
 GPThsyrMw8kVdcGUUKY71YToFEnjZ8g/pKo84HgFy87petdoo+sRg8iBHvyum/yLyq7MjiS5aNu
 rAwuLRuoQpttRc4kbMIDKJBxrrHqms6S8/S0UtoHRIIZz5rjISSmhgzmlcs5ZjA5AjkDG7LCyJN
 aXA09ikloVO7kFXWJAXaH+mZ/C+fCNrefTfJX46w==
X-Gm-Gg: Acq92OGTP/OZy3iaL5W0i3hRQDPH99XGQD36C6BtLZn5wq1WknZKYMuxESDiGDuFkh4
 6niQ/BA57bqlY/kIUjc/Vd309usctuzxqbeq98jRZHxQUXCbqIegrxghx3hiChhjWp0UEp7kEzz
 mqwJgkbiqTLPg5Oanx7L+v2KPyFXmwWId17vsd8a9OpLDkEJoWNdXXLPbjR7cDTiMm3PYghlmpq
 rkwZ99pIpdLXYL8quFvDNArdHUi0rai+CV8h3elRCIvPNcFVsnwbuYY6TAbeYJK6fIDdgIeK5kD
 qu2Dp7bv5/kNLGc/LZ60YFx6QTdNQU6D8IqBA1gf/lABn5ZLmox69+ds0uPUSeFAKIFAxDsOjfi
 2lGpVuv4KxhFJvB6CNai5GAvX47KuM0P+W2Vp0wFCYkej
X-Received: by 2002:a05:622a:5cc:b0:50b:4b2f:1606 with SMTP id
 d75a77b69052e-516c54339efmr4169451cf.15.1779312898656; 
 Wed, 20 May 2026 14:34:58 -0700 (PDT)
X-Received: by 2002:a05:622a:5cc:b0:50b:4b2f:1606 with SMTP id
 d75a77b69052e-516c54339efmr4168821cf.15.1779312897926; 
 Wed, 20 May 2026 14:34:57 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Bin Guo <guobin@linux.alibaba.com>
Subject: [PULL 23/29] migration/vmstate: avoid per-element heap churn in vmsd
 ptr marker field
Date: Wed, 20 May 2026 17:33:51 -0400
Message-ID: <20260520213357.40646-24-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Bin Guo <guobin@linux.alibaba.com>

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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260518110112.21395-4-guobin@linux.alibaba.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 6fa7523f04..50ebe37845 100644
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
@@ -676,6 +670,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
                 const VMStateField *inner_field;
+                VMStateField marker_field;
                 /* maximum number of elements to compress in the JSON blob */
                 int max_elems = vmsd_can_compress(field) ? (n_elems - i) : 1;
                 bool use_marker_field, is_null = false;
@@ -689,7 +684,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 use_marker_field = use_dynamic_array || is_null;
 
                 if (use_marker_field) {
-                    inner_field = vmsd_create_ptr_marker_field(field);
+                    vmsd_init_ptr_marker_field(&marker_field, field);
+                    inner_field = &marker_field;
                 } else {
                     inner_field = field;
                 }
@@ -726,11 +722,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
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
2.53.0


