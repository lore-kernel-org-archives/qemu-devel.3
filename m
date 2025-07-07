Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC24AC71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 21:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYsy6-0006xk-1Y; Mon, 07 Jul 2025 17:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsL7-0005Ge-LR
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:29 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsL5-0004HD-Bc
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:25 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4a44b3526e6so54790811cf.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751919682; x=1752524482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxsgUWQbY5ASUPXPwx0i/WLJ4Mhu4BV4cCyqG0Z6fig=;
 b=bl3wPI+bo7iBmd/4rIjH/OfgpkJzm65UTkql6/6hBoCu+1GR7uKC69zSblZLjHfHH2
 YUqVbeY/4kxD30h7+czt9Dqkzzq3KUlq2q7pD4RqTjLDR02pyoY5iNgSuAlFG4WPwvUb
 oMVIoxPrCeh/1UgdFFO4qQnL4HK+8ycD6JUH/x+AkX/BzcSMojjFmICDWqraHL9UWN9P
 91AcRKYIL4m9fJTKm4mgXdzFgxtxzdTiQAJcU+TCpP0HYAJBfSU1ESVrOIN2FPOUoanN
 DlP3eNhqB+7JyKhf59siSqXBzoR4X7zNPVx+lSKdYPASsEqkgJMqz8XfcFa2FHMyuC3B
 RfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919682; x=1752524482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jxsgUWQbY5ASUPXPwx0i/WLJ4Mhu4BV4cCyqG0Z6fig=;
 b=b3xR1mvz6DAYEeVRvzCxs2Mf55Sz7bKmA+4hvmt+UoRi/JdHrx+TbGI6fWVmmxH5+9
 iGnzEQqtdFWmJ3mno/WeahtXCi/C8RyKf4JpDAD+F7x8Sv9+116R/uckvgyfJVgDXpBt
 1zNgsRTiD7TkN5SQqeLMGXF1aI1paMfaskrJJpCeuoZKcOxc6iRx1xSB8bXSFGB++3OO
 MZsa8kmSAeG1UMfwMpq1ax1Lzhq41G+FJjDH+50n1DOwTZ/z2ABlZEU+vmojA3/a+Db1
 tqdGmTXl16G4ym+xS0jgmOAjUlw6Eu8lOyo3oiRODsgoshhCraTt6xIb9S/yyiMjkN7I
 9pFw==
X-Gm-Message-State: AOJu0YzEJi3kLXjSNVoHHFv8EkyaWCCRphQ0+FRxnjdtwKDIKTDVw+Fa
 0u51/HJynu1qP/spBT/ymHK7eNpydF6kic5SUzXvt5x5dNl01hNfQ3G3pZ25tmRV6MgfCFsXhtd
 NJAyDWcw=
X-Gm-Gg: ASbGnctfSXH4GPYSTyqmSE/tZ7dBsoRVp9E0VRKOPL3yW5bSEoZyIU4kXRFYMkNay8O
 dFTpb9CXPHOfF1EsEgSNV6kFJbLWEq429C6n/ENJ5YPPrwPpRVIp2TjzbJkqZOv86ntnSSRfqAy
 Gs+9Cav6tyZ/WsqB9Y7/6IoR9VRps9IF1HvsYdqPxxU5X3IPxANWHSTmF6T9wxPhkw5p9KOqjqF
 4qgeHqUP2zqJhd5OiilbhWY7oilq3saxwk8ddK5XeQeuVrbeMB98JGjaIQiKUbOEhajH7gdhP9w
 UZpYOhxasr2KasHbssCayfspnPD4LRYnfQNy/4wSwTuT/dK0xbtyF9ZLcGLnxzsT1SqbcESHofg
 hU2TeundtO1Eb+6c+
X-Google-Smtp-Source: AGHT+IExKQL2znVnByclw1nVIw6sdSlZTVR593+58jvr8Wfq3eiZhURLMWNn7BtZsr7pijDwvFS/FQ==
X-Received: by 2002:ac8:7d52:0:b0:4a7:f9ab:7899 with SMTP id
 d75a77b69052e-4a9ccc338a7mr9395711cf.35.1751919681966; 
 Mon, 07 Jul 2025 13:21:21 -0700 (PDT)
Received: from stoup.. ([172.58.142.143]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a78dd4sm69050351cf.51.2025.07.07.13.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 13:21:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 04/20] target/arm: Convert get_phys_addr_pmsav5 to access_perm
Date: Mon,  7 Jul 2025 14:20:55 -0600
Message-ID: <20250707202111.293787-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707202111.293787-1-richard.henderson@linaro.org>
References: <20250707202111.293787-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x836.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 7503d1de6f..adceeabfe4 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2182,7 +2182,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 static bool get_phys_addr_pmsav5(CPUARMState *env,
                                  S1Translate *ptw,
                                  uint32_t address,
-                                 MMUAccessType access_type,
+                                 unsigned access_perm,
                                  GetPhysAddrResult *result,
                                  ARMMMUFaultInfo *fi)
 {
@@ -2218,7 +2218,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
         return true;
     }
 
-    if (access_type == MMU_INST_FETCH) {
+    if (access_perm & PAGE_EXEC) {
         mask = env->cp15.pmsav5_insn_ap;
     } else {
         mask = env->cp15.pmsav5_data_ap;
@@ -3485,7 +3485,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                        result, fi);
         } else {
             /* Pre-v7 MPU */
-            ret = get_phys_addr_pmsav5(env, ptw, address, access_type,
+            ret = get_phys_addr_pmsav5(env, ptw, address, 1 << access_type,
                                        result, fi);
         }
         qemu_log_mask(CPU_LOG_MMU, "PMSA MPU lookup for %s at 0x%08" PRIx32
-- 
2.43.0


