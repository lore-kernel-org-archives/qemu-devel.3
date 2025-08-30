Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C479ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNve-00062Y-Gh; Sat, 30 Aug 2025 11:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMj-0006CZ-Ob
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:43:07 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMg-0004Jh-QE
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:43:05 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-77201f3d389so3022591b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532580; x=1757137380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+ER0bRwaWJSVZXuKMTaNBSXf4hbZ3aeU4lFfN33xP8=;
 b=RlotFGoVZ4cQE/edn06eiZXmRz+bmqX8PVcDueWCdLr8b6fPTFEOuSra1tKx9vK/25
 fClw8YlT5raUEAIVeN4HblZkus5xYpqcax+591Xupf3Tlza+0frVaQaXyItFmCNbzX1P
 zKrHBGeY8tkRyrRv8YOQGZkrokyW/AnMgXPpQNYJEGBrjDp7DwjjQoeWnfgk5hpwJfwq
 xYCL/JKlqNaf+elh3cLf3dxAjeW4sqYE3hhOEwBUq+XUr6SSdzsKFNUa68PsPBU9lUkO
 SL/e+QFHZLE65GoRK8RHugEqr2T62cH20Ebvrkgq7FSF+U8yASiVvlQIfBomSZmjAdCU
 APPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532580; x=1757137380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+ER0bRwaWJSVZXuKMTaNBSXf4hbZ3aeU4lFfN33xP8=;
 b=QB2w+0DKjWRKt/qvj2SyH5/+GuvVwe+TVI5994aDwLxe6DvnE/y2/EAV9tl41Ngdrv
 tkgcu9/4t5rwBoaXvkNvJX6W/vGvNBYfxgDP6L0nLsGtrCfOM3oiAEiTBJPKV+18dtoP
 JAJg5TdBIY6Dn1C3jZZFs0kHWM9VAoXe2/OZg/4/IAaEAILR0at73o43TRqaJ6N9ZQH5
 wwHxlzS1iQOdGo1c+mzRybBM2SiIC6+9iBbH62DfR0xA/tGGGswNSjWY2yXWyNp0yagU
 OwoG2hG9/zgSNGOwQJKNErYIhTO8MIqivS7sH2KtTdnDKY67RwjTLw//kjh6xEEi2dMO
 MP1Q==
X-Gm-Message-State: AOJu0YxaN/XTgMs/D1V85DEW9spU+yyXByAklgUcN5tixVJi8DgcHF7D
 fgG2DCjxzDVEhCAKC3FUAZ/jAJQ/iBnfUnIwEjvjVDZeMnKPenkPkyAcIeZxp2Uy5I76u6BbqJb
 tq3Diq00=
X-Gm-Gg: ASbGnct5bkbMAb/c2m1ji+XPJXCNLExT+J6OS/MN0aPc7F4TXr1DHt1ySFhTdkltuLP
 p3PHNIvDpUd3hp704Azc7Nfs4vgMGdw3Xf3g2p0/d6xIUkMdsYA5+U7mgLclSqq2r+pUP2WEETO
 XryxHFSMjnFjt+ehY+6JP1aYl1GW9Nv5NKxWfaMSFsYfiZd2VQ8e4CXk+Sa0ysjHL0yF5eeiGXE
 vANxoUFdzkJxylkE0HzvrUzLplN2vNwYKyzOEHFfzhQ9T7rpam7sud2LUF9HEQtlTJv372PxmLD
 nceQSMhtHHfhFC16bVmlxl30XNvn5JhBX+BwLNIZbBTfs/RVQna+jQsbhadw5zUFTTzmyBALGpt
 H3YtBKzmZgzXxkpSj5JEZBJIFIZSbLVnerrLBZTDz5L9M4C6OY72cnnqbfsSltt3SyfBxF6Y=
X-Google-Smtp-Source: AGHT+IF0GzHSibwBrIdnpkkw5gj7w65Vb5Z9XfZX58mDgZe8ftvWBcDfJ72rdoT+NbZNWyoLPVCgew==
X-Received: by 2002:a05:6a21:3287:b0:243:a705:af7a with SMTP id
 adf61e73a8af0-243d6f379a1mr1564062637.40.1756532580635; 
 Fri, 29 Aug 2025 22:43:00 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:43:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 31/84] include/hw/core/cpu: Widen MMUIdxMap
Date: Sat, 30 Aug 2025 15:40:35 +1000
Message-ID: <20250830054128.448363-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Widen MMUIdxMap to 32 bits.  Do not yet expand NB_MMU_MODES,
but widen the map type in preparation.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 accel/tcg/cputlb.c    | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 23eb849a9b..fc9a2291d5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -201,7 +201,7 @@ struct CPUClass {
  * Fix the number of mmu modes to 16.
  */
 #define NB_MMU_MODES 16
-typedef uint16_t MMUIdxMap;
+typedef uint32_t MMUIdxMap;
 
 /* Use a fully associative victim tlb of 8 entries. */
 #define CPU_VTLB_SIZE 8
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2a6aa01c57..416aaa1040 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -89,9 +89,6 @@
  */
 QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
 
-/* We currently can't handle more than 16 bits in the MMUIDX bitmask.
- */
-QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
 static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
-- 
2.43.0


