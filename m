Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F312BCD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2IO-0002gA-KH; Wed, 13 May 2026 01:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wN2II-0002fa-IR
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wN2IG-0004xT-Ff
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778650683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XkYNinsYEGPyxvrSjwgj1bi8typGS7e9QH2V7czgNYg=;
 b=W+HyKPnvCruS0iha0vVplOBs5SHQ3Lu1Unw221jK63/2r/SoMwYvyTRK+eDUyhrJpeRqRt
 2fIz04ys2s6CMvgF9r7U6+iLcFF7eAzZ9FfpwniEkYXWxlnkz5qkSgJkqJPxHQ8SWRo68D
 da2c/qSQFENyYCylvYVXq45WexdloAA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-Hv9iJrN3PPCwm3sO9CeqaQ-1; Wed,
 13 May 2026 01:37:58 -0400
X-MC-Unique: Hv9iJrN3PPCwm3sO9CeqaQ-1
X-Mimecast-MFC-AGG-ID: Hv9iJrN3PPCwm3sO9CeqaQ_1778650676
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDE441800359; Wed, 13 May 2026 05:37:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.49.156])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3B421800576; Wed, 13 May 2026 05:37:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] hw/misc/aspeed_scu: Fix AST2600_RNG definitions
Date: Wed, 13 May 2026 07:37:49 +0200
Message-ID: <20260513053749.132759-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit e09cf36321f6 ("hw: aspeed_scu: Add AST2600 support") introduced
a typo on the definitions of the Random Number Generator registers.
Fix that.

The implementation of RNG_CTRL and RNG_DATA should be rechecked on HW
since the QEMU implementation always generates random data, regardless
of RNG_CTRL. A comment in aspeed_ast2600_scu_read() admits uncertainty
about the behavior :

    /*
     * On hardware, RNG_DATA works regardless of the state of the
     * enable bit in RNG_CTRL
     *
     * TODO: Check this is true for ast2600
     */

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2350
Fixes: e09cf36321f6 ("hw: aspeed_scu: Add AST2600 support")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_scu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index e4160356e443..9d9f43e6b563 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -128,8 +128,8 @@
 #define AST2600_HW_STRAP2         TO_REG(0x510)
 #define AST2600_HW_STRAP2_CLR     TO_REG(0x514)
 #define AST2600_HW_STRAP2_PROT    TO_REG(0x518)
-#define AST2600_RNG_CTRL          TO_REG(0x524)
-#define AST2600_RNG_DATA          TO_REG(0x540)
+#define AST2600_RNG_CTRL          TO_REG(0x520)
+#define AST2600_RNG_DATA          TO_REG(0x524)
 #define AST2600_CHIP_ID0          TO_REG(0x5B0)
 #define AST2600_CHIP_ID1          TO_REG(0x5B4)
 
-- 
2.54.0


