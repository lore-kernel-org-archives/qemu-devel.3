Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAB8CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rtj-0008Kg-2q; Tue, 30 Sep 2025 00:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rt7-0006nx-Eo
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rt0-0003Rk-1h
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759206162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHQ9Hf2H7B9XLwvZ0OhggKTyfRMVlgZRVuwXGSGs4Jg=;
 b=bF+qbziTLQg6wZk33bx8X8YJay36tkIkKxVoDnrHfXp1EJUan0No8qZrWCZwWV69zmPJ5g
 4hbYx1hGXvw5ELUDc/o4rZcXMRoe5ttKbFQwA4jZRVAWYT795JKkAgQ22OvsfPuX6lzY8X
 BFf5kv6KYrjrRbATDZlXcfHA9dtAJkc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-fZVMlOu8PROD1XPygAuRYw-1; Tue, 30 Sep 2025 00:22:40 -0400
X-MC-Unique: fZVMlOu8PROD1XPygAuRYw-1
X-Mimecast-MFC-AGG-ID: fZVMlOu8PROD1XPygAuRYw_1759206159
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7810912fc31so4704596b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759206159; x=1759810959;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHQ9Hf2H7B9XLwvZ0OhggKTyfRMVlgZRVuwXGSGs4Jg=;
 b=o0e3J4IEjJxriiJ7rP3VYU2xdagSNpRyR2WvI5aBGCxq/Xnf6c+Yi3jpFc74xYfrsR
 W4Y+sdTjF8vesWEvFkAwrGpKxdBBWqET1mAku13zJMh2bGOO9sUAXlA0G966hTdZeFJd
 nbKkrYqpCGteF2nwV1f8JYAuNxxBWenlGp+roMYwm73DEMr+R9bHrr8h6KYrcBnGJsFn
 uNqZHbTotN4uDl6nMfLR4SP0+RiiZ70Hukn0rHiuiTLdkEhV9WgCXVqJqx6rsDRmeY3d
 JiLjLMI/EuZIKQEV3h9ZF1n5QbQohZwN/247ffTqDgpVReI3Fj3Qx1O+gLSTu5jeFu2f
 4Ang==
X-Gm-Message-State: AOJu0YzTAGXup4S+mMy5lujm0SqP/sfwnW6hxU6eUHnfiM68Qxbva1wF
 SEBoriDJ19jQ1N3QIXQ3j7FstuFp6eWCQj6zPx8BsTK4uBX3ztFEjmN0KlAbZZ5F109lwgKcyKf
 mmI+r/zXRYVhcA2Nbgm+930LFnCBEBBuevYBz+RZQW7GnU960YzrGp0kH
X-Gm-Gg: ASbGncvNXHbBcZeuUKmPi4JnoyFvNQbUAZdbr9YIWjl8X8o6YR4lQQDISbligxRf2H9
 8ehm2ZsjaNaLxnIFyt7dyIMPrJ0TpZftQBUtCAZfuzxk+s4TEE/NK5yM95noPd4a2tulviUxqYM
 /nBmtF+YP/i3ZD3Qh+exB3WJa0OS3clVAMWBccqdp3hh774N2z6oKm6EOWNvRQ1rAzKzKfe0nst
 +4lSvsReX11YBaOGRd9OT9bvPjZAeoIM6TMRWe2RH7sTD6qXMMJHcyFImNuzIp+DYYfMstDGB/v
 G8eN39V0fT+2p27ejExASkZYZncqaW/xQufcnujCuiPg7Q/OHat2+jCGKg==
X-Received: by 2002:a05:6a20:7fa9:b0:243:d1bd:fbc9 with SMTP id
 adf61e73a8af0-2e7da8335a2mr23445704637.56.1759206158866; 
 Mon, 29 Sep 2025 21:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5WAfluMkxP/CFwQolWNdfJpp7cvQNP8Nb8/qGW7mUv07lrWn6ib6r8evej54EuQa4/UJDVA==
X-Received: by 2002:a05:6a20:7fa9:b0:243:d1bd:fbc9 with SMTP id
 adf61e73a8af0-2e7da8335a2mr23445665637.56.1759206158287; 
 Mon, 29 Sep 2025 21:22:38 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:22:37 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:34 +0530
