Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BB8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 07:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scKKA-0002mc-5a; Fri, 09 Aug 2024 03:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scKK8-0002iF-E0
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:46:08 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scKK5-0002vj-SR
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:46:08 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70d25b5b6b0so1448607b3a.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 00:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1723189443; x=1723794243;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/waCfZIpwHr1OgYBTlJkVrmnPH0POYFcg1/H/+p2zcM=;
 b=WdCasAfUjJGffUqv/TQN6Io0jeXBtx00fn/7H3WlDjbuOedd8HOsHBMpl7+lbDT31f
 LbsyX+ew9UHHCh4llxZOsreXRFn3dm6kpocGud4SufDTPV6A4FSgc2LqulP3h47l+5xg
 HdMmGM5ooTxrFMs7EkINzKBgBz7NWqSAeec5WcV3imPaH+wxzypuV+2cokIDvs9lNAV7
 zNgj5kUsj0UVYVhd/h76sBUMa2sFlyww/5RqZRxl1sMPvqzU9an1tS6njE5fIwWAii2h
 xlb+ybZbGR8uGWKdKjfaDrtHdixKexhtnncStT2aiWvw/32BP8f/ustVY4xovxIsugtQ
 DULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723189443; x=1723794243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/waCfZIpwHr1OgYBTlJkVrmnPH0POYFcg1/H/+p2zcM=;
 b=vwz/3sA62KgGgqrlr+I2Eb+9U6tYQBz4vSj5ee3XLKaXCM0enY6hQQGTsS9AOTopjV
 9Budxs+oD1XnumkiDu1eGG9btHjo57EbApQghvqdCzkK9Ij82mzfPq4h0yCfhxceadHO
 LPmw+GYfmPANOF77md6n1nSPu6lJqaIER1dSh3d8ZSU2RwQ70qH09/8gYTcH+kq37w0o
 yE+SXIXn6zP6Lfyk1BL227BtyXIw3HGeejmvRNFJ241kre3VpDiLSKtQRezEWtr8TGfy
 L6fHlKtMKYnCA/Nw4Q+2PpNcsIfWdFPeyOFa9IUvJ1GFFDO9q0vegU3wDQL367/nP9pX
 ZzYw==
X-Gm-Message-State: AOJu0YxMGx3tDqdSgatsu9VkZ4YoL3BHPNiZ/xWxN0XY8Co7yhSXnkrZ
 x6lhf3AUkTs8aOdu+TrGhcY4AIGD8GuI4ODiCFScw8ZERuOBcCU0GN2lgNzatI65DvGrwqE8O7s
 /KvLgBA==
X-Google-Smtp-Source: AGHT+IF8vcxHFwak5VEvoQqOvO5aDEiPjD49SxIvxht4Mu6/PL8/awbnAXYDlGNGLF4ZhMJaGCOcbQ==
X-Received: by 2002:a05:6a00:4b4f:b0:70a:efd7:ada1 with SMTP id
 d2e1a72fcca58-710dc75fa1amr627257b3a.17.1723189442151; 
 Fri, 09 Aug 2024 00:44:02 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb22a455sm2123212b3a.71.2024.08.09.00.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 00:44:01 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v1 0/5] Guestperf: miscellaneous refinement and enrichment 
Date: Fri,  9 Aug 2024 15:43:31 +0800
Message-ID: <cover.1723189080.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Message-ID: <20240809074331.8kYKbOs4LBLnJYi0kSjaV1pvb2l9jEKHFIMeL_md45A@z>

From: Hyman Huang <yong.huang@smartx.com>

The previous patchset:
https://lore.kernel.org/qemu-devel/cover.1722957352.git.yong.huang@smartx.com/
does not made the necessary changes and tests for the upstream version.

This patchset works for that:
1. Move the guestperf to scripts directory suggested by Fabiano Rosas
2. Make initrd-stress.img built by default suggested by Fabiano Rosas
3. Make the necessary changes to adapt the latest multifd behavior
4. A nitpick for multifd migration
5. Support multifd compression option

Please review,

Thanks

Yong

Hyman Huang (5):
  tests/migration: Move the guestperf tool to scripts directory
  tests/migration: Make initrd-stress.img built by default
  guestperf: Support deferred migration for multifd
  guestperf: Nitpick the inconsistent parameters
  guestperf: Introduce multifd compression option

 MAINTAINERS                                        |  5 ++++
 {tests => scripts}/migration/guestperf-batch.py    |  0
 {tests => scripts}/migration/guestperf-plot.py     |  0
 {tests => scripts}/migration/guestperf.py          |  0
 {tests => scripts}/migration/guestperf/__init__.py |  0
 .../migration/guestperf/comparison.py              | 15 +++++++++-
 {tests => scripts}/migration/guestperf/engine.py   | 32 +++++++++++++++++++---
 {tests => scripts}/migration/guestperf/hardware.py |  0
 {tests => scripts}/migration/guestperf/plot.py     |  0
 {tests => scripts}/migration/guestperf/progress.py |  0
 {tests => scripts}/migration/guestperf/report.py   |  0
 {tests => scripts}/migration/guestperf/scenario.py |  7 +++--
 {tests => scripts}/migration/guestperf/shell.py    |  3 ++
 {tests => scripts}/migration/guestperf/timings.py  |  0
 tests/migration/meson.build                        |  5 ++--
 15 files changed, 58 insertions(+), 9 deletions(-)
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
2.11.0


