Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C30FC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs1E-0001Ux-L9; Wed, 21 May 2025 18:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs1D-0001UX-DP
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:35 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs13-0004zh-Ol
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:35 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso5619321a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747866862; x=1748471662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WeWztwRO1f9kpE1L9uL08Bn44xYTu0XHTbPptf9BzjA=;
 b=GJSsNnnOdV97+fzfNAY63469W44nX06R4M7/EIYozH/2pzsa14jyHU1YByrqckQRlV
 W6GQMg8BwW1bDorfn4dhDb3C5STbcTW8XrKeJR6FyE5mPyEzwHvEtUBwSmMRTxy5dSk9
 ecvkXW5oC7lLwTU2P8beGOLCWYnnP2uD4WmPU7EkRPICHH8PO5HHUIDlIt6hDSLxNhna
 5kx+f0SreW/d0w6vHfRHDoYvIT2tpXYhdmkgyxCfu0YjJPluY1n4wqifziFfdve1xqwR
 GKD73ogQm6KmimYz8/OchiDpYT9LxbcVMVyOajBpZnraJd2fnMuak9cGnWFsM+3sbBrL
 REig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747866862; x=1748471662;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WeWztwRO1f9kpE1L9uL08Bn44xYTu0XHTbPptf9BzjA=;
 b=plqLQ0LGwgP8dyWbc+Ro1HmGfCp4wftbCkVTd/NEQwi36KPYpxN7yMY7XnZuvBSN9b
 wdhU4yRlPgPArD+oClC5I5iblVAozXRwcuhJNdsRsTSeXHmGN65If4Pvm8E+BaZdaNNw
 5H6IjsaZKV9izFtXz7fVCr4BT+8m3Stl5xD2OV4UTukEs9/3tGDmwAyxpcTux0klL20L
 8jN4n/TyOZnYcLJQmnaTRK57EnmKNoMPeuGvpbIbQcgsTbXh/X2yc+r33WpyortfIpk1
 cHSlvYncZw9/CJk/MAOuHnuKS49ec5K8ir0/y3YRfW8VfHYCufZPkVYvo84GKdButYBz
 cgLw==
X-Gm-Message-State: AOJu0YwHsbPNf6aCwUNee4CUusbll5KhhyexsgjJnA7BJVuciDA2sDXg
 30NIzOmGa+QqX2IPLbCi0qI1QMPxud1ipdaAno59o8eXWVeJWVk8UNPGwfdVEmwKYrIFCi77F/s
 mxeYc
X-Gm-Gg: ASbGncs3MA79Gdwgm4CqqnPTzDDPwlZ9hvqJn6bPzGyCT4SOGA4yIpeq99vGUt3UPgP
 ICt46gs8CPKPyBnDQn2PxdeAx8EN2C1B05ci3yg1RrKNo9JC7nwlHj5GKkhq2p3OLsa1uvrJST1
 PAKr2VOkQB6IiehiFG87nlTU8u6uTCW7ejwI+xapliEDpTd03j1aokUaMPSktcli37EzNcxRiO1
 8TOab0xcMKO6qFEn7PCOjtTu3R7dR/39C79hScDfpGIFljW0t6Q5IDRvVHIUPkIaVq3Rn3JR26V
 Rp/G4nMliVsLaZWaVIOFl99l1yYsWFB8iISaKj0C+ILetevqc0A=
X-Google-Smtp-Source: AGHT+IG7yGzuJv+5LIVdeTCYxGucE9KEvaqN+9jZtnn3Py3YOy/GALpfcdhPxU0pvsWKFwKENNZHqw==
X-Received: by 2002:a05:6a21:6d82:b0:218:2ee9:2c67 with SMTP id
 adf61e73a8af0-2182ee94ed2mr19701568637.9.1747866861961; 
 Wed, 21 May 2025 15:34:21 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf5a31dsm10165224a12.2.2025.05.21.15.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:34:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/7] single-binary: build target common libraries with
 dependencies
Date: Wed, 21 May 2025 15:34:07 -0700
Message-ID: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

Recently, common libraries per target base architecture were introduced in order
to compile those files only once. However, it was missing common dependencies
(which include external libraries), so it failed to build on some hosts.

This series fixes this, inspired by Thomas fix [1], and applied to other
libraries introduced very recently with [2].

As well, we do further cleanup by removing lib{system, user} source sets that
were recently introduced, by merging them in system/user libraries, thus
simplifying the work on single-binary.

This series was built on {linux, macos, windows} x {x86_64, aarch64} and
freebsd on x86_64. Fully tested on linux x {x86_64, aarch64}.
In addition to that, it was checked that compilation units compiled per binary
stayed the same, and that their size was identical.

[1] https://lore.kernel.org/qemu-devel/20250513115637.184940-1-thuth@redhat.com/
[2] https://gitlab.com/qemu-project/qemu/-/commit/b2bb3f3576e5dc99218607dde09e25ac0e55693c

v2
--

- Additional patch to merge hw_common_arch_libs in
  target_common_system_arch libs (Paolo)
- Better commit description for merging lib{system, user}_ss with
  {system, user}_ss (Paolo)

Pierrick Bouvier (7):
  meson: build target libraries with common dependencies
  hw/arm: remove explicit dependencies listed
  target/arm: remove explicit dependencies listed
  meson: apply target config for picking files from lib{system, user}
  meson: merge lib{system, user}_ss with {system, user}_ss
  meson: remove lib{system, user}_ss aliases
  meson: merge hw_common_arch in target_common_system_arch

 meson.build            | 124 +++++++++++++++++++++--------------------
 accel/tcg/meson.build  |   8 +--
 gdbstub/meson.build    |   4 +-
 hw/arm/meson.build     |   4 +-
 hw/core/meson.build    |   4 +-
 plugins/meson.build    |   4 +-
 system/meson.build     |   2 +-
 target/arm/meson.build |   2 +-
 tcg/meson.build        |   4 +-
 9 files changed, 80 insertions(+), 76 deletions(-)

-- 
2.47.2


