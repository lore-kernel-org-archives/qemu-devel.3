Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65F9CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 17:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP24h-0005UH-GC; Mon, 18 May 2026 13:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP24X-0005S2-3V
 for qemu-devel@nongnu.org; Mon, 18 May 2026 13:48:09 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP24K-0003m4-2T
 for qemu-devel@nongnu.org; Mon, 18 May 2026 13:48:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ba4efedbeaso18933635ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779126473; x=1779731273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtjlPS4phLWwZXeGR6GMzLRtHY+h8FoS/XJKt4A73dQ=;
 b=JJDPFsMnAD/M5czstN6YWLVlGtynx7NW3aXnstTYAMZAoSTjsKV6sUK+UNvn91G4sb
 wY4Ue43quAfsvpCj+Bk4GLsmzBLYYVYFNjMobE5wLKu3tcVWa3rew6QbguZ2Y4T+LhhH
 NHVEGVruN/ajw9qROmeczT4y/GhWv9QUlLRWcmQyB/AagrTnX71V20PEqL1qqbF2gkT6
 1pVDU/znV7r4/GJVMDQMr1GOwG64K1nUcf1G5q9/atQpU3F2adDqoktdbFVjMuAIrASG
 h9UKLX3wS/03jq8SoLmvH6opSBsm1khwd0t1lJQkem87rz9G9W8kQ1etq+Ypj979CbXl
 EPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779126473; x=1779731273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KtjlPS4phLWwZXeGR6GMzLRtHY+h8FoS/XJKt4A73dQ=;
 b=k3akUs1xQje3zDOSzk1N6Dyz3JrN4QBVCw2yNk2LPOaeHfl1Rh/SOBLS2k33wQjSYD
 MB4oc6YPnFNio/S4VFNzgi0wAScyKAfPYsz3uw9a2q/UpYk8mdlg2mF3eqovf6QTNM9F
 Sfd37bbu9erkT8Njz7o9NUqwsjkf3WzetLaXpQRMMOlr7AFphycdtPUugfn+X9rlt+hb
 quNhil6lgfMy2gAQHchfM6fIi9q5R9LY4gQyt1Y3+qD9Q4gbmSm24UF9pSHFI2DbXPXE
 LA0zPg9lvfg4keZo4YDC6P8YTy6Yhh7KOVfFTHE1mvuwg+J2QECWbj8rem8pP2WIxx9v
 BvoA==
X-Gm-Message-State: AOJu0YyUTwg7D8JCety7fkPruvYfVaBnqQPAsAoOnzKm2R2WFfFY/wXr
 WiXrZAy2iba4/w938Dp1UVUwGJCTp/bRDlDea3BHcpmv1mkN7eIVRZaE3USrdleXV1gjXuO2jWm
 gtP2SFj8=
X-Gm-Gg: Acq92OGxa8pIOtN3pc53dH3FiTAqlz8ys2JjXMZpbEnKHuzecmTkLPqUWzJrKuEyDAY
 iyEpYP8gCyVq81OsZjoT+uXP3GB/oXRrtnMHXGYTv9mQXagUTU0+/EkU6TsC0o18CSXm3IpTTtx
 p4tLrn0NLTdq6vI3Mc2Uf70Q4RC563/1dSCC5/lp01umHu0QcwtVFIBi73ahdDnXjq+beMqi38p
 XzbV7Qw6ktSwRxr5ZvcuDj1rOxbRzrhthzWvvrUZeZ8FkpCeal7orFb49p7m78UFoN+GsmjhzeR
 lgqVgCZbh/mZ7856P78BFzcxUVMdGaGmh73czoxSLtVnzIGRS6AHDeBDHipQ435Ort+6bFFfPmx
 MUveyjB6roVENl63WKaM/C9QEm2KBeM+/iysvTl7odDNF68QKwhc55ndAZEsh1976+x6I0PRbW1
 CQI8yibWWT5ZSbVv//vzs5Dvyqo/MPGVhm8ao0lo4=
