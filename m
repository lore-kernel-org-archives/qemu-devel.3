Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82433C5AC80
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsHxr-0007SI-Se; Fri, 07 Aug 2026 06:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wsHxm-0007Rk-EO
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:38:06 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wsHxk-0001JI-Sz
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:38:06 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso3997379a91.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 03:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786099083; x=1786703883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XYPHebnLeDLkc9jt0f49DzFAcWmD685b3WGzwLkyQXo=;
 b=ksHYOHEY87H/NYMeWpdiSL1IN9L4pVObh7qjIEsfVBNWcoVphacn3lSYwTSrzoWa8u
 mZN0/rjnC1/RoBhp+I0gtptPbZHEKecDo7qcqejEPthuOXrbK4oMfL5vaMdjmDsw0FW2
 1k/MSpc8qAlw72T/EW3ZEqdlaeOdKxYqpyy/AtkJtkaN+2PkJfqh2QZESRqr5c9ICGlO
 AtjcsHNyd1k8PGs4ZXagYSPW2bYWY5No+rLntu61ixckTmSA6a3OAnp16To7NeJlvktd
 k5NzJCLInnRnksVLnUr9NGAGx0Kwt0hRcIezvGcMVdC6LNUtvn593WQgszw3uRKdMKxB
 vzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786099083; x=1786703883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XYPHebnLeDLkc9jt0f49DzFAcWmD685b3WGzwLkyQXo=;
 b=k844TPaCR75QPaYzoKve3qMEJnUcB8ci//Ghekb9bsMCdax1mLG1JLHZa7YzpdKNFE
 cJ1YQxgciVnVq1GWAvo2Aeye45STkbqg/W/hHVmMesxoMqABkzkXyrXweJgV5wV6KWHg
 GW/6QkZ8Hqr0r9WbZqLZhb/pfNQmF4JtIG8JWGEwM3pL6sUTlE4WLD5rWleQ/XhVpzYE
 rOgkfFNW9f5o4AvFP50wKBZUkcNeMU7Zkmv2cItEZs26af9IuZh3uAEt8JYnlRaGW2Zz
 L7u1ZsIZ23TKZbj0/IBxMj9H3VFE9/HmGAOCgFzkOlR9syWKI2igUSDLu4T5Q4RI8ol8
 DeCA==
X-Gm-Message-State: AOJu0Yx+6NbOmPsvLEX5MXEL+uBmG39EfOtxUIXkaph98esnfK3LqxAh
 aUouCGtsBU09MxKmK9FHPeiGdWi5jQ3MqjOoDseXlzvvaMb6vrj8oC2o9Yy9KA==
X-Gm-Gg: AR+sD13yVHEyy9d9UsS1QtnCmsnCgZcpKcvKadEtNEMMHjCHbuqqLieJMmYntl5KTFR
 oFHqkSkqFec3SkhFd4HxaBch2qKV5wDxVGBrZyIw2K98eRhavpp4iRomZpoMmYHUMTKA2WKFgKR
 U5L6ewv2me96xLg+GIXXfHRQl152hjSPbv1nUwGUQDSPirB4yBslICuo8zYgo3CugrFZ1wsAcwL
 F+wUDvtCW44iKzv4vCBUmGInXrL2MJlWEPd6o4JF7OLfIF0CY0HMT2c9qy6/JMGuQXn7LYKmKkS
 RkMG0KWugMJrt6lZFSxPL8MoDIDujf4XvAIVWGs5lkRqvyVZHuCHIRC3urEwvFO/yPA8yUXaTTS
 WFi+Nsl/gb292xCJhE1I1/27psTCXkP3g+Mr6NjDGUl9JPeQOHGQOr9Mi3x7NGn7wuyJsp6rEHB
 ZEMPtvTKhmpufQPh805YHygmtIaX+h5+SvamzLoFv5w4cgfyPy+EsACwJ0IFcKpn9998bp
X-Received: by 2002:a17:90b:3a10:b0:38e:70d5:b12d with SMTP id
 98e67ed59e1d1-39261fbc353mr3008057a91.6.1786099082875; 
 Fri, 07 Aug 2026 03:38:02 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085c393d5sm4474743a91.0.2026.08.07.03.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:38:02 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 j-young.choi@samsung.com, mikail.sadic@ibm.com, hyenc.jeong@samsung.com
Subject: [PATCH 0/2] hw/ufs: Add a generic SysBus frontend
Date: Fri,  7 Aug 2026 19:36:15 +0900
Message-ID: <cover.1786096976.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102b.google.com
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

The UFS controller implementation is currently tied to its PCI QOM
device. This series separates the controller core from the PCI frontend
and adds a reusable SysBus frontend, following the AHCI model.

The existing "ufs" PCI device and its properties remain unchanged.
Platform-specific controllers can derive from TYPE_SYSBUS_UFS and keep
only their hardware-specific behavior.

Jeuk Kim (2):
  hw/ufs: Separate the controller core from the PCI frontend
  hw/ufs: Add a generic SysBus frontend

 hw/ufs/Kconfig      |   9 ++++
 hw/ufs/lu.c         |   2 +-
 hw/ufs/meson.build  |   4 +-
 hw/ufs/trace-events |   4 +-
 hw/ufs/ufs-pci.c    | 112 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs-sysbus.c |  81 ++++++++++++++++++++++++++++++++
 hw/ufs/ufs-sysbus.h |  22 +++++++++
 hw/ufs/ufs.c        | 108 +++++++++---------------------------------
 hw/ufs/ufs.h        |  14 ++++--
 9 files changed, 262 insertions(+), 94 deletions(-)
 create mode 100644 hw/ufs/ufs-pci.c
 create mode 100644 hw/ufs/ufs-sysbus.c
 create mode 100644 hw/ufs/ufs-sysbus.h

-- 
2.43.0

