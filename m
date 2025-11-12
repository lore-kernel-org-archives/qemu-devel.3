Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2061CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 09:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ73h-0007OO-3g; Wed, 12 Nov 2025 04:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vJ731-0007D3-En
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 04:21:51 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vJ72x-0000K3-B3
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 04:21:50 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42b3b29153fso286872f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 01:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762939289; x=1763544089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZO47SYLDvpAJq0EByp09SrmEd2ewInfj97sZ5NPvqI=;
 b=E+YTj+QHfehP3F7MOLrH1p4LaXiswcNBAIguc3/kS+hRVfmLSDSv/aCYwe0f8uo0gV
 OqAab1Dzo2+rkEzosEW9u3MutDFSwMfxsUU2mw54N7pGfyoS905XbzkybxEMEL7HXEhL
 VXQTEldau6AG4Cnxy4g/VE/EbxjAJuaF5YNK7XzFZR5By/Tr7ZS2rSprpWUePb8ikqO6
 JR+xhCRGT+PFvs572RM/3nPrWdAbzeRBIhU+pIzLjXjSLwcGpdoZjyAENROTTHFw413U
 2Mug/UnNY+AMoJX1yui+EP6ajpxwhj/g14f4fsn3ZzbdT3QMi2urhWxQKod7mATHjCdc
 4tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762939289; x=1763544089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GZO47SYLDvpAJq0EByp09SrmEd2ewInfj97sZ5NPvqI=;
 b=N7qZMV+qRVEkIzaA6OLDwCfRHUfLCJdbSBXIPlHYvhhemG8qIUyAHSDWtO548fGWcM
 ooVk37qXreAmuBeXLlHfUmq9ZnXMcLF999UE7Un2iLU6pQWcNrJVrnN9ArFK26CqxL35
 wUBSrCM/px+K99vKp3dD54Pd7EOZmbFTs8kOjxes1ZvxSrV/lLROvh9KxZJdFldx0BQR
 tI3hMdINWJxytVFzFW+Jmiy+VieqgQwyRs54tHi4VSKU3ywYzUNqrcUn7VqfDvS+sG+B
 +6T3FAvwvlGm65wYCtJwrLgHz1/X2DJjdiI8SQ67U4mtEz/CfxxPsfUrCm3cxssDH0TV
 IgzA==
X-Gm-Message-State: AOJu0Yz8WsiNfo9rhtgWBYc3i6wqvWSVUb22gov/j2tigVT1GA2ZAxmf
 IGteMDxWEsFCoFgoRuAn/DlIsi2L18xvADzR6/bmPv+AcVrbK6p+FYcC7DllYUR/eT50Y5MjWq6
 J5X52k80=
X-Gm-Gg: ASbGncvS3/hjh2yFivNmFBhG7e+qfGMBcIPWDjBzPESuh6ZpOIg8unLbnBYPGr4RCQx
 9LpVV8iD3UwWOzt3H7HMshPZ90ShSj59FBEytWcJfQ9Sx3jwtZUIbrUJzw5VNxqi7BVev5Uqg1w
 ADQ/gPCyAiZHPV3JDcJ1NBxY20gtg1V9c176gb6UXtoX+1NgQkhnHdLNQKXME896RYPu/QVhu7X
 6Pja1gcqEcyg5YxhTC3rotP9aUmXQRNV2wYyOM1+zBeuY7P1fh8gzIKnKmkna3+beGyLeXCYE1g
 rEDL0aZSLZODDop6bkmj9owWz16wQeXWyeqbsxd+UEw5Ma8JbF+4tBPS7/Om8xBu9OUxf7YgYZa
 Ga6Y80QHz+dl9J3jNFYRFxg2A0korAI0OYyyafGno3PGpEOqi/MpHWkOkaZ/3Smkkoa0HSwB6VO
 Ib
X-Google-Smtp-Source: AGHT+IHTSFFV4e1m6COwwu7tdPoEEB85r8va8lEA0h34WVc0thlOPLZZLQUB4WWNLy7dObeU0ibWbw==
X-Received: by 2002:a05:6000:2204:b0:429:c4bb:fbd6 with SMTP id
 ffacd0b85a97d-42b4bdac73emr1968012f8f.31.1762939289080; 
 Wed, 12 Nov 2025 01:21:29 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:df7:7499:aeed:c296])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe62bf35sm32572495f8f.7.2025.11.12.01.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 01:21:28 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 2/3] target/arm: Enable ASID2 for cpu_max, allow writes to FNG1,
 FNG0, A2
Date: Wed, 12 Nov 2025 09:17:51 +0000
Message-ID: <20251112092048.450090-3-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112092048.450090-1-jim.macarthur@linaro.org>
References: <20251112092048.450090-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x434.google.com
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

This just allows read/write of three feature bits. ASID is still
ignored. Any writes to TTBR0_EL0 and TTBR1_EL0, including changing
the ASID, will still cause a complete flush of the TLB.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-features.h | 7 +++++++
 target/arm/helper.c       | 3 +++
 target/arm/tcg/cpu64.c    | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 579fa8f8f4..d56bda9ce0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -346,6 +346,8 @@ FIELD(ID_AA64MMFR3, SDERR, 52, 4)
 FIELD(ID_AA64MMFR3, ADERR, 56, 4)
 FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
 
+FIELD(ID_AA64MMFR4, ASID2, 8, 4)
+
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
 FIELD(ID_AA64DFR0, PMUVER, 8, 4)
@@ -1369,6 +1371,11 @@ static inline bool isar_feature_aa64_aie(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, AIE) != 0;
 }
 
+static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
+}
+
 static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c20334fa65..b380ade957 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6102,6 +6102,9 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_aie, cpu)) {
         valid_mask |= TCR2_AIE;
     }
+    if (cpu_isar_feature(aa64_asid2, cpu)) {
+        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6871956382..ef4c0c8d73 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1334,6 +1334,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* FEAT_AIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
+    t = GET_IDREG(isar, ID_AA64MMFR4);
+    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* FEAT_ASID2 */
+    SET_IDREG(isar, ID_AA64MMFR4, t);
+
     t = GET_IDREG(isar, ID_AA64ZFR0);
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
-- 
2.43.0


