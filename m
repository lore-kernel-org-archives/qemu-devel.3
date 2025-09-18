Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17F1CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGXp-0002yt-NQ; Thu, 18 Sep 2025 11:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGXi-0002nb-OA
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGXf-0003OF-A8
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PaZvHMvq5UGvPHZJTIR0qZ8hdQBkbCFkuOZ3ZxBhp7k=;
 b=AB+d7a/bv3ypcpBeYRarhrvKRHULIYmXekVCiIIpkGouz3fBIh0DTctQD0cEPBeYBaMnlH
 jqETshSFdXFA+Zvh5yFpLW3oCq2684pyAYf29nr5r8xM9Rv/y/XDauqAAt5XPUJHO0jk91
 UXax0y6skqwMokxtzbfH0sPuJuTZHuk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-krCUzEgVOgmciGei13u-cg-1; Thu, 18 Sep 2025 11:27:25 -0400
X-MC-Unique: krCUzEgVOgmciGei13u-cg-1
X-Mimecast-MFC-AGG-ID: krCUzEgVOgmciGei13u-cg_1758209244
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-77243618babso1175925b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209244; x=1758814044;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PaZvHMvq5UGvPHZJTIR0qZ8hdQBkbCFkuOZ3ZxBhp7k=;
 b=IUY/AgSmMx0KfoU+PKhFc2buZS50XZIw/SeOFNRJdTXghE+OC/1oRqUvm258sP6ukR
 3LdSmsPUMImeZawNYsRbPIJNLeJzd8rGu7iqqyZHQI7RGh8QsbSgBXyGd86IiiEaXvYf
 5tvwEue8ZYkXmHggB8RMz/midEt2h5qdtqrQaPGamwxpTqvmatPvfgfTfpeuEvzTSMyu
 5CtBahUqKLBhDgHaW3Vu5MJ4H8JssYGtOzIWtg9vi9h8yXx2h4HGK4bC/hV7htRAy8Uc
 qtKIoaqW8Nl0uHOWqHsCZrG32T1fYynVGPYtqg3OvoclXI+zNff6m/SLSHO8zfqjZybD
 xpTA==
X-Gm-Message-State: AOJu0YzqW9LSc4HujdL15GaaCiFGkO+KaLOEf2+DaVl2bzY0b4NfwOPK
 EEqmG1eLr8HRgCgGr0Myol+Yzm3wNH63w+MDT3f9OXoPDtY4YlWx3yQmVplza+sIAC3tUhmZeAJ
 rQ0zJst0d1wCu87qnJ6ZfKqLaPYalbk2hKa3sDWahPSTQ0iu4PwT6GRe7
X-Gm-Gg: ASbGnctR2yM99hmABXIcSNyui4ZFAQ/ysAlKUJWzdA0UZ6Zg4UDLXwm/I5fa9tpNb8r
 julBUeQ8Qq/XxJ1obhtx6SunpGJkmx9CIPbSVfBdqHs1s+jgRd8hVYWxH6qslVSD973sejlDREm
 9OquN3rX7pjMJQ9MFnwTYHfCXtY7iGuObH7+/VLlrJcTmj28OzFRV9JJ3tT2fiX/gXnNk1Y9BhC
 gNqwiQ4itf9M4XC2CeRSFW3hgflFsCBwDDcL3X7OyJ0HkY+fvBw3aJGrPoJmbdCUoMfUfMIudw5
 QC2PjM0lKzspVI/nC6V9odD/7KzJaY96iQoDQQzLadhwqi72Dx2XBw==
X-Received: by 2002:a05:6a00:1395:b0:771:ec42:1c1e with SMTP id
 d2e1a72fcca58-77bf9274927mr6708383b3a.16.1758209243988; 
 Thu, 18 Sep 2025 08:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh4YZXnONzvydcwry0JyJmM1lVvZRxCXhgGiNSZ1r9M4aK4I7jrrnQaVsMUnrkDuoLzzmxbQ==
X-Received: by 2002:a05:6a00:1395:b0:771:ec42:1c1e with SMTP id
 d2e1a72fcca58-77bf9274927mr6708358b3a.16.1758209243574; 
 Thu, 18 Sep 2025 08:27:23 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:27:23 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:42 +0530
Subject: [PATCH v14 25/27] migration: Rename post_save() to cleanup_save()
 and make it void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-propagate_tpm_error-v14-25-36f11a6fb9d3@redhat.com>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
In-Reply-To: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6500; i=armenon@redhat.com;
 h=from:subject:message-id; bh=RA0v69F99I5SRsauN9jKQHb/8Bw3uL+HkXH2toG+G78=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5Z99Z2Nk0qR3u6uJX1or/zT/UpjUIwuPD3dPah4qM
 pO6uMK3o5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwET4pRkZnnosOmwso8Fre2ZW
 3rRDz2dfF39+99iuqttLtj4IvyNet4Lhr0xyylvmcouOf/wS33+sqOfwfNh2NDDORk/RWH+Vljo
 HFwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The post_save() function call is responsible for cleaning up resources
after the device state has been saved.
Currently it is infallible, and does not return an error.

It is called regardless of whether there is a preceding error from
save or subsection save. That is, save and post_save() together are
considered to be an atomic logical operation.

