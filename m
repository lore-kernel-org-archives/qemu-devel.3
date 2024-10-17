Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63003D2F7F2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 06:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1KE6-0001fb-OB; Thu, 17 Oct 2024 02:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KE4-0001f5-I4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:43:12 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KE2-0005EY-D7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:43:12 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e06acff261so421888a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 23:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729147388; x=1729752188;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x6zpqchONPHG2z1YpUsmT5085ajZuY5rM0OQd21AjPA=;
 b=JZd1gUPLOT1AUzHkL1TllzkWVpnXxj3+5nVbO3u8wFp21gmUXji7jA2QtySEYrOtzi
 5u7g1ocZMgD21OB5S3EIEkECg64O5jJlKNn3DK3DGloZlUFraMA4FSGc+0UqIa5nrk5K
 T+vugZjGVDQahvPNCE2qTiTjsFw51HUguzxEWINW3QJgDNEyK98R0PiCmmKIa3zqoxTC
 DtArTmkD/cOTzyi1ZfmlFr+xTbuKWT2hJi0VSkUwH1fN6HZtWfFx+nLhN4k+ewGETCSE
 U0oaZOSEGyMDUZyDM+wNq+1m9oIv5YuErpQJP2gzXDPqXZ69EV5wZxWY+3bf5M5fArlo
 204g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729147388; x=1729752188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x6zpqchONPHG2z1YpUsmT5085ajZuY5rM0OQd21AjPA=;
 b=EnZaQVjakBlPH2XNBwemnlDyn4Gl5xv1pBmmfgwgdvfOHQUgNgSSMiLwPESqAXSvXm
 G8E9Vo8kOulGS5ZdpAYIS4lXgA9lUXjoYxJGdNcSCvxyppMKX+SjGU2WgkLtURHHH2gM
 qC79v2jvp0eml4PMmvckI6PJtvwI8ipQEmGzOez5fnAx3LQR3LWmUuwWvAyj5NDiMw52
 8vXGo3HrNtHCX28c4XRVumSBNan6NkDR0ucstiJXLPrpVm24xXp/GEqwvYaRgOKZcWd5
 80aNwb6oSrHoZlTjAt7WRvXq/lL4sEveiiU+OYSjuns64pQhLd4iQDSnCGO1HS+TiyTQ
 BCRg==
X-Gm-Message-State: AOJu0Yy3Z+tg9Rr8s3zVLW/8ieS7TC1BfuwR3iaEwmtsiQHaTdonSgUh
 ZriXRBUfpsAO3UjnAgCJAoGk86ZC5KjCNre9eYz+ucO4DF9TNpREUn8DOkLN0zFr5Pr9NGulb2m
 4OB3X7w==
X-Google-Smtp-Source: AGHT+IEf2TJZkHTOxBnirpe4APYmst/EbPGYtswB9IeyoXAwxqBduqDN+7+lyoY2+4YS6J3WpnPwkA==
X-Received: by 2002:a17:90a:3ea7:b0:2e2:d197:40f3 with SMTP id
 98e67ed59e1d1-2e3ab8e7b46mr7725796a91.35.1729147387458; 
 Wed, 16 Oct 2024 23:43:07 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e3e08eba12sm1044372a91.29.2024.10.16.23.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 23:43:07 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v4 0/6] migration: auto-converge refinements for huge VM  
Date: Thu, 17 Oct 2024 14:42:49 +0800
Message-Id: <cover.1729146786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102c.google.com
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

v4:
1. split the [PATCH v3 1/6] into smaller patches.
2. refine some comment and commit message
3. fix race issue for the throttle_dirty_sync_timer
4. refine the util function cpu_throttle_dirty_sync_timer

Thanks Peter for the suggestions.

Please review.

Yong

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

Hyman Huang (6):
  accel/tcg/icount-common: Remove the reference to the unused header
    file
  migration: Stop CPU throttling conditionally
  migration: Move cpu-throttole.c from system to migration
  migration: Remove "rs" parameter in migration_bitmap_sync_precopy
  migration: Support periodic RAMBlock dirty bitmap sync
  tests/migration: Add case for periodic ramblock dirty sync

 accel/tcg/icount-common.c                    |  1 -
 {system => migration}/cpu-throttle.c         | 67 +++++++++++++++++++-
 {include/sysemu => migration}/cpu-throttle.h | 14 ++++
 migration/meson.build                        |  1 +
 migration/migration.c                        | 23 +++++--
 migration/migration.h                        |  1 +
 migration/ram.c                              | 13 ++--
 migration/trace-events                       |  4 ++
 system/cpu-timers.c                          |  3 -
 system/meson.build                           |  1 -
 system/trace-events                          |  3 -
 tests/qtest/migration-test.c                 | 32 ++++++++++
 12 files changed, 143 insertions(+), 20 deletions(-)
 rename {system => migration}/cpu-throttle.c (67%)
 rename {include/sysemu => migration}/cpu-throttle.h (87%)

-- 
2.27.0


