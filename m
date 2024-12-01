Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6604CD49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWt-0001OW-Br; Sun, 01 Dec 2024 10:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWp-0001Kc-0J
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:31 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWn-0004BD-Fb
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:30 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71d56fe8240so1473132a34.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065588; x=1733670388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haSpz6xiybu5idKSoolAukBIcP9mJCFmnFrAn/lywPE=;
 b=juhx7ui8vxtNe6uiRy+oqoToNfp9uKUOOuI6/Z+pkbWdYQOK2wsyreY/6laNp2e6F9
 2MPDBW+B3B6hqwQqwpgSstvxsMK625rRhbHlWZhI+fgQg+V0wOVzDfHAzLVzIvByHBWa
 sNp2bWNGmiWHAhNTFjIUmicxhk0L6yRydEouzhYrOIDHQJC0hwfahPabw1lNRoX1SU0f
 b7hQW7eRVToG/Pswfs6guJvk5xbo5dalEtQNu1EPTEWdtQjMpbu+N+cpCq+umubFfKhi
 DFzrULLWKFi/Tb9HY1ytgU1woh2TeAn0Dkad24vsuI1Y/cmUM6Bmg3wqpTE8ulqkZA3B
 CMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065588; x=1733670388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=haSpz6xiybu5idKSoolAukBIcP9mJCFmnFrAn/lywPE=;
 b=Sb4JO8+RNGRBwh6BMb4GJ4J/p4fGlIwLo1MV1+s/GIOZPiYV/9vPVNVcxn2EEP+UTd
 yrrt3AcE99WZUNeuk5o30zGYiJC/SlibUYkDadMEwyo0x9Ycm/XFb1o9CFWS5xwVE2Xv
 c7y5wfiE57Mjbk45aWP/3ePUet0Q79iPkIa8PffUSSp5qLDtuvnzG2YHFX9cXrN5KKKc
 IeE6wB5qwnDra2eY9P+jtQ9S9zkzhzRI/54ixzPBeqxU7q12g3fUpnVTkWhwBu6ct0zV
 SHSTeaQoOQGLWBhRT/Waq8dQfX2d/Rh06lON8P95zXIS5cbV5ogPJfin7XK1oJ1eARIh
 jQMg==
X-Gm-Message-State: AOJu0YxnmkOhMHeCojua8L/94KFWcdvBA5KPB30c029CIp1habUHLR4I
 HcrX3B+U54bLJHo2w3PZCc+Yl4jca0IcpEnor/XLwChX3tPfuVaSh5UXgUI1szy+ZkewkgJ+e91
 vHH0=
X-Gm-Gg: ASbGnctz5RzUW/Vos2vhybeR6y3aQqSQzIrVA7Wq2GL7jEiISJLYpYbCadbqCcVmcIs
 mqfqTzdz7egusjYpMfwVDymIwp8mZMGYvqNxJND/nJNUmUsLXyLjT3ODEWE0DmkM0/ib0FrYnh8
 HVq0d7smbjpBZ9tgMftdp2eHJ8G1KgNQbSMA0ee9U6pEST+lh6e8TMdyRJ3MtNRM70uC2wsXX1S
 dQ91XvfIgizN7kLDb9BJvWqtiX5PHfr65ZWE0TUu/OrCW33I3LadxTgYJDLhxgcAG783NzWnLTG
 ZH5oeMdnZwxilmxEMQwWux+uZUz6kYOC9pQw
X-Google-Smtp-Source: AGHT+IEEV8oucEav4dhEO+/M56d+6sYL+Gg3kpeNrWp96zLJffmMCnKKLqDnZCsHsMYRSgUhTxLgkQ==
X-Received: by 2002:a05:6830:44a6:b0:718:1606:c2df with SMTP id
 46e09a7af769-71d65c7537bmr14867627a34.3.1733065588264; 
 Sun, 01 Dec 2024 07:06:28 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 16/67] target/arm: Convert RMIF to decodetree
Date: Sun,  1 Dec 2024 09:05:15 -0600
Message-ID: <20241201150607.12812-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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
 target/arm/tcg/translate-a64.c | 32 +++++++++-----------------------
 target/arm/tcg/a64.decode      |  3 +++
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d7747fcf57..1af41e22eb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8045,30 +8045,18 @@ TRANS(SBC, do_adc_sbc, a, true, false)
 TRANS(ADCS, do_adc_sbc, a, false, true)
 TRANS(SBCS, do_adc_sbc, a, true, true)
 
-/*
- * Rotate right into flags
- *  31 30 29                21       15          10      5  4      0
- * +--+--+--+-----------------+--------+-----------+------+--+------+
- * |sf|op| S| 1 1 0 1 0 0 0 0 |  imm6  | 0 0 0 0 1 |  Rn  |o2| mask |
- * +--+--+--+-----------------+--------+-----------+------+--+------+
- */
-static void disas_rotate_right_into_flags(DisasContext *s, uint32_t insn)
+static bool trans_RMIF(DisasContext *s, arg_RMIF *a)
 {
-    int mask = extract32(insn, 0, 4);
-    int o2 = extract32(insn, 4, 1);
-    int rn = extract32(insn, 5, 5);
-    int imm6 = extract32(insn, 15, 6);
-    int sf_op_s = extract32(insn, 29, 3);
+    int mask = a->mask;
     TCGv_i64 tcg_rn;
     TCGv_i32 nzcv;
 
-    if (sf_op_s != 5 || o2 != 0 || !dc_isar_feature(aa64_condm_4, s)) {
-        unallocated_encoding(s);
-        return;
+    if (!dc_isar_feature(aa64_condm_4, s)) {
+        return false;
     }
 
-    tcg_rn = read_cpu_reg(s, rn, 1);
-    tcg_gen_rotri_i64(tcg_rn, tcg_rn, imm6);
+    tcg_rn = read_cpu_reg(s, a->rn, 1);
+    tcg_gen_rotri_i64(tcg_rn, tcg_rn, a->imm);
 
     nzcv = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(nzcv, tcg_rn);
@@ -8086,6 +8074,7 @@ static void disas_rotate_right_into_flags(DisasContext *s, uint32_t insn)
     if (mask & 1) { /* V */
         tcg_gen_shli_i32(cpu_VF, nzcv, 31 - 0);
     }
+    return true;
 }
 
 /*
@@ -8297,11 +8286,6 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
     switch (op2) {
     case 0x0:
         switch (op3) {
-        case 0x01: /* Rotate right into flags */
-        case 0x21:
-            disas_rotate_right_into_flags(s, insn);
-            break;
-
         case 0x02: /* Evaluate into flags */
         case 0x12:
         case 0x22:
@@ -8311,6 +8295,8 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
 
         default:
         case 0x00: /* Add/subtract (with carry) */
+        case 0x01: /* Rotate right into flags */
+        case 0x21:
             goto do_unallocated;
         }
         break;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 34bff988f7..d13983dffe 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -753,6 +753,9 @@ SBC             . 10 11010000 ..... 000000 ..... .....  @rrr_sf
 SBCS            . 11 11010000 ..... 000000 ..... .....  @rrr_sf
 
 # Rotate right into flags
+
+RMIF            1 01 11010000 imm:6 00001 rn:5 0 mask:4
+
 # Evaluate into flags
 # Conditional compare (regster)
 # Conditional compare (immediate)
-- 
2.43.0


