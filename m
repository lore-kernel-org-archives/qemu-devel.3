Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30707D17159
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34Q3-0005vW-Mg; Mon, 21 Oct 2024 22:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t34Q1-0005v7-Eu
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:14:45 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t34Py-0001Wd-Ru
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:14:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20ceb8bd22fso43523785ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 19:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729563280; x=1730168080;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=28cPfR2zOBj5XZq82Me7wK87Xf09YOKdsorP/mEeBcc=;
 b=LLC8RsAHpYNeyADPaP6EJM7PQ7xjPHCBdm9l/bjmI4jBYSMpUP8Umc+MI7dEzMQQ6t
 zIO4XvPt+vLPkbBxWecxRwXv7Rp8lIDzd7EDeHO2555NZmmVNVpdAEjTp7RJ2iKkCNmg
 xuWWC9WQ8f7bHmi6KEIWs1yZ4kQYFY2VqjDO6m1qTQLRsakpAUCkD6eX2ctieAO6SCxF
 sLnReDO9VhJRrhAjAls34LEi13M93U0EsIy3LbdUZKcyhrEp6+ALJasUbCOmH0fERCya
 HJQB29bK88uq3v6UQaO2EZZu3uOQtjqz9jcaAJBwex+znbcOnFIQ0lzks5jqb8wZ1bLm
 GXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729563280; x=1730168080;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=28cPfR2zOBj5XZq82Me7wK87Xf09YOKdsorP/mEeBcc=;
 b=aFHtaeKYv5hkqRsoNVoDzAGVBXQ0Goa5ojjyA0yUgXDk3qMj/w+ipZScjgl2EpHjrO
 XJVnELtMtpoDplAdb9WpbvLeZDeNl7FOIQbjZNL/J2hUi/K0AcoEPpP8tviqYIiH6/FP
 k9/z99J2OSvUrkQICTneI0+nvu0urgnmKbr36p1HJ4UWIctnKro0U9gjB/QvlILdfL5d
 oOnJAr253SfLtqCe1VGw8jDgrTbdJPinZngSwO/EJkpI8q7VokIZ6LyX8/foJOhC5hor
 yZofKN2LOBpFWgN60YoDCzWVQ2o99FcE/aFHFqQnJJDPFMXIjkZ0mVSrp4yRAv/Faiiq
 7HUQ==
X-Gm-Message-State: AOJu0Yx4eHi3ejM+Tyt4CloaV8hC5afdE1MgnqJ1YhXy8P878CTbFjAW
 Q+5SZm46r+qmfQP8ctBEHB9FhYRL0+juNWrYU1JEZ1Fvu+EGUzn0Wf0DG8DxLprTqzV+V1MahFI
 RLG9gyg==
X-Google-Smtp-Source: AGHT+IEA2KAhEso2RQI5oKovJdQTmw88nHNYuR1NTvl+1PSV4RRcBK9TVIrSly3KDQZxlT6dvKQAsw==
X-Received: by 2002:a17:902:e74e:b0:20c:8763:b3f7 with SMTP id
 d9443c01a7336-20e5a78adfbmr203232745ad.17.1729563279183; 
 Mon, 21 Oct 2024 19:14:39 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([103.172.41.198])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd63fsm32726545ad.173.2024.10.21.19.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 19:14:38 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v3 0/5] Guestperf: miscellaneous refinement and enrichment
Date: Tue, 22 Oct 2024 10:14:21 +0800
Message-Id: <cover.1729562974.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

v3:
1. Remove the two redundant assignments in [PATCH v2 2/5] suggested by Daniel 

Please review, thanks
Yong

v2:
1. Update the MAINTAINERS section suggested by Fabiano Rosas 
2. Ensure the dependencies when build the initrd-stress.img suggested by Daniel
3. Fix some bugs

v1:
The previous patchset:
https://lore.kernel.org/qemu-devel/cover.1722957352.git.yong.huang@smartx.com/
does not made the necessary changes and tests for the upstream version.

This patchset works for that:
1. Move the guestperf to scripts directory suggested by Fabiano Rosas
2. Make initrd-stress.img built by default suggested by Fabiano Rosas
3. Make the necessary changes to adapt the latest multifd behavior
4. A nitpick for multifd migration
5. Support multifd compression option

Hyman Huang (5):
  tests/migration: Move the guestperf tool to scripts directory
  tests/migration: Make initrd-stress.img built by default
  guestperf: Support deferred migration for multifd
  guestperf: Nitpick the inconsistent parameters
  guestperf: Introduce multifd compression option

 MAINTAINERS                                   |  5 +++
 .../migration/guestperf-batch.py              |  0
 .../migration/guestperf-plot.py               |  0
 {tests => scripts}/migration/guestperf.py     |  0
 .../migration/guestperf/__init__.py           |  0
 .../migration/guestperf/comparison.py         | 15 ++++++++-
 .../migration/guestperf/engine.py             | 33 ++++++++++++++++---
 .../migration/guestperf/hardware.py           |  0
 .../migration/guestperf/plot.py               |  0
 .../migration/guestperf/progress.py           |  0
 .../migration/guestperf/report.py             |  0
 .../migration/guestperf/scenario.py           |  7 ++--
 .../migration/guestperf/shell.py              |  3 ++
 .../migration/guestperf/timings.py            |  0
 tests/migration/meson.build                   | 30 +++++++++--------
 15 files changed, 73 insertions(+), 20 deletions(-)
 rename {tests => scripts}/migration/guestperf-batch.py (100%)
 rename {tests => scripts}/migration/guestperf-plot.py (100%)
 rename {tests => scripts}/migration/guestperf.py (100%)
 rename {tests => scripts}/migration/guestperf/__init__.py (100%)
 rename {tests => scripts}/migration/guestperf/comparison.py (89%)
 rename {tests => scripts}/migration/guestperf/engine.py (93%)
 rename {tests => scripts}/migration/guestperf/hardware.py (100%)
 rename {tests => scripts}/migration/guestperf/plot.py (100%)
 rename {tests => scripts}/migration/guestperf/progress.py (100%)
 rename {tests => scripts}/migration/guestperf/report.py (100%)
 rename {tests => scripts}/migration/guestperf/scenario.py (93%)
 rename {tests => scripts}/migration/guestperf/shell.py (98%)
 rename {tests => scripts}/migration/guestperf/timings.py (100%)

-- 
2.27.0


