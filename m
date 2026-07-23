Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30EFC531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1wG-0004D3-CW; Thu, 23 Jul 2026 18:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wE-0004CL-U8
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:30:46 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wD-0001Ou-5I
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:30:46 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-80c5cb9a888so8517047b3.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845843; x=1785450643; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZwwFtlsTkLCj0bPHuaj+IVaPS9QFlGYFzEPwRm95wEg=;
 b=oFWtnktFPhXY2TvdwAr9aQaKmIF0VLK3xydfxykm6rkTEFCyjidmULoz06gpzHSSq8
 skqWvHnKH7qqO6lecEQy8sTzZwaI5pAeGAJCCeIGVEs2XTGfzaZy1EsLbKiwIGJt2WH1
 qTnzRfKZR4gOaZv3LKHlPuqal0AXaJ0YQwxwg6TvzVeVwq0Art4hpn2qPRqXLYy6aLDz
 InYu78xEcfaWRV5/ZbAbGMinEhMG4t4u8ZeeJ/MOPvXlYLWNB8KtYyjQ1UFShnNK2PSl
 5Bp7D0dqvttxbyR1XR2vqjiGyyyvK0iN4ybIA03XbvM2oz8+iM32jDf+hD2SFnY1Wie9
 7m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845843; x=1785450643;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZwwFtlsTkLCj0bPHuaj+IVaPS9QFlGYFzEPwRm95wEg=;
 b=L0lex1uYgHdvpywDvvGSRFFa2XzztNAg0S4i9c11JJODtS7oFo7h9cs0HlNETX8RZY
 LtAaOfF0UtzwLauhYFo5G0p0LWfXcMP9Dd9RrSJfFWk8f+UbovsZBDj12dfl+EC83/0n
 iJXbOK5pEFq4Ciekas+EOvRjzbhPDaE+bd9otb9ey4LA0iVIELeD12idihIDmRDs9bIj
 CoEIl0hV/5UEi8jA5aTtzN4PrOnTlVipubBYoRW0MLgAMtAO56fE1Y0ooiVAtp9UZcej
 sAQTJzpYAgzOKHgB0prpf+ziSuvac5MtzEt7LSkLe02fnjYLacmuJ8LWfNxkf16yftfH
 J9Cg==
X-Gm-Message-State: AOJu0YzwxXtKqXPa//LfrTJ1HrkVZOEnL3E0uLp7oaGwbyBJluNRkyx4
 SnvYNalRc5nJRUW/IgRqjjYa0RbPeB9kwx6oMtKurxdnf4sK+03BrMRi
X-Gm-Gg: AR+sD112Tuvv2mSaWJLyVz7gpVAkwxTFa4TDONorkNMGr8yWoRCVexZyRQCq42rpd9Y
 W7npujGVLr2AGCLEcVrfUEVImKGA6LTvE5fO6++JSfR28j811NeqOdrk6D4KwZ31sPKjMRybdA6
 qAlfowVPl67iD5ZcbTRNrMSACLhfdsQK2wIAAKVqBshwKrkvi1bcNpCTEXWfykzoCbV4EtuuwFo
 myBK86u64ymiTq+nUJhdhC1BS7NrlQlsAlMJ3VYAVvXLNvweNwjRmdglEMDs99SHI2o3vkNDCFY
 ISQfuHDx9jAJTOlU/Nt7US4P0YSefhmClIIkWfZNrhY2KxUuatxRiV47V1aj2JZiQOCL3HSh653
 XydXlzh89E3wC+8n1AU1UHTUjFFMHQ8vutIYni0rVkFtLNJtmQAGHRY+d1mCo/gHUjVYyCC+8WM
 RLnTejchHYPwU1pPmOUQ==
X-Received: by 2002:a05:690c:6b81:b0:81e:c7d8:3e24 with SMTP id
 00721157ae682-81f4c3199b2mr13908547b3.59.1784845843189; 
 Thu, 23 Jul 2026 15:30:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:30:42 -0700 (PDT)
From: ConKite <connorkite@gmail.com>
Subject: [PATCH RFC 00/15] vhost-user: isolated memory
Date: Thu, 23 Jul 2026 15:29:59 -0700
Message-Id: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOeVYmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwMT3bKM/OIS3VKgNt3M4vycxJLUFN3c1Nz8okpdA3OD1BQTC2Pj1FR
 zJaABBUWpaZkVYMOjlYLcnJVia2sB4BUbcXEAAAA=
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=4339;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=ddgAjFSnPTuZOk/CnCc8q0BCfZctEpGERxTbUBmFodA=;
 b=HYOx56uw3p6shzza3KTLUGqJpj9p8IbuHf0Vd1SsXTmo+4VKfOarGBaF4JWGVr05kM1l7BIPK
 LLKgX/XJYbIBWNm3xqJ8lzwltA+rRPJsBxMlV+LlPIFkO+FSCjAC3E2
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=connorkite@gmail.com; helo=mail-yw1-x112a.google.com
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

