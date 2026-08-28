Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29653C61DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvSr-0007mE-0H; Fri, 28 Aug 2026 08:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzvSq-0007m3-3b
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:13:44 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzvSn-0005Wb-DC
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:13:43 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-482e1bfcc63so656302f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 05:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787919220; x=1788524020; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ey69dTinh/EJjSfLRyZUI8o0OPFE0HXzfjla/jXFPMc=;
 b=OUIDA5yVMR4ggnSH/wtM6WiIRYx8rc3Q5qlhPuB7eO3sownPI+OViiufDClYZ4XRU/
 RMZQsL3h14vO15h4SLUYiuRjZsrPXa2J3ij3Zoe/FtF9nB/aHorawQ1r1/rdl/TmDWFM
 ZaNQTuFAc+1ABnxD+oBjdk+YaisVbbAQjXXB7HY15wvy+ej8bjNUX2opo/Cfqe5+SQy5
 aeZmP0u8IEjBipLMmC2Sdd5spwt7CxiL3jLMiq2WTjewTJXl0HrruhzSqmU3E32DzHYQ
 LEiF3+5K3MS0/WCSXVX/EQZmKNgra6bHDXf81eE3Uo2kc/3u1/kRU2Yoz8djCC/G2mFC
 ZAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919220; x=1788524020;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ey69dTinh/EJjSfLRyZUI8o0OPFE0HXzfjla/jXFPMc=;
 b=AgDxgOF5YD3aMWiyxpHCMG8hQp7D4MnxiKaTaiMutUTpSAMDcjEuN0lNcOU+ChqJns
 Ex9PTUq8juN5hWor7qCyy3AEpDU+7DyaVZb2jMJP2YTCpnZIcmBCOHFMirMi7S6XzsK9
 LBTxhKaRbSkA/v0LhJtHJ3i/2nUcnhi5Wlu8/IzK97Hi5C84x2GEOHT/Z6UVD+drX0Br
 p59dihNPbr9xWNFonJMpCI1NFRabJSmnLgk2U3PZhga2+BUvjQK8t8wzJ0yvyFpEfk2x
 Ql7gPmTTyMy1w3vBCGApF5nHCgtJ8i59TBQGA0FKMrnV6bKODjIR70yU6sAZwb/FAuVj
 HBQQ==
X-Gm-Message-State: AFuF++k+SKIC7tu9Xf5SI/Px309Qrvk5nDDSaBLPfpsofhJWFTJbJOMZ
 QmtPr2brKjOj63X/Lc/C/d6zZ6XdbFs1CTCChpVtD+NstLd+/y6JH2pZNMadcfetCgsSJT+40NE
 duaszmQM=
X-Gm-Gg: AR+sD132Wcqcch08E1G13Dm+qJg7H5+q2yjG0tOaGrNz2st2nYhT/2/ogcvGBwh+NWo
 njcP91l4alPBDgCUNBYLT7nnOzRtQzVNPoccdPKZ08KKcjs3DGm5muXRDkJL0Sil68V4cix7aIZ
 5DOMlhCBoOcuHtl9mylRmhXwMoE71TVV+rhkug9YrSRrLZ61drcU9EGCqcvdPNBpc7JwqIvkxiq
 pkf0N5lUkcJtHP6V4FMhV0HsUWmvH8ocjLoIcDUg6MS7wQ9328Rt+gb9Sb3ETb//c47EXS6XQ4u
 NzIVR6NVodM4gsKm64/le0joiHfLuf3++zgQPDtsvMWKTCmwxTD+UVA+DvrlZK5osuEtwKvOeiR
 GdaKhf15DntOhIhwo7KPIhBzYPtZ8/EUdf00a1J2l9ATzdUChDVC+vWlxO4UG9KZII/bd0RLo6s
 UZ2cxCkUsLuNYCau1DABGELZuY5r8opX7140eroh7uKh9Pc8eHzhHlCnPXN3MD
X-Received: by 2002:a05:6000:268a:b0:475:da0e:744d with SMTP id
 ffacd0b85a97d-482f75bb6b8mr9730632f8f.8.1787919219711; 
 Fri, 28 Aug 2026 05:13:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2005esm3477105f8f.24.2026.08.28.05.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:13:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D4EEE5F7E6;
 Fri, 28 Aug 2026 13:13:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 0/6] random fixes (gitlab, tests, char-fe, mailmap,
 deprecations)
Date: Fri, 28 Aug 2026 13:13:31 +0100
Message-ID: <20260828121337.2277303-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

The following changes since commit 0a1ebd448b38afaa118597cbb633dbec24ef74d3:

  tcg/loongarch64: Fix compile issue LoongArch host (2026-08-27 11:04:01 -0700)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.1-random-updates-280826-1

for you to fetch changes up to 485509e033d8d4fc3f408e02de205fad960e1d02:

  mailmap: map the last From-munged author back to a real identity (2026-08-28 11:40:08 +0100)

----------------------------------------------------------------
some random fixes (gitlab, tests, char-fe, mailmap, deprecations):

 - use .base_meson_job_template for macOS jobs
 - use explicit cflags for arm system tests
 - add arm-softmmu tests to MacOS
 - implement qemu_chr_fe_backend_name
 - deprecate virtio-crypto
 - mailmap updates

----------------------------------------------------------------
Alex Bennée (5):
      gitlab: use .base_meson_job_template for macOS jobs
      tests/arm: add explicit CFLAGS for system build
      gitlab: add arm-softmmu tests to the macOS build
      char-fe: implement qemu_chr_fe_backend_name
      docs: deprecate virtio-crypto

Denis V. Lunev (1):
      mailmap: map the last From-munged author back to a real identity

 docs/about/deprecated.rst             | 18 ++++++++++++++++++
 include/chardev/char-fe.h             | 13 ++++++++++++-
 backends/cryptodev-vhost-user.c       |  8 +-------
 backends/rng-egd.c                    |  8 +-------
 backends/vhost-user.c                 |  8 +-------
 hw/char/imx_serial.c                  |  4 ++--
 .gitlab-ci.d/macos.yml                |  7 ++++---
 .mailmap                              |  1 +
 tests/tcg/arm/Makefile.softmmu-target |  2 +-
 9 files changed, 41 insertions(+), 28 deletions(-)

-- 
2.47.3


