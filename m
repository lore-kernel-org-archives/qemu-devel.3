Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FFBD3DEA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 18:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1rf7-0005Ow-DA; Fri, 18 Oct 2024 14:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1rf5-0005OU-Q5
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 14:25:19 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1rf1-0001yz-Eq
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 14:25:18 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20e6981ca77so7566775ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 11:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729275913; x=1729880713;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5To3CkUFilshmDxqH57Mai0sOOEWpL73vJChKdmeLmc=;
 b=zNAQZr3dk+eDUjJHNScj6gGcYaAsWDdUFbVIHPxN8+ifB1ZxnZMwU8/qlmS83kTd69
 OQ8oMszXwAuZ5g6ub2/Q2xF0yUsBqf9o+eou4cguC1HoCDrc99VZ+kqJJoNvLwv4q2hb
 F3hALdvQR9Jox5trqgV3z0uaGsuUG5R4J/I5vTW0EYTVHdV98vW514lHgj7zngJJqL3s
 R3vOaqR8Bnosyz096SjVd638dJO0bcYzhWIY+7n+/+ZTQ2dQlRcuXAXdgfTbmgWQat3K
 AHJOzNv4tl1bOftMqLJwW8PSrCCuqHjnjqiVWOg1dAO2W0Hic52imWdAaBwjFXz5Ww+k
 QdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729275913; x=1729880713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5To3CkUFilshmDxqH57Mai0sOOEWpL73vJChKdmeLmc=;
 b=at2R5UZ4cOmbdccx68DUxTfGcbLHRERXQrfG+G7iXK6jPA2ZsbaHYp08VoFeDuPjiN
 3kkD7U7XIpmwPXIZ927te+j3Wimm5eaZSIV6k30G9VWFFYJcuq6/UXcysrSxU9i5zI7B
 kuaHcQ3DJHGYxdifp1moehZ2Fuj1olJVfLAqejXkc8aLRPfrmhiHfzNzvZhI4M5apFG2
 S30YN5aUyRKeGndrDC0ZfYWy8AEnTuiD7GE0+Yee8CJM7B3TWMf9uXFmsWNKbw6pceQX
 1ajHKb/rpjw1wECfsttsR5WBNOZJ/fvNlRgP0N3VISvynChW6GZOte2rhpts7f/K72Km
 qmrA==
X-Gm-Message-State: AOJu0YyshU4b/yBQWBkMgskcYZoISTu51Vl/NVR2dME+UkCPy6o18Bd5
 /pHeTnnSLHyK9NifcNjfCeOX2W808ZdVufp/gysHrO6vnMVALyVVPQu5iXQ1RPS8p8m7QCom4x2
 mF+tRSw==
X-Google-Smtp-Source: AGHT+IFlJxiyeu0D/jA3YtPgssxliuXR//OWy1tg1iVtgi/lUNKgf1jACTxx9I7pUtvpizbISz5sgw==
X-Received: by 2002:a17:903:94f:b0:20c:ea04:a186 with SMTP id
 d9443c01a7336-20e5a914892mr47876285ad.48.1729275912562; 
 Fri, 18 Oct 2024 11:25:12 -0700 (PDT)
Received: from localhost.localdomain ([118.114.60.204])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e5a8f2034sm15668475ad.193.2024.10.18.11.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 11:25:12 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v2 0/5] Guestperf: miscellaneous refinement and enrichment 
Date: Sat, 19 Oct 2024 02:25:02 +0800
Message-Id: <cover.1729275266.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62c.google.com
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

v2:
1. Update the MAINTAINERS section suggested by Fabiano Rosas 
2. Ensure the dependencies when build the initrd-stress.img suggested by Daniel
3. Fix some bugs

Please review, thanks

Yong

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
 tests/migration/meson.build                   | 33 +++++++++++--------
 15 files changed, 76 insertions(+), 20 deletions(-)
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
2.39.1


