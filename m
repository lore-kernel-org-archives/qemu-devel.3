Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566C5C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsoI-0001bt-JW; Tue, 25 Feb 2025 06:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmso1-0001Xv-1c
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:54 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmsnx-0007ko-Oa
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:51 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43984e9cc90so37501795e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740481728; x=1741086528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QyNSTbsw1Rli9CIOsEEi/zV15lgdGHhsG9D/tniJcAU=;
 b=nSIozgvjSUGBZv2r6pGBqGgmV/Was7FlFIHkh5O3NUc+9D1MKBkUOli9O75PyL9tMy
 x4H7knHMfPwTQkZs2XZFycC+v0tNgGYLsM4G/WfSSFkClAjacpx/0b4JrF+WTBHObsEp
 LnnEcCQmBCVy/WE3jRgZ65YzvpwgUyjHoYzDraVe+YcDIKqXaeelhpeblsoBMjjpUOCV
 dJV2uwGqq+7T2e9XOjMWSzcJ2jRnLC/upemE12hOYVn4r90G5zKHti+LBkKOyRUXZ5II
 wD9ZFS+oEEAzoajzGU6zVBccoBXW9V709BvxfyXZ0kP+FJraJZ9WWDNRBw+EXUnuPZWr
 RVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740481728; x=1741086528;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QyNSTbsw1Rli9CIOsEEi/zV15lgdGHhsG9D/tniJcAU=;
 b=vJuPZojIHko0MVsQMqa7eD2+bYuuBQtACeujswnNHkxzHzsHIf0H421KNjDkkADsgu
 24uCyD3PWtEeMKHajW1PLqHgAr3vK/mtSGaWKf8ijS09gSIkQPMvqNMyLMD4N6lM/Oz+
 /Mrts64zGoYrAkPPGepxMOmuotH62Q5rBcYUlpp15/YJ3lbF7Kn3T1dwb0I4po0s+i3x
 LG8IM+fVQpvhnhTPNdm9o2UcomW3pFClX1cKaEtEH6EHtb+FDN4JzbAdsOIPU/W/mz/C
 twZM7qniKiaIcVysoII2wBCfc+nqAVPYBNzScyoOeqF5dlpyyweWdTQTULbwITaTmNDp
 L3Fw==
X-Gm-Message-State: AOJu0Yxvt9hkhcYud1BJOmCu3VpgWHBuTEgXef8VYIE1vM+QzRWjLbrJ
 e/ah33bkHt2wAAX4MU+qI270Jia0OdFDgsKru84vx38S7HifKNR/iVToJQ+EHEw=
X-Gm-Gg: ASbGncvE9iPTeeAo9x0cSyh+uOGD3u4j+KFi8cJkRfghfcDmBQifdRm3yFP9sB6RHnD
 aoyTuxd7Lsq4Kfxm+7zhteo+U0DJHtIc3Z/jNydyQgMwSPQZJUd75oBJ9zPSY7TUGqy6ONlSUDh
 ZSIj/f7hMsKaGMBQwEdNsVfS8u0s1P56pGxTRBviR9rHuuHqoU1ce8oviF1FjqGBzPmiApVlH9A
 UMjab1WvhZmGIl2R/EFf0rNQdeuo7LT6V0DYSKj61xBnKbfq5kRLyF/aJzxIRy0uvQ8+PhzVIl7
 3R0Yn+mUzcQoi/i+K2MewOblXYOI
X-Google-Smtp-Source: AGHT+IER2h0YA/kvhnSDHcPus6viboUh7mJLj7bW0qCgMQcayyCv0dw2bA1wDMXepGPL/Uw/z1eDFg==
X-Received: by 2002:a05:600c:4e8d:b0:439:892c:dfd0 with SMTP id
 5b1f17b1804b1-439a30e91femr179562495e9.14.1740481727925; 
 Tue, 25 Feb 2025 03:08:47 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b01346d1sm138824145e9.0.2025.02.25.03.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:08:46 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2C39C5F7DC;
 Tue, 25 Feb 2025 11:08:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 00/10] plugins: reduce total number of build objects
Date: Tue, 25 Feb 2025 11:08:34 +0000
Message-Id: <20250225110844.3296991-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

As we move towards a more modular build this series converts both
loader and api to build once objects. For both objects the only real
difference is between user mode and system emulation so those bits
have been hived off into those source sets.

The remaining core plugin is more intimately aligned with the TCG
backend so requires definitions like TCG_TARGET_LONG. Hopefully this
can been cleaned up once Richards TCG rationalisation code is added.

Please review.

Alex.

Alex Bennée (10):
  plugins/api: use tcg_ctx to get TARGET_PAGE_MASK
  plugins/loader: populate target_name with target_name()
  include/qemu: plugin-memory.h doesn't need cpu-defs.h
  plugins/api: clean-up the includes
  plugins/plugin.h: include queue.h
  plugins/loader: compile loader only once
  plugins/api: split out binary path/start/end/entry code
  plugins/api: split out the vaddr/hwaddr helpers
  plugins/api: split out time control helpers
  plugins/api: build only once

 include/qemu/plugin-memory.h |   1 -
 plugins/plugin.h             |   7 ++
 linux-user/plugin-api.c      |  43 +++++++++
 plugins/api-system.c         | 131 +++++++++++++++++++++++++++
 plugins/api-user.c           |  57 ++++++++++++
 plugins/api.c                | 170 +----------------------------------
 plugins/loader.c             |  15 +---
 plugins/system.c             |  24 +++++
 plugins/user.c               |  19 ++++
 linux-user/meson.build       |   1 +
 plugins/meson.build          |   8 +-
 11 files changed, 292 insertions(+), 184 deletions(-)
 create mode 100644 linux-user/plugin-api.c
 create mode 100644 plugins/api-system.c
 create mode 100644 plugins/api-user.c
 create mode 100644 plugins/system.c
 create mode 100644 plugins/user.c

-- 
2.39.5


