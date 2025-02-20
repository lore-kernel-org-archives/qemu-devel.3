Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9294C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1Vo-0005lK-Tq; Thu, 20 Feb 2025 03:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl1Vn-0005lA-AI
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:02:23 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl1Vl-0004zg-4g
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:02:23 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43994ef3872so3223505e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 00:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740038538; x=1740643338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lO29zjEhlgqAi2HWARIys8eJMBOQ5ZBkoeYW9tDGzQA=;
 b=P2Dk90wU+2PbOAhh2rLJdE6z9WEfmkEvp9Xpwpgl6p+EA3FKHYde1G8SELxjX/GPyY
 Tx8n7JQDk3FnqxesHMDGGoGEnojaOlihJ/5fEqQVstz9DF7kab6N0ZVuaxmb0iWdO1Gz
 ikMeiJshbZn7njNwxSD5jaaKTnfUAQDxyQysdnT14NcpQRuRwFZTe4qOUmhW4yR8oNtN
 h5xxU4HmUdtuqwRTnNxf8fwvgnLK1j8NugpGsxcRoSg3Uz+uzOAPt/i21nSHJ5NAVWJz
 iGQjhMeXp1fz+rWtNs456K+J4V+1dUf5yxww9RWgSyH1kU3t+xYKxyt3KKUrxS7GAisI
 8EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740038538; x=1740643338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lO29zjEhlgqAi2HWARIys8eJMBOQ5ZBkoeYW9tDGzQA=;
 b=A/NVXKyQMzpclOOnemnOqj8S0y0SOxsNR88Tw03+DT17bn+EZuIguM/1gVUYhe226y
 TOBSECaIj0fpG9UvD5CyVzfBZawbsStsyyXFewtW43su12x9sfbBLwrtnqGQATIP6fo/
 2+z5NHhycJ7+lJDoWad3J37tzbmkw6brxnzoulIyCqYCKa1VXQaGRXCGy7gq2Gz+Tlvz
 9NMRfAwiqr2LIGu7BD5832b67K8LiQYZCvrYi/Z1PjJYLtAYGpyZ9Lpt2yF5dDJtl2wn
 SY2y4DMsHMGRr9SNbLZA6bQIBJUhb4gIfGOJU1XIFbDdnielVMQ9ptNQ4k1Z8++fexos
 WPmA==
X-Gm-Message-State: AOJu0Yxu08K44lS3U7UZAxpvEWhAf6GPkAVbAgst4rIawqXUdYijHJ6y
 TFM5ghUzGsMCkbmZUMjgLFbk1A5zkk+gbvzsd5rFiznn71UN58YBX9ODc+LduV3lmMQ63JhIjlD
 W1Zc=
X-Gm-Gg: ASbGncvMVYrf1fymVj9bSakwQgAhsV9dYen1Fg1h++vyblL3e0TSjCaIg86EFqM85nt
 QnjEUp7sHpZe/eQHNeCWbDA+71njaThZ6TlCiZnXsCZvGe62KwWu4H7Gdpgdo6keE/iI+L4sFUT
 QF8HS0LPVX356/RRbyJp+JDoEKSESGHyDuvq0i+1tpJHCuyUUX3YL9V4VWZM2+z/2bk+aRjqBy0
 8GB40iV7MyJCL246cj/yOfxgkdNVX623+O8l/GzjgXElu5ityL5Bxys7tjMExLjD2gj9MvgEJMS
 6wPscVwu1vKFX2+fUo3wHz7AWSboQDH9K9JYKd0qbq0vnrlIQD893ukyWkNXnjlzJA==
X-Google-Smtp-Source: AGHT+IGztvpmqgblnb31fv1D9H/XzDSwSA+cOgkjIpbAKtbpyImWPXW8fTD94ikQ8RMAh5Qe6th7Gw==
X-Received: by 2002:a05:600c:154e:b0:439:8c80:6b02 with SMTP id
 5b1f17b1804b1-4398c806e08mr120335935e9.31.1740038538680; 
 Thu, 20 Feb 2025 00:02:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439872b5a46sm101409425e9.32.2025.02.20.00.02.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Feb 2025 00:02:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 0/3] tests/functional: Allow running TCG plugins tests on
 macOS
Date: Thu, 20 Feb 2025 09:02:12 +0100
Message-ID: <20250220080215.49165-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Pierrick kindly helped me to resolve this issue which ended
being trivial (to him!). Not tested on Windows so far.

Since v1:
- Include Pierrick's meson fix patch (adding Fixes: tag)
- Addressed Thomas review comments (config.py, os.path.join)

Philippe Mathieu-Daudé (2):
  tests/functional: Introduce the dso_suffix() helper
  tests/functional: Allow running TCG plugins tests on non-Linux/BSD
    hosts

Pierrick Bouvier (1):
  plugins: add explicit dependency in functional tests

 meson.build                                  |  1 +
 contrib/plugins/meson.build                  |  2 ++
 tests/functional/meson.build                 |  2 +-
 tests/functional/qemu_test/__init__.py       |  2 +-
 tests/functional/qemu_test/cmd.py            |  1 -
 tests/functional/qemu_test/config.py         |  6 ++++++
 tests/functional/test_aarch64_tcg_plugins.py | 11 ++++++++---
 tests/tcg/plugins/meson.build                |  2 ++
 8 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.47.1


