Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741AECD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMM0-0004MO-SL; Tue, 05 May 2026 16:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMLz-0004M7-Am
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMLx-0002ZR-0d
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LF3SXemHFM8frWqOOBpoEpd0pCy7FcRCfYY5pB9rHes=;
 b=HTDRPPIFj+/4lLv8V7aLJIt9Xtwslnp1q/dRsKWn/ymzJN2YkTDQufOL3/X7J292rYPXle
 UI3kdd02VkvI1vRqKqCIcMjXefXCSikW6dfbkjAfGIZVAYfPPQ/xkripRpFi9+R6NIO0tw
 11vEkPjpC3fI8fPj8PPIcSXlIgbPqqs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-ViIr4Sk7P0SBSiORhWL7BA-1; Tue, 05 May 2026 16:26:45 -0400
X-MC-Unique: ViIr4Sk7P0SBSiORhWL7BA-1
X-Mimecast-MFC-AGG-ID: ViIr4Sk7P0SBSiORhWL7BA_1778012805
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8eb04352972so1129521585a.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012805; x=1778617605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LF3SXemHFM8frWqOOBpoEpd0pCy7FcRCfYY5pB9rHes=;
 b=ltAS8KPu2XrDiLuiHNc6eEoSYbtiqKGyw6PpSLxywCefhyDE8EpCgdr9z/FKqDmxyo
 3N6jE1CSLrvRk48kHSpemF53emqPC50WX3XiNNHq5ngedsn2HbIcBmdZ3Bin3wz30jZE
 pHyo9g7QMlFQ+lq4nx0xBShLMuv3auj3YOlL1iHrad0TeXfIchPe7f+RILMyywBfWB4J
 Y9OZ7tGrR6QhnqzG7sPP3ZvLbmCl6xY9vdXwsdqoA1Yi0Oyb9jg3ffNO4/BhEWsHCZ3B
 6HzgZboLR32Jsteb1exzXEZHHXd+Wg7iDXBDV46lVhENInWwLfaRMmZQtJONp2u4T4KI
 +Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012805; x=1778617605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LF3SXemHFM8frWqOOBpoEpd0pCy7FcRCfYY5pB9rHes=;
 b=cehH4tSE4EfT4NaMI5wXKM786X3qNhXW9BK2E3b/OKNsVE7nKkJgMnrQcN9+/+Kujf
 Mj0SQjUD2d18nb0nR39GapAQxVgwoRcEe7NnzQ2J9TQytfhSLb5eSYcz12aK3rT3rJ+o
 2v+Jv/YmeDTmy2IM7KjwVuCVhfE6On1Pkr/V8wU3OEdHu3oPv6H+tWjIK8OMREIKxAVQ
 VQy7OSh7ee9xtOPtdC7bgZrSNt9NGv3yMrPm2I9q/bHTxWBsGOQxdgOGi7qfJdBNfFsE
 gCXY1ZTvi3LwhGMadSEnofwBQVfg0R6iqTmTYWiO2gG3sa4r5y/nEt8+5AGr7DNu9swd
 pYBw==
X-Gm-Message-State: AOJu0YyQsZv6iLM3tVGGQKRT0qxj1WZaGSLIF32DE4Epq9msHXW4JmaL
 NsbHt87zL2r0pQ/On9riznfo55fW94YvuWybbAxdj2oiI+y2K+1tG6CLMBiCIPeC+LmdzvfCfRA
 n8peIX286P1kGF7wgBBi+g64o+kFo0zQ9pByyRMXKjjdWCxiDm7qzpyr6kJ/xC3o+eKAAG7E2pz
 36f8fU7yqISa+4XBiIw6bI8cgGTQyFLdKX55ewPw==
X-Gm-Gg: AeBDievW0Jc4CwJEJbhF52wMcs5ZX1y3352tHQlFNWkOGgSea6GD7zTLTc056x1g8Gt
 oAv6DrIjBMrFBLnO9huWQchwOAUBv7bsOEWcgeSmMxq2JvvZOPTczgOAm7b1QGX2D5NJ4Mep8hr
 OeJ8GRPRMlpB6Kx8zqn+vcPxgb4U0AgwWyUz2nUAcUJegveIuDt4tgQUmy9J/m+iP71+69QU7LJ
 1ACwJXdrT4dUQFjSrPzJaZx3ew/SCmV3DMqUk2UPGjd/OB3JvOY5DtcI+xdoVXmOvJVXOoT4eWh
 ioO9IoZBDuyYAcFdotHPgnILOits+0ewbCBqxOHFHyCEnbByCs7hsgfI5EUHGQCcXp0aX8/Um4p
 9eCCzjfO/XHOKIt3e7rNhhSOscamCqvdhiYA3Bm/ZgRdNSapG/MwezXw=
X-Received: by 2002:a05:620a:414b:b0:8ef:3953:7a4 with SMTP id
 af79cd13be357-904d65e059amr90965385a.43.1778012804684; 
 Tue, 05 May 2026 13:26:44 -0700 (PDT)
