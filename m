Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6294BE937EB
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxIH-0006Y2-Ib; Sun, 12 Apr 2026 12:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHx-0006Rb-Oq
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:04:02 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHp-0004Ve-7B
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:52 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-40f387a688dso2462253fac.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009824; x=1776614624;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3CPXyrU6scI+xTi1TnD3MNp9VsbfveDSzhlCE0CEV+o=;
 b=FUYlqw78fjA/h2z8UbzC5bySSYuRrg5fDYEpeWX8LMqdvdQBsGzXGOPM6l+5zSOifG
 E2L9p376dQuqcOY/HnnmCxj41hcEevB7yiz9zhoOEhRtwZRLoLgvPlbUoW1QUbmasszD
 vqdGDs6PKDihRCdHBPx/P6FL4YHifneXEXgYktU3TxlRRgEGgot1TO7xErvhsC5/V4CI
 zuIh2K/qomYWkjBlirWRYMMdJ+masDJTjIOBtEvQS63vo4SyL7p2iXqUlm2QyF+pP94S
 9v+yZJO6OdQTYOrxmC7NbUDdMTK5lQTuN493v7pgnBf8fTq0acXwQvfmWAksVSWV3TAD
 Dh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009824; x=1776614624;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3CPXyrU6scI+xTi1TnD3MNp9VsbfveDSzhlCE0CEV+o=;
 b=jtoIaOfiVL6DARcA2GH9RxzrPbSAcDYDKRamrAxih2ErUbm1z856CthMhDSLK88Qts
 0fUeDdLJD/CKq16s8Is1CseI51KkewQxJILucozY5QgsTg3z1UnUwWLcjxhiJ3tiodhw
 iBsZ03Hk3uuKhHrZJ763MagsEPkf0FoicsvVEg6ESL6JgJ03ZIs/S4P6vwd6VY04r72D
 SDAI55dlZdhOr3vY2maZV7PBNA0dgYPwW0d3WbvP+1kVCqeLCnyIi9tu7nwxlPAI9oh5
 aIo0NKAQuqs8Hqgx/kEsj4VE6K9In8b99mVuS2KqtsweId7tUwYg/dk76Je5/tiUJZU/
 vpuQ==
X-Gm-Message-State: AOJu0YzlyoVJ5kBQBzsef8pMtsKbP7yVnCDltfQH5cVq7R4aZZ73Uzs8
 4eMmZI3kkXsARynhKH1jSz9oUsJNYd0i/ZvTE6/UZ/ECKyr0jFeaiEmUe3FdujDzuRqxXLn8JHW
 hyRi4pvE=
X-Gm-Gg: AeBDiessngNgirhlZ6AlHg++7JnqNYOwW87zyDkHM/QbubiArAUtDRd3UBz26phvvrG
 G/OCw9X1jg9ujfXZd0lFVka1kA6OV6cZJPb7ah3wSUByphMarO+WqlDntiI8Z4xV6vKjJwex8KY
 d9Yw6sB87+rohtUdyRiMDq44sRUQ9eAQ8zUEQTi+0AS6TPG2vyUPuIWC15xm7kU3s0WaWV/XLfK
 i2HJOrGnetZBC5BtLkaLWGfoGe8TIwNzXfOGWaQYlFF3Axrjneznt5IWZvM2aXem1W52QQcMYkY
 oZ/nf8rFuiGg1QiFY4+pM9afpi7OXTNMFLizQvNhLQHjy9Lj2cFwjc8iepCE+FirDWFywH8d9PW
 b8i0lQ56nIIWu3Nynuj25oMxeOv5hCpRyKMEb/5chbSQWzt+gAeJAG5nzIX0Fapw6HTmFO8Ir2a
 U2Hp0x+E925g==
X-Received: by 2002:a05:6870:1b1a:b0:41b:f2ee:bfea with SMTP id
 586e51a60fabf-423e1162254mr5650894fac.41.1776009824292; 
 Sun, 12 Apr 2026 09:03:44 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:43 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:32 -0600
Subject: [PATCH 09/17] bsd-user: Add bsd-ioctl.h header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-9-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=yeGavK2BMRJ20mAsfFVakCqJnM3dMDajDrM0UbXfJQI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28IgZb4V++s7iQnDx5XKujCjFEjbbSFirgDFJ
 v7Zi4xCRSSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCIAAKCRBsHNEofbAR
 ACz2D/0fGBH304BWkbKEX+Cdg+x2Or+a8S3QtCrv/9T4tPR5UtrihXplOLQvHDttlEUhrGg8H/i
 ycjyjXQrXwLEDRZvadT7HZ2V37C5PGmi0Y9ZBcHXChtTh3d8TaJ+ZYsexLqh39zgRNsFjEAmcPi
 u39yZ1Mf05JuTc3mBMZ4UTmX/li2lkz4pYEnP8CB9/aGG1CtcwkhQEGMOPfsdJzL5KyExUGsrQe
 36yg1oJ2kwTJtCJdisX83pSwFPInME1ZPQAFUJOq6SmjYCS5+L0y4fKiQxCoTmlSS0J+6rhNexI
 RqFrnWlb0Y16f7cLGYL2aCJYBY74PE85wRg/G9cT9Ww/71FXxYe/7Z5AOUf9zg6BvlQso2G2Htp
 efVHGwYoomNTPpxbaKK1fKH+v5BEx7i4cKzFmwaThRXDnlcQf6X3g8VeUGkG10ShAjj15ILML/m
 gNdrcAmM209yqmWe1N3tfksyOEZL81xYc22qkvy5yiffI2wIuDK4g0CbuB/W/4ui5ICdF7ETrOp
 +UZfMbmSrunc/YniNkzP4JhbdJsRqNxb609uQ6OgtrKZoeptYHrEqd4K18dng+MGk0TpJT1Qyao
 kVtpYejnfd+BWSfNIk0yL0yzrP9GdGO4oFORmxMXMBj2jNnZd2RWbu4x2XkEONLOMU+m6a6xeeU
 CMiPxZuhE5Wwjmw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2d;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: "Stacey D. Son" <sson@freebsd.org>

Add bsd-ioctl.h header declaring the public ioctl emulation API:
do_bsd_ioctl() for processing ioctl system calls and init_bsd_ioctl()
for initialization.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/bsd-ioctl.h b/bsd-user/bsd-ioctl.h
new file mode 100644
index 0000000000..bf9bb72bc9
--- /dev/null
+++ b/bsd-user/bsd-ioctl.h
@@ -0,0 +1,14 @@
+/*
+ * ioctl system call definitions
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_IOCTL_H
+#define BSD_IOCTL_H
+
+abi_long do_bsd_ioctl(int fd, abi_long cmd, abi_long arg);
+void init_bsd_ioctl(void);
+
+#endif /* BSD_IOCTL_H */

-- 
2.52.0


