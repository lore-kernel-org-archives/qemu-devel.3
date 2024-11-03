Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034EFD110C1
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 14:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7bgS-0000PL-KV; Sun, 03 Nov 2024 09:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7bgQ-0000ON-Dz; Sun, 03 Nov 2024 09:34:26 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7bgO-0001vb-Tt; Sun, 03 Nov 2024 09:34:26 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a5f555cfbso262794866b.1; 
 Sun, 03 Nov 2024 06:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730644462; x=1731249262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l1tRuAZZ7aREu/MsJgTHobQvvKWIyq2PiRipCLDoKy8=;
 b=C8wVVQzahyXhnDw/YXcCpE6XRKdVAU4l6TE9+tlp7mDlklEKbAPV8BLigGRoY7FKvL
 JFJEuzoTpgEoR3nN+I1qteTay58wSEbS+cjqZ6FxjKMFp6jD2Rz9p7SuZlFAsxl0leC8
 +5v3kxA3Vu5fTgnv7fyrlX3nZt36eVztisL4xKVGcn0+DOKX0MIPFy3lmtrv9ae+0mrn
 ArdlOtS987cfFBzslgaiiCJiE3KeZ3Kw9k7RXJ76mHi2yVPt7wQc3HoHyl4YzyTdAiC2
 yHRR8BMmRTC93qxAWMvfqV89eBWQhJELUVh3I+3XxEykMdtfxQ1isi1m+nVFrze1mXOm
 wi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730644462; x=1731249262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l1tRuAZZ7aREu/MsJgTHobQvvKWIyq2PiRipCLDoKy8=;
 b=rrXFuny9T0JN7q0+OB+v1x5z6PjTTa5thR+Mx3g4VaFfnUR48Y5kzDIVfoZzsLSqiA
 ceAHa4nAzDgGB5YWaPBOuKsfHq+Sk/YA/SXkFSmnsA1TpA6ew/JyEEuWrYmTm+qiMnBm
 PFcC+Ps8rwWyiJHdWWf6FMRLns4aPXc8goLShh0AbN+PIsXINH+KFrwrVzkYUeQevOaG
 i7PHsYc+aMkLRa0ywyrovfe5AzUDAnFuDsVtc6bn+ZjFoMXZxCrdmLHlwPqUKu7514sY
 n9KiRuHyTwcfwKxi518NZo1vmnqM1CLKGdMYuEMCPvk8N9t6ZzQ/+iSTlU6MqmlBaBb6
 2Now==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1XnPe1P9dKD89w93UJOyT7DnZrR+PtjXg9rxd4gdzsk7eOl1ZYqrgLtmR8+fDBKJZudVoIyzd5w==@nongnu.org,
 AJvYcCXiG9htq6uDcOE7U9SGtiYDb1gnMNFXAIZ83BINMuUMGEoTOB/fp5tnPXp8/8KHvPoC/0xf4Yuh8D24c6VI@nongnu.org
X-Gm-Message-State: AOJu0YznvY7nJvp7LoPU+wsrM62u98uR6QPhrk2eG1aMBJOs80SU8ZNn
 OZrdbuhaxUmPxa9LMz3WgkgpSfVbPjPXAOLbM6F7Px48Ijp9splPTEaT8g==
X-Google-Smtp-Source: AGHT+IH9ND1cBglwCCn9TJ35CYz/VyZMeSzd2DaFAW2djoO3WLQwLy3HONZ9TBF1vJTqQwHbg6w3LQ==
X-Received: by 2002:a05:6402:51ca:b0:5cb:728e:926b with SMTP id
 4fb4d7f45d1cf-5ceb92a38f5mr11181518a12.17.1730644462250; 
 Sun, 03 Nov 2024 06:34:22 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ceac74c667sm3350723a12.20.2024.11.03.06.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 06:34:21 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 0/4] Trivial ARM changes
Date: Sun,  3 Nov 2024 15:33:26 +0100
Message-ID: <20241103143330.123596-1-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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

This series improves the tracing experience in three devices used in ARM=0D
context. It also removes a duplicate statement in an IMX watchdog.=0D
=0D
v2:=0D
* Fix format strings in trace events for imx_gpt (Phil)=0D
* Add patch for tmp105 which improves tracing=0D
=0D
Bernhard Beschow (4):=0D
  hw/rtc/ds1338: Trace send and receive operations=0D
  hw/timer/imx_gpt: Convert DPRINTF to trace events=0D
  hw/watchdog/wdt_imx2: Remove redundant assignment=0D
  hw/sensor/tmp105: Convert printf() to trace event, add tracing for=0D
    read/write access=0D
=0D
 meson.build            |  1 +=0D
 hw/sensor/trace.h      |  1 +=0D
 hw/rtc/ds1338.c        |  6 ++++++=0D
 hw/sensor/tmp105.c     |  7 ++++++-=0D
 hw/timer/imx_gpt.c     | 18 +++++-------------=0D
 hw/watchdog/wdt_imx2.c |  1 -=0D
 hw/rtc/trace-events    |  4 ++++=0D
 hw/sensor/trace-events |  6 ++++++=0D
 hw/timer/trace-events  |  6 ++++++=0D
 9 files changed, 35 insertions(+), 15 deletions(-)=0D
 create mode 100644 hw/sensor/trace.h=0D
 create mode 100644 hw/sensor/trace-events=0D
=0D
-- =0D
2.47.0=0D
=0D