Subject: [PATCH v15 25/26] migration: Add error-parameterized function
 variants in VMSD struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-propagate_tpm_error-v15-25-84afd3af1e47@redhat.com>
References: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
In-Reply-To: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7044; i=armenon@redhat.com;
 h=from:subject:message-id; bh=2MxA/qLu8PcUJ62c/SUc697dwZyTWjTvVl1gxvQmbLI=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKKHTYStCN2lJ3f0j3HbgxbPIo0WrrNt9Atit+98E8
 Bfea1fpKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMJHZnxgZdiQXFBdvWKa66dgG
 6R4x/ovGB90F5xkcyHbK9cw2j78/j+F/zWK71ROd5mhKHvgsrX297OoSi/rZsza0LPfQ0z+/JLq
 WFQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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
  VMStateDescription struct. Specifically pre_save, pre_load
  and post_load callbacks.
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 docs/devel/migration/main.rst | 19 +++++++++++++++++++
 include/migration/vmstate.h   | 14 ++++++++++++++
 migration/vmstate.c           | 31 ++++++++++++++++++++++++++++---
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 6493c1d2bca48a2fa34d92f6c0979c215c56b8d5..1afe7b9689bdf61b4da9df4223dd5143ece53523 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -444,6 +444,25 @@ The functions to do that are inside a vmstate definition, and are called:
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
+New impls should preferentally use 'errp' variants of these
+methods and existing impls incrementally converted.
+The variants without 'errp' are intended to be removed
+once all usage is converted.
+
 Example: You can look at hpet.c, that uses the first three functions
 to massage the state that is transferred.
 
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 5fe9bbf39058d0cf97c1adab54cc516dbe8dc32a..5567fd78d0404f5fa8bfc1c9887d63de0cf3b22c 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -200,14 +200,28 @@ struct VMStateDescription {
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
     bool (*needed)(void *opaque);
     bool (*dev_unplug_pending)(void *opaque);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index ad8e5b71ae2ce78e66a6426602e5c20405ec57c0..81eadde553dd21a788cf1b06df9025a6097742d5 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -134,6 +134,7 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp)
 {
+    ERRP_GUARD();
     const VMStateField *field = vmsd->fields;
     int ret = 0;
 
@@ -152,7 +153,16 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
         return -EINVAL;
     }
-    if (vmsd->pre_load) {
+    if (vmsd->pre_load_errp) {
+        ret = vmsd->pre_load_errp(opaque, errp);
+        if (ret < 0) {
+            error_prepend(errp, "pre load hook failed for: '%s', "
+                          "version_id: %d, minimum version_id: %d, "
+                          "ret: %d: ", vmsd->name, vmsd->version_id,
+                          vmsd->minimum_version_id, ret);
+            return ret;
+        }
+    } else if (vmsd->pre_load) {
         ret = vmsd->pre_load(opaque);
         if (ret) {
             error_setg(errp, "pre load hook failed for: '%s', "
@@ -245,7 +255,14 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         qemu_file_set_error(f, ret);
         return ret;
     }
-    if (vmsd->post_load) {
+    if (vmsd->post_load_errp) {
+        ret = vmsd->post_load_errp(opaque, version_id, errp);
+        if (ret < 0) {
+            error_prepend(errp, "post load hook failed for: %s, version_id: "
+                          "%d, minimum_version: %d, ret: %d: ", vmsd->name,
+                          vmsd->version_id, vmsd->minimum_version_id, ret);
+        }
+    } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
         if (ret < 0) {
             error_setg(errp,
@@ -414,12 +431,20 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
 int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                          void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
 {
+    ERRP_GUARD();
     int ret = 0;
     const VMStateField *field = vmsd->fields;
 
     trace_vmstate_save_state_top(vmsd->name);
 
-    if (vmsd->pre_save) {
+    if (vmsd->pre_save_errp) {
+        ret = vmsd->pre_save_errp(opaque, errp);
+        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
+        if (ret < 0) {
+            error_prepend(errp, "pre-save for %s failed, ret: %d: ",
+                          vmsd->name, ret);
+        }
+    } else if (vmsd->pre_save) {
         ret = vmsd->pre_save(opaque);
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {

-- 
2.51.0


