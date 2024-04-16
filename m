Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82706C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjHa-0006JW-Ib; Tue, 16 Apr 2024 09:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjGs-0005JP-3B
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:54:54 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjGo-0001y3-Ux
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:54:49 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-516d4d80d00so5428574e87.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713275684; x=1713880484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBppzEDS51MDAVFf+oWkcwnoJzt4m+loPuqdwyia2Jo=;
 b=jVJAIQRet1DAlNCVnKx+S2cu7Ogq7IoSqRO/N+uwUBQzRchLAwXunXSJNFyC25yuq2
 KkiuiBToxogmvyYvLac3G3yQnFJlpBf1Sxc5vfzIDAbjmpK5Lnzra/H3SZQAGO2ot/2T
 hTAZ6Zekzd7jq3lyDaGzai+hED9SpALZykyaVfU7jetACkPGYrGGFikscaZb0QtCj8w3
 Z4qOPTBoCprJZ8FiKCjkECnG1bAJntqi80dAvb30gHI1Urz00asHq1sfHU3tuC9HzQDZ
 kRbbWMWpYzLudJfNBr4PR7q46yp5iFBOLPjk5N+E5vh7KRRmvkqG4re/c2krvkl6aNh5
 wnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275684; x=1713880484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBppzEDS51MDAVFf+oWkcwnoJzt4m+loPuqdwyia2Jo=;
 b=iEL0mCdSmCiDBvv8d0CSlitUl5PmAju9tV5p0NlxfOktmMyke0U7Lxwsk4dwA3WhWS
 Yab711N5kASHJbeyLpTaF4oUIoDhwUj34CrGjxtpawjsREt/leZp58mgsdDPNUH2ThA8
 WII5KiQY49PMcFaEmkIXDfKenFOOQ6Hab5bxXs1U9rpqJFMYXWaFK5UP0o8O7ze6JV6G
 dX+hcw7pINox9Y86MaeiMFMgj1135UpCkdtYAqFOoi6s/Uybr9+UFupmTXH4e54k9+SQ
 kztxOR/Q9B4lR+hTXuAXghB1VOKlcpwDMBADYmWpi88QwxF+hHjViItdp3hZisn5Wl2B
 1LtQ==
X-Gm-Message-State: AOJu0Yy6DM6bbyt3Mr4LZrTocRa+dbOZm94qHcJ0FQ22yu5+j8Q20dH+
 vSjHefwppTFFKatuA7XdYeuoVT1777uGk4CgPCpmf7ZjVeMI2kvOCcZSQxYpSOc3YzIeI6pWXHZ
 f
X-Google-Smtp-Source: AGHT+IE4prILb1Ayzx/lkcnii8L2DztU14FUF9cZPO63UNEquRoPu9ws+lj+UgUmFi026h11f6Wr8g==
X-Received: by 2002:ac2:5e88:0:b0:515:c964:723f with SMTP id
 b8-20020ac25e88000000b00515c964723fmr8230098lfq.20.1713275684153; 
 Tue, 16 Apr 2024 06:54:44 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 hz19-20020a1709072cf300b00a554a1c75cdsm302037ejc.172.2024.04.16.06.54.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 06:54:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 17/22] hw/i386/pc: Remove
 PCMachineClass::resizable_acpi_blob
Date: Tue, 16 Apr 2024 15:52:46 +0200
Message-ID: <20240416135252.8384-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416135252.8384-1-philmd@linaro.org>
References: <20240416135252.8384-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

PCMachineClass::resizable_acpi_blob was only used by the
pc-i440fx-2.2 machine, which got removed. It is now always
true. Remove it, simplifying acpi_build().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/acpi-build.c | 10 ----------
 hw/i386/pc.c         |  1 -
 3 files changed, 14 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index df97df6ca7..10a8ffa0de 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -124,9 +124,6 @@ struct PCMachineClass {
     /* create kvmclock device even when KVM PV features are not exposed */
     bool kvmclock_create_always;
 
-    /* resizable acpi blob compat */
-    bool resizable_acpi_blob;
-
     /*
      * whether the machine type implements broken 32-bit address space bound
      * check for memory.
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index a6f8203460..ab2d4d8dcb 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2688,16 +2688,6 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
      * keep the table size stable for all (max_cpus, max_memory_slots)
      * combinations.
      */
-    /* Make sure we have a buffer in case we need to resize the tables. */
-    if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
-        !pcmc->resizable_acpi_blob) {
-        /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
-        warn_report("ACPI table size %u exceeds %d bytes,"
-                    " migration may not work",
-                    tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
-        error_printf("Try removing CPUs, NUMA nodes, memory slots"
-                     " or PCI bridges.\n");
-    }
     acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
 
     acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 18bef7c85e..c4a7885a3b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1755,7 +1755,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
-    pcmc->resizable_acpi_blob = true;
     x86mc->apic_xrupt_override = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
-- 
2.41.0


