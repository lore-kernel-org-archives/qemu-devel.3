Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A872EC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 02:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjUgj-00051K-Hv; Sat, 15 Feb 2025 21:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjUge-00050b-Iv
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 21:47:18 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjUgc-0002Cp-6I
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 21:47:15 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2fc0026eb79so6173749a91.0
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 18:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739674033; x=1740278833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YIsLb2tirEHGz04yq4L8PckkcZyn9aHTqkTqwPaOPOc=;
 b=SjojTTPRmvUDnPp79V/D3DAGnCLSCooBixnJ/8iItsqlad3+Wq8EvNhc8MlmcjPNIo
 nzA9B0ewhYaDhdDWADWwqBFMl/ms5MTLnKWxZWaKM9BDGNvPiBRYu1HLUvd3bslh8/3R
 DgoHqCXp9wveOIDCIGuvlPlso4Z5l88O/qMxrzVxp2l8Fi5NPQ1zeTOM4ZZtkq9QOaQp
 16PH8QiS6fMWGU/Z+//XUc8wbl74ZfIC8wTT1RBztoOBUC46bj83LWb4r2V5FisoyxM0
 5X4I4iIfy/V1JeJYeIJdFyvSAM8htaJ2I9YxgFwKINaVMtFPgBxdN7eXzeNnz9LAi1aO
 6N5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739674033; x=1740278833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YIsLb2tirEHGz04yq4L8PckkcZyn9aHTqkTqwPaOPOc=;
 b=MkrE1fOAUXzPTLDr7QoeHkyga7EDFd/k5GgXTOUosVQLEnirZmfmFz0lXCGOILoLpy
 kAMw6/BtLue1BoytXBQtIN4bqSFHkxsIyDfVg24wa15wVT19x3RFtA3DBgYu/l7XEPDL
 pNRx1qE0sBtqc1jPm86kuEsLlwoltcJnftV0WTfbk7PmPconRZYaSnBbvwFFHC2dhT0+
 NHxMdy1/VO0JdVaSCUcPsKFsdvM/I87u13uRea0sMj7W3e+0otQUhmQDm434i+qMwr8t
 /kiwyUxf+CTMuBPsJqSUnVealIXd37IZbNQVFfvXyP7d+k0kn0QdMC7nzviKU7j6edq7
 yKzg==
X-Gm-Message-State: AOJu0YxTkFw8xSKNw548dFTqvUQi5HixNIq6e+HhFAz2YmGvjqTf5dln
 gw2PJrAAFIAiDqtcCfwk5aO1+xeEZkA+7/pAfyM/e4G7m1vkFOQTMVeJJHcxm0/wp+vQWOpnrF9
 v
X-Gm-Gg: ASbGncseauZ8+G9i0xPVw8P0/tSmBCvMI62Mpm2DE6v7v873Q7ghhnG6DO3IrlaZPKj
 bCPif783vNNYNJZnDdff28CmJ35CGYuFLbCVIZ4JnKODDF8aIBHGqxOTWd8Cj9AYP60ccJkulY3
 CrEe3mw7+57HFTuVNDRXVNfv2mtYkcworYUCpsMMRiSJ5gPYHdoOuLlrLah+1Hku9jwXXStlVsy
 IMI6K/ry/1xMdHAnXEFeFd5bSUQ2bPtGzi7VMBlqNG9nKnEuT8lUVrRtmrXYFWXbEEh63ImST7w
 hv2naCNQveSaKv5+qLk1kEcs62J9O1aCrEEQNOf/kUt6N1U=
X-Google-Smtp-Source: AGHT+IF7qFSIVvt6gkZs60XpL9wCp5YjDI4Ie5/9VtxMIFTwhv0TEZdm6fWts6vBPkF0pOdu9OBvwg==
X-Received: by 2002:a17:90b:4c44:b0:2ee:70cb:a500 with SMTP id
 98e67ed59e1d1-2fc40d14e0dmr7593904a91.1.1739674032743; 
 Sat, 15 Feb 2025 18:47:12 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf9ab0233sm7701710a91.44.2025.02.15.18.47.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 18:47:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] tcg: Remove TCG_TARGET_HAS_{br,
 set}cond2 from riscv and loongarch64
Date: Sat, 15 Feb 2025 18:47:09 -0800
Message-ID: <20250216024709.2624325-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216024709.2624325-1-richard.henderson@linaro.org>
References: <20250216024709.2624325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

These defines never should have been added as they were
never used.  Only 32-bit hosts may have these opcodes and
they have them unconditionally.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-has.h | 2 --
 tcg/riscv/tcg-target-has.h       | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index ac88522eef..188b00799f 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -37,8 +37,6 @@
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
-#define TCG_TARGET_HAS_brcond2          0
-#define TCG_TARGET_HAS_setcond2         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index f35f9b31f5..98081084f2 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -37,8 +37,6 @@
 #define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_brcond2          1
-#define TCG_TARGET_HAS_setcond2         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_negsetcond_i64   1
-- 
2.43.0


