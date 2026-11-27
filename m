Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17B5606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=gAhhqqk9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp1f-00032E-HF; Fri, 27 Nov 2026 01:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0t-00025Z-Dl; Fri, 27 Nov 2026 01:00:54 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0r-0001r8-Q8; Fri, 27 Nov 2026 01:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758881; bh=+ul0lCoaBpn9thNyWFNrnKLtWnF0MhMryc0+Af09kbE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gAhhqqk9ZmH30D1i0fi+qe+k1lh+JYunEZktmmdr/HYw8LXKyO5wm4O8IRHkCsCJp
 rwoLMLrzgXqDQTB53iMWGS5DfxLSOeH0SsMSOIEZR0Y27zrb7kWooHUzVrJxSmJb8E
 h04ev7p9Lp3gigrIS5SxHAQxKKvKelH7OI6OgPzHbwCO+w1rkXGtjDFbhKyY/zNF6r
 nnLLIqw8Ezcz/YQ+KyvNZ6UP12W1nvKFJ6F9cODlqBEwaqOTLJUP86wlRq4p0kRmCP
 CCk0HAjnvzsd9JGp3s8BCO/WTEbFkGbTHdsFI4RgJNzl1dUj+EgBKc2dHo/J9/Eqz0
 /r4Lv+xezypQQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A2C4C1EA308;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A070D469942;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8E9C9CF290; Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 125/140] hw/sd/sdcard: Do not abort when writing
 DAT lines on invalid cmd state
Date: Fri, 27 Nov 2026 08:53:51 +0300
Message-ID: <20261127055421.39015-66-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Since commit e2dec2eab04d, an illegal command resets
SDState::current_cmd to 0 but leaves the card in the receiving-data
state. Data written afterwards reaches the g_assert_not_reached()
in sd_write_data():

  CMD24 (WRITE_SINGLE_BLOCK)   -> receiving-data state
  CMD2  (illegal in SPI mode)  -> current_cmd = 0
  data token + data            -> sd_write_data(): abort

  ERROR:../hw/sd/sd.c:<line>:sd_write_data: code should not be reached

Commit bd6207903eb8 already fixed the read side. Fix the write side
the same way: log the guest error and ignore the data.

Cc: qemu-stable@nongnu.org
Fixes: e2dec2eab04d ("hw/sd/sdcard: Remove default case in read/write on DAT lines")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261123225349.54981-4-philmd@oss.qualcomm.com>
(cherry picked from commit a814ba092e39c67428a1337ed536ae0378730f27)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e541c57f8c3..07ec83dbd87 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2418,7 +2418,9 @@ static void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: DAT write illegal for command %s\n",
+                      __func__, sd->last_cmd_name);
+        break;
     }
 }
 
-- 
2.47.3


