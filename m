Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C93BC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txN9n-0000wd-FC; Wed, 26 Mar 2025 05:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txN9i-0000wH-UK
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:34:39 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txN9g-0003WQ-Va
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:34:38 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2255003f4c6so126918135ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742981675; x=1743586475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AFzJoEt0Ixt5u8WKVL91yF4RT8EZ3t7tZkR0nOBMuJ4=;
 b=TW1pJNrpJwKU45Oib0LMyIWIR0sa8BmXEeheF/LNZhwdEf9P8Pk8S8j32lqTz+GBLj
 q45+cdAHshV9Y8I/bDQ1z4VOepCxqV96ypEEN/Le8LFv/2LeaKL63Qlwlfc/Gfzn3Obz
 chXWMuSHoFTCtvKEEPSntw3QzK+Gi/K+MnqRcUfCJsoOZzgZMU2KZo6TodbPiQRaC2TF
 vLUsuLEnfqp0BGjmV/sOWJehjLGyFP05b8iQ3E97KTr9t+N+yGDt+z5iOA3OSXzhCs7S
 uZvmGJvWBtq3CaRYR3fmeRmDKP+a+wlSkbfO0wxqgH4+POTC12GfvbJnvDcGUCF4rRNo
 4hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742981675; x=1743586475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AFzJoEt0Ixt5u8WKVL91yF4RT8EZ3t7tZkR0nOBMuJ4=;
 b=ByN3U1BurDS5DSt84yfs9B7D9gnhZ5Ix9MCRI0dVLRN1q1P3150RvNwHYnrI4zbLSy
 IJEsNTo8sjCa+EpKB7erzCpGjtXE4FHowA10u4pyq3s7JndGzHPrci96Z9MqPMVfFL44
 orSz87lFqQREiAJNDgReFVtcSu7QFBf3wvWPEnzDcuvX4QiRoUFBlK7pAXW5YRICho5A
 r7Zp8REQxPkcMOo+uzmUimxLLMi31J6FDGQNe3TjdKSl4j7sLkQlSGPqyxZ5FbZv2m1K
 24hJtup/+XnVx7MioG5UxID7KWMYip1A5UUMx1Orm9ZQ1Hsab6qtDaKDc9g5IqsKG7Oz
 qrjQ==
X-Gm-Message-State: AOJu0Yz9gErPKllFVUoEpwVlsLEJr2f/bXQC9EKoalEARPa2AMtPSPN4
 0T0fqHZLevgNsjE3zrGQeORbSg+dFmznL0Snr0rXWgeiE6Kgg1xycUd2X/sw
X-Gm-Gg: ASbGncsJeht5y3gAhuJzDV6G7TRaTB7kI78DtiXxsPFmJTpWxQA0Wwvj09iR0tOWUXA
 TKG5VxaEIbuXtDS0nDYBMxf+xl/3PYFYdNfRWeYhVotoOLtzlgD16cr1XcvCxli43u/TawfVcrH
 cGYb19Ppsv4Yfd7s8+Z5CK7ELKL9L7g9vOPnevLPtrPig5DlTTBG/usIW27DB6zWSLqBKmi/PVT
 1ITXC+WCeDqjvciVxuTCoSbc4XZvHV4Sshi9OeKtkUhu2XEhfRs/hmzO/5KNlHvglPhwapg16MJ
 19msrMxlUADcTSsZrEHCz1ChusmUsm6wAV4qsbX7YjUXEL7pbfRHbw6HFVwol+NDt7UZYNrqm3k
 KcZyglRw18h3ToEAmXNve
X-Google-Smtp-Source: AGHT+IE/m6ZJHsMixaTLNC71+XnyBHlDVr2Q85xAMEo3slO1t4MgJObpXmstOwW/TXNu32LRoCF5Qg==
X-Received: by 2002:a05:6a00:a29:b0:736:39d4:ccf6 with SMTP id
 d2e1a72fcca58-739059763admr37531431b3a.8.1742981674891; 
 Wed, 26 Mar 2025 02:34:34 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fd57f7sm11729684b3a.44.2025.03.26.02.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 02:34:34 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PATCH v2 0/6] ui: support multi plane texture
Date: Wed, 26 Mar 2025 17:34:12 +0800
Message-ID: <20250326093418.397269-1-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=yuq825@gmail.com; helo=mail-pl1-x62e.google.com
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
 hw/display/virtio-gpu-udmabuf.c |   8 ++-
 hw/vfio/display.c               |   7 +-
 include/ui/dmabuf.h             |  20 +++---
 include/ui/egl-helpers.h        |   5 +-
 meson.build                     |   5 ++
 ui/dbus-display1.xml            |  37 ++++++++++
 ui/dbus-listener.c              | 123 ++++++++++++++++++++++++++++----
 ui/dmabuf.c                     |  77 +++++++++++++-------
 ui/egl-helpers.c                | 102 +++++++++++++++++++-------
 ui/spice-display.c              | 102 ++++++++++++++++++--------
 11 files changed, 385 insertions(+), 110 deletions(-)

-- 
2.43.0


