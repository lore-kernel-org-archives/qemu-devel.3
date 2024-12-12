Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2D7E77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLh4m-0003BN-NX; Thu, 12 Dec 2024 06:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tLh4i-0003AG-GV; Thu, 12 Dec 2024 06:09:44 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tLh4g-0004La-VO; Thu, 12 Dec 2024 06:09:44 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436249df846so3157015e9.3; 
 Thu, 12 Dec 2024 03:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734001779; x=1734606579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zVWNUBhJGyzu/2Is1amxC46zWsYMopAKiJyOxvMwPmI=;
 b=QeUl05yJB/j9YsstJ99aEYqzgoWmbdBKitnKCwAK7Jg9Q6geCveMpJHulTX0s2W4RU
 WKzKiFoaeIS5MkOX3kOvl4/IRVgBqOFOXsXwM5W9pJLvbFkZzN4FFD0mOOmreROFVfFS
 HtktES3kICsMSL1gB897ougtB4isiEnfzH/tHDuGA7wmR4c6B5OdaQD5IfVc6+7Sw9rk
 Wz86LyIcUTi9nfFvNqM/GUhNfMOEt+dV7vTi6hwijOtY5wvqvHTsFoVvSJaCi0gQwbWg
 EbKU8ooZoA18cs4ZmDf8krBZ+uIyUAX0RyeonSY2O2G1bBzyngbJ0l/EC/IWrEavFoek
 cSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734001779; x=1734606579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zVWNUBhJGyzu/2Is1amxC46zWsYMopAKiJyOxvMwPmI=;
 b=lVE2gjq/zJsdRQy0o2V5Pz0hFil0TNgmMe3WZODMNR1rIlMEI4s1BOns0Ld5w/S0fT
 NzLA0aI8ba3Mi2dC6uv0iJMoZ9M5BqPiijvN7O+FFJ1vnrLX1K1i+67+VbPJ1mHjFehz
 y81KJqHEvrNP28IWJGWghb775AYiqy1TQXnX4jVVX1SOyXCp+Gi6ukQnw1CErr0yJohr
 uoE40dkcCQMWfoxUNwj8RbblqUrquRCG0SkpvrkZBtLVTZPbbNezGZPqChXGA7uZrw1r
 pwmy2w7dZRGtlvLKpOkUWJ55m2oZs8O6XbUUjCdbNN2z0vpcKJRL7+6OalGgGCU2EOcE
 q+7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8EukmpSVHzPb57NDnjYK6jAEg9NexLDW3p7O5CHAC8ul1E9XsOD3fZmMD2BlGvCfNjpU5CuhIawZgbA==@nongnu.org,
 AJvYcCXIT1aCMcBiC0ZPa2FJ7fbUkb3byf9CiqHuC/EPL1gnBIUzYfNRcz/NSgfbWCKg5KyaooCiPxrsaw==@nongnu.org
X-Gm-Message-State: AOJu0YxNDpxiIs5oOXRTB4YSXDQwLFuhRZoraEYqQ8ydaQzMWz0MqNvv
 EDB0B4DwjO4eDzYVWj/vJzXvviBUOG7Hon0KNHEA5sVoChtKTUh8iEU+Dw==
X-Gm-Gg: ASbGncuU48YwsOipWHaRBBTgS8mZPq47CsPsGHvUV+cLqz6Cz5HerYtbHY6yJaD+ZWc
 i/Ci9O+24ZFYU/3QOS1tA3PFtPSVY+kpd8/a6fB1KlWp/p5uaBtW6BJY+uEzO8c78TukShJLTQa
 v5qJ5Mpm2ethyC3bGCDuTZmYe3IIXXdKMKWIcihTccomNiF6VLSL7B+9FmkB8OEjFkFOLVHoMOD
 aUHiq15LtFoQDvX/G2pg3aP0YKdEWUbFUOj7GeG9CV6iYZAWSP9ufqpgRs5iKMf3nF3K+Jd5zNW
 5FD+yBOZ7ekTmkUqR3Ts0TqdlwiF5ll+5RPLgQayvbs=
X-Google-Smtp-Source: AGHT+IG8cTf4jSexVoUvisgwxcfLZmPOrTNIaEkji/unKIY9CXCe1QQpHRiUOVwikIXkndV5j+U3LQ==
X-Received: by 2002:a05:600c:3109:b0:434:f335:855 with SMTP id
 5b1f17b1804b1-4361c441e47mr38831485e9.28.1734001779275; 
 Thu, 12 Dec 2024 03:09:39 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-242-029.77.11.pool.telefonica.de. [77.11.242.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362559ebe1sm13200725e9.19.2024.12.12.03.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 03:09:38 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v4 0/2] AHCI cleanup
Date: Thu, 12 Dec 2024 12:09:24 +0100
Message-ID: <20241212110926.23548-1-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series fixes some runtime overhead when handling interrupts in AHCISta=
te.=0D
It then extracts the SysBus implementation into a dedicated file for separa=
tion=0D
of concerns.=0D
=0D
v4:=0D
* Port away from qemu_allocate_irq() while at it=0D
=0D
v3:=0D
* Remove extra PCI include in ahci-internal.h=0D
* Extract SysBus implementation into dedicated file=0D
=0D
Supersedes: 20241205114453.1848-1-shentey@gmail.com=0D
=0D
Bernhard Beschow (2):=0D
  hw/ide/ahci: Decouple from PCI=0D
  hw/ide/ahci: Extract TYPE_SYSBUS_AHCI into dedicated file=0D
=0D
 hw/ide/ahci-internal.h    |   1 -=0D
 include/hw/ide/ahci-pci.h |   2 +=0D
 include/hw/ide/ahci.h     |   2 -=0D
 hw/ide/ahci-sysbus.c      |  91 ++++++++++++++++++++++++++++++++=0D
 hw/ide/ahci.c             | 106 ++------------------------------------=0D
 hw/ide/ich.c              |  19 +++++--=0D
 hw/arm/Kconfig            |  10 ++--=0D
 hw/ide/Kconfig            |   4 ++=0D
 hw/ide/meson.build        |   1 +=0D
 9 files changed, 122 insertions(+), 114 deletions(-)=0D
 create mode 100644 hw/ide/ahci-sysbus.c=0D
=0D
-- =0D
2.47.1=0D
=0D

