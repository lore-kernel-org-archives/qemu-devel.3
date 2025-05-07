Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCC5C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm5A-0006FR-Rm; Wed, 07 May 2025 17:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4w-0006CO-Nj
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:23 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4u-0006FG-De
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:22 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso305432b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652397; x=1747257197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lm1A/KV4J4dNi7kdLun9oFplRSfgSn/54CeFBMpi4Ws=;
 b=YPnkW7LFm4DfxiNyVibp6KgE724bzBul1/D+Lq3Vh6oq9gvxdmTAuI3ZWe2UcFvVvT
 KroV90A7Ujc8S2E7Z0wZyaf7pU2yhUydMeYbAQfBHfg3ytKH4lhDpEm/CtxTeONBYTKd
 prrFb9bZxIc6RnPb9Qe3VwZKiJ0ssIAaWbL1gH1yK1YFdnZec951VDmlp6aL8AX5QV4E
 GSEH2Ozo3fMqMscf0sA0btoTMTmFAlAGUfV+2K/1WlGFpdIcpvsP1monfdk7PXKwoSev
 ta92XLl3zKU+Xmfr5HrlnDLzexjV0BdmWXeGDMK7DJKYMimUPHl6lBUGN5FoRcxLm8d2
 QL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652397; x=1747257197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lm1A/KV4J4dNi7kdLun9oFplRSfgSn/54CeFBMpi4Ws=;
 b=N9TgEd0Y+ub9LwylfpoL0IHf3oshVU67qmHjIcOIqdX9CRM1UaKGhPAsKoez7farSD
 nhyonTNKmvPFlHttyao8u1A/D0GVyg9DbK/GiIEst9CfFq0UO9affZRvzbfGkNgieL/F
 02FVwi+hc70KWLXwAie+QZH30vMZPmS/XVL1Vjgu1kRNwlgu+sekJDf2RKuGBOT029Dd
 0VF3SUaeS/RmgQsowgVw17ZxNmdK1pytD43ng83/6qN8wpfoNPCQFGmPLDUc18tvVneD
 YVHwdoH1lO5vW12vf0itBwjhUjiKc6h5vkak5jWq5aEZ8Jff8pEunvNuIH2tbQmMAv4h
 uO8g==
X-Gm-Message-State: AOJu0Yw8cyQChG3mF/k74oexirXVzlKouKOG2pmSwL7Htb83ttE9fmGc
 HJB4OS0g1hS1tsqKS/tT0nMaZ+pTL167wFHuEIbsdwFkNOXIdCAPvdHvtqQoJjAay4Uwd1uHkC9
 e
X-Gm-Gg: ASbGncvK8YAT0oKejygZEjJdQ5MYhbJ3G+pQY3iasyL719HMj/a8/B+0jxJ+xx8fJkh
 9lGHJIF978OfUn0CM6Fnp4S9kWWSqqj1kQzitH5PEmzZZmIm90r2vm5ddMrf+No+ywMyc8rBoNq
 EyAPgZaqVvBHprt+EPPNQfUKBfl63ug72Tzri4yqD0zNNpNTZQSJy750HzFvw6o/eIH1d9dwEVo
 BgV2xbjtiyxHTnCXvP0Bky1CvBohUp0PgZpommEvmecwlwVYavmFahGeg1mZZZCCpg9oRUKAROn
 fMAuCDwqLawpVRsDWkA8Q2LYnpS/+VvKvADQztVBHPaVq8YhKxrkxUGnUTnJKg05yJY1uIBmH20
 =
X-Google-Smtp-Source: AGHT+IEyynKhe4aVfzKw1NgZUgir5Mt3eLMIv2h+Vi2tCk1I+GyDbkjdL2a37UhPXgmrzB+mciXMiw==
X-Received: by 2002:a05:6a21:478b:b0:1f5:9016:3594 with SMTP id
 adf61e73a8af0-2148b714690mr7627258637.18.1746652396930; 
 Wed, 07 May 2025 14:13:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 18/24] target/m68k: Move gen_addr_fault into gen_{load,
 store}_mode_fp
Date: Wed,  7 May 2025 14:12:53 -0700
Message-ID: <20250507211300.9735-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Move the exception to be raised into the helpers.
This in preparation for raising other exceptions,
and still wanting to return failure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index a6afde7f49..642e80857c 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1024,6 +1024,7 @@ static bool gen_load_mode_fp(DisasContext *s, uint16_t insn, int opsize,
         return true;
 
     case 1: /* Address register direct.  */
+        gen_addr_fault(s);
         return false;
 
     case 7: /* Other */
@@ -1080,6 +1081,7 @@ static bool gen_load_mode_fp(DisasContext *s, uint16_t insn, int opsize,
     case 6: /* Indirect index + displacement.  */
         addr = gen_lea_mode(s, mode, reg0, opsize);
         if (IS_NULL_QREG(addr)) {
+            gen_addr_fault(s);
             return false;
         }
         gen_load_fp(s, opsize, addr, fp, index);
@@ -1113,6 +1115,7 @@ static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
         return true;
 
     case 1: /* Address register direct.  */
+        gen_addr_fault(s);
         return false;
 
     case 2: /* Indirect register */
@@ -1123,6 +1126,7 @@ static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
     case 7: /* Other */
         addr = gen_lea_mode(s, mode, reg0, opsize);
         if (IS_NULL_QREG(addr)) {
+            gen_addr_fault(s);
             return false;
         }
         gen_store_fp(s, opsize, addr, fp, index);
@@ -4887,10 +4891,9 @@ DISAS_INSN(fpu)
     case 3: /* fmove out */
         cpu_src = gen_fp_ptr(REG(ext, 7));
         opsize = ext_opsize(ext, 10);
-        if (!gen_store_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
-            gen_addr_fault(s);
+        if (gen_store_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
+            gen_helper_ftst(tcg_env, cpu_src);
         }
-        gen_helper_ftst(tcg_env, cpu_src);
         return;
     case 4: /* fmove to control register.  */
     case 5: /* fmove from control register.  */
@@ -4909,7 +4912,6 @@ DISAS_INSN(fpu)
         opsize = ext_opsize(ext, 10);
         cpu_src = gen_fp_result_ptr();
         if (!gen_load_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
-            gen_addr_fault(s);
             return;
         }
     } else {
-- 
2.43.0


