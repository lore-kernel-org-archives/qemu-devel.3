Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF360EA795D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpe7-0008R5-IY; Wed, 04 Feb 2026 22:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpe3-0008QJ-5h
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:03:03 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpe1-0007Vl-Ir
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:03:02 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82318702afbso425516b3a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770260580; x=1770865380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdCt3xlg6F9mwBLu/e3/NZY3cDKrKRpggjURQnBxAP0=;
 b=lOTP+1haZi/1+a4pzzjQsG3KCEb/wD2ShoaPvigSKjBdhjtsqk7NAzx45gGrg4qYW1
 ynltyHlKB8et3iqxVvsgl67mTntK9DQWBqVhIIECAqEc85K9c7ZE/la/iWKfQgitqkbI
 Wex3BYl7fjpNr5xet+WX0Kgm8G3jXgZ7NlZhOG/xRLCVXXX7frutznQZYhKeV7PAIRcv
 xlxkCskK/OHUFgVLu2HKuaCHs8bv9Usp4H5+grHF+lkJ7PkD8zKVgzyHcaeETmM7aeZs
 qZdTIpVdDkMvMKpO/pmJSeKUUyZWAIOhwf0CdlaOPUFCKnVNvmVu8K6RRNsMFerOZ2fj
 0OCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770260580; x=1770865380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CdCt3xlg6F9mwBLu/e3/NZY3cDKrKRpggjURQnBxAP0=;
 b=fdK2MiQqwd9hd9KixCQ3n6w1F1V2LywGw32jOG8Yv1MvmNUXuVtsw3h12QibGeqsXE
 M4wQIypyKxfzkHcASaJNDH6JC+G3TAlLbPXWxsU8GnZerx/0EbWqObpIluQwhDIksmB1
 v0z/TitDuVQvBk2PABpwCes2edoZLkUlc5rlVIYSrKk4rzlRlh/rtkGABLv1l7cgC3u6
 mDv0eoRECs+nqFg3AzcLj5qeMhLCuAjv3WueXMYvMU6WrLCPTcJ0Aneh4muFtermhp1e
 vvOM+XEIzI8EgZ/vnGXy+MuvjTDQiL78jJFqodWdeEM7zKw2ZK7eieBSk22cr9Ve64se
 s88Q==
X-Gm-Message-State: AOJu0YxWO3xZV6LSQcEy/d5AUMEonLWAubkBaVzm84PPgJAlpgjomjax
 VqqnS0uMPQTSSeuobxQSxKhMljGe23TLCYr4roUV5kIGRHQx3QkuWD0iEWpPJrOLQ1c4PAW+aig
 PjQC82i2ozg==
X-Gm-Gg: AZuq6aLM8wsLgR+b8HDR1BsTI9Ei/CKoOBzNqGfpuddmG5RKsupqOJCSr74At7X6y6N
 TViiJF+0u/BraZOxpGd+j4JteaKkkpr2c0MKTb9/b1PYCQ1GpWahOL2U+55sEFf4ZlHreuwO/F9
 XxjtMMqeZc31vecLjcMMqfFYC1rpgo3dcOOuLkKRsRXlYrBiQ5a7cZmFZwJBveIiSwuTanq26i5
 xAYVyy9HGIht47Z0v+8yOG7hqTQllKFgEax6Jmklbl7I3eOCA1VuOOsYF3P35GUJscV8wpcsgZy
 z3i1VmWajI47RZ0uI7v4T396WR727ppa6wztq0RNW/y8uQf5UKtY4hly/y83pQ+HqbchLX0W2Uu
 guEgYaBQdcow61+B7VQ0q7/vssLkV0cqedxB6AzWjWT9oXi9dTAp73WjwogOLZG9gtc8JIgE+/Z
 11QsELOpk+kEHtFFsViVOM
X-Received: by 2002:a05:6a21:6b11:b0:342:a7cd:9211 with SMTP id
 adf61e73a8af0-3937231c5fcmr5304464637.34.1770260579871; 
 Wed, 04 Feb 2026 19:02:59 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c8572b4e7sm3395480a12.33.2026.02.04.19.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 19:02:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	shorne@gmail.com
