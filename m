Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5FCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 07:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scKIF-0006yP-Gf; Fri, 09 Aug 2024 03:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scKID-0006xq-1G
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:44:09 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scKIA-0002im-Dx
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:44:08 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7a0b2924e52so1045342a12.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 00:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1723189322; x=1723794122;
 darn=nongnu.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/waCfZIpwHr1OgYBTlJkVrmnPH0POYFcg1/H/+p2zcM=;
 b=1SqfJQm1/cqvdviFTQICFlJQYJnGADgbOMtv0UmXcwHMxY07mzd9SdgC+gBy1e4vXm
 6QRmaBn3HVwwqoL17DnLH23rseetyL4ZFZa+c717455tqBAn0CAHsqp79Rm90qMX5GqP
 wgLBQHVvuyp4VlmLMTCdXPfERmh2ZlKULT1AvUGmtXMnAwK+812dv4qNvm0GxtkDtS3h
 d8r/c55q2wtet8hCjl131MVU2f0hgFWVsz7RbfwpaORW2RxTdxgKV13Dvifhbg5BWRDG
 mxv1GSIkCVSnaDmNsUM7HgE1ml8jweWj8gyPxpSFfzWtd3A2MyyxAOloA8l6RyMhyMoI
 Nmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723189322; x=1723794122;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/waCfZIpwHr1OgYBTlJkVrmnPH0POYFcg1/H/+p2zcM=;
 b=TWuEvdEgNj9S5/SkaBkD0aclcNayQAI0jK1dE2XvNaXiJrAvHCqg8GnAknfg+FOMuM
 poQl4WLRFj6EO/egKc8Cn8ke5vzTTnHHcAqUyOr7FJb7EkBMmm68dF8BQPV6zidLnoFq
 8R2TDJdADHfUjFMdUHoDEjvMurlCtbWz4TKwvUvPwJsLtXCOlV4bCx6ihDYtav2CIMaN
 JOIEz3ZJfTGyRLFPvflHi4fRmvsJLhuYsWbdIo7FiXN2iplQNUmhqmJczfksbRIPCL9q
 xJDbKqGQw2zZL9Qgf2g5OXM8KiORejLDUsmQGVmyO4oArk3KDn4UCE+ENif5F01pCFqd
 UfkQ==
X-Gm-Message-State: AOJu0YwysZXyzB+AIffYaUNBhgpgFjIalcWCtph7zBjebpYVcepuuxzl
 SPkTxxcCsgmlpkx2u654Q8D7ur57oabmvRIt4Si87ILQflVZAvyeZJagJrKzlgFv7pWggQ4WkAA
 KUkabAA==
X-Google-Smtp-Source: AGHT+IFf7iRq3fmjiElJbsNDlbaW3Ida2C1MyBko4/j2Vw9twiyS2oJUjvv9+bUb8dQxzSEPuW7KjA==
X-Received: by 2002:a05:6a20:cfa2:b0:1c6:a777:4cfa with SMTP id
 adf61e73a8af0-1c89fe97a70mr952184637.13.1723189320941; 
 Fri, 09 Aug 2024 00:42:00 -0700 (PDT)
Received: from c74-1708-dev.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b3addc29sm4655642a91.29.2024.08.09.00.41.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2024 00:42:00 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v1 0/5] Guestperf: miscellaneous refinement and enrichment 
Date: Fri,  9 Aug 2024 15:41:50 +0800
Message-Id: <cover.1723189080.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.11.0
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x534.google.com
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


