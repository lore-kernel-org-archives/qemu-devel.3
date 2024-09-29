Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4532ECF6497
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 17:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suxVU-0007gl-NP; Sun, 29 Sep 2024 13:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1suxVR-0007fG-35
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 13:14:49 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1suxVN-0003ZP-6N
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 13:14:47 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2db85775c43so2634310a91.0
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2024 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1727630082; x=1728234882;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E06ALxTV6zTjdlMEPkmHpI5/f4rzUBHxCz0cwoJGq60=;
 b=HO3YwBtesvG3zURkA6oYtoyRWmWUsg96UUwynZNf6Hcrpsphiwz84rv7P5loPUrXBh
 GWu7cURVPRmZP/s7UXDVxbpXf/QPUShx+wMEEVsUx7MF8/B6C1WrLxehJf1CQ27TbhEQ
 vRFLdc13tndUfOIXk7kEU6rUev8o7WjWx92dKHCBc1CmPwDrCeXPO/jgZ08h1nDLPZjI
 VuGZeVuJxButBW5NyUW12YiW8XqrDeH0WZuVdx3088gVmGtX63oBn8RKC6Es+5GaMzNK
 E5aOMgK5uceYW1129x9M+4MrjKk6tedyx35YjcIAs4UvdGUoVy23vg35J795rYxcP+wl
 SNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727630082; x=1728234882;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E06ALxTV6zTjdlMEPkmHpI5/f4rzUBHxCz0cwoJGq60=;
 b=oqPfwelfCD2AIcrRE9sRVOxGfaVt2iYWxf6S3476F35LyadtvZP3MexOE0Ahd5smw/
 acYfLZ9oYft44ok3IW9iYWXeZSuKZcVExu43IKcUeDVGCyXmmB9gPDoPK2Y165RysRJF
 Ur2QsXIrBlgst8kFpR+5VKhsSPnO+4aLowjtI9NpMb7TUsdyVES52T6G0QAmpO2iBsUE
 mi+4+JuLtAqiIjlottQ5q+xYXx1q2YBVAZJ9s38XX+rY5868g8a99TGJpaHgterLRHHv
 navmEn+Dxf6GlmsOIC1unvUU1SZ4X7LVL51/In0eumU9qoFGjh8L2QJz9r+15zhBAkRS
 umAg==
X-Gm-Message-State: AOJu0Yy/7Qfl1sQO2ey0aszD2eFKXwywe/crKxd2ageDkkBymBIv5DyC
 uC8ucaRrzNpd33+e2KSadl7dOdbq0+PKYNFACyA+MkWqDN6jACi5fIh69xIognFFBgf1HVpECii
 jYLU=
X-Google-Smtp-Source: AGHT+IGeOTKcua3dWKruDv6FVs17gM8tor/ltLESrDtkHNGXh3nwPgEkS1KJYbx4XPS+9W4A1PRcGQ==
X-Received: by 2002:a17:90a:a881:b0:2d8:7445:7ab2 with SMTP id
 98e67ed59e1d1-2e0b731bd65mr12574448a91.20.1727630081566; 
 Sun, 29 Sep 2024 10:14:41 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e06e1e09e2sm9597408a91.32.2024.09.29.10.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 10:14:41 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v2 0/3] migration: auto-converge refinements for huge VM 
Date: Mon, 30 Sep 2024 01:14:25 +0800
Message-Id: <cover.1727630000.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

v2:
1. background sync - Throw out the idea of "not updating the bitmap"
   when the RAMBlock of the RAM list is iterated during migration;
   re-implement the background RAM dirty sync using Peter's updated
   method.

2. responsive throttle - Rename the "cpu-responsive throttle" to
   "cpu-throttle-responsive," as suggested by Fabiano.

For the background sync refinement, The new method achieves a much
shorter migration time overall and is much simpler than the previous
approach.

The test approach is the same as in version 1, but we use a new test
host with 1.93 Gb bandwidth. Please refer to the information included
in version 1 below for more details.

The new test result for background dirty sync is as follows; we didn't
test the responsive throttle feature because its logic is still the same.

