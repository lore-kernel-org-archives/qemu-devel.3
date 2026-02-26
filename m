Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE45CFD8FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdiJ-0005JB-CL; Thu, 26 Feb 2026 10:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiH-0005IS-Ti
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:41 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiF-0003iz-Qj
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:41 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43990aa7dbaso807382f8f.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121338; x=1772726138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VBXg/2TNoBI9VaCBAUsRvO0hRVupsocR+41+B9vIhuc=;
 b=DjsKnYjohGn+aB0eQK5XXGQI1Cfha7pjOT5HbYojtmXwWCC3Opxz/fD7qhKDOm2h3y
 uuRw5x0vnsO/ZjudsH4KLCOYr9VVHZmq+pZaMqmX9EPo6ELmNBK8JmNMQjAjG9R+i1Ob
 jxvPQJUTb2zKV3Dkk1KLHwKqwVzTEIgLwiSjS1OFhzgp0PSHR3WO4LdL5J0lZh1kTQd/
 D+b30z6yPrXOeFB0RTgiJV7ctsYbGRJWnUZwvt5prch0IxKHYiE+qFeqyoKUu3lAs4qN
 go/asEP3bhTH5VChu0Caf7xBMxOv08yHzJ2JLb/H0D3ms9hX0eal7lomfRzSgdSwJV/X
 D9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121338; x=1772726138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VBXg/2TNoBI9VaCBAUsRvO0hRVupsocR+41+B9vIhuc=;
 b=DoBiCMrfQkyUpJ8lbm1kYMW3V99FH5QAxQDI8g4QXCPCctZVGz+yFRLd81K6us4lr/
 yj74n0weYqbV0TjRc+NJQU4muymNbNdRwieW3gF91jQKTQjQgBajTLy82boqdfZM5okj
 FdH4PixHAh5tW+0YDwaVv8NnU70nxg+J8IhQCCwhdr7JYAwWuq70AFCHc2zg2fAIMf4V
 4hqlbQQdrgBnri/fGGo2Sk83/p0e85Zipoa2zkWSjC4HSG+70BsOLIJ1PsotmWfrZi9E
 HuZgj5V0F3vIJYKR4p3e5NVPvuG3RvT3YjzC64pHaukUzsayqiemmYNedf15HKEOaNBB
 3LLw==
X-Gm-Message-State: AOJu0YzGxUQtLgSB31E1XTcXNnmU3C6l4DtnvxTGpwyAGUKJ/XfM9wEj
 uNH4XcUDZg9MMDmrMf2KLkr9R3y4Yd78gpc7PKmkEVDl0MFpAgrzcaSm1u1i4DetPw4X8mAoKlG
 GoaWi
X-Gm-Gg: ATEYQzwJfY88ZJh4P7UM7dWQBXPObHjLm8tbw+UnTm8a8x5tM8c/pxcVKWUSwjVKH69
 co/SUVgdTlF+ScTHWH/GrcU6LuarlWNhnOA/rb41lsL8z7MX8zIHPolDkLsYWgaWVWqxv17SbMF
 tIYk7W6PIWLQRMhVbtY1U3+CQtqtaKPLedc37kWEKmaTYaKgvwnNnjtPcJxXtvCdUQEdAob7ZHc
 hTIyhMuABVowMDqi/JQB+yIDqRZHGF95YfJP0MzNNRYYdts6yuUEbmgqUanWl5woTWancjMPBTg
 Zn+JFSoPWBByWSp171nk4IKLFQTJGKY4FrW29AJJ6iRZkXKAU7rtuXMmSvn+Cl8D3TBkT287yzD
 WmbarwuB25WE9NBPQ3XXn2i3OSCqHjyRwvVzfhXOYE7fGw4ACjDb3JuK6Kq0oveDCJbAAqThAHX
 9rthKZ2Hv6IB6ZIrL++OJ0buW3HXRFqARBWfpQTPlX1520lhEELOZw1/OL+NiZqI8rbbKTdybkC
 MjBMUgryWxJNz9cQ9ByRqe7j6/5AJ0=
X-Received: by 2002:a05:6000:438a:b0:436:1989:a1ba with SMTP id
 ffacd0b85a97d-43994294f6dmr9329748f8f.10.1772121337782; 
 Thu, 26 Feb 2026 07:55:37 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/20] hw/ssi/xilinx_spips: Reset TX FIFO in reset
Date: Thu, 26 Feb 2026 15:55:16 +0000
Message-ID: <20260226155535.1171290-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Weixie Cui <cuiweixie@gmail.com>

In xilinx_spips_reset() and xlnx_zynqmp_qspips_reset() a cut and
paste error meant we reset the RX FIFO twice and the TX FIFO not at
all.  Correct this to reset both FIFOs.

Cc: qemu-stable@nongnu.org
Signed-off-by: Weixie Cui <cuiweixie@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260223095905.67709-1-cuiweixie@gmail.com
[Rewrote commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index a4718fb72d..f6e717bc01 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -369,7 +369,7 @@ static void xilinx_spips_reset(DeviceState *d)
     memset(s->regs, 0, sizeof(s->regs));
 
     fifo8_reset(&s->rx_fifo);
-    fifo8_reset(&s->rx_fifo);
+    fifo8_reset(&s->tx_fifo);
     /* non zero resets */
     s->regs[R_CONFIG] |= MODEFAIL_GEN_EN;
     s->regs[R_SLAVE_IDLE_COUNT] = 0xFF;
@@ -397,7 +397,7 @@ static void xlnx_zynqmp_qspips_reset(DeviceState *d)
     memset(s->regs, 0, sizeof(s->regs));
 
     fifo8_reset(&s->rx_fifo_g);
-    fifo8_reset(&s->rx_fifo_g);
+    fifo8_reset(&s->tx_fifo_g);
     fifo32_reset(&s->fifo_g);
     s->regs[R_INTR_STATUS] = R_INTR_STATUS_RESET;
     s->regs[R_GPIO] = 1;
-- 
2.43.0


