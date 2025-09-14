Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D745CAC594
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Sep 2025 13:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxmIW-0004bF-Gb; Sun, 14 Sep 2025 08:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20250914124648e491eeb33d000207db-ut1UNC@rts-flowmailer.siemens.com>)
 id 1uxmIH-0004Xl-6R
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 08:57:27 -0400
Received: from mta-65-228.siemens.flowmailer.net ([185.136.65.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20250914124648e491eeb33d000207db-ut1UNC@rts-flowmailer.siemens.com>)
 id 1uxmHz-0002N3-8t
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 08:57:24 -0400
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id
 20250914124648e491eeb33d000207db for <qemu-devel@nongnu.org>;
 Sun, 14 Sep 2025 14:46:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=s3ZtzpvKMW/LKc6jZTgrh0+bspaB/1gW/W4kkRDduB0=;
 b=Kbq4AyPK2zEyv4+MFuVyGywWanVTFfMkVu71VmIVDyX0191fQoIWnM6ldn42kpbZkB4xNE
 QbB+47xUEoOfnuZoml6A1Q2Kz7NDOZUYErlByq4U4KXQAyjsl/xQamMjeiAJO5mhkQzrAolT
 ILG3PX1c62934JAPBiOYCWNqvlixwb8CxkSk0o6+6LcHAXbSwRBoLP9MyTyI0wNBTLZ/Hl26
 IO5EBUiJy9QswTW0r7Ghx9Y8W0prKfTOWmpJjdrrjI3JqpoINBTJNqEoeGyUzoK6t54AWXTQ
 vrDBMfzfJBLi/10VECaTpFzgNbO8rhLjY9d94fPQKCLi6UU6nVrEB4sg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v4 2/6] hw/sd/sdcard: Allow user-instantiated eMMC
Date: Sun, 14 Sep 2025 14:46:42 +0200
Message-ID: <aa55b4a207713e1f8c01444e79b38b42c6e1c4d1.1757854006.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1757854006.git.jan.kiszka@siemens.com>
References: <cover.1757854006.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.65.228;
 envelope-from=fm-294854-20250914124648e491eeb33d000207db-ut1UNC@rts-flowmailer.siemens.com;
 helo=mta-65-228.siemens.flowmailer.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


