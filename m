Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F6ACA0EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 07:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uq59p-0006Pb-Ca; Sun, 24 Aug 2025 03:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202508240718413748b289bd8334bda8-BdXSN3@rts-flowmailer.siemens.com>)
 id 1uq59n-0006Oe-A5
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 03:28:51 -0400
Received: from mta-64-225.siemens.flowmailer.net ([185.136.64.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202508240718413748b289bd8334bda8-BdXSN3@rts-flowmailer.siemens.com>)
 id 1uq59k-0005Me-KT
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 03:28:51 -0400
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202508240718413748b289bd8334bda8 for <qemu-devel@nongnu.org>;
 Sun, 24 Aug 2025 09:18:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=G+jTwrh/Tv10lyU83TPYT5+VrS51epr9jsr352ZMXzk=;
 b=hq0J2dXNanr2ZwiUa/vIEjLl+uGfbxwsY/guly6JU/8FnCOJ20tZNIGX7bcsSqbQE6+wke
 gQNVj+Uw6a0GXsC97wLtfwkiXCIn8/o4dVRJ74GAdNmj1Y3BegWbkdgQb1CiqLt2SAiOCXMq
 nZzIANE0jJemcNbVWDBYUx2g822cFEqM1u48Xlleqso/3wGBu9l2iVQijwR4htuZ77avyoiX
 u0WKTKFGFAzoFY3grscV2xUmVWj4Y4PXpsAh1iY3Aqq/hMKK0+IvkqNrs+nNQZxEcy1JNGxY
 DOFCQ8H2UH+WKmbV9G+s82Mz71wTfNBHp2/pPpWmGVfIzgEcc+RXdUAQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/8] hw/sd/sdcard: Add validation for boot-partition-size
Date: Sun, 24 Aug 2025 09:18:34 +0200
Message-ID: <e9f85cfabad79c4afbacff896b012ff9940895ac.1756019920.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1756019920.git.jan.kiszka@siemens.com>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.225;
 envelope-from=fm-294854-202508240718413748b289bd8334bda8-BdXSN3@rts-flowmailer.siemens.com;
 helo=mta-64-225.siemens.flowmailer.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


