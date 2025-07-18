Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD082C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucp8k-00015c-GC; Fri, 18 Jul 2025 13:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucp2g-0002wt-3q
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:38:54 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucp2Z-0002Qw-Td
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:38:37 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7490cb9a892so1606901b3a.0
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752860314; x=1753465114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mxy2QqP/X4XiJEGYLStKtNteNaT0cNDJnWoBTij5AcI=;
 b=PNUOYgXdQvB9ix1j6YMyBYXWptEIFaZbFYuJkZsd1jX8l6vcZnji36BarTuG+t0jRa
 fjdSYBHfbonxYAMKbLfpRiidIeeMEVnrg4P7ua7F1yCmRU46LcdthvmeEWSsPs6pY3kO
 yi3/I4hnzbXiEdvKauIcEEtaL/dCe5Pa57cFUrDwHKsXuOg95+yA43IFb8pyCrhgePVz
 NHG+DSPmlI3+whP40yduUI4VO9r0xKcjTsxncGIly+sOofOPpUtUte4LVb6TDcchi9zh
 2L7J2LHJy4+kZKjJ6FaHYOhpCJJrN/OcHjfJn3geytfvULqcqlUwxUBqBseklYtJC9eS
 gNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752860314; x=1753465114;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mxy2QqP/X4XiJEGYLStKtNteNaT0cNDJnWoBTij5AcI=;
 b=oPHJMcT7OddMnJI0cd+H7hX+SssT83zQjvniZoxVR4EPatxD27LLFt4gf/a4kaCINT
 Bh54LRKbnJeoC/KyPB2LNk+4WMHNSSNcf37AfY/tN53quMCnE3DJxkj9hGTbHNyVksrU
 kCDqNnSnKfU+hs7/HKP7SzI1rCJkIfgWiGUweGEBvwGOiSYs/50THy8DS4XFS4OcS+N/
 OF5XtOHM3mz6ADCyqyQ12uhmYJRRl89Q6tP1tIHEyEm/W9uYzqxdnmlgwnRWCLcU+nJ1
 lLA/rr6MTfI1wxBvefQiRV1sZJDs7k0pbtJlkGYU+cw7VG0JWL0fx/mx/BhQb8RRcMla
 /rPg==
X-Gm-Message-State: AOJu0YwBELBZBSnWxw99Ecjs/yPxPG4aVfU+Z1h4E/7t0s/ovR6Q7RZ9
 vjxxqmsf/NLv4pPU1SWVV2k+mfzN9C4BH3P81hXnqB+6yDE01RuaaLNDe4/rZWYq03A2+tG8HHx
 eOTO2
X-Gm-Gg: ASbGncvJq7EloK2iM6R9jLeRpOVKlwJ+Z0ohLRWxPeki/KOFRBi/KW2JZzbHcEkVYv6
 8fBIR3ayJI0ma5w4dY10NHP1Tem3hsovDjn01IYB/Dzv2P6M0H3h97nD5w4Zvx5sms/2rpf6MUW
 naCbSKg2PSbyDbUMzKcv6bXzYA3Yl/OcLJ1UTm/O+WyX/7hG1VI7rX3izqARJkxiITiADPQyUty
 wmsBM6jSI4yeebl1Eb82VO6pkGKNiA8sCZoN4FklzFeJhRZ8RheRcBgjebjYVxZuqHB9Qglqyk8
 ngnfDrUNH+VwhAJaOE1f/ewVJ8GyNb4dDvAAettVr4+pAIjhuvGnTrzvhnZoe//tpTLPdIFHdE+
 AFcI2SZiLk06KouTkJ1a7/317x5W6
X-Google-Smtp-Source: AGHT+IHzrXrz04Y/L4Zug5HnorapGGQ04/F/q+U3TjDrqbo8WcappQDRXBmWsmG3ncps8WdJjVmT/A==
X-Received: by 2002:a05:6a00:23d5:b0:748:323f:ba21 with SMTP id
 d2e1a72fcca58-759ab639668mr4394818b3a.1.1752860313954; 
 Fri, 18 Jul 2025 10:38:33 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759c89d3190sm1555155b3a.39.2025.07.18.10.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 10:38:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH for-10.1] tcg/optimize: Don't fold INDEX_op_and_vec to extract
Date: Fri, 18 Jul 2025 10:38:32 -0700
Message-ID: <20250718173832.47820-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

There is no such thing as vector extract.

Fixes: 932522a9ddc1 ("tcg/optimize: Fold and to extract during optimize")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3036
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 62a128bc9b..3638ab9fea 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1454,7 +1454,7 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
     a_mask = t1->z_mask & ~t2->o_mask;
 
     if (!fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, a_mask)) {
-        if (ti_is_const(t2)) {
+        if (op->opc == INDEX_op_and && ti_is_const(t2)) {
             /*
              * Canonicalize on extract, if valid.  This aids x86 with its
              * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
-- 
2.43.0