For each scenario, we tested twice and used 3500MB as high memory load.
ramsize: 150MB
|------------+-----------+----------+-----------+--------------|
|            | totaltime | downtime | iteration | max throttle |
|            | (ms)      | (ms)     | count     | percent      |
|------------+-----------+----------+-----------+--------------|
| original   | 57579     | 577      | 107       | 90%          |
|            | 57434     | 466      | 110       | 90%          |
|------------+-----------+----------+-----------+--------------|
| background | 57728     | 488      | 102       | 90%          |
| sync       | 60223     | 447      | 115       | 90%          |
|------------+-----------+----------+-----------+--------------|

ramsize: 3000MB
|------------+-----------+----------+-----------+--------------|
|            | totaltime | downtime | iteration | max throttle |
|            | (ms)      | (ms)     | count     | percent      |
|------------+-----------+----------+-----------+--------------|
| original   | 291275    | 416      | 26        | 99%          |
|            | 290907    | 567      | 27        | 99%          |
|------------+-----------+----------+-----------+--------------|
| background | 210912    | 465      | 30        | 99%          |
| sync       | 203890    | 442      | 28        | 99%          |
|------------+-----------+----------+-----------+--------------|

ramsize: 3500MB
|------------+-----------+----------+-----------+--------------|
|            | totaltime | downtime | iteration | max throttle |
|            | (ms)      | (ms)     | count     | percent      |
|------------+-----------+----------+-----------+--------------|
| original   | 338445    | 491      | 28        | 99%          |
|            | 341168    | 496      | 28        | 99%          |
|------------+-----------+----------+-----------+--------------|
| background | 209099    | 440      | 27        | 99%          |
| sync       | 206241    | 467      | 30        | 99%          |
|------------+-----------+----------+-----------+--------------|

v1:
This is the first version for auto-converge refinements; refer to the
following link for details about the RFC version:
https://patchew.org/QEMU/cover.1725891841.git.yong.huang@smartx.com/

This series introduces two refinements called "background sync" and
"responsive throttle," respectively.

1. background sync:

   The original auto-converge throttle logic doesn't look like it will
   scale because migration_trigger_throttle() is only called for each
   iteration, so it won't be invoked for a long time if one iteration
   can take a long time.

   The background sync would fix this issue by implementing the background
   dirty bitmap sync and throttle automatically once detect that
   the iteration lasts a long time during the migration.

   The background sync is implemented transparently, and there is no
   new-added interface for upper apps.

2. responsive throttle:

   The original auto-converge throttle logic determines if the migration
   is convergent by one criteria, and if the iteration fits twice, then
   launch the CPU throttle or increase the throttle percentage. This
   results in that the migration_trigger_throttle() won't be invoked for
   a long time if one iteration can take a long time too.

   The responsive throttle introduce one more criteria to assist detecting
   the convergence of the migration, if either of the two criteria is
   met, migration_trigger_throttle() would be called. This also makes it
   more likely that the CPU throttle will be activated, thereby
   accelerating the migration process.

   The responsive throttle provides the 'cpu-responsive-throttle' option
   to enable this feature.

We test this two features with the following environment:

a. Test tool:
guestperf

Refer to the following link to see details:
https://github.com/qemu/qemu/tree/master/tests/migration/guestperf

b. Test VM scale:
CPU: 16; Memory: 100GB

c. Average bandwidth between source and destination for migration:
1.59 Gbits/sec

We use stress tool contained in the initrd-stress.img to update
ramsize MB on every CPU in guest, refer to the following link to
see the source code:
https://github.com/qemu/qemu/blob/master/tests/migration/stress.c

The following command is executed to compare our refined QEMU with the
original QEMU:
# python3.6 guestperf.py --binary /path/to/qemu-kvm --cpus 16 \
--mem 100 --max-iters 200 --max-time 1200  --dst-host {dst_ip} \
--kernel /path/to/vmlinuz --initrd /path/to/initrd-stress.img \
--transport tcp --downtime 500 --auto-converge --auto-converge-step 10 \
--verbose --stress-mem {ramsize}

We set ramsize to 150MB to simulate the light load, 3000MB as moderate
load and 5000MB as heavy load. Test cases were executed three times in
each scenario.

