Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7235CE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 15:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSHe6-0002YL-Dx; Mon, 30 Dec 2024 10:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHe2-0002VA-82
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:25:27 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHdz-0001jO-Ct
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:25:25 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so66706945e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 07:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735572321; x=1736177121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qZxfXPJzrwIbM8EwrL9IK6oVeDERpQ9vvDWA7isyiAQ=;
 b=DvcxLdrGpJbDuy3A1rhn3ZSfSb/vmldOk0R+MEgs8JMAH65VpN/FPQgV9/gw61+plx
 oVctovw7ySfTmj7uHkaeK75G3VRyxr8+XnzGxLjX3E2tCKWpyLoOBVjbPgbEIV3vHq1q
 bUGrxsTlpHuwmjuCpUCIgJpsMwirSjw9eBKNi7CK+6eQGl1Eubi/Li70HEyPXULofAAa
 bC7Ywda8+fw2N3mAOHdCOGZ0ocg3a2o7mzXnEBoYVa4cwkx/MrHooHtkmVQERAO0mumR
 D7guQGyhy4Q7ScSCTcOAzPmlbZr5z6eG1+r6uXkNEJ46+UlOkexfA8YSbAvYdqC0mT31
 jw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735572321; x=1736177121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qZxfXPJzrwIbM8EwrL9IK6oVeDERpQ9vvDWA7isyiAQ=;
 b=jMIIydJZAre0kFG9+eYzIvNrsbOOL0GH1lYILoRJnD2xHpICMHuE2cxT+lbibfG9AM
 9SlN6vTWXiK57KxHL30Z3c1qh6Ct53GZaQCfZQOYKSbOdbkeH4/Mv8pGE5T2ZP7w6KYK
 lKHaC+Mi/tQtverlPftPKeeaJfrjIwMBZk95ZUO2il4rkdS5d46a0J2A4bDrF19QlLKf
 8PQ8xrEovdJb/qhbaY7uYtTfAgupU8up3rL6OO5DVsa5V3sjkDHZHB4CFU2ZFsMpiqsL
 jJyUQur7F7KeDBged99PpPnSvNVjAN4CotYL86tJ8VLfN9Z8mA6NpwoIF4DfYWAAO7AZ
 DxmA==
X-Gm-Message-State: AOJu0YwTFXWUCncO4JxbnxVzISb9k+9sAw73Z2eOhy8btCOFmCj1tSyJ
 z/b9bq0Ro/bc441uk7IDPlHFAM/AGwl4N1OBgjGAxlRoXCsX0Rl9gSHm8gfWpmI+FwZcoVFrL6r
 o
X-Gm-Gg: ASbGnctk4ajhvViYi4KG3YyGADlNlv5MNy/HRN/SLpxgoxDwBRoOPBEf0lQRe4AYv/5
 cWArgLWY4Q89uhejblwu9Xvj+gO1XeKENakzKMdOYCHbycXci030SgZdO3lZUFpzlPSM0cAPBC3
 OhImZy/4nzhWoZ58CAbJwxRDMVxJm4ifiP7QgBY12QoayIzhdmd4Qqy0HEd5Hob4dwf2kf+8+e2
 Bnj8o+rqDjcgPswGDZsBmdDs57qlvhnNCxLZd2Vc5ecWm73XyEUbiK/9sHijLdKaZlQ4Qu2MRyH
 1pIiV48deKTOZFi5n/NpDQolS+wRKp8=
X-Google-Smtp-Source: AGHT+IF9o0LsKJq51qK3ICYJjVHteBYlSHKseyKha7cylB0nxmKKupyuGeP5wS0nvE5fAcw7Z2Fhfw==
X-Received: by 2002:a05:600c:1c28:b0:434:f953:eed with SMTP id
 5b1f17b1804b1-43668b78d06mr316347415e9.30.1735572321171; 
 Mon, 30 Dec 2024 07:25:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e140sm30989372f8f.79.2024.12.30.07.25.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Dec 2024 07:25:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/5] hppa CPU reset and speedup
Date: Mon, 30 Dec 2024 16:25:14 +0100
Message-ID: <20241230152519.86291-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Respin of:
https://lore.kernel.org/qemu-devel/20241229234154.32250-1-deller@kernel.org/
"Add CPU reset function and speed up runtime and translation."

- Remove hppa_cpu_init()
- Reset PSW using M bit (untested)

Helge, could we add a functional test booting Linux?

Helge Deller (4):
  target/hppa: Convert hppa_cpu_init() to ResetHold handler
  hw/hppa: Reset vCPUs calling resettable_reset()
  target/hppa: Set PC on vCPU reset
  target/hppa: Speed up hppa_is_pa20()

Philippe Mathieu-Daudé (1):
  target/hppa: Only set PSW 'M' bit on reset

 target/hppa/cpu.h | 11 +++++++++--
 hw/hppa/machine.c |  6 +++---
 target/hppa/cpu.c | 20 +++++++++++++++++---
 3 files changed, 29 insertions(+), 8 deletions(-)

-- 
2.47.1


