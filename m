Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944F8C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 20:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7LA8-00012y-DV; Wed, 15 May 2024 16:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA6-00012G-AA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:42 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA3-0004Es-V5
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:41 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51fdc9af005so11908678e87.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715804617; x=1716409417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C7NdSt3+Gmz6B1W4WCW5L+nUF60PKb5NJ8EPqSfb0KY=;
 b=LKD7GkOR6R8FzRPMBasbfHbAjSzV9Jvj6LrRxJ49HIjMzVNjIgkMT6Mg0o8ph2vFcw
 8SwUNVwKihW7vLFa9yjKrNsHekuw2nUBZ81OCIK8s+lChYwzCCvpLNUh5Sz/TO6JD1rS
 UJwCUydqZUfsblbexBi6vfPs/Mg5BSrFjBG7Ph/UHU8irmBOdEkL8DQukvgnNLDJZpC7
 kiWPvU7hoRAmJLVRj5a5p22HjSGtfxdbbqP+mN2DkidF9MhKzaAYRsR64EzqFxv9AKMm
 1s+gre71PTR9OPj+Gq8mFckE0SugtDGi1/cDNSNF/2wN2g/ZX4eg0B9WGKhPeNumgvHq
 umkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715804617; x=1716409417;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C7NdSt3+Gmz6B1W4WCW5L+nUF60PKb5NJ8EPqSfb0KY=;
 b=ebKFAnFYzJ1CwSHTu2QYWlw1bfR3xdmjLwgAFcZ7U2vfLNh3oU8jIfADCxcBWn+0nD
 zG/kMKX4GWPHAzM3qZQrJ/qM2P8N1UsWRYTwHChueou5gDa6bndNyD7MavReh6PBE/Nx
 MCrzAPXe6fQ9UBEFIJPU7LdGl7neWdYHY2Fz+wiG/YuLefNY72wQ7HQIvujA7BJx1XmV
 o1aiGE+RgZMJn2aGhaBctktonvqoECkM/xVEHbQioButWXRy7vqxLijGqejFlVSolxwb
 rFMiX5amH79ULX1fS/coMcUimhG73PuRLOv4DKhyQgZbXpz72mgJxzDakzyfzGE4SuB8
 VYCw==
X-Gm-Message-State: AOJu0YzH0Ej6za8Y9e2bb45q/W+C4mlWnjDzWrV1LFdgqZzhNHT/hLSx
 Lhip+zs1W2HS2NAar7HYtScExXm3K0jZOTO0u/h/+ftXYqayEWyjuGFCk7HXkTHfxjr9y+8EP2H
 a71A=
X-Google-Smtp-Source: AGHT+IG8tRQh3Epf+CqSKVNOBWy1SeCCzoNw8SmWC0PwYj7seArxQ2392LuSqL6+A8UasdCc9Lz7cg==
X-Received: by 2002:ac2:4e11:0:b0:516:d232:2516 with SMTP id
 2adb3069b0e04-5220fc7c59amr15799724e87.6.1715804617423; 
 Wed, 15 May 2024 13:23:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a60eabd3csm507888466b.108.2024.05.15.13.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 13:23:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 999895F78B;
 Wed, 15 May 2024 21:23:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/11] testing and plugin updates
Date: Wed, 15 May 2024 21:23:23 +0100
Message-Id: <20240515202334.710324-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12a.google.com
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

The following changes since commit 265aad58e9cab31d0e69c374ec2efcede7fa8881:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-05-15 08:52:27 +0200)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-may24-150524-1

for you to fetch changes up to 8f9df78afac40d60a0f8162aae80c90a9c58972d:

  plugins: remove op from qemu_plugin_inline_cb (2024-05-15 13:59:13 +0100)

----------------------------------------------------------------
plugin and testing updates

 - don't duplicate options for microbit test
 - don't spam the linux source tree when importing headers
 - add STORE_U64 inline op to TCG plugins
 - add conditional callback op to TCG plugins

----------------------------------------------------------------
Alex Bennée (2):
      tests/tcg: don't append QEMU_OPTS for armv6m-undef test
      scripts/update-linux-header.sh: be more src tree friendly

Pierrick Bouvier (9):
      plugins: prepare introduction of new inline ops
      plugins: extract generate ptr for qemu_plugin_u64
      plugins: add new inline op STORE_U64
      tests/plugin/inline: add test for STORE_U64 inline op
      plugins: conditional callbacks
      tests/plugin/inline: add test for conditional callback
      plugins: distinct types for callbacks
      plugins: extract cpu_index generate
      plugins: remove op from qemu_plugin_inline_cb

 include/qemu/plugin.h                 |  42 +++++++----
 include/qemu/qemu-plugin.h            |  80 +++++++++++++++++++-
 plugins/plugin.h                      |  12 ++-
 accel/tcg/plugin-gen.c                | 136 ++++++++++++++++++++++++++--------
 plugins/api.c                         |  39 ++++++++++
 plugins/core.c                        | 109 +++++++++++++++++++--------
 tests/plugin/inline.c                 | 130 ++++++++++++++++++++++++++++++--
 plugins/qemu-plugins.symbols          |   2 +
 scripts/update-linux-headers.sh       |  80 ++++++++++----------
 tests/tcg/arm/Makefile.softmmu-target |   2 +-
 10 files changed, 508 insertions(+), 124 deletions(-)

-- 
2.39.2


