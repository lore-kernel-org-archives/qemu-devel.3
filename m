Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618A1C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 12:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU2iX-0001KL-RG; Tue, 24 Jun 2025 08:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uU2iI-0001F5-BL
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 08:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uU2i6-00025Y-Ot
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 08:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750767909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5amOI3Muxw9Bdaa//6DYAvpVb8Ztrhb/8eEIkO5kyU=;
 b=XcOckgrK7h/EbOFTA6kVSf10ww+R7JR5XJLGP35tESRUa96TH3LhN0qPSxOiT5vsLZRW64
 QAyqE7O4yW2ZfFZveY8ebhj4ncpdLGUcOixfNttKWBsIru53acvpZ644quB2OzecUZzhVm
 p3Vl2iJGpKx+8pQNTQfRwnK3+pFfHWQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-ezHct1MjNoK0swe30Y0B5g-1; Tue, 24 Jun 2025 08:23:50 -0400
X-MC-Unique: ezHct1MjNoK0swe30Y0B5g-1
X-Mimecast-MFC-AGG-ID: ezHct1MjNoK0swe30Y0B5g_1750767830
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b2fdba7f818so6245061a12.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 05:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750767829; x=1751372629;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L5amOI3Muxw9Bdaa//6DYAvpVb8Ztrhb/8eEIkO5kyU=;
 b=f4NcDAJOxoLRbJGqj6slgWzdBkcPpxW5jvdMSwj5ibwfvynukqHcESmxz73mbieBoT
 2DavtzDXMobQ6fauvs5JLe84nhd4Ym7EB+8TeC38CxEBQ56GE3Oy/j/9w0j+1EiCk9qx
 hUm/yALXLk3EkXYB3wEUZYw+1G1s8AChZO5qceJ+Ufsh52W+kv3FCHAHXotsj1rjplcy
 eaQAr/eMKlYEGepDI92gukvpzoS18W80i095A+jy9tPDK9zOZy1EMVu8E3erXnAMIdKw
 YSVGi7p8cWtXdqj1tJs9/M+CNurrdoFIy90QoiTLGEL6iEAfrZ/uz+A7Wn/Y14cb9fwT
 v2oQ==
X-Gm-Message-State: AOJu0YzdhLudMfseagVaqsb1rSlhaxIGRIzrwAU0lfqE+McFp4SsYYo2
 C9w+0t3lFRVvyumBxjLJ8y6EDFhOJT6eGt/kfyyxafY9S2yQNRvBbg7sg9v34BGH9vCNshVbkNW
 hOqoGARackYOoaeFgl6YPnMMQDsO24gSCvbQPSZTMsNPpCT7zleGpeOkz
X-Gm-Gg: ASbGnctNsztgzU7GLD6n9RDMkVpPBf3KWKciO++kpzXnQk4PEvMCAPJcS9bPh4hxqS2
 seYndUCpcKZw6r0VIJjkUj0yX7e7830zkrwSL232iJf6oYrftF99qpmdjJgkAxYMpKuVVr8DXsJ
 UvjvKgLWfsltddpu5c0qf3lHgHZP2J5F/06OlvVQC6bVgqLn2cSzYyOZbaKOkHt/10fz3jQkRz9
 4tYUJtJH2jR2QfRPMWvpSGsqU8TWbh8YFD7Q+Zuro94pi/67ExRDHrp9vVt2yqZLIWGPBVTr/on
 jOItTYZuJkQ5t1/fr5+t5anWI0HMSf03jue/
X-Received: by 2002:a05:6a20:7350:b0:21f:62e7:cd2d with SMTP id
 adf61e73a8af0-22026ed2595mr28281786637.34.1750767829507; 
 Tue, 24 Jun 2025 05:23:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0qv/6EDiQ36RuMlJnajlMLohP38T43JWwblQEW5eEkg/Y9KE9bie9YbNem5eduY5FohGVEA==
X-Received: by 2002:a05:6a20:7350:b0:21f:62e7:cd2d with SMTP id
 adf61e73a8af0-22026ed2595mr28281732637.34.1750767829133; 
 Tue, 24 Jun 2025 05:23:49 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.251])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c882cc5fsm1772091b3a.73.2025.06.24.05.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 05:23:48 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 24 Jun 2025 17:53:05 +0530
