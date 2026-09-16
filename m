Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25948C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ofj-00022s-U9; Wed, 16 Sep 2026 08:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6ofh-00021s-25
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:23:29 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6off-0000iZ-9M
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:23:28 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b390bcab0cso576297eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789561406; x=1790166206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=svABQc2G1+qSjR7L7fw3ixodXbDjdkhkdfPAC+/94/E=;
 b=NIabHkym2ApynphGuTCXdVrtJKNTh7TwKIzlNguyW8flL6T/bwgxoyFo9RcdA03UzT
 5TTzIyMNaXewolN166nEQMiSMe4DJgLRjmRbYNDo6bmSpg9shjVI//+s35FCo1yX2EYX
 fglpKP8JKQAyJBN2fZ7h0jmQEr2pTAM+DsaAA3BWj/Kwh58P39BNvFbM1Rdg8fSF+LKL
 UsBd11qbQOqHvnZkJIUnzc/H99P0RyNx32gEtBTEfnCN3TsJcUT1O977jqZ41l86g5AT
 3Tn4F1xT8qwifa/XwCC5YBw6ET1RIUiks1Xf2OMqKUS/imL7+XOkhwCgfTZlMnjHYqbx
 L8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789561406; x=1790166206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=svABQc2G1+qSjR7L7fw3ixodXbDjdkhkdfPAC+/94/E=;
 b=uSuHBmQJ30rIN4mGocyqekzynbkekHjzwdtYfcoxznOT+1B+uUqxcuFzCAyHUezyUp
 jPpKo08ZZmvu0IiyCNHRDpyeiPRr7g0HSm26HBFr3SLxNOoRuoTab8Y1ko/jxJNdgvVB
 rOnpPsg6BUCrxlg+rE3Pj1Dn6Ci/0vATIvkC4yD43ILMFoLf4/o3wCawgWFwdY2aL1uI
 OdRThIjn/nN+1HcEIjxloy4mbhZyZwnS1e9M4jHTIGjiPWBfznOrnf4DnXByw4+B8Z+v
 fxZw8l+D/cqlsP3eeBbqlrM2U5EnD4rZuO48aAI2WJOcf/Mq8bpxuF5uZU4i/GzBkHCX
 gZnQ==
X-Gm-Message-State: AFuF++mhZPjaJdSl6Z5QzqqTQVIIwO65DCiXnxOpngUJqx+NxM9TPDsA
 Q4+P4n83XkIxpWeTHOn5gkkpIhCG+my01mmyodKis6nvywAJldN1uLuOWCZBav1vTTb76+SXKpY
 nlcx3KG0=
X-Gm-Gg: AYBFou2yM2Xpg6vdtynovwjV3hsoPJ+HjpKv2Or9ttqXqd0qIqpwKGmCFChUtzXBB/O
 CEDRAbYg6GRnFf7Gc3Mt0zBr7YwwcAMXUx1id6t8tBodCiSgSOOKUAPPkf5lkOxkDzBmGP51fkF
 QD/CpQBmxnNjFuiP42KwAq7ulzV3AztVmUI/MuBSPUkaQNzFCYkh2Ojv0bKV0ep+yVinQEp+f0q
 NFlRTJmfwVZNTG/v77DW25jkv8VwCQuJMRBtXoYMzYMZ2pZVxMM5zQwDfqIodLvX9bvvFAKuFY2
 oHQycQeSOQAXuPSiDsQxxYED2zMIZLpIJnCiNfuCY+GlKQRwwoG7BX87VYv0W/NL1MaaQ9RukKh
 zPMBJHgTpdVjQz83BvmptPHyEBAxyr/ZjjbT6jiHhnYutqbVQOjQ9VjFI0kkvZgtoxpeiLXB46e
 z+aZMQwd1f0RRMEkZpuN1nHo5+kfCoujFQlQVavf36mgclwxf7ne2s6FbVBE8C8bzzYXReIeMf1
 f99y0w=
X-Received: by 2002:a05:6820:c8a:b0:6b7:46fc:1d8 with SMTP id
 006d021491bc7-6c7d41dcf3dmr2401091eaf.55.1789561405728; 
 Wed, 16 Sep 2026 05:23:25 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b0520asm8254656eec.27.2026.09.16.05.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:23:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 1/2] tcg/optimize: Fix expansion/simplification of deposit
Date: Wed, 16 Sep 2026 02:23:21 -1000
Message-ID: <20260916122322.3224918-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916122322.3224918-1-richard.henderson@linaro.org>
References: <20260916122322.3224918-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

When we computed z_mask/o_mask for the deposit, we may accidentially
prove that the result is a constant.

If we let the rest of the code expand as-is, when can we get to the
end we'll see the constant, note that it's the same as the current
value, remove what we think is "the opcode" that computes this same
value.  But in this case we've been expanding deposit to multiple
opcodes and the removal of only the last opcode breaks the expansion.

Fix this by noting the constant result early, before expanding,
allowing the entire operation to be removed.

Cc: qemu-stable@nongnu.org
Fixes: 5f747705a4 ("tcg/optimize: Lower unsupported deposit during optimize")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4449
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index bd91220650b..1e4d2a0a425 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1708,6 +1708,23 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     type_mask = MAKE_64BIT_MASK(0, width);
     len_mask = MAKE_64BIT_MASK(0, len);
 
+    /*
+     * Compute result masks before calling other fold_* subroutines
+     * which could modify the masks of our inputs.
+     */
+    z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
+    o_mask = deposit64(t1->o_mask, ofs, len, t2->o_mask);
+    if (ofs + len < width) {
+        s_mask = t1->s_mask & ~MAKE_64BIT_MASK(0, ofs + len);
+    } else {
+        s_mask = t2->s_mask << ofs;
+    }
+
+    /* Sometimes we prove a constant from non-constants. */
+    if (z_mask == o_mask) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0], z_mask);
+    }
+
     /* Inserting all-zero into a value. */
     if ((t2->z_mask & len_mask) == 0) {
         op->opc = INDEX_op_and;
@@ -1740,18 +1757,6 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
         return fold_or(ctx, op);
     }
 
-    /*
-     * Compute result masks before calling other fold_* subroutines
-     * which could modify the masks of our inputs.
-     */
-    z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
-    o_mask = deposit64(t1->o_mask, ofs, len, t2->o_mask);
-    if (ofs + len < width) {
-        s_mask = t1->s_mask & ~MAKE_64BIT_MASK(0, ofs + len);
-    } else {
-        s_mask = t2->s_mask << ofs;
-    }
-
     /* Inserting a value into zero. */
     if (ti_is_const_val(t1, 0)) {
         uint64_t need_mask;
-- 
2.53.0


