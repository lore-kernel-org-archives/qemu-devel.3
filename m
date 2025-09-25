Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A11FCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 01:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1atM-0007xg-FI; Wed, 24 Sep 2025 21:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1atJ-0007wK-Ut
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:35:26 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1atE-0006yy-AY
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:35:25 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso276898f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 18:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758764114; x=1759368914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VFhtUcOsJveEodO1UInRzpRG8sK6xpan4ybiG8pPGO4=;
 b=w+9omjpO/ZnrSdZHzHMBT5zG6RrDD3dQHqW7h/tgGhGLZfKtZZCoK+vQ2XnNH1p3xO
 IqOr8bBKTWOAV7zGQCuiqiKIhOmt3W3kdLAypLWpgNNVb8LVZ/MOeu7jNjeN7TdXId6v
 10j9eFBonhCHR6bYfAneTyPdRMriAMIbgrJyyQXdfyWX4aNw6FCPfOaJDp+6qARRxpag
 MgKVhI7DW2fKWAEP0leVfvTg5Rw1UoveecGXtA7BI1TO7g92KGoDK+N98zJQt4CMBGof
 tCxxc89PJqO+QiPzIvhvrUwZL+EfnXl9EEdJDJrHlaZoQuGPTIVpr/FVqCth+VYZIfaJ
 EsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758764114; x=1759368914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VFhtUcOsJveEodO1UInRzpRG8sK6xpan4ybiG8pPGO4=;
 b=bQnuFXZBIWPmvMfLSFHUpe7STxgd1kkpeFGgVjadoLZt7VQ1cJ3Z6roSSwr0b7DDGG
 Rd1+AKTCW8PHrPaIZZnT+BKGaky00cbBtckRJwnYHXQ6l2wHpv0v6kcEm5ygIgcFycLk
 PLSIbk3Q2NMyRpzYRT540hhzYPWK3tUkoqwaqL7iBB2Dyo1ujFHBGRvkaKG1pMsQ/d3b
 tJ55zK1IUP3+INgFw/20K8eENZnz/eRBVyHIMDw4nZPmD84Y8m5BFwqIKIMzXI9fVpw/
 tAZ3RBZy5nXjsODbCEgVvwIW/lC1fuw7/ue7FSFQ9ufugDvrpf5CvlxZK1HFj1joCUlE
 SmGA==
X-Gm-Message-State: AOJu0YzPub1VbiLne+eLEOOxAuYUF8ve2kbHFwi725EnAqSypoPzaOIb
 qPhJmIklkMGGR0uhLzfxMYbONe52Q8izV1PWHyf5Wq5o+40VrgVd14XeaQvjH5ZHFqJcp11wiLg
 E1YczgDS2Vg==
X-Gm-Gg: ASbGncs8dDhSg6FO8esVNwBVSzSVG5elJWya0mNPm0UHznUOdTjZ25FJpbu4NchWMOA
 y0K4QJqe8mefR7H7ZhWCuzxOJrFws/OJ957F7s31fiGuHY2T6UUIW2C0ZCJ0YJhSZRkppQXIdtC
 jJNlr4lY5+1BDVKqE/OcpT68151Mlougm40CWOztbzzsrnFKxkbYEH1r1lrYkk441FPaHvWwcXb
 Z6r+DXNe3EPu30XpNEJF4+OM5N3NY7LmFq9V0eh/FYEgO15/0ZIso4ycWciKYSYHGdUxT65x3e5
 ZWqIcB23xMZsznSbGE6N3pVoPqRgITyKXRNT11uo6XmvWi2zmf7ZUFB0xlIjO+NFRPktRxOFsrO
 azBqyWOGWfBPWDwsbtWo78c96OJDIYoANESxBzahpAxpn8rqjm6u+fglruhk12w+yuZ6aWlhu
X-Google-Smtp-Source: AGHT+IF85vRYd0XeNRRzrOCWI9iAZAA2pJuXuup2VaKw7r7h+sfdxdwI/yl82f036aOAVAU11JVAUA==
X-Received: by 2002:a05:6000:40e0:b0:3ec:db87:e88f with SMTP id
 ffacd0b85a97d-40e49e72912mr1359898f8f.58.1758764114584; 
 Wed, 24 Sep 2025 18:35:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33b9e902sm10576425e9.5.2025.09.24.18.35.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 18:35:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/xtensa/xtfpga: Have xtfpga_init() only initialize MMU
Date: Thu, 25 Sep 2025 03:35:12 +0200
Message-ID: <20250925013513.67780-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

cpu_reset() should not be used with an unrealized CPU.
Here we simply want to initialize the MMU, not the CPU,
so just call reset_mmu().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xtensa/xtfpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 6efffae466b..55de1a7a073 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -268,7 +268,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
         /* Need MMU initialized prior to ELF loading,
          * so that ELF gets loaded into virtual addresses
          */
-        cpu_reset(CPU(cpu));
+        reset_mmu(cenv);
     }
     if (smp_cpus > 1) {
         extints = xtensa_mx_pic_get_extints(mx_pic);
-- 
2.51.0


