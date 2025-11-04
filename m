Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58649CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJbZ-0006gG-RU; Tue, 04 Nov 2025 11:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbS-0006f5-2V
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:09:50 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbQ-0007J9-Bm
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:09:49 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477563bcbbcso4577285e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762272586; x=1762877386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pcrnq4ag/ZW0NVr3bqcln/DJ4CftlPRqBUCod8tXOfU=;
 b=P1xiaix6P3AiwrQdC7zok3cFM1chEksP9f+F6m1VxZL+c3TJ9bUIUE2y3AvoY348K4
 gM3JzVNQAD8BLeqL2XKMwxon1HBZOIBEL/Uv+0VSQJLo3gteedDZNQkB8Ah5T1/Yt06F
 8Dz6kh0LYX4YRMGun4ZW2dit9XiGdXfDTN8lAlL3BbEOOtNvSPY/LjxtJB7dl833y66T
 zTUJclIVBRseFbWUbZSXrEmzwk6DIc86z5A+ej72my8hp8AV4rpSBdWTiFgFOata1cb+
 jZkeHyFYSIR+YDwY0JyslLh8hV5XE8KAeCWZ3F3iqWil/fdzEQLN5699X+KyQPsiYGMF
 uVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272586; x=1762877386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pcrnq4ag/ZW0NVr3bqcln/DJ4CftlPRqBUCod8tXOfU=;
 b=LSkcW5Wv3C8TCQhkc7bpRf25MkNlEp5fs/XgD6SmjfVLcCrKRvTaOTbdtubJTOgdXm
 JBn/4EPiSgY/TN2dqkV8HQIK9uc8oZQVZT4bZalfYlrhXGgoH+d0DCztaWH3ZBjULQMO
 WaScjSAWpA3YbrB2EDnaEH0NXtb2aLHWqlDKZofuGueYMMjePh0fGy0tZqI3jcMa0TYi
 1RtXOpmkQVeT1ynHVYURQuM9fwBaxnUaRYxUDAfQMfIEvs93FXBUpKJ/viCVzYIIc1QA
 S4KZoZDhXGyimJO4108Njmf17N65x5//kvQEHZf4JxZF7pxLJXySnSBoFlWbAazMlZLB
 kQBQ==
X-Gm-Message-State: AOJu0YyZEMn+hvg/xLRh/vwbSmDzn+qM6OAasu7HsAwuG8EoeYz/W0tX
 hjlCnuiQQqwznpftKm3DO//q0urUyqcIwguAdxESepvHykEQOfEL9DwGhnus9c+FH9THAF4fs5P
 tvQYr
X-Gm-Gg: ASbGncvYft14WS++u6b3zLHAnbmGxzQZ9gkEHQyBoaPNO6n9dVCfAiaIslWXkZG/WaC
 G0iNeemxNKzh/QP6yAjwQpafrqEsEprspVwcalVzDdijaaSbq6sZWlR5IZ5vt5A1X+K9qf7gjAr
 Iu7NjZM9eHc8j/h0JE3vMHyLDjYD+t6S569d0OKoZMrb2AnL/6Lp531yeuIJGqSjAPvVaOOIHKk
 gCm7EuXFZMzJscPvZKrnyBeAO2ceSjrMK93N+diUoTmK4Cqb0oH+fmA/zAHemHRLSwXRihjO0Bj
 P8nV3WjnkIlCDQpapNxo3ojjR+nRgC7X/4hjp8L2nMw4ziHem4Xjxo+Bw05irJIGhUxcYI+i9rq
 qu7m04egrRpoqTjsvw11psB7X+ZyK7Jd1oF+WFseJ9ipDzBQRYZ8SeaeJ7FekwnQjyxXpnskAZE
 LQynsc9g==
X-Google-Smtp-Source: AGHT+IGcN9A4Udc0r05nk7IDfhOivQ9od+FMGYZkJ1y+6lkCBmjx5Cl9adnZCebK6mBOr7cXDd8RCw==
X-Received: by 2002:a05:600c:3acd:b0:46e:32f7:98fc with SMTP id
 5b1f17b1804b1-477498de36fmr80786205e9.21.1762272585938; 
 Tue, 04 Nov 2025 08:09:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47754adcd08sm57314455e9.5.2025.11.04.08.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:09:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: [PATCH 0/9] clean-includes: improve exclude list, run on cxl, vfio,
 tests
Date: Tue,  4 Nov 2025 16:09:34 +0000
Message-ID: <20251104160943.751997-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

I realised that we haven't run clean-includes recently, and
unsurprisingly various violations of our include policy have
crept in to the tree. The exclude-list of files it shouldn't
be run on has also grown rather out of date.

While looking at this I realised that one reason the exclude list
is stale is that it's encoded in the script in a really awkward
single long line extended regex. So the main thing this patch
series does is fix that to instead use a list of regexes, one
per line, with comments permitted.

The other useful new feature here is that you can now point
the script at a directory (previously your only options were
an explicit list of files, or '--all' to scan everything).

The other changes to the script itself are minor cleanups.

Finally, I have a couple of patches which are the result of
running the script on some subdirectories. I do think that all
the changes that the script now suggests are correct (it wants
to make changes to 28 files other than these) but I wanted to
get the script changes through review first, and then perhaps
send those last changes a bit more broken up per-subsystem.

thanks
-- PMM

Peter Maydell (9):
  scripts/clean-includes: Allow directories on command line
  scripts/clean-includes: Remove outdated comment
  scripts/clean-includes: Make ignore-regexes one per line
  scripts/clean-includes: Do all our exclusions with REGEXFILE
  scripts/clean-includes: Give the args in git commit messages
  scripts/clean-includes: Update exclude list
  cxl: Clean up includes
  vfio: Clean up includes
  tests: Clean up includes

 hw/vfio-user/container.h             |  1 -
 hw/vfio-user/device.h                |  1 -
 hw/vfio/pci-quirks.h                 |  1 -
 tests/qtest/aspeed-hace-utils.h      |  1 -
 tests/qtest/aspeed-smc-utils.h       |  1 -
 hw/cxl/cxl-mailbox-utils.c           |  2 +-
 hw/mem/cxl_type3.c                   |  2 +-
 hw/vfio-user/container.c             |  2 +-
 hw/vfio-user/pci.c                   |  2 +-
 hw/vfio/ap.c                         |  1 -
 hw/vfio/container.c                  |  2 +-
 hw/vfio/cpr-legacy.c                 |  2 +-
 tests/qtest/aspeed_gpio-test.c       |  1 -
 tests/qtest/dbus-display-test.c      |  3 -
 tests/qtest/pnv-spi-seeprom-test.c   |  1 -
 tests/unit/test-cutils.c             |  2 +-
 tests/unit/test-error-report.c       |  1 -
 tests/unit/test-io-channel-command.c |  2 -
 scripts/clean-includes               | 88 ++++++++++++++++++----------
 19 files changed, 63 insertions(+), 53 deletions(-)

-- 
2.43.0


