Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230FBC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh59r-0006kL-0y; Tue, 07 Jul 2026 08:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh59i-0006X6-8D
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh59g-0005Dd-OD
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783428244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mWFIqi8bILGYzO4m3LD405SUESbjC9vfP9FQlaBjmw=;
 b=gRaXBEr4jllaAAXIZtjGEmSuAoVrdSA0XtLx2vJitkD9R+Xq55jH4ZSjGE2v2pOI2ZF462
 Ozdc60uEN4hazagG6rkWT1oSnsV0O1RlRk2XL9K8NjxILkdEXezUA9RFQWSsBIoLKMyJwq
 8HGi9X9daI5ddrp3E/O8/An9qc5fTz8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-Jb2pndpwN3uLVg0BNdbx_Q-1; Tue,
 07 Jul 2026 08:44:03 -0400
X-MC-Unique: Jb2pndpwN3uLVg0BNdbx_Q-1
X-Mimecast-MFC-AGG-ID: Jb2pndpwN3uLVg0BNdbx_Q_1783428240
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39A72195422A; Tue,  7 Jul 2026 12:44:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.253])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED6BB36924; Tue,  7 Jul 2026 12:43:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: yujun <yujun@kylinos.cn>, Peter Maydell <peter.maydell@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 3/8] hw/gpio/pca9552: fix off-by-one in QOM led index validation
Date: Tue,  7 Jul 2026 14:43:44 +0200
Message-ID: <20260707124349.662198-4-clg@redhat.com>
In-Reply-To: <20260707124349.662198-1-clg@redhat.com>
References: <20260707124349.662198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: yujun <yujun@kylinos.cn>

pca955x_get_led() and pca955x_set_led() accept led indices equal to
pin_count, but valid indices are 0..pin_count-1.  For a 16-pin device,
led16 passes the current check and then accesses an LS register past
max_reg.

Use the same >= pin_count bounds check as pca9554_set_pin() and the
gpio input handler assert in this file.

Fixes: a90d8f84674 ("misc/pca9552: Add qom set and get")
Signed-off-by: yujun <yujun@kylinos.cn>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260629074133.187549-1-yujun@kylinos.cn
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/gpio/pca9552.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 472d8ad95715..b13ac9fd9ce5 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -311,8 +311,8 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (led < 0 || led > k->pin_count) {
-        error_setg(errp, "%s invalid led %s", __func__, name);
+    if (led < 0 || led >= k->pin_count) {
+        error_setg(errp, "%s: invalid led %s", __func__, name);
         return;
     }
     /*
@@ -352,8 +352,8 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (led < 0 || led > k->pin_count) {
-        error_setg(errp, "%s invalid led %s", __func__, name);
+    if (led < 0 || led >= k->pin_count) {
+        error_setg(errp, "%s: invalid led %s", __func__, name);
         return;
     }
 
-- 
2.54.0


