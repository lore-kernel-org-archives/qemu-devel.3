Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C594E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4XL-0000QX-VJ; Tue, 07 Jan 2025 03:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wl-0000DK-HT
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:27 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wj-0002tx-IN
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:26 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21636268e43so41672625ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236884; x=1736841684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DcTEozh86Xrwd11aGFdHOjTtoqytx9vFk9B8/PjCx4=;
 b=Kjr1Y6Or45gRI/sKGMEe49Nf4VDJV5NxbWKb6mOF/4nGRmiuYf66YRPrZr8b1Rk3o1
 E6+zbCz5SFzoN17J2VfgAtqEyfvHqQcoTRyTfHY92IApsoCT1jJNwqwzkOljfWdPin1K
 PUjqHYdBHS6Uo1Dcl1uhD61WInCbay06oQJISvu2ryQOyXuCWRVxiCCpHFq4dcOIg1k8
 84ySXiGNT9I49kVzwY2kyUM7acTzlVfrGvGV9w9pccjyjgZR+/B8VGZ+IpOBUEQ4+7Vr
 Aom/FiO+i0YD8gBTZ/WyiLgrmgjRWePUucZThLam1T0pWDGAVHpAQ7O8kvzMtFWNWCdW
 leWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236884; x=1736841684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DcTEozh86Xrwd11aGFdHOjTtoqytx9vFk9B8/PjCx4=;
 b=k2JbZkH0+n8DwrRobvAjnvxnTHy/6vtwTKK+hfgnCvzmr8EWQC1lKVQ8mYqfAm2dAu
 w2ShMObqs2ZNpKL+peZDCrRYpF8mIweKRIatS7qk0BppRWfZlvnQ2e1lf9FNiMLNKmSY
 gx6eOT8QDHaw9QDXGo2TswKdAzwn+L8B/szv+zRwW/lxTgkDx01IcwUgHNWle0vOoZJM
 6+usqdhAihTbVc3g18dderY253gO7mV3rVro6I0RNDNRlgqtGgeD+9sLaXBTucETvR07
 exhFXH7RpSt44Dckv8J+Nk7KhdqYj3fiqfJKj2c3zw4m+4hiXuJO+4CbeMMDuoU3X0m/
 zHpw==
X-Gm-Message-State: AOJu0Yx2xly2cAHj+7dvT1PaMDS469inNrOUF7hnH66Ul2WiJf2OO2t/
 88KNfgiyt/2qHhS6NS8RRxcZ8+0Bfgqv/mtFgkX8ReaNv1SH1stHEHngxTbTOQKcxoGfTvSnnQz
 C
X-Gm-Gg: ASbGncs6ut7G66nOnTftYp5ZmWUM/0+AgqzAeVd1cqjOY5ueFylwuARU30WpeJVHGay
 +ERV7FR3HFDPtgXp0G4kIBG0bO+N91fd4vbqF9Nava6vVukqp0q6Y2EBwpl8t53jl3S0Zw4eFjD
 e6OppYvZRe9XThEexBlxdonEGdtMZin0uON2P5p+dvvXota6Hk+4kvTXCoIdyAZNw7t0eRVWTWt
 POv3tdPahVLDxeGduTi5y6urJx7Je1HVTjFwHK8pCP6BP/BBP9IFbxFm98nn826EWiG43PY7fOQ
 1FY9h75PRwiRI2bOww==
X-Google-Smtp-Source: AGHT+IG4wBhqISaH+5ummJmWIfGogDfvqZCtaLwzafvg03LQrO07yzVSINR3Qt8QVnNkfR6Pa8gr7Q==
X-Received: by 2002:a17:903:2c6:b0:216:3c36:69a7 with SMTP id
 d9443c01a7336-219e6f262admr870559805ad.45.1736236884285; 
 Tue, 07 Jan 2025 00:01:24 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 09/81] target/tricore: Use tcg_op_supported
Date: Tue,  7 Jan 2025 00:00:00 -0800
Message-ID: <20250107080112.1175095-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Do not reference TCG_TARGET_HAS_* directly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 0ef3743f3e..6819b77668 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -3980,7 +3980,7 @@ static void decode_bit_andacc(DisasContext *ctx)
                     pos1, pos2, &tcg_gen_andc_tl, &tcg_gen_and_tl);
         break;
     case OPC2_32_BIT_AND_NOR_T:
-        if (TCG_TARGET_HAS_andc_i32) {
+        if (tcg_op_supported(INDEX_op_andc_i32, TCG_TYPE_I32, 0)) {
             gen_bit_2op(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
                         pos1, pos2, &tcg_gen_or_tl, &tcg_gen_andc_tl);
         } else {
@@ -4113,7 +4113,7 @@ static void decode_bit_orand(DisasContext *ctx)
                     pos1, pos2, &tcg_gen_andc_tl, &tcg_gen_or_tl);
         break;
     case OPC2_32_BIT_OR_NOR_T:
-        if (TCG_TARGET_HAS_orc_i32) {
+        if (tcg_op_supported(INDEX_op_orc_i32, TCG_TYPE_I32, 0)) {
             gen_bit_2op(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
                         pos1, pos2, &tcg_gen_or_tl, &tcg_gen_orc_tl);
         } else {
-- 
2.43.0


