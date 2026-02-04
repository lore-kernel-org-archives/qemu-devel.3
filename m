Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FFDE95374
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBT-0000hH-Ei; Wed, 04 Feb 2026 05:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaB0-0000Qq-7s
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaAy-0003y9-MD
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6kkGdiMInY4jNEsOYYm3r+vDmyuak5bnYi3QmZSEto=;
 b=JdvP0gkGbGS3Mvfs64WCCIxrDrlBukQl/ksOwUTosP4IHnaCmCKxidokjU4YMgwZ0F9cHc
 HbAQtKjqI8VX5yymz7AqBhhYVieZta8pkgrL98YvusQbICziaGD/zQP+KbnOecBqFeHTnj
 g6p8MZ/I+IgN8wPT6cKPjdS6SvQpqe0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-Y1hTJvcWO7es8VYE1EjBKw-1; Wed,
 04 Feb 2026 05:31:57 -0500
X-MC-Unique: Y1hTJvcWO7es8VYE1EjBKw-1
X-Mimecast-MFC-AGG-ID: Y1hTJvcWO7es8VYE1EjBKw_1770201117
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B71451954B14; Wed,  4 Feb 2026 10:31:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4142C180066A; Wed,  4 Feb 2026 10:31:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Patrick Williams <patrick@stwcx.xyz>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/45] hw/arm/aspeed: catalina: use pca9535
Date: Wed,  4 Feb 2026 11:30:58 +0100
Message-ID: <20260204103136.1795455-8-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Patrick Williams <patrick@stwcx.xyz>

A few entries in the catalina model were using the PCA9552 chip
because it was "close enough" in function.  Since there is a PCA9535
model now, switch to use it.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260121-pca9535-v1-2-164640e622ff@stwcx.xyz
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600_catalina.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 4edb30bb16b8..65495a524ea5 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -480,7 +480,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* i2c0mux1ch1 */
     /* io_expander7 - pca9535@20 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
-                            TYPE_PCA9552, 0x20);
+                            TYPE_PCA9535, 0x20);
     /* eeprom@50 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
                           gb200io_eeprom, gb200io_eeprom_len);
@@ -497,7 +497,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* i2c0mux4ch1 */
     /* io_expander8 - pca9535@21 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
-                            TYPE_PCA9552, 0x21);
+                            TYPE_PCA9535, 0x21);
     /* eeprom@50 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
                           gb200io_eeprom, gb200io_eeprom_len);
-- 
2.52.0


