Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13E2C87FDA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMW5-0007Ae-8e; Tue, 05 Aug 2025 14:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMUo-0002SN-Ag
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMS0-0004iF-27
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlIs+5oJLd8M5Nb7gR+6rl1imycCIonfLjvBTmqx+ps=;
 b=B4dvIu3kwt7CMw4SPhxkOwCbZXElx8vLaV0fVZq3H8Cf2z9Q0KBHIR24QQU23eQfN6C1Uu
 Q1mStlxTYopgmXq6gAK5nao8Mql2E2uB2mehHhRnvh3JZrqu1gQb4Ky5Y+k2YDGKt8hK3p
 b3s897e1d2LXxjwH4GYfK69XWfIxpx0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-WQ1rJ-0hOqyd2W145JFoLQ-1; Tue, 05 Aug 2025 14:31:48 -0400
X-MC-Unique: WQ1rJ-0hOqyd2W145JFoLQ-1
X-Mimecast-MFC-AGG-ID: WQ1rJ-0hOqyd2W145JFoLQ_1754418707
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b425a67c64bso85005a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418707; x=1755023507;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlIs+5oJLd8M5Nb7gR+6rl1imycCIonfLjvBTmqx+ps=;
 b=qEmITnKAsujkRbtFAto/I2h7k/+3ytMvPA8sczOLzyvlj65OwtkUZP+PCWsvPyuH4o
 WhkLHZsT5J1fuLbADAIsvkNP/3Panpyg2Ya6abaasva7CAow3h9dM+Js0opS3uLjeTnj
 Cs+S0zO7ByHQMe3wffnKpiZokvXh5sr6ced7zDmXW9EFnMvUidRfQGVCn5O+sGcozSjZ
 6U1xU2Kndz0REd3isJUGY5FIQ1AHWbgSxuiOVqCPOekAKlF3xJJAVSYpxzA5XUvM2i+I
 kUDC1hlgPJbxv3x2qutd/Q/EuPeJp8HeBqrnc75FWYRE4buef8toIRskwi12G0tadvbo
 IyBA==
X-Gm-Message-State: AOJu0Yz/9yEyrRGWgJljkZ3iT1rBXFqeDHLHPX1MGsfUlL3TdlGRELSx
 XLpaq6biyfPkqf6x/ozWT5AgP+Iru/tzSG/Xj4MWuEYqnYQXbAOsax/f8NxMYfzA/7ji4O//Ka9
 cFE1nASA5YcWn65pd1c1yQb1Uv17x6WQ/+qLE/bSPgDWgPwmHM+k3rc4V
X-Gm-Gg: ASbGnctXnpCIeeQQmxXJm1+xeJjkfz/lXwrbWnh+B9OdRZ8Um5zmAbvJRBPM7Io5r1U
 RdGHFRrSapm8aA4POczqKZFRdUccucn+OzijYQ853uvy02MdYa9DVfxR1pqbYTjoao/Zgl8vj+n
 OFETKgrABLGXPdV3t7yBCJlXcatyEFy+eZFI5ZciD+D0/j0EKs5L9QrwFieNn7qqyeL3BcD6eRg
 vab0yofbmR/zmj7TVzXK7iARvAc0o/bYf80ZIbX0L8JMd6djwOYA1vkBj/3sM+ZGgXbc5conTmk
 NnvpCfyto8T1kvyWOTVyA0PbgcdAFiELuR6iRLdPe+7Lc9z0QA==
X-Received: by 2002:a17:903:2451:b0:240:ac96:e054 with SMTP id
 d9443c01a7336-24288d93ae0mr63928985ad.23.1754418707024; 
 Tue, 05 Aug 2025 11:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+EvusuAD7Nz1pX9yL7gT1GAIxsawLlXQuSwuAygxjQw72BsDD3sp4xUI9FrzUEblX5w0w+A==
X-Received: by 2002:a17:903:2451:b0:240:ac96:e054 with SMTP id
 d9443c01a7336-24288d93ae0mr63928535ad.23.1754418706543; 
 Tue, 05 Aug 2025 11:31:46 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:31:46 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:33 +0530
