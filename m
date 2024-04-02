Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EBFCD1294
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 10:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrbP7-0008NY-Vb; Tue, 02 Apr 2024 06:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrbP2-0008KA-He
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:30:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrbOy-0003e7-CN
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:30:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4161eb1a9fcso41475e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712053794; x=1712658594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kF8DIXj6upaIDgYItyrCELeFAUmDbN8yJ98Yufsh5Fc=;
 b=flYTtX7Nt/Y7dAXF4qiSRbdWkB3CALX3wLR8eRsetcmx24jgE6KUGdk3caOnM0sgTG
 y6GlWapFRnsCYl0vyxZM4cj4Y4SZ4YNVolUVe+FvoHBcAgdkmRt0XETpGxUJqxk49OmH
 SD4afO4UmUYqOg5PZ4eNeec7jzMK5LgFhGSZZ/NeX2DZkAjmQdyxosW88lUp/8snYSLp
 XaDiARJqzVTrfGEpMudaTt9OVuKXHbWGmdnE4FrXFOa1MtMFDHS7SqvcKIEvDxXGKFUj
 rwgi3cfThG51m+LXaHCpR58Jg2qTFVJTKuXE2C4fxpS522Ys9mi/oREbJibnW8L5Nkwb
 fHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712053794; x=1712658594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kF8DIXj6upaIDgYItyrCELeFAUmDbN8yJ98Yufsh5Fc=;
 b=i734Q81r3fVOD57OtojeWJZRormjylJZ5R9tU3N4hUWKlyQCstVSNHJT7h3+Gb8bPi
 t3ZRQEXVfnkd8Okp+HHYZWsevtmFcQyoIkjwD/tKoLC0EIYzTdr5fAIigyWx0eaj3zdG
 V/QDIIB3985015i6G0Zjj+Vy1w1dG/QUKlx294fJ2dsCG/UkzmnyUVKeYfC9R4WAbI3G
 FHAG0UbTfsTTa5zXhe/jOdkbR5AvosljgbVOKoL9ACH/FDi6ruShP90kauL6jRSuwf+O
 +zYpqmBXVeaeMSAutX41/rHn5VbbxS5OiAEw9dAaHLBSeuRBnZZgHkgTqqWtuJTG/CAA
 mo1A==
X-Gm-Message-State: AOJu0Yym3NdqWVeh2YYMS83M+D+sjaNinaRyd2xErkTrJ/x+Vy+Kyfhx
 PHBAibcyWKsIFefkUf5m6GKwAipQx0XxdXNIIMS8uhuMkr5JyA68EhT2JnO++o9JUn8GqUYSWtM
 O
X-Google-Smtp-Source: AGHT+IHYHlLqPCEATaXSkGcg8fXvF2071t3vB8QI5daX1CfAmXI295nfjMS/AE6mLULjKIpTmI9lsw==
X-Received: by 2002:a05:600c:1c12:b0:415:66ac:614d with SMTP id
 j18-20020a05600c1c1200b0041566ac614dmr3631159wms.13.1712053793933; 
 Tue, 02 Apr 2024 03:29:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a05600c4fcf00b0041488895a37sm20586175wmq.33.2024.04.02.03.29.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 03:29:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] target/arm: take HSTR traps of cp15 accesses to EL2,
 not EL1
Date: Tue,  2 Apr 2024 11:29:47 +0100
Message-Id: <20240402102951.3099078-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402102951.3099078-1-peter.maydell@linaro.org>
References: <20240402102951.3099078-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The HSTR_EL2 register allows the hypervisor to trap AArch32 EL1 and
EL0 accesses to cp15 registers.  We incorrectly implemented this so
they trap to EL1 when we detect the need for a HSTR trap at code
generation time.  (The check in access_check_cp_reg() which we do at
runtime to catch traps from EL0 is correctly routing them to EL2.)

Use the correct target EL when generating the code to take the trap.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2226
Fixes: 049edada5e93df ("target/arm: Make HSTR_EL2 traps take priority over UNDEF-at-EL1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240325133116.2075362-1-peter.maydell@linaro.org
---
 target/arm/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c8a24706750..69585e6003d 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4585,7 +4585,7 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
             tcg_gen_andi_i32(t, t, 1u << maskbit);
             tcg_gen_brcondi_i32(TCG_COND_EQ, t, 0, over.label);
 
-            gen_exception_insn(s, 0, EXCP_UDEF, syndrome);
+            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
             /*
              * gen_exception_insn() will set is_jmp to DISAS_NORETURN,
              * but since we're conditionally branching over it, we want
-- 
2.34.1


