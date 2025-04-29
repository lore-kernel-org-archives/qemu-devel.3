Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B22C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9n3X-0006qP-Gv; Tue, 29 Apr 2025 11:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9n3O-0006ce-UK
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:39:27 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9n3N-0007dO-9d
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:39:26 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39d83782ef6so4978235f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745941163; x=1746545963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8jtYz/pm0MOVEXjDxd+0O3U5LV+mIpnGicCzP3Uyik=;
 b=paINkDjItM+KWbiZtNH4fimYMn6CQw4BvGMUU+hdvPvnVagb6pxMGWiVNYU6jTaSTi
 ik5LyHV4t8ryFPzj7IQ33YaEFI44tUmorOnGZbALPSsizOc+0hgsWe5OUhJ3laNBk2vU
 3zLkPJuIN84PNIG4rFe+1587ClZQk9XOKkbI5/TrepuGmjY+GBm31B0FN/jDkX4UB9mK
 iWakEq8XfR3ESxOKOYwT64/VP6kWZdNiugGvRTB2TgpbGrDpSbZ5ZP6VZAJtNTxZUgd+
 CyHLJ70oLh9ZjBw06DY2zp/DMRxBJfpas8G1/IsM2D5hUKNE5oIuhI1hG/SnLUD7y08p
 SBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745941163; x=1746545963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e8jtYz/pm0MOVEXjDxd+0O3U5LV+mIpnGicCzP3Uyik=;
 b=v2qQyoMpKfmzf9ZVVoDcbVtwVaZpTC6h7meAlUjKQR5vLH1m7DeG7b5khNRAYH/K+I
 kDPHoLi00FIxQbdl18Yh9rIvk3Odfk9GdJaed5gyaffWISeCpML3Nz3tf2GDHSxUGxkH
 x6gMIHT42n5uIGGsRmK9wb8I5QBoHnAhNG9pKPVoQY8kjDUDcauKby3cla7j+Iz6+aFP
 381/CuR7R1jlNOQCWJPgXINsyS9hw153OsDN1mDeizfyybNMqLPFng132sVATp5Bgxa+
 +DEOGZR8n4mbOicx96VLG8FY8NGx3cky+4YNPx1tvdcA7lyucTNAc2/gEc/5zi6cfShb
 g63A==
X-Gm-Message-State: AOJu0Yya04WrxiZhVLUYZ1V5+3nCmEJIH1DECArK/YyZs2tavK9PjVcQ
 FZ0GBGJ5ySRgHimW3n8m0GrlGLzYA7zEoyKxPvc4E3TOIKJmOX+kH7aTuh+fZqEF9/yiqswfHZV
 n
X-Gm-Gg: ASbGncs9oFgYcW5uPthIuf4C1/fLhg6dwNo+JYPVwvDrPkLSDqKc8GooY+xQe04I8VM
 ff7dfATtLMB1vQpSeiHV20bg7J6XEhlfCoU9V9jiVr/HLN2s+9jkT6Hr/za++GeEH9qbPFcSBdG
 XEID15ZOE71+E/zeUqAQXbQXu1Rl8t0e1dtSsH2aGiibAhzEqGvDTja4k0UyrmTbMt0ZhlOuqZx
 QNtWMbyFK3K0cm+0Ku7DlIjnvXnY7fWQBysXweSegm8JIaAyl48alXhJX2PlBNVV1iYKDcJ3RVZ
 1fv5i0t7h1d0rF16tppIIVk5w3beRXTCtY2EpZrblI4UENHvToo10OY02acE4ccAC6c6PYhgkO5
 WHanEcmlhn2AAjTf8qsxX
X-Google-Smtp-Source: AGHT+IGO2MPT3TtqRMvCdymRU0xW/J1i5xJ3NpgxabCA0mzas2TTL+SFTByeWj/K4vbhAo9fnjkh2w==
X-Received: by 2002:a05:6000:228a:b0:3a0:8536:1261 with SMTP id
 ffacd0b85a97d-3a08a513362mr3207285f8f.8.1745941162933; 
 Tue, 29 Apr 2025 08:39:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a53874a9sm160553965e9.34.2025.04.29.08.39.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 08:39:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] hw/arm/virt: Remove deprecated virt-3.1 machine
Date: Tue, 29 Apr 2025 17:39:06 +0200
Message-ID: <20250429153907.31866-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429153907.31866-1-philmd@linaro.org>
References: <20250429153907.31866-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f70d90d12eb..bccbc54073e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3570,10 +3570,3 @@ static void virt_machine_4_0_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
 }
 DEFINE_VIRT_MACHINE(4, 0)
-
-static void virt_machine_3_1_options(MachineClass *mc)
-{
-    virt_machine_4_0_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
-}
-DEFINE_VIRT_MACHINE(3, 1)
-- 
2.47.1


