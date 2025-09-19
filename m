Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFCACAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbcM-0004Yb-NC; Fri, 19 Sep 2025 09:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1uzaKn-0001xR-W0; Fri, 19 Sep 2025 08:35:30 -0400
Received: from mail.avm.de ([212.42.244.120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1uzaKe-00005D-L9; Fri, 19 Sep 2025 08:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1758285309; bh=+CcdsuLZvpVt3WE/Oie6//pHCVefmVxTe48yvU7P96s=;
 h=From:Subject:Date:To:Cc:From;
 b=eGCtSXqJK4nE3nwc520Meit6RRG3NPBfKvpdGDhq8RE+ps9zsG5D2CZ9YQ+ecUt/2
 fpxSPrR16QzfUsoRhpAPYjz9+jCyKFptM1o66BZApPg2WAM61ysc04H0E5+tGoWqax
 rZm8Ow6Tg4SFLBny4VaVcKUF+IfVTd6AuMmJs58o=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 68cd4dfd-c042-7f0000032729-7f0000018842-1
 for <multiple-recipients>; Fri, 19 Sep 2025 14:35:09 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Fri, 19 Sep 2025 14:35:09 +0200 (CEST)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025091914351037-13014 ;
 Fri, 19 Sep 2025 14:35:10 +0200 
From: Christian Speich <c.speich@avm.de>
Subject: [PATCH 0/4] hw/sd: Improve performance of read/write/erase
Date: Fri, 19 Sep 2025 14:34:39 +0200
Message-Id: <20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN9NzWgC/x3MPQqAMAxA4atIZgOxKFivIg79STWDVVIQQby7x
 fEb3nugsAoXmJoHlC8pcuSKrm0gbC6vjBKrwZAZyHYGSwxOI56s6dDd5cDoe4yWRu/94Ih6qO2
 pnOT+v/Pyvh+0vtaKZwAAAA==
X-Change-ID: 20250912-sdcard-performance-b4-d908bbb5a004
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Christian Speich
 <c.speich@avm.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 19.09.2025 14:35:10,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 19.09.2025 14:35:10, Serialize complete at 19.09.2025 14:35:10
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1758285309-25674DB6-0E91F56A/0/0
X-purgate-type: clean
X-purgate-size: 1707
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=212.42.244.120; envelope-from=c.speich@avm.de;
 helo=mail.avm.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Sep 2025 09:57:35 -0400
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

For erasing the third commit changes the erase operation to write zeros,
as indicated by DATA_STAT_AFTER_ERASE in SCR.

The fourth commit allows erasure in large blocks, to speed it up
significantly. Erasing 2GiB now takes 0.1s instead of 26s.

Signed-off-by: Christian Speich <c.speich@avm.de>
---
Christian Speich (4):
      hw/sd: Switch from byte-wise to buf+len read/writes
      hw/sd/sdhci: Don't use bounce buffer for ADMA
      hw/sd/sdcard: Erase blocks to zero
      hw/sd/sdcard: Erase in large blocks

 hw/sd/core.c       |  16 +---
 hw/sd/sd.c         | 277 ++++++++++++++++++++++++++++++++++++++++-------------
 hw/sd/sdhci.c      | 102 +++++++++++---------
 include/hw/sd/sd.h |  13 +--
 4 files changed, 277 insertions(+), 131 deletions(-)
---
base-commit: e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6
change-id: 20250912-sdcard-performance-b4-d908bbb5a004

Best regards,
-- 
Christian Speich <c.speich@avm.de>


