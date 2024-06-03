Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC544C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 16:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEAFl-00020j-GB; Mon, 03 Jun 2024 12:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEAFh-000205-DG
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:09:41 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEAFe-0000Z5-Qy
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:09:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42134bb9735so21458805e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717430975; x=1718035775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAmag+cWpcLwhgu5cuQHENQ1h6AJ+A+dNV70xL+L7j4=;
 b=iVIIDOHVmhZt/q2pxqYjt5evBNfqYdAmv/gY5fDEjx/mZZc1SNs4IdsZR8f7zWCHh3
 gRAcZ1MtkdbCInNw7dNTnUfkTgZPT+ZSGX/zb+Ih16WsAkmGvNSun6C7GMH9ZOWR8jyj
 L+rpTmTF+Z8i5eVqzDQb32um27MxTCnRhJ4XVES22Ns+YSqKtzddc+OrpQcJ9g4fPFpJ
 Cs/FeB3wwF0KkWHianmsi3SmCHzVJYgtF99JgDO/HR6AbJqknVvrEHE01P+arvSzvwNV
 IubM0GbD/+ewsqh17uybRkoDxyHjJgtMm8BlxLALOb/rz5tOA4w2L/JKTyCw5N20k1Bf
 tGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717430975; x=1718035775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAmag+cWpcLwhgu5cuQHENQ1h6AJ+A+dNV70xL+L7j4=;
 b=iNxOlAEFnl0vAUBfOvRarRV9PJ57NObn7Ze6Vl++i1PxO7ZL61d9DQfcpKQ9xA3mtv
 dCXjp/h65ZG/6mVEyqbG/uP/iEUKwJSjw7Y6OjseDZxJLxSPKM8Np8Eh8J95qBKv4+Ed
 wjkjaYLUN0mPjFTOwH35Sqolsmtrgrcb7jA4EmHmD5YeGu322vfEcAuNILhV05ey8Onr
 OVJnNHkw+Uwg1LJ8Jds96eCiI0LPv3vYXNoMQG3MHIWrLfXDkl2uYoDDJKdPwOY39ABL
 sfQox2lwn9OfIu9Fu1xC1P0oR0kFnikxqiHLcaSKu0HhhfL1eIS/sfeIyLGnQhYVTLGr
 H2SQ==
X-Gm-Message-State: AOJu0Yw/1wrBdSunSlsPR+5YT3Tfp3sX/fR7qYilqbiIQGTCuIg9BGhS
 0z7hDC9hndN9q2eds33NpYW7wS5amR0BYNWNi7lZEc8+EounKEnSp/o5BnFYGgdKMrxxkCp6WC7
 U
X-Google-Smtp-Source: AGHT+IEo9I+QgwyFPpE8UA7gzFvqqxv3KT56TJX4vzSME6jkm8uH/eng2IRzAkRjJofkLBj1UgtwmA==
X-Received: by 2002:a05:600c:4e8b:b0:421:3a41:5428 with SMTP id
 5b1f17b1804b1-4213a4157bcmr28421855e9.41.1717430975395; 
 Mon, 03 Jun 2024 09:09:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd0649fb5sm8975858f8f.94.2024.06.03.09.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 09:09:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/3] target/arm: Set arm_v7m_tcg_ops cpu_exec_halt to
 arm_cpu_exec_halt()
Date: Mon,  3 Jun 2024 17:09:31 +0100
Message-Id: <20240603160933.1141717-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603160933.1141717-1-peter.maydell@linaro.org>
References: <20240603160933.1141717-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In commit a96edb687e76 we set the cpu_exec_halt field of the
TCGCPUOps arm_tcg_ops to arm_cpu_exec_halt(), but we left the
arm_v7m_tcg_ops struct unchanged.  That isn't wrong, because for
M-profile FEAT_WFxT doesn't exist and the default handling for "no
cpu_exec_halt method" is correct, but it's perhaps a little
confusing.  We would also like to make setting the cpu_exec_halt
method mandatory.

Initialize arm_v7m_tcg_ops cpu_exec_halt to the same function we use
for A-profile.  (On M-profile we never set up the wfxt timer so there
is no change in behaviour here.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h   | 3 +++
 target/arm/cpu.c         | 2 +-
 target/arm/tcg/cpu-v7m.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 11b5da2562f..e45ccd983e1 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -364,6 +364,9 @@ void arm_restore_state_to_opc(CPUState *cs,
 
 #ifdef CONFIG_TCG
 void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
+
+/* Our implementation of TCGCPUOps::cpu_exec_halt */
+bool arm_cpu_exec_halt(CPUState *cs);
 #endif /* CONFIG_TCG */
 
 typedef enum ARMFPRounding {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 35fa281f1b9..948e904bd8a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1133,7 +1133,7 @@ static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
 }
 
 #ifdef CONFIG_TCG
-static bool arm_cpu_exec_halt(CPUState *cs)
+bool arm_cpu_exec_halt(CPUState *cs)
 {
     bool leave_halt = cpu_has_work(cs);
 
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index c059c681e94..5496f14dc16 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -244,6 +244,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
 #else
     .tlb_fill = arm_cpu_tlb_fill,
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
+    .cpu_exec_halt = arm_cpu_exec_halt,
     .do_interrupt = arm_v7m_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
     .do_unaligned_access = arm_cpu_do_unaligned_access,
-- 
2.34.1


