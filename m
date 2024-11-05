Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AD9D1267D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8H2H-000373-T1; Tue, 05 Nov 2024 05:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t8H2F-0002yf-74
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:43:43 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t8H2B-0003Qx-NS
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:43:42 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fb5fa911aaso78954341fa.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730803417; x=1731408217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gSsnXOF1ME9BHz6sGossYoKzXBZecSgk6Ro1rEK1Uwo=;
 b=TiepQtS+eURTgfqOURngyn+gjrV5bGR564chwO68+olQAWjzytRfNMN4Uspal+UZPi
 PdC9QJtvcei8kiyMadqkqvUKCUKKu1KYf+W9JKd7+z4s5CDDHRJdnIA9rgCOfhIhQbzL
 kYKWN+qHKGHlQFCkiBLvhYhibyu4lQkY1osbklxlepneGMEZMzWmugPSVQ59wNLkpaUN
 hBqNBRiGTKYHhcs0jvJrHyy9LCWK5glmnjttX2xOxFWa5jRgoZTFNOHwuXf45fOl1LKh
 KyXBYyhpWa07HbvcYrU85hI+ia1B0ryT19mLsTIqbqjCRb2O/KvFI1bwERle1ULj8rXp
 /+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730803417; x=1731408217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gSsnXOF1ME9BHz6sGossYoKzXBZecSgk6Ro1rEK1Uwo=;
 b=dzZGP9muoIoNHVH1uNTr/QA8qvwsg9k3rCKlCoyuC//aAM1sODWXOtXFHGUmKGobtZ
 +BTvenuNndTasZDdK3U7mMGBuMXX5QXE1hW3fKaotaMR6KO4/A1rOZAeYhES9yfG/EF0
 MAdjindKQSeSjbKP73qDYGgDqRPELZZYmAhKBgHF5JKl2V57NuP+Ox1wDF9CDiPtEV3p
 MAU8HA/k7pynM5SGd5ukKcXRpOAbKHHMTetlT5RqPExxOFhOfa/NW1i/K6GWFR2Tp2wK
 2//8H8je0sAUYelRNy8f4y8X6OJ0wTT6jVOSBa0/Y41mlAE6SpzMGGjiomvIG4BjV8fi
 r6wA==
X-Gm-Message-State: AOJu0Yxi4ITqxykBTb86Ao2EIVvM2V+BHi1vj4ebmu661c8zlA06gBQf
 5N/MeInbqXgxG8XXoUJ57AgvH8m8XcPxugbkSddHdsQIMZ7fdKBa46H+eCaq1v8=
X-Google-Smtp-Source: AGHT+IElLr4hsNY27qMYGiW5Zy+IR5P9fSYi1noH/Ihq5yuXSOFd98FpTN/8hEnN1DrgCPksl96s2A==
X-Received: by 2002:a05:651c:2123:b0:2fa:c0c2:d311 with SMTP id
 38308e7fff4ca-2fedb794b2dmr122116441fa.5.1730803417248; 
 Tue, 05 Nov 2024 02:43:37 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb18140a6sm114899666b.195.2024.11.05.02.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 02:43:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A21F75F882;
 Tue,  5 Nov 2024 10:43:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 0/3] final plugin updates for 9.2
Date: Tue,  5 Nov 2024 10:43:30 +0000
Message-Id: <20241105104333.2534823-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
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

The following changes since commit daaf51001a13da007d7dde72e1ed3b06bc490791:

  Merge tag 'seabios-hppa-v17-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2024-11-04 16:01:23 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-plugin-tweaks-051124-1

for you to fetch changes up to 55c84a72aba4a9406320943e6348bb120c2df08f:

  contrib/plugins: remove Makefile for contrib/plugins (2024-11-05 09:13:51 +0000)

----------------------------------------------------------------
final plugin updates for 9.2

  - fix a warning in cflow plugin
  - replace Makefile with meson.build

----------------------------------------------------------------
Pierrick Bouvier (3):
      contrib/plugins/cflow: fix warning
      meson: build contrib/plugins with meson
      contrib/plugins: remove Makefile for contrib/plugins

 configure                   | 18 ----------
 Makefile                    | 10 ------
 meson.build                 |  4 +++
 contrib/plugins/cflow.c     |  6 ++--
 contrib/plugins/Makefile    | 87 ---------------------------------------------
 contrib/plugins/meson.build | 28 +++++++++++++++
 6 files changed, 35 insertions(+), 118 deletions(-)
 delete mode 100644 contrib/plugins/Makefile
 create mode 100644 contrib/plugins/meson.build

-- 
2.39.5


