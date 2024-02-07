Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83559C48297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 02:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXY2z-0003By-W7; Tue, 06 Feb 2024 21:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXY2y-0003BW-HD
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:52:24 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXY2x-0000aa-2A
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:52:24 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d7881b1843so1870695ad.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 18:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707274342; x=1707879142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XeR3jaWaGEublhkyds5zMH3a9rvdTlNi440zus838qM=;
 b=jPPRtVt2qlWbOd4dk8tsixl03xv5kvn5NHQcsSVcWLuy4CDw+BoDGX5N2AOSphQeLc
 ebJIA9APqAoOLUhm+S5LjZQwsRB3VlnGlSLbO2bUqG9D92qtRk90LWg+3b9ie9N3qKoR
 uEl5IQBSrew7npzOBNC53EijHBVkITqLaQRA22TdBcatZpr+9MI7kFO9KbRvTYc4RGtx
 tFHF82FgVnn7S5j41vogvK9/u2hODsk6aZ+Vx31hOHJ70We+r5TbdtwNVGrXdDCpnQzj
 6x8BlXYj79dqrnm5tL9gXvzx30VitpOxJzX1ZfoXxjb79KfFkx0TZ9i3dagBL7jyYhp6
 7eBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707274342; x=1707879142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeR3jaWaGEublhkyds5zMH3a9rvdTlNi440zus838qM=;
 b=V2+SGZNJHcsTpRFo/0s6xFPpErPVZC6uupN+KHpBjBTnObC9hzN6ET2PRs6kbmWdgQ
 XQsAEztsnYam5WhwqCk8D8aUom7/38qhAqpuTk+wfDQk1n/uqJbBWbIrHdVLJE3tOCHf
 2U7D102lQPlREQHsOFvQwjZxoZA1092h91+J7/7QiHJ7dAEwhtxW2EHOhQIUQqhRspNO
 cGU5Nk6K+hhUce3MnyqrL1e5BlBJpdVo/+v9OaW0BqWxcNd1KaEoxzGIUvnyXMNL6EmA
 PcQt+JB8fDLLZepopntbxEare/n72CWcRShuYpBjtQAPg+MfRmldBesLCbcaeDEFmgcz
 ekTw==
X-Gm-Message-State: AOJu0YxdixF026KpPodR5zRkCKyjn+Ims4PharsiloZ3n6Dhe71pixBc
 V8w5l9B1Ch8HMKRDd27u8WPTzjGKY+bRjvuXqEm+mvaJCBYiqZYvCofTENZp134fzckK5ibXLBb
 17hg=
X-Google-Smtp-Source: AGHT+IHsdTQac/xAkNwdXpFXHf7g8N4a4Z8LjqetWStt8M2KpmdhbIOZSNj/TC2ducnl4/lfaWsmEQ==
X-Received: by 2002:a17:902:f544:b0:1d9:cded:4ef1 with SMTP id
 h4-20020a170902f54400b001d9cded4ef1mr4766316plf.13.1707274341606; 
 Tue, 06 Feb 2024 18:52:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU5m2j9cgPXpIuWFfZLH0bgymEtyndClnEul0XDonZ3RMXQEcItZrvl/TiYj0n+tgcVJd7B1yCWirZp6UXIFJJmhtvoRkXoQpZJmy3xkZEgBzw6X6OQssd/BoxDvXXS/YY/
Received: from stoup.. (60-242-98-186.static.tpgi.com.au. [60.242.98.186])
 by smtp.gmail.com with ESMTPSA id
 kr8-20020a170903080800b001d8ef97de4asm255435plb.38.2024.02.06.18.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 18:52:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v3 1/6] linux-user/aarch64: Choose SYNC as the preferred MTE
 mode
Date: Wed,  7 Feb 2024 12:52:05 +1000
Message-Id: <20240207025210.8837-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207025210.8837-1-richard.henderson@linaro.org>
References: <20240207025210.8837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

The API does not generate an error for setting ASYNC | SYNC; that merely
constrains the selection vs the per-cpu default.  For qemu linux-user,
choose SYNC as the default.

Cc: qemu-stable@nongnu.org
Reported-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_prctl.h | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
index 5067e7d731..aa8e203c15 100644
--- a/linux-user/aarch64/target_prctl.h
+++ b/linux-user/aarch64/target_prctl.h
@@ -173,21 +173,26 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
     env->tagged_addr_enable = arg2 & PR_TAGGED_ADDR_ENABLE;
 
     if (cpu_isar_feature(aa64_mte, cpu)) {
-        switch (arg2 & PR_MTE_TCF_MASK) {
-        case PR_MTE_TCF_NONE:
-        case PR_MTE_TCF_SYNC:
-        case PR_MTE_TCF_ASYNC:
-            break;
-        default:
-            return -EINVAL;
-        }
-
         /*
          * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
-         * Note that the syscall values are consistent with hw.
+         *
+         * The kernel has a per-cpu configuration for the sysadmin,
+         * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
+         * which qemu does not implement.
+         *
+         * Because there is no performance difference between the modes, and
+         * because SYNC is most useful for debugging MTE errors, choose SYNC
+         * as the preferred mode.  With this preference, and the way the API
+         * uses only two bits, there is no way for the program to select
+         * ASYMM mode.
          */
-        env->cp15.sctlr_el[1] =
-            deposit64(env->cp15.sctlr_el[1], 38, 2, arg2 >> PR_MTE_TCF_SHIFT);
+        unsigned tcf = 0;
+        if (arg2 & PR_MTE_TCF_SYNC) {
+            tcf = 1;
+        } else if (arg2 & PR_MTE_TCF_ASYNC) {
+            tcf = 2;
+        }
+        env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
 
         /*
          * Write PR_MTE_TAG to GCR_EL1[Exclude].
-- 
2.34.1


