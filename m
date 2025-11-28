Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA84D116E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 18:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP36s-00031R-MO; Fri, 28 Nov 2025 13:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vP36j-0002yp-7R
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 13:22:13 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vP36h-0003A1-KU
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 13:22:12 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso21793365e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 10:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764354122; x=1764958922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VH0vJM7+U/YI9Ekj72lGuEmq3CIiJueJTkyD77UU3KY=;
 b=L38+/yIjora5GciiSYlIibxjlCEMRwuygoSc1FYoLqEQM9AAE0ag35JuPxp+9iD/z0
 19GmWeSzYr9xPQEtynJ1EKgOb70zmvWKOgf+kf7m3rNqs3SYSgeDRenGdV9DI1AMz0RQ
 FmpIqoNxkO0SbZzYzp/5o2ABqV0zEFntyoemSiTHyPiOmovObSkjjYjNMLerfB3CDsnz
 DyekNRxK3lrwjP0zYLbn4GSeb2/KcHMafcQxDUN5BALkdp176HhOUML2Jq2NcOyEZv7t
 MUmkKXWzq63jSpJ3Itru6uyufUXKj5sZTenlrP/vxA/iIuGIWrNAqttK+BgR8ij3VUhq
 jTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764354122; x=1764958922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VH0vJM7+U/YI9Ekj72lGuEmq3CIiJueJTkyD77UU3KY=;
 b=Gx4kKVb3bRmi5xAw218POuy+pPfC7ebiEZ21oZZovwOtrEyMw/nAWph49h6HJWft9G
 JxaTYnhtyHVZA0BhA/om33VTo6Gd1OS066D0yq4aLwQFUaaYAz7bB4QXED+riCVlBD2w
 of5cIF0jDiXm+0jJ0VjhLUG7sqzlpVUQMsX/DrmxpLaht4PAIJcJ6Zp56f+WPUdxkhl/
 MrWyYhmotKdm1X4iYwS2uZWmwsAISu+VTk9ROKbfFISvbqrcl5R+4AwJ3tAzaHU3vXUb
 Rs6GCb89SpifggPxANBkbulapRzXZKI6oZmvCDpsfBu8SjRi+1wuITDhKWuq6gwpfunX
 gK0w==
X-Gm-Message-State: AOJu0Yxfx5xdPF1CaF21X80FskpTKWhf7n4QsBzOdWyKfUly6yo5tjKq
 FYUvmuUReaACYgSdEnR1zpiqchTN2/m1rdYpbug2M3WBX7RnnzYPPL8ujO7B0hUh2Mg=
X-Gm-Gg: ASbGncvnBcqrMZjFvijEMmJDzuOw9o9PomZzqNgZwV9N20gff6Y9VgyA2VhsXTDaeHj
 3oNAPmQm4rtE7yJB40HBf+OXrZoz2TQOaMmQ6hgrUpbobZFwMnDBQAsulyO6mHc5a32EKicvV3J
 ohKi14/6/T2C/uKafmd69HeKvzy5cVkaNeFJ8afWsxYH2WGWyN3XYr4f+X/Ej/Ek2WL4X2viRsE
 VEH9XoIgbJ8xuqMX+E98EG6IbhYnTYhBZt2PC5fNW1gTxtZhVb7w6AM+VFnloH3rWYz1/YbgmHv
 vk7R0E3mmThQ7iELdVcW4agIQS45RgFsuZqVn274jE14t5lqeaAVcULnD9uVYUkJIggVNir2qze
 qthTr1S1vFOsbdF0PuzsYkA5dWEHnlYWkZ98qLpowLLaDKnxV6NIqyOTnOZKkMsSJZVwi2jWXj1
 Vq6enIHdVu85w=
X-Google-Smtp-Source: AGHT+IGwQJXIY5Tn0QHrayyPs33RbZQDd4nmKhgxwHyIO8N12MGjtkM3XaPNY2nbJ0wYXMZzIqtCxA==
X-Received: by 2002:a05:600c:1ca4:b0:45d:f83b:96aa with SMTP id
 5b1f17b1804b1-477c10c92d8mr349981965e9.7.1764354121967; 
 Fri, 28 Nov 2025 10:22:01 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a310sm11205270f8f.26.2025.11.28.10.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 10:21:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BF1A95F7F6;
 Fri, 28 Nov 2025 18:21:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] Final fixes for 10.2 (build, docs, dockerfiles, plugins)
Date: Fri, 28 Nov 2025 18:21:52 +0000
Message-ID: <20251128182157.4125745-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Alex.

Alex Bennée (5):
  tests/tcg: honour the available QEMU binaries when running check-tcg
  tests/lcitool: add bzip2 to the minimal dependency list
  tests/dockerfiles: transition debian-all-test-cross to lcitool
  docs/devel: update build environment setup documentation
  plugins/core: allow reading of registers during discon events

 docs/devel/build-environment.rst              | 145 ++++++++++++------
 configure                                     |   6 +-
 plugins/core.c                                |   2 +
 tests/Makefile.include                        |   9 ++
 .../dockerfiles/debian-all-test-cross.docker  | 122 ++++++++-------
 tests/lcitool/projects/qemu-minimal.yml       |   1 +
 tests/lcitool/refresh                         |  43 ++++++
 7 files changed, 222 insertions(+), 106 deletions(-)

-- 
2.47.3


