Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDB7CFA742
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6fv-0002NL-Kw; Sat, 05 Oct 2024 11:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fe-00028o-6F
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:14 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fc-0002Q3-7K
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:13 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b93887decso25572495ad.3
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141970; x=1728746770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tqb0TUsQOZF/sRJ8YxWqhKeQa3g/EH2JXyCvd2UdW4=;
 b=y2YAOQ2M3rfwVjP+EOOSPePWmxRMBHW1uH657FCgoy7ROq1LhmaJzs1ghCh/J3ort3
 YV35cL/qbEzjFpljuHz6nghVuPykH6xfIPQ1mQw8ZL9LXYSscObyfGaWCX+SmNUk6w6t
 d4jL+HRo4lhJYbof1Q9Wsg0e5oFARsMDcnF4aB3t+XKs8mu1QGNdcLWJWka2HcsZ8NYi
 M4veyKjocwq/FrOIkDFflDwxPkN4Ccvd1dPAmOisORPaPxiLm/L2Iiqo5to9YU089RZ5
 IyAe2GbW9ed/4R+3U+9SM5mNpZPMrSwMVQw/Zm2aKsoH7GgobyvmJXhRMpuDhci4cHzT
 WzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141970; x=1728746770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tqb0TUsQOZF/sRJ8YxWqhKeQa3g/EH2JXyCvd2UdW4=;
 b=TRFNORhotHzzPgQtlldw1nGOsjPZItWKvKXrD6CtUz0vK8A9zR9GWzyMGFgvp/2uCX
 tnZ3G+gKPnCSgmrOb8yK6BOPJfOzscwyW6uf/L3vQFW25sXPrmhHQaYuTXNSQ5wA89IR
 4ow83iWO1XUIEz68dqKA3RbKXHz7Wyi+5DUXXr3G899jqlNyqfeMak5vdMlCyeshJwXD
 1f1UyZjtopEf0kV2bDYYWb3E0RvRVV12SACTbT3f3D4eYYxXuIS1M9kaTlk9Y9WUHDIK
 g6FZOvVKKZ71+pCHzFWeoHvVLDYQRJBHvuSjoqn+g1SRciZJOYw6fcjjkCdlPmQXatCV
 xXew==
X-Gm-Message-State: AOJu0Yyf+kWrWRYW5DhnRwCV5tbbtj2jzzBhkqbceQFpAqsOQZWpHofv
 La7F8QeEpoiWSjQfzQ9cJ3oml5g/YDoO1T4Mk//7ASETNC+d55MTGBLfwDJYs00kEyXdNSptNzQ
 c
X-Google-Smtp-Source: AGHT+IHAcc49fQDj+6dUv1WwyItmZo+VQhDVyFSsiB0HVGJtSbOyDZXUNQcKgpb3qKjj8UutpLm7Eg==
X-Received: by 2002:a17:902:d2d0:b0:20b:be06:f3d9 with SMTP id
 d9443c01a7336-20bfe1887c8mr91971805ad.24.1728141970334; 
 Sat, 05 Oct 2024 08:26:10 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396948dsm14351765ad.225.2024.10.05.08.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:26:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 18/20] target/arm: Pass MemOp to get_phys_addr_lpae
Date: Sat,  5 Oct 2024 08:25:49 -0700
Message-ID: <20241005152551.307923-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005152551.307923-1-richard.henderson@linaro.org>
References: <20241005152551.307923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Pass the value through from get_phys_addr_nogpc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index f1fca086a4..238b2c92a9 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1684,12 +1684,13 @@ static bool nv_nv1_enabled(CPUARMState *env, S1Translate *ptw)
  * @ptw: Current and next stage parameters for the walk.
  * @address: virtual address to get physical address for
  * @access_type: MMU_DATA_LOAD, MMU_DATA_STORE or MMU_INST_FETCH
+ * @memop: memory operation feeding this access, or 0 for none
  * @result: set on translation success,
  * @fi: set to fault info if the translation fails
  */
 static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                uint64_t address,
-                               MMUAccessType access_type,
+                               MMUAccessType access_type, MemOp memop,
                                GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -3534,7 +3535,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     }
 
     if (regime_using_lpae_format(env, mmu_idx)) {
-        return get_phys_addr_lpae(env, ptw, address, access_type, result, fi);
+        return get_phys_addr_lpae(env, ptw, address, access_type,
+                                  memop, result, fi);
     } else if (arm_feature(env, ARM_FEATURE_V7) ||
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
         return get_phys_addr_v6(env, ptw, address, access_type, result, fi);
-- 
2.43.0


