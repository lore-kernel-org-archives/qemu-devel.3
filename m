Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B671DCA5FE5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjki-0007aC-4o; Fri, 02 Oct 2026 16:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkc-0007Q7-4f
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:21:02 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjka-0005pJ-8b
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:21:01 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747f01363so51437765ad.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790972459; x=1791577259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EutMuVi05q7D0n6FZ3Jv8HMw5DGbhkWXN2U7LRtbrK8=;
 b=k8G6dJUooSdY8HUDAmK2rHUym0QQpo1DVGV+mjQssb8f2oyQGxfvJpvuIRMFA4tSo1
 cxxEsR9b0YrMeXUKN5BsACDKiRlxXDrDLfQV3IfPGbUvsGCCI0wFQL2zglPKwsFwqkAf
 6kIViT+yVWFRKhk1sY2iygRolWDJEDwIWhqmU2flJz0z/SEcdRuuCUmwiENnZ7VurM+d
 Y2bjVXDWOED+gyk1lx2st0TpCJuCZVzggqZ2lx2cpDOadwmIxb0RLzTRFHCML0z1+T1R
 P5/AzyaJT8b8UffuBnfQdWaIwUCOlBLbGZqFVWODcDrSSSCDaa2IjtdtpbC8bFnroJq+
 dUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972459; x=1791577259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EutMuVi05q7D0n6FZ3Jv8HMw5DGbhkWXN2U7LRtbrK8=;
 b=e5SdxIhnscNy258ZoVbR4H7biOYntZCjhAC7COZmWGPK6Z0QP6dGV1HC4h5qrwOHAz
 gqsEzCTpiua1FDOGvzqzveWXJxkcLrglDH7e/w59jBH1N1OPPRdotXjT3M/JwnpMgGhR
 Y+4p5dGbJCJa0vOz9JO5k5n7z3NNc9hSCBps0yO1mJdFi/mCAPaDsUJwzWwJ1o4HaYMA
 5D5tEH7Edff5INXNwW+RNQrpXB3rZo53S7bfA96tPnC8c1kJ3B7Pu8/tyVt45yOfBgR3
 Iz1HBnx2zrV9IhdvGXgZI90nv5J/HKthYiGaSrI9f6yZ70z4en5bIRz743PLsG0NBo04
 Dm4Q==
X-Gm-Message-State: AFq9FYJSulT2DAZ9nIv4tC7+qPl+9D7BhKoOntL5m9Uf5opBhAZX5C5Z
 D1Z+2BegnmDkgxyVGOET8Nv8IwpoHyZmtbYzE65DR4DRRM0B4TOnjUKMfRv8fi96TsE=
X-Gm-Gg: AYBFou1nfgp7WTJ09h7ASVkPBQ7xhaEXI+Pn5RLC4Tkg9GB+bXi2GyZEYjCes0OvFn6
 QtxBpC1f8SyAsj6uBloULHxFHb1sn+tNRZn53+U5W32171/E9LFgJqwt0XutJfBEwrFYzHuYQZs
 86tF67L/7cNHzXhSaZmfabWt3ZAvS9aZ9WOV+kjBQqqFLHVy4l/2VEWEVqX/UxsVLAjOE9vAZH2
 vV4xIU/tFuSwkddH4OnzRHMh5Z0D7dLwO+YR2B4qdpZ3RBdNIjQCjXte2K0HBpMKNr/23nyFwEz
 jr7+CzPYRDpE7aWu+XqyHtz+wkgvX4Wlstv4KZ07tv3nps0sPCaGotPgo8a7DaLv3/QHojQINFA
 UyoEOhF8r2X0MzSUwmJP2H0KXk3ZmYJMlN53sbHoHacGvUxpCfFI4tUhg2lkKl/UPBZDx2yC8Jg
 bUNscm7sbqur+ThKLZ1KU18My2M8YTd0DfXLGu9TbErWuC0cyb9szQ8mXaM9poJ4j6+5JTAlT1H
 PP0u/jqkQp78QssrKFHN0Qq
X-Received: by 2002:a17:903:3d0e:b0:2d8:d4ce:7e40 with SMTP id
 d9443c01a7336-2e49b64e249mr33210835ad.21.1790972458684; 
 Fri, 02 Oct 2026 13:20:58 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:20:57 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 16/22] hw/arm/virt: Disable DTB randomness for confidential
 VMs
Date: Fri,  2 Oct 2026 14:20:20 -0600
Message-ID: <20261002202026.1204110-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The dtb-randomness feature, which adds random seeds to the DTB, isn't
really compatible with confidential VMs since it randomizes the Realm
Initial Measurement. Enabling it is not an error, but it prevents
attestation. It also isn't useful to a Realm, which doesn't trust host
input.

Currently the feature is automatically enabled, unless the user disables
it on the command-line. Change it to OnOffAuto, and automatically
disable it for confidential VMs, unless the user explicitly enables it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 docs/system/arm/virt.rst |  9 +++++----
 hw/arm/virt.c            | 41 +++++++++++++++++++++++++---------------
 include/hw/arm/virt.h    |  2 +-
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 5f6dd1797862..9882b842ddd5 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -238,10 +238,11 @@ dtb-randomness
   rng-seed and kaslr-seed nodes (in both "/chosen" and
   "/secure-chosen") to use for features like the random number
   generator and address space randomisation. The default is
