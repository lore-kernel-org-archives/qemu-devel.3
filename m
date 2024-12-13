Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162D0E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XF-00075P-98; Fri, 13 Dec 2024 12:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wt-0006sn-Ax
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:45 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wp-0001SU-SH
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:43 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so1374595f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111158; x=1734715958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q06RjwqfoGMqijUanpYdiBSZsyuy9j4pDBF+J1wv7+I=;
 b=IsI7w3kn/tLlhLu/uEo/yp+UJKIKeVVCoIkBNVcPRnLt1ncYjBo2x4pyZPdl2gCDmQ
 M2RBY48eZJ4dTkeAc5RrzHkjGK+tuOyxev4lDdSzfaHTy2pa64sxq7Zxj48armGUTBEu
 aMz4B7300iuk4WedtBaeZVFlFGbBrdHW6bM6NjSa4mEgcXdXuoRucn0v42C6LcM9b3Qf
 P+zibzkBtfhufMwRbQDTCbJq2TtF006vu6xzdfFVPl/TYlWmayucrTOMldw0TIcAPL/p
 lBTVkeLa4M2mGImxloUSMWe18HK4giWWz5iHAnbND0Ne/zlPsJs3ljQK6OUtP/g8Y41H
 m5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111158; x=1734715958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q06RjwqfoGMqijUanpYdiBSZsyuy9j4pDBF+J1wv7+I=;
 b=bcsIgKLh834AeMcyiYiMXuWMseAWYxQMLEwXb0b1/2pdR6o4L28l8Gv3xOkeS+/IEZ
 aLadPpXIpf+sA9pXnGh+rQ2QZ3Rnb3GoRbW0p7bFvzKBQj1d3eXhndRe2ur0mi1tWljK
 YnaIU3C+Llid4qjsV5ZXqnk0lXihUM4DTovyig/ZleRIt80WRo7ge3YDh1jMnduaCbyl
 C0joaF+hsm8ciF6E/LsnOo8jX6JPix3CPhT+QGAlnmKW3hsXXkJnnfscs+3KYdRSf+5Y
 rrtnlKUunV5H9zfMNzJyD5b8PmTjOKeYFP+8MvfXzHjAjXkigen2FcIJcPmE8OJGxWa3
 tVqQ==
X-Gm-Message-State: AOJu0YyM7hcSdr3HdF0vEJUJaL1Z65ocBdmaVrGkGrigoiDZeGWGzXQL
 yg128eCUKcBEZs3UT/a6gFs9xRJP5NCfDWLcf4QkTv2qlmAfoqcIgs+JjodhDzPnzZyjazIbTUI
 +
X-Gm-Gg: ASbGncsDxB/WuN18eEdunS5A2YTbI5F1O5WpjIj7HVFudInyKKgeWo7mvUZIoq1dS+c
 JtYe/p/3J83yeBIxCqNnj4x47tjPxRrTrAvriLMUb1hYJD1U8SGXv7R2Rv6ROdnfuabE/N/+aSx
 Xhzj8sZj30R6JIoytxclQ2w6b5wmJuZEb8C/0zM0K2RPerO9s7Or3HKEdqxh2hQQ5XoKqqIc8ff
 43y2CBwwHvqBNThOWt+NJj6pnZvZYBajylefporlXcPllHxhAJY6UjER7dymg==
X-Google-Smtp-Source: AGHT+IFeL9XzmHQQteaI/7IU5xR1xH3XHUUK2VWsr7BEB97Llvpsm7/QzlodJVXDB4HbmFYRkjPaCg==
X-Received: by 2002:a05:6000:1449:b0:382:4b43:c3a with SMTP id
 ffacd0b85a97d-38880abfc98mr2623030f8f.2.1734111158277; 
 Fri, 13 Dec 2024 09:32:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/85] target/arm: Convert PACGA to decodetree
Date: Fri, 13 Dec 2024 17:31:10 +0000
Message-Id: <20241213173229.3308926-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Remove disas_data_proc_2src, as this was the last insn
decoded by that function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 65 ++++++----------------------------
 2 files changed, 13 insertions(+), 54 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f0a5ffb1cd8..a23d6a6645b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -682,6 +682,8 @@ SUBPS           1 01 11010110 ..... 000000 ..... .....  @rrr
 IRG             1 00 11010110 ..... 000100 ..... .....  @rrr
 GMI             1 00 11010110 ..... 000101 ..... .....  @rrr
 
+PACGA           1 00 11010110 ..... 001100 ..... .....  @rrr
+
 # Data Processing (1-source)
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 00e55d42ffd..ca8b644dc7a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7674,6 +7674,16 @@ static bool trans_GMI(DisasContext *s, arg_rrr *a)
     return false;
 }
 
+static bool trans_PACGA(DisasContext *s, arg_rrr *a)
+{
+    if (dc_isar_feature(aa64_pauth, s)) {
+        gen_helper_pacga(cpu_reg(s, a->rd), tcg_env,
+                         cpu_reg(s, a->rn), cpu_reg_sp(s, a->rm));
+        return true;
+    }
+    return false;
+}
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8555,59 +8565,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 }
 
 
-/* Data-processing (2 source)
- *   31   30  29 28             21 20  16 15    10 9    5 4    0
- * +----+---+---+-----------------+------+--------+------+------+
- * | sf | 0 | S | 1 1 0 1 0 1 1 0 |  Rm  | opcode |  Rn  |  Rd  |
- * +----+---+---+-----------------+------+--------+------+------+
- */
-static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
-{
-    unsigned int sf, rm, opcode, rn, rd, setflag;
-    sf = extract32(insn, 31, 1);
-    setflag = extract32(insn, 29, 1);
-    rm = extract32(insn, 16, 5);
-    opcode = extract32(insn, 10, 6);
-    rn = extract32(insn, 5, 5);
-    rd = extract32(insn, 0, 5);
-
-    if (setflag && opcode != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 12: /* PACGA */
-        if (sf == 0 || !dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        gen_helper_pacga(cpu_reg(s, rd), tcg_env,
-                         cpu_reg(s, rn), cpu_reg_sp(s, rm));
-        break;
-    default:
-    do_unallocated:
-    case 0: /* SUBP(S) */
-    case 2: /* UDIV */
-    case 3: /* SDIV */
-    case 4: /* IRG */
-    case 5: /* GMI */
-    case 8: /* LSLV */
-    case 9: /* LSRV */
-    case 10: /* ASRV */
-    case 11: /* RORV */
-    case 16:
-    case 17:
-    case 18:
-    case 19:
-    case 20:
-    case 21:
-    case 22:
-    case 23: /* CRC32 */
-        unallocated_encoding(s);
-        break;
-    }
-}
-
 /*
  * Data processing - register
  *  31  30 29  28      25    21  20  16      10         0
@@ -8674,7 +8631,7 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
         if (op0) {    /* (1 source) */
             disas_data_proc_1src(s, insn);
         } else {      /* (2 source) */
-            disas_data_proc_2src(s, insn);
+            goto do_unallocated;
         }
         break;
     case 0x8 ... 0xf: /* (3 source) */
-- 
2.34.1


