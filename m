Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1E5E9539B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncqJ-0003Iq-N2; Wed, 04 Feb 2026 08:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vncqG-0003I9-BB; Wed, 04 Feb 2026 08:22:48 -0500
Received: from mail.avm.de ([212.42.244.120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vncqE-00030x-AW; Wed, 04 Feb 2026 08:22:48 -0500
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.0)
 (envelope-from <c.speich@avm.de>)
 id 6983481e-cb91-7f0000032729-7f000001d8e6-1
 for <multiple-recipients>; Wed, 04 Feb 2026 14:22:38 +0100
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Wed,  4 Feb 2026 14:22:38 +0100 (CET)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026020414223963-15147 ;
 Wed, 4 Feb 2026 14:22:39 +0100 
Subject: [PATCH v3 0/6] hw/sd: Improve performance of read/write/erase
Date: Wed, 04 Feb 2026 14:22:24 +0100
Message-Id: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABBIg2kC/3XNzQqDMAzA8VeRnteRxMrsTr7H2KG1cfbgB+0oG
 +K7rwrz5iXwD+SXRUQOnqO4F4sInHz005ijvBSi7c34YuldbkFAFWgkGV1rgpMzh24KgxlbllZ
 Jp6G21lYGQIl8Owfu/Gd3H8/cvY/vKXz3Nwm37V/UJ2JCCZIRyhurGg3qxqTh6lhsXKKDwDzOC
 MqEU6Q0WMSS6CDWdf0BkpIqOvoAAAA=
X-Change-ID: 20250912-sdcard-performance-b4-d908bbb5a004
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Christian Speich
 <c.speich@avm.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 04.02.2026 14:22:39,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 04.02.2026 14:22:39, Serialize complete at 04.02.2026 14:22:39
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1770211358-F164465A-0E47C8B9/0/0
X-purgate-type: clean
X-purgate-size: 2527
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=212.42.244.120; envelope-from=c.speich@avm.de;
 helo=mail.avm.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Christian Speich <c.speich@avm.de>
From:  Christian Speich via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch series improves the performance of read/write/erase operations
on sdcards.

This is done by increasing the maximum buffer size that is worked on.
From 1 byte (master) to 512 bytes (commit 1-3) to larger than 512
(adma commit).

Testing on my system with fio I see the following rough performance
values in MiB/s.

              read write readwrite
       master:   6     6     3/  3
 first commit:  51    43    23/ 23
second commit: 392   180   144/143

Tested on a 2GiB raw image with:
  fio --filename=/dev/mmcblk0 --direct=1 --runtime=60 --time_based --bs=128k --rw={mode}

The adma values are somewhat unstable but always >100MiB/s, I'm not sure
why but I guess it has something to do with the host side caching.

The fifth commit fixes the DATA_STAT_AFTER_ERASE bit in SCR and
introduces an option to allow to erase blocks to 0x00.

The sixth commit optimizes block erase when erase-blocks-as-zero=true
is used, by passing the zeroing request down the to the block device.
Erasing 2GiB now takes 0.1s instead of 26s.

Signed-off-by: Christian Speich <c.speich@avm.de>
---
Changes in v3:
- Rebase onto master, updating read/write path for newly added RBMP
- Split up commit 1 into multiple commits
  - change interface to allow "short" read/writes that are continued
    by the core later by calling again
- Link to v2: https://lore.kernel.org/qemu-devel/20251202-sdcard-performance-b4-v2-0-d42490b11322@avm.de

Changes in v2:
- Properly set DATA_STAT_AFTER_ERASE in SCR
- Add erase-blocks-as-zero option to allow the user to switch between
  0x00 and 0xFF for erased blocks.
- Link to v1: https://lore.kernel.org/qemu-devel/20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de

---
Christian Speich (6):
      hw/sd: Switch read/write primitive to buf+len
      hw/sd/sd: Allow multi-byte read/write for generic paths
      hw/sd/sd: Use multi-byte/block writes for block path
      hw/sd/sdhci: Don't use bounce buffer for ADMA
      hw/sd/sdcard: Add erase-blocks-as-zero option.
      hw/sd/sdcard: Optimize erase blocks as zero.

 hw/sd/core.c       |  26 +++--
 hw/sd/sd.c         | 333 ++++++++++++++++++++++++++++++++++++++++-------------
 hw/sd/sdhci.c      | 102 ++++++++--------
 include/hw/sd/sd.h |  22 ++--
 4 files changed, 341 insertions(+), 142 deletions(-)
---
base-commit: 28a6ca268c2cd3718b5bf24c2d97e3d1e95fc604
change-id: 20250912-sdcard-performance-b4-d908bbb5a004

Best regards,
-- 
Christian Speich <c.speich@avm.de>


