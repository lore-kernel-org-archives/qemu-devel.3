Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5275EC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyZZ-0002zg-1Y; Wed, 20 Mar 2024 12:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmyZX-0002yj-9A
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:13:47 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmyZU-00035I-Ch
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:13:47 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a468004667aso777809066b.2
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710951222; x=1711556022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xjVvDV3TsrlgDiYhLHud51GePd1hYOBaGg3ow4DDNys=;
 b=ukHGBE7S+nqWjjE1qSsaIHhb8U0IMpv5cid0iz0bGT2R/JxuI8hp8RFfoigPJHHYQH
 mJMQRVdzN3E7pP3a46P51ZJgaEl0g4uRgdB/ndDpzYGQjd852uR41rymf2tMdz4IrIkb
 UlTy+4cQZNBuGfJuTHpCYKhDHmb6RR0VDT69S7/52rcagMJlm33YezxzfQml6SUoSLXe
 z7pISdx28K3Td5LWTTLPb6Cf9yKTsbCyg17JhFqY8YPMX/cOZJPFjCIyTVRiwvQswXKa
 QZ8ryZv3cl7G4yGye+xzL3y4YviQev7ysP3Cfqn5N09XkebZw6VoQiztIqsL+bf9FK7/
 gUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710951222; x=1711556022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xjVvDV3TsrlgDiYhLHud51GePd1hYOBaGg3ow4DDNys=;
 b=HZIOiuy1Buhx043S+jxzgR1ZZh7KtJarr7G+RHG2PXvk2J7qPEIExLfScZ7pjFtfTE
 NXnPGwEnJozJXotZ9XU7X4VnBmwBJ7wu/tKvUrClEeVrMG5OUPfz/GGL1zj4lhQOWg6e
 P4E6gY7lu+poTXQKTVILvveKE572MWkSMcu7mCiBDBTSpJxyEHa43nSRHk1rIzuWlq7f
 m+sptDwpGMSff+lYTnM4PCfEiKA7SQQX8iRTafPcuYIX/rb3RYE8WRUCr9kiJj6ShYz5
 HivD+7vq3dBCab/g4HnQcwWn6zy9jWZY3CaDFgkeNlz9NYUG9AD362GUiu4SUhkdDdNx
 nlqA==
X-Gm-Message-State: AOJu0YxxfYKc/SQgI8YmE46pcgqOSwbJb1QYKcEL7CLCcCiIR+grINap
 7mspHqv55mw9kc7gf0q478oE1rnlgW+IZTVPJm5OmcUAkqKLjNADpt7psJwTDKg=
X-Google-Smtp-Source: AGHT+IG+KqS46ndZxmmyBoo253EEB5B45tUu+CTg/3n2NN6AUHop1zT+QfIvRjoFGkYSWrUdNUsaiQ==
X-Received: by 2002:a17:906:3508:b0:a46:d47e:eefe with SMTP id
 r8-20020a170906350800b00a46d47eeefemr4278327eja.36.1710951221640; 
 Wed, 20 Mar 2024 09:13:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 qk26-20020a170906d9da00b00a45bb14b1a5sm7395559ejb.89.2024.03.20.09.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 09:13:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F2AC75F78B;
 Wed, 20 Mar 2024 16:13:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 0/5] more maintainer updates (git, avocado)
Date: Wed, 20 Mar 2024 16:13:35 +0000
Message-Id: <20240320161340.391798-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

The following changes since commit c62d54d0a8067ffb3d5b909276f7296d7df33fa7:

  Update version for v9.0.0-rc0 release (2024-03-19 19:13:52 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-final-for-real-this-time-200324-1

for you to fetch changes up to 55900f5dcc3205b87609d9be452c6c76c48b863b:

  tests/avocado: sbsa-ref: add OpenBSD tests for misc 'max' setup (2024-03-20 09:52:27 +0000)

----------------------------------------------------------------
maintainer updates (gitlab, avocado):

  - avoid extra git data on gitlab checkouts
  - update sbsa-ref tests

----------------------------------------------------------------
Alex Bennée (1):
      gitlab: aggressively avoid extra GIT data

Marcin Juszkiewicz (4):
      tests/avocado: update sbsa-ref firmware
      tests/avocado: drop virtio-rng from sbsa-ref tests
      tests/avocado: sbsa-ref: add Alpine tests for misc 'max' setup
      tests/avocado: sbsa-ref: add OpenBSD tests for misc 'max' setup

 .gitlab-ci.d/base.yml                    |  4 ++
 .gitlab-ci.d/buildtest-template.yml      |  1 +
 .gitlab-ci.d/buildtest.yml               |  2 +
 .gitlab-ci.d/custom-runners.yml          |  5 +-
 .gitlab-ci.d/windows.yml                 |  2 +
 tests/avocado/machine_aarch64_sbsaref.py | 86 +++++++++++++++++++++-----------
 6 files changed, 70 insertions(+), 30 deletions(-)

-- 
2.39.2


