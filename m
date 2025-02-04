Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DE9C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 00:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf6jE-0000ep-Id; Mon, 03 Feb 2025 19:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6j2-0000Q3-6f
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:37 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6iy-00075x-Qa
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:35 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso58290005e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 16:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738628611; x=1739233411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pIv2DBodYYA0dRZkz56J6dhWz5LDF9EMp1+oiy+F/vk=;
 b=iQEkpkLUfGOwQ0mNlpZyUhmr3iT3iHZ78XK987RxNiC6EVk4Y5NDkA0mKxj1a/DRm8
 7ea5837C2AMOddf+DsKT2NvZqDhI8fnWdl6k/K8Vhye6LYZBaqtbHO8SKFlacsGsUZJZ
 RonXuvnHR0TR9tFW9F4Fum5eiWsfuv+5Vg79PecKGddF28qmpWmFAIBDvvSiirWx2Pqx
 WD/NrZ+R6LjBWb4xZAxNrQPaEEF3ilxysHID7O3SBj+RxLY7X9M0uQymP1Ye9Rt2S9b3
 i0X9TfFcrY0zUUsA5FpKpA01vr3MJ9syyqWFwP+PScsp7j33NN0x6gSjC85paWCGCV04
 TM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738628611; x=1739233411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pIv2DBodYYA0dRZkz56J6dhWz5LDF9EMp1+oiy+F/vk=;
 b=M+4YyrHzulpeeVSGuIkV4YkaoPqw0PeAxTQfnSMkBJpLQ5tQQGZ3F1chwKPIsgTCZH
 is4dfe5TuRYGCBXgtQnndZXgdoh14/IpetmdHCr8zG7Z2/YojYlfp8aYSq+S/aioatm2
 MNyndur3ClckBtHkgct2GLjFfIc5WoW3uZZ3bGQufMAXATqu9bdXIxJgFb1/r8EuoRW9
 BKPjxVyqb4obK7VG6/umJ/FNUijHXOEg1h9NJjMCqPDVQWCEopbrCXRJ/rL88WTw3433
 wqmFMaXFAVdTOa2SLOF0UTfIXI+niHT3QlhfBHJeI14urADnP+5UvKp/vJF7Aua7MsBA
 1f4Q==
X-Gm-Message-State: AOJu0YzQX3kjFKue5mfi6Y7GyNE1rcqS61sjJuiZWaA08Lmu7CSkMFjf
 KC3Yf8jEfj1gmaeu3bkloshrOYk7zRR+kqZrGQ9/3M/xRAcQe0YNhFgMAhkLs5shGQ6p6CltM3S
 +B4g=
X-Gm-Gg: ASbGncuM1ISgyz3uIUaOfoTLZzy+4DTg+vGQ0K8AEN96rOQpXDh3ewvZHWHyfTGD+NE
 Pkm2KBZu4+KR2jL9IxV2KyEHGQ+r4zJzC8JTIg71mi1Baw/jfFSb+zhB5LTUxuyLZAfR+bt1kcP
 dcjMj5LeosCMBIaq/P9eOQIeOlMb0mgH2ajC+aC62Xln3senNmAJcwh+kGD4lFmAceO5oJb4NLS
 mjt6BdC1DP+bFcqJahtJ+Vfsb7BGaVK29fwusVBQkHqCxbeO1+hB+Z2FqADlQhaYKLg/kdkRrPk
 ENIxrcp3ScOG51gzxZAiQ5tBxx3u1vX4pOi2D9lBhXc6T4ktOtlTFCyyt+PfGG5qyw==
X-Google-Smtp-Source: AGHT+IFOUPAuBUePYklyiQuwsGTbYNQ+OFZucNwNkREnXsqpf8qQTNiP7f8PImZO9S8kkCWx2U14VA==
X-Received: by 2002:a05:600c:1ca3:b0:438:a240:c55 with SMTP id
 5b1f17b1804b1-438e70d1b20mr112546225e9.1.1738628611126; 
 Mon, 03 Feb 2025 16:23:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc12f88sm206385815e9.2.2025.02.03.16.23.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Feb 2025 16:23:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: [PATCH v2 08/12] hw/arm/raspi: Introduce generic Raspberry Pi machine
