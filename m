Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B5BCF34C4
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6fe-00029e-N7; Sat, 05 Oct 2024 11:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fb-00026n-MF
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fY-0002P1-Nq
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:10 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20b9b35c7c7so21873515ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141967; x=1728746767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4X5zP7zXx4H0vSkmfgBSYylbUDArgVMPw2dfqzvhfaA=;
 b=x5YzRLk4ARd6XpiUopEFYv+iyWGitqOvwSXLlYUSZ/BgOIE07Hc+9hxiqJNatRBfd4
 8hcEPA235BXocSstX592wCuiJGiJ1yPcKJr5pJvZcAhpB0G0cmoRjzL+9ZayYXA9eONg
 NLlozVhLBfhVos5qMndqHfcpCWKdzhoqwBQLAwtXV+Hx+1Jug/IFxHCNY3O1UuvPCWaJ
 pZ/ZZM0kuTIND1SvRbxWaT03etn33NY2VtUjWbo310W9SxJSTLKfcsZdQLXtJbSAa9cf
 o6tRVzk3FD3GcEAcvjRs3XQIIULJbdJqvtwmHNYn2mcjiNAnU1t4dXhr7BkLNAcliG4R
 Xs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141967; x=1728746767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4X5zP7zXx4H0vSkmfgBSYylbUDArgVMPw2dfqzvhfaA=;
 b=EqcNM7Fwxtnofdd4NVYEvCpIa9DiFwT53ghJlYXH0NrPkfp8pXGyBrjeVa8mkcI2/B
 FfcM0bQks1JZqQgdXAVYtMyukDIqPO+L8NRMe+SmUBE4Sv5W3DzezK/XxPJfNNPS0kzu
 aGe0J7Kuq4EQoPjjMg9vI0rcw2RI3ThKrg2yk7HvJoALan1TC8JRxn+BkNblwX9lmueN
 GLafF3+3tStl/oHQWaf0fTKWIqlIM3Wme3JiZBKUKjkUbHPt5SJqD031kfbNf4UhsAa6
 WaSD90WftC01Sl8mF+CKrz0j8n2fYOAQE5Ecn2R9yIMMPI8g+jSnmq9M3a6bAaH96bDY
 KvNQ==
X-Gm-Message-State: AOJu0YwVgTxOXBlq1aMtDAoOEaqunBK6qU0Y2DoKPdiXBPMvzW23wsyb
 DS1Q0uORIDlilm46gtoSYIEjLrLeEdMSFZKgoa0mkP9RbsCEb4maTI+jqBDVGMHPffxn8oqDXv6
 f
X-Google-Smtp-Source: AGHT+IHY99g3UXT4c2ojVRByg/b7oYD6LPj2/nVP/Gw9LAajOrCDKRjQrnpHrqEZDe38lbLZqZ4qcw==
X-Received: by 2002:a17:903:1d0:b0:20b:fa34:7325 with SMTP id
 d9443c01a7336-20bfe291d4emr83779435ad.43.1728141967491; 
 Sat, 05 Oct 2024 08:26:07 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396948dsm14351765ad.225.2024.10.05.08.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:26:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 15/20] target/arm: Pass MemOp to get_phys_addr_gpc
Date: Sat,  5 Oct 2024 08:25:46 -0700
Message-ID: <20241005152551.307923-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005152551.307923-1-richard.henderson@linaro.org>
References: <20241005152551.307923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Zero is the safe do-nothing value for callers to use.
Pass the value through from get_phys_addr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9af86da597..e92537d8f2 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -81,7 +81,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                               vaddr address,
-                              MMUAccessType access_type,
+                              MMUAccessType access_type, MemOp memop,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi);
 
@@ -579,7 +579,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         };
         GetPhysAddrResult s2 = { };
 
-        if (get_phys_addr_gpc(env, &s2ptw, addr, MMU_DATA_LOAD, &s2, fi)) {
+        if (get_phys_addr_gpc(env, &s2ptw, addr, MMU_DATA_LOAD, 0, &s2, fi)) {
             goto fail;
         }
 
@@ -3543,7 +3543,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                               vaddr address,
-                              MMUAccessType access_type,
+                              MMUAccessType access_type, MemOp memop,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi)
 {
@@ -3641,7 +3641,8 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
     }
 
     ptw.in_space = ss;
-    return get_phys_addr_gpc(env, &ptw, address, access_type, result, fi);
+    return get_phys_addr_gpc(env, &ptw, address, access_type,
+                             memop, result, fi);
 }
 
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
@@ -3660,7 +3661,7 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     ARMMMUFaultInfo fi = {};
     bool ret;
 
-    ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, &res, &fi);
+    ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
     *attrs = res.f.attrs;
 
     if (ret) {
-- 
2.43.0


