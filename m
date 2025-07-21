Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D05C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udook-0005dm-PZ; Mon, 21 Jul 2025 07:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udolK-0004AT-Pi
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udolG-0001Ed-H7
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9AF+7c8u5HxJ0eCpL/YXqsKTRoDXAggxdzD85+tAHME=;
 b=Axp4FZtilsyS0tbTMXfjJv062VkIb6g9nbi7LOZVEIJ07HsUvwjJ1GdpPm9qkgFSFn0kP7
 4+H0SnK1KsqGUzWGYstTpTzugWxuuo6/DSbAZm4SnVQpAoHuywxC1wTul0ZMDQo3O7g9U2
 5Oq/73jMF2jbCxFz/uEBt8RSPoUKfuQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-pU9wqqGAPGadTM9maJrSZw-1; Mon, 21 Jul 2025 07:32:48 -0400
X-MC-Unique: pU9wqqGAPGadTM9maJrSZw-1
X-Mimecast-MFC-AGG-ID: pU9wqqGAPGadTM9maJrSZw_1753097567
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-235089528a0so43192315ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097567; x=1753702367;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9AF+7c8u5HxJ0eCpL/YXqsKTRoDXAggxdzD85+tAHME=;
 b=kir+KleJ/ML5X5zsd992FAYBPO8RlLmG049zK4ncX9kRV7adRoqpQxQ4ESbt/ZSS71
 nPTZNj6qEr3WQuyf7CHBXVvhA5XK7J0+KDwPVYuBzCI/Br1eN6kn9Z1CKXOCP4jcTq89
 8VnbxWiDqtfZe8w32Pgzi6vxZs6aTOIUJg3GaAJOayn3cGC14tOhpDwiV6OSGcDiS26H
 BMOX6MrO8r2NlxaTi9m7A9IRLKwWUdKdI0nC9aHJ2Lp4R8sz9s4yDxkAR9mCiTlWuN5h
 0c8YRZAsV+Ynj8WX4JGxK/FfC9Z8NMjrW/FjvbXOkbs/YIiOFAhXfsWoTNfMiLw8+9ed
 gWgQ==
X-Gm-Message-State: AOJu0YwKnFUO/+Mq4u97kw03U4HC+ZTGTxZiKVlV3Uk0+YTGDFVUpFNC
 xPvxLnlB9V+e327YUH1by8EpvrqXpqYeK+v8WiJS/REr0rDwfYyMpFwIw9kNYJA6nmn0xz56Kt0
 xaoFeWRDDZTkPgfI/jSzFuHdocQyQ1fFdwm7u1fpOPqeG7py/zYhM80Od
X-Gm-Gg: ASbGnctU8SdiILnja7ZgVoitBRgoku+Hxw2MxED99h0aWF2NOJCZUVlNxq80/dVVYaX
 tUbBb4gk+V5Q5HN+Hb32A+skhXfe+Gn/c6tekIKE9VIoSCtQdmd/QScLVu98UJKOadDFIMopEag
 YzNs/v0YrWUXSuCANE+tWSrW6WXre/kUbNepfT5FBoQ+Q1ODUwQ2+x01w2C5mYEs5AmhGAyBFRF
 DWOcU1nqe6KLCbb4e9X/4dC4gIKvwEvbx+bkmbc/iGHZ4/wDnoVobJqlBCwtDlHE/xnjCfoYjg5
 fjVM74VAsp8aZ7AHSZxIo6znZuQi8N1lsdOmNRc+qsqkROHTC751
X-Received: by 2002:a17:902:c94b:b0:235:278c:7d06 with SMTP id
 d9443c01a7336-23e2f6d2420mr256341535ad.8.1753097566923; 
 Mon, 21 Jul 2025 04:32:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdiPexjo8snhE5rX8cCdYEJMvmbD0WiiyBF6hWhLb265i3yIAKjCfEsAJyghAZC6LR1ZV+zg==
X-Received: by 2002:a17:902:c94b:b0:235:278c:7d06 with SMTP id
 d9443c01a7336-23e2f6d2420mr256340845ad.8.1753097566430; 
 Mon, 21 Jul 2025 04:32:46 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:32:46 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:28 +0530
Subject: [PATCH v6 23/24] migration: Add error-parameterized function
 variants in VMSD struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-23-fef740e15e17@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
In-Reply-To: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6628; i=armenon@redhat.com;
 h=from:subject:message-id; bh=4u2wEPaJWzkOD0krWjkaQt4Hj33n6lpbrXVanB9lnio=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adyuQrvPPOz+Ro5XJsePsg8fSS9SeP3VA+8o+/ZoJ/v
 W9Tbvz1jlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABNZeomR4cGKG9w+jdcvTjJ9
 /k8j5pXeFLsF/e8Xa3xbuO67fbfq53MMfyW27F2Rl87xq1bbt9JyirTiYSXfO58Sr+S1ShhI9n7
 L5gMA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- We need to have good error reporting in the callbacks in
  VMStateDescription struct. Specifically pre_save, post_save,
  pre_load and post_load callbacks.
- It is not possible to change these functions everywhere in one
  patch, therefore, we introduce a duplicate set of callbacks
  with Error object passed to them.
