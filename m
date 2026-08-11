Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE01C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNy-0002QQ-U9; Tue, 11 Aug 2026 12:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNd-0000rL-PU
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNa-0000jb-Cb
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BaeA7T8RVfwBgpnddgHWxh3sjpGb19alLjUHzJVORuo=;
 b=OyiMWlWwHcokzNx2yh+b2TVEl/8bxKmN5gEMp5brwbI5RrLik3WuVUaNfYAYiEGw21bSna
 eC0X68LUiX5gOUPX1lRmBIS+W4jrnx8zgqK8EeJSAQBfrk/uPInNqsXT/r4keQPRak+7Gb
 p2Hxdnqz9NNNbCNiOxir7cfjf6PylyY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-KmuvrRV_NnmC5H5VnlC7_g-1; Tue,
 11 Aug 2026 12:31:02 -0400
X-MC-Unique: KmuvrRV_NnmC5H5VnlC7_g-1
X-Mimecast-MFC-AGG-ID: KmuvrRV_NnmC5H5VnlC7_g_1786465860
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AAB3195608B; Tue, 11 Aug 2026 16:31:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCA5B195DF98; Tue, 11 Aug 2026 16:30:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 36/83] hw/gpio: pca9552: rename I2CSlave member to parent_obj
Date: Tue, 11 Aug 2026 18:28:51 +0200
Message-ID: <20260811162938.1403216-37-clg@redhat.com>
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

Use the conventional parent_obj name for the embedded I2CSlave instance.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-3-814575bc076b@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/gpio/pca9552.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 36bc4f86edb1..da21e56aabdf 100644
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
2.55.0


