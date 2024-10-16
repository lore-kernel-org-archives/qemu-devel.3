Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A2ED2F7C6
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 21:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1BVG-000269-Td; Wed, 16 Oct 2024 17:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t1BVF-00025i-RG; Wed, 16 Oct 2024 17:24:21 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t1BVE-00012f-76; Wed, 16 Oct 2024 17:24:21 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a0084f703so32656366b.3; 
 Wed, 16 Oct 2024 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729113857; x=1729718657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7V7VO+tsKceMvp6RylfNFS9ZDwLOpBaFsdLb0+3aNAs=;
 b=nLiTtyhIbQFU7htwZagwzGAce8uZyDZW1hX0bKQu0jl776kfiZQusZ/DicdRYdQt4K
 v5ke1t4+4RsD7amrMmsAASzLYWB4mZpwH13GI472EXWSKBF1Q/n3Vqd3lldYeHByA1pq
 1xrlD5IHr845d8bQ4bYeEbnL/FM94eB3XcCki5wNcg61WJf12mD8JKcKyXktwxPBUkiE
 PL5HQFHAFOP6bOPmJbsbzwsI2JTQlOELNqS41kqC8UY6OUcV5tIYNnf+4XWyWrwvSy49
 E78tvM45r1JvOi6ubxSABDWg6laMF3mQ1tPRAfEXT7pHBbx1x7YPedKaskS185Th7C0e
 gPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729113857; x=1729718657;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7V7VO+tsKceMvp6RylfNFS9ZDwLOpBaFsdLb0+3aNAs=;
 b=Xy52x7J2eXP9kJ2eDRRCdP0Ai96AG2M38boMJ1hc0wDNHfT968kZNW0r4LTgL1qHnX
 JvFNGLmu0rNlM1sA/99jHKpc73COCpPT+Tq2+0f4O9AmoiLo6onVz7II119rVTXDV/y8
 9PEkvGghDFcPlETE4RX3jerV0WBsCq1h6xThwfvZVvqpujJhEreTiDisWw4DxSpTmDcn
 f/H76I6H2vlrfZ1Irv1SaZ3lgwCeP079Ih7FfAYJUpJrsnh0vRiqyDPEqsUcOHyH/OXn
 MuqiOWBijEw9VXicNQJbc+yQf4LjrVP+DVGhkPs0AY/eUBJ8l+CziGkXw0fVQGBSv7Nr
 fhJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjI8TkoR4ixBxE0zXqFk5GKYnhoiIIt1phmcYD4xg0hkvjI+aOOXChZp7cCqu9MNvaBqHQzqIrQg==@nongnu.org
X-Gm-Message-State: AOJu0YxRc0R2dNawCF48YJmgyd8QeC/NwNobi3z4TvAWQvsvC16FyIaM
 VRrkof+qcKtHKgXKfm2Cr4sWfvIC38hL07WanUsKVrOiTeyY22YcXNEfjQ==
X-Google-Smtp-Source: AGHT+IG+/xmKyGmHB9rzx4bo73mLe1iY5wMB+WIPj5fUrSh5vxph4cldG/Qh/iSt+UaOP9CszJhaoA==
X-Received: by 2002:a17:907:f148:b0:a99:f1aa:a71f with SMTP id
 a640c23a62f3a-a9a34d3cd85mr474036866b.11.1729113856989; 
 Wed, 16 Oct 2024 14:24:16 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-025-143.77.191.pool.telefonica.de.
 [77.191.25.143]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a29750a9asm218005766b.88.2024.10.16.14.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 14:24:16 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 0/5] Consolidate lan9118 phy implementations
Date: Wed, 16 Oct 2024 23:24:02 +0200
Message-ID: <20241016212407.139390-1-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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

hw/net/imx_fec and hw/net/lan9118 implement the same Ethernet PHY with simi=
lar=0D
but not quite the same code. This series consolidates the implementations i=
nto=0D
one to fix code duplication. It then continues to make the code more readab=
le by=0D
reusing some existing constants.=0D
=0D
Having a dedicated module for the PHY allows it to be reused in even furthe=
r=0D
device models.=0D
=0D
Testing done:=0D
* Run my usual sabrelite load and verify that network works.=0D
* Build and run Buildroot's qemu_arm_vexpress_defconfig which includes lan9=
118=0D
  and check on serial console that IP address gets assigned.=0D
=0D
v2:=0D
* QOM'ify + mention boards whose migratability will be broken (Peter)=0D
=0D
Bernhard Beschow (5):=0D
  hw/resettable: Add SOFT reset type=0D
  hw/net/lan9118: Extract lan9118_phy=0D
  hw/net/lan9118_phy: Reuse in imx_fec and consolidate implementations=0D
  hw/net/lan9118_phy: Reuse MII constants=0D
  hw/net/lan9118_phy: Add missing 100 mbps full duplex advertisement=0D
=0D
 include/hw/net/imx_fec.h     |   9 +-=0D
 include/hw/net/lan9118_phy.h |  36 ++++++=0D
 include/hw/net/mii.h         |   6 +=0D
 include/hw/resettable.h      |   1 +=0D
 hw/net/imx_fec.c             | 146 +++---------------------=0D
 hw/net/lan9118.c             | 137 ++++------------------=0D
 hw/net/lan9118_phy.c         | 215 +++++++++++++++++++++++++++++++++++=0D
 hw/net/Kconfig               |   5 +=0D
 hw/net/meson.build           |   1 +=0D
 hw/net/trace-events          |  10 +-=0D
 10 files changed, 311 insertions(+), 255 deletions(-)=0D
 create mode 100644 include/hw/net/lan9118_phy.h=0D
 create mode 100644 hw/net/lan9118_phy.c=0D
=0D
-- =0D
2.47.0=0D
=0D

