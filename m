Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BECC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5SVe-0008O5-SU; Thu, 17 Apr 2025 12:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SVa-0008NT-1R
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:54:38 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SVX-0003cZ-5i
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:54:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so1294107f8f.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744908872; x=1745513672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uZ9eXIXnL6BmIju3Xf84AVwZP1NVgL6vTrZkgK7VLps=;
 b=u3WjTVA9atFCPkjifL3Lo5ygS96c99bekh7TA0klE9jPnOKazI4If7G73i0twiuRcH
 KAbk1nqw9DPGdh5w2H0KGohmabI1KLNwmwjWOYJ73F73Md90uK8XFpN+nxciiCA+34z/
 Hnh88eTUeuQ1wUKIEjg9BPz7XviQGjicFmJuyFlY5N94PF0cLtTx/78Q8poDaDLzwaP5
 ECPpjNvUcEMV4z58TEFPht9hMByqaGm+3APzQDddtrTP2SJ9C/7fvzyqio/xVKVLMbKv
 pX7w9z7iUouYRjiuzX7oIzwVSYh2nxsMTgI5OfHZ1gfXWulrcenxuY/n2j9+6KBPFjTs
 oyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744908872; x=1745513672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uZ9eXIXnL6BmIju3Xf84AVwZP1NVgL6vTrZkgK7VLps=;
 b=rGfjuh/xUDX4xf6e9bha4CA63+xBDI2OBZCd7lXkzJ7o9pjTIqapCRZPHxWeNXivY0
 puQPWItgQkQyDnHNrTFJr0d0pqglPnOtcF/ufP0Hk/Ul27BjFpD3aTFnrwQU7Y+u+7ag
 E8uFVL2zROTznCiTa6bCSzxSEoj/zVdiGs+EDy6AGvMhKZ6hHa1rA2Qlqor58PXsq/nT
 3YLTD0vXUd7J147VEXT9XpO7N7DiZKt576EmgGbXTyCE2SggRqUOJny/XVeTJ3nP33Y8
 9SVKrHXXT5s/VZJFUAkouUANWsROFxsPOVYVFsBf7XfP8JlAnA0njofPRjogeuYgROxg
 RoqQ==
X-Gm-Message-State: AOJu0YwoV4fyIQkqeTBeHhWndW4ogA64CFpezKM9EQlkUzZL9cRYsG8X
 N4J/NlLhVu02dT9eXkHakdwV9BvWCj+tp+TWJD+PtQH45hvj2hgnI5nZRRIBUpzNygywjKtDiYI
 G
X-Gm-Gg: ASbGncsqrb+8TsKpo80pbbvjEgpaPaQs1yrCl+I7DNkGPCuoh/mTX5oXvxF24fAqjjI
 TjHfUAorvXdXqcSHzOclBPkql1DBF//lpj2jYYnP6YJfNwkwbdduwm1vkXppgz5YcgH5MxuHRfl
 k/cIiK+YzaKMK2+Kbq6Y/5FLoBodVY2vcPGzOz5A6EZcD1Prle1H+EYtLZHKT6xzjn457vTcJry
 iZkqrpspa1z4pIxJjEHFVoV3+WMgnUpF++wyUkQTF1AILiuBNyCw2zRO97zNZQ8ryuSUGFybo6H
 HHiH95aQifmUNB9005e7GQlBlPU1jeiJ0GkZGwNsGcitS/BITZ7kj4KNMRmbqujS5uykykVTfa9
 xp3BGr4BZeHmleDc=
X-Google-Smtp-Source: AGHT+IH7AYEJNaX0Zcuk74ydHRUdP8jQ0CsXw+4/q96yK7TZWNLIw26K0X2WF0f/7gJDLruMJtEp4A==
X-Received: by 2002:a5d:6485:0:b0:390:eb50:37c3 with SMTP id
 ffacd0b85a97d-39ee5b37b83mr6263062f8f.27.1744908872562; 
 Thu, 17 Apr 2025 09:54:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa5a2300sm106600f8f.101.2025.04.17.09.54.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 09:54:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/7] cpus: Replace CPU_RESOLVING_TYPE -> target_cpu_type()
Date: Thu, 17 Apr 2025 18:54:23 +0200
Message-ID: <20250417165430.58213-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

(Series fully reviewed, I plan to queue it via my tree)

This series replace the target-specific CPU_RESOLVING_TYPE
by calls to the target-agnostic target_cpu_type() method.

Since RFCv1:
- Split from bigger/unrelated TargetInfo series (Pierrick)
- Added Pierrick R-b tags
- Added commit descriptions

Philippe Mathieu-Daudé (7):
  qemu: Introduce target_cpu_type()
  cpus: Replace CPU_RESOLVING_TYPE -> target_cpu_type()
  cpus: Move target-agnostic methods out of cpu-target.c
  accel: Implement accel_init_ops_interfaces() for both system/user mode
  accel: Include missing 'qemu/accel.h' header in accel-internal.h
  accel: Make AccelCPUClass structure target-agnostic
  accel: Move target-agnostic code from accel-target.c -> accel-common.c

 MAINTAINERS                                |   4 +-
 meson.build                                |   2 +
 accel/{accel-system.h => accel-internal.h} |  10 +-
 include/accel/accel-cpu-target.h           |  12 +-
 include/accel/accel-cpu.h                  |  23 ++++
 include/qemu/target_info.h                 |  19 +++
 accel/accel-common.c                       | 142 +++++++++++++++++++++
 accel/accel-system.c                       |   4 +-
 accel/accel-target.c                       | 134 -------------------
 accel/accel-user.c                         |   6 +
 accel/tcg/tcg-all.c                        |   5 +-
 cpu-target.c                               |  76 +----------
 hw/core/cpu-common.c                       |  74 +++++++++++
 target_info-defs.c                         |  16 +++
 accel/meson.build                          |   1 +
 15 files changed, 299 insertions(+), 229 deletions(-)
 rename accel/{accel-system.h => accel-internal.h} (56%)
 create mode 100644 include/accel/accel-cpu.h
 create mode 100644 include/qemu/target_info.h
 create mode 100644 accel/accel-common.c
 create mode 100644 target_info-defs.c

-- 
2.47.1


