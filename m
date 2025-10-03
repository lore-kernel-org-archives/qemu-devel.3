Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF55FCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hup-0005La-Lj; Fri, 03 Oct 2025 11:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huE-0004vZ-SF
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htf-0007gW-27
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cH4PFStgd3tkIBio2mLeCJam9cI6cbrtyVGN2JLYb+w=;
 b=a6x5rGtjCjdG42o4WJSPhGxIhoz065EDVMIuPKt8KRf2nTN7bQV3sM34Gk9a06+Lhl7oti
 UK0zza0tRHpxts5c2j/CT1qvVbW0CI46Nau7YJC5EBuU0wSH+8zY8iWgCDeG2VpWMdNGxR
 2p1NmO0VF8otD8l67VIqb8CsLK42b6s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-uBCnp0p5MFOTIHCl7ulZ1g-1; Fri, 03 Oct 2025 11:40:29 -0400
X-MC-Unique: uBCnp0p5MFOTIHCl7ulZ1g-1
X-Mimecast-MFC-AGG-ID: uBCnp0p5MFOTIHCl7ulZ1g_1759506029
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-7fa235e330dso45657946d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506029; x=1760110829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cH4PFStgd3tkIBio2mLeCJam9cI6cbrtyVGN2JLYb+w=;
 b=EkK9uSNNRSrnBusK5gR3IklI8I3oJoLcWgXB7XmoSftz7Uv9xFXWNf3kajXvl07mne
 cIwZ/m2+CdpANh4QXg+/saph/woc5vWcUVdyahq6pDmtmcc3jGnW7Woni3eYDlt17JKL
 wkPxnXK05gfJdd+9sQuKrybISOTB2ph7Q4F9lDvwFW9gtGtphufbBrchVJXnDUv4r/m/
 7SQFgHgzkkl8pGmQdgzleVDItmh0Ks/3oTf6laNqZJTsZMMxOoTLLX2o4zm41wWgabSX
 RzkZkbBryuJ8g2b9NRaM8ZvTK3hJXuFuRgqhzZtAZKe/z9W0HXssxM0qNjYKZSThX1bi
 gzBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1ViXOfqPlxEVEvyU/YpThb8NXYqIeRPUZKguK+h0jt0P21AWWJG1rqtosxIwTYtmePaRKxEv3DgIk@nongnu.org
X-Gm-Message-State: AOJu0YxY7AtDd7OZANAYFVmeV30TpQf3p4CwwwgvNjPwRTU5iZLxX2GK
 Z2Y9uIe0P/YIoRdbK1mk3f98Gj4BUBHFMebZVFnoEkILBGS8x4kZTiC7O0EGGzItFEUmjIRUS/m
 BkmEnWElZl478eWmEbWzvMi1rH1IkHbYJgyXqs5rdLlwjVQrzgvTwQ4Bi
X-Gm-Gg: ASbGncvaD2TH0YSXZssMopmKdjQQ5VmsmQdLSWyOjCqQPIJz77lTOky0bdC+XAdbooG
 xw1mekoe7ZHrMK0cQgBLC/mNA/Me+5cdbd8QqBheZDmk3x+ek5LyXxgdAY1FszbPbEwBiSn/9Gj
 2LjlX/SoDoKRpU+XMZ9uJJD7tDttDhnAn3z86SOZbrU8q+TToKe4C8GRiOdCnKsjMasbgeUrSv4
 fkCy1DUcfUHQaX0XVMaDgBY2EJ3aIMPekzdR09UIeWkurFkRpNYR8/igbjpd/MGUt7FbG49fEvg
 UaDbDC3Yya2q/o5V+RHEVe2ANwaqfZhmd/Etwg==
X-Received: by 2002:a05:6214:2428:b0:788:82e0:3a9 with SMTP id
 6a1803df08f44-879dc443233mr39547696d6.21.1759506029054; 
 Fri, 03 Oct 2025 08:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKXnyKoVCB3VFVroJi84btCmkfIQyy5XrAgtfHBnJWYCjGEWfiUuj9J4ksFHEN2bRkXXef9g==
X-Received: by 2002:a05:6214:2428:b0:788:82e0:3a9 with SMTP id
 6a1803df08f44-879dc443233mr39547206d6.21.1759506028470; 
 Fri, 03 Oct 2025 08:40:28 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:28 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 25/45] migration: Add error-parameterized function variants in
 VMSD struct
Date: Fri,  3 Oct 2025 11:39:28 -0400
Message-ID: <20251003153948.1304776-26-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Arun Menon <armenon@redhat.com>

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
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-26-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/main.rst | 19 +++++++++++++++++++
 include/migration/vmstate.h   | 14 ++++++++++++++
 migration/vmstate.c           | 31 ++++++++++++++++++++++++++++---
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 6493c1d2bc..1afe7b9689 100644
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
index 5fe9bbf390..5567fd78d0 100644
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
index ad8e5b71ae..81eadde553 100644
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
2.50.1


