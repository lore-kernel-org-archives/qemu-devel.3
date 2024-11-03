Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F775D11043
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7alL-0006ne-2r; Sun, 03 Nov 2024 08:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7alD-0006eN-Fu; Sun, 03 Nov 2024 08:35:19 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7alC-0001Xq-1g; Sun, 03 Nov 2024 08:35:19 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1ecbso4212633a12.0; 
 Sun, 03 Nov 2024 05:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640915; x=1731245715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVflLGHPyO3cQe2iVaao8/FC1//CU9ki9Sx4TSq7Uus=;
 b=WTGYvfydV8J+ZtL8tJtVG/AGXpLFNab0Gyo5GHJCHmYzto0vCz/8/DyP/l5ZKgVGla
 erDPLPwOCbLxlutCntSoqEiT7rnEVvgcYWYcD4OFcn4XYwzotjD+bqxQHC/3BhNGjasL
 ikd54AO1dJWp2fwXJITd8Lmp+VXV8upjquU6XDf65Pa439y27KwX+Q96aikcW94VxGnw
 CgI29QA+ZmQByrhoqQksEsxhJzaiBOYlXVEprpALU6NOwfuOECHSQKhWwIYED1A2dmAc
 9bXyQL9+Vy4OlLTdeH14K0gU+/Z5mW27JxUShUNG+tZLQPWjp2hfFx08hINxaiBXvpVn
 NXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640915; x=1731245715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVflLGHPyO3cQe2iVaao8/FC1//CU9ki9Sx4TSq7Uus=;
 b=F0jyZqG7K2hoEnKoXAmI44o8ayRjiKmdZCwLAUfpsir0miDDOIbwB0OTXz3U0cI1tF
 UvR8rINAwpLlvx7hVj2vJI/p4np+s4aOT7pbsFfDGNeqOxs40Ydhm4GtqujzPQaidJHF
 WwtnUjnNOQylUdX+8fvxHCD2tq85N+9OT0hs1HD+c0PuvHk66TeJtlPaBb/AXYiSvPhT
 0f533Rj9OVhb/1v7KTqVVj8tlw5MDod5XUOfoKOie/J9/9s1A+N+qaM8/nWiCgwhNSmY
 PCPvKe1fOWPPgpm+9irzPd7WCdDA6XUtpnanI0hb6i8NKzOHedC2zP2f2TBXkP6gMfhs
 keJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYDVt6N/qASK+uuxW1EGVvRbMXexOJlJ2Jka/wldlvm5Pvhd6SgtFl46Z+YXGLfzGs/8dbC1OffZ4=@nongnu.org,
 AJvYcCWy9QM7jyhahbfJ1AgTv1sNKDHAfAH6a61PZpHmkfxG4vbq+uiEdiz0azQGmxKO3yCNUTi0UEa1oYBX@nongnu.org
X-Gm-Message-State: AOJu0Yz5jZYJSJDh/Qpu5kJHV1vTyV1tTUhfq4U1GuL4eD09Br3nXOce
 C+q8vjM59p1AT/tSryE9AjdzFUiJxmZ9L/RZNQloQWThPyUqPEmkZI5fPA==
X-Google-Smtp-Source: AGHT+IFSAMzYZp3iO2kUylRyZZ1WNNzMYdgRFsRmn01AOrdiyrwCTjRWWPYSZ647eiOxZXftkF4AwA==
X-Received: by 2002:a17:907:9604:b0:a99:f4be:7a6a with SMTP id
 a640c23a62f3a-a9de61ce626mr2663539666b.47.1730640915260; 
 Sun, 03 Nov 2024 05:35:15 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:35:14 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 25/26] hw/vfio/platform: Let vfio_start_eventfd_injection()
 take VFIOPlatformDevice pointer
Date: Sun,  3 Nov 2024 14:34:11 +0100
Message-ID: <20241103133412.73536-26-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Avoids one downcast, making the code more type-safe.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/vfio/platform.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index a85c199c76..77bbfbf62c 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -318,13 +318,12 @@ static void vfio_platform_eoi(VFIODevice *vbasedev)
 /**
  * vfio_start_eventfd_injection - starts the virtual IRQ injection using
  * user-side handled eventfds
- * @sbdev: the sysbus device handle
+ * @vdev: the VFIO platform device handle
  * @irq: the qemu irq handle
  */
 
-static void vfio_start_eventfd_injection(SysBusDevice *sbdev, qemu_irq irq)
+static void vfio_start_eventfd_injection(VFIOPlatformDevice *vdev, qemu_irq irq)
 {
-    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
     VFIOINTp *intp;
 
     QLIST_FOREACH(intp, &vdev->intp_list, next) {
@@ -417,7 +416,7 @@ fail_vfio:
     kvm_irqchip_remove_irqfd_notifier(kvm_state, intp->interrupt, irq);
     abort();
 fail_irqfd:
-    vfio_start_eventfd_injection(sbdev, irq);
+    vfio_start_eventfd_injection(vdev, irq);
     return;
 }
 
-- 
2.47.0


