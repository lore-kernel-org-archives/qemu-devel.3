Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A032C54F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonTB-0003yU-Br; Tue, 28 Jul 2026 15:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSP-0003TY-0e
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:19 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSN-0001b1-7i
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:16 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38e347638adso231748a91.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266834; x=1785871634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B/s2MhOVNf5tNx0QLnD9DD7cZjOjKqSbP0aTOIvlKbQ=;
 b=jhc2ES0qqECbG0DvG0aMrnD0ac57mWBA171tF7+PL/WlqQN13/FUnE68f9ULxs6PDh
 5YXtLfaTV+J8XmbEw+gf/U9cDRikv6ejlg99CJoBjaErqengHRRXA23d5ivIDaAme3T9
 LrI3IF7CWVAv+qtX4ZTvVELo/5mpYQWBgpxmqQmaXMKmodtofiWyDJPY7/Qu3jXwzFNQ
 dwD35jbiX907Bb3fjzqw+23phEMgLgdjUIb7iqK9S3dD2had8bgxWM0s994FX1CkQFC/
 plk+19lB66H+tQTnNmmVOkwquXUw1XlJg+SaIQ8gACqArppPSz+0YhChgFXyeZLmhA8L
 3qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266834; x=1785871634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B/s2MhOVNf5tNx0QLnD9DD7cZjOjKqSbP0aTOIvlKbQ=;
 b=JexRDyeA2BdHddXp32eZiVucppuv4+YTZB1UCMCDLX5xcCKIAMiqKl0uPeRB5GIdP3
 HxthP58nnr0uY1qChEx2GZgZCoQrf6rbTtZ9pK0oMzDs4vBwcPxz8VbIQsZGkg1cWitU
 gEZwdRIEzvPkMC1un6Xrt3fQXPwBrDlsRyIJ0Peq6veSioV/1JnYrTU0sN0sMe1As10/
 BXIM5yscuXfSGn9RO23A+50N20y28DlRXh5vX6YFM0NF5PzRU57xZq2pqy66GDs4yNFo
 CBcCXY2VAAQOqiMkz5WdVznGHgTDPay3Rljx9MHoQA9UJe/GGCY1blrkrNqp3YsKqgaT
 9VOg==
X-Gm-Message-State: AOJu0YzXIaRDPCW9CqzHTUSXgwx7Rww62rlnDOBO0HnGSeskJd/3zoTi
 L1PLvfymfkA6dF6yx/wgcSrg+LUBjNGhK2+bpC800l3o1+05axlw/XGJrDgUXQY/E6w=
X-Gm-Gg: AR+sD11FRJd349KjLwxHCqPeySXEuG1daNDPwKapxKli+EjiFMMxxwqP4IMeEVKI00A
 vbhnSQZL8ShU8oquDNBZ9M6HP0jGiUBPIpfmSR2oFW/Nf6wM9ONXvP9Mzuc2WDqQhRiGv40SEHU
 Vh64kMOWjBtEn7GMxFDx4rhT55wL2bf6T/juLPddfJtBBYt31alEJNHjF45vRuC3bdt8uhLIQ6p
 FfXT7pyEA4odbJjs4k+gFYfc3nj+8zvzZHOUX0x8i5bUaHZ7YPbqKk53tpWQndQcrpX/Ul7pyM3
 rj8MYUudbbJRyaIfS5c9cWY77oW2XEkZIz6ymkG3Xy5L7TGD5erXSn85zFN8xg4Wc09mwPhE5do
 erqMtGinpawFzQw8b9oYCzAhpsuwyfZrAfaqWB7Rz4xHE3y/DtRMxckEF6zgQYafrw8BQBUwNj0
 W6y7aneWe0duoHXJGmYYblFlhVb7Pw
X-Received: by 2002:a17:90b:4a06:b0:38e:69f8:cc49 with SMTP id
 98e67ed59e1d1-38f6a569e3emr3771045a91.40.1785266833744; 
 Tue, 28 Jul 2026 12:27:13 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:27:13 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 18/24] hw/arm/virt: Disable DTB randomness for confidential
 VMs
Date: Tue, 28 Jul 2026 13:26:24 -0600
Message-ID: <20260728192630.240375-19-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102e.google.com
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
index fa6cd62a335c..65ed8573f8b1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -401,6 +401,7 @@ static int gic_fdt_irq_type_spi(const VirtMachineState *vms)
 
 static void create_fdt(VirtMachineState *vms)
 {
+    bool dtb_randomness = true;
     MachineState *ms = MACHINE(vms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
     void *fdt = create_device_tree(&vms->fdt_size);
@@ -410,6 +411,16 @@ static void create_fdt(VirtMachineState *vms)
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
@@ -431,13 +442,13 @@ static void create_fdt(VirtMachineState *vms)
 
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
@@ -3512,18 +3523,21 @@ static void virt_set_virtio_transports(Object *obj, Visitor *v,
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
@@ -4343,16 +4357,16 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
 
@@ -4415,9 +4429,6 @@ static void virt_instance_init(Object *obj)
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


