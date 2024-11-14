Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F34D68B36
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcIb-00059P-Lo; Thu, 14 Nov 2024 11:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIO-00053L-9s
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:13 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIL-0002JE-9r
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:12 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e31af47681so652330a91.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600128; x=1732204928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l6VeKTlRuD0Xy07QiXe4r1yW5BzO376HoZWUmX4DLoU=;
 b=ga9lUu8Lch3Ve1RO2rV7glzYz/sSC/u2UKPn+xqVKlfxvl79ff9+VRNPqppKL6Olbn
 L0edK1GuLHkXpHwJuw5320905ElB+EvdTiH0Ay51X9R99IMCoZF+5xkmiooDfBJRMb5N
 uAP3gjyJn/oIWOx/nHhP6xKFaaFfW4ZfhME+dVokU7Z2JlZM8f5oQB2TXUE9+srIC1ym
 j5A+lIk+NMHfc2matmw5k0sIr55YqQMlcX2go5cPfdnPzwcjfUAW47jxd1N6AhxEGsy+
 9JSYCBg0yFon88/1MOZtfuVbxDyKh40xdtDzV3tPKFeZRX1pMP6voVMK2XbDD2lT+Svj
 0bvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600128; x=1732204928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l6VeKTlRuD0Xy07QiXe4r1yW5BzO376HoZWUmX4DLoU=;
 b=p16Cwty/6Kv2Tt7+gKWxGVC7Tfz/OCsyTa9A31Aq8rrzskeaNBPU+sWH8oM8/1U3u7
 kz9tWj3EQ/AMxGsRyx2a0hf/H9LByNiYQfe/rqjTDnIGn+gk5y/ahtIoASspniphmoFM
 XggQGYk/tO3Aqi1zIdEVrmB0bqSKijdQnBtYYXAHEnvKlWAKT358YgdoQfS+2zeIJ7CP
 JS54ewyWIPTMstQq5ZUxsP+qC+ZNgT2TTahARXquL36F/9uQDQN1baGsYWeRfbqpNERT
 x0uwZ5joa213HodejhzKPk2GWkyUn9fweOyuGpxMs7k/PCUfxxCpHvAfzGbiXxieDrtE
 eizA==
X-Gm-Message-State: AOJu0Yz7vHibg7w5VHb+AgfVEzBXECUyOmDFW0g3als0JzQkDeBBVxz1
 iE7RNMXL33FID/+KggTQ8rSR4zDBWv9oORS3GNABns6IpIHCIQjrNPk6+vMdcUxmGusbp8P+c1q
 Z
X-Google-Smtp-Source: AGHT+IHF5hmTJojDMsBQyX7XdkOmm91aDExazdJ38la63nTUZIw4KmnyvC76QsCNcvcA+3I7Ip1syA==
X-Received: by 2002:a17:90b:2548:b0:2e2:e092:5323 with SMTP id
 98e67ed59e1d1-2e9f2d5cc36mr9029570a91.29.1731600127730; 
 Thu, 14 Nov 2024 08:02:07 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.02.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:02:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 39/54] target/m68k: Do not call tlb_set_page in helper_ptest
Date: Thu, 14 Nov 2024 08:01:15 -0800
Message-ID: <20241114160131.48616-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

The entire operation of ptest is performed within
get_physical_address as part of ACCESS_PTEST.
There is no need to install the page into softmmu.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/helper.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 1decb6f39c..0a54eca9bb 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -1460,7 +1460,6 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
     hwaddr physical;
     int access_type;
     int prot;
-    int ret;
     target_ulong page_size;
 
     access_type = ACCESS_PTEST;
@@ -1476,14 +1475,7 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
 
     env->mmu.mmusr = 0;
     env->mmu.ssw = 0;
-    ret = get_physical_address(env, &physical, &prot, addr,
-                               access_type, &page_size);
-    if (ret == 0) {
-        tlb_set_page(env_cpu(env), addr & TARGET_PAGE_MASK,
-                     physical & TARGET_PAGE_MASK,
-                     prot, access_type & ACCESS_SUPER ?
-                     MMU_KERNEL_IDX : MMU_USER_IDX, page_size);
-    }
+    get_physical_address(env, &physical, &prot, addr, access_type, &page_size);
 }
 
 void HELPER(pflush)(CPUM68KState *env, uint32_t addr, uint32_t opmode)
-- 
2.43.0


