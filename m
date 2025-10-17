Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916BFCCD1A2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9jM2-0005w9-V7; Fri, 17 Oct 2025 08:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202510171204011b1bab774e000207e5-PW3bf_@rts-flowmailer.siemens.com>)
 id 1v9jLr-0005pw-6s
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:14:32 -0400
Received: from mta-65-227.siemens.flowmailer.net ([185.136.65.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202510171204011b1bab774e000207e5-PW3bf_@rts-flowmailer.siemens.com>)
 id 1v9jLe-0005E8-R2
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:14:30 -0400
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 202510171204011b1bab774e000207e5 for <qemu-devel@nongnu.org>;
 Fri, 17 Oct 2025 14:04:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=o0vzWO7EP6ba9YHG0RLmyb2yOxun27xq6dQCAVZVuz4=;
 b=kseNPrmT9QTQNYWUckJSYQeBm9/nm2DI6jpoDvGMR8xxc/E2zbWJefbkTQXZDczx9RDZUb
 hAf6ey7SAWLb5nI5fQrhgNvtEA440SRQCONPn/zOFBeIMKotWrITh6efgxlzB84a+C8vEB1H
 lZrIHmLIDBcPHedV885FSpdpz5fBNSG4g3HLpZHoz861fnP4qTLM3WddYQ3pl97k+bK/U5fw
 8b5Q5tvnimiMQjy12406kwvul+9ebZvxAKRzvvZJDjoSW08mYApZZgTSd9ZV9yvtEYdtELCq
 dktGVIojIzBwwGgk+jZFDb9c7J+uSLr6kAHnqaIO973/HPMijP+Xvaaw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v5 2/6] hw/sd/sdcard: Allow user-instantiated eMMC
Date: Fri, 17 Oct 2025 14:03:54 +0200
Message-ID: <90fc6201696fcf0e5fd0493365bc32b217aa9d6e.1760702638.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1760702638.git.jan.kiszka@siemens.com>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.65.227;
 envelope-from=fm-294854-202510171204011b1bab774e000207e5-PW3bf_@rts-flowmailer.siemens.com;
 helo=mta-65-227.siemens.flowmailer.net
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.272,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Enable user-instantiation so that PCI-attached eMMCs can be created for
virt machines, for QA purposes for the eMMC model itself and for complex
firmware/OS integrations using the upcoming RPMB partition support.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 hw/sd/sd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d1e1bb4f0e..305ea251cb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2928,8 +2928,6 @@ static void emmc_class_init(ObjectClass *klass, const void *data)
     dc->desc = "eMMC";
     dc->realize = emmc_realize;
     device_class_set_props(dc, emmc_properties);
-    /* Reason: Soldered on board */
-    dc->user_creatable = false;
 
     sc->proto = &sd_proto_emmc;
 
-- 
2.51.0


