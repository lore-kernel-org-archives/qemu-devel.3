Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8C9C83035
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 13:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWEGe-0005ww-Mn; Mon, 30 Jun 2025 09:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWEGc-0005wW-O0
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:09:50 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWEGZ-0003vy-TM
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:09:50 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so1587966f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 06:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751288985; x=1751893785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JYsduLxNVqPKGIUHLquU8P/wxsfx+yTwXnitP4Bhu9k=;
 b=zp5SVFZtIUuVzNvduoECWUZbq15smnyO3tACjly80UMZCNm0LrWmyrQWwrERzkhnIs
 9Qt7ZRyQDsWOIM4+ZuzCCOw7qxaDFSxkiLSitZ7Y/fUDFdkRrmFSfD0Y2winRCUKUP0D
 AM+M/S/hwmtRcMQeAG42PRj93jLAaVCEvtcLpKJf4uvsRKqmlTG0JtOyugEmM3vkwO5v
 6bHhwexawphII17JczJY3e67U1y37VqlRDYznJ44+q4F0r3dsKc+0RYQbGzQWENW4Dx2
 aHcR82FtC699U9dNFXmlgI3GecifqXaRqFpmXtyjkzouV1MhnrVrmC6iAaEK+NGA7izp
 uVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751288985; x=1751893785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JYsduLxNVqPKGIUHLquU8P/wxsfx+yTwXnitP4Bhu9k=;
 b=PqKvJT/W866HWu+GJjEIGQFcgFLD1vgh3DhTQcTUPkQbue9LpVr2V9T+59MIYOVIG/
 TepYTkEtvZH5FYAZbTwENxbthYOFtvQIjhfYuMbAUy0fFzkWFvDSE44YW5s/MDlWqitR
 nZ0Y8rmS3lWmFXgImXd6mEwaGQ9OR+9Tb2Gb39HM0d4t69yZlnq1yI2KQdXRQ/QPT7PW
 ABA2purooxSLYIL0ayysYm0tw1TpNkC88T9MzVI22nG5WTjwHyT5Sm8p4nPqTJusV7x+
 C5PHxI+F+jTc+ho2OVx/wlij+thDpEhu3Ab1hySnXODf+8itCSJrqiM8Jo7j3bIYi2UW
 jsyA==
X-Gm-Message-State: AOJu0Yxo2qEWrpapn3WKfNVnbi9t93Jr7aObog04cbLh2iWflFAuX/qD
 E2p3MLSDCQ1poiThEl22YGu1B25Mc1POwLjI3JyX5fG+3ecblrmk99eG6SRN1+3p6IjLrXHJLOY
 R2EB3
X-Gm-Gg: ASbGncuGi8C1mG32VmMa5YYA1ZgyYml3Nraf9bOtoTUNEyvs/kaRmOfJsU/FqQ8BMZ/
 /puaW1FeUTUXfwFzGT3sLJdEfrI+Zaxgls98TGwfLLbypQGeKTVwaLC6Cjg8QoHay3jtqTyNwWL
 N1x0g7m3jivf6Nja297I0XyLUf82qwgdYTF/8XKOsIF5s6QcBL3Y0Pck8HdkUj/ADCX74ge/8RX
 HkZMenAR+kU9TppKsy/fCUgELu7XRT3ziH0zUUrDXAkDeuHZorCmJFEL7B5ZcTKqfyws1N20LhF
 rNvTrQry4cor5z5JM0B8HW0ELIvjrvckSh6HNr+AHJ0xL0KntFFULM/XSMcyLt3S2jM5WWXdmNY
 j4/U7yG7zZDdve3d2T1+22NtieGg5M5P1093G
X-Google-Smtp-Source: AGHT+IGGUzavBAxnZDAudqJ5R9I1M0tcbn771DSJnY6iAVvDoRTWzTNamhzqevp5dtEWdPx1XkvQuw==
X-Received: by 2002:a05:6000:1786:b0:3a4:dc93:1e87 with SMTP id
 ffacd0b85a97d-3a8f577fdf7mr11776774f8f.1.1751288985121; 
 Mon, 30 Jun 2025 06:09:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3aba76e40c0sm6177885f8f.59.2025.06.30.06.09.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Jun 2025 06:09:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/6] target/arm: Only set CPU_INTERRUPT_EXITTB for TCG
Date: Mon, 30 Jun 2025 15:09:32 +0200
Message-ID: <20250630130937.3487-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130937.3487-1-philmd@linaro.org>
References: <20250630130937.3487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 34c45d53026 ("target-arm: kvm - re-inject guest debug
exceptions") removed CPU_INTERRUPT_EXITTB from KVM, but it
also appears on HVF. Better to restrict it to TCG.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 889d3088079..764b1f82dc2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10929,7 +10929,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
 
     arm_call_el_change_hook(cpu);
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled()) {
         cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
     }
 }
-- 
2.49.0


