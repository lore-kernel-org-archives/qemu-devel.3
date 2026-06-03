Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81022CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 18:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUqIZ-0000bC-BY; Wed, 03 Jun 2026 14:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wUqIQ-0000XU-W6
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 14:26:31 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wUqIP-0003Yi-24
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 14:26:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso30736535e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 11:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780511186; x=1781115986; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6RwiudhEWA7LbPZR+jTN6zMMB0hfCg8/CZoYlqSchzk=;
 b=Je7R8ZiNyVrp+ENH6TzEzcfamivmY33DqK8GsIur/o56m6IImFt2J2XuuEmxd1LS1b
 DGQ51WL7xShg1I34IsY7Fx+NQZuw1n8+GNj2fh1oeo+7ilTQ7Unrhp9SpLqSf5jg6/bH
 5LD2lNeOX/3xFu+jkHvWuIDCHelsneS8YlevSTyiMQep0OxYVjSgBfbBmA2eJsft0DKK
 QmrhC5pSGQqQpTiuKvpR6C+wOrkPdj9EH0CfyvigjgkBPng8U0xIddfR7wUdqrvzqEhm
 DExqiSL0jCxYr0oDrptnHR7GY18R9sCHTU6H2wrR934lX2pXuU3zudDtA/X3mmA9S1up
 zYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780511186; x=1781115986;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RwiudhEWA7LbPZR+jTN6zMMB0hfCg8/CZoYlqSchzk=;
 b=pl3W8mqNSrgR7PDHV/qWjkwc+B8nIAH4ehLc01MMgpACZEQZrofOJbSyPTXP4WXPn1
 0qAzyC2i8BxjEsEGn4fQTKE6ZB67CxuY8QLtqiyIoNAWGQ4TaNuZtC8Nzu2+3D8I8Ke9
 USXqpPA1mV410/lzn5YAYBdSKhnD34Z06fZvFhE/kNCYknDbgPyNHjgGrUyE5aDi1tLn
 PHlVTdmoBF0DaLkjF+dF1oSEGRgQPmb9xTDnLP+WIOvTQzPiP8t3Fmmy2ka25uwP2GEL
 dfNS4nfj5Qe+trfmBd4Scz5n4d0YSVjfrXCr5uaojDFMCP5JNwrz5OanjB7uJSUxmPRn
 8eNg==
X-Gm-Message-State: AOJu0Yz0WShvJU4zHhXIuFZhdUH2VXUG66v/YA5/9RxGeDuw3CkMwM+W
 2pY4JpaWYuZvmsJKbwQEKdmNzbq9rnRGuiiW78KQ6iLpMhPDHDAEUBfPnn0yY8f9lz4=
X-Gm-Gg: Acq92OFyx7wOKVPu3PaeLbm7nWWr55OIls4xzAw6medQNu+GaeTZNKEg0UA9bAqPWPj
 4zxfkvBIithGecR3tS1tOOdPyOPXyVE+XrRemzHJ6mNyOdSM4GTio53t13Nkpdgcge9zGkj4OLO
 h8ZGa9/ov5FxyYVUtbl4vmGweR/LBojH3Y9Xc7i/+QyhXqXU93G7HfxD/PJ3P/D8xEEDHyzwbnY
 OFw5XD1sv/m7HtEnQnbNT+EgeA9SEX5qeFnOUXfxGXDt3a5ScsggDIOBPqLo27oX2dscx2lmFwx
 c98DYSCgr1U4GGG3LeSZuPz3+3i+3Hg6jyhX9FSiyGAXVeR6zGHCy2Hsgthdn8LGX4Kz/KzIz13
 qXcRBLRJJz8antOQ4gZuRbtd/UO7ZDYj2iZoNXCVDd6p3dIaFUjr7VVNUqNoGBafciiqOQjRHz6
 T6JWMg0zqZjKbo6OBPjh5Fq4MSGX3rZHL3f8q29Q==
X-Received: by 2002:a05:600c:c84:b0:490:389:7644 with SMTP id
 5b1f17b1804b1-490b5fe0e36mr76438755e9.17.1780511185963; 
 Wed, 03 Jun 2026 11:26:25 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:d530:6a6b:58a7:e220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2ed944sm9793127f8f.13.2026.06.03.11.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:26:25 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v2 0/6] target/arm: Add aarch64 GPC3 bypass windows
Date: Wed, 03 Jun 2026 19:26:19 +0100
Message-Id: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMxxIGoC/23MSw7CIBSF4a00dywGaEsfI/dhOkBevUahAUM0D
 XsXO3b4n+R8OyQT0SSYmx2iyZgw+Br81IBapXeGoK4NnHJBez6S+1Mq4jbV3ggbBzvpQVmqNdT
 DFo3F94Fdl9orpleIn8PO7Lf+ZTIjlOi2U51QPRWTvTzQyxjOITpYSilfR9nlxKUAAAA=
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x335.google.com
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

Adds the GPC bypass windows defined in D9.2 of the Arm ARM. D9.8 (the 
APAS instruction) is not implemented yet.

A large part of this is testing. To test GPC effectively, we need to
check that memory accesses are causing exceptions, or not causing exceptions
as appropriate. For some tests, boot.S is altered to record certain
exceptions and continue executing the test. An alternative would be
to use gdbstub to break on locations inside the vector table and continue,
but this requires significant coordination between the C test binary and
Python test driver, so has been avoided for now.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Changes in v2:
- ptw.c changes have been rewritten after a number of faults were found
- boot.S: Align exception_log to page
- target/arm/helper.c: flush all caches and remove redundant mask
- Switch on of GPC3 moved after feature implementation
- Link to v1: https://lore.kernel.org/qemu-devel/20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org

---
Jim MacArthur (6):
      target/arm/tcg/cpu64.c: Extra test for GPC3.
      target/arm: Setup new registers for GPC3
      target/arm/ptw.c: Add Granule Bypass Windows
      target/arm/cpu-features.h: x-rme now means GPC3
      tests/tcg/aarch64/system: Alternative boot object for exception logging
      tests/tcg/aarch64/system/gpc-test.c: Basic test for granule protection check

 target/arm/cpu-features.h                 |   5 +
 target/arm/cpu.h                          |   7 ++
 target/arm/helper.c                       |  19 ++++
 target/arm/ptw.c                          |  81 +++++++++++++++
 target/arm/tcg/cpu64.c                    |   4 +-
 tests/tcg/aarch64/Makefile.softmmu-target |  22 +++-
 tests/tcg/aarch64/system/boot.S           |  62 +++++++++++
 tests/tcg/aarch64/system/boot.h           |  14 +++
 tests/tcg/aarch64/system/gpc-test.c       | 165 ++++++++++++++++++++++++++++++
 9 files changed, 372 insertions(+), 7 deletions(-)
---
base-commit: 405c32d2b18a683ba36301351af75125d9afda08
change-id: 20260528-jmac-gpc3b-187f9d7cf0dd

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