Subject: [PATCH 2/3] migration: Use error_setg instead of error_report
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-propagate_tpm_error-v1-2-2171487a593d@redhat.com>
References: <20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com>
In-Reply-To: <20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9315; i=armenon@redhat.com;
 h=from:subject:message-id; bh=SkTmNBSbT3qZxSBqMViWO3dogsetGJdllcHBRy+niBU=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0bUjH0H3IJ6v5rs/JSyYferadJfnfcEzeZSaOL71qnNJ
 i17re5yRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIkcjmL4K9Vm+WQ1W27h0elf
 xQLLktodck5Y+BS8DvyToWerP22qECPDH67Hld/+bJDNMvmZ0tHC1R82ff3lpeU6h2TcX8tJ67z
 gBAA=
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- This is an incremental step in converting vmstate
  loading code to report error via Error object.
- error_report() has been replaced with error_setg();
  and in places where error has been already set,
  error_prepend() is used to not lose information.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/migration.c |  8 +++++++-
 migration/savevm.c    | 56 ++++++++++++++++++++++++++++++++-------------------
 migration/vmstate.c   | 20 +++++++++---------
 3 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5cabb4e7307323159241ff35781db7f1c665a75b..86e16a284286928aedd47e65e7756d27e82e811c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -903,7 +903,13 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
-        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
+        if (local_err) {
+            error_prepend(&local_err, "load of migration failed: %s: ",
+                          strerror(-ret));
+        } else {
+            error_setg(&local_err, "load of migration failed: %s",
+                       strerror(-ret));
+        }
         goto fail;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 9bcc0935781b73e209dc57945f9dbb381283cad5..dd7b722f51143eacdc621c343a1334e6056bb268 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2689,8 +2689,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
     /* Read section start */
     section_id = qemu_get_be32(f);
     if (!qemu_get_counted_string(f, idstr)) {
-        error_report("Unable to read ID string for section %u",
-                     section_id);
+        error_setg(errp, "Unable to read ID string for section %u",
+                   section_id);
         return -EINVAL;
     }
     instance_id = qemu_get_be32(f);
@@ -2698,8 +2698,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read instance/version ID: %d",
-                     __func__, ret);
+        error_setg(errp, "%s: Failed to read instance/version ID: %d",
+                   __func__, ret);
         return ret;
     }
 
@@ -2708,17 +2708,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
     /* Find savevm section */
     se = find_se(idstr, instance_id);
     if (se == NULL) {
-        error_report("Unknown savevm section or instance '%s' %"PRIu32". "
-                     "Make sure that your current VM setup matches your "
-                     "saved VM setup, including any hotplugged devices",
-                     idstr, instance_id);
+        error_setg(errp, "Unknown savevm section or instance '%s' %"PRIu32". "
+                   "Make sure that your current VM setup matches your "
+                   "saved VM setup, including any hotplugged devices",
+                   idstr, instance_id);
         return -EINVAL;
     }
 
     /* Validate version */
     if (version_id > se->version_id) {
-        error_report("savevm: unsupported version %d for '%s' v%d",
-                     version_id, idstr, se->version_id);
+        error_setg(errp, "savevm: unsupported version %d for '%s' v%d",
+                   version_id, idstr, se->version_id);
         return -EINVAL;
     }
     se->load_version_id = version_id;
@@ -2726,7 +2726,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 
     /* Validate if it is a device's state */
     if (xen_enabled() && se->is_ram) {
-        error_report("loadvm: %s RAM loading not allowed on Xen", idstr);
+        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
         return -EINVAL;
     }
 
@@ -2767,8 +2767,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read section ID: %d",
-                     __func__, ret);
+        error_setg(errp, "%s: Failed to read section ID: %d",
+                   __func__, ret);
         return ret;
     }
 
@@ -2779,7 +2779,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
         }
     }
     if (se == NULL) {
-        error_report("Unknown savevm section %d", section_id);
+        error_setg(errp, "Unknown savevm section %d", section_id);
         return -EINVAL;
     }
 
