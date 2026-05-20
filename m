Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81D7CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlcz-0005JU-7P; Wed, 20 May 2026 14:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlc7-00045H-Je
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:25:52 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlc5-000233-HY
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:25:51 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c80227b1f6cso2069348a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301548; x=1779906348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiL04P2CzHdch1eAb8Dy0QC+hd+UkcPVAZS3KCpqoms=;
 b=pcAzMQ3NtsAomtfusEJQMaRlaHTJ8Dc1QCoPV4C9TmQbwyERds2r2KVh6EQGqdlEUE
 7fhM4EvW/fpJhyVGUY3NmzudOVpZiSLRu1B0Aj3tkgna9piiGE3O1+2y3VjGM6gswA/V
 QIl9TjzBVa1N9Z8lE5T78TfH0rd4jEwU1apRQot3TgKFfdMbpaqbokCWcWh2BFJTRTZn
 BkAiasuoN41hpVc7J3QrRlpWkgs47FyxdU7V8e+AUino/0FCi6dSW0sAPZXgZ+d12tpS
 V33Bh5z/qDdoxvPNpzoWWmN1NvdGVKacAsBrOYpxFOkc5q8yCL3kTyY9cVkscfcEKmtU
 Bsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301548; x=1779906348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BiL04P2CzHdch1eAb8Dy0QC+hd+UkcPVAZS3KCpqoms=;
 b=CY06FXJsRd0C8qql3bmNUrPtguzpcWjcxFvhBNrkanDNXFMB1eyywCDakg4fVeYcNz
 XFV+TH9KD02MIp2TjEIOy41mEOeC1A9VIVas7cH5IBWc0W5TmDwrgpAvzxIfe8wR8cau
 GAVAkTDZALikUS4fL08KNcImpExDgQ6l35aUPr5YczPV4a2LtOw/J5qgbp1JoP28zhZU
 V2kOOY5afO1aXnwoHK9RuVN5hg5ftORsDMrLIlFzVV/cQtxFeiEGYw0J1GALtAT/BSg2
 ulZdgbVyE2taBX/WRaw8v7Uz+1tmVHLCMCg/zugNcJAo+DaVI6e0XgCvIlwi8+aGuazb
 AxyQ==
X-Gm-Message-State: AOJu0YyoUnv6eOBHuQ3ujfSdo8g5wMdKYAVnyZBtmQ3W5YezOr0I3Kpu
 +yszuDf0kQvYXNPbnG6O2LjxxxwJQOI0eZj6Uq0bUD/unHRAjhM2uMzE1xc9TySYEVzQSSAJIU9
 Rs0k+Fxc=
X-Gm-Gg: Acq92OEXdCm/70v9KuXN3tgwirxhxmSKcKhUM4N+q/GYDdDMwMG2yE1FTuRydbe0v+i
 AfFGk6mZPqzrBCO6Nx0kAs7oCN1ii6rSH3knwIBljCIGflRCpNxg3yiviK/5P3q/Anh5aNAVwUW
 vVBbHvGKcE7H9Odw6IHqeJebJMv4WujVcurer3nOtvDpVuU8A1B/FXcnRhwtQLrKECdlvuSynbM
 b+if8Cy4sGSHKEhjJCnbQA3OimRfZ9pepNn2n15b8ESmr2gW+qT2emf4lNqajdAzJoHAPno8h3w
 o0P2Yj29ytgJducC8igwUlaB6JQx+dzCw1lpNeH7KESV0BfGss52lK+l7fclXdemD52RqSxG55t
 eb84d62joY1RD91duVAug7MYYTdE+Upj5quVEGDFE+7OgjszgbrRvx0uQMjQvGD6+JupsFibycf
 8IN8kulQoJG1kO6Of/kmw/NCI7DQnd
X-Received: by 2002:a17:903:1a2d:b0:2bd:a3cc:256d with SMTP id
 d9443c01a7336-2bda3cc2d93mr206933535ad.2.1779301547709; 
 Wed, 20 May 2026 11:25:47 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 45/64] target/arm: Enable FEAT_SME_LUTv2 for -cpu max
Date: Wed, 20 May 2026 11:21:54 -0700
Message-ID: <20260520182213.872945-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8d0c057902..90214a355a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1388,6 +1388,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* FEAT_SME_F64F64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* FEAT_SME_I16I64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* FEAT_SME2p1 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, LUTv2, 1);    /* FEAT_SME_LUTv2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b6f0ca9351..0dd6b554a0 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -158,6 +158,7 @@ the following architecture extensions:
 - FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
+- FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
-- 
2.43.0


