Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA35CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9N1H-00019H-CA; Thu, 16 Oct 2025 08:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mz4-0005wC-V2
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Myv-0000V2-Bf
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so5335045e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617273; x=1761222073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=37FTiToFTijiam8M3G0vpqh4+LNYP4bNXXaif/l6Yhc=;
 b=jrpNoK6D3RXtV+aNs2sdq7yoQ/UecrLKPLLlbMrVyojw2hXIEeVzQOG2W+ZXbpocWX
 y3skZIPeWKgFlD3N4Qa5A0kLDiY5phq2ziluolcd42VM1khMsSLYusyeOmWAQKcU5S9g
 J4MdPOQBn3kw8IhrFNViFOPObclG6D1Ov/lL3CRI70MEReUYIZjphsdT0jU9X5t2/9G3
 PfKuTKsN0ew6Cab09FrUbEqjtG8xg2iiiWjwHVty9WP0vZ4xkoAMe1d/GOPWss20LrsB
 EA/eJ+geQ9n9MVStyl5y4AzjWssnVrxXUgLAURB4fKhhBPWGKDtnlZ/j22yiqvRxmvPN
 GECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617273; x=1761222073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37FTiToFTijiam8M3G0vpqh4+LNYP4bNXXaif/l6Yhc=;
 b=YrbC69DaypMEH9pZvpbRvdsh3y9Ow0mIoukdjZzq7G0ozACR3JKhlC6N2szUtyhy6n
 gb8eNE4B2VuidDGpUL8v2gDR8JeTGuz0AR8BgESIkqa0kozwH+5u31+/WnTizRsIVmeP
 z3sL3qdOk8pIPE+KgadjbfjMDdddUdCO17ZsLnNWdMOTe4DWuJ/SNA1n3ExZakKdesjm
 vnSI47aN+hb3vI497HOqa3hPF1paoPks0ecBtVtm6poq1z61nvtla4iA190UBRNfWtGR
 GJA3OhjOHJnzT053+2oXwM3phBboegRivfQQFZ6bdj2ebyhmLN8rDjO6SS7aVmM7kuvL
 vZjA==
X-Gm-Message-State: AOJu0Yz07pZeGCfXmdaM6m3PJmIXx/atr2nF/8XiRVtO7w36hg2+EiEY
 NHDDHCn/O57LR9mR3PD6+VZeSc4Rb9woNoV26bvLUGO18ZZ3wsYmQ+CLNGMNBeKSdbuty10EHTQ
 nx8NOclU=
X-Gm-Gg: ASbGncsb+0tFz+fc+mCms85HMxp1AZRglM5l6CgZyl+6v9yY1BFOYbm62NSh0QwOGWs
 9E/HJiIXI1x5XLe3s77a8Ape+pHsuecw3GMrd6EMeL90Yf3N/097It6+hUNNLQoQShH0U0WQGzm
 PLqzuaCCpWW4WUMs/IPrb9dIkw9vloW8EIV8ZlqSrBWrylyiKGeultEeGIWy29B09iamJnWo+PU
 l0aXSoai/mO163G3eu6DyH7rGPGy0KuegwME49Bp0im9vtTSurnPiPpaWP+Qrd6g9smpU8bNgPN
 Bu00PzhOvNhfVcq/rtpSC5h7yl5XVfi9EOSKT70gphFn2ReqHvXA1hfmqO6zgqE8iz5FycqISdd
 fDU1Q8aFUl3O2j4DgV9uJHujsYJC9lAzOukvyJCmxlPoBg4LAHgGRnlRj7X6G7/WYB/J75I4eWi
 Ji4hXlOlT9B1BvNOYXajMRGgeRkKeN3zk0nlqUPG5rabAxiMg3MkKrVi5YyiWmvDz1
X-Google-Smtp-Source: AGHT+IEk14bwXl01qhw/h3SXCz87nbTgvir4a+OW1k/V7tkazCalOM3FLuZzVVLN6SOYxWv4D/MXLw==
X-Received: by 2002:a05:600c:138f:b0:46e:19f8:88d8 with SMTP id
 5b1f17b1804b1-46fa9b17d03mr262865865e9.34.1760617273092; 
 Thu, 16 Oct 2025 05:21:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144239f4sm23928515e9.2.2025.10.16.05.21.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:21:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 73/75] target/xtensa: Remove target_ulong use in
 xtensa_get_tb_cpu_state()
Date: Thu, 16 Oct 2025 14:15:29 +0200
Message-ID: <20251016121532.14042-74-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Since commit bb5de52524c ("target: Widen pc/cs_base in
cpu_get_tb_cpu_state"), cpu_get_tb_cpu_state() expects
a uint64_t type for cs_base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20251008051529.86378-3-philmd@linaro.org>
---
 target/xtensa/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index ea9b6df3aa2..1eeed44e336 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -59,13 +59,13 @@ static TCGTBCPUState xtensa_get_tb_cpu_state(CPUState *cs)
 {
     CPUXtensaState *env = cpu_env(cs);
     uint32_t flags = 0;
-    target_ulong cs_base = 0;
+    uint64_t cs_base = 0;
 
     flags |= xtensa_get_ring(env);
     if (env->sregs[PS] & PS_EXCM) {
         flags |= XTENSA_TBFLAG_EXCM;
     } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_LOOP)) {
-        target_ulong lend_dist =
+        uint64_t lend_dist =
             env->sregs[LEND] - (env->pc & -(1u << TARGET_PAGE_BITS));
 
         /*
@@ -83,7 +83,7 @@ static TCGTBCPUState xtensa_get_tb_cpu_state(CPUState *cs)
          * for the TB that contains this instruction.
          */
         if (lend_dist < (1u << TARGET_PAGE_BITS) + env->config->max_insn_size) {
-            target_ulong lbeg_off = env->sregs[LEND] - env->sregs[LBEG];
+            uint64_t lbeg_off = env->sregs[LEND] - env->sregs[LBEG];
 
             cs_base = lend_dist;
             if (lbeg_off < 256) {
-- 
2.51.0


