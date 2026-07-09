Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B37C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whtwy-0008C7-NK; Thu, 09 Jul 2026 14:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whtww-0008BW-4c; Thu, 09 Jul 2026 14:58:18 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whtwt-0002gc-Uk; Thu, 09 Jul 2026 14:58:17 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 1D6A42003CC;
 Thu,  9 Jul 2026 20:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783623492;
 bh=Og/EdQF3BJSVUTQy/T7zKNQEi0RRayayqEMltnNOpns=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=TgKh9eq+h7RDdhf+L5QRhNOEmNzATiOaDIwIifj9osSHXap69utKXdv3RUQZA/H0H
 n0QmbSs1Wu9JJrJM/h+sq2TuGWVSgL2qICw9Lijfy2RhCam/HKo3xzaxYAH83cAGL9
 I0eziH25xS8u5qYSzgH9zxQS+8c5ZbrXUJrzINYg5oNzY1TsdWbxuzYOi/QzlCWHJC
 DK3qC0V3JSzKJZI2qonhLIRhCXNP4/2G1yph9FP6c83OJ0PnxnmYagJh04MPpKlGK2
 X9OJWJp0f9g8HYAaLynQh9OHdIog1Vb8CtHzXuIFWLWvhMyeNpPDoSIsBGnlAr3kfz
 fo9NHg7ZyacJg==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:10 +0200
Subject: [PATCH 18/29] hw/gpio: pca9554: expose pin%d as a string property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-18-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
In-Reply-To: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610580; l=986;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=Og/EdQF3BJSVUTQy/T7zKNQEi0RRayayqEMltnNOpns=;
 b=MlU4WcsZwkKcYcO8lWK95khyoBhIcRP+CacLZ4dM8/0dvdQKx3wsOamKB21V/WZJIMD/eQP0b
 OwNiOAyRBNwAE3/ZZHqmLPIP6XvVZBsl9l5Go77C5l2Sn//a5HyvXii
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The pinN properties are accessed with visit_type_str() (values "low" and
"high"), but were registered as type "bool", so introspection advertised
a boolean while the accessors require a string. Register them as "str",
matching the PCA9555 GPIO variant.

Fixes: de0c7d543bca ("misc: Add a pca9554 GPIO device model")
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/gpio/pca9554.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index d4746719f9..904698cdce 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -280,7 +280,7 @@ static void pca9554_initfn(Object *obj)
         char *name;
 
         name = g_strdup_printf("pin%d", pin);
-        object_property_add(obj, name, "bool", pca9554_get_pin, pca9554_set_pin,
+        object_property_add(obj, name, "str", pca9554_get_pin, pca9554_set_pin,
                             NULL, NULL);
         g_free(name);
     }

-- 
2.50.1


