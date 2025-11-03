Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5B5CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwm8-0005Az-I3; Mon, 03 Nov 2025 10:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFwm4-00059f-Ha
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:47:17 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFwlx-0002hq-3E
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:47:16 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47754547a38so640285e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 07:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762184822; x=1762789622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=aFk7bpxHsJh7x/4ni0dX7itVP3R/xFfC1vregJPgVow=;
 b=ES6vhVU+e7jENIdF/+ogRYBfvMo1/WL5yG16H+2nA9BjOeW1XEVqqdSngz+Nz1erB+
 3tghF6oMujfzSSSfojtOiDLX/J8cH/uhewkDWzTPjaBNGSqw2SGoUdtXdEVqbCCr2Wvq
 NRVaG2Z20bKEgE36WG+52gai9H/QV2ToLfseL6cqCMvNtg4FXDYxVdV0mG+F2+99xQoZ
 NvOLmFb4Yuz/hXT4lyBLpWzyHPLrEvTfvgYL0Lm8vm0QywJLLY7svDclgsN/lHW3GcPY
 e09eXYmuamDUf9VYkSPGfoNP9TcAldu7KV5IhJ7HmWEw8QjglUFirqAeZFeJWWdjqNLt
 XWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762184822; x=1762789622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aFk7bpxHsJh7x/4ni0dX7itVP3R/xFfC1vregJPgVow=;
 b=VhRUWfw3DM1f68TC0oMpj54y9Bf+oMWPt37hNl5Mlxo0paghXjjqzkyrtNWbfHCmqa
 /50IuXEZxet9Ztnszbq+V6pWI7bFuhToTP7K6XoLLNbs+Sy8vRTHXkp/ZoRAQShLzFZo
 R5twhCeD4IOqzEZlVSxiOR7F4LTqRLATfG8Of4lV2IgFyPDL17cp0ta34UK7hY8o03nN
 xnd/FUQif0MXOoZJeOoe0GunK2UMj6peQadXT28H7lPvLGq3h5PMHvu6k4tHp0Xug/JA
 TfWqdFzid4TPIQUIzhegG6mGLXv4AUpSmCkroHNJmSOfy/xZbICEW/ZVFtHoIPZE1YJe
 23gA==
X-Gm-Message-State: AOJu0YzUsicWO6rSxinstyrCcg0g8caX2/s8AbK+HhYL3tCZUHHtPdh7
 pmeOGQYI36TO1W47BaA7imkSX0JN1zqSmRZP69wFhABc6EXDck/Nce8EdIR8aI9Nijj0oi/KP9Z
 K8Gid
X-Gm-Gg: ASbGncven7mknePEmXD8Kr/fLGV46eLKHaY6lkx8DYitGVGjmroXEKa5QqyEKYaMTLL
 EHiB6wudvYJRizw40QgKuogBIE9n7XKL9iOWLs8tM57f2ULJ38yLBYYF1pbk6DGAaAe5kkLM9pv
 /QXhRq3uMUsNKRclDAPmyTfNlSvHfXpkK9inreVsV44b0Gzo9cMadxRVZxjEi/oB5XaaInvw5r2
 oxiWjRAwHllTo9ufVjF3wwccrecz08sI5ZEZC8+ZSBp235m3jjhAQvPpUUBXqXEk8d0JvmfeuP8
 ILAFeREF67vY5DmGwwTXd3mKxamSZKPYZvKtNnA0mTuH0o01/wC/nHsXf92CshuM3Okwok0WD2L
 60FZPUx/A9aZxp4SWmtuRoA9g0Cd5EGAa+Leiwz/M451rB5kLQ8yVIrWCPqb02GeJ3Uxwn5qX85
 c5WwTudg==
X-Google-Smtp-Source: AGHT+IHW5jz71QaPbg0QldupJcnK+iL4uPG9ulmKHDE73yyCf0xlecmB5cBYIz5DR0qkosnJbvuPvg==
X-Received: by 2002:a05:600c:190e:b0:46e:3cd9:e56f with SMTP id
 5b1f17b1804b1-47730802ca0mr121201685e9.6.1762184822383; 
 Mon, 03 Nov 2025 07:47:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429ce6b0c16sm10504156f8f.38.2025.11.03.07.47.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 07:47:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] target-arm queue
Date: Mon,  3 Nov 2025 15:46:57 +0000
Message-ID: <20251103154700.4126379-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

One last small target-arm pullreq for before softfreeze.

thanks
-- PMM

The following changes since commit 53b41bb78950912ba2d9809eef6b45e4df30c647:

  Merge tag 'pull-target-arm-20251031' of https://gitlab.com/pm215/qemu into staging (2025-11-01 10:52:48 +0100)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251103

for you to fetch changes up to 5848d2c3a6c4cc1b37234db462b1b36bc0a18bf4:

  docs/devel/testing/fuzzing: Note that you can get qtest to read from a file (2025-11-03 14:16:53 +0000)

----------------------------------------------------------------
target-arm queue:
 * allow KVM accelerator on imx8mp-evk
 * docs/devel/testing/fuzzing: Note that you can get qtest to read from a file

----------------------------------------------------------------
Bernhard Beschow (2):
      hw/arm/imx8mp-evk: Add KVM support
      hw/arm/imx8mp-evk: Fix guest time in KVM mode

Peter Maydell (1):
      docs/devel/testing/fuzzing: Note that you can get qtest to read from a file

 docs/devel/testing/fuzzing.rst |  9 +++++++++
 docs/system/arm/imx8mp-evk.rst | 19 +++++++++++++++++++
 hw/arm/fsl-imx8mp.c            | 34 +++++++++++++++++++++++++++++-----
 hw/arm/imx8mp-evk.c            | 20 ++++++++++++++++++++
 hw/arm/Kconfig                 |  3 ++-
 5 files changed, 79 insertions(+), 6 deletions(-)

