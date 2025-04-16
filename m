Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B20C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 16:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u55ls-0006ad-55; Wed, 16 Apr 2025 12:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.nesterov@gmail.com>)
 id 1u55U7-0000xF-SI
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 12:19:36 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.nesterov@gmail.com>)
 id 1u55U6-00039Z-9t
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 12:19:35 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-54acc0cd458so8013433e87.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744820371; x=1745425171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+3qSB0+GTgBghiSFnENIgrlEhLLev9jZvqUHME6NoLg=;
 b=Ymq8Blxlepqe15a316D7bBm45YXhxDoTL9ToWP8MG/CUBzo4eBAxQbclm8VJ9VGNo7
 Fu4J7lCTxFbEZOSIwvhCMeHQJhr5QoBk+iRJD82aOzoJ92z8Bf1s+K0rpJFK4TI6ZtxZ
 MMpjitx3AJ/6+uKr8oirdGkP+J91Gs/tqHO6EH4wc5nq/Q9HiXt+VQ5rLoQL4WxZ5VCa
 VNeyeLZBh20TZXXCn8/YohtEzYbUDOK0sVtFI0UUc9gRMuwuaikrOu4my+3rtXzQHBvm
 nkw3Q2vRJOgxycD9ICVStP/OJorn9Um3pMD9DFHNUDwrtOZXNe+txpijIXHUrLmnmXZ6
 fcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744820371; x=1745425171;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+3qSB0+GTgBghiSFnENIgrlEhLLev9jZvqUHME6NoLg=;
 b=cznj7fgnDF8X522ZaApSjdxfC4V/lIeyAH9aOGQjIFrODrNvgwxLnDeVbddTLIO/EI
 pKuiYKPFsOzRrOt155GkX+9ANgkQR5ZgYZJbL25Jh3OiSfUsZRx0owidKepxF0wOXxIP
 mcDlaDfhKL8t6QQC3rroMqQ6DtcUhPyuDMqXj7BjE1YPCcN4G12v3BkKSBQ7TrPfgDrq
 MPPW5AUooSgWkcDzQIREWlRYwrwCrfXwNzMV9KWiI8olQhB3Nca9ebdIeSWSoVg6Ta6Z
 8iT9DHCIBBM6Fdsg5YHVpaOrmLTEHRu5M5WGoXs2YJV9HviPXQMCR8ds/rLZebxWs6q9
 rKpg==
X-Gm-Message-State: AOJu0YzldUprb7nIZkqGlbD5yOG8JWOmKaoMQX3UR6eWBdCOlFbdzo6f
 7uOeXfDUKrN4UIyouM2TW5BE0dKr3fWOSnpi3/584ietMUMMtQ19zXXcxg==
X-Gm-Gg: ASbGnctfYb/f37JKEAjGRYT5sNontpIlig/98QAmBuNB6MDsxLP15jMFGNnHYhBmK8r
 pMhWYO2FWFUsksHxDIN9ebZc8SH82zV1tJvqN9KvQ/iqgMckD2vDvr6sN9ZsQf2+24AdiCrdwqY
 CuRMHunfu0Lmx5BcYpleHcAPiq1/X2xoyTq8IANrDYHkvk0JuT0j+MCsk0amN46Vdag1oxywFMp
 XWSKOWoXHPHg2mNC2z3X/sOraNeiNOocj71qiWzprIHzz3JaCXEHgU/EadXADOm20KsBEZYMwHp
 51ftv141YJdyaA5Qew29vxwCRVaZNR6qjIbSYEkKm6QSV8DaP2fI88P5yBRlH4l4BgQXFrGx9e1
 s3d92jecAf7ZWbpRa/B8wdjOM
X-Google-Smtp-Source: AGHT+IFVcWM9oS8VDP9KSL4KXTQCV6rgcWmuykJoJtgh15OvUSjGkWd0NZsBQFyVs6O0k8OZfeyw2A==
X-Received: by 2002:a05:6512:2250:b0:549:59d2:9ac0 with SMTP id
 2adb3069b0e04-54d64afc326mr885577e87.47.1744820370565; 
 Wed, 16 Apr 2025 09:19:30 -0700 (PDT)
Received: from yuriy-ThinkPad-P14s-Gen-2a.. (87-95-173-171.bb.dnainternet.fi.
 [87.95.173.171]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54d3d123168sm1758247e87.3.2025.04.16.09.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 09:19:30 -0700 (PDT)
From: Yuri Nesterov <yuri.nesterov@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yuri Nesterov <yuri.nesterov@gmail.com>
Subject: [PATCH] usb-host: enable autoscan for bus+addr to survive host
 suspend/resume
Date: Wed, 16 Apr 2025 19:19:29 +0300
Message-ID: <20250416161929.2846102-1-yuri.nesterov@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=yuri.nesterov@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 16 Apr 2025 12:37:54 -0400
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

Currently, there is a special case for usb-host devices added using the
hostbus= and hostaddr= properties to avoid adding them to the hotplug
watchlist, since the address changes every time the device is plugged
in. However, on Linux, when the host system goes into suspend and then
resumes, those devices stop working in both the guest and the host.

Enabling autoscan and adding those devices to the watchlist allows them
to keep working in the guest after host suspend/resume.

Signed-off-by: Yuri Nesterov <yuri.nesterov@gmail.com>
---
 hw/usb/host-libusb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index c3d642c9d3..32c0251471 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1227,7 +1227,7 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
         !s->match.vendor_id &&
         !s->match.product_id &&
         !s->match.port) {
-        s->needs_autoscan = false;
+        s->needs_autoscan = true;
         ldev = usb_host_find_ref(s->match.bus_num,
                                  s->match.addr);
         if (!ldev) {
@@ -1244,6 +1244,9 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
         }
     } else {
         s->needs_autoscan = true;
+    }
+
+    if (s->needs_autoscan) {
         QTAILQ_INSERT_TAIL(&hostdevs, s, next);
         usb_host_auto_check(NULL);
     }
-- 
2.43.0


