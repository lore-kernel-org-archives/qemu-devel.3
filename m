Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42DEC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 08:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twd24-0005vn-Nu; Mon, 24 Mar 2025 04:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twd22-0005va-SD
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 04:19:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twd20-0008Td-HD
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 04:19:38 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22548a28d0cso70195085ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742804374; x=1743409174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xOrK0CNyvWgwvHNMDt1EpqYNiKW8RnpUxsrXXNGkomM=;
 b=gOvIo4l98gFj6pZh4SdXGxU98k7CI8WOXQE/84faQfPwdw3IOvNxS/4IuxBmnZnqkQ
 aWqz4DBnxIhYIS8r1cvgC/XDOHpIub8l9R9HY1J+XYuzNTArcItR3rJk5lnnAlTgUxQA
 ztroBbUwGhLdgI5neTiCIJiRWFzpvFcLvQcx6FydXkBxzvxJaTYNBm3XOSfXlVIfyct0
 ivHhhjJPv8HvrEGE3oeifgdiGkHIZBEFEr2sIVmb2i7a9p3S+YhqOkwN85h55M6ZsrQ+
 FhsmZ7QQgpEaLu2Nl0+gGAo8btk82uhYWKH34vJmBk9Dkd5kHqTGvon9IoLYtjSw33z7
 whwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742804374; x=1743409174;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xOrK0CNyvWgwvHNMDt1EpqYNiKW8RnpUxsrXXNGkomM=;
 b=dMXRUIHpDsqm9Ds5UCxlHaYy+2frYLITwQdRi+ljtxTiwtFGB6dl1Ujzs6zgGlkJtw
 qmudrb1IXqQlgE56HPft4yFnYRPbB5R706f30TGFfd8l+iWNBMECeXn3+OETaxeKr53H
 dtCaj6HoWQp8+VfA1Nh4PvBPtcWZVbSuTaY/dfMQfYrDnV2gCvigaW4utPGPA7I/9GJf
 OlQh336AiN0jLzogRePkLoXzu3wyDAXOGsMkr3K7/r3yYA1c76LSYiP5tmplyPTRL8Ux
 qnvI2E9EO1w1grBGtPcgn80LD1qpCTR4BUFgPGXqMOG1frU66Xp3w+C2ir17xC6xDIUR
 pVRQ==
X-Gm-Message-State: AOJu0Yxp8orqAtHDAbWemJCHzCGvRag2P/l789X9K2TWmuAkHmqT/zNX
 ISv/g5FEOMb67tvttfvGrxVmgFiNzVKse0FcUnkQYJJp6ZPMHRjwjL5l8wLU
X-Gm-Gg: ASbGncttXgmvwbBOFfXhFp5VKDzE/HWlANBlaxkKm2uockLoBNxLte8m/tLbuGqTtBX
 xkP9zsIP7JvwnYretnyrmAs52qaeL2Qz56vjubo3QsxhaeXkCTAwRMjiKg9830yRt//mycXwQkI
 RgA20FbGiBk09x7Itk31L+ZSiPPp/+BjmV1WGpv8MDmKEcambxCnHmu5J51FDHxMjK85Dt7ur6u
 xf11+5mBAHcbOOyLJVhVq8f/oy3c/uO9uHXQvSwJ/+0QQsKun5J6YPOsT71igrA8NNendckt5JQ
 o9sGEzlyBbpMCBK+uNRmj7YWxhsnS+SDy/mg9CImXmfqxmDQL6RPAUb8DuUvkYbIqNLMuDV91QH
 LkwMUl+nBIofgfYKYIGGv
X-Google-Smtp-Source: AGHT+IGDCsT1etrXhlxwmmjbTPXg6wW/MP23Pu+q/LcNuumB3Bwn6H46EoMZPKyfU+1O0B8l64ddiA==
X-Received: by 2002:a17:903:320d:b0:220:f87d:9d5b with SMTP id
 d9443c01a7336-22780d8a597mr224604475ad.24.1742804373722; 
 Mon, 24 Mar 2025 01:19:33 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2278120a5b6sm64717685ad.252.2025.03.24.01.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 01:19:31 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PATCH 0/6] ui: support multi plane texture
Date: Mon, 24 Mar 2025 16:19:15 +0800
Message-ID: <20250324081922.359369-1-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=yuq825@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Qiang Yu <yuq825@gmail.com>

mesa/radeonsi is going to support explicit modifier with this MR:
  * https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/31658

The side effect is some texture will become multi-plane which
breaks qemu. Because qemu currently only support single plane
texture.

For example, texture with DCC (a compressed format) enabled modifier
will expose one plane for compressed data, another plane with metadata
for compression.

This patch serial fix qemu to support multi-plane texture for
DBus and SPICE display, other display seems not affected by multi
plane.

This patch serial also depends on the spice changes here:
  * https://gitlab.freedesktop.org/spice/spice/-/merge_requests/232

SPICE client change here:
  * https://gitlab.freedesktop.org/spice/spice-gtk/-/merge_requests/130

DBus client change here:
  * https://gitlab.com/marcandre.lureau/qemu-display/-/merge_requests/5

Qiang Yu (6):
  ui/dmabuf: extend QemuDmaBuf to support multi-plane
  ui/egl: require EGL_EXT_image_dma_buf_import_modifiers
  ui/egl: use DRM_FORMAT_MOD_INVALID as default modifier
  ui/egl: support multi-plane dmabuf when egl export/import
  ui/dbus: change dbus ScanoutDMABUF interface
  ui/spice: support multi plane dmabuf scanout

 hw/display/vhost-user-gpu.c     |   9 ++-
 hw/display/virtio-gpu-udmabuf.c |   8 ++-
 hw/vfio/display.c               |   7 +-
 include/ui/dmabuf.h             |  20 +++---
 include/ui/egl-helpers.h        |   5 +-
 meson.build                     |   2 +-
 ui/dbus-display1.xml            |  37 ++++++++++
 ui/dbus-listener.c              | 118 ++++++++++++++++++++++++++++----
 ui/dmabuf.c                     |  67 +++++++++++-------
 ui/egl-helpers.c                |  97 ++++++++++++++++++--------
 ui/spice-display.c              |  77 +++++++++++++--------
 11 files changed, 336 insertions(+), 111 deletions(-)

-- 
2.43.0


