Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56763C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDuX-0005JV-J5; Fri, 11 Jul 2025 09:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtu-0004RB-Ft
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDts-00035N-7V
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-453647147c6so19098085e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240891; x=1752845691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pbjg9RvDfbdG6d500Oq0/a5SPdDZ16+NUzBBz9QOEEg=;
 b=X/7C/NmglnHTpnRS3y8SEBmJ5NTGnB36kRa7o40NFO7TFXeR3qj3UuHhQ1LqU55tcs
 Q612o+rbIIPBgkx/BU4ZU7yOntMKvWRPDhfKcMt3nYNVGzPbNN+8MT+WHkWBFgUMKTsE
 uwx3eBvZnGyaFcyEZUOTlLB87UYscASgsqrG3bKDR6bxxJLYtoIIQ8Tntgk8LFqefJBO
 4U/1kMpHN6aW9iXl/unLZDCAXzJKGpO1UZgxZYTUUDIWkaWeAUZsN3VnDib4OJNOKVgP
 VKR12oHA7YJKvpN9hEtJGl/OTKdmRW2LzoW/SlWDkZPaWo3/zysL9+Al7UrIQDT7gWpc
 YGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240891; x=1752845691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbjg9RvDfbdG6d500Oq0/a5SPdDZ16+NUzBBz9QOEEg=;
 b=VMwbUdYtthmsRGXNnz8q8e3rXqbdlndky3xyCV7323lYOngIqN/Gm2yPGwaZ70CgJJ
 8TbJ4AIRUbwvwSN2azsVwBn0Z/9IggQtpSNHkGHLm/rh8T30R4LB3VIXHe9e4zo/DOBU
 hqYFHopkdysl338sgGWBa1xJUyHoAXNq9PaeB1NjtKgNQygE+FcYpI0xG5aUZY4mSbgJ
 KCm3FC0NHig6Li4OhEC4WAMs72olem3STrYbo1rvSmRxOK3R81FevijJbIohLqbJ4gRn
 tT9x4DsRhNlESdTTx7V2v4U5APZMooN2tG05mdPztpHVdfqF74SoDXF2htapWIHAEcn1
 iMqQ==
X-Gm-Message-State: AOJu0Yw0xokg6QfEB8BxinAfXoCTwvfVpc5V3lhFa0mT/kRoDEl6wklO
 ec0gAcP3Kfy+HwoAQL9y/fkNKDaQTZDn99t90zxqEC8JIRwtxFs69Kw7hXTjWniWgEyvJGuRk2S
 R2BZ0
X-Gm-Gg: ASbGncv0mfPTrYKci0q6eqDI2X8/79W7hVVq9UiMFS4nur9c6NHhOziYh0HndYjPuLs
 gGJWV7U/Q0UDxcyN45aqe/vYNBFfwLyA7n11gQ4dM1wI1Ggc+y/NFEcjeDHNITtUD9Zk6lQUiAS
 0R0wHKHVRoXeE9PHHREk2zadyjZsD29HV+njaCVtQXzqnpfPRaahpJ7euejWZLqgtHouko1uGn2
 XE1P/RENDDWh2ajtNXgyDJKFxgqSUa4TwLaG8tMyEfdrIo29R1I1NE3eKTCSBTx+zt2xxBLAgmu
 xOcQpQzFqVSwZfSVp9xv9ulGoECint9mFl/3nLF1G1dkFTvh9vBhpYM//PW+zVTSvifybKx84P9
 kCPdcQrt1ipZbBSlNDrNGXZEwxduJ
X-Google-Smtp-Source: AGHT+IHv3x8qLBs9lv511hYGEUMvfHkuVCjiV3SxFDca1cQAxy0u8wFIX9Vf0BO9bLN3QrULRQbu2A==
X-Received: by 2002:a05:600c:1c95:b0:451:833f:483c with SMTP id
 5b1f17b1804b1-454ec133982mr33710275e9.7.1752240890546; 
 Fri, 11 Jul 2025 06:34:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/36] arm/cpu: store id_aa64afr{0,1} into the idregs array