-  ``on``. You will want to disable it if your trusted boot chain
-  will verify the DTB it is passed, since this option causes the
-  DTB to be non-deterministic. It would be the responsibility of
-  the firmware to come up with a seed and pass it on if it wants to.
+  ``off`` for confidential VMs, and ``on`` otherwise. You will want
+  to disable it if your trusted boot chain will verify the DTB it is
+  passed, since this option causes the DTB to be non-deterministic.
+  It would be the responsibility of the firmware to come up with a
+  seed and pass it on if it wants to.
 
 dtb-kaslr-seed
   A deprecated synonym for dtb-randomness.
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b2cca73dda6f..35e76951dafd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -394,6 +394,7 @@ static int gic_fdt_irq_type_spi(const VirtMachineState *vms)
 
 static void create_fdt(VirtMachineState *vms)
 {
+    bool dtb_randomness = true;
     MachineState *ms = MACHINE(vms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
     void *fdt = create_device_tree(&vms->fdt_size);
@@ -403,6 +404,16 @@ static void create_fdt(VirtMachineState *vms)
         exit(1);
     }
 
+    /*
+     * Including random data in the DTB causes random intial measurement on CCA,
+     * so disable it for confidential VMs.
+     */
+    if (vms->dtb_randomness == ON_OFF_AUTO_OFF ||
+        (vms->dtb_randomness == ON_OFF_AUTO_AUTO &&
+         virt_machine_is_confidential(vms))) {
+        dtb_randomness = false;
+    }
+
     ms->fdt = fdt;
 
     /* Header */
@@ -424,13 +435,13 @@ static void create_fdt(VirtMachineState *vms)
 
     /* /chosen must exist for load_dtb to fill in necessary properties later */
     qemu_fdt_add_subnode(fdt, "/chosen");
-    if (vms->dtb_randomness) {
+    if (dtb_randomness) {
         create_randomness(ms, "/chosen");
     }
 
     if (vms->secure) {
         qemu_fdt_add_subnode(fdt, "/secure-chosen");
-        if (vms->dtb_randomness) {
+        if (dtb_randomness) {
             create_randomness(ms, "/secure-chosen");
         }
     }
@@ -3505,18 +3516,21 @@ static void virt_set_virtio_transports(Object *obj, Visitor *v,
     vms->virtio_transports = transports;
 }
 
-static bool virt_get_dtb_randomness(Object *obj, Error **errp)
+static void virt_get_dtb_randomness(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
+    OnOffAuto dtb_randomness = vms->dtb_randomness;
 
-    return vms->dtb_randomness;
+    visit_type_OnOffAuto(v, name, &dtb_randomness, errp);
 }
 
-static void virt_set_dtb_randomness(Object *obj, bool value, Error **errp)
+static void virt_set_dtb_randomness(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    vms->dtb_randomness = value;
+    visit_type_OnOffAuto(v, name, &vms->dtb_randomness, errp);
 }
 
 static char *virt_get_oem_id(Object *obj, Error **errp)
@@ -4339,16 +4353,16 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set MSI settings. "
                                           "Valid values are auto, gicv2m, its and off");
 
-    object_class_property_add_bool(oc, "dtb-randomness",
-                                   virt_get_dtb_randomness,
-                                   virt_set_dtb_randomness);
+    object_class_property_add(oc, "dtb-randomness", "OnOffAuto",
+                              virt_get_dtb_randomness, virt_set_dtb_randomness,
+                              NULL, NULL);
     object_class_property_set_description(oc, "dtb-randomness",
                                           "Set off to disable passing random or "
                                           "non-deterministic dtb nodes to guest");
 
-    object_class_property_add_bool(oc, "dtb-kaslr-seed",
-                                   virt_get_dtb_randomness,
-                                   virt_set_dtb_randomness);
+    object_class_property_add(oc, "dtb-kaslr-seed", "OnOffAuto",
+                              virt_get_dtb_randomness, virt_set_dtb_randomness,
+                              NULL, NULL);
     object_class_property_set_description(oc, "dtb-kaslr-seed",
                                           "Deprecated synonym of dtb-randomness");
 
@@ -4411,9 +4425,6 @@ static void virt_instance_init(Object *obj)
     /* MTE is disabled by default.  */
     vms->mte = false;
 
-    /* Supply kaslr-seed and rng-seed by default */
-    vms->dtb_randomness = true;
-
     vms->irqmap = a15irqmap;
 
     vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 22e66d1a113c..d4c1aa04f664 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -176,7 +176,7 @@ struct VirtMachineState {
     bool virt;
     bool ras;
     bool mte;
-    bool dtb_randomness;
+    OnOffAuto dtb_randomness;
     bool second_ns_uart_present;
     OnOffAuto acpi;
     VirtGICType gic_version;
-- 
2.43.0