- So, in this commit, we implement 'errp' variants of these callbacks,
  introducing an explicit Error object parameter.
- This is a functional step towards transitioning the entire codebase
  to the new error-parameterized functions.
- Deliberately called in mutual exclusion from their counterparts,
  to prevent conflicts during the transition.
- New impls should preferentally use 'errp' variants of
  these methods, and existing impls incrementally converted.
  The variants without 'errp' are intended to be removed
  once all usage is converted.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 include/migration/vmstate.h | 11 +++++++++++
 migration/vmstate.c         | 47 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 056781b1c21e737583f081594d9f88b32adfd674..53fa72c1bbde399be02c88fc8745fdbb79bfd7c8 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -200,15 +200,26 @@ struct VMStateDescription {
      * exclusive. For this reason, also early_setup VMSDs are migrated in a
      * QEMU_VM_SECTION_FULL section, while save_setup() data is migrated in
      * a QEMU_VM_SECTION_START section.
+     *
+     * There are duplicate impls of the post/pre save/load hooks.
+     * New impls should preferentally use 'errp' variants of these
+     * methods and existing impls incrementally converted.
+     * The variants without 'errp' are intended to be removed
+     * once all usage is converted.
      */
+
     bool early_setup;
     int version_id;
     int minimum_version_id;
     MigrationPriority priority;
     int (*pre_load)(void *opaque);
+    int (*pre_load_errp)(void *opaque, Error **errp);
     int (*post_load)(void *opaque, int version_id);
+    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
     int (*pre_save)(void *opaque);
+    int (*pre_save_errp)(void *opaque, Error **errp);
     int (*post_save)(void *opaque);
+    int (*post_save_errp)(void *opaque, Error **errp);
     bool (*needed)(void *opaque);
     bool (*dev_unplug_pending)(void *opaque);
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 288b57e1ed778cce21247b64d5e97dfef41ad586..d96908d12ccffaef421e5d399a48e26cada2cb77 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -152,7 +152,16 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
         return -EINVAL;
     }
-    if (vmsd->pre_load) {
+    if (vmsd->pre_load_errp) {
+        ret = vmsd->pre_load_errp(opaque, errp);
+        if (ret) {
+            error_prepend(errp, "VM pre load failed for: '%s', "
+                          "version_id: '%d', minimum version_id: '%d', "
+                          "ret: %d ", vmsd->name, vmsd->version_id,
+                          vmsd->minimum_version_id, ret);
+            return ret;
+        }
+    } else if (vmsd->pre_load) {
         ret = vmsd->pre_load(opaque);
         if (ret) {
             error_setg(errp, "VM pre load failed for: '%s', "
@@ -236,10 +245,17 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         qemu_file_set_error(f, ret);
         return ret;
     }
-    if (vmsd->post_load) {
+    if (vmsd->post_load_errp) {
+        ret = vmsd->post_load_errp(opaque, version_id, errp);
+        if (ret < 0) {
+            error_prepend(errp, "VM Post load failed for: %s, version_id: %d, "
+                          "minimum_version: %d, ret: %d ", vmsd->name,
+                          vmsd->version_id, vmsd->minimum_version_id, ret);
+        }
+    } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
         if (ret < 0) {
-            error_setg(errp, "VM Post load failed for: %s, version_id: %d,"
+            error_setg(errp, "VM Post load failed for: %s, version_id: %d, "
                        "minimum_version: %d, ret: %d", vmsd->name,
                        vmsd->version_id, vmsd->minimum_version_id, ret);
         }
@@ -410,11 +426,19 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                          void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
 {
     int ret = 0;
+    Error *local_err = NULL;
     const VMStateField *field = vmsd->fields;
 
     trace_vmstate_save_state_top(vmsd->name);
 
-    if (vmsd->pre_save) {
+    if (vmsd->pre_save_errp) {
+        ret = vmsd->pre_save_errp(opaque, errp);
+        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
+        if (ret) {
+            error_prepend(errp, "pre-save failed: %s ", vmsd->name);
+            return ret;
+        }
+    } else if (vmsd->pre_save) {
         ret = vmsd->pre_save(opaque);
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {
@@ -524,7 +548,12 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 if (ret) {
                     error_setg(errp, "Save of field %s/%s failed",
                                 vmsd->name, field->name);
-                    if (vmsd->post_save) {
+                    if (vmsd->post_save_errp) {
+                        ret = vmsd->post_save_errp(opaque, &local_err);
+                        if (ret < 0) {
+                            error_propagate(errp, local_err);
+                        }
+                    } else if (vmsd->post_save) {
                         vmsd->post_save(opaque);
                     }
                     return ret;
@@ -552,7 +581,13 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
     ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
 
-    if (vmsd->post_save) {
+    if (vmsd->post_save_errp) {
+        int ps_ret = vmsd->post_save_errp(opaque, &local_err);
+        if (!ret && ps_ret) {
+            ret = ps_ret;
+            error_propagate(errp, local_err);
+        }
+    } else if (vmsd->post_save) {
         int ps_ret = vmsd->post_save(opaque);
         if (!ret && ps_ret) {
             ret = ps_ret;

-- 
2.50.0


