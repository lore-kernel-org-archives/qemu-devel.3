Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A53BC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7tf-0005e7-0i; Wed, 12 Aug 2026 08:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tH-0005JD-Hi
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:07 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tF-00009f-O6
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:03 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso9467465e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537020; x=1787141820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DrJmT+G7mTqQA3ZMgApM+c+RAZwLbfyz9fx1PjswSaM=;
 b=w3GEWQF8ogpwtEuo1yzMQrSpjg+WuX6R4oQm6f6N8CvnkxML8ySViThLCAY+QpEnnO
 dLwDdZt3Q4xYGRrrfKd4UTsV+hLGvXZfLN7wuz1h65hNaaz2f1HuUw6qVlldWAIvTgdO
 pTbUkK7iqL5YYazeMLlpQ6rPJB3QRfh6xfGK5JquZQVba88t1cNk0pm/Hqd1NbN35SPT
 5P0YwHEUiPJIsEMbalma02HzX1xDXOZFD67kkjztBzkdtffpr1TZrwEbo/7KxrZj65Xp
 xlw8OO8+b+txukhuyk5LCPVBwRTV4eBAI6uohvkdG4phMyWQtKJNCGnt8X5BvpZOX8Hu
 U6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537020; x=1787141820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DrJmT+G7mTqQA3ZMgApM+c+RAZwLbfyz9fx1PjswSaM=;
 b=gklHlTk0e2Dj240RXSZvGoE3bD4rYx3M1Rk1x3MJcYVkiC2zgne+5v0nPkYLBktBvz
 M+fgScjeaJwv6ZWPKWFiKxjPfjpWogSAJx1rJ3grwV9UDNv2h3ZWTr/OdSPKPgJ2g97e
 WEsHRmqz+xaybPKklqmS4InrsmomwHGHrq4GsfGq8hYJCXLyIIXOaVAqkNz7XyYH7/8e
 Z0Z61njJp9w16MTZ+ihcZQvUdAoxyRdp4xdzZkWuhwY8QGbqunqWRYt2zTXxxXX9bwd7
 /Ju0NSvP6/4hz4Hm20e+vbT19FXWJwgJpHGc+Stpb61ggzILZ7h9i1l2aFr2qo7h3LJI
 uljg==
X-Gm-Message-State: AOJu0YyfZ8qdIJBGzfADFWRds1vcCfvfdRWGp6BtUP2RIq/6LGj9/Ii/
 /jR/iANiZgNwz8t3VFBxeJxGWFTtc0e0DuTqTcD7i5z08kTvdyqbjL+2CGo0WKRstVrK5bPvLWv
 2LTQY
X-Gm-Gg: AR+sD13fDiA57dXpD/agsTAFX8iBiTwQbo5fwRvIU7Ah/CpnYhgNid5qdoWhRk8UnaU
 5rPW93giy9OOfPgKekVRYXUMI+VTK2GoIZmfpLYVfVhtKEE5FVRCZMJBPAtRDIUehW1iuOz+GDi
 d0rvkCjsPES18crRqDCnkL0keVI18fFVaYPMmUWoP+S0ZrNys3PtD2HoLaMnhh0GE9ywcAAdx/u
 tpM4ceBe81cw0wPJdjJzpX3Nvrvica7ybOHDzWg6Os3xIQ3ND6V0z8vlblxBa4qMxY3gteq0GZd
 o/SHDBLdXYl9OHYIaFyYepFv7DHnqGS+8G34BNAD97j4fzGv1Bjp4Y3wNc5FQjzQpPeLbKdMjAL
 x9YJdLzNIthsqqq9O6DzBLm+ae5lfaydLAKapHy40yOZPcZ8VoFAZ3EsdBnNr7OAK4M0AmnqA+R
 qanYq1SE0xTw5oyrZ8uYZid9g9Ta7N6dnJWbIhO05a0QeKp8zrU9+0qnajccge50StR1DjF2wbI
 QyLNbSxv8adtp02R7mlTLj7HzskARcXqNnkRbMz0l2CczQsxx737qN/2D5uxGGDYD7YoQ==
X-Received: by 2002:a05:600c:3551:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-4997c0fe5ccmr48138355e9.11.1786537020241; 
 Wed, 12 Aug 2026 05:17:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/26] hw/arm/mps2-tz.c: fix AN547 APB PPC EXP0 MPC ports
Date: Wed, 12 Aug 2026 13:16:17 +0100
Message-ID: <20260812121622.649730-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Simon Xu <simonxhy0404@gmail.com>

The AN547 TRM defines them to be on ports [15:13], not [2:0].

AN547 TRM: https://developer.arm.com/documentation/dai0547/latest/

Fixes: eb09d533d87f ("hw/arm/mps2-tz: Add new mps3-an547 board")
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Message-id: 20260805191257.11303-4-simonxhy0404@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2-tz.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index f101c1b7c3..81e64a91de 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1048,6 +1048,19 @@ static void mps2tz_common_init(MachineState *machine)
     const PPCInfo an547_ppcs[] = { {
             .name = "apb_ppcexp0",
             .ports = {
+                { /* port 0 USER MEM APB0 */ },
+                { /* port 1 USER MEM APB0 */ },
+                { /* port 2 reserved */ },
+                { /* port 3 reserved */ },
+                { /* port 4 NPU APB0 */ },
+                { /* port 5 NPU APB1 */ },
+                { /* port 6 reserved */ },
+                { /* port 7 reserved */ },
+                { /* port 8 reserved */ },
+                { /* port 9 reserved */ },
+                { /* port 10 reserved */ },
+                { /* port 11 reserved */ },
+                { /* port 12 reserved */ },
                 { "ssram-mpc", make_mpc, &mms->mpc[0], 0x57000000, 0x1000 },
                 { "qspi-mpc", make_mpc, &mms->mpc[1], 0x57001000, 0x1000 },
                 { "ddr-mpc", make_mpc, &mms->mpc[2], 0x57002000, 0x1000 },
-- 
2.43.0


