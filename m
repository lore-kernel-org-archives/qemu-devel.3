Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9990ACD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN7Iz-00065S-7j; Wed, 13 May 2026 06:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7Fd-0003Av-RS
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:45 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7FW-0001Oy-NX
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:38 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so37684665e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778669729; x=1779274529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1JNG0WpLJF3nkTQNm/OVMSOxMuYSpcxBZJPbT2YaBCM=;
 b=qDNkY8LQSOSQnlU28PnQXbaeYQJpszEiJkDjX6P3jIlG27w5GOf6rnCJr52YZCowm6
 aofp8W9O24vec7bFUx3hFAtOQvyPou1ENzeZDqnmdgVNhMEKp1lI8g+k1z+EFNqz4wZW
 t0SUhXfqwL65Q2KGZsrPbAcjEPaffOYegZPNex0jJZtEgHrDDH8h9PeZZ6Od9cTFfKmM
 QhwYMyKVRSpCkY3FAvs1PVZhSpTY7shmmErd8U0IteCoLsnKKXojy9acCcd7NdAUE8ZH
 mOgNobqGXWAfiUn0VbbijNGP628qXvlUJNTsuUCy4qFTLOwMkYYRAfrEv60f5f+3ku9Y
 iIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778669729; x=1779274529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1JNG0WpLJF3nkTQNm/OVMSOxMuYSpcxBZJPbT2YaBCM=;
 b=g5MJQ48QETrIBtK6gRNFc8UBFJkLuXg9sPyTRxkw7LL1x1vf9eHgbn0bgti0UwO0FC
 qs2iIwW5o8RfnXLAmo8u7W2Vy7qjGHESSZYzq7QB0osobKqYxU55OqEeZpiji5C7WFS7
 Ge2vT68ERk+4wte9MmTYp6dDrgk4ZLQhtR+vJh+u9UEw11bl/5ciTO17AAkVv0LEajyo
 dQ31IkHJ6I9d8A+/JE0hcFRCmuTg0E3WtPjV8aUaCBPRckR8HhuDnVQPSQqQyvASTCVw
 28pqf8941D5Z7T/r3t55ji4wSvmaDO7Y9/5yLJJUGet5Y16hcobxwO3n/sVJ6RWMg+BF
 2hkw==
X-Gm-Message-State: AOJu0YysaUEYl//8nNG5wyljzmk4MH++YzKUAKjruQw4m7JbIRlx1hvo
 q0dK0aXXc5m9KQc6haTUQSXaQn9qvL82i4v0VbNLey7dqnjYtGIt2IY2PsRi9LTt
X-Gm-Gg: Acq92OHMb7Lf26aKjzc8x8C5qj8FWfX8+x8Yz5pkVTij9SYdtgSc1vkzmLIo5dCgJuN
 vdSEDMFZFAAJDDv3F0wpwWuSGXuflH2tvVZcfSqlVVPG7A63/yNwD5JxA/sv5XmENS0xeoVNJIN
 3SOuPW7xPwduU3VA85zt87oVjKwJ05idnbt+mB6xyWYT5eO6SP60SP7nRoRK7Tq89eKth2evTWq
 nXkEKvFS5TRePvdJRTtRI9rLbV3PQETCFeBIOiMnWaBwZnepZdzNgGZWLf6yXhtXAnXMyx9SvHa
 5u9ewk4IcfgyvQ6WDUWBpTWLI4Yfaj9moBgD8NCpIuBGVts4MdyAZNZTM0BX2elXqdambrcGZbM
 sxXxQi8kYi0o7jA/BeSHuP6WHpxt2RsWVGmIBU2BbLC3KHU1rJ8bBvF7kVKZiUm4QD5rTfPYlMJ
 GTHdSkD6AyLlwYdzbaaJYdifGd4aUtjqqiDviklQuKQqF5
X-Received: by 2002:a05:600c:4595:b0:48e:706b:53e8 with SMTP id
 5b1f17b1804b1-48fc9a1b9famr39261065e9.11.1778669729442; 
 Wed, 13 May 2026 03:55:29 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.196])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f410d9fsm56062295e9.6.2026.05.13.03.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 03:55:28 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v6 07/15] hw/dma/zynq-devcfg: Indicate power-up status of PL
Date: Wed, 13 May 2026 12:55:09 +0200
Message-ID: <20260513105517.146706-8-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513105517.146706-1-corvin.koehne@gmail.com>
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: YannickV <Y.Vossen@beckhoff.com>

It is assumed, that the programmable logic (PL) is always powered
during emulation. Therefor the PCFG_POR_B bit in the MCTRL register
is set.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 6b1d96ff80..5608460dc7 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -333,7 +333,8 @@ static const RegisterAccessInfo xlnx_zynq_devcfg_regs_info[] = {
        /* Silicon 3.0 for version field, the mysterious reserved bit 23
         * and QEMU platform identifier.
         */
-       .reset = 0x2 << R_MCTRL_PS_VERSION_SHIFT | 1 << 23 | R_MCTRL_QEMU_MASK,
+       .reset = 0x2 << R_MCTRL_PS_VERSION_SHIFT | 1 << 23 |
+                R_MCTRL_PCFG_POR_B_MASK | R_MCTRL_QEMU_MASK,
        .ro = ~R_MCTRL_INT_PCAP_LPBK_MASK,
        .rsvd = 0x00f00303,
     },
-- 
2.47.3


