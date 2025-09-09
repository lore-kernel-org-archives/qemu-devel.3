Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57824CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvxzM-0001HE-LK; Tue, 09 Sep 2025 09:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202509091251014a936fadca000207b3-nYJC2j@rts-flowmailer.siemens.com>)
 id 1uvxyP-0000OS-CG
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:01:34 -0400
Received: from mta-65-227.siemens.flowmailer.net ([185.136.65.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202509091251014a936fadca000207b3-nYJC2j@rts-flowmailer.siemens.com>)
 id 1uvxyG-0003pf-ME
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:01:21 -0400
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 202509091251014a936fadca000207b3 for <qemu-devel@nongnu.org>;
 Tue, 09 Sep 2025 14:51:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=s3ZtzpvKMW/LKc6jZTgrh0+bspaB/1gW/W4kkRDduB0=;
 b=qt0v4GZRheTw2yvDY7N27ZtDcTtoM9w+2JFCj+qkDyr2yTnXOPGoD1sLw0Wh0P3hpca2de
 uWEx169S93yGD1IDztXOC41pDEENrKHNcCV+Ygfi9z/T9FIPdfc8GZ6tWIDZ9UNHwE9G4Mu5
 Rd6xbrqmyVTMiW/TA5Tq2f/c7qjGIc3FL3J7/B2Kp8PeLz+8zp9UVuQslWBU8CMuAV/vGmd/
 U6jmjeIcppgnpTmcVhuWYEDFJYNaA7EyNGDri5OLkukbmnBRQm+QlDaF1aQbmdUm5RkyPe7p
 xyvyc0r8V6IUXjh6ycKCeWJtgS7d05bXKX6ke7gtD8izc6ErYOXWTGxw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>
Subject: [PATCH v3 2/6] hw/sd/sdcard: Allow user-instantiated eMMC
Date: Tue,  9 Sep 2025 14:50:52 +0200
Message-ID: <5a372b6e093fc64c31822c6b1e6fc4d3cf006df7.1757422256.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1757422256.git.jan.kiszka@siemens.com>
References: <cover.1757422256.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.65.227;
 envelope-from=fm-294854-202509091251014a936fadca000207b3-nYJC2j@rts-flowmailer.siemens.com;
 helo=mta-65-227.siemens.flowmailer.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Enable user-instantiation so that PCI-attached eMMCs can be created for
virt machines, for QA purposes for the eMMC model itself and for complex
firmware/OS integrations using the upcoming RPMB partition support.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 hw/sd/sd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b42cd01d1f..b86cbf0fbd 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2926,8 +2926,6 @@ static void emmc_class_init(ObjectClass *klass, const void *data)
     dc->desc = "eMMC";
     dc->realize = emmc_realize;
     device_class_set_props(dc, emmc_properties);
-    /* Reason: Soldered on board */
-    dc->user_creatable = false;
 
     sc->proto = &sd_proto_emmc;
 
-- 
2.51.0


