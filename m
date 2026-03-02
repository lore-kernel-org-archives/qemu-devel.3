Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CCEEB363C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 22:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxBME-0000Pe-83; Mon, 02 Mar 2026 17:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBMB-0000O0-FN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:15 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBMA-00018w-1f
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:15 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439b7c2788dso963140f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 14:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772488992; x=1773093792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONRooDxE+SOFwVUb1D4HBBaOVoswy7bX7wry9VAuImw=;
 b=dWTL6MSgzB94pgB6s1IrxdjIh3jPjmkvjsKS3dOoI0xG2RSn6tDMD1gVWNlVwxNDiq
 mMrb5m+bKJ2BYOgnEbRVmcyEnWpmT9a9rplB2Q/+528zcSC2npOjbKO9Ch7u0L69+DxH
 2ksUVSgJqZyyjD5uqPrpZxwA6VxwxV67gN2aqz+Kki0i9+X8Udh7i12Ho4clFIj0Y4xM
 ibIhXkXf1EBoOgu7rHQRcqRvqCU7TVaDjkMIFB7McwX1Kut/5HSIZOc2eXDnlcP2j843
 m13Kbs8ou7TGpc7QBsDuXC8KuqPZGZRPp3O9lIA21oVipMals+BwC6WCQP0yOpdtAGUQ
 B6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772488992; x=1773093792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ONRooDxE+SOFwVUb1D4HBBaOVoswy7bX7wry9VAuImw=;
 b=sJFJ06cwrHsc6r5QCeukXGsxsJjflxhuA9JdQcjeRQtVaNHfPpS2j11OaEz+qog8w7
 /N2VQkCSDQK8AjEROCIlF74R2q9zyCQGN6aDDiaS5Dl1c1V477tGqgYovYnF2ttYdiXt
 Iv416p7bQjPJWlwO4ym/Cr2p30fbeniPoNrsyzcCqY+vaXL7Euh0ZLD4+Z7scrkhoAyq
 HDGhPNwcjxCALQvtbXIe4oDK2SH8Gk+lJCGkQ2z3hCFiCMHPHHZyXMz+7/vhrRs/9L+E
 Vzd5b9wOyUt9XlTX2df2d26ewhJbGdVPJVF19bABrM3Xt+BqzYgJTMu8HlGoku2aw/nm
 Z7MA==
X-Gm-Message-State: AOJu0Yywyg93TMfG9WpGj47Gp1sui4Kq+fuu1aWfIpUF0GjZAckfWpFw
 JMoU9ameq0k34XUT7iqDFpAYJyn5sV+8JqP+VsWzLtM9tIwodyr7EBWJdpzolQ==
X-Gm-Gg: ATEYQzygu2o1xkfBA1e182+D7BfnrTno+3gsdWrDjFJvodTXazb4Zbhfo+El1h114tp
 HO5TuQK52yvF9uIsr9hTWRZQnzbQbw20UIycqEp32uVYQvUzyfAttPjTb4+XRKAQsFfjNddySBu
 R+UkB5gQ1ylp5aGSO6IhxjmR2m08WFL+jH3uXAzcM6aUVaIxroZAk6O56uUDan+n7yM6WlG5iNa
 KRYMBXrgssnJp4h/kHP93Ns4aF2zw/OhMvs9H2UqsJn2rGhT1YtTYoN2Zfmt3XvzQsDf9/n1RZs
 zLBJoFO9hlUr4UQ8M0XCcZAmFwVr2wBH28svvXebupWHKVuFJKInDvcw3ucP4pTrjVS7dAoRe3H
 9sZbZv3AfhpTq3ei4G97L9qt7Vkq9GSi0cseUM9qgvPvk28ZhcFLzediHFJIpFQXVHLH23ghaZi
 NUVKWIg2zGw2vY1Sbs2UqDHY83TyV+LIAnugVnX8PTZHLxIm5Zgnor6vIEUYGpxHIHCI447WaE0
 I7D3k/FB3fAoiE0Fefisd3fTgcifyAXxtFcdt/ydQ9ehRY=
X-Received: by 2002:a5d:5d0d:0:b0:437:771b:26b with SMTP id
 ffacd0b85a97d-4399ddfc43cmr25415996f8f.26.1772488991958; 
 Mon, 02 Mar 2026 14:03:11 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2e0b-4800-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2e0b:4800:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c38sm29308102f8f.31.2026.03.02.14.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:03:11 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 07/12] hw/char/serial: Remove redundant reset
Date: Mon,  2 Mar 2026 23:02:49 +0100
Message-ID: <20260302220254.1166849-8-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302220254.1166849-1-shentey@gmail.com>
References: <20260302220254.1166849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

There is no need to invoke the reset method in realize since the reset
framework will do so anyway before the machine starts.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/char/serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 485b98f03f..0f3469a1e8 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -934,7 +934,6 @@ static void serial_realize(DeviceState *dev, Error **errp)
                              serial_event, serial_be_change, s, NULL, true);
     fifo8_create(&s->recv_fifo, UART_FIFO_LENGTH);
     fifo8_create(&s->xmit_fifo, UART_FIFO_LENGTH);
-    serial_reset(s);
 }
 
 static void serial_unrealize(DeviceState *dev)
-- 
2.53.0


