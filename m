Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06B8D116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 14:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQRY4-0005De-Sw; Tue, 02 Dec 2025 09:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vQRY2-00058I-6r; Tue, 02 Dec 2025 09:40:10 -0500
Received: from mail.avm.de ([2001:bf0:244:244::120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vQRXy-0001Bo-Oo; Tue, 02 Dec 2025 09:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1764686399; bh=K9vuWhafCDUBSXLkMwA6XOD1WupqFLxNHnz3nHLdQa8=;
 h=From:Subject:Date:To:Cc:From;
 b=liK3+t/g2psu9WVkOYQKeA7N+s8tDv6nB2tQ3vd7iLpORlwJvUAfp0ysEJ8ICTt6Q
 HkH5zuZmRDavPzjzB99BAJDR1w+AGqyiAXSHZRmftKEuZmBuk++s+WloQYIFQDVuS3
 W1IteTs6BmrQ6aFpNisJoMIpZiTFify/OUvXkX1E=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 692efa3f-a0ff-7f0000032729-7f000001962a-1
 for <multiple-recipients>; Tue, 02 Dec 2025 15:39:59 +0100
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Tue,  2 Dec 2025 15:39:59 +0100 (CET)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025120215400009-18425 ;
 Tue, 2 Dec 2025 15:40:00 +0100 
From: Christian Speich <c.speich@avm.de>
Subject: [PATCH v2 0/4] hw/sd: Improve performance of read/write/erase
Date: Tue, 02 Dec 2025 15:39:30 +0100
Message-Id: <20251202-sdcard-performance-b4-v2-0-d42490b11322@avm.de>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACL6LmkC/3WNywrCMBBFf6XM2pFJbLFx1f+QLpJmarPog4kEp
 eTfjQWXLs+Be+4OkSVwhFu1g3AKMaxLAX2qYJjs8mAMvjBo0g0ZpTH6wYrHjWVcZbbLwOhq9IZ
 a51xjiWoo2014DK+je+8LTyE+V3kfN0l97a9o/hSTQkJWdLly3SqrTGfTfPYMfc75A0bK9iy3A
 AAA
X-Change-ID: 20250912-sdcard-performance-b4-d908bbb5a004
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Christian Speich
 <c.speich@avm.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 02.12.2025 15:40:00,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 02.12.2025 15:40:00, Serialize complete at 02.12.2025 15:40:00
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1764686399-2160AD7E-DD80283A/0/0
X-purgate-type: clean
X-purgate-size: 2068
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=2001:bf0:244:244::120;
 envelope-from=c.speich@avm.de; helo=mail.avm.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch series improves the performance of read/write/erase operations
on sdcards.

This is done by increasing the maximum buffer size that is worked on.
From 1 byte (master) to 512 bytes (first commit) to larger than 512
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

The third commit fixes the DATA_STAT_AFTER_ERASE bit in SCR and
introduces an option to allow to erase blocks to 0x00.

The fourth commit optimizes block erase when erase-blocks-as-zero=true
is used, by passing the zeroing request down the to the block device.
Erasing 2GiB now takes 0.1s instead of 26s.

Signed-off-by: Christian Speich <c.speich@avm.de>
---
Changes in v2:
- Properly set DATA_STAT_AFTER_ERASE in SCR
- Add erase-blocks-as-zero option to allow the user to switch between
  0x00 and 0xFF for erased blocks.
- Link to v1: https://lore.kernel.org/qemu-devel/20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de

---
Christian Speich (4):
      hw/sd: Switch from byte-wise to buf+len read/writes
      hw/sd/sdhci: Don't use bounce buffer for ADMA
      hw/sd/sdcard: Add erase-blocks-as-zero option.
      hw/sd/sdcard: Optimize erase blocks as zero.

 hw/sd/core.c       |  16 +--
 hw/sd/sd.c         | 308 +++++++++++++++++++++++++++++++++++++++++------------
 hw/sd/sdhci.c      | 102 ++++++++++--------
 include/hw/sd/sd.h |  13 +--
 4 files changed, 307 insertions(+), 132 deletions(-)
---
base-commit: e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6
change-id: 20250912-sdcard-performance-b4-d908bbb5a004

Best regards,
-- 
Christian Speich <c.speich@avm.de>


