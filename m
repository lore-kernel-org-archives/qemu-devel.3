Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B85C3DA7E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUc68-0003bS-6r; Thu, 18 Jul 2024 21:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc5m-0002u1-KC
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:29 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc5j-0000jN-Sv
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:25 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fb3b7d0d56so9671665ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721351242; x=1721956042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lffTC77hfuBCBlcm53ysSfFxUjHJ9OXDuax++3VtjJ0=;
 b=gftxvehNrfN5FV6jZov2DcfkBumsBw37zrftGYDBZ1J8NhUQDznwtS41HFALXN/gCQ
 dG4V4vw52P+NKd/Za7IR1HG49ZqOBxeWpr9qlAXg+n3WMZ3GsCZlb9P86FNASAlVkws9
 zi+qUE9W4VIjV0qFao2npxR63DAFsS5TuMhYa/bTocAyAvIu/Dh+yTcLc1D8u/Wi3UGn
 buZXhtLWoDJeBR7ZfuLUSGFVrp2s7FTgtYjyQ6b5qvJ53WPB8G2cYuSKoUePB+4HW2lm
 NcBbnDLd8WisInBv5LpYXbuDFuv6MNFG+AKqTyikIusHhd2mgXT6EkT/yggj8O0CXWTj
 Znww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721351242; x=1721956042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lffTC77hfuBCBlcm53ysSfFxUjHJ9OXDuax++3VtjJ0=;
 b=d/GKL+4Q2DME17gt4kxAlGOADvEw2ixnLOtHHrdWvwob9wSkG8N2ghkRnBg799DLmT
 2oGCQKtDCiM99ZNRmS4BHfcAjk8bGhvIBHawDt5GCM4DGQRnBzRnPxm0nmMCrM/1DwDU
 7XV2l700o67IbQPNZMZ/XYeszq9eaACG5nd7tNaeHxS5l9V4JmZENTzzPXpltRNgawp5
 lTywsKAb50g6zi/5Xbo9Fhngo52IFkaqNoCyor0/7TcvXeIpu8fs2MORL3Gn/WM6I8Nt
 eEW1h/b2mLBj87XqtPnn/FU7+i1QeD1+c2NRqz9N+2l2t65mbAOkPEE3eFF2rqnLVEfh
 x1qw==
X-Gm-Message-State: AOJu0Yxl2+zE1m0cuu4UDKWajelydyhKd1SsIq7/jaa/ZfSrkype0Is0
 ZybQ8HztFxrvYovHS6kbTifNv044in3jA9P8mqvcSrQQh4jqhgFPF0ERjJ26K0ekrDTHzSnWnvz
 v5Dc/TA==
X-Google-Smtp-Source: AGHT+IERzcxqQd9TBc5XTG0h+EZpjTUk4fb4kk4jAFlNS2wKpK+1ohtWm9kb6U9kAdd4xseTrLC5Hg==
X-Received: by 2002:a17:902:d506:b0:1fc:327a:1f48 with SMTP id
 d9443c01a7336-1fc4e1077a8mr63280235ad.12.1721351241529; 
 Thu, 18 Jul 2024 18:07:21 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d07ad9sm2067415ad.177.2024.07.18.18.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 18:07:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 02/12] target/arm: Use set/clear_helper_retaddr in
 helper-a64.c
Date: Fri, 19 Jul 2024 11:06:57 +1000
Message-ID: <20240719010707.1319675-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719010707.1319675-1-richard.henderson@linaro.org>
References: <20240719010707.1319675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Use these in helper_dc_dva and the FEAT_MOPS routines to
avoid a race condition with munmap in another thread.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 0ea8668ab4..c60d2a7ec9 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -928,6 +928,8 @@ uint32_t HELPER(sqrt_f16)(uint32_t a, void *fpstp)
 
 void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 {
+    uintptr_t ra = GETPC();
+
     /*
      * Implement DC ZVA, which zeroes a fixed-length block of memory.
      * Note that we do not implement the (architecturally mandated)
@@ -948,8 +950,6 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 
 #ifndef CONFIG_USER_ONLY
     if (unlikely(!mem)) {
-        uintptr_t ra = GETPC();
-
         /*
          * Trap if accessing an invalid page.  DC_ZVA requires that we supply
          * the original pointer for an invalid page.  But watchpoints require
@@ -971,7 +971,9 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
     }
 #endif
 
+    set_helper_retaddr(ra);
     memset(mem, 0, blocklen);
+    clear_helper_retaddr();
 }
 
 void HELPER(unaligned_access)(CPUARMState *env, uint64_t addr,
@@ -1120,7 +1122,9 @@ static uint64_t set_step(CPUARMState *env, uint64_t toaddr,
     }
 #endif
     /* Easy case: just memset the host memory */
+    set_helper_retaddr(ra);
     memset(mem, data, setsize);
+    clear_helper_retaddr();
     return setsize;
 }
 
@@ -1163,7 +1167,9 @@ static uint64_t set_step_tags(CPUARMState *env, uint64_t toaddr,
     }
 #endif
     /* Easy case: just memset the host memory */
+    set_helper_retaddr(ra);
     memset(mem, data, setsize);
+    clear_helper_retaddr();
     mte_mops_set_tags(env, toaddr, setsize, *mtedesc);
     return setsize;
 }
@@ -1497,7 +1503,9 @@ static uint64_t copy_step(CPUARMState *env, uint64_t toaddr, uint64_t fromaddr,
     }
 #endif
     /* Easy case: just memmove the host memory */
+    set_helper_retaddr(ra);
     memmove(wmem, rmem, copysize);
+    clear_helper_retaddr();
     return copysize;
 }
 
@@ -1572,7 +1580,9 @@ static uint64_t copy_step_rev(CPUARMState *env, uint64_t toaddr,
      * Easy case: just memmove the host memory. Note that wmem and
      * rmem here point to the *last* byte to copy.
      */
+    set_helper_retaddr(ra);
     memmove(wmem - (copysize - 1), rmem - (copysize - 1), copysize);
+    clear_helper_retaddr();
     return copysize;
 }
 
-- 
2.43.0


