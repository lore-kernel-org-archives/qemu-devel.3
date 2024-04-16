Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A85BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjGJ-0002pJ-Ur; Tue, 16 Apr 2024 09:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjG8-0002YN-9o
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:54:04 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjG5-0001pu-F7
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:54:04 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-570423c4f80so973934a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713275639; x=1713880439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cSOUYBAUJgDyQn/Z100iE3+Sgt5Cj+78hNwZltzxNs=;
 b=nT5CS1DcP8cMCSi8W4vlxRzaBmQtfKzCdcxNWIJbr14tMBZ1NeZNuX3wJTici29BlL
 qNrKaQJsrJkJK2P52LuyRZTr/Tr+RqMgaqsLmxc16X4ORblhEnDt4jOC/wjbX7GZjRpE
 7NtPS2zk4qALXtQobT/HIY8JC1RsqTZ0vOAXavpofJts2w3yURdVwoYIEg9cYpyMCUof
 3COEyMuGRZcutBroa2EkV51FCh70b7VO+yaJcEmKIzMT1BMgOZiUzD1l2O35c5nqgoZH
 VoaEtNiIliA5O3jlJcwBNewG0PSXlV7S49K1BEsoY9Ezr8gubAoxhWaM5pNmBhfwMz8b
 9nSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275639; x=1713880439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cSOUYBAUJgDyQn/Z100iE3+Sgt5Cj+78hNwZltzxNs=;
 b=Kw3dGnP6oOfsPxfNjw54xeOYHl+cwHvwuBZTm1T65VrSA3SliOLTrJyX+FXSxjxky/
 l8Cs+jzfg29xn22nc6A0aXe7LpmAhFwUqbGJFe1tbDWz1oHC3SCVlJsWXVM5DC+HK0iW
 fkr8MmWuSvDFJBvyseASN4KC7SXMaPM9ZiAg92porwdSBijM03oGfN01X3xe53CxlCfC
 EDLVQLR1/3lpTPoHGn78pg9Wu3OzqgKN7iVOfkIdk4zKBAElx/1w32Jz0V3H/y6Xta4v
 4owwjgm8QmDgWIm+DFZorgGtr+F/le/RqbJ5FvZ0Q2O8sDlS5Adkg3ofoy6pzN+Zzzjf
 I0Hw==
X-Gm-Message-State: AOJu0YwJdazt05rhs+Ew+KxpSmssvddHDuK4GWNe04R47BvY2D9rj1Ae
 BvvjrXO4wgWOvTjZG1lO7DARlWessG4SOUPbiow0WybPNF2xz6r11pJhiorTGSsilMqyY5MvAKt
 U
X-Google-Smtp-Source: AGHT+IH25qpXTodrDyAR9/gxikoinWnTP0zcJbrjsTK89otp6pxL4CKwj5mWVB7RUHKX+qhqsQivEQ==
X-Received: by 2002:a17:906:689:b0:a52:613d:e49e with SMTP id
 u9-20020a170906068900b00a52613de49emr4621712ejb.36.1713275639502; 
 Tue, 16 Apr 2024 06:53:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 bv1-20020a170906b1c100b00a522cd687aesm6303312ejb.142.2024.04.16.06.53.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 06:53:58 -0700 (PDT)
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
Subject: [PATCH v3 10/22] hw/i386/pc: Remove
 PCMachineClass::smbios_uuid_encoded
Date: Tue, 16 Apr 2024 15:52:39 +0200
Message-ID: <20240416135252.8384-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416135252.8384-1-philmd@linaro.org>
References: <20240416135252.8384-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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