@@ -2814,23 +2814,27 @@ static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
 
     v = qemu_get_be32(f);
     if (v != QEMU_VM_FILE_MAGIC) {
-        error_report("Not a migration stream");
+        error_setg(errp, "Not a migration stream magic %x != %x",
+                   v, QEMU_VM_FILE_MAGIC);
         return -EINVAL;
     }
 
     v = qemu_get_be32(f);
     if (v == QEMU_VM_FILE_VERSION_COMPAT) {
-        error_report("SaveVM v2 format is obsolete and don't work anymore");
+        error_setg(errp, "SaveVM v2 format is obsolete and don't work anymore");
         return -ENOTSUP;
     }
     if (v != QEMU_VM_FILE_VERSION) {
-        error_report("Unsupported migration stream version");
+        error_setg(errp, "Unsupported migration stream version %x != %x",
+                   v, QEMU_VM_FILE_VERSION);
         return -ENOTSUP;
     }
 
     if (migrate_get_current()->send_configuration) {
-        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
-            error_report("Configuration section missing");
+        v = qemu_get_byte(f);
+        if (v != QEMU_VM_CONFIGURATION) {
+            error_setg(errp, "Configuration section missing, %x != %x",
+                       v, QEMU_VM_CONFIGURATION);
             return -EINVAL;
         }
         ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
@@ -3434,7 +3438,12 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     ret = qemu_loadvm_state(f, errp);
     qemu_fclose(f);
     if (ret < 0) {
-        error_setg(errp, "loading Xen device state failed");
+        if (*errp) {
+            ERRP_GUARD();
+            error_prepend(errp, "loading Xen device state failed: ");
+        } else {
+            error_setg(errp, "loading Xen device state failed");
+        }
     }
     migration_incoming_state_destroy();
 }
@@ -3511,7 +3520,12 @@ bool load_snapshot(const char *name, const char *vmstate,
     bdrv_drain_all_end();
 
     if (ret < 0) {
-        error_setg(errp, "Error %d while loading VM state", ret);
+        if (*errp) {
+            ERRP_GUARD();
+            error_prepend(errp, "Error %d while loading VM state: ", ret);
+        } else {
+            error_setg(errp, "Error %d while loading VM state", ret);
+        }
         return false;
     }
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 177c563ff103ada2e494c14173fa773d52adb800..3f8c3d3c1dcfe14d70bab1f43b827244eb4bb385 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -139,16 +139,16 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 
     trace_vmstate_load_state(vmsd->name, version_id);
     if (version_id > vmsd->version_id) {
-        error_report("%s: incoming version_id %d is too new "
-                     "for local version_id %d",
-                     vmsd->name, version_id, vmsd->version_id);
+        error_setg(errp, "%s: incoming version_id %d is too new "
+                   "for local version_id %d",
+                   vmsd->name, version_id, vmsd->version_id);
         trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
         return -EINVAL;
     }
     if  (version_id < vmsd->minimum_version_id) {
-        error_report("%s: incoming version_id %d is too old "
-                     "for local minimum version_id  %d",
-                     vmsd->name, version_id, vmsd->minimum_version_id);
+        error_setg(errp, "%s: incoming version_id %d is too old "
+                   "for local minimum version_id  %d",
+                   vmsd->name, version_id, vmsd->minimum_version_id);
         trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
         return -EINVAL;
     }
@@ -213,15 +213,15 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                 }
                 if (ret < 0) {
                     qemu_file_set_error(f, ret);
-                    error_report("Failed to load %s:%s", vmsd->name,
-                                 field->name);
+                    error_setg(errp, "Failed to load %s:%s", vmsd->name,
+                               field->name);
                     trace_vmstate_load_field_error(field->name, ret);
                     return ret;
                 }
             }
         } else if (field->flags & VMS_MUST_EXIST) {
-            error_report("Input validation failed: %s/%s",
-                         vmsd->name, field->name);
+            error_setg(errp, "Input validation failed: %s/%s",
+                       vmsd->name, field->name);
             return -1;
         }
         field++;

-- 
2.49.0


