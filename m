Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E50C27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6Y2-00080k-Cd; Mon, 17 Jun 2024 03:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Y0-0007rg-Mz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:13:00 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Xy-0002Qn-Qd
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:13:00 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a6f85f82ffeso85996466b.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608376; x=1719213176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGcfGHDvtroaYyz+NeEr2C8tnUxSYTqOW0jpLqEw7ts=;
 b=X+R2aPmidusnCur9j8KPwn22af2bW3wDLnFXUN3TR2cAxUGuJ7l5k4WoHZ5bu28R7v
 vshSB7UE714nmx5vGqSftmqfGxqMIYA4MLXKSFNgp3u/Ce1zANcmg/VC7k1uiS8tEiFL
 T1+oTI9A4kAQyYYZNFJEwtSEDXDOfv+j2TySslycJFpYWNyyurClswqDBlQIQfTdUTs+
 62GLYdLwchDjMt1XDQQOIHg6p/Qj10y782UXbVJ+oQoeCi08F+PrcSAeyXamURCnm0qx
 ViqxOiTXR1dNTAOXHV8dmU5hiL4sNmdHnc26NjqN13Ge0FfVRNQrxx6PfpHAqLHSU4Sm
 w/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608376; x=1719213176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eGcfGHDvtroaYyz+NeEr2C8tnUxSYTqOW0jpLqEw7ts=;
 b=r2CR3mxZQjF2y5ziwFsCtQvieYTqzSziSrfZIkWarpa+yZhACZ/O79aDFW5tcgMkFS
 QVCYZX3abbQJPG/CralPBMCfyZ2H0Uh04MMvv6ZBI4pTTXpGKMOqUfBQNxLZoXklYD5y
 kwo+Egd/ibeAa6/Uoga+1GaPMQ9+Qe4Ssa+6MuHF/PkDmHxjHWm1J9tV3uCsdqJ3YP3v
 BuFXTCsszS1VzlVU1VApukAXJ3sUYmRQqES1MbggjaWu7fzL2k3YiFc612s3yuyowziY
 Xl7ceg8ooI1xQH4syrb5rJqW/KSvASi3uYBqjK9nTDYsC7fPIQvmE96n3RWJzHt44Inn
 +vLQ==
X-Gm-Message-State: AOJu0Yz9y9oSnJrv2q97LD78ELILwtBDmWNm3ihGLjfxMPF+ZGSi7o3W
 yB0J67byrA8nwWFaEPCQ1ZVg6IxrChqWeNOjTtc7ojAhBG2OuTG0wiscOipDZZjoeF3RwKCTUC8
 shP0=
X-Google-Smtp-Source: AGHT+IHcDXYu46bFL6JGRCnTxIpQxbkMYaHSwt82MauMVVYk8aHDGbwFMzAIMINEuDLcmVaTr3flMA==
X-Received: by 2002:a17:906:bf45:b0:a6f:7826:41ea with SMTP id
 a640c23a62f3a-a6f78264e1amr399158066b.39.1718608376562; 
 Mon, 17 Jun 2024 00:12:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da32c3sm493440566b.13.2024.06.17.00.12.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:12:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 17/23] hw/i386/pc: Remove
 PCMachineClass::resizable_acpi_blob
Date: Mon, 17 Jun 2024 09:11:12 +0200
Message-ID: <20240617071118.60464-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/acpi-build.c | 10 ----------
 hw/i386/pc.c         |  1 -
 3 files changed, 14 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 155a02b1b5..d01ddc4618 100644
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
index f5d74e2b4b..eafc3761c8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2687,16 +2687,6 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
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
index 21a9b7a5ae..a6d50df500 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1774,7 +1774,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
-    pcmc->resizable_acpi_blob = true;
     x86mc->apic_xrupt_override = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
-- 
2.41.0


