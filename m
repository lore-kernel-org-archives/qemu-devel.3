Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72000C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 01:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbsJa-0005Us-55; Sun, 18 Feb 2024 20:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIj-0003bd-Tw; Sun, 18 Feb 2024 20:18:34 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIh-0004MA-5c; Sun, 18 Feb 2024 20:18:32 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-607a84acf6aso15163117b3.2; 
 Sun, 18 Feb 2024 17:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708305509; x=1708910309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v1gR/KAa53/oE2iH7GhO3G8Sk5ViFxF2SsXmdhHxpKI=;
 b=NU9YpyK3tfgX2zqgtbJwGxfU/dB2PvzuvwE1m3aIWboU4lQB2jtt0eExpCF0PLLvkQ
 CTMG6G9CKjfDe5LS/83p+ptoV9EKerGmtC+yGluAqIpl6I90pk0EuE7x931tp5mQmJGu
 bGnUKATnCP+8F7IENIOMchuFMo1zZpi6wXgqiPfNl8SHeUoZ64dEC82dNN2nvccb78qd
 YAMX/m3g4RLqh7RXrcNRRt0DzzjiV+sa+5v3oqXJFMNRa389M1yNEtm4r+UQjzAean4x
 +MLOi2/z2eGEJjS+dUjvn14JVOfHkvzq/V9omiQXP/0rV6U51TEsB/6OHtT4QWivSuVJ
 WI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708305509; x=1708910309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v1gR/KAa53/oE2iH7GhO3G8Sk5ViFxF2SsXmdhHxpKI=;
 b=IoaNCkLWuZgiQkKhidEWeM96CkVKzgeBT8w8nhpvQmAu/27Y3eVRmcS14nIkORgHdT
 BY9baredxgqYIDScsr14yCkwsvfqKffZwTPruX4O18QXnIpuIx/hW+dFPJfB5BszZ4D+
 IZAJ6sWTbI8LnNkO3R1fvME+xvIHaFsHqHezmuaiDJi5L/dWt0ys2NQ4fnAum1om8tQr
 zSw+FRUKflHnkhv4nc5/6gwyW5WKvJV4qvsBthg4RBU6+YfZ/rkA1hz2Zu4n2LCl9DPL
 8fryxhY/u2lqNRxbKjEHakzorK2sqvzm9aFciJBtfNtsO+Y+xdeG1mNNXrmO4Xg5NGnx
 3mNQ==
X-Gm-Message-State: AOJu0YxEUvNK6lnIQiQEk7TLYw0TTIhTuTq9CWzmF6boQPB8PJuyhc4i
 fCflzdpVVzZOg5cQjRsjyQuSwQ9zcBr584qj2EnQ69AQGLOoRyiANJEWZEFHOgk=
X-Google-Smtp-Source: AGHT+IE9HW5BVHh0c8TUwgNZ7Q1Etp6GBtU33LTRVXwS53DWi4TMHY3DNjYkgqoI6b/yzQujz+GklA==
X-Received: by 2002:a81:ac4a:0:b0:607:fe2f:34af with SMTP id
 z10-20020a81ac4a000000b00607fe2f34afmr4563996ywj.2.1708305509574; 
 Sun, 18 Feb 2024 17:18:29 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a819e0c000000b00607ff905ed3sm1204704ywj.58.2024.02.18.17.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 17:18:29 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v5 41/41] Add RPi4B to paspi.rst
Date: Sun, 18 Feb 2024 19:17:39 -0600
Message-Id: <20240219011739.2316619-42-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 docs/system/arm/raspi.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index d0a6f08b2b..c21b27744e 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -1,5 +1,5 @@
-Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``)
-======================================================================================
+Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``, ``raspi4b-2g``)
+======================================================================================================
 
 
 QEMU provides models of the following Raspberry Pi boards:
@@ -12,12 +12,13 @@ QEMU provides models of the following Raspberry Pi boards:
   Cortex-A53 (4 cores), 512 MiB of RAM
 ``raspi3b``
   Cortex-A53 (4 cores), 1 GiB of RAM
-
+``raspi4b-2g``
+  Cortex-A72 (4 cores), 2 GiB of RAM
 
 Implemented devices
 -------------------
 
- * ARM1176JZF-S, Cortex-A7 or Cortex-A53 CPU
+ * ARM1176JZF-S, Cortex-A7, Cortex-A53 or Cortex-A72 CPU
  * Interrupt controller
  * DMA controller
  * Clock and reset controller (CPRMAN)
@@ -34,6 +35,8 @@ Implemented devices
  * MailBox controller (MBOX)
  * VideoCore firmware (property)
  * Peripheral SPI controller (SPI)
+ * PCIE Root Port (raspi4b-2g)
+ * GENET Ethernet Controller (raspi4b-2g)
 
 
 Missing devices
-- 
2.34.1