The following data shows the migration test results with an increase in
stress.

ramsize: 150MB
|------------+-----------+----------+-----------+--------------|
|            | totaltime | downtime | iteration | max throttle |
|            | (ms)      | (ms)     | count     | percent      |
|------------+-----------+----------+-----------+--------------|
| original   | 123685    | 490      | 87        | 99%          |
|            | 116249    | 542      | 45        | 60%          |
|            | 107772    | 587      | 8         | 0%           |
|------------+-----------+----------+-----------+--------------|
| background | 113744    | 1654     | 16        | 20%          |
| sync       | 122623    | 758      | 60        | 80%          |
|            | 112668    | 547      | 23        | 20%          |
|------------+-----------+----------+-----------+--------------|
| background | 113660    | 573      | 5         | 0%           |
| sync +     | 109357    | 576      | 6         | 0%           |
| responsive | 126792    | 494      | 37        | 99%          |
| throttle   |           |          |           |              |
|------------+-----------+----------+-----------+--------------|

ramsize: 3000MB
|------------+-----------+----------+-----------+--------------|
|            | totaltime | downtime | iteration | max throttle |
|            | (ms)      | (ms)     | count     | percent      |
|------------+-----------+----------+-----------+--------------|
| original   | 404398    | 515      | 26        | 99%          |
|            | 392552    | 528      | 25        | 99%          |
|            | 400113    | 447      | 24        | 99%          |
|------------+-----------+----------+-----------+--------------|
| background | 239151    | 681      | 25        | 99%          |
| sync       | 295047    | 587      | 41        | 99%          |
|            | 289936    | 681      | 34        | 99%          |
|------------+-----------+----------+-----------+--------------|
| background | 212786    | 487      | 22        | 99%          |
| sync +     | 225246    | 666      | 23        | 99%          |
| responsive | 244053    | 572      | 27        | 99%          |
| throttle   |           |          |           |              |
|------------+-----------+----------+-----------+--------------|

ramsize: 5000MB
|------------+-----------+----------+-----------+--------------|
|            | totaltime | downtime | iteration | max throttle |
|            | (ms)      | (ms)     | count     | percent      |
|------------+-----------+----------+-----------+--------------|
| original   | 566357    | 644      | 22        | 99%          |
|            | 607471    | 320      | 23        | 99%          |
|            | 603136    | 417      | 22        | 99%          |
|------------+-----------+----------+-----------+--------------|
| background | 284605    | 793      | 27        | 99%          |
| sync       | 272270    | 668      | 28        | 99%          |
|            | 267543    | 545      | 28        | 99%          |
|------------+-----------+----------+-----------+--------------|
| background | 226446    | 413      | 22        | 99%          |
| sync +     | 232082    | 494      | 23        | 99%          |
| responsive | 269863    | 533      | 23        | 99%          |
| throttle   |           |          |           |              |
|------------+-----------+----------+-----------+--------------|

To summarize the data above, any data that implies negative optimization
does not appear, the refinement saves the total time significantly and,
therefore, shortens the duration of the guest performance degradation.

Additionally, we examined the memory performance curves generated from
the test case results above; while no negative optimization is there,
but the performance degradation occurs more quickly. Since it is
inconvenient to display the graphic data, one can independently
verify it.

Hyman Huang (3):
  migration: Support background ramblock dirty sync
  qapi/migration: Introduce cpu-throttle-responsive parameter
  migration: Support responsive CPU throttle

 include/migration/misc.h       |   3 +
 migration/migration-hmp-cmds.c |   8 +++
 migration/migration.c          |  11 +++
 migration/options.c            |  20 ++++++
 migration/options.h            |   1 +
 migration/ram.c                | 119 ++++++++++++++++++++++++++++++++-
 migration/ram.h                |   3 +
 migration/trace-events         |   2 +
 qapi/migration.json            |  16 ++++-
 system/cpu-timers.c            |   2 +
 tests/qtest/migration-test.c   |  30 +++++++++
 11 files changed, 212 insertions(+), 3 deletions(-)

-- 
2.27.0


