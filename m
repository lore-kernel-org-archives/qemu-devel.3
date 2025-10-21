Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86753CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJIV-0002Fo-Sn; Tue, 21 Oct 2025 16:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJII-00023y-DV
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:24 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIB-0001EH-Rp
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:21 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso5888811f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079753; x=1761684553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9eb7afNyuJzQGK0xtJs1N7yRKtZt0dzwealgk3XAOio=;
 b=bgGZ3cGlliRuh9YeeqyA8HHNFgz1D5bIeoX7Q+LAMVZMdU8ZEkPAZ/S0WsQFd8owW1
 t0ZCvgOcZpkTKHNF5p81h27eZqw/gGKuE2nEGM0Dz1C5aBUJSmbVwotyUiapoYuM4jSj
 d17vAse3sTh3BUSJCREhF98kPDAaaD+dEw7jP/hwNHCpMe0ULUYoD3TXry8gJyWZb0Il
 3ilbWho/SUBDd/NMLPIpTAIVl8IsC5jTiC8Mi2pGkiZ1DHxT3xw8PcJlW0MfqWMEkokl
 b07OkveZR71wmATBEOY+j33sdr33L9GkB6Q7FqKQU8zDdo2cfr5fx/X1VxRHZCF+SG+o
 q0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079753; x=1761684553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eb7afNyuJzQGK0xtJs1N7yRKtZt0dzwealgk3XAOio=;
 b=erxFJGEkPoaV1ma/U7vDYvxHeSRrTbJMoLntjnh3BUXJ/sIge/X+m+YnHAwx9yCr0n
 Ms02lNTmGlxsP6xrnadyKJzpF00gNML0H4Nkk4QDjYVE5vivvX5u1RFWiXDYs8IkIZag
 go2sysdMq8bgKr8xo5y9R4ztYbYxZ5uyQe3BzEs1UA4OM3SU8/CdUVZJaVNGR1E4VkP6
 oS/NW6aSG1s3V1GDDiTV3qd0SkCwvEdImRldF00/g3UNBWay5k4KBS12AQvcK99Uh7sc
 nIG51aM8p4uYCYGbMtJtwM0KV09+sbEP1G/VKSBpc2MMNVprHM8kHz+lK4YtLZ0HyBMb
 DCCQ==
X-Gm-Message-State: AOJu0YyS9ETI2O2y/IRM5PaluZhMn9UAzFwxg9WYamMUnQsgW0b+V8PP
 6UVKr3esDNJmvd4fo4qZnOcUBe+JT7b/4iPWssMQ6Es+ic+FpjbpF19579zvP9gLyjYnRYj8VLP
 ILMizhMQ=
X-Gm-Gg: ASbGnctWSplD9RE0N5PqD/nCGjha5+JPBZtVdZkdvWItzLqtxfvX6NN0qWSzNpDjvYZ
 XFVsZri2o1a/vtrY6ZbO50mfwm78s0IPCkQB87z7fHTDyR1Ry/TNAvHTKKpWibn5rc9j1YAE7NA
 04RcYg2anl87PHF6JqO2CkCCcvB24CZIi6uq0sLx8W2s6ChvCuvYby4rJf8mzEJlyHPgomIllG9
 x2O/hOdrl6KxKU80PL5i1Wc6jVCtQthYVTHodYB2+6wAKp6SSfizhrsrK8VKG4h524qBToIwVB3
 NW5Qbn9M2gXjSNEvZjJa70CCFuy6bAI7AueoalZplkYAgxByr4Pww3IAXESOQPPiVYZwi1X4uIF
 QtKt3m0jW4BrEizlDZhBDxVNZHcZKvC4kHAG2yCD0w1mBZVGelBO+qiUs/anTVAfhM4/ltyH1mU
 E791uSAKwCt2a2IjDLQWVnozo4wB7mjWeSdEm80/wvvxZsAgLSH2dhH7lkic4h
X-Google-Smtp-Source: AGHT+IEiiD4CNRQnboBszha4q4uTBLq3eAYVL6NNdSaZgvKx9W9eUGT3SnGpxoDtEs0kRv6s0HRr5Q==
X-Received: by 2002:a5d:64c3:0:b0:427:8fe:4359 with SMTP id
 ffacd0b85a97d-42708fe44f3mr11680360f8f.27.1761079752808; 
 Tue, 21 Oct 2025 13:49:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427c3casm9707885e9.4.2025.10.21.13.49.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:49:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/45] hw/rtc/mc146818rtc: Assert correct usage of
 mc146818rtc_set_cmos_data()
Date: Tue, 21 Oct 2025 22:46:42 +0200
Message-ID: <20251021204700.56072-29-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The offset is never controlled by the guest, so any misuse constitutes a
programming error and shouldn't be silently ignored. Fix this by using assert().

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251019210303.104718-6-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/rtc/mc146818rtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 5a89062b4c5..8631386b9f0 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -726,9 +726,8 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
 
 void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val)
 {
-    if (addr >= 0 && addr < ARRAY_SIZE(s->cmos_data)) {
-        s->cmos_data[addr] = val;
-    }
+    assert(addr >= 0 && addr < ARRAY_SIZE(s->cmos_data));
+    s->cmos_data[addr] = val;
 }
 
 int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr)
-- 
2.51.0


