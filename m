Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237CCCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usxh2-0003F7-Oj; Mon, 01 Sep 2025 02:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20250901055630ee0accfa81000207a1-nrUymq@rts-flowmailer.siemens.com>)
 id 1usxgh-00039X-SY
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:06:43 -0400
Received: from mta-64-226.siemens.flowmailer.net ([185.136.64.226])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20250901055630ee0accfa81000207a1-nrUymq@rts-flowmailer.siemens.com>)
 id 1usxgc-0001x0-Fa
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:06:43 -0400
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20250901055630ee0accfa81000207a1 for <qemu-devel@nongnu.org>;
 Mon, 01 Sep 2025 07:56:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UKrXuWkhhtDdfM61O1kYCBCKRtPDr2G+/JbT7cj8dUM=;
 b=iBRT2/fgwJh1HJ8bxSli7LKmPrloiASjhL8k8QXJ1TPF3iaCVXmNNJwzcguyI4Hkahy91n
 ZH+ZyBrqJ7LQvekJqTFoIqr1w6rCsb0Jg6rDpHPpVG1iagQ8+EeicKouSYlVCsmeeH425FJs
 BHDDkbh6Ha7Larq7PEDVa+jCoOF5uo5zA4C+50zkEqhqAofk+Qbnyr2szD/bUcBs93+cOd28
 BQZRpfLjgtBMPXXdAhnDKK5wVBB5WGt8i4aBiuZDbEOHj+FRSqFan/jKYWyNF/A1n2jS4AlT
 ymz3fOfO6Njf+1EeJpradEK3S9ELiBcaN3ft8Na8PnDn5LXRH2QmufSw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block image
Date: Mon,  1 Sep 2025 07:56:21 +0200
Message-ID: <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1756706188.git.jan.kiszka@siemens.com>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.226;
 envelope-from=fm-294854-20250901055630ee0accfa81000207a1-nrUymq@rts-flowmailer.siemens.com;
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

The power-of-2 rule applies to the user data area, not the complete
block image. The latter can be concatenation of boot partition images
and the user data.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8c290595f0..16aee210b4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2789,7 +2789,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        blk_size = blk_getlength(sd->blk);
+        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
         if (blk_size > 0 && !is_power_of_2(blk_size)) {
             int64_t blk_size_aligned = pow2ceil(blk_size);
             char *blk_size_str;
-- 
2.43.0


