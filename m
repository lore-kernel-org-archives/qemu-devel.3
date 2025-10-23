Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC27CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBu9N-0000cl-Qb; Thu, 23 Oct 2025 08:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBu8m-0008Jr-SS
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:10:12 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBu8j-0005Ei-Sy
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:10:00 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-63c0c9a408aso1187833a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761221395; x=1761826195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WoFx5hXFMOkcmrAtx+7KR2kUN/FtJR56Q/9V8JNHu+w=;
 b=WbYv8/0q7KJveNWKoH33qWfpZ5A0/76tibihVOlhmmv8xEFXfCTtcH7/SVC3HL2mHI
 FVluAi1W0jpBJOqWcuCMR2CI6o6OS8ETRj/6KlcqtraBK7GrKiNJjJPpmTRchMdsnxNE
 7+EpAEOKKl1GrWbmXETduajRRKfWSUQevTCkvCLzbmnsb3ynewiQkwKPsHmx7L7rkUCL
 UYMhy6HfvbTFtE8a6LYU8iJNsQUu6HIm3vrVQV37R2IfHv1F3UUfoOxABmz67jahSw/y
 yIzp2MeJ1YWXmmbnIo/vLWhKl+N6NJJYPPe14tz1O4Q7/BY4LBIyE45SxhOmw6W1iOLj
 /4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761221395; x=1761826195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WoFx5hXFMOkcmrAtx+7KR2kUN/FtJR56Q/9V8JNHu+w=;
 b=Kp4YI8kgjZxokBns/CTtmEPIFpksuH9AFLBX4eLBFfN8tTxbEkvIMqasrumm5wCr5A
 yUuNhwFHYdqLnLvJfa9p7R4Wx3ly9zwBDyjRJwDx1ktdMfBNApRpSzhc93xmyi5gNW89
 3KRXPhgWNgXm23j/LgSZCWm/nNPgURsO6H6/rFftPye6S1LY7ZZsDmXNLaWmM7krPAQ4
 TuUbDJi+5YsltsImjL8hOYrO9yq5DWjV7PnBvOXunta/YohPQvvjSJaRkjpbeI+MMXfJ
 DHAS2Ga/RTj+VBK45TPA6QJs60gYukiuMmkFFYuAo2zbADlEAnFOe9Xcrmc8fS1NnhQm
 wDcw==
X-Gm-Message-State: AOJu0Yzcze8kqEeL+DxNJfoq7co9fpcTVoj+KWfx47QZ3phrqWBBpnDR
 uCdIDFenyKlCGZvpE2w39r7NvNS2NawSPknXwh0dRGZmcVRGFdYEiSBOpjo+BadTtW8=
X-Gm-Gg: ASbGncvjFGYqL47tsP2KEPwss5CuUPwGc13WxpzysTc6pnzYu5oWLP5+GIh5E8gUE9f
 gB2gghn1j0PnnaBbKmCsCy86e+XO+YT6fq1D6+hqHQQKNzvwguSrOfrwNQY+s4Zr3m4cBVil4au
 kniHLj1Tx+SRk0nHr+Iqdj8gzddylQOHhekvK2+zaVOpnQs3PIC5QLz8iAMYG5AIKGwWEs/+Yqv
 v9p6Sib2oHil77Vx2JvUYl3E4iTnYMt2SlMCT8dMoW5ym243MAmOHBsWN85RLv61SgtyTvBj0ev
 B/AYO9pClWLU9cDQO0YviXDP1wBxtq9SyASGO5NsRRCKmHp++Sz6vzQw4YJ1MnK7gGxeh3J62pJ
 TIjTcKE21qBE4LOJEApA/nqD/vRbn3iwk5nlxsNFNhxYXj/+nCNUyvtaaMNPfFoeHcc84xYRoYG
 3PJJXtwtknUYg=
X-Google-Smtp-Source: AGHT+IEIxRce7czzelmwy7/KdT4D4r3znYuSIJF/oZfYhRtY39H9jXu8ccf0g2Gd6/RqzGf0TQ41hw==
X-Received: by 2002:a05:6402:2810:b0:63b:e668:b099 with SMTP id
 4fb4d7f45d1cf-63c1f64f121mr23861531a12.2.1761221395353; 
 Thu, 23 Oct 2025 05:09:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e3ebb3838sm1532747a12.4.2025.10.23.05.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 05:09:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBEB85F7F5;
 Thu, 23 Oct 2025 13:09:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/7] testing/next - more custom runner tweaks (ansible,
 ppc64le)
Date: Thu, 23 Oct 2025 13:09:46 +0100
Message-ID: <20251023120953.2905297-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We have a new ppc64le custom runner box courtesy of OSUOSL so I took
the opportunity to clean up our ansible scripts. As Debian and Ubuntu
are practically identical we can reduce the logic to "does the yaml
exist" for the given platform.

I'm having trouble getting the box to run at the moment but the
clean-ups up to "tests/lcitool: generate a yaml file for the ppc64le
runner" are probably worthwhile anyway. The final commit that adds the
runner can wait until things are stabilised.

Please review,

Alex.

Alex Bennée (7):
  ci: clean-up remaining bits of armhf builds.
  scripts/ci/setup: regenerate yaml
  scripts/ci: move build-environment.yaml up a level
  scripts/ci: allow both Ubuntu or Debian to run upgrade
  tests/lcitool: generate a yaml file for the ppc64le runner
  scripts/ci: modify gitlab runner deb setup
  gitlab: add initial ppc64le custom-runner test

 docs/devel/testing/ci-jobs.rst.inc            |  13 +-
 .gitlab-ci.d/custom-runners.yml               |   1 +
 .../custom-runners/debian-13-ppc64le.yml      |  40 ++++++
 .../setup/{ubuntu => }/build-environment.yml  |  32 +++--
 .../ci/setup/debian/debian-13-ppc64le.yaml    | 134 ++++++++++++++++++
 scripts/ci/setup/gitlab-runner.yml            |   6 +-
 .../ci/setup/ubuntu/ubuntu-2404-aarch64.yaml  |   4 +-
 .../ci/setup/ubuntu/ubuntu-2404-s390x.yaml    |   4 +-
 tests/lcitool/refresh                         |   1 +
 9 files changed, 208 insertions(+), 27 deletions(-)
 create mode 100644 .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
 rename scripts/ci/setup/{ubuntu => }/build-environment.yml (63%)
 create mode 100644 scripts/ci/setup/debian/debian-13-ppc64le.yaml

-- 
2.47.3


