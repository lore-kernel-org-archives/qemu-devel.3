Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D32CC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqcz-0000rw-0D; Thu, 09 Jul 2026 11:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqcx-0000oA-E1; Thu, 09 Jul 2026 11:25:27 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqcv-0008TD-W2; Thu, 09 Jul 2026 11:25:27 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id D01352003D0;
 Thu,  9 Jul 2026 17:25:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783610724;
 bh=qgrnOtzqZvVPJsK5XjTyaMP4kgKLz0kEI72U6v+M054=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WXgaY601rijQdNRWMFpx9y33fiXbKfS/QD7fdc1hsF/ORWHY7pPqKXQRqP32ebgze
 WZXw/Fl0UpsVEdHgtcf0WXR+O2nIFqMptCOHLXGPVVFLRSF0XN9X1PLm4E0AIBsHW1
 60RQ+3loTnTiYK9muYCXZktaGf4070YuZlWLjyMrsBcldqVTUZ/MoT3buVOTXedqiE
 b09cemCz19vh7xDfhfe9ZIPREHQFe3DI8syiIBm+PZAoYM5bgD1F6vHPCiIBa1Ko9B
 35sxDSF6i6QdXHkBGbmqNqti5AxgnfUc0HEtfD/SLhRG6xTF1c+GP8oIifIbYQOWFW
 Wh1YaXAujigeA==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:41 +0200
Subject: [PATCH 03/29] hw/gpio: pca9552: rename I2CSlave member to parent_obj
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-3-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
In-Reply-To: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Corey Minyard <cminyard@mvista.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610647; l=1001;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=qgrnOtzqZvVPJsK5XjTyaMP4kgKLz0kEI72U6v+M054=;
 b=OSzJuhjJeYttM7oSV/lNlb91xHHvYPaB+zncy8jIftzN4KhrU6QD6KzegRewFyL7gYOBtgrFi
 4tzJKb4Iea9A3RfQ98tBpXqtWLlJBiDyRPdd/jJlCVYcHI95Drjzzqn
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use the conventional parent_obj name for the embedded I2CSlave instance.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/gpio/pca9552.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 36bc4f86ed..da21e56aab 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -34,7 +34,7 @@ OBJECT_DECLARE_TYPE(PCA955xState, PCA955xClass, PCA955X)
 
 struct PCA955xState {
     /*< private >*/
-    I2CSlave i2c;
+    I2CSlave parent_obj;
     /*< public >*/
 
     uint8_t len;
@@ -401,7 +401,7 @@ static const VMStateDescription pca9552_vmstate = {
         VMSTATE_UINT8(pointer, PCA955xState),
         VMSTATE_UINT8_ARRAY(regs, PCA955xState, PCA955X_NR_REGS),
         VMSTATE_UINT8_ARRAY(ext_state, PCA955xState, PCA955X_PIN_COUNT_MAX),
-        VMSTATE_I2C_SLAVE(i2c, PCA955xState),
+        VMSTATE_I2C_SLAVE(parent_obj, PCA955xState),
         VMSTATE_END_OF_LIST()
     }
 };

-- 
2.50.1


