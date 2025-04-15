Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1B3C369BD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mGL-0000j7-PN; Tue, 15 Apr 2025 15:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mAo-000744-ON
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:42:23 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mAA-0007FG-AD
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:42:16 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6ecf0e07954so82373496d6.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746076; x=1745350876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q83w8Xallm3lqa4mcTd5yBe7/enj/IxNEYYygxKl8+I=;
 b=XCsNDAb7MFWHjR+50WHcax7Pzsf/N/tHhv5qxlBEhRBK9jfct64CuoPBeAmKwVu7uZ
 /CuwKVTkEDnAIMOd2jad4DL3y4Ci0rA3EVYVAkbY1j3p4PfzHbm170Gt2vwZqIU8RfKy
 dCnq0Br3IghsIgZ0100eMfSdqhUYAxQQcvgVEfM/ZGCeyUIAxmIsBJa5KktVbJ2dH+so
 fjTEaFauPy39h5Y303YZ3TJ281MPwTbPYsi1nnHBBNtfImfDd3jcqzfAD5npAAM1BuSL
 ZxZDozJgl9AX/7DkMm3zGH5dIPcArBhW+tXfAdp3qKLOWLwUCXk8U8SlZvm5xf/pM+t6
 2CSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746076; x=1745350876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q83w8Xallm3lqa4mcTd5yBe7/enj/IxNEYYygxKl8+I=;
 b=hpAqF08vXwWYM/ASH832DFiU+/qPueXj6zIhr7f66PAUicqm7GDiGBx+Ph8Pu6xfoZ
 HpPKzf6m4MwuLOSKPH25yX/pX4P2JTp2y8+U7k62f9ZebmMuBXGO9K+Y9PLGCQBShDTs
 R2HY4uwbYrHRsudiqLXY15/wtHLdJclq8cv4GsU43et9m2I1uQsxdRCAwS4UqM9F17WA
 z6dmGQjR9U2+wwQ+HjE+JTVvWt1yjEchsgKvUu7wTHTtENc7hfWEavcoKyh7RUwSpLbA
 EjFteCH/InSabEeMHwSuyLdvbvBPf9wixlXU/zTlott2YmEdCuUPMaUj2G6narycTuzY
 OKHA==
X-Gm-Message-State: AOJu0Yy1XyHFXKIupx68epsAjz/sh7GYCl5n5uwV565O/zi2eWrJ/mb9
 qBEp8jxluVMgNU7jUrfeV4wi5/2u7pj7S1jzAHCIiRiT5SsNUfgDbL4M3YgksGTFM69RJi7g7c4
 w
X-Gm-Gg: ASbGnctVJ7mSCB2KKzbLPcmgA95K2u7auIJg1eP6BZhWQ6c4HcFaXJoDUL/EVLAPQPB
 uSYELxtDI+iD/XH17Juxvkvp9Bura+a3bhkiMchT8ZQM2LM6XwuUAOtW2iwd1voi2J7f5SxpExn
 9uxznxEZI+mI+sagsB/a3dRqA3nsxncjolcgWUXVulfeQeSU4o2e+r/jHdq4tOqTrpVB6eBTZiQ
 Ikx4AGL2pGxiguAPcYSi1omS+rFrLlHvwrjeJVsCfpJ30p8vXYAMcFWYAav1Hkdbrbn3aO0vr/N
 6KanYDknaY8uEgqqv8gYdPiA6ESXmgIMAEAKsw7JxnGuPf9YOyGYjj7LTwJQZOfiKIpMh2AXrSY
 =
X-Google-Smtp-Source: AGHT+IGA45a5vCqIGnpBvKEWK3rXE9cKRop1b54Y5kJDwA6T+bWdMUAdh4w9qGbH50jq0+8uG1nfVQ==
X-Received: by 2002:a05:6a21:6d91:b0:1f5:9208:3ac7 with SMTP id
 adf61e73a8af0-203ae06c498mr311763637.41.1744745763214; 
 Tue, 15 Apr 2025 12:36:03 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 127/163] target/openrisc: Use tcg_gen_addcio_* for ADDC
Date: Tue, 15 Apr 2025 12:24:38 -0700
Message-ID: <20250415192515.232910-128-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7a6af183ae..c9856fdc88 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -220,8 +220,7 @@ static void gen_addc(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
     TCGv t0 = tcg_temp_new();
     TCGv res = tcg_temp_new();
 
-    tcg_gen_add2_tl(res, cpu_sr_cy, srca, dc->zero, cpu_sr_cy, dc->zero);
-    tcg_gen_add2_tl(res, cpu_sr_cy, res, cpu_sr_cy, srcb, dc->zero);
+    tcg_gen_addcio_tl(res, cpu_sr_cy, srca, srcb, cpu_sr_cy);
     tcg_gen_xor_tl(cpu_sr_ov, srca, srcb);
     tcg_gen_xor_tl(t0, res, srcb);
     tcg_gen_andc_tl(cpu_sr_ov, t0, cpu_sr_ov);
-- 
2.43.0


