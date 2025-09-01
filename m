Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1135CCA1000
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usxgt-0003Cy-R3; Mon, 01 Sep 2025 02:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20250901055630fa224eee7e00020764-mSyvn6@rts-flowmailer.siemens.com>)
 id 1usxgg-00038f-8i
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:06:42 -0400
Received: from mta-64-228.siemens.flowmailer.net ([185.136.64.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20250901055630fa224eee7e00020764-mSyvn6@rts-flowmailer.siemens.com>)
 id 1usxgb-0001ww-VT
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:06:41 -0400
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20250901055630fa224eee7e00020764 for <qemu-devel@nongnu.org>;
 Mon, 01 Sep 2025 07:56:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xFI1VA5/EHO61KzQO5OccwT8cCfNkw46hYpCrq2jLa0=;
 b=DZbkFIu/XR+YFaWYli1pZSlGD1o5uAptvsDtxY0sJsGx21Mblh1N1f15wcRsSoMfaSlbGz
 kum4AE0i/QaW4XqWPYPM2iRkQujd/ARcCvYW1WL+d7MnevwEEy8tpWEwjkT/QX70PB65gWLT
 /VSVOA+x8XqZIbcdm+mdKyUzWSlHbiuRGGUB4j7FJVrV1TidClXxADK8kNmNvyiJ8TBDk9v4
 C5etNrWHtM8rLwfLVssbdKC0Yx3qEFat9lxU4pc9MkxANIDGklPhjkjb9o/X16zO5/UJ42mT
 YocV3ghIbFpLho9XNUUYgdVHHa4EFggS2RZG/nY91VDeRrdNHANlP7XQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 3/8] hw/sd/sdcard: Allow user-instantiated eMMC
Date: Mon,  1 Sep 2025 07:56:23 +0200
Message-ID: <1f9b0ea005e49578ffcb6c6a5175d8b9af514a03.1756706188.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1756706188.git.jan.kiszka@siemens.com>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.228;
 envelope-from=fm-294854-20250901055630fa224eee7e00020764-mSyvn6@rts-flowmailer.siemens.com;
 helo=mta-64-228.siemens.flowmailer.net
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

Enable user-instantiation so that PCI-attached eMMCs can be created for
virt machines, for QA purposes for the eMMC model itself and for complex
firmware/OS integrations using the upcoming RPMB partition support.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 hw/sd/sd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 834392b0a8..8a4f58295b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2912,8 +2912,6 @@ static void emmc_class_init(ObjectClass *klass, const void *data)
     dc->desc = "eMMC";
     dc->realize = emmc_realize;
     device_class_set_props(dc, emmc_properties);
-    /* Reason: Soldered on board */
-    dc->user_creatable = false;
 
     sc->proto = &sd_proto_emmc;
 
-- 
2.43.0