It should not be confused as a counterpart of the post_load() function
because post_load() does some sanity checks and returns an error if it
fails. This commit, therefore, renames post_save() to cleanup_save()
and makes it a void function.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 docs/devel/migration/main.rst |  2 +-
 hw/ppc/spapr_pci.c            |  5 ++---
 include/migration/vmstate.h   |  2 +-
 migration/savevm.c            |  5 ++---
 migration/vmstate.c           | 12 ++++--------
 target/arm/machine.c          |  6 ++----
 6 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 6493c1d2bca48a2fa34d92f6c0979c215c56b8d5..a39fec2e21c26c4315c0cf13b105176d70679d4d 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -439,7 +439,7 @@ The functions to do that are inside a vmstate definition, and are called:
 
   This function is called before we save the state of one device.
 
-- ``int (*post_save)(void *opaque);``
+- ``void (*cleanup_save)(void *opaque);``
 
   This function is called after we save the state of one device
   (even upon failure, unless the call to pre_save returned an error).
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 1ac1185825e84ca908fd878f6cbe7e8cacac1d89..135265f075dff502af59fbc91babca1f9a26c54d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2118,14 +2118,13 @@ static int spapr_pci_pre_save(void *opaque)
     return 0;
 }
 
-static int spapr_pci_post_save(void *opaque)
+static void spapr_pci_cleanup_save(void *opaque)
 {
     SpaprPhbState *sphb = opaque;
 
     g_free(sphb->msi_devs);
     sphb->msi_devs = NULL;
     sphb->msi_devs_num = 0;
-    return 0;
 }
 
 static int spapr_pci_post_load(void *opaque, int version_id)
@@ -2152,7 +2151,7 @@ static const VMStateDescription vmstate_spapr_pci = {
     .version_id = 2,
     .minimum_version_id = 2,
     .pre_save = spapr_pci_pre_save,
-    .post_save = spapr_pci_post_save,
+    .cleanup_save = spapr_pci_cleanup_save,
     .post_load = spapr_pci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64_EQUAL(buid, SpaprPhbState, NULL),
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 5fe9bbf39058d0cf97c1adab54cc516dbe8dc32a..c1d8e5b7a7d9d544fc8ce181372660f5538ef66b 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -208,7 +208,7 @@ struct VMStateDescription {
     int (*pre_load)(void *opaque);
     int (*post_load)(void *opaque, int version_id);
     int (*pre_save)(void *opaque);
-    int (*post_save)(void *opaque);
+    void (*cleanup_save)(void *opaque);
     bool (*needed)(void *opaque);
     bool (*dev_unplug_pending)(void *opaque);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 2c05b763148295d7e2095027aa143f45bc4c4676..693f77b728604f2072fb40bd2ec268b217da9727 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -322,14 +322,13 @@ static int configuration_pre_save(void *opaque)
     return 0;
 }
 
-static int configuration_post_save(void *opaque)
+static void configuration_cleanup_save(void *opaque)
 {
     SaveState *state = opaque;
 
     g_free(state->capabilities);
     state->capabilities = NULL;
     state->caps_count = 0;
-    return 0;
 }
 
 static int configuration_pre_load(void *opaque)
@@ -544,7 +543,7 @@ static const VMStateDescription vmstate_configuration = {
     .pre_load = configuration_pre_load,
     .post_load = configuration_post_load,
     .pre_save = configuration_pre_save,
-    .post_save = configuration_post_save,
+    .cleanup_save = configuration_cleanup_save,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(len, SaveState),
         VMSTATE_VBUFFER_ALLOC_UINT32(name, SaveState, 0, NULL, len),
diff --git a/migration/vmstate.c b/migration/vmstate.c
index ad8e5b71ae2ce78e66a6426602e5c20405ec57c0..a7562a5cfd8627e20c90e286e35c5e3429c48150 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -529,8 +529,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 if (ret) {
                     error_setg(errp, "Save of field %s/%s failed",
                                 vmsd->name, field->name);
-                    if (vmsd->post_save) {
-                        vmsd->post_save(opaque);
+                    if (vmsd->cleanup_save) {
+                        vmsd->cleanup_save(opaque);
                     }
                     return ret;
                 }
@@ -557,12 +557,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
     ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
 
-    if (vmsd->post_save) {
-        int ps_ret = vmsd->post_save(opaque);
-        if (!ret && ps_ret) {
-            ret = ps_ret;
-            error_setg(errp, "post-save failed: %s", vmsd->name);
-        }
+    if (vmsd->cleanup_save) {
+        vmsd->cleanup_save(opaque);
     }
     return ret;
 }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 6666a0c50c45504082f02fab42f499ca58dc3597..cb6b9ee653915cd07b7d93e2c9ec63be1a3365a0 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -883,15 +883,13 @@ static int cpu_pre_save(void *opaque)
     return 0;
 }
 
-static int cpu_post_save(void *opaque)
+static void cpu_cleanup_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
     if (!kvm_enabled()) {
         pmu_op_finish(&cpu->env);
     }
-
-    return 0;
 }
 
 static int cpu_pre_load(void *opaque)
@@ -1028,7 +1026,7 @@ const VMStateDescription vmstate_arm_cpu = {
     .version_id = 22,
     .minimum_version_id = 22,
     .pre_save = cpu_pre_save,
-    .post_save = cpu_post_save,
+    .cleanup_save = cpu_cleanup_save,
     .pre_load = cpu_pre_load,
     .post_load = cpu_post_load,
     .fields = (const VMStateField[]) {

-- 
2.51.0


