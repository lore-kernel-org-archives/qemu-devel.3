Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E71FD8FF5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 18:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvgUM-0008H5-MP; Thu, 26 Feb 2026 13:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvgU5-0008Cu-EO
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:53:14 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvgU1-0003Wx-In
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:53:12 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so162504666b.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 10:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772131988; x=1772736788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RMdtgRWA5gqr95DClCoxpPc26n0R06qA62QGanpPfPo=;
 b=lVDBF5rWnVcaeDszs0UTPTnRQg7sW51MsN9JJzqymVixniPaiUdf38l9P4zroaih8v
 UigWHB3NY0B/zA7H12lB7zAuO4Ly874C4yE1hk3UWF+JOwLt3XbScZPxDohH+IVajdBH
 O9ACnvKBDWW274yB3mT5108S5aF5IOkZubjV8ntAk/z7QCHdlNZaBjzbjQfxMLC2tBmp
 BJroWItHigPDwTLtG/U0onkCeXajdJ3MTVEnpjdMPXZpcLJHM08OTUICiS11Lls9q1Dn
 HiyjOEGbM+AJENvYMNooukJw25hKQD12AkXCzndCijH98SeL+Xo0bw28i0uEkYW6oa06
 TtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772131988; x=1772736788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RMdtgRWA5gqr95DClCoxpPc26n0R06qA62QGanpPfPo=;
 b=M3YtLAc6u/90WUI/xcrbn4LFfcx208pCNnkB0TklwC0O8Zdo0N9Rt/4oEUDYkwdoCe
 KnBcp2ZzknRBAC8UunTfQgHiMOlhqb0K7RrToa/phh7Ycocc0GDFVYzHUADL+YV8MDO8
 UixatYbaOHoNA0rIVuxmTgQbdAlXa3yjdnqPQnULQSetAxuty+HIOYMmqVkwxlQl1GAh
 VaMAAyn8jxlJ31BXvzgsokmNhfIIfkILOGHs+qoPgm8blG+yVVdROt0xDMkNW7fBSdVo
 LVVXOOLyRBvtM8mfIBzBNtQ8SlfZKhTh2BW0/F/2UYmiUv0LGKIUaNQmjMfRm5dW6McO
 040g==
X-Gm-Message-State: AOJu0Yzs50kY21c+DyfEGqAwsPGpNM6SdXYAovYuYAtbK77K1iL1e6aV
 UNVThKFC6fAKP8zSK2vMi1/II+MjEI4biDQutxuGWOaq5ck9iPXapLBIbVi6sDioQeI=
X-Gm-Gg: ATEYQzw9ZbUQcMjjgMacXs1j5XAmmTrbWGrJDD/2bEXDBWLN/KeUTACe2cYGlxbhdIU
 WRnPePypSFfU5J1//5EzU8KN0LyLPFNfFKNBG/gkkWkLwI5CMylnpx3ZetkV8L4yAyK1KshtPgC
 GAo+clkn1GuSq9c2lEyR3Wyqf1ZsXA8+loe/gqVtPVQJxlEes+wXAxU1SI4GpdSvuuyzs2Fu9+1
 qfnHf9WIuUDWSCThxkJKcsaxal9VAHQJ+FSudY4SGHHJrcmzxg2bACYbjiYLV8zQm7Yz3noD/Eq
 +QEEnbdXpgwv5PXxKH4ZXh6IcgvSjvfrYSQFBuuttE/eaFze6BWkRhHzO50If/lUKgK5dNaR5Oc
 pxRBpybZMXnYCH94irnntvo4PwkjEXTPOTmOXCFDUi3esRo1o2sL4a6ql2itpYxR+g/SCPowfvl
 O9Mi3FbCbbvqwdyrPMnuZPiTFU9LfrhR89UQ==
X-Received: by 2002:a17:907:724b:b0:b87:4bdb:1061 with SMTP id
 a640c23a62f3a-b935b4b8179mr199578866b.1.1772131987934; 
 Thu, 26 Feb 2026 10:53:07 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ab13564sm85778866b.9.2026.02.26.10.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 10:53:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5F8C55F802;
 Thu, 26 Feb 2026 18:53:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 0/7] testing/next: libvirt-ci,
 tests/vm and vbsa functional test
Date: Thu, 26 Feb 2026 18:52:55 +0000
Message-ID: <20260226185303.1920021-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

While I was looking at Jon's python patches I noticed some failures
with getting OpenBSD up and running. In pulling that thread I found a
few other bits to fix and up revved the image and converted it to use
lci-tool data like FreeBSD does.

I've also added the VBSA conformance test for Arm virt machines to the
functional tests. This just adds the UEFI based tests as the full
suite needs kernel modules and a userspace app which I think I have to
build.

v2
  - added the docker updates
  - added tags
  - fixed up binary and error checking on VBSA test

The following still need review:

  tests/functional: add Arm VBSA uefi conformance test
  tests/docker: migrate legacy-test-cross compilers to trixie

Alex.

Alex Bennée (6):
  tests/docker: migrate legacy-test-cross compilers to trixie
  tests/vm: bump OpenBSD to the current 7.8 release
  tests/vm: remove unused import
  tests/vm: fix interactive boot
  tests/vm: build openbsd from lcitool data (!567)
  tests/functional: add Arm VBSA uefi conformance test

John Snow (1):
  tests/docker: upgrade most non-lcitool debian tests to debian 13

 configure                                     | 10 +-
 .gitlab-ci.d/buildtest.yml                    | 12 ---
 .gitlab-ci.d/container-cross.yml              |  6 --
 .gitlab-ci.d/containers.yml                   |  1 -
 .../dockerfiles/debian-all-test-cross.docker  |  8 +-
 .../dockerfiles/debian-hexagon-cross.docker   | 11 ++-
 .../debian-legacy-test-cross.docker           | 51 ----------
 .../dockerfiles/debian-loongarch-cross.docker | 10 +-
 .../dockerfiles/debian-toolchain.docker       |  8 +-
 .../dockerfiles/debian-tricore-cross.docker   |  5 +-
 .../dockerfiles/debian-xtensa-cross.docker    |  2 +-
 tests/functional/aarch64/meson.build          |  1 +
 tests/functional/aarch64/test_virt_vbsa.py    | 99 +++++++++++++++++++
 tests/lcitool/refresh                         | 13 ++-
 tests/vm/Makefile.include                     |  2 +-
 tests/vm/generated/openbsd.json               | 27 +++++
 tests/vm/openbsd                              | 47 +--------
 17 files changed, 167 insertions(+), 146 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-legacy-test-cross.docker
 create mode 100755 tests/functional/aarch64/test_virt_vbsa.py
 create mode 100644 tests/vm/generated/openbsd.json

-- 
2.47.3


