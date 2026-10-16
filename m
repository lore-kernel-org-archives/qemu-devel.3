Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A66CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWMq-0001EF-MW; Thu, 15 Oct 2026 21:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLf-0000Hj-VP
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:04 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLe-0004Dr-CB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:03 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2e915887d9dso24016165ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112581; x=1792717381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QVMBiGCXBl16d9HL8Unik9lFRKj8974JHMX15++voLg=;
 b=jT3yqz3w7yzv8oI02S5Re0e8YjeYP7A1w7y4L1o+gZUgVM9GPn+sZLIuzjGKcYeOco
 EJnBTaO5JfUyMLbwcXLghnJ8KDz2gRsz4c5n/aQIehXKzw0Lc2sqGny2iOV9FhCf0Ab9
 IaPYN6kuDXix46CmjsU9EtonZVZ/KC7B2rdjxt1JaW9F5dEZELwxPIOLdaKpYpOvvwTR
 Vu/MiZxbxCARqkuwUEH7tTcIbZxaHokrRygoewyUTdGbFMTGrWdUBtPjT1qgjEcP0BMe
 jesBv/07iPjDqGkPQOxrGAE5qKLkGWSlFUgnV0BxIh9gVt4x6ufqXREZh6x0C0zP3YIF
 db9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112581; x=1792717381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QVMBiGCXBl16d9HL8Unik9lFRKj8974JHMX15++voLg=;
 b=gxA/D80wA8KT0+Qv6qYcW6wocUHMStUuGSfnT/OMQSyG6sYZDv2qnXFVoY8qsvSfBr
 43QxJMNop4D8oN2KzrX6hoDfXUL0osLB67WYIvNsJ5xmWVF7XGoD7YlqUoxq6JVz0HJ0
 uRx0ruQgVKeiVA0RLf6JLk2cBYxrlFPsbl5mJUW1ZeZSH6torjqe788gB5fYQMEZ0iND
 cwFTL308IUieC1+4MCSk70D1BaeXVYevCSJcyMlz6ZhV9nq+L52h+CaSVQsoMan2m9oT
 JISuPHmvLV2wgjTbwYFlNn47jf7VYrSl/h8s5vyw1pvSULc0GMhgiRnNCYCJm6Wrt//U
 GPvA==
X-Gm-Message-State: AFq9FYI+rkb6rnkIg/ue4net3FRV/G3iwoPaFNGblJ7MRki9yeSYYsTC
 1pSBg09A4JDGY2JCYDtdDO7GM944kIqdYxRglcxDKEKhkoKA8fKN5RMwUNQI0Q==
X-Gm-Gg: AYBFou0Gt/iXsTmGpzY+CLw/WgvhZ9uMOfbfeAGrzz2MIFtnHkD4DUnSq/Zq0nb+Bt6
 NtKgS7an6ekQx5MJ6vZCcj8k1SVS8crV8z5fJxJIr72+2smtvI9UA1LR/969QeSnMZuITJbfFF6
 RDaNQxbp15DVH0b/AnanWtltkhFecYKRVh+z2B31T0UqQjXwqXTU3Tu6YZBP8n7vDyR4eYcfXzh
 e/xXs4kr+bTehhzwow5fFmoKwEsQNKcdLJVf92XywHr5A+lJutjJ1fQrjZ0kNCydGpXDDdBUYsn
 cfRFq7ymB3Zc8ji63W7rxO9WchxrnN2ZU+yQclG+TPf32NxQQcIOInzVsF+a0yftVe0VXMXqmi+
 mxsw03vjyN9YBvUtrPAK/79PD80qYdpc2XyQmQ0YcT/zDuskyKrCx+nnbi5FCEMXUaPTIvwTMQo
 h3z7/copwXp9Qizh8PPCdCMRkRDTHQr21B2gLa4TFbmac8jxwsvzZiHyEHFl66z7pXalYexWhCm
 9I2zHYDQmUeHpSZTTyoiZOKQYU=
X-Received: by 2002:a17:902:f611:b0:2e9:58c5:8c68 with SMTP id
 d9443c01a7336-2e958c5916emr38878835ad.54.1792112581118; 
 Thu, 15 Oct 2026 18:03:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:00 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: "Christian S. Lima" <christianslima@proton.me>, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 05/50] targetriscv: svinval instructions raise virtual
 instruction exception
Date: Fri, 16 Oct 2026 11:01:52 +1000
Message-ID: <20261016010237.1102834-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: "Christian S. Lima" <christianslima@proton.me>

The risc v privileged specification requires hinval.vvma, hinval.gvma,
sfence.w.inval and sfence.inval.ir should raise a virtual instruction
exception when executed in the vu-mode. This patch add the check to
raise the virtual instruction exception when is in the vu-mode.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3621
Signed-off-by: Christian S. Lima <christianslima@proton.me>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260911201323.37757-1-christianslima@proton.me>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/insn_trans/trans_svinval.c.inc |  3 +++
 target/riscv/tcg/insn_trans/trans_xthead.c.inc  | 12 +++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_svinval.c.inc b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
index 4614c1489c..1341beba2f 100644
--- a/target/riscv/tcg/insn_trans/trans_svinval.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
@@ -25,6 +25,9 @@
 /* Test if priv level is M or S. */
 #define REQUIRE_PRIV_MS(ctx) do {          \
     if (ctx->priv == PRV_U) {              \
+        if (ctx->virt_enabled) {           \
+            ctx->virt_inst_excp = true;    \
+        }                                  \
         return false;                      \
     }                                      \
 } while (0)
diff --git a/target/riscv/tcg/insn_trans/trans_xthead.c.inc b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
index f4e3051000..ea4b169422 100644
--- a/target/riscv/tcg/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
@@ -267,11 +267,13 @@ static bool trans_th_tst(DisasContext *ctx, arg_th_tst *a)
 #define REQUIRE_PRIV_MSU(ctx)
 
 /* Test if priv level is M or S. */
-#define REQUIRE_PRIV_MS(ctx)                                    \
-do {                                                            \
-    if (ctx->priv == PRV_U) {                                   \
-        return false;                                           \
-    }                                                           \
+#define REQUIRE_PRIV_MS(ctx) do {          \
+    if (ctx->priv == PRV_U) {              \
+        if (ctx->virt_enabled) {           \
+            ctx->virt_inst_excp = true;    \
+        }                                  \
+        return false;                      \
+    }                                      \
 } while (0)
 
 #define NOP_PRIVCHECK(insn, extcheck, privcheck)                \
-- 
2.55.0


