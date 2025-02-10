Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF1AC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thadj-0003Vf-Q0; Mon, 10 Feb 2025 15:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadf-00035D-B1
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:19 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadd-0003sf-Br
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:19 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43934d6b155so13690655e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220255; x=1739825055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwm1ZkyQbCKYEL7sQcfI0amiIz6D6N+OhtZTgkExnsw=;
 b=WHuRt/xZ+SKNK3MJigOap6ZgXNx6Jbyh+fzhFmb5zMUsW0o7YYYAHMC32ar1ykvARd
 QxMntnCnZbsgvKirtkfKR5XZphi4GhUKZOiB/A8eRlIh0LhwBBRzzU8mGeEhBcFZ3Kn+
 DpMWPft8N8poAkFgtkszqkKtqWBjXKF00oumNs5pR+hzWiHuuWpgMAd8YaYBykFscVAf
 6XyREEgTnWGMzELjHLaTFydlCvpRz8zGiIw7w37KdlRHY5ujam5M/DtEptfYWCGyuoHW
 UrI5BnC/mi4NWb3+qw2+32Miv6hzBX/YJNQS65FjkQERjLckGziP6KAiiVsIdeUCvTm0
 3oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220255; x=1739825055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwm1ZkyQbCKYEL7sQcfI0amiIz6D6N+OhtZTgkExnsw=;
 b=tWQPUPxswvgHmyaNSFfZ/1ayoZ0/z6IV6kKP01RcMFxRBaotXuMP1qWnZkBCCMozt2
 vqBIkT6DSisnBqMqQ0+JFOr0DcSqsPob5xx09i8jqwGs3UyTLzYbaKGLcSTtxrAAzlxL
 mh23d08qSb2wrQc6bBkc0V5XEkSAnjj1OM6A758twSbbabQsODLPZnQ9pbGo9mwqZDlr
 IFZc7wemR37LVgLXKeIejE4YMZqK3KsgrGhy9YavtY/z+yqNMB/Y7dAdKhlGGUfL5eFE
 RuT5GMDVH/cr/IMykKr8bNqpEGM2//hq41TSDQM4T8aRmNilOOKbKdefkr4+Z8XbcMdU
 Qw9w==
X-Gm-Message-State: AOJu0YwNCwoJxU79zssQqOSqAXGD45eLEkkc76tRM/UMA+TyBFPkBRVE
 hpIFJuDj9UFuf6C9aIaIOPBbboZWPjSKBG2tNtliaSsL1HcUYNb/6UimvXs4nsL4obk3eAvPGK7
 AcVw=
X-Gm-Gg: ASbGncvzSDfnUVKGMcsFSpHt00DTWWPFisw/6eBEjE2XGUbSLA1Ci0EI7MqsWLT+yzs
 Lj5h2EHtlUOPnoEh24iz93LULfrnV46iLUwAEXpeLmfEYy/j5Sh592vZMlyzyRsL3IgRd84yz2S
 KqFP7eVqmQkZuSkm+WcPikPuiRhtvS2VKsRCt8JzpNj7NIuyfTzgwFbJb+16RAdBcrFt6jwPIvK
 s/w5hVKFJF6nkUVYAsaCS4taNNtMYyZSxcoIo/6nEUdFleziLAhlAmVLH+Pfgt3WoNnqQaIeJ4N
 /TgYOlNTzFL4zqzvWmeGefNL80DIfxensiHqtcfvTvtoMPFMxhYvu5AAc7pCGFnVdw==
X-Google-Smtp-Source: AGHT+IEW00f5NXPMEah0IyXqUYIaAbaLYFMThNpjvOjtZexVfFL2TAoAzUOKUs/LcmU274Q3fJNctQ==
X-Received: by 2002:a05:600c:1c85:b0:434:ea1a:e30c with SMTP id
 5b1f17b1804b1-4394cf08108mr6697495e9.13.1739220255360; 
 Mon, 10 Feb 2025 12:44:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4394127afcbsm53217585e9.23.2025.02.10.12.44.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:44:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 25/32] hw/riscv: Remove all invalid uses of
 auto_create_sdcard=true
Date: Mon, 10 Feb 2025 21:41:57 +0100
Message-ID: <20250210204204.54407-26-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

MachineClass::auto_create_sdcard is only useful to automatically
create a SD card, attach a IF_SD block drive to it and plug the
card onto a SD bus. None of the RISCV machines modified by this
commit try to use the IF_SD interface.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250204200934.65279-7-philmd@linaro.org>
---
 hw/riscv/opentitan.c | 1 -
 hw/riscv/shakti_c.c  | 1 -
 hw/riscv/sifive_e.c  | 1 -
 hw/riscv/spike.c     | 1 -
 hw/riscv/virt.c      | 1 -
 5 files changed, 5 deletions(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index d78a96c5354..b9e56235d87 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -121,7 +121,6 @@ static void opentitan_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_IBEX;
     mc->default_ram_id = "riscv.lowrisc.ibex.ram";
     mc->default_ram_size = ibex_memmap[IBEX_DEV_RAM].size;
-    mc->auto_create_sdcard = true;
 }
 
 static void lowrisc_ibex_soc_init(Object *obj)
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index efe814b5868..e2242b97d0c 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -84,7 +84,6 @@ static void shakti_c_machine_class_init(ObjectClass *klass, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_SHAKTI_C;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "riscv.shakti.c.ram";
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo shakti_c_machine_type_info = {
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 164eb3ab83b..73d3b74281c 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -153,7 +153,6 @@ static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = SIFIVE_E_CPU;
     mc->default_ram_id = "riscv.sifive.e.ram";
     mc->default_ram_size = sifive_e_memmap[SIFIVE_E_DEV_DTIM].size;
-    mc->auto_create_sdcard = true;
 
     object_class_property_add_bool(oc, "revb", sifive_e_machine_get_revb,
                                    sifive_e_machine_set_revb);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 1ea35937e15..74a20016f14 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -358,7 +358,6 @@ static void spike_machine_class_init(ObjectClass *oc, void *data)
     /* platform instead of architectural choice */
     mc->cpu_cluster_has_numa_boundary = true;
     mc->default_ram_id = "riscv.spike.ram";
-    mc->auto_create_sdcard = true;
     object_class_property_add_str(oc, "signature", NULL, spike_set_signature);
     object_class_property_set_description(oc, "signature",
                                           "File to write ACT test signature");
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2aa420f6e55..241389d72f8 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1918,7 +1918,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
-    mc->auto_create_sdcard = true;
     mc->pci_allow_0_address = true;
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
-- 
2.47.1


