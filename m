Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6136DC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL9U-0004Yn-R7; Mon, 31 Mar 2025 15:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL9C-0003x8-9W
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:50:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL9A-0003gG-3J
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:50:13 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso2743410f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450610; x=1744055410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mW/LOTnTsMj5waRnbyiJBrlUqbYcaju/dZQD/CeCa/g=;
 b=clZSFJErFAdBWW9/eCcdY+8/CLu3NqTUUlAPTkyTDqCo1n8h/TbPFinrw6uVkODL4M
 g+/Cb049zt0J1DHNJ2YuVcdOqzAiDYd+Y+B8WEmn0vbjDR8CKBD+2RbphxOqSSno1Ebm
 9ycNRwOaoOT9AMjYysE4vY3k7pR37RI8b/XORpSHD+Qo/pNSHkDvi6TZzTKUkzik9BDD
 YJhTi3IbDfIEKlgyNmvF+0nC8J01JHvrB9fRTRbpkkIBNoXp2BbwzxTBLLUECTW5Dp41
 2PunXrENL/VTx1kSGs9qD10UaUGK3HKfZihs+Z1F3y49Wm0JN9Sq9lsrU9aUUkfEJamz
 wDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450610; x=1744055410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mW/LOTnTsMj5waRnbyiJBrlUqbYcaju/dZQD/CeCa/g=;
 b=oV+wX0g+GGslHQPi3np5QduUO8I8+vCMUg/zPV1ch45eKgOGCT5JpQfRp/3D1IDmUY
 DSrZdP4v5azO+z+LPHZkELBSkew5i8JwEVbjU2i/HWo4JlWTMM3GuASFxpbkpseoJMVl
 5pHMUPIT2ZRxyUH6NQxRYWivXpUKhPszeWoHNvYKPh5mslOoJCqwfoJWW4TMUA+D2qSi
 O3bNoAdiZSyCZg92MFDZ/22rGuBz3f/SxjaL0AacAb+qbjoq5DopTW04APyecsy0eim9
 lK2g1k1M0/NhQ9MryhLCWkpsa3s7JpoBiU1sZoZrcm2ex9VgyNJImd72OcQbiFanqmcr
 rNnw==
X-Gm-Message-State: AOJu0Yx2XpxsZT6RjELTYn5CRBREv2eMcVDvk0Gz/9MQrPvKqrwbyaSm
 F4UBpNGGzcFHNkY7fNluFUaq+W6byuyWB+NpQVroDaMgLKNhiCdZPvjOqxB+uLIXSaVnoiAIVJ1
 A
X-Gm-Gg: ASbGncuFg0OlUGiP7RFSsKWK0i49wbLhy17xcpe99z3fbNkyV/K8nxaams0xky2Epkh
 jclRNMRKiVlhuqaNghj4VKnJ+Dg6p8q71h6o6SUNXesoGEmQHkJphu77d+3bVLtDubAxfrpj4FV
 M9rIo7csMZZpB6KBcGa6ZjgNuKwvDAS/Gxo+Swu9q6Y8dfYBXnokJgZecVY+gM8fSUFa7mQ/gha
 81a/pyXy+a+PVHqG3u9YpyZqw1A43XPQ5m7HbbxqeUc2uGZ6sPBOG08edg34iJdgAzRKpAunwfW
 6XhjXs/OB9qcKRhhf2eyqrfnnrmgkSe4nVjCQnx4LWFHjiA9K2G9BImh/8ubzoxDhIZMGjNK1Sq
 R+OINAO1eXsNW++2/WRE=
X-Google-Smtp-Source: AGHT+IFGjfflTjCvFw3S4vyuY6vdqcZEeyfkAOBgkSIoUGphtDRNkkKMf5XwifT29+IA1MGP/b6gKQ==
X-Received: by 2002:a05:6000:2913:b0:39c:e14:cd70 with SMTP id
 ffacd0b85a97d-39c12115d6fmr8695093f8f.34.1743450610081; 
 Mon, 31 Mar 2025 12:50:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4239sm12269696f8f.94.2025.03.31.12.50.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:50:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/23] target/mips: Revert TARGET_PAGE_BITS_VARY
Date: Mon, 31 Mar 2025 21:48:19 +0200
Message-ID: <20250331194822.77309-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Revert ee3863b9d41 and a08d60bc6c2b.  The logic behind changing
the system page size because of what the Loongson kernel "prefers"
is flawed.

In the Loongson-2E manual, section 5.5, it is clear that the cpu
supports a 4k page size (along with many others).  Similarly for
the Loongson-3 series CPUs, the 4k page size is mentioned in the
section 7.7 (PageMask Register).  Therefore we must continue to
support a 4k page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250328175526.368121-2-richard.henderson@linaro.org>
[PMD: Mention Loongson-3 series CPUs]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu-param.h             | 5 -----
 hw/mips/fuloong2e.c                 | 1 -
 hw/mips/loongson3_virt.c            | 1 -
 target/mips/tcg/system/cp0_helper.c | 7 +------
 target/mips/tcg/system/tlb_helper.c | 2 +-
 5 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 11b3ac0ac63..8fcb1b4f5f2 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -18,12 +18,7 @@
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 #endif
-#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 12
-#else
-#define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 12
-#endif
 
 #define TCG_GUEST_DEFAULT_MO (0)
 
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 646044e2749..2a8507b8b0a 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -334,7 +334,6 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fuloong2e.ram";
-    mc->minimum_page_bits = 14;
     machine_add_audiodev_property(mc);
 }
 
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index db1cc513147..1da20dccec4 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -677,7 +677,6 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = LOONGSON_MAX_VCPUS;
     mc->default_ram_id = "loongson3.highram";
     mc->default_ram_size = 1600 * MiB;
-    mc->minimum_page_bits = 14;
     mc->default_nic = "virtio-net-pci";
 }
 
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 01a07a169f6..8c2114c58a6 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -877,18 +877,13 @@ void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
     if ((mask >> maskbits) != 0) {
         goto invalid;
     }
-    /* We don't support VTLB entry smaller than target page */
-    if ((maskbits + TARGET_PAGE_BITS_MIN) < TARGET_PAGE_BITS) {
-        goto invalid;
-    }
     env->CP0_PageMask = mask << CP0PM_MASK;
 
     return;
 
 invalid:
     /* When invalid, set to default target page size. */
-    mask = (~TARGET_PAGE_MASK >> TARGET_PAGE_BITS_MIN);
-    env->CP0_PageMask = mask << CP0PM_MASK;
+    env->CP0_PageMask = 0;
 }
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index ca4d6b27bc9..123639fa18e 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -875,7 +875,7 @@ refill:
             break;
         }
     }
-    pw_pagemask = m >> TARGET_PAGE_BITS_MIN;
+    pw_pagemask = m >> TARGET_PAGE_BITS;
     update_pagemask(env, pw_pagemask << CP0PM_MASK, &pw_pagemask);
     pw_entryhi = (address & ~0x1fff) | (env->CP0_EntryHi & 0xFF);
     {
-- 
2.47.1


