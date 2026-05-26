Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3CFCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn0D-0005BZ-Us; Tue, 26 May 2026 04:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0A-0005Ac-4J
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn07-0007Sj-B4
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RwQQORSoHbpxB3+b3+LMm34qhoW6a91fGHA0i5e1pSQ=;
 b=dvHq3FEmWopTJpFOWsPn/basgjxoFfzFC4cJvZKcH1gHtK7o7pajwHIE5dFedx+gKS/ez/
 UxI0BLbVN8Odj2bQagr9jaDHtmAEdtbHwxxUFyIMShVEmJrFA7jRbRJdnDWDUFqBpDdHU+
 rxBdXDD7qHj2Ag8Nx/SdGhWIrmmIeik=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-q1g6V6_xM86es_hlM6jPpQ-1; Tue,
 26 May 2026 04:18:56 -0400
X-MC-Unique: q1g6V6_xM86es_hlM6jPpQ-1
X-Mimecast-MFC-AGG-ID: q1g6V6_xM86es_hlM6jPpQ_1779783535
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 082D118002DC; Tue, 26 May 2026 08:18:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DCAC1800267; Tue, 26 May 2026 08:18:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PULL 01/37] hw/misc/aspeed_scu: Fix AST2600_RNG definitions
Date: Tue, 26 May 2026 10:18:12 +0200
Message-ID: <20260526081848.651835-2-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
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


