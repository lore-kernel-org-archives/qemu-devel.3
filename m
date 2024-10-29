Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC36D2AB32
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5l3W-0004Zh-WC; Tue, 29 Oct 2024 08:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3U-0004Yy-UT
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3S-0007Rm-5R
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:36 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43193678216so40866065e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730203832; x=1730808632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Qn3VnlLWDra9koZ9LR5i1hb7kIkeKEhWw6Jyi9oumY=;
 b=kvDuLxs2ksdkYxt1OFNG1qE1o8CDD2fBMBLReMW1GK1PWHbcprdzKE+sMbA5pkr4UN
 IKHhMyVKFvdlsdxZBMje3/3W+Sc06PXJvgy13DRIpk35nqYDbv0WaupZcsJkj+wArNr8
 fajNvh3oy6V+UOanO1hUGHTMNmqOvwIZXKwOkb9kEnmeVX9zTARIZsV6uVv/4LMNHYTQ
 8jDoQn01XCKx6EnsBi3y3h6eiWjQznBYpeum71zYsq/e3IxwoRde0eSdZNYOw1RyxWX5
 QGIffRuHG/UghFK6gtwNk9Ji3rs1H8JhR1K+vwwLxXCPH0a1k4Tr0as3/EAXe0oebyY7
 mdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730203832; x=1730808632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Qn3VnlLWDra9koZ9LR5i1hb7kIkeKEhWw6Jyi9oumY=;
 b=nhsyRghNMrwnTtMmoAJy4hVugl1pdYQhkfV95ObI2IBsX9vxxNFPT0rwLX44DgoYJ7
 c0HRzsDf0ceK/j7X/+LO36GQHBhOe2rkHsfFmlpszVkZgmlObUp+s9SkQm+UJAN+xUQP
 H+9q/TKc1cH9VqNTw7bmTWqeH3X3RPcQkknQv4H/8/0DlvWAzxA8tDe5rgX+PZ1xs1of
 8rPCOfPfqB7bly4UY3JM44nWOCEhzMC99Gu0BACYRcY21DcOajeXXyHrOOn4dC9Xipac
 rrfgyVKfgwq1Y95OCvUjAgNA09OwHXa0otXXpUVDdg37JigZBySdSfIyYrjpbvvyAN8i
 CX+A==
X-Gm-Message-State: AOJu0YwwMejk/TwMnwfPAg/bIotbwDm/avzcVlOO4ghycebd6AmWvQBM
 RvookyLeoLWK0wttP4WNbQS7sK1S4f6wLj5EqL60y/Ks0GEN2dAbhqg4/U1rMKDqMtprjLGP3lV
 8
X-Google-Smtp-Source: AGHT+IELqIgGR3Ny8//GN7zkjzF3NQGG0Uy4ofKGbc1GjxCYUpeNbbg49hQW75VSMF1Ao05vrUf6/Q==
X-Received: by 2002:a05:600c:4f83:b0:42c:c28c:e477 with SMTP id
 5b1f17b1804b1-4319ad089b0mr83155255e9.23.1730203832329; 
 Tue, 29 Oct 2024 05:10:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431935f7213sm142369085e9.32.2024.10.29.05.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:10:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 79E3B5F860;
 Tue, 29 Oct 2024 12:10:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/13] virtio-gpu vulkan support
Date: Tue, 29 Oct 2024 12:10:17 +0000
Message-Id: <20241029121030.4007014-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The following changes since commit fdf250e5a37830615e324017cb3a503e84b3712c:

  Merge tag 'pull-maintainer-oct-misc-241024-1' of https://gitlab.com/stsquad/qemu into staging (2024-10-25 19:12:06 +0100)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-virtio-gpu-vulkan-291024-1

for you to fetch changes up to 94d0ea1c19289d76ced934711fccd2269e69bb29:

  virtio-gpu: Support Venus context (2024-10-28 16:56:36 +0000)

----------------------------------------------------------------
virtio-gpu: add venus/vulkan capability

We are currently lacking a declared maintainer for the sub-system so
while we look for one I'm merging after testing locally.

  - convert some fprintfs to proper trace events
  - move timers used by GL devices into GL structures
  - handle virtio_gpu_virgl_init() failure better
  - implement unrealize for GL devices
  - use virgl version numbering to gate features
  - support context-init feature
  - don't require udmabuf for virgl only
  - add virgl resource tracker
  - allow command submission to be suspended
  - handle resource blob commands
  - dynamically handle capabilit sets
  - add venus context support for passing vulkan

----------------------------------------------------------------
Antonio Caggiano (1):
      virtio-gpu: Support Venus context

Dmitry Osipenko (8):
      virtio-gpu: Use trace events for tracking number of in-flight fences
      virtio-gpu: Move fence_poll timer to VirtIOGPUGL
      virtio-gpu: Move print_stats timer to VirtIOGPUGL
      virtio-gpu: Handle virtio_gpu_virgl_init() failure
      virtio-gpu: Unrealize GL device
      virtio-gpu: Use pkgconfig version to decide which virgl features are available
      virtio-gpu: Don't require udmabuf when blobs and virgl are enabled
      virtio-gpu: Support suspension of commands processing

Huang Rui (2):
      virtio-gpu: Support context-init feature with virglrenderer
      virtio-gpu: Add virgl resource management

Pierre-Eric Pelloux-Prayer (1):
      virtio-gpu: Register capsets dynamically

Robert Beckett (1):
      virtio-gpu: Handle resource blob commands

 docs/system/devices/virtio-gpu.rst |  11 +
 meson.build                        |   5 +-
 include/hw/virtio/virtio-gpu.h     |  32 +-
 hw/display/virtio-gpu-gl.c         |  62 +++-
 hw/display/virtio-gpu-virgl.c      | 585 +++++++++++++++++++++++++++++++++++--
 hw/display/virtio-gpu.c            |  44 ++-
 hw/display/trace-events            |   3 +
 7 files changed, 685 insertions(+), 57 deletions(-)


-- 
2.39.5