Date: Tue,  4 Feb 2025 01:22:36 +0100
Message-ID: <20250204002240.97830-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204002240.97830-1-philmd@linaro.org>
References: <20250204002240.97830-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The generic 'raspi' machine takes a 'model' argument and
create the machine associated with the model, with the
RAM size requested (or default to the minimum of 256MB
if not precised).

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2797
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/raspi_platform.h |   3 +-
 hw/arm/raspi.c                  | 127 ++++++++++++++++++++++++++++----
 2 files changed, 115 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index defb786153b..14cb91e153c 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -41,7 +41,8 @@ OBJECT_DECLARE_TYPE(RaspiBaseMachineState, RaspiBaseMachineClass,
 struct RaspiBaseMachineState {
     /*< private >*/
     MachineState parent_obj;
-    /*< public >*/
+
+    uint32_t board_rev;
     struct arm_boot_info binfo;
 };
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index d44277001ee..1dc41701efe 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -300,20 +300,6 @@ void raspi_base_machine_init(MachineState *machine,
     BlockBackend *blk;
     BusState *bus;
     DeviceState *carddev;
-    uint64_t max_ramsize;
-
-    if (machine->ram_size != ram_size) {
-        char *size_str = size_to_str(ram_size);
-        error_report("Invalid RAM size, should be %s", size_str);
-        g_free(size_str);
-        exit(1);
-    }
-    max_ramsize = ramsize_max(board_rev);
-    if (ram_size > max_ramsize) {
-        g_autofree char *max_ramsize_str = size_to_str(max_ramsize);
-        error_report("At most %s of RAM can be used", max_ramsize_str);
-         exit(1);
-    }
 
     /* FIXME: Remove when we have custom CPU address space support */
     memory_region_add_subregion_overlap(get_system_memory(), 0,
@@ -448,6 +434,115 @@ void raspi_machine_init(MachineState *machine)
     raspi_base_machine_init(machine, BCM283X_BASE(soc), mc->board_rev);
 }
 
+static void raspi_generic_machine_init(MachineState *ms)
+{
+    RaspiMachineState *s = RASPI_MACHINE(ms);
+    RaspiBaseMachineState *s_base = RASPI_BASE_MACHINE(ms);
+    uint32_t board_rev = s_base->board_rev;
+    const char *soc_type = board_soc_type(board_rev);
+    BCM283XBaseState *bsoc;
+    uint64_t ram_size;
+    uint64_t max_ramsize;
+
+    if (!board_rev) {
+        error_report("Missing model");
+        exit(1);
+    }
+
+    ram_size = ROUND_UP(ms->ram_size, 256 * MiB);
+    if (ram_size != ms->ram_size) {
+        g_autofree char *ram_size_str = size_to_str(ms->ram_size);
+        g_autofree char *rounded_size_str = size_to_str(ram_size);
+        warn_report("Invalid RAM size %s, rounding to %s",
+                    ram_size_str, rounded_size_str);
+    }
+    max_ramsize = ramsize_max(board_rev);
+    if (ram_size > max_ramsize) {
+        g_autofree char *max_ramsize_str = size_to_str(max_ramsize);
+        error_report("At most %s of RAM can be used with BCM%s",
+                     max_ramsize_str, soc_type + 3);
+        exit(1);
+    }
+    board_rev = FIELD_DP32(board_rev, REV_CODE, MEMORY_SIZE,
+                           ctz64(ms->ram_size) - 28);
+
+    ms->ram = g_new(MemoryRegion, 1);
+    memory_region_init(ms->ram, OBJECT(ms), "DRAM", ram_size);
+
+    if (board_processor_id(board_rev) == PROCESSOR_ID_BCM2838) {
+        BCM2838State *soc = &s->soc4;
+        bsoc = BCM283X_BASE(soc);
+        object_initialize_child(OBJECT(ms), "soc", soc, soc_type);
+    } else {
+        BCM283XState *soc = &s->soc;
+        bsoc = BCM283X_BASE(soc);
+        object_initialize_child(OBJECT(ms), "soc", soc, soc_type);
+    }
+    raspi_base_machine_init(ms, bsoc, board_rev);
+}
+
+static void raspi_update_board_rev(RaspiBaseMachineState *s)
+{
+    MachineState *ms = MACHINE(s);
+    RaspiProcessorId proc;
+    unsigned model_index;
+
+    s->board_rev = FIELD_DP32(s->board_rev, REV_CODE, STYLE, 1);
+
+    model_index = FIELD_EX32(s->board_rev, REV_CODE, TYPE);
+    proc = types[model_index].proc_id;
+    s->board_rev = FIELD_DP32(s->board_rev, REV_CODE, PROCESSOR, proc);
+
+    ms->smp.max_cpus = soc_property[proc].cores_count;
+}
+
+static void raspi_set_machine_model(Object *obj, const char *value, Error **errp)
+{
+    for (unsigned i = 0; i < ARRAY_SIZE(types); i++) {
+        if (types[i].model && !strcmp(value, types[i].model)) {
+            RaspiBaseMachineState *s = RASPI_BASE_MACHINE(obj);
+
+            s->board_rev = FIELD_DP32(s->board_rev, REV_CODE, TYPE, i);
+
+            return raspi_update_board_rev(s);
+        }
+    }
+    error_setg(errp, "Invalid model");
+}
+
+static char *raspi_get_machine_model(Object *obj, Error **errp)
+{
+    RaspiBaseMachineState *s = RASPI_BASE_MACHINE(obj);
+
+    return g_strdup(types[FIELD_EX32(s->board_rev, REV_CODE, TYPE)].model);
+}
+
+static void raspi_generic_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+
+    rmc->board_rev = FIELD_DP32(0, REV_CODE, STYLE, 1);
+
+    mc->desc = "Raspberry Pi";
+    mc->block_default_type = IF_SD;
+    mc->no_parallel = 1;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->default_cpus = 1;
+    mc->min_cpus = 1;
+    mc->max_cpus = 4;
+    mc->default_ram_size = 0;
+    mc->default_ram_id = "DRAM";
+    mc->init = raspi_generic_machine_init;
+
+    object_class_property_add_str(oc, "model",
+                                  raspi_get_machine_model,
+                                  raspi_set_machine_model);
+    object_class_property_set_description(oc, "model", "Set machine model.");
+};
+
+
 void raspi_machine_class_common_init(MachineClass *mc,
                                      uint32_t board_rev)
 {
@@ -533,6 +628,10 @@ static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo raspi_machine_types[] = {
     {
+        .name           = MACHINE_TYPE_NAME("raspi"),
+        .parent         = TYPE_RASPI_MACHINE,
+        .class_init     = raspi_generic_machine_class_init,
+    }, {
         .name           = MACHINE_TYPE_NAME("raspi0"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi0_machine_class_init,
-- 
2.47.1