Subject: [PATCH v9 26/27] migration: Add error-parameterized function
 variants in VMSD struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-propagate_tpm_error-v9-26-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7155; i=armenon@redhat.com;
 h=from:subject:message-id; bh=E+HpMgoCIwt9wAj1MGaL/SXGMQu3dPj/x5uh9PXiny0=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX9m43OelYgLfuPmS9568qrRzyZSDYuuTWd03TWFcr
 zPX/LN5RykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIk8nsvIMGX2pegFgZxXDs86
 /4p381TJ2SlMArYn7dui/k1ymPR65kFGht8x1iYTaqbtPbpVhmNBd0ldwYUbmu3yi240rvYR7PZ
 yZwIA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 docs/devel/migration/main.rst | 24 ++++++++++++++++++++++++
 include/migration/vmstate.h   | 15 +++++++++++++++
 migration/vmstate.c           | 34 ++++++++++++++++++++++++++++++----
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 6493c1d2bca48a2fa34d92f6c0979c215c56b8d5..35bf5ae26c87f3c82964eb15618be373ab5a41fc 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -444,6 +444,30 @@ The functions to do that are inside a vmstate definition, and are called:
   This function is called after we save the state of one device
   (even upon failure, unless the call to pre_save returned an error).
 
+Following are the errp variants of these functions.
+
+- ``int (*pre_load_errp)(void *opaque, Error **errp);``
+
+  This function is called before we load the state of one device.
+
+- ``int (*post_load_errp)(void *opaque, int version_id, Error **errp);``
+
+  This function is called after we load the state of one device.
+
+- ``int (*pre_save_errp)(void *opaque, Error **errp);``
+
+  This function is called before we save the state of one device.
+
+- ``int (*post_save_errp)(void *opaque, Error **errp);``
+
+  This function is called after we save the state of one device
+  (even upon failure, unless the call to pre_save returned an error).
+
+New impls should preferentally use 'errp' variants of these
+methods and existing impls incrementally converted.
+The variants without 'errp' are intended to be removed
+once all usage is converted.
+
 Example: You can look at hpet.c, that uses the first three functions
 to massage the state that is transferred.
 
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 5fe9bbf39058d0cf97c1adab54cc516dbe8dc32a..51baf6c7f9d061ee33949d7e798f2184e50b4cbf 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -200,15 +200,30 @@ struct VMStateDescription {
      * exclusive. For this reason, also early_setup VMSDs are migrated in a
      * QEMU_VM_SECTION_FULL section, while save_setup() data is migrated in
      * a QEMU_VM_SECTION_START section.
+     *
+     * There are duplicate impls of the post/pre save/load hooks.
+     * New impls should preferentally use 'errp' variants of these
+     * methods and existing impls incrementally converted.
+     * The variants without 'errp' are intended to be removed
+     * once all usage is converted.
+     *
+     * For the errp variants,
+     * Returns: 0 on success,
+     *          <0 on error where -value is an error number from errno.h
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
index 569e66ea983f833e6a0d651d2a751f34a64e8f5c..0acaa855cfec8ddac63e33d4562e39c345856213 100644
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
+                          "version_id: %d, minimum version_id: %d, "
+                          "ret: %d: ", vmsd->name, vmsd->version_id,
+                          vmsd->minimum_version_id, ret);
+            return ret;
+        }
+    } else if (vmsd->pre_load) {
         ret = vmsd->pre_load(opaque);
         if (ret) {
             error_setg(errp, "VM pre load failed for: '%s', "
@@ -242,7 +251,14 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         qemu_file_set_error(f, ret);
         return ret;
     }
-    if (vmsd->post_load) {
+    if (vmsd->post_load_errp) {
+        ret = vmsd->post_load_errp(opaque, version_id, errp);
+        if (ret < 0) {
+            error_prepend(errp, "VM Post load failed for: %s, version_id: %d, "
+                          "minimum_version: %d, ret: %d: ", vmsd->name,
+                          vmsd->version_id, vmsd->minimum_version_id, ret);
+        }
+    } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
         if (ret < 0) {
             error_setg(errp,
@@ -411,8 +427,16 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
 static int pre_save_dispatch(const VMStateDescription *vmsd, void *opaque,
                              Error **errp)
 {
+    ERRP_GUARD();
     int ret = 0;
-    if (vmsd->pre_save) {
+    if (vmsd->pre_save_errp) {
+        ret = vmsd->pre_save_errp(opaque, errp);
+        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
+        if (ret) {
+            error_prepend(errp, "pre-save for %s failed, ret: %d: ",
+                          vmsd->name, ret);
+        }
+    } else if (vmsd->pre_save) {
         ret = vmsd->pre_save(opaque);
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {
@@ -427,7 +451,9 @@ static int post_save_dispatch(const VMStateDescription *vmsd, void *opaque,
                               Error **errp)
 {
     int ret = 0;
-    if (vmsd->post_save) {
+    if (vmsd->post_save_errp) {
+        ret = vmsd->post_save_errp(opaque, errp);
+    } else if (vmsd->post_save) {
         ret = vmsd->post_save(opaque);
         error_setg(errp, "post-save for %s failed, ret: %d",
                    vmsd->name, ret);

-- 
2.50.1


