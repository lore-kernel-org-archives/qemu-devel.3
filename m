Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD9EFCA168
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzejZ-0000pC-Jn; Mon, 09 Mar 2026 13:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vzein-0000Zh-IW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:48:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vzeik-0002oX-Es
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:48:47 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4852fdb36a8so25767985e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773078523; x=1773683323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l/sIyvWWOet6DcAfwt9uriFJA/qSWmiHhlEJv1XIlhM=;
 b=gZYxf4nLcQ3aNyJdcwyEbvhMiEgodZuwy2PDmQ/FIZiotJvozqp8UiT8JRuwjdKzZS
 YAFp0rzgoV0lx18FBeP/g7VLZO4xOVaXxiY+9GA7u7DyKl4hPVbg6daX1XhM3uO0/A7x
 6lqB63DqRwCUVSfIt44Kx7GbO1GLoPD8Xy4kFbqUZmbht9T1a4EGhRSTk6rXqb/sWdla
 Gve8LBGPBVbYJLQhjqSOH8dxSU9JRyBJva+1X69wgUteiGcNDpgIRnLW6yDM7s/XpBVg
 wt88A2BMm13dyHCg6r59oJx/NPb1R6LFsXECe9QIqUgphSApe4k5iRGbuzuChp+Zkyrm
 FM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078523; x=1773683323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/sIyvWWOet6DcAfwt9uriFJA/qSWmiHhlEJv1XIlhM=;
 b=Z4h2JdbuEluAX0uitZwZWJbat01BpsWvgpjCbVA2JQ1bPgEHODjJKbj4fODQPqEDzL
 QQmTasXG9V1m6u9Rd9m0qchDzPoA0KX7LXtDJTeWZZjXSvLdclzyaJH/CBIu+RWU+WNH
 Xe2hrdItg+UAsgkSZSxE81YBqwu+hnhcSNFLx91kOWvTkMIyWrLspTXKsMZvJb7uwa6X
 DK/25JQWX6jFU/tx6QRDbESg5lPdGgABYeALlcWQZKL9EvBdQ2vp+EAS71nGBdC9IFeE
 zybOs4wmY36hv6TCgoItJMYqlaUQWS4YK5jullxSlexDqZQKm7oEJtVOH7SosHVI0bgz
 8mCA==
X-Gm-Message-State: AOJu0YyTtJDNoNL3q4Dnrbouozskg5Y0j+fgRumbDEwgvJjM9Ss2wYTu
 vySIHctp+XLJqSrPKfiry/G23KKrEfjsTt232Wbg8WIBPlJVzyuuWhktbA/H98un/A8=
X-Gm-Gg: ATEYQzwOM4n2+VNIEhM/xJEmCeH2PeYyKZOAYCzeTZmPVjb594770HZSEeYfN5VP2FD
 L+l57rc6EahRwq1MPZ5d/vkq4T5MTDnYQw/Z76G8Y7rDbowtSLky46o+PeoW05wT+EV8XwyIOUw
 Y+/BsnH4gGChN5nNG4Ol31Dbtzr+BJYu+Y3FHqSLBwmPwk3kNwLbofGUhzTQHFUs/G1fnJgxtab
 LaDsQHOdCzayD6HxPDdupZ3VjOr9Gq9e0RK1XQNISkIgD1YEtE0WJeVtr6+aSDSZ7EAPLhafwk8
 dbH73XayZOwL1iCDQ6gFy+T+qvtgPB/OzBWVjhP+ybr32vizz9xRJ03eNntUyHb8jnjhjzCYaWV
 zuABap6rWSby0WpcwnnJMkmJq3RL5E8c++MOq3yFx/XFP5N9wNT1zNBygsMcZZCkWOMJsmv06jH
 o2Vfh9mrb2bv/Dvm7n9K/akS0=
X-Received: by 2002:a05:600c:3b89:b0:485:3f1c:d8a4 with SMTP id
 5b1f17b1804b1-4853f1cda4cmr42751195e9.9.1773078522980; 
 Mon, 09 Mar 2026 10:48:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a9c293sm6548745e9.10.2026.03.09.10.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:48:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9EDB55F882;
 Mon, 09 Mar 2026 17:48:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/5] testing/next: gdb-multiarch, check-tcg, vbsa tests
Date: Mon,  9 Mar 2026 17:48:36 +0000
Message-ID: <20260309174841.4184117-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

This is the current status of my testing tree. The gdb-multiarch and
filtering changes should be pretty uncontroversial. Due to the
enhancements I needed to make to get the vbsa linux tests running they
may want to cook a bit longer and wait until the 11.0 release is out
of the way.

v2

  - mostly tweaks to the vbsa test (see inline comments on commit)
  - dropped the zip and send_key patches

All patches now reviewed (although worth giving the vbsa test the once over).

Alex.

Alex Bennée (4):
  tests/docker: add gdb-multiarch to all-test-cross
  tests/tcg: allow filtering of TCG tests
  tests/functional: allow tests to define decompression target
  tests/functional: add VBSA linux tests

Matheus Tavares Bernardino (1):
  tests/tcg/multiarch/linux-test: use portable alternative for dirent64

 tests/tcg/multiarch/linux/linux-test.c        |   5 +-
 tests/Makefile.include                        |   8 +-
 .../dockerfiles/debian-all-test-cross.docker  |   1 +
 tests/functional/aarch64/test_virt_vbsa.py    | 122 ++++++++++++++++--
 tests/functional/qemu_test/testcase.py        |   9 +-
 tests/lcitool/refresh                         |   1 +
 tests/tcg/Makefile.target                     |  12 +-
 7 files changed, 138 insertions(+), 20 deletions(-)

-- 
2.47.3


