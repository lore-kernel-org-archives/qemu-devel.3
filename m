Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C86EA4FBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuW8O-0003Vi-J3; Mon, 23 Feb 2026 08:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cuiweixie@gmail.com>)
 id 1vuSih-0004L4-Na
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:59:15 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cuiweixie@gmail.com>)
 id 1vuSig-0008KO-CA
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:59:15 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c6e23cb81f4so1540490a12.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 01:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771840752; x=1772445552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uOCtjF/FyA9nxfNzpBGRvTULb6K9sciGgdZgP8WG6ss=;
 b=kNnONz0XrSZ6aEWEJQjAv38KCinslFrdtdH8ZRmQi9EzsuEra57LUvlhq3ADbBSf6h
 Y7x8hza/K1a/XAykAV0jzjwC+Bn9p90on5BAm2EE9PJD/llBZMrJijihUnNwOR9xP//X
 NPSfOhcdQsnDLIEEH9Dp80dJuPp8KmTTPSiQTXLvoxuM9Zu7RHwT6eA6c0g/H53qWvjG
 2tlWvG/UAcaMgEG66wJsclVtoaUueZ155c3fnIQEguIXWaIrVI5vEZexL5c7Gxpgyxe5
 d1Dp+pealvH9ICjKHgWKm/3+9woCoCQ40wHPdvFODt27zjJdyZvu/aRbxT/qF7a9quT1
 dhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771840752; x=1772445552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOCtjF/FyA9nxfNzpBGRvTULb6K9sciGgdZgP8WG6ss=;
 b=lZwT7tEnECugx1Hu38eKF4amjGFqMjsO+JxEtL7t0OBzfluk0tcV0He9AXRvOUuJ3a
 We/o8Bcr8OuxY1CHIfKEQx/hL8i4OJ9wwL0Vt195nRmNm9Y2d5p0HlkQFz5vgRlVrDBT
 WMLKb7j8CvuG51DtPtQ5TOh1WbKnIVlIfmXwQoc/lpy86txuMnCqqPjjnl6fVBkKagwZ
 yraPuplAAU7r+o2qnEkKm5UhY+VUlYN8sV4tCSsNdeBuvZTJ53cCUaAWc2vjN97bckuq
 BG5Ju7U1emTe3r6TJBZpPpH1YUtM1J9xIYd4XUqFe+gNnG3Zx/9SVy3X/d9q9VuZRm2D
 2tIg==
X-Gm-Message-State: AOJu0YwZVThr7FuUdD55mkWFfNX7mtwp4ScEGuW+dln6PT52fPd7fCSz
 VsRHI0MtFyWrgrIZX7t46vAy8DoesfMO6QwLdoNUm2sZkaBQuU1gy/A6eCG9SZIaZxw=
X-Gm-Gg: ATEYQzyOVudJOEuVDBMIwD/fVK/BL+SMqGOjCBg5vJrDHSm/lfxOP+WczbbnBGjwWUB
 T2DKW/TrqSAMblK3Vu4NO0zEyld5hMfM0969U9MI56RM+3BcfC0tsC/L76zMCLP6VjntzT536kQ
 68Z6ERcup4XcOi3ohV+ZBIY2ob171tCucFNSd8d8GsuQdfhdKksTl/S/McBcoHeHcmwWFWB6wJ3
 lBxltzqSSX5mypQfYGvBEUV/MYvzm/F1OUKNHyN/iaH+hJuKyLN5kOGaB+6Or1ANkPEYTZflutT
 b04h1JSgPdix7IaZVmojJxW4E69gVG9e9/yodJRBlg4TKwqYLiK+cc6Tn3F5zMth12axrP29oww
 cJN8gXyFBkWqasnx1L5dN0B14GkSukh9efDJEmYO7EDsipjjYva6jEkd2xJdZqJ+zT8srWiV12S
 mspdt5onOB/WkNMIrK3ehWhYXZJ3XIT87cyfXP
X-Received: by 2002:a17:903:3b84:b0:2aa:e817:1bd4 with SMTP id
 d9443c01a7336-2ad7453c0f6mr77388125ad.37.1771840751925; 
 Mon, 23 Feb 2026 01:59:11 -0800 (PST)
Received: from 192.168.2.102 ([120.235.196.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74f5d2c1sm65262465ad.20.2026.02.23.01.59.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Feb 2026 01:59:11 -0800 (PST)
From: Weixie Cui <cuiweixie@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weixie Cui <cuiweixie@gmail.com>
Subject: [PATCH] hw: copy paste bug
Date: Mon, 23 Feb 2026 17:59:05 +0800
Message-Id: <20260223095905.67709-1-cuiweixie@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=cuiweixie@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:37:50 -0500
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

Signed-off-by: Weixie Cui <cuiweixie@gmail.com>
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
2.39.5 (Apple Git-154)


