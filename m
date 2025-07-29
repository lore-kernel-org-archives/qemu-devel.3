Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C96C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 11:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugixw-0002Kk-VN; Tue, 29 Jul 2025 07:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugixt-00028U-Er
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:57:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugixm-0006CZ-3K
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:57:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso54610465e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 04:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753790262; x=1754395062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qlMPsFcRkecAJn4sG0LZ+bCyhxVU/WClwqhj9h0KqLU=;
 b=nc2OrzsiuOcAp2UDvWG68LZ0MYbtJGgGABaNEH245pnnsfE2A16WJdK4X/eMghxOqx
 g2f6QnSBNTkms+Z9Hedvk7MpQgTbhJj3FcFxujPW8xWchY8/xNxDxTiIaO7kAxA1ZSg9
 cN67lRoYF4ufSzQfs5iUBQ4hU1hrr9ghE4iUlhv+BM6wCUZlzBndnTImxOqOBSfI9n5h
 BZzFZKwgSbkNujkvmHFAEJSTNXBZj2IKgJeWUq1Ejrjurgc+od5vL73EiEJ9ibB+HTU3
 QUXAI2WvzzaLjNyJvtHAb+B8Sn7eolcnL4Mlxqm0XMjaUEg/WtMqIw1eQV4uaI5pOYQt
 2n7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753790262; x=1754395062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlMPsFcRkecAJn4sG0LZ+bCyhxVU/WClwqhj9h0KqLU=;
 b=Bs5qX0UJHflqEXCjvkybmnW7sjl9HjBNHA1KGXkWySJQjwgA+vabIQXE6oRIM+4rdH
 Cpd1Y/lK6Y/wuYI4LwyCGwU/G4w0AkXjHnbQe9TBFsCnMD+4e5giXtydUi1s4kJr1x6i
 IgNSpLTKrbkBH1gScXsxufkNz3mXYnSpOjeW5iXuUYkIs5LlMhEczyabjKdoTk8ady7U
 ksg18N/mtX0tAL1iMJVdXwaA6RRDoSAM1/UTiBzZkm+r5U7nbHXEpCP8zFYkj9tUbGuS
 7DJLfqo3ZnoBgrUBwEYSN3pZNcv2AmqdnabFzxAKlKEapOYlpIEMSzLhUUGKvvvM+FT7
 dnlQ==
X-Gm-Message-State: AOJu0YwH3tDxDAegEsu1X7Ahs7yVViTcjl+r0oqEIektDuArMw81CcxI
 fV8gvbCpIz4FCf7tOlZOIxgAY2Ji5Xx1jWJHYZ0VTzO4BtmIYjBNj9UkuP55jaOK10DOQqgXxPo
 pe4Gw
X-Gm-Gg: ASbGnct6KFxGDmSxSLXRK/SzS0f02pXRrz07qn4BfiPveEvnYQgtRWX07yNhEVagzo6
 SbN7uKMhXtTZ0NsnqU2aBbKJBuh0MBzxSaeZr+0eLfSssfz9vjpfhgfNQI/vldAQ4JD5I+/7atR
 zjYJ7gwBZu8KNHf/GX4cBOtmotzLCN1NBdNl3XZw6bOkQSySu+jbA577GtMIBM6A/uvV2Po3nLk
 58nE5MPKh/eg9Om2j1zrW2lBNxoyQTRUoQRQ8219cjhKtYVrG1ylJCmi8d7wswoLvxlaPmoksdz
 9b1OIalN8woiLR8vDpYnPTdVCmflwd8Gm27Rt2Jp/GLnstIGFavwEmGYm8dHj1rpkxPvwil1o3V
 F8EWBWOYnSMZnkL2r/HsGv3F327wR1NkT7//51JJr5fkTCcvCA8hRi+OvsgQEnuewScOgH/dU
