Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F87BD29FB2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFK8-0006ug-Ut; Thu, 04 Dec 2025 14:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFK7-0006ts-GY
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:07 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFK5-0007KH-TI
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:07 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42e2b78d45bso657764f8f.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 11:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764877744; x=1765482544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PUqsZxLf2BjAdjMRP1ceKMEa7XldD1oT0pbBwWuZwq8=;
 b=Zn/UKxC/hHURtiD6fMh95XAUK3VkBMSJb5M4nlQQIFyvh+CznOwEp0XXOla2ZCUkIc
 Fjz9/l7QrOjylXe9lCB/cCm+k/VXRrMaO85PDxMqo19WJaG9JJHblkmEUQa0I+fAyUlJ
 o5N9OFif3CvRoOn1Ft8cuAyIWD+ZC0fO/YwHI+rwkJrXmmSAoZ1mZuZMJsln/rOVSR4/
 PP5NtlBSq0UWX1esHk4zGd9VgZ9FrFDSeDwqCRB1Q2o/XY/yubsEhgthLk2bZXZI7eXh
 bnwg38Mcuy9Z0OGrE6LAcaR6Rjw4JMUZSwCxS7etG0gY9ksFxI6sjrU4+E8Hnb+l/j5j
 3v8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877744; x=1765482544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PUqsZxLf2BjAdjMRP1ceKMEa7XldD1oT0pbBwWuZwq8=;
 b=Z+Li6km2M205LowwJ0Xgh3c4N1fDJu80bGwZCkN6t1NyLLZ4hlbWILrMlKlPB/o49W
 vWDkTypGk1GvdQiBjRGSf+uD670sIcsNCYnnmpVIVjjrJuItr10GLe97ABM1K6cItc/W
 P2fQHOXQHs8kFYyi/xu3xDl2xsXLYswNf92Cb1u/2MyuSN6GtmBZqkfzw7QrQZHZUOOU
 A7+3Ab+PvHQBgDXcJfjTzw0SOD4zbAYHxDPEdK0bWc7wKQss50TalCboMw/XPmXPEyoZ
 dd/m7Mxp9hNcnvm81ZcpMYcJ6FC8HpwOYVFbYz0RnUBgICRyWAIyzECYSijzVVZET8f+
 CDVg==
X-Gm-Message-State: AOJu0YxvcuVPjYEYOXJVNqyykXiKfuPLgCVl7kdmhn3FKCl2uz8TQnzZ
 GkLkJlhKR7LcBvfBTWcxPu+7nOQ/uXlYIA15HWmUtUVBLx//2kNdcVZmkZX69Z6AyAE=
X-Gm-Gg: ASbGncuUV081W70A3eOfSPYlXGh7yRjOqcNnyW4YxXcmR+VoTZfgC7DtPu4ZUYcd+Aw
 xk9jGcx4LjNNN0+Tj1XEjWYr+ZGSTJsxXunI2yorReaB28KiwEllqiixy4nW6ZIt053EUfQHwUm
 qIdf8j01HxA3ldnXRW9oPseSsIjNs0RuvHJFUuR99dFTzR+WvKknRn0V+ss4syxp+vN4NFqWda4
 fF1Fr5RZmTQWX/DR8lxrnSCgXBXtqj+r8wSUdJ1jwX5owi4/fuI2uYp6VpWQknJFN/haoKO1fVz
 AH5UxjIM6vxhW7pS1bPOz8AOLu3JqrOtUTpf01Ge4uocw5UqnyN6v72H4FJ7yeDaH+H28rUP+Zs
 u2aku26KbsOJdofX+OCz7yO9FrObXKdQWYp6aka6w3ykawmB9PeFrlyDPrm6UAYC3aIEJ1KqlsT
 DuDF7uLHMmhv8=
X-Google-Smtp-Source: AGHT+IGnbAoHgvgLZBBY2ZkNbI/MuotSWRHue7dVTEKYh8NbLNN7cbd0Mqpat0eskKJA/BnIugEddw==
X-Received: by 2002:a05:6000:24c5:b0:42b:3cd2:e9bc with SMTP id
 ffacd0b85a97d-42f731c329cmr7556561f8f.39.1764877744152; 
 Thu, 04 Dec 2025 11:49:04 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222506sm5579163f8f.28.2025.12.04.11.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:49:03 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A27CD5F7E9;
 Thu, 04 Dec 2025 19:49:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 00/11] Final fixes for 10.2 (build, docs, dockerfiles,
 plugins)
Date: Thu,  4 Dec 2025 19:48:51 +0000
Message-ID: <20251204194902.1340008-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

I'm on the fence if these are needed for 10.2. There is at least one
bug fix (plugins) but the build and documentation fixes can easily be
punted to 11.0 if we are feeling nervous.

v2

Well the list grew as I fixed up the issues caused by the transition
of debian-all-test-cross to lcitool. There is also a typo fix and a
tweak to one of the custom runner jobs that is no longer needed.

The following still need review:

  MAINTAINERS: update the custom runner entries
  docs/devel: update build environment setup documentation
  tests/docker: drop --disable-[tools|system] from all-test-cross
  tests/docker: transition debian-all-test-cross to lcitool
  tests/lcitool: add nettle to the minimal deps
  tests/lcitool: add bzip2 to the minimal dependency list
  tests/tcg: honour the available QEMU binaries when running check-tcg
  gitlab: drop explicit pxe-test from the build-tci job
  gitlab: drop --disable-pie from aarch64-all-linux-static build

Alex.

Alano Song (1):
  docs/devel: Correct typo

Alex Bennée (10):
  gitlab: drop --disable-pie from aarch64-all-linux-static build
  gitlab: drop explicit pxe-test from the build-tci job
  tests/tcg: honour the available QEMU binaries when running check-tcg
  tests/lcitool: add bzip2 to the minimal dependency list
  tests/lcitool: add nettle to the minimal deps
  tests/docker: transition debian-all-test-cross to lcitool
  tests/docker: drop --disable-[tools|system] from all-test-cross
  docs/devel: update build environment setup documentation
  MAINTAINERS: update the custom runner entries
  plugins/core: allow reading of registers during discon events

 MAINTAINERS                                   |   7 +-
 docs/devel/atomics.rst                        |   4 +-
 docs/devel/build-environment.rst              | 145 ++++++++++++------
 configure                                     |   6 +-
 plugins/core.c                                |   2 +
 .gitlab-ci.d/buildtest.yml                    |   4 +-
 .../custom-runners/ubuntu-24.04-aarch64.yml   |   4 +-
 tests/Makefile.include                        |   9 ++
 .../dockerfiles/debian-all-test-cross.docker  | 131 +++++++++-------
 tests/lcitool/projects/qemu-minimal.yml       |   2 +
 tests/lcitool/refresh                         |  49 ++++++
 11 files changed, 245 insertions(+), 118 deletions(-)

-- 
2.47.3


