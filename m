Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891D9F43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfxE-0002tq-3k; Fri, 17 Apr 2026 05:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDfx9-0002jU-EZ; Fri, 17 Apr 2026 05:57:35 -0400
Received: from mail.avm.de ([2001:bf0:244:244::119])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDfx5-0002zL-HP; Fri, 17 Apr 2026 05:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1776419845; bh=hMZI9Of630JExhvUar0FTq2FjOJ5OfP7PFDSsZ5OJ8A=;
 h=From:Subject:Date:To:Cc:From;
 b=aXmWWnx4XW4wW5naiW2n26WFxN8IrFiZ2QMNjVeuSQzSxMqGuN7FL5LTS4Z7tth2V
 cLgk5eR68hl0fK6/LwuxlVhGtFlPlvxKvbb5dUme80MVIrik5RLk5YOXqUqkDfzM8S
 MeiFGlJB61IjdB47lipUx9jy+Ux1iuYKtun4C9qE=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <c.speich@avm.de>)
 id 69e20405-1e6c-7f0000032729-7f000001c50a-1
 for <multiple-recipients>; Fri, 17 Apr 2026 11:57:25 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Fri, 17 Apr 2026 11:57:25 +0200 (CEST)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026041711572441-2973 ;
 Fri, 17 Apr 2026 11:57:24 +0200 
From: Christian Speich <c.speich@avm.de>
Subject: [PATCH v4 0/7] hw/sd: Improve performance of read/write/erase
Date: Fri, 17 Apr 2026 11:51:33 +0200
Message-Id: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKUC4mkC/3XNzQrCMAzA8VeRnq0kWeesJ99DPPQjcz3sg1aKM
 vbudoKCh10C/0B+mUXiGDiJ824WkXNIYRxKqP1OuM4Md5bBlxYEVINGksk7E72cOLZj7M3gWFo
 lvYaTtbY2AEqU2ylyG54f93or3YX0GOPr8ybjuv2KekPMKEEyQtWwOqFBfTG5P3gWK5fpR2AZW
 wQVwitSGixiRfRHVF/iCARqi6hWwqFrsSHmuvkRy7K8Afyn7Ek9AQAA
X-Change-ID: 20250912-sdcard-performance-b4-d908bbb5a004
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, Christian Speich <c.speich@avm.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 17.04.2026 11:57:24,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 17.04.2026 11:57:24, Serialize complete at 17.04.2026 11:57:24
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1776419845-8E72B373-383F0CAF/0/0
X-purgate-type: clean
X-purgate-size: 3153
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=2001:bf0:244:244::119;
 envelope-from=c.speich@avm.de; helo=mail.avm.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Changes in v4:
- Rebase onto master, no changes needed.
- Renames:
  - sd_blk_{read,write} -> sd_blk_{read,write}_bounce_buffer
  - sd_blk_{read,write}_direct -> sd_blk_{read,write}
  - to_erase -> erase_len
- Extract erase logic into sd_blk_erase helper
- Enable erase-blocks-as-zero by default. Add compat for 11.0 and below
  to keep it disabled.
- Add cleanup commit to update trace events.
- Link to v3: https://lore.kernel.org/qemu-devel/20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de

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
Christian Speich (7):
      hw/sd: Switch read/write primitive to buf+len
      hw/sd/sd: Allow multi-byte read/write for generic paths
      hw/sd/sd: Use multi-byte/block writes for block path
      hw/sd/sdhci: Don't use bounce buffer for ADMA
      hw/sd/sdcard: Add erase-blocks-as-zero option.
      hw/sd/sdcard: Optimize erase blocks as zero.
      hw/sd: Update trace events for buf+len data

 hw/core/machine.c  |   5 +
 hw/sd/core.c       |  53 ++++++--
 hw/sd/sd.c         | 353 ++++++++++++++++++++++++++++++++++++++++-------------
 hw/sd/sdhci.c      | 102 +++++++++-------
 hw/sd/trace-events |   6 +-
 include/hw/sd/sd.h |  22 ++--
 6 files changed, 389 insertions(+), 152 deletions(-)
---
base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
change-id: 20250912-sdcard-performance-b4-d908bbb5a004

Best regards,
-- 
Christian Speich <c.speich@avm.de>


