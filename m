Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E37D206AC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 07:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0yu3-0003Z0-Ju; Wed, 16 Oct 2024 03:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t0yu0-0003YK-7F
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 03:57:04 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t0ytx-0000gi-Ef
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 03:57:03 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cb47387ceso38016715ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 00:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729065418; x=1729670218;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QZkjyrN5gie7mbAjhKNmNrig3p6XKtP8gMq042cxCtA=;
 b=aRevhuU9+vMl1PvHEkofM8QSy9GkJDPh3pR45/fboMsVrUCj+/T8nYt4PSVmEf+ryQ
 rdQMusEK0wYmtQZoq6wxhzbtNVgimb71mY8HL47CBeWBRjxsz+gFCuts8u4/U03fNS+f
 RlIRT8UoWB5tw05gquP6MyRwpxh5xJ7jBSXXv0GPIyyItA2c6qdTvZ83BwFKwoiX8yVM
 jg9Xjizkjw2tmDKnd374yDvzF3WwayahjR/T7/yFk0wVEGMhX4MDRAugUwBjODjHXxxH
 lXzwjAZcRUJUnnUsO69gxe8PwwpmyeXinK3WP0xTC/l1qGNNsSJL8JVOcY/AYwPmSdOA
 O8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729065418; x=1729670218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QZkjyrN5gie7mbAjhKNmNrig3p6XKtP8gMq042cxCtA=;
 b=biKKIO5SP7hfWt9yUHm89gpkfh1RtpdCZb1JOIqeFRPT6NrrAWMpMoA25gsARQpu1q
 9exUUXIongpAtt+LnDf9T633dKJlRYmDaPQBkEdG2T8FdkgFNtcQm8CDN9FUtxwoZAdu
 v3zwkHOyOkA0K6tO3+cyJ8vA2hfn8gHg7SqJgplNJfx/3FhIlKPyQptrSOs1GWR+tKVd
 KUKFEauIAhR6L0oNNcRaRSPz4bdn9DYaE17rB5kZbP1d/lOT81y7D/7I42zLGugfunhO
 uP2DDlWz7Aj3E5S2PD2wfRV5DWJIZifM7OHAunrWb98Kfqdz/R5cdZmPZ9pr4EGBD4a3
 tw7g==
X-Gm-Message-State: AOJu0YxFrQzMYMd1K0GT7cx9CP9IEZp+Zd2sGu587Ym9qwaTdALsunf3
 KX6LCzQi+POi46aDDakD7n2z7I7VMRIHkwxJnfebvyQVsDIGkuWtTcEHdtpvobEasgyNSFrxXnU
 amP5x7g==
X-Google-Smtp-Source: AGHT+IF7kLa7pGiY6HchiN7bxLAa40YurO9CvOVgJSzy0TnQM2162dhVh4jCJCgyXflZbEiwMm51Jg==
X-Received: by 2002:a17:903:d1:b0:20c:9821:69a4 with SMTP id
 d9443c01a7336-20d27e7ec6emr31128645ad.6.1729065417549; 
 Wed, 16 Oct 2024 00:56:57 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f84dd1sm23608365ad.43.2024.10.16.00.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 00:56:57 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v3 0/4] migration: auto-converge refinements for huge VM
Date: Wed, 16 Oct 2024 15:56:41 +0800
Message-Id: <cover.1729064919.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62a.google.com
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
1. drop the responsive throttle patchset
2. rename background sync to periodic ramblock dirty sync
3. move the cpu-throttle.* from system to migration
4. remove "rs" parameter in migration_bitmap_sync_precopy
5. implement periodic ramblock dirty sync in cpu-throttle.c
6. move the test change into a separate patch

To simplify the cover letter, i have dropped the test data,
please refer to 
https://lore.kernel.org/qemu-devel/cover.1727630000.git.yong.huang@smartx.com/
for more test details.

Thanks Peter and Fabiano for the suggestions and comments.

Please review.

Yong

Hyman Huang (4):
  migration: Move cpu-throttole.c from system to migration
  migration: Remove "rs" parameter in migration_bitmap_sync_precopy
  migration: Support periodic ramblock dirty sync
  tests/migration: Add case for periodic ramblock dirty sync

 accel/tcg/icount-common.c                    |  1 -
 {system => migration}/cpu-throttle.c         | 72 +++++++++++++++++++-
 {include/sysemu => migration}/cpu-throttle.h | 14 ++++
 migration/meson.build                        |  1 +
 migration/migration.c                        | 11 ++-
 migration/migration.h                        |  1 +
 migration/ram.c                              | 20 ++++--
 migration/trace-events                       |  4 ++
 system/cpu-timers.c                          |  3 -
 system/meson.build                           |  1 -
 system/trace-events                          |  3 -
 tests/qtest/migration-test.c                 | 32 +++++++++
 12 files changed, 144 insertions(+), 19 deletions(-)
 rename {system => migration}/cpu-throttle.c (65%)
 rename {include/sysemu => migration}/cpu-throttle.h (87%)

-- 
2.27.0


