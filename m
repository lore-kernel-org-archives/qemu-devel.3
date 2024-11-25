Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EF9D59D69
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFK-0005EM-D0; Mon, 25 Nov 2024 14:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFG-00058m-B2
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:42 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF9-0004qA-6G
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:42 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38230ed9baeso3430502f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564774; x=1733169574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=infJS9DeH0K27lOoLlvsvVDPUOvzl4+LENJg6UezPVw=;
 b=EutVuyD9pOsvz9ThBgVAQQrYgLOwwq0uR4rEMXNESmTwXdsArjRf2FhAW3e+3tDeN7
 8p4PJO5Sy77POzdRlrqPOz/++ke0ismX+0+R4sfG7lsq9yu6+2o8+j9gYDUelALhYiQr
 WG+4Kq0qpEmu2d+HSG6wi7p5C+ct/uS5Dp4IXhCcc9owyft1pvx817bWraiTJSrMEaK5
 3qixjFIg+TMsmVgBRCVS2kXuUzOYMwAvkCpPlochdVxMf4l0aFwbR4sdZrQb9g7iFb7k
 9zHxZMG5vjMWVkFWfp4pHDylbowA3/w/O8VDjp168k/fKA3vGKDH0yyXKSfZPwQZn+U4
 Kudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564774; x=1733169574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=infJS9DeH0K27lOoLlvsvVDPUOvzl4+LENJg6UezPVw=;
 b=dXWNYhpphQsv9lthfoET+xwU0ExxZt6aKCkuFsVbl8N5Py2ikU9OetwtLl7hkryBsz
 ZQD4DSKSopdc9nKgGm6RkgGJ0jZdL+lC9fa96+55SGALDLWkiUlADTh910piWLES2hAn
 ges60wmJucsV2c2R/gxlQ5017Vd6LtR++vsd+WSJkf1CCOY8D1/1M3SST1SxI+HC6u4S
 4E0mXomWetyVwbFIOQLI1BfCpiWxcLcqzJagRyw46vXPdg36vyV7GwNpiJXqixg9KNfi
 zjlLx8vmh6vjSZidpWSNYCimtCJjwb7bs5laXMoOc0aseNvgYwivA9yKS0D4ViIbb0sL
 ze8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+AYBcpZcPKMejdIRjWfbvAX9E35c0w+LPwfkuYDu+DSbo0inD+nMe9w/hiJzQ/llxQVrjSjyQ3MCY@nongnu.org
X-Gm-Message-State: AOJu0Yy3NjZHVgr27sZ2oYbv0VK9EiByNrVUz2IJUxuKVTedvbGvy4Cu
 aosDNxZgVQd1NktX1proSttJMdWfUK45H8VFzu/agyvGEKJSfWEYA1rJ5SqAFhg=
X-Gm-Gg: ASbGncuddOQv43jEtb0MTNePca3LFaj/C4YUrZNoT0nK73KNobIyP5iIbK8oui9EWKw
 xIjl08c2Pv0QuEgne3GxFM06AZ7bHmVEiFJiAzO+cqxE3UsKMRbkeAQIIp6TAIcpyIoD7wOUzng
 kjN2hSjWPveKNN1ZdB/VnpVwSrb6T/hHFiTgQnw6DjS9DhoO04W0EU8Dh80k/7we6sytxx4xYE+
 tzdMrRW7KHLjdI5CrxT1q4IAuehNqFGAt2Svmn3WUGfybcTPnVxYliJnzqfYbEPRLVg
X-Google-Smtp-Source: AGHT+IFz53X0C41rcCk5XmswOFreoozjR+mCfK83ojYyPfr6ibBWXlpbWCzbCzkSaNhjhYu6BBHmqw==
X-Received: by 2002:a05:6000:178a:b0:37c:d11f:c591 with SMTP id
 ffacd0b85a97d-38260b5ba0amr8944205f8f.17.1732564773787; 
 Mon, 25 Nov 2024 11:59:33 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:33 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 16/26] hw/arm/virt: Disable DTB randomness for confidential
 VMs
Date: Mon, 25 Nov 2024 19:56:15 +0000
Message-ID: <20241125195626.856992-18-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42f.google.com
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

The dtb-randomness feature, which adds random seeds to the DTB, isn't
really compatible with confidential VMs since it randomizes the Realm
Initial Measurement. Enabling it is not an error, but it prevents
attestation. It also isn't useful to a Realm, which doesn't trust host
input.

Currently the feature is automatically enabled, unless the user disables
it on the command-line. Change it to OnOffAuto, and automatically
disable it for confidential VMs, unless the user explicitly enables it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 docs/system/arm/virt.rst |  9 +++++----
 include/hw/arm/virt.h    |  2 +-
 hw/arm/virt.c            | 41 +++++++++++++++++++++++++---------------
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e67e7f0f7c..c8319555a5 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -176,10 +176,11 @@ dtb-randomness
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
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index aca4f8061b..e5e9f67f52 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -154,7 +154,7 @@ struct VirtMachineState {
     bool virt;
     bool ras;
     bool mte;
-    bool dtb_randomness;
+    OnOffAuto dtb_randomness;
     bool second_ns_uart_present;
     OnOffAuto acpi;
     VirtGICType gic_version;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2d36640733..9836dfbdfb 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -264,6 +264,7 @@ static bool ns_el2_virt_timer_present(void)
 
 static void create_fdt(VirtMachineState *vms)
 {
+    bool dtb_randomness = true;
     MachineState *ms = MACHINE(vms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
     void *fdt = create_device_tree(&vms->fdt_size);
@@ -273,6 +274,16 @@ static void create_fdt(VirtMachineState *vms)
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
@@ -294,13 +305,13 @@ static void create_fdt(VirtMachineState *vms)
 
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
@@ -2570,18 +2581,21 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
     vms->its = value;
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
@@ -3253,16 +3267,16 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                           "Set on/off to enable/disable "
                                           "ITS instantiation");
 
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
 
@@ -3333,9 +3347,6 @@ static void virt_instance_init(Object *obj)
     /* MTE is disabled by default.  */
     vms->mte = false;
 
-    /* Supply kaslr-seed and rng-seed by default */
-    vms->dtb_randomness = true;
-
     vms->irqmap = a15irqmap;
 
     virt_flash_create(vms);
-- 
2.47.0


