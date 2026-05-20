Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD4FCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlYr-00075J-3w; Wed, 20 May 2026 14:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYk-0006mD-He
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:22 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYh-0000TG-Mo
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:22 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36a3aff302aso382754a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301338; x=1779906138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0L8sm2nuOmiw4XE7Qu74ytG281Y5T5t916Djua5D5pM=;
 b=lgYDqEWT9940ZLa/V6Cc4sSy/R6rg8BjD0I7vJrss3A/uFqndtUVuM4AkE5p9OXL95
 hUxPWJXMM+YKAE1S27ThN1e+PLWB8HP3CcyVpGU0tJJyu66zHZys8NvjFNaRNm7JDYg8
 ecuqUFQedv+VHYg6ZS1XFk6Z9MUtNr/zahny0iqZ/2lju0OxE/mUV4eKQ+iqxVqK1tQw
 pnkMAxDhpL5ft7UQnMWM/hZGn8pabJ5JvRa7dP5YxtZ7y9qdxx6lgLx9Dl9IC70EjtJ6
 Mlwimm451kIk4B73vm85qaMzcbQvFtxyRIn8TSojFT08U+fCrv01HZdeWQRXPTydjYO5
 ObKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301338; x=1779906138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0L8sm2nuOmiw4XE7Qu74ytG281Y5T5t916Djua5D5pM=;
 b=ZNT5BiAmTdqYwMH65QqJWTFENr9EYCwXpsDDqjXAvzOJdncaig92FDFzuRRBhoFWvH
 rnYiz6kkHKlw3ftFSFYBcToerivVtd50++rYZah9EAx7Q5EBYjjGunGVxaHz1Sx0pxou
 OMoYcjKqvndehY8cVde+kQOohAPAUEN5fSrEjYIjQpH0oDYjcVCPGDGnQC57FDVs049O
 rccosqgJpkBK4lNvFwZrtJnTFDYMxpEay6hJc0Rwmvmc0IjNjblK/yQpthSV5hCP32Xm
 pjROQpWKwCRcnu0QcI8SlL6JLwOv2J0ASkCLtg6RwDSZysW9d8PJ71i5nMNF5inm4B2B
 19cw==
X-Gm-Message-State: AOJu0YzsTTr7L2yIKKhtpv16U5X4wnLcRBDtKFDm0oiF5enwNXtoJoOv
 oTtydYYymYwZNbqZaYrrNeHq3b/I/KcwpaFhFOzmoerpnRczn+NEc6olv44i8FBhqCmR3owt3jf
 ljAmVL8Q=
X-Gm-Gg: Acq92OFGTfYv7uEyxskvEWqzgfY08L84sFAwlRVo743rQf2Z9smR/35xdoB7q/JbDRD
 fZGVDFp5VYJcdwYTE2FunHvdZHXxAeRfAQoewZqx+59Kmu0BfUkO9qMoVuqMCwYmJaduwDBFzco
 eaDsxmx7tyf8G6KcPVz+R06OBxKqQyHEshCeIVIM6eDtBLmnEp4U4tRe9aiSZ6qbUCsfxurAu5x
 Xgw1HhofesGh6rTccLbnmLSHHAxAJNy4JmDa9V7OLxxgx/2/nDeP6QGXYsC9KoCkOq5tGKYROoG
 tgM5XOD6Wxs+tklAe05YyjoAPiia7Hs3cZ4hGkGgTOJfAvc2qoUlAFMxZYLJTv7AH9T5QG0OT1v
 UhLgE8cpQQZDr517en97xUFslo+AX651CGZJ0O+Y1YJwETdbxT3M45d8U+3yJS7KnYYSV030OYX
 P48lZi8yGZy7cruoAVtxw3JNq4egV0
X-Received: by 2002:a17:90b:3804:b0:35f:9ab2:a5bb with SMTP id
 98e67ed59e1d1-36951a1cc30mr25925826a91.10.1779301338157; 
 Wed, 20 May 2026 11:22:18 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 05/64] target/arm: Enable FEAT_FAMINMAX for -cpu max
Date: Wed, 20 May 2026 11:21:14 -0700
Message-ID: <20260520182213.872945-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 4 ++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 649d854a65..ff0c2b1c47 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1266,6 +1266,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
+    t = GET_IDREG(isar, ID_AA64ISAR3);
+    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* FEAT_FAMINMAX */
+    SET_IDREG(isar, ID_AA64ISAR3, t);
+
     t = GET_IDREG(isar, ID_AA64PFR0);
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* FEAT_FP16 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 8cd7fe7b00..da5f7efce2 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -68,6 +68,7 @@ the following architecture extensions:
 - FEAT_EVT (Enhanced Virtualization Traps)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
+- FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
 - FEAT_FCMA (Floating-point complex number instructions)
 - FEAT_FGT (Fine-Grained Traps)
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
-- 
2.43.0


