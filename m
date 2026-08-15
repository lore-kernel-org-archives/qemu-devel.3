Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26722C5DF67
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvL8l-0008J7-Dq; Sat, 15 Aug 2026 16:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8h-0008Eq-WD
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:38:00 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8c-0008KU-HR
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:59 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso3293817a91.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786826270; x=1787431070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MvJ7+F16DEpj7QIj1wZklJf2PY3H3pWuGHhmdxhy48A=;
 b=Itc/WKj+73pbZcozLr4FP9jzbcO+xybMs++VR/DSpmP5MRzcyjJtovcMM45b9LuPlo
 HmkzUtSB04QSzmGnnpLvrKb20YPkkPUig3BbkSTjxsWp9AFILOAJym/SG7iQMoGQgF7Y
 3biVyevImZkVEPWFiIHivpBazIHZu86d+GA3XUq8ELQApvXPVvhZZnXFZbvF9wze2vDu
 oVasB7IPf7lrcqeSQJNqQphFyxRPYs2IBeDQ68mzu0NVQa6A7fE68434Bm8H6X8+ivXN
 u3T83vlgpgZBpS/7EfsqqXx7ReS9d8V0952KbnX8N9uZKSflDE8hQ1cu3K5GYtffrRtf
 9/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826270; x=1787431070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MvJ7+F16DEpj7QIj1wZklJf2PY3H3pWuGHhmdxhy48A=;
 b=iAZ4m347cedSFOvUC10tN0sFFj7m8In+mLfo6XyIaPot+lIiiUkVkXnBdxKntPb00S
 xCE12nnQz6f1VAPE1V5x5DplMoYEmpm9YezfMCUu3L5nMIV7MF9fO6sHYPCzDmON2rVv
 wvnZWBAVYy5NqKw2PaB0mPq1VjtcB8BGPJDz7cB6HxQD0gN4aXx0Ooq3GVvhJIVTuliX
 2EnJ8sn/qE8aSQKhZ2wc9S6S9cpDF8UeBHeKfjgLb4mRPlVn8FSuUh2Wwy+C7uiefm9p
 yubjSp6ARhLA55M5dmHxiEb3LKPvYwh7h7CSSSFz3jmFGATO9KC0UpfsQbdnDNoejh4V
 Xotg==
X-Gm-Message-State: AOJu0YwxGifO8ywi60MCR//sGZSFRJldwJUIHPGvlFrD/QoZNsThm4yS
 x1kzws/f5tYH71CD6C0lM8XVvTpC6wEvMmczyo/VLu7dDhANOXq889vmju/Qp82LlDEisnQzsNr
 52WFX
X-Gm-Gg: AR+sD12WKF2xow9RFxoR6HtnnFqOHSdDpYQb321AYCURqt28CMsxGUTL0Xd3+2BMRHd
 M6rrQsHEQktIFUUG/wbNdAgAotcbyefbp/cuojW3dtQEiqHfe5+848ybCG5oLxuHYsXrAjSt3fI
 1fODm7YiEO0FqaaHr/SywHc6e4DawLeKsBwKia1nRlfpj3fuPZfciFuqp364rg3jhRFf0UzWFNo
 dylGGYIy1emXwWu09bhpanLYm54F/9wc9TOk4c/P8qLvzfHMNYlLnoqt0yWTaVnqktJgzC3FYdA
 F3DFL9tSp++JxnNS1GBg8yICoiTNJnuuSxV1Ky1wFwxnJsFHGn1eZ1F7CmHh1nf2jzV9YZmk8r1
 4AzWejtLJI/8DM/SA7qzgO42O+AYoJRRyfaGj+29suDhRmdFMEcyKAh0f4NDQa/NgKUn5OSW1Te
 TWVl2Hac5tqhydqy+G18LMfdHErqAIABQjTZXuaeaQJmVOVBBG9E0RrM4MT/anlGOU0Rx+f/FaF
 rSJlmLy9ko8eNRctpvt
X-Received: by 2002:a17:90b:5745:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-3933b7a6986mr18082879a91.8.1786826269652; 
 Sat, 15 Aug 2026 13:37:49 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea97207fsm7066853a91.1.2026.08.15.13.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:37:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC PATCH 13/18] target/riscv: Move PMP_AMATCH_OFF check in
 pmp_hart_has_privs
Date: Sat, 15 Aug 2026 13:37:25 -0700
Message-ID: <20260815203730.1468365-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815203730.1468365-1-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Check for region disabled before checking the region range.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/pmp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 41b55519a8..5bccc60527 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -415,6 +415,10 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
      * from low to high
      */
     for (i = 0; i < pmp_regions; i++) {
+        if (pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg) == PMP_AMATCH_OFF) {
+            continue;
+        }
+
         s = pmp_is_in_range(env, i, addr);
         e = pmp_is_in_range(env, i, addr + pmp_size - 1);
 
@@ -427,10 +431,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
         }
 
         /* fully inside */
-        const uint8_t a_field =
-            pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
-
-        if (((s + e) == 2) && (PMP_AMATCH_OFF != a_field)) {
+        if (s + e == 2) {
             /*
              * If the PMP entry is not off and the address is in range,
              * do the priv check
-- 
2.43.0


