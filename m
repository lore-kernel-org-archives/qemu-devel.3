Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DABFC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFO9-00068D-V4; Mon, 18 Mar 2024 11:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7gLY=KY=redhat.com=clg@ozlabs.org>)
 id 1rmFO7-00067i-Cj; Mon, 18 Mar 2024 11:58:59 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7gLY=KY=redhat.com=clg@ozlabs.org>)
 id 1rmFO4-0001P1-T2; Mon, 18 Mar 2024 11:58:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tyzzv0KZ3z4wcN;
 Tue, 19 Mar 2024 02:58:51 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tyzzr1VTFz4wbr;
 Tue, 19 Mar 2024 02:58:47 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2] ppc/pnv: I2C controller is not user creatable
Date: Mon, 18 Mar 2024 16:58:44 +0100
Message-ID: <20240318155844.224193-1-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7gLY=KY=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The I2C controller is a subunit of the processor. Make it so and avoid
QEMU crashes.

  $ build/qemu-system-ppc64 -S -machine powernv9 -device pnv-i2c
  qemu-system-ppc64: ../hw/ppc/pnv_i2c.c:521: pnv_i2c_realize: Assertion `i2c->chip' failed.
  Aborted (core dumped)

Fixes: 263b81ee15af ("ppc/pnv: Add an I2C controller model")
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
Reported-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/ppc/pnv_i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index 4581cc5e5d4645ab3e358d983a633e33a214c425..eec5047ce83f842108b53a6e2bd9869a81f14ac1 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -557,6 +557,9 @@ static void pnv_i2c_class_init(ObjectClass *klass, void *data)
 
     xscomc->dt_xscom = pnv_i2c_dt_xscom;
 
+    /* Reason: This device is part of the CPU and cannot be used separately */
+    dc->user_creatable = false;
+
     dc->desc = "PowerNV I2C";
     dc->realize = pnv_i2c_realize;
     device_class_set_props(dc, pnv_i2c_properties);
-- 
2.44.0


