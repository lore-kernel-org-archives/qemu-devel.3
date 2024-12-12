Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBB8E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoKr-0004zO-1W; Thu, 12 Dec 2024 13:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoKp-0004yq-47
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:54:51 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoKn-0006aA-EH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:54:50 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-725e71a11f7so1704021b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029688; x=1734634488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BSVRLQ/NCbTr+znZaNjcUH8IYeWT9qLO5QVBWX7wORU=;
 b=rzVYXHRIeIC9ukl6nnTzowbGMk8EFI4pOAy4sg+rlEZYoToCXkA0eB6tH85ZzWBpdm
 G/tZFeiEpmcFIVPrCLVRy1zUrKNpINhXGfmoxwrnseXtXn/WY54D6dHZW44S62EzvB1e
 s1LljfaV066ISObWtgAROik73FYtwzK4XxtRprFJKuulgmUtFfsGcKCvANKa/3kVOI9v
 pGZb1G+gq+2s2Q1+ig/Qo551zmYGgbTyfOO2qaM9THOl1Eca3gHjIsCSKCgLVR0JyM6Z
 fN1hcYIz1ZrItmm2770VRP3yRF0khHm0VR78FQyVkeS8BxZ3UwmAIXhhovbfhRNyGeZ7
 X3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029688; x=1734634488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BSVRLQ/NCbTr+znZaNjcUH8IYeWT9qLO5QVBWX7wORU=;
 b=fQ2yjSoZ1TseIZfIY5KV2fHJxQ/aECy4d0QRXfZfywZHC9+aUcR7t3zczGEkgsEPdC
 6yui8rkYMyElKJiRG8uTqD68b/QK1gIBIyMDzdCbVMdq2P8h+rnZddnmDwZRhSvycs6a
 /YD8C5tXF7cLZ4gOY1Qm2cIYtL82Hn71GtcifafzYd8hRjwcSGcYoYpl4HK9HP9Ey0dk
 dJovugAkwSsot59yXlePmLnpIf1b/55T48IPbRl4/1YaCYb84V5GrjwG43D40Tl52dLs
 z0u7PJBKuezEfTq/PVo9/6+CclaPnZkgKosT7SUYA8jHiX0l5v24rVoehD+ONWGOB89G
 OrqA==
X-Gm-Message-State: AOJu0YyZ9J6AqRYbrTh/piw+MfBGRKzTEGX2/aZScUnvfmAgbIPukeYV
 YudfSmUi3Hf4Howw/hgV7hE/wc2+0koM9pCR4L/7CmsKw7PXqWmVuvpwIyZ3mpbYTVYzgOXn0lB
 4
X-Gm-Gg: ASbGncskpYykMCTaShpixGyhJ75oeymU+MMD7IYkNwzs+fFOuD0XW/IHUr/2ZEUH8mK
 VLgZTtAhb0p5YDNLUG+i5Xm4qCj6RmaREM/Nlp+eaMu4uOw249BmkA2lpDKRmMIwmeAW73Hx628
 y0Mfuf4+j974Sm2r/9y3N9CS2TBIoabpOUloDtICxaGg95cQEI5PLgstrQuL8mqAGS6JwPo+Rl9
 4AJdM1dRS/OJv/iQZOXen1iF8XiyeQwxWRs782dMIeXlDoW2oLWV3akUodm3vOMbh75PHY2Kfac
 Ryw9SFuT0U4mW+htIWER0d0gk3Y+GB8=
X-Google-Smtp-Source: AGHT+IHVXn2W0r6tSoU77aUt+fJJfO9dJ9F7xpCFOmjp8kKXPWlbXNvPPa5bMX3EM6iHOqc6KPq/qg==
X-Received: by 2002:a05:6a00:4c87:b0:725:4301:ed5a with SMTP id
 d2e1a72fcca58-72907c19ba0mr1714891b3a.2.1734029687822; 
 Thu, 12 Dec 2024 10:54:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725ee10f928sm7499833b3a.32.2024.12.12.10.54.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:54:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/18] accel/tcg: Use tb_page_addr_t type in page_unprotect()
Date: Thu, 12 Dec 2024 19:53:28 +0100
Message-ID: <20241212185341.2857-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42a.google.com
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

Match with the page_protect() prototype, use a tb_page_addr_t
argument instead of target_ulong.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/translate-all.h | 2 +-
 accel/tcg/user-exec.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
index 85c9460c7ca..c50661a05d5 100644
--- a/include/exec/translate-all.h
+++ b/include/exec/translate-all.h
@@ -27,7 +27,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
 
 #ifdef CONFIG_USER_ONLY
 void page_protect(tb_page_addr_t page_addr);
-int page_unprotect(target_ulong address, uintptr_t pc);
+int page_unprotect(tb_page_addr_t address, uintptr_t pc);
 #endif
 
 #endif /* TRANSLATE_ALL_H */
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 06016eb0301..4ed6dd19f30 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -696,7 +696,7 @@ void page_protect(tb_page_addr_t address)
  * immediately exited. (We can only return 2 if the 'pc' argument is
  * non-zero.)
  */
-int page_unprotect(target_ulong address, uintptr_t pc)
+int page_unprotect(tb_page_addr_t address, uintptr_t pc)
 {
     PageFlagsNode *p;
     bool current_tb_invalidated;
-- 
2.45.2


