Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79129D74EDE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIbp-00049D-Ka; Fri, 23 Jan 2026 09:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbm-00046D-PL
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:57:59 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbl-0007k6-40
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:57:58 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-435a11957f6so1928678f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180274; x=1769785074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pqWj7e9H0VZffi7592hwo9AGcQ1WEnpnJ0TigrnC4EQ=;
 b=BQBHeY6VIIQ9yB9vGtwyLFtIoo/z5eqaPW+jy1UuMXTZwa4CuoOw5ptP0leb0nUtiU
 4U+mgtm//MDXkjbVOewpWg4lnKg0cpcOo+TvbkbacBWhBAhNSji+Rkhol9amlvY39wkx
 ugV+qFuoGzZWgIR8AYT+61z3nJ/UsouBt8hjqVXMLY9Umxx/0qNKJJmb8RY+siRyokU7
 4J9a0DDX6VJ2gbtJyag3M6PRl1eStdGXeJRbMbw/1/HeJ7THxbrcySIVZQO9Mic+mbq0
 T0KzxTyjzNNqyjoDDoWUkzG7QHlMMxCHaij/abopPwcFGF6cCgDdjGNAWx5Db5/z7I+Y
 i3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180274; x=1769785074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqWj7e9H0VZffi7592hwo9AGcQ1WEnpnJ0TigrnC4EQ=;
 b=bHQF35XD0KlY8HjM1UYK6RIN0DHCU3CpJ4Dn17mFzLP8/eIEhEjCABBgzov8jbMfst
 WwE1CP3kXQYyf6pBENjaoaaQcajLe/vqfuy2vNhYNJDRu1QxwhXSTYIbJZTu/rMs/n7D
 c8+jGG2n0NGjmepFcvvJ46N8XkFm2iv3i1LhqqhTC+PlnSZM1hV6IHZzC2EbMFViArEE
 XeeQP32lflbq9PeNULQIzWTr0KVjYBwPTcfadLR3hPpUBcKtNDVreQ1czUyBJxDThWJe
 FYl7KfviN6pA348JznEFmsw80ua6eQn0Fsgbp7WU5pD2HjxKj6zTz0qSYmTdF7IijQKd
 wMQw==
X-Gm-Message-State: AOJu0Yw2dRn4ifYm1slEfSlLvBw1Y/JKlrEm8O0jxFoJGDOafTy2NmD0
 1eM4MVz40WcXCCFfEpBTpOUeMBpTCzwmseTEZSzLJ2Uirn6YEtTjC7W41PVJJ+jSRLQ=
X-Gm-Gg: AZuq6aKMdYSFVWE5B2gnJrWoXiS296XLD8gUP/h8kRq4Vp4jYjjYAUsXMJN28PgQrXP
 PfJTGJzdoQZorwo5cWfO+xq7HN1AlPRRkM9b0/1OgQfactg5hdq6uhbkGpCdUcKxAPTzbcAwStW
 rbpqkIX42U/fT6Do7Wu85u097CVwbBlVmUKJGy32GJQUXFRKIPnoZDlYtH97YLz7DhjBiu9qCSw
 l/rEPeAJBKcv3IfIuBVyR/f5ixydJ6xPKT6C9YbeE8xj0CO+HfZpJ4XMwROr/ZF7J+C3D+1kHhF
 f/BbLmRhOF54E3bOxFg5+5BsuN2aLeKt3wT03R6XZRAzn+sr5vDGfMKbLrs68dXn4DbvZuJJvHO
 mCWt3dzMz+CyHAM6oU0J5qR2HAoM2ShhzTwbdafX62y6B7Bh6J3ubpLrmkKK4pfOpY4A9rihWKZ
 e6DmiCUc1vzqUl
X-Received: by 2002:a5d:63ce:0:b0:435:bcbe:d104 with SMTP id
 ffacd0b85a97d-435bcbed11amr430310f8f.34.1769180274269; 
 Fri, 23 Jan 2026 06:57:54 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm7384541f8f.9.2026.01.23.06.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:57:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 681495F7B3;
 Fri, 23 Jan 2026 14:57:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 00/16] MAINTAINER updates plus conversion of
 get_maintainers.pl to python
Date: Fri, 23 Jan 2026 14:57:33 +0000
Message-ID: <20260123145750.1200879-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I wanted to look at adding gitlab tags to MAINTAINERS and baulked
slightly at figuring out what I would need to change in the perl
script to cleanly handle it.

While we imported the perl script from the kernel I'm fairly sure we
don't use half the features it has and as us grey beards age out less
people will be willing to tweak it. Consider this a proof-of-concept
for discussion about if it is worth perusing this path.

For v2:

  - added the missing K: keyword support
  - added basic --git fallback support
  - picked up a few more MAINTAINER updates from list
  - updated entries for Arm and *-user

I've CC'd the kernel maintainers for the script to see if they are
interested in this work.

While the python script is still cooking I will send a PR on Monday
with just the MAINTAINER updates which are reviewed/acked.

Alex.

Alex Bennée (13):
  MAINTAINERS: fix missing names
  MAINTAINERS: fix libvirt entry
  MAINTAINERS: regularise the status fields
  MAINTAINERS: update Arm to Supported status
  MAINTAINERS: be realistic about *-user
  scripts/get_maintainer.py: minimal argument parsing
  scripts/get_maintainer.py: resolve the source path
  scripts/get_maintainer.py: initial parsing of MAINTAINERS
  scripts/get_maintainer.py: add support for -f
  scripts/get_maintainer.py: add support reading patch files
  scripts/get_maintainer.py: add keyword (K:) support
  scripts/get_maintainer.py: implement basic git fallback support
  gitlab: add a check-maintainers task

Mads Ynddal (1):
  MAINTAINERS: remove myself as reviewer

Pierrick Bouvier (2):
  MAINTAINERS: add maintainer for docs/
  MAINTAINERS: add reviewer for linux-user

 MAINTAINERS                    |  31 +-
 .gitlab-ci.d/static_checks.yml |   9 +
 scripts/get_maintainer.py      | 499 +++++++++++++++++++++++++++++++++
 3 files changed, 525 insertions(+), 14 deletions(-)
 create mode 100755 scripts/get_maintainer.py

-- 
2.47.3