X-Received: by 2002:a05:620a:414b:b0:8ef:3953:7a4 with SMTP id
 af79cd13be357-904d65e059amr90958385a.43.1778012803941; 
 Tue, 05 May 2026 13:26:43 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:26:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 00/23] Next patches
Date: Tue,  5 May 2026 16:26:17 -0400
Message-ID: <20260505202640.1011006-1-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-05-01 14:41:49 -0400)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/next-pull-request

for you to fetch changes up to 348c67cb16ecb479994b0c957699f906bd40a6c2:

  tests/qtest/migration: Fix A-B file build (2026-05-05 12:35:25 -0400)

----------------------------------------------------------------
Migration and mem pull request

- Fabiano's fix on migrate_set_parameter crash with multifd & zerocopy
- Pranav's fix on postcopy stucking at device state when ack lost
- Samuel's new migration parameter x-rdma-chunk-size for RDMA
- PeterX's vfio/migration series to report remaining data and fix downtime calc
- PeterM's MemoryRegionOps .impl cleanup series
- Fabiano's fix to build a-b migration bootfiles for all archs

----------------------------------------------------------------

CJ Chen (2):
  hw/riscv: iommu-trap: remove .impl.unaligned = true
  system/memory: assert on invalid MemoryRegionOps .unaligned combo

Fabiano Rosas (2):
  migration: Use QAPI_CLONE_MEMBERS in migrate_params_test_apply
  tests/qtest/migration: Fix A-B file build

Peter Maydell (2):
  hw/npcm7xx_fiu: Specify .impl for npcm7xx_fiu_flash_ops
  hw/xtensa/mx_pic: Specify xtensa_mx_pic_ops .impl settings

Peter Xu (15):
  migration: Fix low possibility downtime violation
  migration/qapi: Rename MigrationStats to MigrationRAMStats
  vfio/migration: Cache stop size in VFIOMigration
  migration/treewide: Merge @state_pending_{exact|estimate} APIs
  migration: Use the new save_query_pending() API directly
  migration: Introduce stopcopy_bytes in save_query_pending()
  vfio/migration: Fix incorrect reporting for VFIO pending data
  migration: Move iteration counter out of RAM
  migration: Introduce a helper to return switchover bw estimate
  migration: Calculate expected downtime on demand
  migration: Fix calculation of expected_downtime to take VFIO info
  migration: Remember total dirty bytes in mig_stats
  migration/qapi: Introduce system-wide "remaining" reports
  migration/qapi: Update unit for avail-switchover-bandwidth
  vfio/migration: Add tracepoints for precopy/stopcopy query ioctls

Pranav Tyagi (1):
  migration: Fix blocking in POSTCOPY_DEVICE during package load

Samuel Zhang (1):
  migration/rdma: add x-rdma-chunk-size parameter

 docs/about/removed-features.rst            |   2 +-
 docs/devel/migration/main.rst              |   9 +-
 docs/devel/migration/vfio.rst              |   9 +-
 qapi/migration.json                        |  45 +-
 hw/vfio/vfio-migration-internal.h          |   8 +
 include/migration/register.h               |  59 +-
 migration/migration-stats.h                |  20 +-
 migration/migration.h                      |   3 +-
 migration/options.h                        |   1 +
 migration/savevm.h                         |   7 +-
 tests/qtest/migration/aarch64/a-b-kernel.h |   7 +-
 tests/qtest/migration/bootfile.h           |  11 +
 tests/qtest/migration/i386/a-b-bootblock.h |   8 +-
 tests/qtest/migration/ppc64/a-b-kernel.h   |   8 +-
 tests/qtest/migration/s390x/a-b-bios.h     | 611 +++++++++++++--------
 hw/riscv/riscv-iommu.c                     |   1 -
 hw/s390x/s390-stattrib.c                   |   9 +-
 hw/ssi/npcm7xx_fiu.c                       |   5 +
 hw/vfio/migration.c                        | 125 +++--
 hw/xtensa/mx_pic.c                         |  27 +
 migration/block-dirty-bitmap.c             |  10 +-
 migration/migration-hmp-cmds.c             |  16 +
 migration/migration.c                      | 225 +++++---
 migration/options.c                        |  59 +-
 migration/ram.c                            |  40 +-
 migration/rdma.c                           |  30 +-
 migration/savevm.c                         |  42 +-
 system/memory.c                            |   1 +
 tests/qtest/migration/s390x/a-b-bios.c     |  66 ++-
 hw/vfio/trace-events                       |   5 +-
 migration/trace-events                     |   3 +-
 tests/qtest/migration/Makefile             |  11 +-
 tests/qtest/migration/aarch64/Makefile     |   4 +-
 tests/qtest/migration/aarch64/a-b-kernel.S |   2 +-
 tests/qtest/migration/i386/Makefile        |   4 +-
 tests/qtest/migration/i386/a-b-bootblock.S |   2 +-
 tests/qtest/migration/ppc64/Makefile       |   6 +-
 tests/qtest/migration/ppc64/a-b-kernel.S   |   2 +-
 tests/qtest/migration/s390x/Makefile       |   8 +-
 39 files changed, 957 insertions(+), 554 deletions(-)

-- 
2.53.0


