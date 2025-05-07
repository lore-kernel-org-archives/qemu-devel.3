Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB27AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQC-0000iJ-1R; Wed, 07 May 2025 19:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPx-0000IQ-Of
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:13 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPv-0002aN-BO
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:13 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-30828fc17adso478420a91.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661390; x=1747266190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMEP48GWxCsRSx7QE2iBFebS5MEkI8l2Uk35GcFvWVQ=;
 b=r8KAFHeyTOTPRSohRn+eOm14KvQBPo125eEJO0d/GDFvz6lgAy2dWfLkmmObcWRkaf
 Bt/4wiBSixBoI3yJGBvRxIDfeQn/uIaBLniAbel5saWU6y3BvzvOst2ou9Ru94SDXuec
 yBjgl9QAuZBJThDeuMiieXOknnOW4pv2i2Tcel2PZER/nxDOXA+BNDGVv1IDsKqrfoji
 dWfLBqYWccmTxAYCOqh1CTVkHqnTFjOs6ugX+wxPFmsglRgM6WO7fSrSJSfuDEoAcAMh
 dbZvA1iqHlc9JwGMIZ4qe7q6QuBU3/mWpjuMZIOD/QoQsXnT0FaW3uqYtYSqEgn0D/v8
 I3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661390; x=1747266190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EMEP48GWxCsRSx7QE2iBFebS5MEkI8l2Uk35GcFvWVQ=;
 b=VUi1yr12Cyhkrc8ZAuNkTOJ5t1V2z5ndFngKoHrIIwStY/M5iuooYCHdkENS3K5awH
 HC45jcLrSumrSNbN3GtIbzHIJZoJ9PYwuZJFPFZJPdU5mPv6YeRh/pmE+r8gTjVi5MyW
 CDWhWKIav2RTK9gWRpQF+Xldm4TPrXcgubmUDsrheCgFGEBCm9cNq2skcmSUuI0pNRrX
 7CtRiwjPHCm0nTKEZUfh6PWsB+MyP7mltG2W7D1fBedgq/iN30MhefRqWspeRMl5snfj
 86Cwa0xRPmChx/nEeGmGk2KcoaediU4fbhuYyaMtoaZ5IgJU6Djj1adIl2yBJ0zSA/T+
 zZ/g==
X-Gm-Message-State: AOJu0Yz/Dm2jtxA/IuV9+N+9c9xYNn9ELeF4punAqTdq1RV4VMKXWNmV
 1ETNJzCgJhKR1GabwOhG29lsTqkvTTOEsYw7fHuJP9w3tUCr817KanLgnGYe/U+jcFCcnpnL0cW
 FGasxww==
X-Gm-Gg: ASbGncvReeBcKtgqXJzgJ5cTPFGvgI/NtMd3Qb+sS3UtJ7AU0jfwalYQsxobzO5Ndzc
 h2NaBCj11/JKFZfryveMRc/f0SIhp5eajGOeHDOKxbtJnK1J+iuIIp1NAOZZnL5AzOfy5cqaUKc
 7ANUjjM9IP9Y7vdeUr781sQ6V9DjVKigavC937H2K6XbvF8mbqRrkkhhcEMajc6XIwweFb+s/vk
 gGUmBR5l3gI3EBz68r16sHsSgyfMfXO8RibFggQXH3ciUaUup5dJL0HhGi6OGCDuqjNLq8ZXSrq
 qHCx5/nCiodlKxWh4CRoeNGOe3UMhpU87GMseNAO
X-Google-Smtp-Source: AGHT+IEcU9dnskRHp617G3UulVikylQpHRfLIGjQ/yGDH7e1z5HXtg/D6CcYwWudm0EWP3DH+uoZgA==
X-Received: by 2002:a17:90b:4c88:b0:2fa:15ab:4de7 with SMTP id
 98e67ed59e1d1-30aac19cf0dmr9668869a91.12.1746661390062; 
 Wed, 07 May 2025 16:43:10 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 31/49] target/arm/ptw: replace TARGET_AARCH64 by
 CONFIG_ATOMIC64 from arm_casq_ptw
Date: Wed,  7 May 2025 16:42:22 -0700
Message-ID: <20250507234241.957746-32-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

This function needs 64 bit compare exchange, so we hide implementation
for hosts not supporting it (some 32 bit target, which don't run 64 bit
guests anyway).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 68ec3f5e755..44170d831cc 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -737,7 +737,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
-#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
+#if defined(CONFIG_ATOMIC64) && defined(CONFIG_TCG)
     uint64_t cur_val;
     void *host = ptw->out_host;
 
-- 
2.47.2


