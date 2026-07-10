Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0428C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIEz-0001W6-OW; Fri, 10 Jul 2026 16:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEx-0001TD-6B
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:31 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEm-0000j9-8j
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:30 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8423f236418so1050585b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716859; x=1784321659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sqD0i4B4xHusdPHG8dIAD4vZ8p3PsgamfaStAkj5bxU=;
 b=W7p4KMSRHRVwda8Ne3q5fOWJOCW5UxyVlhNNHIYiovpsTH/tyEW9GCnXYA24bVRrSL
 ESpCQm6E38xmSDXcj64tXhc60AjNiQHlBV+zuGg8KaCLSO/rRvgsEJvPSJm1yh1m80ri
 f/AIwxidO0XrsZF6BwQtdD6Sp69xdAPWV8cV9uLtHzCGCZcVlIAt/6hFNihjFEhub7gD
 gf5blITHz1SV4a874n5+xoUtTvpMyXNEX9RF6CUICnjp2x87iEIVx5xJYRHiw+eD4wvJ
 d2TSDq2/LdCVpsUqTA73qtzCKTWSX5Db404+ApQunWTTsaOjsb7VzeXJhBMprwRVcERX
 TeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716859; x=1784321659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sqD0i4B4xHusdPHG8dIAD4vZ8p3PsgamfaStAkj5bxU=;
 b=O/pPtymHohdkDCMK7XgAhqWf+/OnZqoK0sy/1OmN8mAEtHi00AJyrD3VAsQvF7deOx
 oJMzyJn/cXKOJfVYYIJKnEgIjy+T55c+mhnqIfyh5TYRkaih9QxcloLWM9Oljdq/fKmn
 G50s2pYb6GuIH6Nsh9RYDNQcVZO1AQwi5yi66wg9mSTD50JQQqlWYsImunYwqB4sjHH8
 XnfyJEr+ZWiLnRSbnPWMNM7SqgsvPEhbyr4yI4I2KXIAXbpsEFvWgXEfyfZa75TUeOGw
 BdFGlSTMgESvhaXsZ00yzItD85VANs0y5FwNN2R8mQtZAPknxsboMZTLHnzZRfEdAJfq
 dOrg==
X-Gm-Message-State: AOJu0YxV0Tx4Pt/qYavrI2fMQsmE0f7eZd47Qfqk0ZtAA6fxx7Lnv9m2
 5lHJmfrmtahmYXygxL8ztW4iYGpKfN64baB4hyz6qrjjmSDitZEzVL+VMarSqbVMBPOixwQed69
 uLcqo
X-Gm-Gg: AfdE7cmvAIFadSPCw1qVFZwx0Q3Hr3RBQEl2GgjxX6u+yy7wr2IPDiNeaP+sRY2f7Du
 5IaDgeekT/E1+15955axjxaXm2hVWhaC+MXCKrJ2ruPVU7EJoPa7OAGF3gLGOk+n/cJnupzX4pE
 xfabmp1zaYh0t+SnRfw6/CLSI5uNoEo4/1cwtrHR1C5+9KfEtc3mV3oyIBRPfvi7HKay9FCTbrv
 xTlQ3dRzIXsThbYPhBg8YgCDoM7PuvRNFeEVg7wKMImIOOH+7435llhyZn8tpfBbmhV4KkpFnIu
 0bqfyBALgBmPXX73aqSCcv6+2X1bX4Q7Tw3Fub2vsybrx782xe+3d+czo7qg4BWe5YLGR2yhvDR
 fFjwRGCLwamun1GIT5VgfZJEeEeVa97fooVTSEwSrWQNrqpiFNoa37a2VqkikoRUmY1hvZ3MdKH
 vocFrRoK+114Z3ule23a2y7V9YmfmE
X-Received: by 2002:a05:6a00:3494:b0:848:8445:6956 with SMTP id
 d2e1a72fcca58-848895feb43mr459561b3a.18.1783716858692; 
 Fri, 10 Jul 2026 13:54:18 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 14/51] target/xtensa: Use bp argument in
 xtensa_debug_check_breakpoint
Date: Fri, 10 Jul 2026 13:53:24 -0700
Message-ID: <20260710205401.836304-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Use the ID of the breakpoint instead of a loop over all.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/dbg_helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 557a7852c8..b08bd03435 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -67,18 +67,11 @@ void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
 bool xtensa_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
 {
     CPUXtensaState *env = cpu_env(cs);
-    unsigned int i;
 
     if (xtensa_get_cintlevel(env) >= env->config->debug_level) {
         return false;
     }
-    for (i = 0; i < env->config->nibreak; ++i) {
-        if (env->sregs[IBREAKENABLE] & (1 << i) &&
-            env->sregs[IBREAKA + i] == env->pc) {
-            return true;
-        }
-    }
-    return false;
+    return (env->sregs[IBREAKENABLE] >> bp->id) & 1;
 }
 
 static void set_dbreak(CPUXtensaState *env, unsigned i, uint32_t dbreaka,
-- 
2.43.0


