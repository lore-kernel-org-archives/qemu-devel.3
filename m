Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0E7C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUn-0001aT-3P; Tue, 28 May 2024 10:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUk-0001Xi-UH
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:06 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUi-00073C-Am
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:05 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-357ec504fcdso579070f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905283; x=1717510083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0NfFGA91GjMAl+N5OiSeWRtiynvfnz6dd2uWVlnAF1w=;
 b=BETzmEY0PNafl3znuUlD4c/Y0lmPXdi3hNHxdvHauEuL2AzjShnudTeos8PEPtNcIK
 Xp0tLzWkISgLc+dPfGLwV+e9AbA3f5idkzzPaTtWCVKet8+3kgoqEZCn4OtokELIdYve
 CZSSEnBag9MPlJoQXX6qf052j9vfVZ8t7qTxnoCznrqRGiiReySFlp4U7hQC6bjPB2PN
 07F0DYK71e9Gv0aNweK7z4LIOsAe00Qbe3NSRPDy0H4wuPXBBUIBR1AYlpY3WlV2oPnp
 1h5nOdxRgPTDJCfrlvra+6GAiP8eOdtuogQ3rqhhtUKGC99S6ENNa5SEKgCfnCxTkacP
 a9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905283; x=1717510083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NfFGA91GjMAl+N5OiSeWRtiynvfnz6dd2uWVlnAF1w=;
 b=DRX7Pej58QtdzMKz+byUHKWmCnkgm6Z+IljfvVssRxZGu2S1e82Nm6xzGXspoc+q9d
 qT/a95ahkx5Ihjru9PSFojMkRNN+O6xxOP6HNhEmudv6QXfmrsF3TS2q2+1xZmSU9Yda
 OXmiJu9Zg83xfTabkF/qlXPfGnwta0waZBEchyDWefkPijpf6IztMiMKfMYUKepUll9b
 JfLkCeJC9bod78YvKIDOWki1JTX1KkjfMFaE57qwTUcB+vj4G9Vc68TeXUbcnnQKcgeL
 LmUFM87UT/AGEh4RRnni8+ElrlQUIGe6C4uDf7WgVkRTuF+3ZmY7aZc3DGHvbo7iyg3i
 TZhA==
X-Gm-Message-State: AOJu0YwB56mIVq3ri0uxTYBPLMH6cy2LESYOKAR1cani7peHr3PSd5H/
 dRhrG3bxgoMVBkmkaUB541uEdVxveb1SMIH/24fx1byUe8xY7bWepqhyRXsXmovWTWGZVzeGNWD
 q
X-Google-Smtp-Source: AGHT+IGjaXehukhJySyzAd0ScCZbVrr/JRBAAbjQ8GyqcKSq02sO+TQpuF89PdmEF9mXes9arS5PcQ==
X-Received: by 2002:a5d:4950:0:b0:354:fc03:b44 with SMTP id
 ffacd0b85a97d-35526c27760mr7848927f8f.4.1716905282884; 
 Tue, 28 May 2024 07:08:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/42] target/arm: Verify sz=0 for Advanced SIMD scalar
 pairwise (fp16)
Date: Tue, 28 May 2024 15:07:23 +0100
Message-Id: <20240528140753.3620597-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

All of these insns have "if sz == '1' then UNDEFINED" in their pseudocode.
Fixes a RISU miscompare for invalid insn 0x5ef0c87a.

Fixes: 5c36d89567c ("arm/translate-a64: add all FP16 ops in simd_scalar_pairwise")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240524232121.284515-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5455ae36850..0bdddb8517a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8006,7 +8006,7 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
     case 0x2f: /* FMINP */
         /* FP op, size[0] is 32 or 64 bit*/
         if (!u) {
-            if (!dc_isar_feature(aa64_fp16, s)) {
+            if ((size & 1) || !dc_isar_feature(aa64_fp16, s)) {
                 unallocated_encoding(s);
                 return;
             } else {
-- 
2.34.1


