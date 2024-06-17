Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3781BC2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 16:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJExx-0005E8-CZ; Mon, 17 Jun 2024 12:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJExu-0005DI-3y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:12:18 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJExs-00089q-Gf
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:12:17 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f480624d0fso32880765ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718640733; x=1719245533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTNFGS8vX+zjeGw3tiagWM4V6BogHHP8tAf3WNuhRt4=;
 b=WrN4pQdHuflbOaFHjX/eIds0gyjBpdAwHMVIZ0CvKuHwuvLhPQDOv9h5bdBY7E8O76
 PpT+oarg6/rNr5Jh+4SKehJ/QQ/bI9BjD+HR31KT9ZCzt8h/Hj7IPb2ftk8yZ91A+U5G
 59L+1272YkYLJao+t7yLE/SDUD9j7zeNH3Bn+1jiD4byvZx61gXoOUg+pQaKDGuUzMnp
 dQQzto7jBio6H6AePDzOZmaALNs85pXJ/n2Hm+4S2Y8PLZ8IGmSZR4oddAQbWFbhSpuh
 W0vZLEd/EKvJfFrpuMNzs8J3maJik97Vxxrnwtd9+ToUMBCOu9YVCDPbX5hPR5LJ+Vgo
 FIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718640733; x=1719245533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QTNFGS8vX+zjeGw3tiagWM4V6BogHHP8tAf3WNuhRt4=;
 b=lpl1NHH//qFl6Wg+GXSFBBDw8kr5PriRdJnNAYInqFS6vIeTfJMVubcP265fDewUU6
 sdSkBZDhXj6pWw7WHlQrpED+CjS34tggCXgrIkEZQVge5YlB9aShCQokTd4sxKgT4sLH
 Ov97G/oTYJXme/ezltHNYhwvJEDcJ1u3gUbOGDm/eYbt2XRaGtusAa/8Xw+OVDwTxuah
 AeQvyJFKSQeiL8feSGJcGE88QF0FuGJz28ezofPv2yeczMMpt86/5ipKnlksepaZLNsV
 MnLyN5kfMBVA+3xB92IwfrcygTB0n9AaOeAhYohZv+Ewr23AZIz7L4NmurhWU/nQJTxM
 AuWw==
X-Gm-Message-State: AOJu0YyglZahS1gui7UstoIstJz7+hE7MeFgPcDF6bcDJDK8UoddaolY
 +8KDt6v+5dhopCr5zQgQ7ys6OLPGA1W+cj/MpJ7onWPY5kU7bQPrNDCOT9GwtCQaQ+tIuHSaOiJ
 f
X-Google-Smtp-Source: AGHT+IHxG0vEwrNPtVdeLAo2FLq6k4ZvChThw1RPQjA4g7p2v5XqE2GUU40XGNJCKJTZ/r2O9zccZg==
X-Received: by 2002:a17:902:c40f:b0:1f6:8157:b52f with SMTP id
 d9443c01a7336-1f8625c60a2mr115174255ad.8.1718640733455; 
 Mon, 17 Jun 2024 09:12:13 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855ee8317sm80829285ad.145.2024.06.17.09.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 09:12:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 2/3] target/i386: Remove SEG_ADDL
Date: Mon, 17 Jun 2024 09:12:09 -0700
Message-Id: <20240617161210.4639-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617161210.4639-1-richard.henderson@linaro.org>
References: <20240617161210.4639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This truncation is now handled by MMU_*32_IDX, which is how
this was working for PUSHW/POPW, which did not use SEG_ADDL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/seg_helper.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 715db1f232..8884d82b33 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -579,10 +579,6 @@ int exception_has_error_code(int intno)
     } while (0)
 #endif
 
-/* in 64-bit machines, this can overflow. So this segment addition macro
- * can be used to trim the value to 32-bit whenever needed */
-#define SEG_ADDL(ssp, sp, sp_mask) ((uint32_t)((ssp) + (sp & (sp_mask))))
-
 /* XXX: add a is_user flag to have proper security support */
 #define PUSHW_RA(ssp, sp, sp_mask, val, ra)                      \
     {                                                            \
@@ -593,7 +589,7 @@ int exception_has_error_code(int intno)
 #define PUSHL_RA(ssp, sp, sp_mask, val, ra)                             \
     {                                                                   \
         sp -= 4;                                                        \
-        cpu_stl_kernel_ra(env, SEG_ADDL(ssp, sp, sp_mask), (uint32_t)(val), ra); \
+        cpu_stl_kernel_ra(env, (ssp) + (sp & (sp_mask)), (val), ra); \
     }
 
 #define POPW_RA(ssp, sp, sp_mask, val, ra)                       \
@@ -604,7 +600,7 @@ int exception_has_error_code(int intno)
 
 #define POPL_RA(ssp, sp, sp_mask, val, ra)                              \
     {                                                                   \
-        val = (uint32_t)cpu_ldl_kernel_ra(env, SEG_ADDL(ssp, sp, sp_mask), ra); \
+        val = (uint32_t)cpu_ldl_kernel_ra(env, (ssp) + (sp & (sp_mask)), ra); \
         sp += 4;                                                        \
     }
 
-- 
2.34.1


