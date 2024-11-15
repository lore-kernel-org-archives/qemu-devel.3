Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09FFD68BD7
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 21:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3PC-0007XT-Al; Fri, 15 Nov 2024 15:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P9-0007Vw-Dd
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:58:59 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P7-0004Na-My
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:58:59 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7f8cc29aaf2so508937a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704336; x=1732309136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCYl3p7NTkXg+Dt0eWVy+0t6Rq+HCybUm/IWs0g2j0w=;
 b=wfhPx2vTByQTb44lBMOctLqutMGfiuRzTnOzG4JdkqTPkSmcOaUQiBaq1luVmLsw7i
 ocjh3GF0vaGC+XrJIYRB2vu5dVCXkXFhDtLDHFlV9bYOHSYJZaqbOyXiQhAVk/6M8g9f
 An+ENYhj1W1Qip4QKKdcQ1KOYHB9nvy2Ud5auxAlECabPuG+o3auVaGMnosH6rxOOVev
 6pS1aKEkMw66GCptMcHnmshqQV7D7GP5e0JFo2Bwsu+mcIcmQATjfdR6ELWenAqAOW85
 YaanYLKM2KUZ85Ht0+CQ+bcB6Rgf8Bs/2G+y9ccVabneTouE2lusct/Y4dVq0Uoh4yhI
 xRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704336; x=1732309136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uCYl3p7NTkXg+Dt0eWVy+0t6Rq+HCybUm/IWs0g2j0w=;
 b=nJENQXH4lpnPvICsPDWipPOsjoOq6Wjy2YJgwoBK02eaFEXf5RsHGzQ7PUxSAFcmoc
 Bviu53ADsHFQdhhed381FMkWbH57MKE2aX/ICspy4ZBImEpvpXdws+cRs5Bg94PKSuQX
 RlHdPLTkmwhw/UIoSVwVu554EczIeVkOTYBpfjBVcvziyiXMrPI+3kYpvlsOp0R9BY5R
 XX51F6AqjRgZTDlA/CqfnClzp6lT4G3T16XF+ZwPF/ldKlj6H/VIRylEKf22WZkf72CG
 +pmiEGnA3xXubrpizmMDeKKpKGJAm3OESBNxOEQuqlNQ4UpnVT8Kw7cjN94DRh3pdJpQ
 uqVQ==
X-Gm-Message-State: AOJu0YxB96/O6ei9Z0v8sQoHqWnThuuEmH3y9ZIVT4exShWerT1lStHd
 dnq7yuvoTktBk0EVPW+/uB/BU1IyDBS5pCsz8h7Lu8sJ1VLps15IFLLKaLXImQOXWliOiACF6SI
 E
X-Google-Smtp-Source: AGHT+IGefY/UTFTE1dTr55aBICS8jh/mvG5H2HvXhRnSDB0lNKb8JV1m0Hz69e0xGzSmQbmVtd9xRw==
X-Received: by 2002:a17:90b:4c52:b0:2e9:4717:97a8 with SMTP id
 98e67ed59e1d1-2ea1559feb9mr4091044a91.36.1731704336337; 
 Fri, 15 Nov 2024 12:58:56 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a49a8sm3362274a91.23.2024.11.15.12.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:58:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 05/14] target/i386: fix hang when using slow path for ptw_setl
Date: Fri, 15 Nov 2024 12:58:40 -0800
Message-ID: <20241115205849.266094-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115205849.266094-1-richard.henderson@linaro.org>
References: <20241115205849.266094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

When instrumenting memory accesses for plugin, we force memory accesses
to use the slow path for mmu [1]. This create a situation where we end
up calling ptw_setl_slow. This was fixed recently in [2] but the issue
still could appear out of plugins use case.

Since this function gets called during a cpu_exec, start_exclusive then
hangs. This exclusive section was introduced initially for security
reasons [3].

I suspect this code path was never triggered, because ptw_setl_slow
would always be called transitively from cpu_exec, resulting in a hang.

[1] https://gitlab.com/qemu-project/qemu/-/commit/6d03226b42247b68ab2f0b3663e0f624335a4055
[2] https://gitlab.com/qemu-project/qemu/-/commit/115ade42d50144c15b74368d32dc734ea277d853
[3] https://gitlab.com/qemu-project/qemu/-/issues/279

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2566
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241025175857.2554252-2-pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/sysemu/excp_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 02d3486421..b1f40040f8 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -107,6 +107,10 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
 {
     uint32_t cmp;
 
+    CPUState *cpu = env_cpu(in->env);
+    /* We are in cpu_exec, and start_exclusive can't be called directly.*/
+    g_assert(cpu->running);
+    cpu_exec_end(cpu);
     /* Does x86 really perform a rmw cycle on mmio for ptw? */
     start_exclusive();
     cmp = cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
@@ -114,6 +118,7 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
         cpu_stl_mmuidx_ra(in->env, in->gaddr, new, in->ptw_idx, 0);
     }
     end_exclusive();
+    cpu_exec_start(cpu);
     return cmp == old;
 }
 
-- 
2.43.0


