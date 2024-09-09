Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A993CECE57B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniC5-0005Sr-GT; Mon, 09 Sep 2024 13:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBy-0004tM-5n
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:46 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBw-00063u-FP
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:45 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2055136b612so55185495ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902923; x=1726507723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mow0V9G4FldmSnaWptbbOl3icRG+p5X53n012qTF0RY=;
 b=x3DbfAhDX8pIKK1QY2c/iW/xh088YFHjWYfMmKh4SYQ9AWoMpus2TbVCQdKwfAQbkh
 x1IAqZFoj/857w32YKL2YbW+Z11lJ1/WWgzZQ6Jc1CbdSIiOwS1Wc4Y5Yxmtb5qqWj53
 JpPjRsWJFGlZ51pnVaiJQAw7aTITT+ocUfM2hrrymEkm+NtP7AIfxeo6XdXmd24QOs/y
 1fkA7IbZutYKVeC7NBHr6fceKK8S13rLbSzVV/oBwWaA28smxaL/2Le2Gz0cEGKC7Wd7
 6+YUD64aLEndMbWNsYY8l+03AtAlx5Md0D4bxbWrwJhWnpdRVXh9yrXtIgx1g1vhwfHf
 gJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902923; x=1726507723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mow0V9G4FldmSnaWptbbOl3icRG+p5X53n012qTF0RY=;
 b=PlvlDEVembPunmk7Uukop1KK6iwkq0mg3Fc5ARA7pNDVRDmepjG4p4PFM9yakQ616b
 3dwlwJH1FJFUADWLRurUpqPQ7BAKjoxv2UFoRaH2VSi8+3wYbXpedMu2NkBCwliq8rx8
 71cvuL9VjK91VH2Rtca1hbLTWM8TeDNIqyHhmEmimCsQbRe97e/EYDFJnMQyiudLwwag
 mRcyN8Q5bt2NSgFk3bkaNoITFc6maAH2PmlbR8qyGs61n1fWuEl97uVozpmRX1hJbsGD
 sl1jYCNZ9AL47XFTNVjGa0Blh6WjVQwazkqK1tAeGnj+/zj9K0a8DPSyMd47bvBeY0Vp
 ntIQ==
X-Gm-Message-State: AOJu0YzwaRpmfPnsFu/gQz97B9URXjlbVWGG3XwbMcRBVfTO+lxgUDNk
 Ed4SEsnHRC2kHfuqPgexVS7xco2NNyNh9eq9SHLl2mZ6gnhSJe8HDdgqbAwhYT1y9nyGyXvfqvp
 K
X-Google-Smtp-Source: AGHT+IFEejr9xRs5oEBo3oO3YeG7IwM+RiIR6QHKnwFBxA+PG6E2X6COexI2a56iTumG1qSAKP1Djw==
X-Received: by 2002:a17:902:f709:b0:206:cc5b:ad0c with SMTP id
 d9443c01a7336-206f053479amr182542955ad.28.1725902923204; 
 Mon, 09 Sep 2024 10:28:43 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 20/26] target/m68k: Move gen_addr_fault into gen_{load,
 store}_mode_fp
Date: Mon,  9 Sep 2024 10:28:17 -0700
Message-ID: <20240909172823.649837-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index c81d093c61..df886ed062 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1023,6 +1023,7 @@ static bool gen_load_mode_fp(DisasContext *s, uint16_t insn, int opsize,
         return true;
 
     case 1: /* Address register direct.  */
+        gen_addr_fault(s);
         return false;
 
     case 7: /* Other */
@@ -1079,6 +1080,7 @@ static bool gen_load_mode_fp(DisasContext *s, uint16_t insn, int opsize,
     case 6: /* Indirect index + displacement.  */
         addr = gen_lea_mode(s, mode, reg0, opsize);
         if (IS_NULL_QREG(addr)) {
+            gen_addr_fault(s);
             return false;
         }
         gen_load_fp(s, opsize, addr, fp, index);
@@ -1112,6 +1114,7 @@ static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
         return true;
 
     case 1: /* Address register direct.  */
+        gen_addr_fault(s);
         return false;
 
     case 2: /* Indirect register */
@@ -1122,6 +1125,7 @@ static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
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
+            gen_helper_update_fpsr(tcg_env, cpu_src);
         }
-        gen_helper_update_fpsr(tcg_env, cpu_src);
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


