Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6F7CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBY0D-0001zO-AU; Wed, 22 Oct 2025 08:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXzL-0001Re-DQ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXzF-0008RS-MM
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761136240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FW6JqfxgLAwqsIH9ljEDUOQ58wJhevs/bEIifDWovxY=;
 b=al7RbK55wz4Yrd0CSC++4TnMsFQOXy6GN/QgeA5DOivuxztQaJrKDLPelbSJKQ/I3n5IXi
 WboVQOhTLCTyz0lNu0jIRW0YUhEkEGJvvWgC39t0zp56ziFTBFPLEAq12LEq6MBhp9TICG
 mxcSjAxnRllTttgVjt8LTOdDTUrfFe0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-9wrK0TKDO6OLGEKF03D3rw-1; Wed,
 22 Oct 2025 08:30:37 -0400
X-MC-Unique: 9wrK0TKDO6OLGEKF03D3rw-1
X-Mimecast-MFC-AGG-ID: 9wrK0TKDO6OLGEKF03D3rw_1761136236
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A31A1800D81; Wed, 22 Oct 2025 12:30:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37E671800584; Wed, 22 Oct 2025 12:30:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PULL 15/16] hw/arm/aspeed: ast2600-evb: Use w25q512jv flash model
Date: Wed, 22 Oct 2025 14:29:52 +0200
Message-ID: <20251022122953.877335-16-clg@redhat.com>
In-Reply-To: <20251022122953.877335-1-clg@redhat.com>
References: <20251022122953.877335-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The ast2600-evb machine model is using the "mx66u51235f" flash model,
which has issues with recent Linux kernels (6.15+) when reading SFDP
data.

Change the flash model to "w25q512jv", which is the model present on
some ast2600a3 EVB board and is known to work correctly with recent
kernels. Adjust the corresponding qtest to reflect the new JEDEC ID of
the w25q512jv flash.

Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20251016212437.1046135-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c               | 4 ++--
 tests/qtest/aspeed_smc-test.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 21ee62f75044..1bc9e534ba49 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1592,8 +1592,8 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
     amc->soc_name  = "ast2600-a3";
     amc->hw_strap1 = AST2600_EVB_HW_STRAP1;
     amc->hw_strap2 = AST2600_EVB_HW_STRAP2;
-    amc->fmc_model = "mx66u51235f";
-    amc->spi_model = "mx66u51235f";
+    amc->fmc_model = "w25q512jv";
+    amc->spi_model = "w25q512jv";
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON |
                      ASPEED_MAC3_ON;
diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index 52a00e6f0a7e..50a87e625001 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -134,10 +134,10 @@ static void test_ast2600_evb(AspeedSMCTestData *data)
                           "-drive file=%s,format=raw,if=mtd",
                           data->tmp_path);
 
-    /* fmc cs0 with mx66u51235f flash */
+    /* fmc cs0 with w25q512jv flash */
     data->flash_base = 0x20000000;
     data->spi_base = 0x1E620000;
-    data->jedec_id = 0xc2253a;
+    data->jedec_id = 0xef4020;
     data->cs = 0;
     data->node = "/machine/soc/fmc/ssi.0/child[0]";
     /* beyond 16MB */
-- 
2.51.0


