Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDC0CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CpB-0006Bq-Ne; Fri, 10 Oct 2025 09:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cou-000690-Tl
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cog-0003pb-4Q
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e430494ccso12205645e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101545; x=1760706345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7Fn77nA9fi9EfoppxXjEuvaOw+8iwaxtAjZMWeleC4k=;
 b=XAzbk7e65bxBxnnY8aSkWpQPYdVGgMOfUiUw78XHktB6rgzvWOfHWwb6eypw6YX7vV
 9STaGAUmXljabJ7h/Y60MA6KCFkjq4nYq4dWaL/wsQYt9JfgojLaI4VNvPSbSR4kaMDA
 /C3YIhOsZsKECtuqJE3i1qltVeXS6xuhAKkLjCqncQ7pudDK671cag4iMyhdavLZZozw
 Qg+JPRKur4wKIasrosTuNTqJaJTaTsOy7XS28EEXu4GVd2b1J0WePBSBGeTtlXwQQU4S
 YzO9bwvxdSSBqWGuUgbjw//3ytGukfCCpc3feDXtDAVk0QpYjzKyaqQkqWaR3i2+pIFo
 NUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101545; x=1760706345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Fn77nA9fi9EfoppxXjEuvaOw+8iwaxtAjZMWeleC4k=;
 b=b19I1HfEvNeMByf3Ga9a4KqnDueH/gg8osrVOTqqGwQqrIE6WRj2o1qJ6h5Bt24Vdq
 2RfShR6Hc/6ciP3akgfjrlZWj4q2KysyMyCA4tIKRtX7CArW0In6AO9MYgBYm4PXmDae
 ynhV0nO+eBSxLP4ZTgXtazXlhD3iwgZriHpuTy0VwOCOkpoS+i945vev0CSp0oQOlrsa
 hrk/4yXlJxhiyCTRj5b5J9/FTR9Cd0b/V0C6NXZA03D/pXMr6dLVlNX7Jq2ZelONN42g
 M+1vQov98dH3fmkOiHP98APXfNYfX+WzF42YQkAya7+ZAWQBxEibXkmvJTV8A7RnzOvr
 Aqmw==
X-Gm-Message-State: AOJu0Yz/kc29VWkqnCd5BsglDV8RZKLvK2eNlkFeTjWRU6AocPv02xyJ
 6WLrXHyda6TmM0EuhetRa60tuN48/dYyZAm7BYZNXiir1e7ulV83ZoQBlGWPtj8S0AYvDhfyaSy
 wjr2T
X-Gm-Gg: ASbGncvArBWyFAo0rMEiy1xmI0qfOhabx1tw2CEDRB4gmrYlgecWaTpLIZncMS+ZTy3
 OAlWLAq6qKEzC4SNTPZ/Y87q8QPZkZi7zp1tD/JC2rmnvoBOndY9NmG5LFQHeUV5aH53Z/SrYoa
 n6FWALZlPphK4OMNSccCcNts+V5sDyqu87YhFgJ0M430VLpHifufGPYovR6i9C1a7WiMVEdyKuM
 naXC+2suQFFAbNmiZAePrVg975CsPJbtU7Z9la66w7n9ZeB5MdpBC7ym/tCkT5prp8yQV5E1FGb
 4+865mDLBmncW9gLw1/3Ygz6OLLcv8bKoATSRS376rz8oCAuEXt44VqcjRaI39e6NcRcRdxGfxh
 C++KVLyvlPLLOhafqUlgjcQ4/tsXqmKvJa1imvsGL+O5jShXvMB0=
X-Google-Smtp-Source: AGHT+IF9AnHdO62mq8DKLzM/yWhyWmfSAqZHozLBMjI/5mTiB5TGBWzLMxiVky1lPCNAkm+x6Nmuqw==
X-Received: by 2002:a05:600c:4ed1:b0:46f:b42e:ed85 with SMTP id
 5b1f17b1804b1-46fb42eedfcmr25960185e9.38.1760101545488; 
 Fri, 10 Oct 2025 06:05:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/76] target/arm: Enable FEAT_S1PIE and FEAT_S2PIE on -cpu max
Date: Fri, 10 Oct 2025 14:04:24 +0100
Message-ID: <20251010130527.3921602-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 2 ++
 target/arm/tcg/cpu64.c        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 1aa0a6e4c39..c779a50570a 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -123,6 +123,8 @@ the following architecture extensions:
 - FEAT_RME_GPC2 (RME Granule Protection Check 2 Extension)
 - FEAT_RNG (Random number generator)
 - FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
+- FEAT_S1PIE (Stage 1 permission indirections)
+- FEAT_S2PIE (Stage 2 permission indirections)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_SB (Speculation Barrier)
 - FEAT_SCTLR2 (Extension to SCTLR_ELx)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8c617fe37b2..f024db1d29f 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1327,6 +1327,8 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
+    t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* FEAT_S1PIE */
+    t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* FEAT_S2PIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
-- 
2.43.0


