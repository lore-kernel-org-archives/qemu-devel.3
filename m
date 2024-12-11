Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA025E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPci-0004Np-4Q; Wed, 11 Dec 2024 11:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcJ-0003r2-SS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:16 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcH-0001BT-BW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:15 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-467631f3ae3so22935221cf.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934671; x=1734539471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OheJzngdS+HhJoEVosRxkCExJJDmRaec59L8+hjrWV0=;
 b=vkSEz7GSHozHWh12+ZrLKk0G04HJGHsswdSaFi2U0nfVbj0VxKGcADqB39MagM9Ky3
 8MSH+nWyetxQ6+mIQyqSRiQqq6BC97XbFbKt87RiVceyzu1x4/1ZijKJ9OO+K1+FUImG
 BmZvP6xE6s+hQ4hfob+z7994P7iNxZ/bG3HY0jwtWkOQNgetucwqFLgYzxo8eSyflXY9
 MhMizdcTK8fn52qS15aY0CBcXYNLDC+q3lhklZasXgW7LgHNR5O6MoKvZdt/kIgOfv3m
 4kFKIUYn+0A8NWbNuthrFEt6kQuYlr8TKWC54EF+2lzDnU7jQXVQv1agBz57hUrDgJM+
 qXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934671; x=1734539471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OheJzngdS+HhJoEVosRxkCExJJDmRaec59L8+hjrWV0=;
 b=Kpx/INVZoPgd3rGXX4HfqeZMnPr9Sr+q2vMDsUIQEs8k9+LefKZCQ9NYv0Es3DxQXL
 Z4CXDucrpzSNlUpjHBkr9t8x4m6J6VS44z5lnvE72fKQeMhruX8vGTOqzD8kLnvVLeRK
 KnZe5ZXygj/yT9NgHOtuMyTyRvc7PONwXxEsMpBUwaL+99kmpEjcs+EVHkm55AWjaJTJ
 FnJjwJPEYkOanqq33vtQDktgF570U0LSBBWw5gJFoIe/67qHZLOIMk2jU2d/O7jFkHil
 jxY/eHQ1rBeeY4SETs0NU7reWx28EnWkzeXtswTQ11iizY8Cz7r3TI5C93SXgKhQAosy
 U5Xw==
X-Gm-Message-State: AOJu0Yz9iFE6ds9P7TqO4areyr90gBQao8T7K007sw1PmjOsPOvP65bZ
 K1JjPOO+0RW9DzaADY6SBTOCBXUZ7g2Yt2lkb2aGLCT79XfylkOW4rvlBcwlCgkHR5092e5aiTJ
 9Qs5dNgt0
X-Gm-Gg: ASbGnctweANZ2HiZhN20AIaDDz6Uo1qbnzauNXir0xUA6fqLqsv0sB+ZyYbSYdTUMZb
 c1Wf5phES51RHwSCYQEIkp/+kkbqjkh3XIa3sNVcwKsR0NYZa0WuokqmPTlNMBsii7jEoba9+PQ
 w8dMdZ77VXbBtVW/YbIa4c4Phs/lY300lJxovpRQOEvkN9kO7urpx2AMA49TPnyyCL25AZ2gFr4
 ekhP0nHawAZYy+VEDVG9vcsXtKTjxRV5mOJAcVkv0bWfogf5CM7cM26BeNiBw==
X-Google-Smtp-Source: AGHT+IFcncVsV1kMwXE8zgzLyMCwmAqsmRno1cEXAYbyqajt7lelC/ix8x1m+BiF9rZF0TiJgrr1iA==
X-Received: by 2002:ac8:5e52:0:b0:467:50d0:8866 with SMTP id
 d75a77b69052e-467953526e6mr7806391cf.19.1733934671070; 
 Wed, 11 Dec 2024 08:31:11 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:31:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/69] target/arm: Convert PACGA to decodetree
Date: Wed, 11 Dec 2024 10:29:33 -0600
Message-ID: <20241211163036.2297116-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x835.google.com
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

Remove disas_data_proc_2src, as this was the last insn
decoded by that function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 65 ++++++----------------------------
 target/arm/tcg/a64.decode      |  2 ++
 2 files changed, 13 insertions(+), 54 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 00e55d42ff..ca8b644dc7 100644
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
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f0a5ffb1cd..a23d6a6645 100644
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
-- 
2.43.0


