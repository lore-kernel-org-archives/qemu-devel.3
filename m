Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72057C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYf-0000fd-5i; Wed, 24 Apr 2024 20:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXx-0008J2-SD
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:06 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXs-0006JR-MU
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:03 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2a78c2e253aso372807a91.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003259; x=1714608059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=od3C8Is61jrhdrT5iIGSRyg1mQHZLFI1AAa4tyjr1AQ=;
 b=GLhvnZLsI/3Z+uNKovnRt+BWaFkiBU+Ql4jGJyV7A9KBoEC3KG9Y6fkFwEF+kzpyEo
 cLYU94A7ekOeW20ChvbcD6xvQdTJpbjmN+VPpgj/q70egYOHFFr4+0LnVz7xGAxsLaTJ
 Jx9miizvppgXAMoeu2Z0Su16zAPZ1yIh238+XLaUWFuTtzRZ1xsJAMaHv5t/SQalBxnQ
 sb6DOY2FnxHxBlGryIdfmP/rINJh9/iCsahg5azPIp56098VHBfcD5HyJd360N3+03W0
 +Xtitx3rIGEsz12YdSCHqqDnHlv9lEww+bMZnssUl6oWq8NUZ08+fzf0ZvFQ1820uP/H
 YQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003259; x=1714608059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=od3C8Is61jrhdrT5iIGSRyg1mQHZLFI1AAa4tyjr1AQ=;
 b=nI8HnXGl/hoNWe8oz+3TkVy/dITAgBSNU6bZU7oSTsNDuYayXn8vRgRLyNcUJhJ6dG
 QPMtZBn2w+WswXQu42un50Z1Vrm1dPy/qxvVCZS90c0mfKHQ8LCb1JygYWCoCKHHU7xE
 aC4V//9nUlm5GBlLlepxAtzLuHKQgIXkrsvDWXYK82iFdfVgAgh6kVRVuY3k18RRr1t9
 IEmdP8jLiO16xEYlOLAKJrakH2TGXL+klAn0jfNUNrmXi2YjZLU9qLNhzBagJS2z/eRP
 t7n0Y6R/SbcQ1hn1QMIOlcel4MPekL+vPQvpmQNdbsWdxlygOxZruvrA4ObXcpS2Gnfp
 rkBw==
X-Gm-Message-State: AOJu0YyDFLf6U/ZsB/xJE4sY7+wFRwopiv3ZC7pJHRoShh5l9sdHZ8w6
 b7mkp1kkIyd7zE0bCnBTLY7CiisjXoBf6fijRI2/nC8nUIbYbUr+1DkXTU8xKaevggWHktQQy+d
 8
X-Google-Smtp-Source: AGHT+IGO+HoWJYgQUWKTP2pU+W42xjJLiG3ZDNrACmkIu8yUTSnn+9LCFST87iRfXQAZDcqgV4N5oQ==
X-Received: by 2002:a17:90a:c244:b0:2af:9e88:d41d with SMTP id
 d4-20020a17090ac24400b002af9e88d41dmr1791320pjx.23.1714003259102; 
 Wed, 24 Apr 2024 17:00:59 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 35/45] target/hppa: Split PSW X and B into their own field
Date: Wed, 24 Apr 2024 17:00:13 -0700
Message-Id: <20240425000023.1002026-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Generally, both of these bits are cleared at the end of each
instruction.  By separating these, we will be able to clear
both with a single insn, instead of 2 or 3.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h    | 3 ++-
 target/hppa/helper.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 66cae795bd..629299653d 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -214,7 +214,8 @@ typedef struct CPUArchState {
     uint64_t fr[32];
     uint64_t sr[8];          /* stored shifted into place for gva */
 
-    target_ulong psw;        /* All psw bits except the following:  */
+    uint32_t psw;            /* All psw bits except the following:  */
+    uint32_t psw_xb;         /* X and B, in their normal positions */
     target_ulong psw_n;      /* boolean */
     target_long psw_v;       /* in most significant bit */
 
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 7d22c248fb..b79ddd8184 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -54,7 +54,7 @@ target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
 
     psw |= env->psw_n * PSW_N;
     psw |= (env->psw_v < 0) * PSW_V;
-    psw |= env->psw;
+    psw |= env->psw | env->psw_xb;
 
     return psw;
 }
@@ -76,8 +76,8 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
     }
     psw &= ~reserved;
 
-    env->psw = psw & (uint32_t)~(PSW_N | PSW_V | PSW_CB);
-
+    env->psw = psw & (uint32_t)~(PSW_B | PSW_N | PSW_V | PSW_X | PSW_CB);
+    env->psw_xb = psw & (PSW_X | PSW_B);
     env->psw_n = (psw / PSW_N) & 1;
     env->psw_v = -((psw / PSW_V) & 1);
 
-- 
2.34.1