This patch series implements a memory isolation mode in vhost-user. The
purpose of this mode is to provide the option of additional security by
eliminating direct access of guest memory by vhost-user devices.
At a high level this works by:

1. Adding qdev and qapi properties required to enable isolation mode for
   various devices.
2. Allocating an isolation memory region in an anonymous file and mapping it
   to host memory.  This isolation region will hold the bounce buffers and
   vrings necessary to move data.
3. Using a vhost-iova-tree to allocate and track the mapping between
   guest regions and their corresponding bounce buffers in the isolation
   memory.
4. Creating shadow virtqueues to intercept request notifications.  As
   kick and call events are received by an svq, it copies buffer
   contents and descriptors between isolation and guest memory before
   notifying the backend or guest.   

Note: This project is currently in a partially functional state. For
example, in testing vhost-user-input and a keyboard, keystrokes may
register correctly or be double counted depending on the combination
of backend daemon and guest OS used. However, the desire is to make
this work public at this stage for comment on the overall
approach.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
ConKite (2):
      vhost-user: Consolidate chardev property definitions
      vhost-user: Add memory-isolation qdev property to vhost-user devices

Connor Kite (13):
      backends/cryptodev-vhost-user: add memory isolation bool
      net/vhost-user: add memory isolation
      vhost-user: add memory_isolation to VhostUserState
      util/iova-tree: g_tree_foreach wrapper
      hw/virtio: iova_tree_foreach wrapper
      hw/virtio/vhost-shadow-virtqueue: used handler
      hw/virtio/vhost-shadow-virtqueue: specified vring placement
      hw/virtio/vhost-shadow-virtqueue: range boundary in translation
      hw/virtio/vhost-user: create isolation region
      hw/virtio/vhost-user: send isolation regions to device
      hw/virtio/vhost-user: add shadow virtqueues and eventfd intercepts
      hw/virtio/vhost-user: handle data movement with shadow vqs
      hw/virtio/vhost-user: shadow vq cleanup

 backends/cryptodev-vhost-user.c      |  24 +-
 backends/vhost-user.c                |   4 +-
 hw/block/vhost-user-blk.c            |   4 +-
 hw/display/vhost-user-gpu.c          |   4 +-
 hw/scsi/vhost-user-scsi.c            |   4 +-
 hw/virtio/vhost-iova-tree.c          |  15 ++
 hw/virtio/vhost-iova-tree.h          |   3 +
 hw/virtio/vhost-shadow-virtqueue.c   |  30 ++-
 hw/virtio/vhost-shadow-virtqueue.h   |  17 ++
 hw/virtio/vhost-stub.c               |   3 +-
 hw/virtio/vhost-user-base.c          |  13 +-
 hw/virtio/vhost-user-fs.c            |   4 +-
 hw/virtio/vhost-user-gpio.c          |   4 -
 hw/virtio/vhost-user-i2c.c           |   5 -
 hw/virtio/vhost-user-input.c         |   5 -
 hw/virtio/vhost-user-rng.c           |   5 -
 hw/virtio/vhost-user-rtc.c           |   4 -
 hw/virtio/vhost-user-scmi.c          |   4 +-
 hw/virtio/vhost-user-snd.c           |   1 -
 hw/virtio/vhost-user-spi.c           |   5 -
 hw/virtio/vhost-user-test-device.c   |   1 -
 hw/virtio/vhost-user-vsock.c         |   4 +-
 hw/virtio/vhost-user.c               | 441 ++++++++++++++++++++++++++++++++++-
 include/hw/virtio/vhost-user-base.h  |   1 +
 include/hw/virtio/vhost-user-blk.h   |   1 +
 include/hw/virtio/vhost-user-fs.h    |   1 +
 include/hw/virtio/vhost-user-scmi.h  |   1 +
 include/hw/virtio/vhost-user-vsock.h |   1 +
 include/hw/virtio/vhost-user.h       |   6 +-
 include/hw/virtio/virtio-gpu.h       |   1 +
 include/hw/virtio/virtio-scsi.h      |   1 +
 include/qemu/iova-tree.h             |  13 ++
 include/system/vhost-user-backend.h  |   3 +-
 net/passt.c                          |  16 +-
 net/vhost-user.c                     |  11 +-
 qapi/net.json                        |  15 +-
 qapi/qom.json                        |   6 +-
 util/iova-tree.c                     |   5 +
 38 files changed, 622 insertions(+), 64 deletions(-)
---
base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
change-id: 20260604-vhost-user-isolated-memory-070ed4833ee7

Best regards,
-- 
Connor Kite <connorkite@gmail.com>


