Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B30C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHVK-000791-Cr; Fri, 25 Jul 2025 08:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHRX-0002uo-Ds
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHRU-0000iO-Uu
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7J0TJo5TqElFUpVXoKroLa2yyNDufm2dJkisge/7g5A=;
 b=BrrVB8goChrsZywJzlW0NCWlrdFqCbjUX02dXbCWQjav0f0lWeSiVRpcaLymgwIlkJ7XnA
 4ZcBfkzCiI+8ZWlhra2B3TjZNm57be0FqI18WGNXHiTyj16IbSSTPQFOV9vEHcCrjhzBP/
 zoiiMDIpLVS+9+FPoh3QUDxvbl9LK7Y=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-GoOwQ0hcMG2ZK4YArjxZxA-1; Fri, 25 Jul 2025 08:22:26 -0400
X-MC-Unique: GoOwQ0hcMG2ZK4YArjxZxA-1
X-Mimecast-MFC-AGG-ID: GoOwQ0hcMG2ZK4YArjxZxA_1753446146
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3121cffd7e8so1877022a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446145; x=1754050945;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7J0TJo5TqElFUpVXoKroLa2yyNDufm2dJkisge/7g5A=;
 b=WXU9cHGsdtiShzPW0tZcvM8vzwcHhWCnjGbGDt5fFV2ZSuS4BvJ2iMz6M7xowA6z68
 heRXlnoH54ROqnvUlJl7dRuopWUFuL5x8ATwJKWrd8oXcSwuNnPZKRetzdnjsWsDA3RG
 u60WzLjYy/S3qFq64MsK3zaEIvUu8tsEnWnEBu9Lg8sPtrB0ILPdBwnLETUXTX4IRV+d
 ew7c9WoWrk+DXUhW1OGvEF8Hxf5H/JZmaId1n5ZcrH3BVPwfx5p0w+YzMQfnbbIYMvcH
 NPyynDyNgejJnwr0elBh3Xiy0MJp4x9/QWcShwYVsLAmNLAECjNrl7RmZbYYZ+ZpZ5ys
 Kizw==
X-Gm-Message-State: AOJu0Yw2gNcmNtwK8nsi92SeaIMuf2jERWBXeD04UClsTW1OdTvK9c7a
 XexBzUUFt+1pKNn7gdTI8HXnSHKugMluqdlZuJk/G4kfju8vrvcGy1/5IhwGoUuDBfpNxqAAQyl
 ZM2wb4j+fYU1S/pY0IIawf8thBe4+fj00djBca+UhK9QOqY0WMzoT5QOy
X-Gm-Gg: ASbGncvdgi4/GqQWjYbOFfOnVLTTq+d4OrIePkzObAdY4S9quCYlFM18Izym/+yFeIb
 m1uSr0EzZrxOFKmfvJkKSuv/yIQKIgKBDudxvd5nWbzBhQRjugMAkUo+dmZ9d4tckX8o81i45kd
 vaiM+l7YCu/inr216VGgdEDcj96O3aq3sAWkBnKY2kdtr2V/dPnefikx4TnrL6gxsVR7IhKNybK
 fkqmbGsi/Ovyr8FWgpDe219nAz7zWIxmMr3sqUlqcaezJP5KV/TaG1YBTgf/blSBqK6fytJcHzG
 lLRvfc4CuVeHmiTRvhpsLKKTBqv6Xx/0zaHfnyekOVtIsBxfqAtULA==
X-Received: by 2002:a17:90b:4f49:b0:31c:15b4:8e22 with SMTP id
 98e67ed59e1d1-31e7786e68emr2184928a91.7.1753446145398; 
 Fri, 25 Jul 2025 05:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1w8pnsiZhxT1T/M4W1TfUQk5n1dKG1IlXCcoNEXr5ZRiL+KxCfPo9Nu6NuDM20+OY5OaW1w==
X-Received: by 2002:a17:90b:4f49:b0:31c:15b4:8e22 with SMTP id
 98e67ed59e1d1-31e7786e68emr2184897a91.7.1753446144937; 
 Fri, 25 Jul 2025 05:22:24 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:22:24 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:49:02 +0530
Subject: [PATCH v7 23/24] migration: Add error-parameterized function
 variants in VMSD struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-propagate_tpm_error-v7-23-d52704443975@redhat.com>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7038; i=armenon@redhat.com;
 h=from:subject:message-id; bh=ism3yTV1svQzQq/1PEanhpRwocCsWlODf7ag0T6GxfA=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Zzma52e6TPzTYLPfdLa+bz39sgYOa57Yjsbb0jKn27m
 67MyBPqKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMJHSR4wM/zlVtl1eMfuvjfSl
 uvJ1XAEvrxr0/WHf//pX3af/qfq3chkZvjwNDbxzv+XXk2mxq+f1hTy7ES6md+ra1K5W8azCT1x
 XWQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 include/migration/vmstate.h | 11 ++++++++
 migration/vmstate.c         | 62 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 65 insertions(+), 8 deletions(-)

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
index bb5e9bf38d6ee7619ceb3e9da29209581c3c12eb..e427ef49b2b1991b0a3cdb14d641c197e00014b0 100644
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
+                          "ret: %d: ", vmsd->name, vmsd->version_id,
+                          vmsd->minimum_version_id, ret);
+            return ret;
+        }
+    } else if (vmsd->pre_load) {
         ret = vmsd->pre_load(opaque);
         if (ret) {
             error_setg(errp, "VM pre load failed for: '%s', "
@@ -236,7 +245,14 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
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
@@ -412,11 +428,19 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
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
+            error_prepend(errp, "pre-save failed: %s: ", vmsd->name);
+            return ret;
+        }
+    } else if (vmsd->pre_save) {
         ret = vmsd->pre_save(opaque);
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {
@@ -524,10 +548,22 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 if (ret) {
-                    error_setg(errp, "Save of field %s/%s failed",
-                                vmsd->name, field->name);
-                    if (vmsd->post_save) {
-                        vmsd->post_save(opaque);
+                    if (*errp == NULL) {
+                        error_setg(errp, "Save of field %s/%s failed",
+                                   vmsd->name, field->name);
+                    }
+                    if (vmsd->post_save_errp) {
+                        int ps_ret = vmsd->post_save_errp(opaque, &local_err);
+                        if (ps_ret < 0) {
+                            error_free_or_abort(errp);
+                            error_propagate(errp, local_err);
+                            ret = ps_ret;
+                        }
+                    } else if (vmsd->post_save) {
+                        int ps_ret = vmsd->post_save(opaque);
+                        if (ps_ret < 0) {
+                            ret = ps_ret;
+                        }
                     }
                     return ret;
                 }
@@ -554,7 +590,17 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
     ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
 
-    if (vmsd->post_save) {
+    if (vmsd->post_save_errp) {
+        int ps_ret = vmsd->post_save_errp(opaque, &local_err);
+        if (!ret && ps_ret) {
+            ret = ps_ret;
+            error_propagate(errp, local_err);
+        } else if (ret && ps_ret) {
+            error_free_or_abort(errp);
+            error_propagate(errp, local_err);
+            ret = ps_ret;
+        }
+    } else if (vmsd->post_save) {
         int ps_ret = vmsd->post_save(opaque);
         if (!ret && ps_ret) {
             ret = ps_ret;

-- 
2.50.0


