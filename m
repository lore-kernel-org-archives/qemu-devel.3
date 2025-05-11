Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A2AC3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDP6-0003XD-TH; Sun, 11 May 2025 16:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP3-0003EG-17
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:05 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP1-0006Mc-9M
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:04 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b1fb650bdf7so2271026a12.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995762; x=1747600562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vP/tqNEXhh7xq2lmGpddVDaMuSRJdXzb5jFSxGcQeLk=;
 b=UWl3iP4OHozsrz1J9qpFjZ3fvZcALKeNVcuGZ178GhFBk2ijT7ZOX0yyL9mSZjon/R
 QiBlPJUQy7/+dntp6TI+Lvh+iNMUAB2vDy4ztUqGJjRzXuChKB3HAKgLPjR46TBDhOO7
 lBfi3krsccClMIzpYNMwUZtasWB5wIH3JckSk/XJ88s/cTrNlCpXKMyE+7+qZT9nQZDJ
 yZJP/51Fm7trETVPdprpdcUP5T9UG39KPzfq4Q9NBecTSFmbBRwio5gKMTOVtvFZOfBo
 TSy0XRCDgLo2DQA2zLGqkBpUDfmbVYde4SU6KgXkHr3CBRHi8n5WQVU+4r1Tj+n2sLtV
 PcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995762; x=1747600562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vP/tqNEXhh7xq2lmGpddVDaMuSRJdXzb5jFSxGcQeLk=;
 b=n//SMjtihl1p5MY0XGBcAQ1ui7s2yl6Kof6ZT/kLv090aekRKM7WTmTHlahTr5Dg45
 V5gP7lm5V77A6vvTz8ZWTaEiLC5C0YPRX7zBkmwumddgX9Fezgc8RcFRpzKPi9r4Q/h/
 ZBCWN5TOsOKhFEiewXl0iuZWCpyEeNJFeGKfQdblvDrE5dQQY6TYX7fZZe1lnnYk73x6
 V37Mzf7fjf0bVU1Tyz7ib4Nxx1VcdAszK/pSN6r52IbrjLys/4pdo78CFCjjz5WebeBv
 eVqfc9l1MAp3L1OBd/mzptDSIabXkBh0NNJmVI3B5JQjSjC40GJHKw21XGNpT8QOi+Lw
 74uA==
X-Gm-Message-State: AOJu0YzoKVL+FIoTBF6QfA+TjOCEuSytboU4i4DpJRm6vVLhbMjEnYQC
 CB5BzFGVcYr/SWOwSkWKLlDZ4AzYSSETYv7O0bfmtIz5zoLkvhbHHfu4lhVucbPIUSBSj94jgrU
 +
X-Gm-Gg: ASbGncvi8UbyTpf7bidtcu/u1VyaaR8kn2aQA+kd26BRgfX2Er2wWRumbiM97hOqx02
 wIifWtL2l7pziggnhbAJe87GLQG4QJO0K9s2nXcUEmm8hnArNoRdmNZtqSf0iW+j+/mxzs3vKeq
 x5nhwDZHRbYbxw+yOTqmy3ZvL2DTuE+im5biHaZ/cD7hyAyIRrv9Szz3PjzSYEZkV4QaHghL7qJ
 Tg5HuFAHqK+dex3UNfNBBrA+C2EOH/eLZdpKXEM6X477TXbHv6EcbUyV3SYZwGKsNtrcaZafsHB
 30fhzBoA+ScY4aQcnTiR5Y+AdNfb4MqdxgXJJVFOZkt8SRRHNBsWni5KIMSeMeDyoRqcuET/sNk
 qY9gPS5nIZw==
X-Google-Smtp-Source: AGHT+IFIue58VQETB/Sfe/JJmAMrZaPptOzXx0C6catwjlqwU05wL7+ZT84wTvruRFDWuCbr+YB9pQ==
X-Received: by 2002:a17:902:ecc6:b0:22f:c19c:810c with SMTP id
 d9443c01a7336-22fc91a20b3mr144529855ad.51.1746995761854; 
 Sun, 11 May 2025 13:36:01 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:36:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 18/24] target/m68k: Move gen_addr_fault into gen_{load,
 store}_mode_fp
Date: Sun, 11 May 2025 13:35:40 -0700
Message-ID: <20250511203546.139788-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
index da3293d762..ab6db2cd57 100644
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


