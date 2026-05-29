Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65605CD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgf-0001WK-DW; Fri, 29 May 2026 07:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgc-0001T6-IX
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvga-0008Bd-Vq
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:34 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45ef1198766so372583f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055251; x=1780660051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yBoybGBcc78BXT1jv7MjxVZXXQcfqmhfBr2N9SAmleU=;
 b=dpaiH6xv289iCAXqye7jsWhbs2rKZmlAwdMnvislG0QMz9eD8FohDQ7zxA0FPIFGCg
 q2d82QAmGLSOCd+c7ouOE0rXIvN4GTzFcziux5Q5v+WdhZpYUBf0nR9WrsSIgdoJdn63
 zcH8APZHZSKHZ3XDNUtROwyLEBtbmLQBAAGZsZmobwPZ7S4BnEWZS3xzjgdiYJ7c9OFu
 UjTa1a4yerC8mBlHvrprCMjvdZw3VKXaqzsmEFHK/U4F0da/fFIfhGO7Ht2hlWEiMNUp
 Ezc/oANqvZZkdtuiOV2Ekm+Eyo1/f9h9PP2mNCqs4UBCC7WOBjqP5vDUYwmFExTkq05o
 340g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055251; x=1780660051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yBoybGBcc78BXT1jv7MjxVZXXQcfqmhfBr2N9SAmleU=;
 b=Radv0S8oo3v3t8mOJW5L+XGoupjCYirOFZfgsNWX0yZq2JBGIVZPQT+N0LvFXDiAfe
 98e/TY8uDYwpew/EvV00sZ7BbpTyeN6YWAVCEuYwNiFFI65+29eGlP3Kj/QRPqp7w7km
 8kwGUc4fXRHEWTOiAL1mPsHOr6gwEbhP52lAz8l1oRl68E+L2Ui1n8pjCTOg4F+8W3je
 aDKptXT9qwbztDc2vDPyM3/J+4a/02gIWYOOMnt1UByIE4pu2KJDwoEnryhHUuC2slU/
 kPyfyYXjHfMVV+UU3W0yO1Qj+FSsHi5a1szY4bE+mbpMqHzjqkBu1rmylJc+WsaXifeV
 pzTg==
X-Gm-Message-State: AOJu0Yy1BTTqUl2TWiX0A279puVcdyQSMpiZ0YZgcpOgBcfpNyecUSFl
 hmLZJpUFBYJoGIWJYJVgWk32aYMUPoAT6gW9qfVdktGi6gYeSLHpDVTbbcx/koOWmyBaraFfHEn
 HJ6hF
X-Gm-Gg: Acq92OFr8aGJO5bbiKPkuj2MNTG6lKl2PMqWhTAsLP6KSYRCHVbzUwjKT5rsVawNlYO
 aU/9QKRH3/nPxWr7aoNOnhV23MJ7sDgyNgIGhX3A6djM0lHmavFSQfEhjhNvEhGVKuOI1kjNmPa
 ppMlpcEmLOZiWGcxK1xuJtMtrqBhlv4KcGzO1byJ1TDAPYk32fssXWd/PeANctR2L35ZxOQ3IRG
 40O36EJM6BRRw0kQAbz4FtlRtBAbWoLGui0lcfFKL9/sKo/vnOHdPhpwX+bKZ9tjG6XkNsX8Scx
 0dJeU7AGhoVy+dk2tS8edszpSyJ5q0VF+HBIs8wfpnd1wyo4ulBUCjfgyeqACH4sBGAA7InO8Lv
 VcjDx97V/iKFyfT9hNOlV/x50nlRYXBCGMvx3XI8v33+u1UDfUABgrbeXIr4DxnB9p5ztrOxLlQ
 5psl0WRQJYdaZr16kLdWpub+3tmSFRd6im5NpoGvFyTa4Pauylqi7mrZl3yW/id7+tf7zKD2jJk
 ckxNVDH+yKNQ5yHBAjaqRwnc7YXunnv6rxfoL0ZHg==
X-Received: by 2002:a05:6000:4b1a:b0:455:564e:3a28 with SMTP id
 ffacd0b85a97d-45ef137a0bamr3820249f8f.17.1780055251304; 
 Fri, 29 May 2026 04:47:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/21] hw/dma/zynq-devcfg: Indicate power-up status of PL
Date: Fri, 29 May 2026 12:47:07 +0100
Message-ID: <20260529114723.42040-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
Message-id: 20260518073401.11279-6-corvin.koehne@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


