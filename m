Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9168C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 12:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugixq-0001qR-1a; Tue, 29 Jul 2025 07:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugixo-0001jG-Er
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:57:48 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugixk-0006CP-22
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:57:48 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so4525826f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 04:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753790257; x=1754395057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SZSODHS5E6m6BD865ahUYVN2+26qppC1UXbBufFAE50=;
 b=lJF6KTR2t+Qsa79zIk4KPI+z++TQHAWQbTpg/anthh/YnpiD9gTk1/OKXPt/Gax0Ul
 V8XVF7z/s1xruWPNYNlg8HCtsVr6LhtNMz+WfPtuS4jZnVEp5Mi70AJLWMyoXyki4qse
 zhVEG8AhPwo1ZKDhQR+tXvPR4iyjiXiyNOVARXZLWVhHzDp42rqxI2UaMsZD+gi1a8F6
 hLnjU135IqdPGeA4xeV7SAiudpXvJtoA3ZOUT5FD5owW273j/SNIg7H6uVn0pXuNr439
 QQ0Rwq1BgtKCMuCbXFsk60k2b0gTuE2g6nQiyNX1ppUVCC2/Ye7hW7J08sAz7kdJr/Hr
 yHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753790257; x=1754395057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SZSODHS5E6m6BD865ahUYVN2+26qppC1UXbBufFAE50=;
 b=eNV6QpaiFiFjmIeIMozKbgslWU3QWyosUolkcnltTjfUXzQ2U6FoeQMi6x8bwVZ1Z9
 5EhtcQikpLWqLCaXF6FJ7qr1H82Tmdx7kRoYAIXcLd7gw70xnGinijV32vCcR+OwIAFb
 vhP2IGXeHNDjKQ32yxNQ6sznRlGTc1EG7FquYm3hrY45oCzAkB+rnkwqU6F59OfyuXLZ
 gQcWJ1/a3NuSVh210byIMoTQtOuvSBzo0TePd+/9/mW1BkplCSTDfIxkOMRtCYSVqktZ
 keY5lWvdSKXcOyHpzkCUXi+o0uC+cUDpW6c0ARvdwQ5IVeGrg5nVi8S83qrPe5Jmi6dV
 Pgqg==
X-Gm-Message-State: AOJu0Yx+NE2/+w2V/POMYLpTM2SSoveu+71nsxh7cEW/JhwiHL+o6RQa
 ev4rMXYTE0SPuhMVuPtuVWUrN+E/Xg2W6LiG069bVB7zT92XmslRZHxFcPF15vzZ5dp5fQ0KeJs
 Vx493
X-Gm-Gg: ASbGncuJlzfXRdBW0PDty3V+rwzmCiaGVxiQA7a+r2MaX9HZl07OYk50HAHE8zoS+fD
 xpu8M6JZQToesBiGha3AfJVCz0DQEPa1kSuNq19jtz8xuoZ+B18We4NafUVVBRp/7vHTRXc0TNM
 9MKxqAD5Rtfzs3J4Ls0wo4f92Z+Oj1yxbGrsT8Ae0Nuyl8NGMhXV52r44Vb0irSd5DOubNr5/Jk
 MZ4mcRnleZ3iUeRP2p6WGjFSHsCf3GHizgAe7NT2QgZHEj5HHPI6cocxJUryRrVHB6wB/tD1dgC
 5y83gq4gtSQfJE9vnIZk9ST4Kqru6SpFfdkPRTfn1KMzZ6mn/tuLrxTIlkY13m8ycJWILYMUoVJ
 rsksJJ6j6cXXP8wZjYE44LyCFyoQIi3pq6MKwQstCRY/31Lns5tQz73wcZ/t+u0mYiK5smMc2H8
 KZmhJBpDE=
X-Google-Smtp-Source: AGHT+IGxL/hVMxdniwy3OVLc3vXXtfaeZvA02syxnLLFnpEu9NCuVgpPqpu52kI7OIaH6UZhKPXHPQ==
X-Received: by 2002:a05:6000:40cc:b0:3b7:8b1b:a9d5 with SMTP id
 ffacd0b85a97d-3b78b1baf11mr3724364f8f.51.1753790257172; 
 Tue, 29 Jul 2025 04:57:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b7842a3e59sm8582019f8f.44.2025.07.29.04.57.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Jul 2025 04:57:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/9] Misc HW patches for 2025-07-29
Date: Tue, 29 Jul 2025 13:57:25 +0200
Message-ID: <20250729115735.33619-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The following changes since commit c017386f28c03a03b8f14444f8671d3d8f7180fe:

  Merge tag 'pull-target-arm-20250725' of https://gitlab.com/pm215/qemu into staging (2025-07-25 08:24:52 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250729

for you to fetch changes up to 67e4808403471427b73c8d2c3f4273d64908f480:

  hw/display/sm501: fix missing error-report.h (2025-07-29 13:56:39 +0200)

----------------------------------------------------------------
Misc HW patches

- Fix MIPS MVPControl.EVP update
- Fix qxl_unpack_chunks() chunk size calculation
- Fix Cadence GEM register mask initialization
- Fix AddressSpaceDispatch use after free
- Fix building npcm7xx/npcm8xx bootroms
- Include missing headers

----------------------------------------------------------------

Adam Williamson (1):
  hw/xen/passthrough: add missing error-report include

Clément Chigot (1):
  hw/display/sm501: fix missing error-report.h

Luc Michel (1):
  hw/net/cadence_gem: fix register mask initialization

Michael Tokarev (2):
  hw/display/qxl-render: fix qxl_unpack_chunks() chunk size calculation
  roms/Makefile: fix npcmNxx_bootrom build rules

Philippe Mathieu-Daudé (2):
  target/mips: Only update MVPControl.EVP bit if executed by master VPE
  hw/vfio/vfio-migration: Remove unnecessary 'qemu/typedefs.h' include

Pierrick Bouvier (2):
  migration: rename target.c to vfio.c
  system/physmem: fix use-after-free with dispatch

 hw/vfio/vfio-migration-internal.h   |  1 -
 hw/display/qxl-render.c             | 11 +++++++++-
 hw/display/sm501.c                  |  1 +
 hw/net/cadence_gem.c                |  2 +-
 hw/xen/xen_pt.c                     |  1 +
 migration/{target.c => vfio.c}      |  2 +-
 system/physmem.c                    | 15 +++-----------
 target/mips/tcg/system/cp0_helper.c | 32 ++++++++++++++++-------------
 migration/meson.build               |  2 +-
 roms/Makefile                       |  8 ++++----
 10 files changed, 40 insertions(+), 35 deletions(-)
 rename migration/{target.c => vfio.c} (90%)

-- 
2.49.0


