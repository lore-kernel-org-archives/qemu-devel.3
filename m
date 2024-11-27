Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961A1D6ACC0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGGz7-0004cy-RB; Wed, 27 Nov 2024 07:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGGyq-0004cQ-Hh
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:17:19 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGGyi-0008JO-C9
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:17:13 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434ab114753so4053155e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 04:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732709826; x=1733314626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3BxEjvnBnJkyOT5moaMUVcAM+eLwUr9AkrsxmW/0bSo=;
 b=lgZ491cqTVGJel2/e9m3f1obYBwgFhkfwJGKq3as/kf14dq51Q6YFlq20jnXIUDgGU
 TWeaBl0PcYba1i3bJLD3jE9gxq1MLPfbohhIb6VgJE6rD23TjNDanWBquppwxSletZhM
 ckWNwTShDYJ+to6YjC1DQlGHmRIAOvFdcB1QPaWkkj3bXtk3/T0v6KVdwd7mDxY2xxpe
 fDp4k9Sn8i9iQG7kEiMYNjKOmMlFVHLsZrdz7yRHDVZHe289DOhclofl7QrVQrqbzdoR
 g2p0T1Q4QyVfGZHodr3OF/oAiu8YWTVRbNRNqodJiVhCnhbWGekYMNHrrGKzbhdd5gIK
 sG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732709826; x=1733314626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3BxEjvnBnJkyOT5moaMUVcAM+eLwUr9AkrsxmW/0bSo=;
 b=EoqZhVqRd94bHcHrHpVoUfv2Qb9DDXuP689ug1I/rTrWMDMtzSlBZlDyYEuGw+EhwE
 vIEMVHFOgY6nqJzsRov2hhlt2zgEVlleqXqG6kkK2tN7qBJFXw78BqZhKqIzZ+z3+mJo
 NtuoS/KakRhUkAr7GOq/Ws8DNxzN80JFK69nxB+LLq+GANBkg03afwOvyJML5ESvn+DA
 Le6hyI4U8rHpC0GHopltkO1wovCq8dI3DophMvIzWxVQ3Ix3lzkV7R59pfqjLsbIdxq6
 bs/vXSBXINwgFz9hrFuNbnVKwfKwOqBZIEQtxRB4jIFknUC/K5OhsQFOdqT2s8HHzV9H
 0unA==
X-Gm-Message-State: AOJu0YyZmBwKkVDzhOWou3+hpRW4ndp648PLEx9hRHqv5Fl1qQYG2kBc
 Fo5rHpd/ODeFg3diXnM5NWeCgmiMlxvIh+clpVAX+p4nEV2GHvILqw3ENG6esutuZJVxiYK94NF
 C
X-Gm-Gg: ASbGncsZaOq1ierXiYVfcXajAXH6riFfa7zNMs1gOkJesI6zzVfNP/pK0SX6k+UKWZC
 ouPTTJnZNQC8xPZf+RXToqhUcwfsMpH++YKtfL9QouQ5WKUvl8V4exXHwjXSh20L7rlLr0XRhuA
 te5HF18sN+nTkl8lKYFDsuGBxMVm/Ofc9RRFaL5ErUrG1t7rgupKSwZULwD9xQJc7UUHhbMWcoK
 DQ/8QXWM9OnelplARmXhJFfpSAsYWvW8ebrNhf9pHLcOREILnNm/y3qzAUqNNIgsmZM9KuQreCi
 9HXs/33n8AfgUhhHaNdmHuPa08fGGHPwcWZWoiu31SY=
X-Google-Smtp-Source: AGHT+IG2Pxc7/F2DjMgho0eUIWCImEyRJJ0EJnierZX3aYz9KyZUOReeHeKxX1iQqcstykPWPXBQTg==
X-Received: by 2002:a5d:64a9:0:b0:385:c872:49f4 with SMTP id
 ffacd0b85a97d-385c8724b03mr1406229f8f.32.1732709826427; 
 Wed, 27 Nov 2024 04:17:06 -0800 (PST)
Received: from localhost.localdomain
 (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr. [176.184.14.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aca7eea8sm6937285e9.34.2024.11.27.04.17.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Nov 2024 04:17:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH-for-10.0 1/6] target/ppc: Indent ppc_tcg_ops[] with 4 spaces
Date: Wed, 27 Nov 2024 13:16:53 +0100
Message-ID: <20241127121658.88966-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127121658.88966-1-philmd@linaro.org>
References: <20241127121658.88966-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index efcb80d1c25..daf7f8a93bd 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7416,23 +7416,22 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps ppc_tcg_ops = {
-  .initialize = ppc_translate_init,
-  .restore_state_to_opc = ppc_restore_state_to_opc,
-
+    .initialize = ppc_translate_init,
+    .restore_state_to_opc = ppc_restore_state_to_opc,
 #ifdef CONFIG_USER_ONLY
-  .record_sigsegv = ppc_cpu_record_sigsegv,
+    .record_sigsegv = ppc_cpu_record_sigsegv,
 #else
-  .tlb_fill = ppc_cpu_tlb_fill,
-  .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
-  .cpu_exec_halt = ppc_cpu_has_work,
-  .do_interrupt = ppc_cpu_do_interrupt,
-  .cpu_exec_enter = ppc_cpu_exec_enter,
-  .cpu_exec_exit = ppc_cpu_exec_exit,
-  .do_unaligned_access = ppc_cpu_do_unaligned_access,
-  .do_transaction_failed = ppc_cpu_do_transaction_failed,
-  .debug_excp_handler = ppc_cpu_debug_excp_handler,
-  .debug_check_breakpoint = ppc_cpu_debug_check_breakpoint,
-  .debug_check_watchpoint = ppc_cpu_debug_check_watchpoint,
+    .tlb_fill = ppc_cpu_tlb_fill,
+    .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
+    .cpu_exec_halt = ppc_cpu_has_work,
+    .do_interrupt = ppc_cpu_do_interrupt,
+    .cpu_exec_enter = ppc_cpu_exec_enter,
+    .cpu_exec_exit = ppc_cpu_exec_exit,
+    .do_unaligned_access = ppc_cpu_do_unaligned_access,
+    .do_transaction_failed = ppc_cpu_do_transaction_failed,
+    .debug_excp_handler = ppc_cpu_debug_excp_handler,
+    .debug_check_breakpoint = ppc_cpu_debug_check_breakpoint,
+    .debug_check_watchpoint = ppc_cpu_debug_check_watchpoint,
 #endif /* !CONFIG_USER_ONLY */
 };
 #endif /* CONFIG_TCG */
-- 
2.45.2


