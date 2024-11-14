Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943E4D6A22F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgxK-0008VM-5P; Thu, 14 Nov 2024 16:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgxD-0008SH-1L
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:00:39 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgxB-0007wQ-8U
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:00:38 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d495d217bso862914f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618031; x=1732222831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YlgtA2w+nkGpq6odlZPv7GuJkitbYlthMfvxp2Wzgbg=;
 b=zvaJYErv6yAaQHqckRPX1UP5Y7IdpEwqrsrbq9Ey+Obw9tvf5QuP6V1o0wki/qJCOZ
 rECy69YCd83DvWK1eq7Aq4Ebmi8dfD6zFi//piSW5QRY8+9DUNEwy8IXD8YGjbc+EYc1
 8JmDe7nXzNedO0WAEvaW6YC7skJ8BqmN7ovwdGuxPuY+mWPuiseDVs35BehWivGMX/MK
 0hbiwRchaqZU8rh/pXqG9oFOWVIm64zocaaoz0r5l8EfNMh2SqSir5+WmHvcaktxO4Fx
 oCHGOP3fPQA61yMJ3urKnnNA1EXBnTFWDJAkYa01TG3hXcFqZ8q/4brCWzOYdYjpO9/6
 37DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618031; x=1732222831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YlgtA2w+nkGpq6odlZPv7GuJkitbYlthMfvxp2Wzgbg=;
 b=VHk2sXVF5Mv8bSfIH2Ujn5b68ynj+g51xY9VciADbS7h0N0cBNK2BTk0FE09BxLfNL
 qiyefAJdylz5IYRPQF6xyEzeRWVWI/GvDON1e3u3eRBmVrLSoUJ/cBGkvJg/5Ij/lB2H
 5F3KkbJD4XwXMtSeQ3FD7kh/Kk3wGHvuWWaY2LOV6QMCSk4LML/lZDui5xvV5K11xxAb
 jUI4Jbqib3PtPYwOfKOae4P0YKOCR8deHLJPdxQwx+EnBpl2ryvt8rF3VB+3IPmngU7R
 r1h6SGlTLPlsXUd5v9UmIOTldATDb4RsyeLd+804L47C/hGa/HGpMMvDFrOaWVDDyB9i
 2i3g==
X-Gm-Message-State: AOJu0YxaD32yk7ZQENo3K3ljfCPodXwMhTcNzuFRcfSrzi+dwDAJ0JX5
 zBmqbA8anJMvaNHfmaXcmUERwn2eeEsSPoit5fAFhScXUS0N6NRK3ty2Ftli0bX6RDGtgOYPrww
 s
X-Google-Smtp-Source: AGHT+IG+cYORDoo3vfMplmaZEPJ4MN2+phvbhsgf7WY8+JyJF09aAiQdcETeGtdafok/5l8YkxevZQ==
X-Received: by 2002:a5d:5e02:0:b0:381:f603:ff62 with SMTP id
 ffacd0b85a97d-38225a454ddmr179821f8f.20.1731618030678; 
 Thu, 14 Nov 2024 13:00:30 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae16827sm2464974f8f.76.2024.11.14.13.00.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:00:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH RESEND v2 02/19] hw/net/xilinx_ethlite: Convert some debug
 logs to trace events
Date: Thu, 14 Nov 2024 21:59:53 +0100
Message-ID: <20241114210010.34502-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114210010.34502-1-philmd@linaro.org>
References: <20241114210010.34502-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/net/xilinx_ethlite.c | 5 +++--
 hw/net/trace-events     | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index e84b4cdd35..bb330a233f 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -30,6 +30,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "net/net.h"
+#include "trace.h"
 
 #define D(x)
 #define R_TX_BUF0     0
@@ -198,13 +199,13 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
         return size;
 
     if (s->regs[rxbase + R_RX_CTRL0] & CTRL_S) {
-        D(qemu_log("ethlite lost packet %x\n", s->regs[R_RX_CTRL0]));
+        trace_ethlite_pkt_lost(s->regs[R_RX_CTRL0]);
         return -1;
     }
 
     D(qemu_log("%s %zd rxbase=%x\n", __func__, size, rxbase));
     if (size > (R_MAX - R_RX_BUF0 - rxbase) * 4) {
-        D(qemu_log("ethlite packet is too big, size=%x\n", size));
+        trace_ethlite_pkt_size_too_big(size);
         return -1;
     }
     memcpy(&s->regs[rxbase + R_RX_BUF0], buf, size);
diff --git a/hw/net/trace-events b/hw/net/trace-events
index d0f1d8c0fb..2b36cd967e 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -511,3 +511,7 @@ xen_netdev_connect(int dev, unsigned int tx, unsigned int rx, int port) "vif%u t
 xen_netdev_frontend_changed(const char *dev, int state) "vif%s state %d"
 xen_netdev_tx(int dev, int ref, int off, int len, unsigned int flags, const char *c, const char *d, const char *m, const char *e) "vif%u ref %u off %u len %u flags 0x%x%s%s%s%s"
 xen_netdev_rx(int dev, int idx, int status, int flags) "vif%u idx %d status %d flags 0x%x"
+
+# xilinx_ethlite.c
+ethlite_pkt_lost(uint32_t rx_ctrl) "rx_ctrl:0x%" PRIx32
+ethlite_pkt_size_too_big(uint64_t size) "size:0x%" PRIx64
-- 
2.45.2


