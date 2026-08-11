Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE5DC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpO0-0002dG-Vr; Tue, 11 Aug 2026 12:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNi-0001Tj-UM
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNh-0000lS-2F
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hWgHS+a9nGFf22zZsb7nNIMZ0M9viWh83NHppztR4aM=;
 b=h152d0eL4+kefUhN+R2fzD3692NmgenFX501p0N8sG6a1KKzp3vNNgDp7pLmvxTt+lUqz2
 MeNqok+msjDl50xnD5AoZ3canMIzbTp62DoLXLj9SzYozMi+bmaFz472tCklx16ShIM+Mm
 odntBfMoAQuK8liUw4/b/gCAk93l62w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-PcltlInLPx-NLfFnRYvYdg-1; Tue,
 11 Aug 2026 12:31:06 -0400
X-MC-Unique: PcltlInLPx-NLfFnRYvYdg-1
X-Mimecast-MFC-AGG-ID: PcltlInLPx-NLfFnRYvYdg_1786465865
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECF53195604C; Tue, 11 Aug 2026 16:31:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44787195DF91; Tue, 11 Aug 2026 16:31:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 38/83] hw/gpio: pca9552: declare pca9555 device as an alias of
 pca9535 device
Date: Tue, 11 Aug 2026 18:28:53 +0200
Message-ID: <20260811162938.1403216-39-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

PCA9555 HW is mostly identical to PCA9535.
PCA9555 HW features pull-up resistors that are not available on PCA9535.

Pull-up are not handled by current PCA955x implementation and PCA9535
already initializes input as Hi-Z.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-5-814575bc076b@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/gpio/pca9552.h | 1 +
 hw/gpio/pca9552.c         | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/hw/gpio/pca9552.h b/include/hw/gpio/pca9552.h
index 71479ea0006e..5299c13829b3 100644
--- a/include/hw/gpio/pca9552.h
+++ b/include/hw/gpio/pca9552.h
@@ -13,5 +13,6 @@
 #define TYPE_PCA955X "pca955x"
 #define TYPE_PCA9552 "pca9552"
 #define TYPE_PCA9535 "pca9535"
+#define TYPE_PCA9555 "pca9555"
 
 #endif
diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index ffeb438d2ab4..3b9b63eb1766 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -523,7 +523,7 @@ static void pca9552_class_init(ObjectClass *oc, const void *data)
     pc->has_led_support = true;
 }
 
-static void pca9535_class_init(ObjectClass *oc, const void *data)
+static void pca95x5_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCA955xClass *pc = PCA955X_CLASS(oc);
@@ -553,7 +553,12 @@ static const TypeInfo pca955x_types[] = {
     {
         .name          = TYPE_PCA9535,
         .parent        = TYPE_PCA955X,
-        .class_init    = pca9535_class_init,
+        .class_init    = pca95x5_class_init,
+    },
+    {
+        .name          = TYPE_PCA9555,
+        .parent        = TYPE_PCA955X,
+        .class_init    = pca95x5_class_init,
     }
 };
 
-- 
2.55.0


