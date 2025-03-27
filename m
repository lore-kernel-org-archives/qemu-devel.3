Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C417C36008
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 03:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txdSv-0006tl-CI; Wed, 26 Mar 2025 22:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txdSr-0006tK-9S
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:59:29 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txdSn-0007db-PO
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:59:28 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2260c91576aso9250935ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 19:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743044363; x=1743649163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yJyAHUwFlVJraZEtb73M+HzUUPfVVPBywg26KBCi8IU=;
 b=QOaxxPWp3/is0mq32wNTt7v3V2Mvlr+G2mZB3raqf3Vj437vbPnlebAjzRKt4QoH4d
 mB5uET23CeKSbRDf+CraClKjzR+0kEpzioHjyg2FbC995qSPgN2ofQqf7Wd586Rr7UHF
 Ay30FQHeL2mGw1HDrio0uVuObE+pOjb7G2lukALtOAAyb9Z0IS360DAAeOuVuZyYfm0X
 Y7kU4+As8MjqGdNNtBUqRUA/qkNMSn2LkLucctJvud+VHY8SUc9Luffq1gptWNG0e98J
 SA1h1QvXGixIDMD3cbUBaKq8p+tC7SfIcSAl/yEGhNvoMMK0ozg+aQssN8P3ZouOor2X
 SdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743044363; x=1743649163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yJyAHUwFlVJraZEtb73M+HzUUPfVVPBywg26KBCi8IU=;
 b=XKhQkrprAemA0aDcfyi7IkTvCMAhuaaU0bXRtzW5GOCgpy0lj5YAhUcTSFs6oDVgKP
 F5EHWmvuuKLp9zAMag3olxOSH/rMT7se1UV5FphaXK2NA2EZghbOsZOFxyDRo8Uu8irU
 p8Hdz7pG7vhsF3UBQtJ91RXJ0z5LFkaACB1fXOw2xxLa6kvEVgDPaEZKxVYsOZU5xEKu
 rP1IYNTq8Qrwao5XypJwAjCiFqbVf9FbSOY+qv4rp9hevT0neRbxQBIG5ru4oPKz/KkR
 x5RivpSCvHWO7j+I+O4bzWfrBBO73BpMvZrpDyAHvdcKFWDByff0ZJsMG6yDtGGbvS11
 L16g==
X-Gm-Message-State: AOJu0YxgW0UPyBV2aas3jPGKrs4wT9acjCS8fDcqYgfjn3Wd3Ynz/jYg
 F3kcQScmXo/Q+uRlO2HPMkw9qCxhaGbLYxnv4dHAwV5+OD5dJWWObL2KINAN
X-Gm-Gg: ASbGncuH7b/GusplrTs09iA2XBmgkDnR9tFJKVfbzKnpBkUTR+nXZuBK7WUTi/a1cZV
 bGloKgFcM8br3Mdtwu2dqYMMbR2PlFsoz/1CQGh1/1ItMj6cGiRcRuFiwBvSu1LI4kpo9DHRWpk
 MnXZr0SzZ6zS/cDDPfbJlEUN9rHWp7JuEASE0ZcqmBJfDCb2zC25rPyYvPeUWrqHj3UnYWskkBG
 WTX1RET2TfjLuRrhDMRacIaebdB94M0PsDyvpOajPC8vRV8Ux6V+bpZSsa9G5CFfeeAxQDiZarC
 uOfLLtjPR1IGMN9yN3cLieCmfzH0n68nlw9VArwZChQezsi3Bw4QhqgGl2+r4ca6w+KGZJvypNs
 UgcLKifd5bHvHhBLuCOdR
X-Google-Smtp-Source: AGHT+IHEjZLGZPmfTrPwgawGGysCEiB3ueR+fk6bKAZU3j59yQlNc15QKlHoPaX2Y0950vD3+IMyfA==
X-Received: by 2002:a17:90b:2650:b0:2fe:afbc:cd53 with SMTP id
 98e67ed59e1d1-303a87b2f9dmr3032682a91.28.1743044363222; 
 Wed, 26 Mar 2025 19:59:23 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd37e5sm1027698a91.2.2025.03.26.19.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 19:59:22 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PATCH v3 0/6] ui: support multi plane texture
Date: Thu, 27 Mar 2025 10:58:42 +0800
Message-ID: <20250327025848.46962-1-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=yuq825@gmail.com; helo=mail-pl1-x629.google.com
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

v3:
  * dbus rename interface, add more args

v2:
  * change dmabuf API for array length
  * check spice_qxl_gl_scanout2 API instead of bumping spice version

Qiang Yu (6):
  ui/dmabuf: extend QemuDmaBuf to support multi-plane
  ui/egl: require EGL_EXT_image_dma_buf_import_modifiers
  ui/egl: use DRM_FORMAT_MOD_INVALID as default modifier
  ui/egl: support multi-plane dmabuf when egl export/import
  ui/dbus: change dbus ScanoutDMABUF interface
  ui/spice: support multi plane dmabuf scanout

 hw/display/vhost-user-gpu.c     |   9 ++-
 hw/display/virtio-gpu-udmabuf.c |   8 +-
 hw/vfio/display.c               |   7 +-
 include/ui/dmabuf.h             |  20 +++--
 include/ui/egl-helpers.h        |   5 +-
 meson.build                     |   5 ++
 ui/dbus-display1.xml            |  45 +++++++++++
 ui/dbus-listener.c              | 127 ++++++++++++++++++++++++++++----
 ui/dmabuf.c                     |  77 +++++++++++++------
 ui/egl-helpers.c                | 102 ++++++++++++++++++-------
 ui/spice-display.c              | 102 ++++++++++++++++++-------
 11 files changed, 397 insertions(+), 110 deletions(-)

-- 
2.43.0


