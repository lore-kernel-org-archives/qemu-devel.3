Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC388C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 17:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6wBn-0004yH-Pw; Tue, 14 May 2024 13:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wBP-0004pu-IJ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:29 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wB0-0004tG-J4
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:01 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so545743a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715708577; x=1716313377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GjZ7KifFglh+uMfDPAeKXZwHERo568uFc2foxLMBJ4U=;
 b=n3iwcMJmq5DYm4cA5LDU1ID8U2BBjky0IN+kP9VD0w6cmMrMGwxTmZQ4n5c5Sgv57h
 CnwaHdRJ4oCI/xDeVM59Igx87HNWbT1WK3uzgH2c5A2Nk4MGJWwyGs60nKj4Fayk+NqE
 T2uUnumKK2UDf0BnNI76ztBTrPhKD6Cecywq8u+ErYbeHQ0XFCUIm2I+aCJMs1owCzLp
 GzI3DxH/sG7ar3intLNmX4qlSKg7fsK5BHZNMfWt9ID6RbJTH9kZbZAa01l3w2t4ECXN
 Gp62YDwf0lGoMImsbuT2lfukIDpC173k9tEDHbw+JCc9BfgssbJOM/5Puij8dV9/FI1s
 S8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715708577; x=1716313377;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GjZ7KifFglh+uMfDPAeKXZwHERo568uFc2foxLMBJ4U=;
 b=lhSjIcV012aDKIdIWE+4iv/w2+UJszOaXW6GaNlVvZ6gbKxO+TKzxtG+txCK84dOPi
 xyCAP1dYPW2sJ4sNC/TtU5VzU2DTiM3b01suMKQrgg3QwsTGkZmqNgrbA6mJo+REEJsv
 Yjs+pYlxQFLe3B9FUxvrgNt6Ey0YI/8pH/WHDKloViP3BF8M01iN9Ouqbj0bQwXp+PTU
 8qU4VQjm+hxBl9s3AQshu40pbykLQW1c6+xJTiCenA/si2KUmmtVO42Tfsat0QU3+/HN
 1x0WVCJeMoeMzPS5rvxvQnoJEjZLDWnJY3VivcY5ERwKQA/NwOuzxh+pG7iUelSQGFmT
 cWGQ==
X-Gm-Message-State: AOJu0Yw483jdHoxrhrvLdsOd0GW323lf+29GXpZfji4B103irOtIawAR
 if/DIQ42i6neOk2ukcwNb77kJlYC2tdFMULv/GX0MTJUYb5MzniONu3LwMojvtI=
X-Google-Smtp-Source: AGHT+IGUkbCf+0zBMAQvgnOBLMuzZVclFPF48yEE6fAKTRy5TpALV/kVJR7gighWSgVy7njI4ULqcA==
X-Received: by 2002:a50:c30b:0:b0:574:eb80:3305 with SMTP id
 4fb4d7f45d1cf-574eb80345fmr1172325a12.11.1715708576906; 
 Tue, 14 May 2024 10:42:56 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c322c85sm7790031a12.84.2024.05.14.10.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 10:42:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E552D5F8B0;
 Tue, 14 May 2024 18:42:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 00/11] maintainer updates (plugins, testing) pre-PR
Date: Tue, 14 May 2024 18:42:42 +0100
Message-Id: <20240514174253.694591-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

This is mostly plugin related stuff which is all ready to go however
I have a few miscellaneous testing updates which would appreciate the
review.

Thanks.

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

 include/qemu/plugin.h                 |  42 +++++---
 include/qemu/qemu-plugin.h            |  80 ++++++++++++++-
 plugins/plugin.h                      |  12 ++-
 accel/tcg/plugin-gen.c                | 136 ++++++++++++++++++++------
 plugins/api.c                         |  39 ++++++++
 plugins/core.c                        | 109 +++++++++++++++------
 tests/plugin/inline.c                 | 130 ++++++++++++++++++++++--
 plugins/qemu-plugins.symbols          |   2 +
 scripts/update-linux-headers.sh       |  80 +++++++--------
 tests/tcg/arm/Makefile.softmmu-target |   2 +-
 10 files changed, 508 insertions(+), 124 deletions(-)

-- 
2.39.2


