Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8EAC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQK-0008SC-MW; Tue, 22 Apr 2025 15:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLd-0000am-NH
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLb-0006d3-ND
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:01 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso2415295ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350318; x=1745955118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/uK/6e74nn8Fot5LvCS7tmplWHujswrlAKxdO1vG4SM=;
 b=pqMS3LgFjVnlb7oJ4Zg71pITDQq+FrAzFiY2kUAWZLFcWeMTcb+oIwn6LBw2X+Pofn
 OGh5/8ZGIY67yTxcL3RQNzmM0kk82VD7AiaKbhSp6Tx1TUvXa6LxTpCdmnSaBRDmydID
 fYtFg2lzcBd7aJtBP6TXb+Qi0gvtWBG3VnIO8FdpV4dIejjZLzWmPJC6J3bcdW24m4fw
 F2Gxrt9M16vJiLOy+ToixW9VnVm9E5Vn8ETwEbHkEDf97BwN2bTAU/UCH2xyXk/gavC9
 7DENKwUNHCjrnPb1Gzsef2AsPCtxmBV88dZm+lCLmllEw6T//4VrcLPHbWpy1KQO3uPE
 DduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350318; x=1745955118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/uK/6e74nn8Fot5LvCS7tmplWHujswrlAKxdO1vG4SM=;
 b=H1CRzSg//IGHaD+959axekFfn6V/HhynzvtrFC1WGApnimF3x9nMq5XVbv/qW4JTmJ
 W2qQ3fui0VjhXkwjJ2ouI3uWaohk7cSMD0QotIOC3c4Fi1TeSs2XwSAfHW1iESvtitwF
 dEwddYLG06drXy88pjve1H0ptosZqKHR2Dhoh1LdsieZAGb4iu9HWq17OEB6BSjYBXkF
 kb9pLRyLbdK+5foD4fFTi0lh3bLsEeOjac8cHytKZWrkF5Ca1TX0oREGFc5DH5lrJqES
 6v9PWGFJizEQ5LizWwJzYQO2llpmc9y/g61nNzD5K7X6vt+GJSs97mD1Sgf9jnNKdOQh
 2LVQ==
X-Gm-Message-State: AOJu0YyZxwmcLVtGrSmk2tP8BUUKPUSSQkugqJWl9o+fF1Vp1TPlMbVG
 tk0q53XqzTT8tNXkypPLNCde2NImvMvO86Eq6kBPEmjXGPQQ6zUMB0ouML7H0YloMTqJKTAjQQs
 G
X-Gm-Gg: ASbGncuiRTK2AnD77yLVMAdMBECT28cuAPesBoKXcbHJ56tIYKlgGhhkTE8ig8MLQb9
 s6ldaYmOM8ExquUVD59GO4I/agRzNcPV85l8qOsYVRCofypUJqFXBdZtH6TfhcRee1lWu/FMMsV
 Yw+285GaTg8E8JmaSrlMfNUM+mnsBQ9UEE59UIenep/pauEc2c+HYjN4y00twuSUI+fXj6TnjzL
 /DakB+DJ3GidCuXHCtZYlY6EipZSgYwLCx5ma4pYDLsVRS96OrRcPkUAvz/wbUMAiKdiymjOdA6
 edckC2nuqqEWYOUDua1RwkDmxrazU50f8jb1NIjrNHsOWf4YM+ZCsAaK3KdTeZkeXbaFCcZSkMY
 =
X-Google-Smtp-Source: AGHT+IFyMAnr3n8Qri4/q7uvsoq2AvNHasCCWieoVTPkN6YKfgR7EJBb6G1AuHRET8f1DiXyyS0HJA==
X-Received: by 2002:a17:903:1aa8:b0:223:607c:1d99 with SMTP id
 d9443c01a7336-22da304bff3mr3947885ad.0.1745350318305; 
 Tue, 22 Apr 2025 12:31:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 057/147] include/exec: Protect icount_enabled from poisoned
 symbols
Date: Tue, 22 Apr 2025 12:26:46 -0700
Message-ID: <20250422192819.302784-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 include/exec/icount.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/exec/icount.h b/include/exec/icount.h
index 4964987ae4..7a26b40084 100644
--- a/include/exec/icount.h
+++ b/include/exec/icount.h
@@ -22,13 +22,21 @@ typedef enum {
     ICOUNT_ADAPTATIVE,
 } ICountMode;
 
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+#ifdef CONFIG_TCG
 extern ICountMode use_icount;
 #define icount_enabled() (use_icount)
 #else
 #define icount_enabled() ICOUNT_DISABLED
 #endif
 
+/* Protect the CONFIG_USER_ONLY test vs poisoning. */
+#if defined(COMPILING_PER_TARGET) || defined(COMPILING_SYSTEM_VS_USER)
+# ifdef CONFIG_USER_ONLY
+#  undef  icount_enabled
+#  define icount_enabled() ICOUNT_DISABLED
+# endif
+#endif
+
 /*
  * Update the icount with the executed instructions. Called by
  * cpus-tcg vCPU thread so the main-loop can see time has moved forward.
-- 
2.43.0


