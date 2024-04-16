Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27C4C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo3O-0001Zl-MJ; Tue, 16 Apr 2024 15:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo37-0001Cw-DN
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:00:59 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo31-0005fx-Qn
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:00:56 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-516cbf3fd3dso5982707e87.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294049; x=1713898849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cSOUYBAUJgDyQn/Z100iE3+Sgt5Cj+78hNwZltzxNs=;
 b=WWc+gDkXmB/FHCwWPSOUAQP2rx4wMRhKrR+82tLpnhncn5GGnheWvS5Sssb+PbvF7i
 lUaaKTW9l/qSu+S//u4d4hQXZRVamzTdabW9e2D11p9bR2upz7RAe+s7In+B2F8eyI6K
 Ca2kqlBPpFRsPRmPE3RZKEkCzvdDNnXK+l8QjJH0Fp12koXAHtViY+kaQGMSVk4AWvWs
 e51l1hqx4apYZnGhEGZTsBCfSYZezI1rf5UgE273Mq0FWCm/imH928mU5iNN3wggz2fz
 oMGcVgyjWKXvuvYu62teqWhEDgFqxXMB8mg/ZEuVJOL4t7oLEITpEsiB7T+U8YlP06CO
 ybPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294049; x=1713898849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cSOUYBAUJgDyQn/Z100iE3+Sgt5Cj+78hNwZltzxNs=;
 b=oiCdjJ5PMlENXCbSZkF9q8toCQ95xG8DZF1MTA6hju/v1z5xr+0vTwn/YKrJMxD1kX
 zdtb5ZHUfZbnIlhSBP8XbZdCJewba57QfIvNqYHwihTLMwxlCz7bWyot8b6Q7cy+8Om2
 f59m9IPxkBS/uPsDyLoNh3a7ctqcroLARj9hMzqh+3LGAB+oz1unNnOlxVR7c3KyoLL9
 6dS3jOpDbxjhuexio/aeOoNjIAmhmhpLAuUyF2mD0pLZfd9i8x97+RB0hvfiOq4ST7Ev
 LVlzdd4FDNwKfAr3TgOUic+nlHV9ZxEtYLvdJbfyaxKvhhkOpamytwdZX6KotE8tXn0B
 pf4Q==
X-Gm-Message-State: AOJu0Yzmm0VoCRAMU9aNO8+BmteKRPMsywj/3ADPnzE8OcyOMDcU12RP
 Se+6F9r84LXOxarCBJreYyN6aQZtYah2ugns9UIAOL8fLQ+T9EiBD472YkgH9scL/n1i0ChAlxc
 u
X-Google-Smtp-Source: AGHT+IHGTBCSVJo2t7yAUY9UWwABae+zuiW472THcqCnHvQ3bUekN+LNwbNpJnex0bMnOpxnGv/ltw==
X-Received: by 2002:a05:6512:3c9e:b0:517:866a:117e with SMTP id
 h30-20020a0565123c9e00b00517866a117emr12821425lfv.7.1713294049051; 
 Tue, 16 Apr 2024 12:00:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 du2-20020a17090772c200b00a52299d8eecsm6710577ejc.135.2024.04.16.12.00.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 12:00:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 10/22] hw/i386/pc: Remove
 PCMachineClass::smbios_uuid_encoded
Date: Tue, 16 Apr 2024 20:59:26 +0200
Message-ID: <20240416185939.37984-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

PCMachineClass::smbios_uuid_encoded was only used by the
pc-i440fx-2.1 machine, which got removed. It is now always
true, remove it.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/i386/pc.h | 1 -
 hw/i386/fw_cfg.c     | 3 +--
 hw/i386/pc.c         | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index b528f17904..c2d9af36b2 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -109,7 +109,6 @@ struct PCMachineClass {
     /* SMBIOS compat: */
     bool smbios_defaults;
     bool smbios_legacy_mode;
-    bool smbios_uuid_encoded;
     SmbiosEntryPointType default_smbios_ep_type;
 
     /* RAM / address space compat: */
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index d802d2787f..f7c2501161 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -63,8 +63,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
 
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
-        smbios_set_defaults("QEMU", mc->desc, mc->name,
-                            pcmc->smbios_uuid_encoded);
+        smbios_set_defaults("QEMU", mc->desc, mc->name, true);
     }
 
     /* tell smbios about cpuid version and features */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index cd6335d6b4..2bf1bfd5b2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1778,7 +1778,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->has_acpi_build = true;
     pcmc->rsdp_in_ram = true;
     pcmc->smbios_defaults = true;
-    pcmc->smbios_uuid_encoded = true;
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
     pcmc->enforce_aligned_dimm = true;
-- 
2.41.0


