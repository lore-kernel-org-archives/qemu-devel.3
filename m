Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462EBC54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs1N-0001WU-6O; Wed, 21 May 2025 18:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs1I-0001Vz-6a
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:40 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs14-000503-Tq
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:39 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-742c73f82dfso3655230b3a.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747866864; x=1748471664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dU3iAcSQrpRQtiTX04EuYFPrLnsx+BhMT5SxU3B5tJI=;
 b=PLQzcQEYq4HE5yoJQGchMGBDTrbO8fpnN3kGUQlsLHFJLznPaJcbNNiNBdkREBD6Tq
 nIWJIeeK93GyAMwt4QKw+DCC5hYTGPgx84m42SsRmuJ7X3+SwUJfGrr2uE+/a5i9qUyD
 4MpWzdLJYelc4lZ0ztuqM9LH+YBwpbTLgXonj7O1qyExHz+qjxh72YFH1g3howHUXnTJ
 WV7cnIDtnEe8wJVOqoiF5huO+L6duY3XfjeNT4OpmmAY+qcEnRhnFiMUyP5CknlwvD1Y
 +J+NemgDZ1GZm9ZiC/+/6bVYCPxur5NjP3Cuj9hgnEEVi5zEZWQiVZ5ZGFlXixlyWaZn
 x7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747866864; x=1748471664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dU3iAcSQrpRQtiTX04EuYFPrLnsx+BhMT5SxU3B5tJI=;
 b=XXGOwgFssIflihkmvNq1c55UbEYdvOjpCSDqqzBqoAZeUFyCZO9GOLi43ug8GRI38U
 28dgm+0A16fCytwgA1OEi04nUxKeqjVgI8OT6EVplimMwxoybwzzbDq3zO9EKFPtGUBu
 awovAVdTi0NmiadGC7KtsrYkbY6nsDJw3AXKXQgmhyEOHgoEEtRHSdI1O9feUtXrlxz0
 HFVKXloVvyzE03k97W5tbekv/KH0yrXhkpSSxosTxwWYpEsl1MidtRmqgMmzZUYlZY7l
 Md/D8xpKPOa46AUlTyuLyomaPFiTtTYwSHoCgafdUncP1SLEaUqXrHJ5As3hUwkKF0iw
 WkMA==
X-Gm-Message-State: AOJu0YyaOmefzg5y1c/n8NFCbkXBnKopKxwqLYiB0U/wOWUAhdarmbIg
 UqcakZUqLloJALoUbUO9Eko5yfrbZJTgKseIVFgwN6Xm2A2+WTOeVj5enLpc3WdWhy3d2HuoGBZ
 VgOvp
X-Gm-Gg: ASbGnctQrt4IyrNJhUPFFSGCL+jdwDpyZ/i93bYjp0keSDICFxPIMY355baVPH/rOga
 UOmSETLOvBDPIaxNe/7C5/ljTDsHqTeHoxpRpAPkTiobd50/P1gZ+dzRvUg6OHdfHVh3CC41uFD
 Rsiknk6wYxwfMKejMSvA3f/H6fpQQebAtXBWezUfVIpHhXyrhs93yWEKjbc7WNrlP67yUXyxXxq
 q9SSFiJmZCG0kGBwOg9xn10cfR4WkaP21pJjtm66bhfjBncP3Zp+fkXzdA2VnZij8VoEBOt+tAO
 3aaoC1NBMD1UlGKI3eckSvTrSxnxFBk5xD/Dg+7tyNBUR8ptHzs=
X-Google-Smtp-Source: AGHT+IFp5eBquDdukOCBcywTwzFqFUvSkWp8GWgZfqUr2/xuGK15to7XhX+/j1winXGNyPRUvhRFQQ==
X-Received: by 2002:a05:6a20:72a6:b0:1fe:5921:44f2 with SMTP id
 adf61e73a8af0-216219382c2mr31117037637.20.1747866864573; 
 Wed, 21 May 2025 15:34:24 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf5a31dsm10165224a12.2.2025.05.21.15.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:34:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 3/7] target/arm: remove explicit dependencies listed
Date: Wed, 21 May 2025 15:34:10 -0700
Message-ID: <20250521223414.248276-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
References: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index b404fa54863..2ff7ed6e98f 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -28,7 +28,7 @@ arm_user_ss.add(files(
   'vfp_fpscr.c',
 ))
 
-arm_common_system_ss.add(files('cpu.c'), capstone)
+arm_common_system_ss.add(files('cpu.c'))
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
-- 
2.47.2


