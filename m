Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B784C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 16:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKsZ-000267-Cm; Thu, 21 Mar 2024 12:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rnKsL-0001pm-21
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rnKsJ-0005bF-34
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711036957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qb6T0wX/a0zoWU83voW1zu0dyWTiTnln4IKFAYcZEIw=;
 b=QNVsPVM6vO96Ml91ykSl4BuBpv6QEMmgE9S0XzvSD6Elh+VXlwS1FWvAkp365MXxWNWFM0
 zUstCvxti7n4yExZrdU+9iEUGj8OntDYEBqXTMI0C67AQgt6MNXODyKaQhb6NmHuvEzRq4
 ABYCzlHS6Y085aQATork94k/IR3TOZo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-gzpTJzI3OaK3rCZM01VS9w-1; Thu, 21 Mar 2024 12:02:33 -0400
X-MC-Unique: gzpTJzI3OaK3rCZM01VS9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAC5B803C8C;
 Thu, 21 Mar 2024 16:02:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.194.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE5A03C54;
 Thu, 21 Mar 2024 16:02:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: Glenn Miles <milesg@linux.vnet.ibm.com>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] misc/pca9554: Fix check of pin range value in property
 accessors
Date: Thu, 21 Mar 2024 17:01:54 +0100
Message-ID: <20240321160154.901829-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Coverity detected an "Integer handling" issue with the pin value :

  In expression "state >> pin", right shifting "state" by more than 7
  bits always yields zero.  The shift amount, "pin", is as much as 8.

In practice, this should not happen because the properties "pin8" and
above are not created. Nevertheless, fix the range to avoid this warning.

Fixes: CID 1534917
Fixes: de0c7d543bca ("misc: Add a pca9554 GPIO device model")
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/pca9554.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/pca9554.c b/hw/misc/pca9554.c
index 778b32e4430a8b618322c26b1b185ed3ead97cc4..5e31696797d9564666ece6fe17737ee2a9733e96 100644
--- a/hw/misc/pca9554.c
+++ b/hw/misc/pca9554.c
@@ -160,7 +160,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
+    if (pin < 0 || pin >= PCA9554_PIN_COUNT) {
         error_setg(errp, "%s invalid pin %s", __func__, name);
         return;
     }
@@ -187,7 +187,7 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
+    if (pin < 0 || pin >= PCA9554_PIN_COUNT) {
         error_setg(errp, "%s invalid pin %s", __func__, name);
         return;
     }
-- 
2.44.0


