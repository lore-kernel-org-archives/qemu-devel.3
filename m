Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56341C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBgr-00031y-NX; Wed, 29 May 2024 01:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBgb-00026L-IE
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:17:18 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBga-0005UD-0s
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:17:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-357ec504fcdso1172015f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 22:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716959833; x=1717564633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+89nIq6Az7cr57eP5247OlrNJ6UHgv8xML8ZTJQpOfU=;
 b=dpcZhiyTb6IvIoM2yCOpZeaqmp3/rBTQOXSeJ+ZcwtptxvEBVBiUNH47/LOwPO1xIj
 QXMbWi5K4OQVVYqV50URBwONdTAkzeXgm21Yw5Rs+67j7t9b+BkLOFvGCLlhgcVvsS4Z
 KVa+nfg7ydzq1VT7idco6mFwQs/4fH+BtmW1UcxEcZ/iGM2sEqeQG0Q6kNZOQG1NzUsU
 x9YXd6fr8brF6stv0YzDJOk5ByaCfM7rDaVb4RFrrWGLv2oYR6jw4w8L9gjoFKv46o22
 9LkgguagHjaw/MhALF9kmcz4YW0SbIX5qhCwlEZjNNGw3AxjexzruY7jiDtfyE2Ufuni
 MOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716959833; x=1717564633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+89nIq6Az7cr57eP5247OlrNJ6UHgv8xML8ZTJQpOfU=;
 b=ijJU4h1lw7le5EhCv09l+uwjkuu097fqfTuiLf3H36MkrhsJ8LGtK0n7Nv+NwpwB1W
 ppRuT2pxYxkn8pq2fB2dtCcO/3xmpGgzSfGSEN3HIiWTC+TNFU84AhdQ5PVPPdKHf9fU
 Hx5NorVtro3p/o0LhdDmOcxDiFMFzFTQ0CeVzLxiyMeKtzK3Y45ciPAY3BvgWZyQBOa2
 s0olKpfzofg9FyzD3AWhqDDK1MhNsQiiciJj0y4A29vr3rgPPdvqszVRplPEHK1FVsMA
 zLBHbtj+iI9xuZA0vCJ6OBr+EeXGQJR0Jk6U/EWLQddaGfjXFiyWAdZMoI4PO1Z5lQEA
 /g4w==
X-Gm-Message-State: AOJu0YxBSpHQz3XG0mcw7/+0X/p2vbIFEZR2jMzrBratrYKnT3thUfH6
 6VOLlgQXHNOfHaxRuKtV9NSF0e2oHK/+OaN9yS3E336Z96P6uEJPb27WF7YWRuKPd1a5E+o/ihV
 K
X-Google-Smtp-Source: AGHT+IEb9D4CvQ+rKR78oy21rdvdiIq7pR2MaTk5nNpRsrWg5we13zUnEQhpyyhblrx2eKWnPHNahg==
X-Received: by 2002:a5d:6649:0:b0:354:e04d:13e0 with SMTP id
 ffacd0b85a97d-3552fdf23cfmr10446226f8f.46.1716959833412; 
 Tue, 28 May 2024 22:17:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42122299300sm17739485e9.42.2024.05.28.22.17.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 22:17:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 17/23] hw/i386/pc: Remove
 PCMachineClass::resizable_acpi_blob
Date: Wed, 29 May 2024 07:15:33 +0200
Message-ID: <20240529051539.71210-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529051539.71210-1-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 996495985e..808de4eca7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -125,9 +125,6 @@ struct PCMachineClass {
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
index ccfcb92605..fae21f75aa 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1768,7 +1768,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
-    pcmc->resizable_acpi_blob = true;
     x86mc->apic_xrupt_override = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
-- 
2.41.0


