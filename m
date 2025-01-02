Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EE0E77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 10:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTI3Q-0002ZL-0d; Thu, 02 Jan 2025 05:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTI3O-0002ZC-Sv
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:03:46 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTI3N-0006h1-A8
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:03:46 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so118221485e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 02:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735812223; x=1736417023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lsXapPA3Gk5QAziX+SdQxSVqm8p+NaxnEOOojCh6YBA=;
 b=b4wMUukq4yWlFNdGid5ojblWOBY/rim6tF4C+ioYi8TyYUmF9tlU9Yc3aUbDBeRMw0
 XP6S9mUZ87Zm6/Cx905ocBSlcGhboXdfC4FYskdrk2do8UtPAlaWeIfBrxQEstpoqvhe
 Mhzx+OIU5402uZVcpJWDAdANJ1ILgawKKgsbGMxGZenMW6/X5zoY8n0Rh9nx2SJjVkX3
 g89RxRIqNX1oJgES8yXtppSy7HNvtwP+KQOzKXRX605hQNLH2mc1l6ZShTWKlpLp/Rra
 twQCW9D+DE/Gi68IQCwuR9yB3tVgCSw2XCx8y3m0hxvnkswo3dm9Yd/cG/TuQeMOjX+u
 QhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735812223; x=1736417023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lsXapPA3Gk5QAziX+SdQxSVqm8p+NaxnEOOojCh6YBA=;
 b=LQiBAdckcgfV9EAqsOdJIe0w96tQQMas3o7OU1KdulP/7X91tcBVeoGjzOfiEdh0mS
 5Xdkv4MBqVxL3l9jqNtgzD4ZUbKYgNmlvt4V7zEloRiRCIifwr7P5FZcYBQ7CjwWLMDg
 CDI83pJjNOMCCDK1zHC7c3aNU8NFDqw5d4jHEQOG05C6/IwjpbuUVr/PXvPBEpTklgDF
 +Fq8IuSXP0+gOefpJ0jgZtxw7fE2QUEYPgw/OgPzmDIGt9zvvUFCUS09ebiyYAablAPe
 vagTU9bDGqjs3xt3MVy1132opy47/lNMG2BvQGioJ8YWj6TPd4m5ijiL2WpwV1veLH6k
 ibOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrYKdEWIooeyP1AYjDurlXJKYzwFUkra55IPZDKBCqURIHRqZ9L63pt4NA0dSCcqYKll7eIRSEXsxM@nongnu.org
X-Gm-Message-State: AOJu0YzRDlMWQuOH7rpcsFLrSvdnPVZaXsEfwOotdEKBjOYoGEyycIOr
 ZcB0JjfqcXp2L6heSZb+a4n1FXXdDJrWrvy5/+kawwSXsFxviULjsh8b63kwAYg=
X-Gm-Gg: ASbGnctF1V6RPb02j3jHzahZtmXU2YDVq44AOHVnP83niB57WP2RclBFRRY2kc3DaMG
 CzZts3A7skklvHpFIo6n946Fo+AKqjNkrdnCsisMVtOrb2Ewq8oRFQs7Y5QjGQVimq0Xs4C55KR
 4gIikgqaCdHvJShkjuu7kSwmdKW6SBFywRoi6MkPfiAaSHlm3YoDK12OsTyIho4QWbdeXDKB0NM
 2bGLO3xR4m+JKi2ZBDhbZUSJVCrKq4Fu0lJdHK/zocTjLK/AqdYLEhY8W+J0AhgP0RgJJ2PWFMv
 rvwt/lHuL6UP5BYQaTAOdif62TdSyfs=
X-Google-Smtp-Source: AGHT+IFnAu3bSJIyVcz3SUPdKYWFL3KamviLLHCHGquio2ndxHNnOyNekRgflwS1MZpKv2uZOozMrA==
X-Received: by 2002:a05:6000:4021:b0:385:e1f5:476f with SMTP id
 ffacd0b85a97d-38a223f7583mr44466168f8f.39.1735812221938; 
 Thu, 02 Jan 2025 02:03:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea3e0sm452428225e9.7.2025.01.02.02.03.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 02:03:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 0/2] tests: Add functional tests for HPPA machines
Date: Thu,  2 Jan 2025 11:03:38 +0100
Message-ID: <20250102100340.43014-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Since v5:
- Correct boot-serial-test machine name for stable (th_huth)

Philippe Mathieu-Daudé (2):
  tests/qtest/boot-serial-test: Correct HPPA machine name
  tests: Add functional tests for HPPA machines

 MAINTAINERS                           |  1 +
 tests/qtest/boot-serial-test.c        |  2 --
 tests/functional/meson.build          |  4 +++
 tests/functional/test_hppa_seabios.py | 35 +++++++++++++++++++++++++++
 tests/qtest/meson.build               |  2 +-
 5 files changed, 41 insertions(+), 3 deletions(-)
 create mode 100755 tests/functional/test_hppa_seabios.py

-- 
2.47.1


