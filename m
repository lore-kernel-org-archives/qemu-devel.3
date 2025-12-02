Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A48BD116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 12:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQP5x-0006cG-E9; Tue, 02 Dec 2025 07:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vQP5v-0006b0-3Y
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:02:59 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vQP5s-0006U4-8L
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:02:58 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so36775535e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 04:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764676973; x=1765281773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UjInhO+n4r0xBag/pZShgiqyLRb94VnP2a+V9taCdyU=;
 b=Y3omTqmBvUGk5ZJfylrRD9FXP1W0o4UsR1UkrWoieY/4KbJUQ97rqeEH8ed6nlScyR
 bgQgpWei4roSwfJxRgVhO772qvkj13m140Ggz1tXjN4tY8OnE5Pc5anUNsgQsMSBoc+2
 pPtkhouY0GZ80FnTGVlT18k1U4d4a5l08WlMSt/YDQ9f49wpafdmAB3f+y8BUYM+IP1M
 DsAealmji5i16pBa/7vx4QZsAWEzF+nPdI8rKSqAEBJSCIVW928dHq+C47LnJ/Vm3Olx
 /RrBUih+WX3quxx5VveU8oZiEqslmTO3NteifnXOAozp2Uj9pS7gU73uOFteaPqKil/F
 XvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764676973; x=1765281773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UjInhO+n4r0xBag/pZShgiqyLRb94VnP2a+V9taCdyU=;
 b=ob8z9huNJARJoCar1ER6JsyZzsVp+Er/Hd0+G5zanGy5NQELaOXZa7mTRMJtQ8pdJ5
 SXRo68QAHxnv9zycyueBptBhwpuTqzz/P/bGyNyqtOtXm2/9MLwKbtfPORFvTbbTrdKo
 Ms5bW0VxhouLkNX3bdBsORaq9ghrKhUquKqasrEiqjl/2f13bH4mLnoxkpFiaQtjOIam
 3QMEtdPpKjqgCfcLnDP6sgSFAkQ7njf9/SwL4Zjs+F9hJ8YG7/bDIC6WjFunO1xGinCP
 C8i/z+VZCbcxgm33heUJ3CEZkJ4h96s+PGjaS8axaFqftiFgDA79fsYOatsIrDn4ml7+
 Xjqg==
X-Gm-Message-State: AOJu0YxuNFi8fQz9Wl8vvYKeoMrRA5wTt/JPbGoroMDjzIGsozYGkqXK
 EL8BPJ6ETpM9spNBEmgd6Dleq9oW67bPv60UApjWjR0E5l2ute2Yo+FoRmpvnHrmaLYCAPCu4cO
 eXR/w
X-Gm-Gg: ASbGnctLjvOewQpnIfG1VsjWW8d33L1nkWjgtIujoakHOlnsY3EcRQioAH4p8bf4kZ7
 NkqE728B1yPHFHMCupETqf3VR54DE9caxmIKqPq4Eobsfi2/oIJE/x8nvu5etHNy1dGEYGLiNMq
 +bnYHAYkYwZrJJgo34vTnpY0uJ5NXnLNvjznXUyrvjXLxFc9/NpaHdJ+YRMLeMISNIMtXYSQ24v
 63o/EkI9suhraYih9ZjSP6pv7A06muQpVL2cLGvVNFaYwQgWzraxuUOwmHy8PyzttC/FrkEx+mb
 bk1lDAN3fx4/7gp+XkTBtX8Pe5rFSIGDI8JOL8bMN82QyhtAyROx/1WzJKTzVNcKt7L7Y5woKbL
 /X6dcwQX+Jgkrim9eq0pq4bj0Mxe0dUCPjsFJrQmpphjVXapzpzi8ceDa8/+gyD9/MtHWLYt6/3
 aVmlDEyLobSdmc
X-Google-Smtp-Source: AGHT+IHPtNQ1CqHOVmLoHANDy038i0xMHWEk9qZSjNvlTBV5unG77GN+odbxaHn+ZZiVhvcpzFD7rg==
X-Received: by 2002:a05:600c:474b:b0:477:9dc1:b706 with SMTP id
 5b1f17b1804b1-477c01b494fmr439079885e9.19.1764676973260; 
 Tue, 02 Dec 2025 04:02:53 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:d0df:e484:1145:883f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0e21e8sm381169835e9.15.2025.12.02.04.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 04:02:52 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH V4 2/4] target/arm: Allow writes to FNG1, FNG0, A2
Date: Tue,  2 Dec 2025 12:00:39 +0000
Message-ID: <20251202120250.763150-3-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202120250.763150-1-jim.macarthur@linaro.org>
References: <20251202120250.763150-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x334.google.com
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
 target/arm/helper.c       | 6 ++++++
 2 files changed, 13 insertions(+)

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
index c20334fa65..7812a82bab 100644
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
@@ -6121,6 +6124,9 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_mec, cpu)) {
         valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
     }
+    if (cpu_isar_feature(aa64_asid2, cpu)) {
+        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
-- 
2.43.0