Subject: [PATCH 3/6] hw/or1k: Rename from openrisc
Date: Thu,  5 Feb 2026 13:02:41 +1000
Message-ID: <20260205030244.266447-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205030244.266447-1-richard.henderson@linaro.org>
References: <20260205030244.266447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/{openrisc => or1k}/boot.c         | 0
 hw/{openrisc => or1k}/cputimer.c     | 0
 hw/{openrisc => or1k}/openrisc_sim.c | 0
 hw/{openrisc => or1k}/virt.c         | 0
 MAINTAINERS                          | 4 ++--
 hw/Kconfig                           | 2 +-
 hw/meson.build                       | 2 +-
 hw/{openrisc => or1k}/Kconfig        | 0
 hw/{openrisc => or1k}/meson.build    | 0
 9 files changed, 4 insertions(+), 4 deletions(-)
 rename hw/{openrisc => or1k}/boot.c (100%)
 rename hw/{openrisc => or1k}/cputimer.c (100%)
 rename hw/{openrisc => or1k}/openrisc_sim.c (100%)
 rename hw/{openrisc => or1k}/virt.c (100%)
 rename hw/{openrisc => or1k}/Kconfig (100%)
 rename hw/{openrisc => or1k}/meson.build (100%)

diff --git a/hw/openrisc/boot.c b/hw/or1k/boot.c
similarity index 100%
rename from hw/openrisc/boot.c
rename to hw/or1k/boot.c
diff --git a/hw/openrisc/cputimer.c b/hw/or1k/cputimer.c
similarity index 100%
rename from hw/openrisc/cputimer.c
rename to hw/or1k/cputimer.c
diff --git a/hw/openrisc/openrisc_sim.c b/hw/or1k/openrisc_sim.c
similarity index 100%
rename from hw/openrisc/openrisc_sim.c
rename to hw/or1k/openrisc_sim.c
diff --git a/hw/openrisc/virt.c b/hw/or1k/virt.c
similarity index 100%
rename from hw/openrisc/virt.c
rename to hw/or1k/virt.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 508d37ab7a..00aa4f2a41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -304,7 +304,7 @@ M: Stafford Horne <shorne@gmail.com>
 S: Odd Fixes
 F: docs/system/openrisc/cpu-features.rst
 F: target/or1k/
-F: hw/openrisc/
+F: hw/or1k/
 F: include/hw/or1k/
 F: tests/functional/or1k/meson.build
 F: tests/tcg/openrisc/
@@ -1493,7 +1493,7 @@ M: Jia Liu <proljc@gmail.com>
 S: Maintained
 F: docs/system/openrisc/or1k-sim.rst
 F: hw/intc/ompic.c
-F: hw/openrisc/openrisc_sim.c
+F: hw/or1k/openrisc_sim.c
 F: tests/functional/or1k/test_sim.py
 
 PowerPC Machines
diff --git a/hw/Kconfig b/hw/Kconfig
index 9e6c789ae7..f8f92b5d03 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -58,7 +58,7 @@ source loongarch/Kconfig
 source m68k/Kconfig
 source microblaze/Kconfig
 source mips/Kconfig
-source openrisc/Kconfig
+source or1k/Kconfig
 source ppc/Kconfig
 source riscv/Kconfig
 source rx/Kconfig
diff --git a/hw/meson.build b/hw/meson.build
index 1022bdb806..66e46b8090 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -9,7 +9,7 @@ subdir('loongarch')
 subdir('m68k')
 subdir('microblaze')
 subdir('mips')
-subdir('openrisc')
+subdir('or1k')
 subdir('ppc')
 subdir('remote')
 subdir('riscv')
diff --git a/hw/openrisc/Kconfig b/hw/or1k/Kconfig
similarity index 100%
rename from hw/openrisc/Kconfig
rename to hw/or1k/Kconfig
diff --git a/hw/openrisc/meson.build b/hw/or1k/meson.build
similarity index 100%
rename from hw/openrisc/meson.build
rename to hw/or1k/meson.build
-- 
2.43.0