Date: Fri, 11 Jul 2025 14:34:11 +0100
Message-ID: <20250711133429.1423030-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Cornelia Huck <cohuck@redhat.com>

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20250704141927.38963-3-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  2 --
 target/arm/cpu-sysregs.h.inc |  2 ++
 target/arm/helper.c          |  4 ++--
 target/arm/tcg/cpu64.c       | 16 ++++++++--------
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 835700cfab8..008e5305782 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1082,8 +1082,6 @@ struct ArchCPU {
     uint32_t reset_sctlr;
     uint64_t pmceid0;
     uint64_t pmceid1;
-    uint64_t id_aa64afr0;
-    uint64_t id_aa64afr1;
     uint64_t clidr;
     uint64_t mp_affinity; /* MP ID without feature bits */
     /* The elements of this array are the CCSIDR values for each cache,
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index b96a3588043..44c877245ee 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -4,6 +4,8 @@ DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
 DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
 DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
 DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
+DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)
+DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)
 DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
 DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
 DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ae6231803e1..93da8f170ea 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7987,12 +7987,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->id_aa64afr0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64AFR0) },
             { .name = "ID_AA64AFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->id_aa64afr1 },
+              .resetvalue = GET_IDREG(isar, ID_AA64AFR1) },
             { .name = "ID_AA64AFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index e3183c53bb1..3a65d3903bf 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -428,8 +428,8 @@ static void aarch64_a64fx_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000000);
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408),
     SET_IDREG(isar, ID_AA64DFR1, 0x0000000000000000),
-    cpu->id_aa64afr0 = 0x0000000000000000;
-    cpu->id_aa64afr1 = 0x0000000000000000;
+    SET_IDREG(isar, ID_AA64AFR0, 0x0000000000000000);
+    SET_IDREG(isar, ID_AA64AFR1, 0x0000000000000000);
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000001122);
     SET_IDREG(isar, ID_AA64MMFR1, 0x0000000011212100);
     SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011);
@@ -676,8 +676,8 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->clidr = 0x82000023;
     cpu->ctr = 0xb444c004; /* With DIC and IDC set */
     cpu->dcz_blocksize = 4;
-    cpu->id_aa64afr0 = 0x00000000;
-    cpu->id_aa64afr1 = 0x00000000;
+    SET_IDREG(isar, ID_AA64AFR0, 0x00000000);
+    SET_IDREG(isar, ID_AA64AFR1, 0x00000000);
     SET_IDREG(isar, ID_AA64DFR0, 0x000001f210305519ull),
     SET_IDREG(isar, ID_AA64DFR1, 0x00000000),
     SET_IDREG(isar, ID_AA64ISAR0, 0x1011111110212120ull); /* with FEAT_RNG */
@@ -927,8 +927,8 @@ static void aarch64_a710_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64ZFR0, 0x0000110100110021ull); /* with Crypto */
     SET_IDREG(isar, ID_AA64DFR0, 0x000011f010305619ull);
     SET_IDREG(isar, ID_AA64DFR1, 0);
-    cpu->id_aa64afr0       = 0;
-    cpu->id_aa64afr1       = 0;
+    SET_IDREG(isar, ID_AA64AFR0, 0);
+    SET_IDREG(isar, ID_AA64AFR1, 0);
     SET_IDREG(isar, ID_AA64ISAR0, 0x0221111110212120ull); /* with Crypto */
     SET_IDREG(isar, ID_AA64ISAR1, 0x0010111101211052ull);
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000022200101122ull);
@@ -1029,8 +1029,8 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64ZFR0, 0x0000110100110021ull); /* with Crypto */
     SET_IDREG(isar, ID_AA64DFR0, 0x000011f210305619ull);
     SET_IDREG(isar, ID_AA64DFR1, 0);
-    cpu->id_aa64afr0       = 0;
-    cpu->id_aa64afr1       = 0;
+    SET_IDREG(isar, ID_AA64AFR0, 0);
+    SET_IDREG(isar, ID_AA64AFR1, 0);
     SET_IDREG(isar, ID_AA64ISAR0, 0x1221111110212120ull); /* with Crypto and FEAT_RNG */
     SET_IDREG(isar, ID_AA64ISAR1, 0x0011111101211052ull);
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000022200101125ull);
-- 
2.43.0