X-Received: by 2002:a17:903:8cf:b0:2b0:4fb6:85ce with SMTP id
 d9443c01a7336-2bd7e8c570cmr113802005ad.21.1779126473067; 
 Mon, 18 May 2026 10:47:53 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d12e38dsm157334905ad.77.2026.05.18.10.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:47:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 2/4] target/arm: Implement CB, CBB, CBH
Date: Mon, 18 May 2026 10:47:48 -0700
Message-ID: <20260518174750.660258-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518174750.660258-1-richard.henderson@linaro.org>
References: <20260518174750.660258-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Compare and branch instructions, with various operand widths.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode      |  9 ++++++++
 2 files changed, 51 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9a27c4c6ec..293aa43cc9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1774,6 +1774,48 @@ static bool trans_B_cond(DisasContext *s, arg_B_cond *a)
     return true;
 }
 
+static bool trans_CB_cond(DisasContext *s, arg_CB_cond *a)
+{
+    static const TCGCond cb_cond[8] = {
+        [0] = TCG_COND_GT,
+        [1] = TCG_COND_GE,
+        [2] = TCG_COND_GTU,
+        [3] = TCG_COND_GEU,
+        [4] = TCG_COND_NEVER,  /* reserved */
+        [5] = TCG_COND_NEVER,  /* reserved */
+        [6] = TCG_COND_EQ,
+        [7] = TCG_COND_NE,
+    };
+    TCGCond cond = cb_cond[a->cc];
+    TCGv_i64 t, m;
+
+    if (!dc_isar_feature(aa64_cmpbr, s) || cond == TCG_COND_NEVER) {
+        return false;
+    }
+
+    t = cpu_reg(s, a->rt);
+    m = cpu_reg(s, a->rm);
+    if (a->esz != MO_64) {
+        MemOp mop = a->esz | (is_signed_cond(cond) ? MO_SIGN : 0);
+        TCGv_i64 tt = tcg_temp_new_i64();
+        TCGv_i64 tm = tcg_temp_new_i64();
+
+        tcg_gen_ext_i64(tt, t, mop);
+        tcg_gen_ext_i64(tm, m, mop);
+        t = tt;
+        m = tm;
+    }
+
+    reset_btype(s);
+    DisasLabel match = gen_disas_label(s);
+
+    tcg_gen_brcond_i64(cond, t, m, match.label);
+    gen_goto_tb(s, 0, 4);
+    set_disas_label(s, match);
+    gen_goto_tb(s, 1, a->imm);
+    return true;
+}
+
 static void set_btype_for_br(DisasContext *s, int rn)
 {
     if (dc_isar_feature(aa64_bti, s)) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 01b1b3e38b..8fb1314bfc 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -208,6 +208,15 @@ TBZ             . 011011 nz:1 ..... .............. rt:5 &tbz  imm=%imm14 bitpos=
 # B.cond and BC.cond
 B_cond          0101010 0 ................... c:1 cond:4 imm=%imm19
 
+# CB, CBB, CBH
+%imm9           5:s9   !function=times_4
+&cb             cc rt rm imm esz
+@cb             . ....... cc:3 rm:5 .. ......... rt:5       &cb imm=%imm9
+CB_cond         0 1110100 ... ..... 00 ......... .....      @cb esz=2
+CB_cond         1 1110100 ... ..... 00 ......... .....      @cb esz=3
+CB_cond         0 1110100 ... ..... 10 ......... .....      @cb esz=0  # CBB
+CB_cond         0 1110100 ... ..... 11 ......... .....      @cb esz=1  # CBH
+
 BR              1101011 0000 11111 000000 rn:5 00000 &r
 BLR             1101011 0001 11111 000000 rn:5 00000 &r
 RET             1101011 0010 11111 000000 rn:5 00000 &r
-- 
2.43.0


