Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0DEC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jn-000119-Cu; Fri, 28 Aug 2026 18:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jl-00010D-P4
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:01 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jk-0004MW-9p
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:01 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so1541476a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957099; x=1788561899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YkaJNMx3LlnyAT8c1M0BxaIxuYtmXIvIWAde/pzZ480=;
 b=q2oG7LFLb9EsKgybXjtCzGB2nJZZ4aG6+q7E6XDviBpxP1qhZKLkBLTCqKXCmZhr/k
 o+CP0lsuGw6FXhNX6YQEBBDAEacJEjFRmJwQ+j7iDW+PFyVye86YvTdc+tcUCL/JXecR
 CcuclDG1pNlQkFoKcziqFCbP5FBRJEDlu2f02STGYWPPcOBVeq4W/3z9TNEi1Q/8p+d3
 tdKvo66HAoScY3ijtZa7Fy/QfkmrmPB1BDXt/i0pqwvB1e99FWP/I4pNLy4rcadbwyXP
 ad7CfC8TkBhTLOA496PCtIjWJcQclv9F+1rHA/23tGt1ydfQoSd8O913KWUByF9b7ga8
 Mcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957099; x=1788561899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YkaJNMx3LlnyAT8c1M0BxaIxuYtmXIvIWAde/pzZ480=;
 b=UbmTBPrtnklVe46z+bXPMtTJcLvZDbYchirTzbnIfBqAUSvaDPHo9DJ8bEcZU53VbI
 5p81oCiBIzg9ofpqMb7AjiCMJbNpQZhtSMiD7B6c4KMQ6RDSV5Z9caqvUfNBrzXRsyHQ
 adhH5oY+HClidbo8yHHga23PoW48FqY/wPtAPqvaJ4GJVKujIqQdNb2BRHlyLZNd6XoA
 Unx+AYSo3oYPnnxhb5YEqHuQfvr1ZZB7l//2TrZX3Ludgi8JO0QYevoN56kdibY9N8Bh
 0Mim6uuv7zWc2XEMObJpiwoZ74c6HKEmYNLjtT/Uc17AfbRETF/ufGY38S/VOKKowi9/
 4TGw==
X-Gm-Message-State: AFuF++m1sFzilBCxfzIGkTbC3uWwnBMthpH1/B+i7MYBSueG08MqL0MC
 sSwztAYuhGrN1i0h32MtXaRkpHHnuDCNhywPa5yL+tt6AOWkjPTm0du1TVAt+WFVbdhv1rKBuVv
 kWRclL+8=
X-Gm-Gg: AYBFou2ayJ/Xr9nSgyJ44g1ebuTfH39lhCTu0yGEkzYuN0CkNCKoXrHV4KHvoLXncMu
 uItvHjnT6mv0f+iol4VO59QRKVlsmgg88Thc14IvAt0trlRCURZfDOIrZ0FH0toK75OcSAHtBKt
 KESUWSwEiOHq0onibg2ajOe1X8EEXbtLgXhxeraT8FYB2QMNcgdtZjqaR/8kHklP4ffn0dhvGrL
 gkcjAEhk91pXhCMIY9dNOmmsoWtbolLe2WbrHwsDgJg+YvB/gDu1usVXpJaIZ5FSYU4kktKWNKw
 5f7KuikTvi6iD2uNGcCgOVgo8uP9vpu2h7thCG1a6NJDregWOYjMVZtmCmv/DWcgEHZtJXAzbuW
 xcr9xtNcuPoJC+TitZuJwEawtfab2TZrjw0aaixfAOToCKh2Do47YqBZpSc/rNfYaS2f+i7S2dL
 gZ87mfL/0LDE/rh+ZcTKWR5QS9+qLIAu02dVMN8VyDcKyJX16n2nvucbUeE8U2FLTvIntehVK0Y
 nerAdsFXjzAXk0V/JU3
X-Received: by 2002:a17:90b:2783:b0:398:9beb:5c19 with SMTP id
 98e67ed59e1d1-3989beb6352mr4209840a91.20.1787957098619; 
 Fri, 28 Aug 2026 15:44:58 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:44:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 07/16] target/riscv: Use tcg_gen_lea_tl for SH*ADD
Date: Fri, 28 Aug 2026 15:44:42 -0700
Message-ID: <20260828224451.1564072-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/insn_trans/trans_rvb.c.inc | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvb.c.inc b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
index 3e74be223b0..82e715c7b73 100644
--- a/target/riscv/tcg/insn_trans/trans_rvb.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
@@ -336,10 +336,7 @@ static bool trans_orc_b(DisasContext *ctx, arg_orc_b *a)
 #define GEN_SHADD(SHAMT)                                       \
 static void gen_sh##SHAMT##add(TCGv ret, TCGv arg1, TCGv arg2) \
 {                                                              \
-    TCGv t = tcg_temp_new();                                   \
-                                                               \
-    tcg_gen_shli_tl(t, arg1, SHAMT);                           \
-    tcg_gen_add_tl(ret, t, arg2);                              \
+    tcg_gen_lea_tl(ret, arg2, arg1, SHAMT, 0);                 \
 }
 
 GEN_SHADD(1)
-- 
2.53.0


