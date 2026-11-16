Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D02606A33E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=oWvrH30j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3IL-0008N8-0r; Mon, 16 Nov 2026 15:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Hx-0007Ny-4r; Mon, 16 Nov 2026 15:26:54 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Hu-0000QU-Kt; Mon, 16 Nov 2026 15:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860763; bh=iDO8YgBNisLMtpFBHoP6bEyivsTJkDaD+wQA//0mWcs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oWvrH30jrToRBT2egbetuLtXjypbTyei4dQWBIueAuEUpog+mEGOuGhSc8rolXuKa
 KAsfAiKYz4bt/giGFiROGlQfS4ayiiMO2DsihARfa/gsYQydN+z0z9oRS6bZfugpcN
 RVt53/bxIalGIWIfmaYjOmJ8WRSX2Yp4M52//qqjZU2vQwL/z9VSW7WrYvV2CJZcER
 0Inib7XCzM6ipOFj8DCyP7iX9UIYSS4XDC549Qmyp1hSuG/s4cFlU0wMMyATXJqXV/
 m9TFt1BuyX78PPpZdj3P5RFx6LRId2FqHPyJbj/YDIfJRDYerQ64ZB+sGwSf81dQVT
 1IGYsGB8DlPZA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DBF1A1E71A2;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D8A5045FBCE;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8EC91B8E60; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 13/63] hw/arm/imx8mm-evk: Fix reference count of SoC
 object
Date: Mon, 16 Nov 2026 23:24:52 +0300
Message-ID: <20261116202554.535325-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
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

From: Bernhard Beschow <shentey@gmail.com>

Using sysbus_realize_and_unref() requires object_new() rather than
object_new_with_props(), otherwise the initial reference count is
subtracted twice, i.e. ends up being one too low.

Cc: qemu-stable@nongnu.org
Fixes: 7bcd1f30bc83 ("hw/arm: Add the i.MX 8MM EVK board")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-6-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit c814f8c9f8e788051ef16dba6300af93f9c0190d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 6b7774d3e25..9a9f8921da6 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -77,8 +77,8 @@ static void imx8mm_evk_init(MachineState *machine)
         .modify_dtb = imx8mm_evk_modify_dtb,
     };
 
-    s = FSL_IMX8MM(object_new_with_props(TYPE_FSL_IMX8MM, OBJECT(machine),
-                                         "soc", &error_fatal, NULL));
+    s = FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
-- 
2.47.3


