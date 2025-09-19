Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42E1CAC5AB
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbcW-0004jU-I2; Fri, 19 Sep 2025 09:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1uzaKu-0001yX-Vo; Fri, 19 Sep 2025 08:35:37 -0400
Received: from mail.avm.de ([212.42.244.120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1uzaKf-00005G-Hj; Fri, 19 Sep 2025 08:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1758285309; bh=UNVA4ooLunuHZ7TXvoiUVGY0o6aZJLlqjGBTEFJMut0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=vlO8Jz9sj9aJCjp6YbSgh28+WWd6uEJ+Vxrzuz4I7GhLOvVwR8JEoP/r51XxcN4xj
 yRgtpqfoFyaeRCJ55RKNuRnY8dPTY3BG3FGkohEuxOnUV2doLA7IEBiRf/MHg2YD5T
 JwR9LCo8bHVazq9EcmRA80lovdd9rTWMmoNq+7uQ=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 68cd4dfd-c042-7f0000032729-7f0000018860-1
 for <multiple-recipients>; Fri, 19 Sep 2025 14:35:09 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Fri, 19 Sep 2025 14:35:09 +0200 (CEST)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025091914351039-13017 ;
 Fri, 19 Sep 2025 14:35:10 +0200 
From: Christian Speich <c.speich@avm.de>
Date: Fri, 19 Sep 2025 14:34:42 +0200
Subject: [PATCH 3/4] hw/sd/sdcard: Erase blocks to zero
MIME-Version: 1.0
Message-Id: <20250919-sdcard-performance-b4-v1-3-e1037e481a19@avm.de>
References: <20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de>
In-Reply-To: <20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de>
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
X-purgate-ID: 149429::1758285309-1C67ADB6-52A2F63A/0/0
X-purgate-type: clean
X-purgate-size: 1175
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
X-Mailman-Approved-At: Fri, 19 Sep 2025 09:57:38 -0400
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

Currently, erased blocks are filled with 0xFF. However SCR Bit 55
(DATA_STAT_AFTER_ERASE) indicates that an erase produces zeros. One of
them is wrong.

As erasing to zero is more performant and allows block devices to
use optimizations, we the erase to produce 0x00.

Signed-off-by: Christian Speich <c.speich@avm.de>
---
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 23764ed99f36cf39ee7abe02f08e51897c05e718..94ef3cc62582717ee044c4b114b7f22bd1b4a256 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1115,7 +1115,6 @@ static void sd_erase(SDState *sd)
     sd->erase_end = INVALID_ADDRESS;
     sd->csd[14] |= 0x40;
 
-    memset(sd->data, 0xff, erase_len);
     for (erase_addr = erase_start; erase_addr <= erase_end;
          erase_addr += erase_len) {
         if (sdsc) {
@@ -1127,7 +1126,8 @@ static void sd_erase(SDState *sd)
                 continue;
             }
         }
-        sd_blk_write(sd, erase_addr, erase_len);
+        blk_pwrite_zeroes(sd->blk, erase_addr + sd_part_offset(sd),
+                          erase_len, 0);
     }
 }
 

-- 
2.43.0


