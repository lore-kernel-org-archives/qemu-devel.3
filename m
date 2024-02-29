Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B055C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 05:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfZN5-0004gt-AM; Thu, 29 Feb 2024 00:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfZN1-0004gi-3Q
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:54:15 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfZMz-00076G-LM
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:54:14 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412b68d1a42so3926535e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 21:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709186051; x=1709790851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T2HBVz0S4NJ5PHHJFwkPmozZ7jbnrWNnxao4/XSu/No=;
 b=AK1TpYyy4RmCaZCIp8AvDV5DOE6RESj80/bF9731v9KsMJG3bT9LKo3Cu9TcDQNMN7
 f9rEyxLRu1dLv4vuQZ0jAKXEcDI85gdFF+5zJAF85wNvEUZtCwo/MARIVUoVnW74UGgo
 xY9fSMTiPIqkarq4vECtm0w9/Wpfcxk4j0WNS/2PUVux410RzR4BW8g3Hs5Z/f+Qpr/X
 Lg8W6j5XN9YdNaXC7x8q3bE854+0mAC6FcHcfwYIqMtbFG3zf0jEzgkppRbNBLsucaSo
 81KM55sQzAvU3qscLINCiRu1V4qgdRHStQVtW177GaIlpPKoUjU9tPWL32Ygnq0NRF8p
 2o0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709186051; x=1709790851;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T2HBVz0S4NJ5PHHJFwkPmozZ7jbnrWNnxao4/XSu/No=;
 b=X9J1+jzeg8cr1lmDBjfP+mN1yauypoZ2MA6WW+1i2gGMpjAZctDG/9mNrXBpawrt6K
 ZEgsoe2CR2OcxhMOo79eD4PfjwqWkstqiefkZ8Dp1B3lI1CjQJxyt7nXz12LbnV84zRF
 PkUemvoWnSbDjvFOH6lX+jp5U+cB2n+NuQ5kyAV7f8QR0CDmJvWADsr1AKiZjV11IS3I
 UeSYEfIX+BZ7+BZIUseCLdicLmmgE3wX+L9MApkifKnGZnJZTNgtu8y3op4Rdp4NDPL3
 059+XYFKFm2RhesZtt0A3ykYJRX4tvsyhenIaoKS9FPVLIFnoLtMURL5qvstyklVGOZp
 0OwQ==
X-Gm-Message-State: AOJu0YxEcTu2+1tzBC1Nip0Ae/h6gaQsk2I7+64WFK0TGXrmhKdSsB/B
 JwHviiFNFRAeu4MO6BevjlbFhblQKXSc7QOMn+lGXAptCDE+oUkqVchtEis6xMFfe6Q19/wdBIR
 29TY=
X-Google-Smtp-Source: AGHT+IFfzI1/oy7c8z6g1/ELF+e7L12CNsWnNMu5jd4WSETgOKnvbyWYa0XBkaOsde3fQehhYb/anQ==
X-Received: by 2002:adf:fb52:0:b0:33d:5a6f:a856 with SMTP id
 c18-20020adffb52000000b0033d5a6fa856mr569911wrs.30.1709186051045; 
 Wed, 28 Feb 2024 21:54:11 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 ck12-20020a5d5e8c000000b0033d2541b3e1sm721589wrb.72.2024.02.28.21.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 21:54:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/5] TCG plugins new inline operations
Date: Thu, 29 Feb 2024 09:53:54 +0400
Message-ID: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series implement two new operations for plugins:
- Store inline allows to write a specific value to a scoreboard.
- Conditional callback executes a callback only when a given condition is true.
  The condition is evaluated inline.

It's possible to mix various inline operations (add, store) with conditional
callbacks, allowing efficient "trap" based counters.

It builds on top of new scoreboard API, introduced in the previous series.

Based-on: 20240229052506.933222-1-pierrick.bouvier@linaro.org

Pierrick Bouvier (5):
  plugins: prepare introduction of new inline ops
  plugins: add new inline op STORE_U64
  tests/plugin/inline: add test for STORE_U64 inline op
  plugins: conditional callbacks
  tests/plugin/inline: add test for condition callback

 include/qemu/plugin.h        |  10 +-
 include/qemu/qemu-plugin.h   |  80 +++++++-
 plugins/plugin.h             |   9 +
 accel/tcg/plugin-gen.c       | 359 +++++++++++++++++++++++++++++++----
 plugins/api.c                |  76 +++++++-
 plugins/core.c               |  28 ++-
 tests/plugin/inline.c        | 128 ++++++++++++-
 plugins/qemu-plugins.symbols |   2 +
 8 files changed, 633 insertions(+), 59 deletions(-)

-- 
2.43.0