X-Google-Smtp-Source: AGHT+IHaLH4m3hWKP+mnTa4+aJppGB3FqFEQNseWODpswY5ubtPIlj3Y23GMTmWKAH57lkvxrmRTjA==
X-Received: by 2002:a05:600c:3ace:b0:456:25aa:e9b0 with SMTP id
 5b1f17b1804b1-4587654b626mr154620205e9.16.1753790261828; 
 Tue, 29 Jul 2025 04:57:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705bcb61sm191001725e9.20.2025.07.29.04.57.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Jul 2025 04:57:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-stable@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PULL 1/9] target/mips: Only update MVPControl.EVP bit if executed by
 master VPE
Date: Tue, 29 Jul 2025 13:57:26 +0200
Message-ID: <20250729115735.33619-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729115735.33619-1-philmd@linaro.org>
References: <20250729115735.33619-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

According to the 'MIPS MT Application-Speciﬁc Extension' manual:

  If the VPE executing the instruction is not a Master VPE,
  with the MVP bit of the VPEConf0 register set, the EVP bit
  is unchanged by the instruction.

Modify the DVPE/EVPE opcodes to only update the MVPControl.EVP bit
if executed on a master VPE.

Cc: qemu-stable@nongnu.org
Reported-by: Hansni Bu
Buglink: https://bugs.launchpad.net/qemu/+bug/1926277
Fixes: f249412c749 ("mips: Add MT halting and waking of VPEs")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <20210427133343.159718-1-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/system/cp0_helper.c | 32 ++++++++++++++++-------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 101b1e65fdd..b69e70d7fcf 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -1562,12 +1562,14 @@ target_ulong helper_dvpe(CPUMIPSState *env)
     CPUState *other_cs = first_cpu;
     target_ulong prev = env->mvp->CP0_MVPControl;
 
-    CPU_FOREACH(other_cs) {
-        MIPSCPU *other_cpu = MIPS_CPU(other_cs);
-        /* Turn off all VPEs except the one executing the dvpe.  */
-        if (&other_cpu->env != env) {
-            other_cpu->env.mvp->CP0_MVPControl &= ~(1 << CP0MVPCo_EVP);
-            mips_vpe_sleep(other_cpu);
+    if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
+        CPU_FOREACH(other_cs) {
+            MIPSCPU *other_cpu = MIPS_CPU(other_cs);
+            /* Turn off all VPEs except the one executing the dvpe.  */
+            if (&other_cpu->env != env) {
+                other_cpu->env.mvp->CP0_MVPControl &= ~(1 << CP0MVPCo_EVP);
+                mips_vpe_sleep(other_cpu);
+            }
         }
     }
     return prev;
@@ -1578,15 +1580,17 @@ target_ulong helper_evpe(CPUMIPSState *env)
     CPUState *other_cs = first_cpu;
     target_ulong prev = env->mvp->CP0_MVPControl;
 
-    CPU_FOREACH(other_cs) {
-        MIPSCPU *other_cpu = MIPS_CPU(other_cs);
+    if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
+        CPU_FOREACH(other_cs) {
+            MIPSCPU *other_cpu = MIPS_CPU(other_cs);
 
-        if (&other_cpu->env != env
-            /* If the VPE is WFI, don't disturb its sleep.  */
-            && !mips_vpe_is_wfi(other_cpu)) {
-            /* Enable the VPE.  */
-            other_cpu->env.mvp->CP0_MVPControl |= (1 << CP0MVPCo_EVP);
-            mips_vpe_wake(other_cpu); /* And wake it up.  */
+            if (&other_cpu->env != env
+                /* If the VPE is WFI, don't disturb its sleep.  */
+                && !mips_vpe_is_wfi(other_cpu)) {
+                /* Enable the VPE.  */
+                other_cpu->env.mvp->CP0_MVPControl |= (1 << CP0MVPCo_EVP);
+                mips_vpe_wake(other_cpu); /* And wake it up.  */
+            }
         }
     }
     return prev;
-- 
2.49.0


