Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F7CC87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 07:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufw1a-0007Dk-IQ; Sun, 27 Jul 2025 03:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufw1U-0006RK-1J
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:42:20 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufw1S-00016y-Df
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:42:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2401b855980so296985ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753602137; x=1754206937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6I/c6izRvO/9YY3k1FhH9eJOO9nj/nIYdH0I7uHsCI=;
 b=wNZbE0iIRyx+wKTFaqdJbVfkRxYgcuaY3MNtQxzCO36xE0KgrUXm5qqJ00uCfwj5Tk
 wYVcLB+M6UYhDUQKw0a0Kwmn+siWM4aaMVYTABSBC2Su3ga/919cEtLMzDb3bspO0jfb
 ZLGIXmt9676MxYtFFUQJtknJriAXEg/TEKToc0Wt289w+J1d4IYngzUbxoIAqNUVllkc
 uVfdNNmfI5PVtLnDMnfhE7HrnSudgLxPrs0Fter29/KxraT/yPtQ1nKWNEiWl8hgnslX
 wTp3rtMWuH3OBSw3fvWVSwVBQb9qLI1sLGXDVwMaI2iK2B3LNzgrTGAuv1uGVH5EEKVS
 vFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753602137; x=1754206937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6I/c6izRvO/9YY3k1FhH9eJOO9nj/nIYdH0I7uHsCI=;
 b=r6xrxT0VJxYoCCXatqTCLsfSLfFvSSayinLmh/gGv/B+dq3MRA1qgMy9qBTw3bowIF
 XgPMBoHyGUKOzREnG9/Ma7oYVyVpTyikkOS4z6Q/Y+wgug+U+EsBK5FaeLNtnHK2t36i
 jN5s8WDITP2GwyafOYK6zUmsWkpeW8fP/8kaTlDT39EK41r91o9pDlJCNgf5NwFcPBGL
 yOUQRgH8GgADVZMnauiHs0fUm8B8LhysSsid1yxYRiOa/RnEMedkXg3vaMnDStSPR4aQ
 jFk5HLwdXN5ceMzNbGdyNpY4TcbpE2cdbCFICsJsBoZNYjZE4IxCjAEnv8wVKkH95haO
 /TTA==
X-Gm-Message-State: AOJu0YyfmSNqKAaGvR9EnUKpbuakQj7oz21dQE7AJK2D7vXDgpG1im7O
 AyWJV4YO5H9CwE5psanuamQG8hXDHTdb67yom4g/cEgZBArhDdEazGKmtuajd72i3aLkSSafKkY
 PeZNM
X-Gm-Gg: ASbGncth/ohhOOfAIjZCPCWYVeUrc+kVK9ErITvkhS1LEALb9wEVKQXOqUiIlWHRFc6
 Emgs3chmBoc7l5GWmtBB4+Lr0enQOyZ5PXt0mkUvGFf5H9IbxIXH4CM1boPqwjohMFpYW+HZHnQ
 bjLKa8K9jjTdSgn9KsE90xe6OcIrfPyNgYiIOWqcCnrUG8qLpHMjt5lkI0pLT6XfN61jrQs9sS3
 +TaidPt3mBPbTzJAY7o5la95wF7WtlPIQYDclHkGT/uY3oki5I5q1F1dXqYFz7EmAUh/7+wqUHu
 50kwLFQbSSUyJXDxxjLeNizPDND8Gm9iFSgVxLaiIOeAtrPw1Bug3F0KVJcFpgA+Oj8vVFCURD6
 t1gtqXxfHDeVp41lNfz1miy9pg7Xsson28FomEiare++4SfeY+b6YIL1S2aOKhTMsPgRLNNlMoJ
 avU2KpcVWQxw==
X-Google-Smtp-Source: AGHT+IETF/Tl9fw42ilp67lr6vwrhtW7A/H1HWuow0B2+KLHZLi0AjQ3Cy0OLMZW9emZ8JYggA2drg==
X-Received: by 2002:a17:902:e1d3:b0:240:90d:468d with SMTP id
 d9443c01a7336-240090d4734mr9724485ad.9.1753602136932; 
 Sun, 27 Jul 2025 00:42:16 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe53b546sm29633055ad.177.2025.07.27.00.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 00:42:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v9 6/6] target/arm: Enable FEAT_MEC in -cpu max
Date: Sat, 26 Jul 2025 21:42:02 -1000
Message-ID: <20250727074202.83141-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727074202.83141-1-richard.henderson@linaro.org>
References: <20250727074202.83141-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Advertise FEAT_MEC in AA64MMFR3 ID register for the Arm64 cpu max as a
first step to fully support FEAT_MEC.

The FEAT_MEC is an extension to FEAT_RME that implements multiple
Memory Encryption Contexts (MEC) so the memory in a realm can be
encrypted and accessing it from the wrong encryption context is not
possible. An encryption context allow the selection of a memory
encryption engine.

At this point, no real memory encryption is supported, but software
stacks that rely on FEAT_MEC should work properly.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250711140828.1714666-7-gustavo.romero@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 4eb51420ef..c54aa528c6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1250,6 +1250,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64MMFR3);
     t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
+    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);        /* FEAT_MEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 1c597d8673..d207a9f266 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -89,6 +89,9 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
+- FEAT_MEC (Memory Encryption Contexts)
+
+  * This is a register-only implementation without encryption.
 - FEAT_MixedEnd (Mixed-endian support)
 - FEAT_MixedEndEL0 (Mixed-endian support at EL0)
 - FEAT_MOPS (Standardization of memory operations)
-- 
2.43.0


