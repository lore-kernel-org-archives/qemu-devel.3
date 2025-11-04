Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16289CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGrT-0002uO-2G; Tue, 04 Nov 2025 08:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202511041303528b9198a251000207db-J5kvXi@rts-flowmailer.siemens.com>)
 id 1vGGrM-0002qi-0a
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:14:04 -0500
Received: from mta-65-227.siemens.flowmailer.net ([185.136.65.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202511041303528b9198a251000207db-J5kvXi@rts-flowmailer.siemens.com>)
 id 1vGGrG-0005VU-SB
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:14:03 -0500
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 202511041303528b9198a251000207db for <qemu-devel@nongnu.org>;
 Tue, 04 Nov 2025 14:03:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Vy09HTh3JYnvcuwY5IAEqh0Cuyp2/EvXPk0j44vcsDg=;
 b=hGbtOt5y0V7tvI9SnCflQ9iVdDSWpbmTPko1gvz0JPjPf8xQ8EOjBWwHOhloHsvFvssPQw
 8wxIrhj63/1TkwmAzLy2PiuMO1ziiWCzRdakkPbHTGd+UBISU+MOhVb87wYF0DRB5PbZnG6q
 nx9Tp4S7pYm36vaW+dtX60r6T0Q4hEzHhIfTfFcB6ALMREhdG91oKYBQlqXm4Nk0IKCsE/5n
 sXXE1ctCws8gc05LQBXPPz2Nd634fjvGDgmD/eqhPEKef0BNWg1j/ISXqdVq4ffqkbLrtuXZ
 afE9aEhK9X7RBduWNUZNEWOb8PG4gWJr9yOJqtt83g6LeeDtr+APHpZw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v6 2/6] hw/sd/sdcard: Allow user-instantiated eMMC
Date: Tue,  4 Nov 2025 14:03:46 +0100
Message-ID: <e515cc80de261ff03b3141724298f20313259a85.1762261430.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1762261430.git.jan.kiszka@siemens.com>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.65.227;
 envelope-from=fm-294854-202511041303528b9198a251000207db-J5kvXi@rts-flowmailer.siemens.com;
 helo=mta-65-227.siemens.flowmailer.net
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

Enable user-instantiation so that eMMCs can be created for PCI-attached
SD/MMC host controllers (such as sdhci-pci) on virt machines, for QA
purposes for the eMMC model itself and for complex firmware/OS
integrations using the upcoming RPMB partition support.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 hw/sd/sd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 76e915e190..e43e1a10eb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2930,8 +2930,6 @@ static void emmc_class_init(ObjectClass *klass, const void *data)
     dc->desc = "eMMC";
     dc->realize = emmc_realize;
     device_class_set_props(dc, emmc_properties);
-    /* Reason: Soldered on board */
-    dc->user_creatable = false;
 
     sc->proto = &sd_proto_emmc;
 
-- 
2.51.0


