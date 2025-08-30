Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D49ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNwf-0001QA-3g; Sat, 30 Aug 2025 11:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMT-00067a-Lk
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:50 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMQ-0004Eb-AC
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:48 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-327705d0a9bso2506632a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532564; x=1757137364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjDdAknr01k7YxkbZX1BtFHr9eMT0hUzaWlnonFMe1U=;
 b=bJ75cxoJLWO2cms8P+QmZ5SD/4NkHt7j7O5UC8uZ7vH/q3eoLNpQA6PvYWfe1Iy+X6
 GHjfi7pQ4B71ifPlH7CZpSZIMv4hFjseLwlnJhDZblhBd1Mw6samBk4IlCC8lmIIgerf
 n462AH9BHgRZoTrNZDIr88pPP0Uu56IAY+Crm/AsyNEzXTmacuxEZjtVrWnap6xL564J
 Zolus43k6ZnoJEKIq+1EKuqJxa9F/4JHmAA538HZ4b9o9ETB/Syl8a0zpzwedlRwKRa0
 o0e2XMilL+wFSPbrZ/wwtE+d6INx3noHC210LskiYIAHTnDxJE5S5/27jfHa1byOfVsz
 WWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532564; x=1757137364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjDdAknr01k7YxkbZX1BtFHr9eMT0hUzaWlnonFMe1U=;
 b=WfR/O2kRPbKvlIcfgYooCveLXgqIIaxWNLBldt3ZA/9qc3A0WMEfqFQayAg7aUzw+F
 1WlKJyUSBJJQDpeLQ5E9r+g0UOJne0OSlkZI1G/nY5DnizDgv3/PJcYg3CYRY7kcfKj0
 9iObly93KQKUogERizjljWR5HzBRdeuH5QEpxG8Qp+FmtMFXty9/IDtL6rrVCTmrR0i9
 hFp7FA/YgcbbkNzdjGFBGwKqWvhBri0zhtKowAD0t52aBW1Gvqfo86cCnIqkPE3vxvO0
 sX6xWRvcmKke3/prkmx4NgJd1Tm0vdKDGcw7fs0e1WauRj2DAv4Jw2MzLpRTWL2DdQtv
 yzPw==
X-Gm-Message-State: AOJu0YxNjlkwuULWIr+AN7Vt84rDErUekCtVAYFwJPgsiZ/5ty141Xzg
 LUoRFUUwUkmP7UFGvztFbjz7CNRzAGWQiHGT1UeZ/Ui9mwPX5iDDGI/1bZjz6LnujohlXalIZhN
 Hk1o3vGk=
X-Gm-Gg: ASbGnctGE6sOSqGKiZayy7B5xkpw5dhoagC9qpxZS/bv6TmnGLTABQuI1MO/xZiMMZ1
 JrSozxVy4x7ZPMBQCCLQIxOu3QxrY2rJvzeRFg2ALb5QYAXvV3Rh7VWm6EXaAO7fbTf2h10iaKU
 hV0/fIBrbyOSlVQpplonprCcyAWCi60e6pzSqoGkzMhZzWO6FB7rT3N2T5gZZXrgst9aXbLZKff
 gmNnvxhTvHPhGocVY/fpFSODEdN2q3RgyXiw8H2v/ImhJu1uo3UNvpEt5X/Qr/4mXzJrK7r9fl+
 NmmN7cCTfM+vlGgdK+BtX/OJEloQLd8Rl7tq4MqQmyst3DGMo62Bd/cS9aS/ALt16nyBZs3hAte
 BqNnsGNxAAEBWZYYrkdlPtRuCUnXnDTEPpVQRqVpTmTuWR/SkVYriyWEECnir
X-Google-Smtp-Source: AGHT+IFmme7wGBLJVhnimV4sfHG6Hp8dJvpSP273BNav0/0QLZRc9KGCVBlRLuriNEm2UH+dNcJV8g==
X-Received: by 2002:a17:90b:4f4a:b0:327:ceb0:6f6a with SMTP id
 98e67ed59e1d1-328154128b3mr1531353a91.4.1756532564496; 
 Fri, 29 Aug 2025 22:42:44 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 25/84] target/arm: Enable FEAT_S1PIE and FEAT_S2PIE on -cpu
 max
Date: Sat, 30 Aug 2025 15:40:29 +1000
Message-ID: <20250830054128.448363-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index abef6a246e..76193826ce 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1253,6 +1253,8 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
+    t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* FEAT_S1PIE */
+    t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* FEAT_S2PIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 6b04c96c8c..94a6192fa9 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -122,6 +122,8 @@ the following architecture extensions:
 - FEAT_RME (Realm Management Extension) (NB: support status in QEMU is experimental)
 - FEAT_RNG (Random number generator)
 - FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
+- FEAT_S1PIE (Stage 1 permission indirections)
+- FEAT_S2PIE (Stage 2 permission indirections)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_SB (Speculation Barrier)
 - FEAT_SCTLR2 (Extension to SCTLR_ELx)
-- 
2.43.0


