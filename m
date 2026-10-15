Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC028CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKTK-0004y6-Lo; Thu, 15 Oct 2026 08:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTI-0004sC-G0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTG-0005Xt-PQ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CkRVfEpXYMnyfG9yh5h4tsLjoXXIzPwfDpnhTe/js40=;
 b=dTgYsEmOFUPFbmQUH+SlIPVRzjLs2F9onjxUVZBdtsYjVshnAm0slJ/HENSW0DOgw36IJM
 e0kAXkqvWgXinY8OaqEDoQAbJzvGJsntawViGXDBpUSrZ7qNIfKOqhNeGJxE2Q14Kk/c4m
 B+otPZRTLBHqRVFsQUt7TMrXFBFAiKE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-tR66jFoRPXqP7sAsRkSNSQ-1; Thu,
 15 Oct 2026 12:22:00 +0000
X-MC-Unique: tR66jFoRPXqP7sAsRkSNSQ-1
X-Mimecast-MFC-AGG-ID: tR66jFoRPXqP7sAsRkSNSQ_1792066919
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E0D71956072; Thu, 15 Oct 2026 12:21:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BB8A7D5; Thu, 15 Oct 2026 12:21:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/21] tests/qtest/aspeed-acry: Allocate SRAM buffers on the
 heap
Date: Thu, 15 Oct 2026 14:21:32 +0200
Message-ID: <20261015122151.889017-3-clg@redhat.com>
In-Reply-To: <20261015122151.889017-1-clg@redhat.com>
References: <20261015122151.889017-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The ACRY RSA qtest allocates two ACRY_SRAM_SIZE buffers on the
stack. Since each buffer is nearly 9 KiB, this unnecessarily increases
the stack usage of test_modexp_rsa() and may cause unexpected failures
on environments with a limited stack size.

This reduces the stack usage while preserving the existing test
behavior.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Link: https://lore.kernel.org/qemu-devel/20260910012422.4065857-1-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-acry-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/aspeed-acry-test.c b/tests/qtest/aspeed-acry-test.c
index ec348c220664..51048d697cf6 100644
--- a/tests/qtest/aspeed-acry-test.c
+++ b/tests/qtest/aspeed-acry-test.c
@@ -327,8 +327,8 @@ static void test_modexp_rsa(const void *opaque)
         .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
         .u.rsa.padding_alg = QCRYPTO_RSA_PADDING_ALGO_RAW,
     };
-    uint8_t dram_buf[ACRY_SRAM_SIZE] = { 0 };
-    uint8_t sram_buf[ACRY_SRAM_SIZE] = { 0 };
+    g_autofree uint8_t *dram_buf = g_malloc0(ACRY_SRAM_SIZE);
+    g_autofree uint8_t *sram_buf = g_malloc0(ACRY_SRAM_SIZE);
     uint8_t result[ACRY_MAX_BYTES] = { 0 };
     QTestState *qts;
 
@@ -345,7 +345,7 @@ static void test_modexp_rsa(const void *opaque)
     put_bignum_be_bytes(dram_buf, ACRY_MOD_OFFSET, t->n, t->n_len);
     put_bignum_be_bytes(dram_buf, ACRY_DATA_OFFSET, t->m, t->m_len);
 
-    qtest_memwrite(qts, c->dram_addr, dram_buf, sizeof(dram_buf));
+    qtest_memwrite(qts, c->dram_addr, dram_buf, ACRY_SRAM_SIZE);
 
     qtest_writel(qts, c->acry_addr + ACRY_DMA_CMD, ACRY_DMA_CMD_DMEM_AHB);
     qtest_writel(qts, c->acry_addr + ACRY_DMA_SRC, c->dram_addr);
@@ -362,7 +362,7 @@ static void test_modexp_rsa(const void *opaque)
     g_assert_cmphex(qtest_readl(qts, c->acry_addr + ACRY_STATUS), ==,
                     ACRY_STATUS_RSA_DONE);
 
-    qtest_memread(qts, c->sram_addr, sram_buf, sizeof(sram_buf));
+    qtest_memread(qts, c->sram_addr, sram_buf, ACRY_SRAM_SIZE);
     get_bignum_be_bytes(sram_buf, ACRY_DATA_OFFSET, result, t->c_len);
     g_assert_cmpmem(result, t->c_len, t->c, t->c_len);
 
-- 
2.56.0


