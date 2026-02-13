Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB096EDF173
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvPt-0001uj-Jg; Fri, 13 Feb 2026 10:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vqvPp-0001qx-16
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:49:09 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vqvPl-0007wl-TX
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:49:08 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-65a414a6859so1885196a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 07:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770997744; x=1771602544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QxsuxdaSfuvmviENh9G98WFpXuHJOPaxQR6wxO3M1Bc=;
 b=vjVXaFPUoeVnH1rWr7J8WrPskdVIUjixgG/rYxTo6GwEhdlIqanBtPmrdZcHrI2RB5
 9YO0Bj9Df9fhp8Y1n8nKqqitCsz30VBzJ7iGfR7vtZf70DBWixXSAzwuS2/UDYiTb6P7
 h16Mp0Qn0K3c0K5BGZzEcWTaMpqoJ15zANh9Qy40CO9q/co6ur8wrLWczUyM8wgyfzAo
 C6iFoBeItcIVpPg9U3Ey4H3hmzQ5aXEhjnuDCnGC6rBhgz/HYgMA0iiDHlQzPClrn3GK
 Pxwy/fk05Nr4tJ6QEB+rsOhydSrLVkxqtsL9UVeDpnMNu+vhF6xvjNiweHMezvYqGKHc
 w4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770997744; x=1771602544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QxsuxdaSfuvmviENh9G98WFpXuHJOPaxQR6wxO3M1Bc=;
 b=b6XPk3BR52kHtung+PE5EKvCBdTLslHbMVqt3DZdlaJ6yuHtl2meCTSvWz28wsulKf
 qKXlKpjkgV/FDkpVnw4ssuJdOOQFaMAPV8FEfRV7TxPDQslBuHYv9Dr+bLH7SXt88pPs
 VMzAumhxp+VX09VH6GJMN7yeCYqh7BCVOqGm+a0/W2HSP8OTpZjcFNPTexDlrxnWeMfa
 g8/rokRv0FB+VM6wv8+5OnrtXsJYRpx/M7+EbI6/L84DmssGiXpdLMyYyUkKNRN1k0W1
 sHBbFdJf4G6TdDiozT2LNKJ9E7pozegnvu1onKg9+GzWQmPMleIBGQIeAm+OvaMB+7Ig
 aOaw==
X-Gm-Message-State: AOJu0YxikgwB0DjHgdvMMLe3XUWA1Irx17C5ZKTN7bY47PdSfWvegUW/
 is2JRRsOQMK8J1halqh8HEFO8b00fvxDrxxYl5sXVdNDZ/st3LkAGSIbB+KAosG6ni6n/O3tiiL
 i53xC
X-Gm-Gg: AZuq6aKyzFVzkfUKXvxLlfQ2ZrvxtIq0V854nrG/iqCqAHfSKn57tSyms4q+BGwn/ip
 vOad5xFBP0u0RkzRZtXPpfS0ciIQOQCQr19PeAW0tjt1Dtmdhs5SQRm6PE3cgYGIKvd1lVlmHQN
 YIlKIHb9q602fPhieSeNkVFxbcFc9eCfAr7wI02YQj6Kt7HKL+bvnHHopDyHET78x8Je4ZWeh/p
 7BolrTEE+GDOpUTw2FNXKrkRwP9kO7JeV5bAJLfR3n9bvF0Mrm+uG90YMIeryas9ODDCk4F/RYX
 LqxJOdC82xUkDs3t50Nu5IPYAfpOPZDbSK3x6ExI7nys4TYU7C1WV1UT+vv6bf997xuWnlatpvg
 cBlaexixJ3EanvRSGovXPmycXZx9E+XzdWHI90941wiZl45R9kdk0DYldzRKqXAniwZsP5DsfLZ
 uXR6mGHjUnumbm6J3QlTstENY=
X-Received: by 2002:a05:6402:278b:b0:65a:409c:6fe6 with SMTP id
 4fb4d7f45d1cf-65bb1161199mr1339982a12.15.1770997743824; 
 Fri, 13 Feb 2026 07:49:03 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65bad3e39bfsm768387a12.22.2026.02.13.07.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 07:49:01 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CD5675F818;
 Fri, 13 Feb 2026 15:48:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 0/6] testing/next: libvirt-ci,
 tests/vm and vbsa functional test
Date: Fri, 13 Feb 2026 15:48:53 +0000
Message-ID: <20260213154859.1551283-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Alex.

Alex Bennée (6):
  tests: bump libvirt-ci to latest state
  tests/vm: bump OpenBSD to the current 7.8 release
  tests/vm: remove unused import
  tests/vm: fix interactive boot
  tests/vm: build openbsd from lcitool data (!567)
  tests/functional: add Arm VBSA uefi conformance test

 tests/docker/dockerfiles/alpine.docker        |   4 +-
 tests/docker/dockerfiles/centos9.docker       | 240 ++++++++--------
 .../dockerfiles/fedora-rust-nightly.docker    | 262 +++++++++---------
 .../dockerfiles/fedora-win64-cross.docker     | 162 +++++------
 tests/docker/dockerfiles/fedora.docker        | 262 +++++++++---------
 tests/functional/aarch64/meson.build          |   1 +
 tests/functional/aarch64/test_virt_vbsa.py    |  99 +++++++
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/refresh                         |  13 +-
 tests/vm/Makefile.include                     |   2 +-
 tests/vm/generated/openbsd.json               |  27 ++
 tests/vm/openbsd                              |  44 +--
 12 files changed, 605 insertions(+), 513 deletions(-)
 create mode 100755 tests/functional/aarch64/test_virt_vbsa.py
 create mode 100644 tests/vm/generated/openbsd.json

-- 
2.47.3


