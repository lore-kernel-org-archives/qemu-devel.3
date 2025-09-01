Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B416CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usxgq-0003BZ-Ix; Mon, 01 Sep 2025 02:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202509010556306f63e0863a000207c1-szNMmg@rts-flowmailer.siemens.com>)
 id 1usxgg-00038X-5q
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:06:42 -0400
Received: from mta-64-226.siemens.flowmailer.net ([185.136.64.226])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202509010556306f63e0863a000207c1-szNMmg@rts-flowmailer.siemens.com>)
 id 1usxgb-0001wv-Vo
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:06:41 -0400
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202509010556306f63e0863a000207c1 for <qemu-devel@nongnu.org>;
 Mon, 01 Sep 2025 07:56:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=G+jTwrh/Tv10lyU83TPYT5+VrS51epr9jsr352ZMXzk=;
 b=rfa74Cdn2qGV3Vvfwn9ohPpVWzCtOSnqp0AbJsdQ1ppLkGklCbz28gbZG+hjz+KOIu7+7m
 x8HCTwL4QnPhoqHsqMVjZ3rLbup5JJasDkUf66Py+Zxymaw84kIdPZDaUU34HAWG2kJSJ0GM
 IDF/yBZW8u8nBtveK/GrXFJ0plXtkc0XBCQ53ddT8uEUUpcUszrKItCvbUro7CCnj8lnbIwm
 w26XxQ/32DM0ZJ3Nj2qIAUgRwmuchyjvPdldbNKFA0H/XkC23P4C2oC7JALK/YREtsXS9rn9
 YrOmcmF8/a04txxEppqRG+4/5uewFDSBficWVMprGSILHY3idFxuuENw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 2/8] hw/sd/sdcard: Add validation for boot-partition-size
Date: Mon,  1 Sep 2025 07:56:22 +0200
Message-ID: <1fff448da042bdf8cff7733ce67cadff4c540f1d.1756706188.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1756706188.git.jan.kiszka@siemens.com>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.226;
 envelope-from=fm-294854-202509010556306f63e0863a000207c1-szNMmg@rts-flowmailer.siemens.com;
 helo=mta-64-226.siemens.flowmailer.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Make sure we are not silently rounding down or even wrapping around,
causing inconsistencies with the provided image.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 hw/sd/sd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 16aee210b4..834392b0a8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2818,6 +2818,16 @@ static void sd_realize(DeviceState *dev, Error **errp)
         }
         blk_set_dev_ops(sd->blk, &sd_block_ops, sd);
     }
+    if (sd->boot_part_size % (128 * KiB) ||
+        sd->boot_part_size > 255 * 128 * KiB) {
+        char *size_str = size_to_str(sd->boot_part_size);
+
+        error_setg(errp, "Invalid boot partition size: %s", size_str);
+        g_free(size_str);
+        error_append_hint(errp,
+                          "The boot partition size must be multiples of 128K"
+                          "and not larger than 32640K.\n");
+    }
 }
 
 static void emmc_realize(DeviceState *dev, Error **errp)
-- 
2.43.0


