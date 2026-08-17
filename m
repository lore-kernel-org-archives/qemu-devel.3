Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D5FC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtJV-0004cI-AN; Mon, 17 Aug 2026 05:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtIh-0003uA-G9; Mon, 17 Aug 2026 05:06:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtIf-0001kM-Ck; Mon, 17 Aug 2026 05:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957506; bh=yVnDzgJxHRKLs1AbfBa6eDRrhVWVnNWtrTUWSLOlkbA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NFMUZ7XDY7fd3/y3z2IN4yJVHkG72XiUv/OQD7RogMj81IwrnYR6ucC8OEcwIm0Wp
 k1W61crELazNINxwU9gnxp9BT1XgQHGeXUdKODK1UXyb0wdBAvBU8OlCxbkA0zeKcq
 LE3P6wmEk8/InvpnXIStn6UTD2ougcjDt94aKQapSvWJ/5wN+Auv5+2ivfOwoERCOm
 Pus7ci9FJlDGlpQZJQidHaIxGKbLYb5w/gTNd5Q1zwIsCOPouRK+HtgUECrJkGA/6H
 rkdWAQ6pZKKp09O8akakVSIZSN+s0aHPtL+O6wbuitHaKlL9WoCucwuB6jM0+wn1WI
 Qu5kqSox2FHNw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4C0151CBA46;
 Mon, 17 Aug 2026 12:05:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2BC4340D028;
 Mon, 17 Aug 2026 12:05:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D40CC30D04; Mon, 17 Aug 2026 12:05:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Joshua Daley <jdaley@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 18/42] pc-bios/s390-ccw: fix out-of-bounds read in
 iso_get_file_size()
Date: Mon, 17 Aug 2026 12:04:23 +0300
Message-ID: <20260817090453.2034156-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joshua Daley <jdaley@linux.ibm.com>

In the dir_rem[level] == 0 case, level is decremented, then
a virtio_read() is issued on sec_loc[level]. If level is -1, then the
4 bytes before the static sec_loc array are read, and the virtio_read()
is issued on that garbage block number.

Guard the call to virtio_read() against the value of level to prevent
this.

Fixes: 869648e87eeb ("pc-bios/s390-ccw: El Torito 16-bit boot image size field workaround")
Cc: qemu-stable@nongnu.org
Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260727115052.24289-4-borntraeger@linux.ibm.com
[farman@linux.ibm.com: Fixed typo on Christian's tag, added qemu-stable]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit a9f1e84c6b8213fb1bfc664b1ffa1a8d975a69b6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 420ee32eff8..ed6e8cbbc78 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -902,7 +902,7 @@ static inline long iso_get_file_size(uint32_t load_rba)
         if (dir_rem[level] == 0) {
             /* Nothing remaining */
             level--;
-            if (virtio_read(sec_loc[level], temp)) {
+            if (level >= 0 && virtio_read(sec_loc[level], temp)) {
                 puts("Failed to read ISO directory");
                 return -EIO;
             }
-- 
2.47.3


