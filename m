Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB51606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wv6bDop7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN33t-00035s-9R; Sat, 31 Oct 2026 02:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33R-0002sI-VP
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33Q-0002m6-0Y
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocOUOxWV/NefxOXeedYoDKce1VrE//8WUCYMHiB4vZU=;
 b=Wv6bDop7avimycDwn6WQ13eNr5AwT8BrbGkQFz19aQ63b8qTDD+8sVB3VJUkzvNl0bNrvV
 6ZHUl6mlEs1d2Daia2heE/o2a+/TxvQIy2wbKXoV9aQmQXIs6SWJnhnXxkQg1twfNK/ZMG
 FLdgLuCcPQFQI7KicJT0jP0FIDTYQPk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-IdCoNTfLNQetnq5vYHeMyQ-1; Sat,
 31 Oct 2026 02:59:00 -0400
X-MC-Unique: IdCoNTfLNQetnq5vYHeMyQ-1
X-Mimecast-MFC-AGG-ID: IdCoNTfLNQetnq5vYHeMyQ_1793429940
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D76E11800871; Sat, 31 Oct 2026 06:58:59 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 720B41800677; Sat, 31 Oct 2026 06:58:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/34] tests/qtest/aspeed_smc: Add AST1040 SMC tests
Date: Sat, 31 Oct 2026 07:58:01 +0100
Message-ID: <20261031065823.191966-13-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add SMC qtests for the AST1040 EVB using a 4 MiB W25Q33PW flash
connected to FMC CS0.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261028023154.48395-13-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed_smc-test.c | 61 +++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index 59c96bd68ae8..34010e283f25 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -240,12 +240,69 @@ static void test_ast1030_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_write_page_qor);
 }
 
+static void test_ast1040_evb(AspeedSMCTestData *data)
+{
+    int ret;
+    int fd;
+
+    fd = g_file_open_tmp("qtest.m25p80.w25q33pw.XXXXXX",
+                         &data->tmp_path, NULL);
+    g_assert(fd >= 0);
+    ret = ftruncate(fd, 4 * 1024 * 1024);
+    g_assert(ret == 0);
+    close(fd);
+
+    data->s = qtest_initf("-machine ast1040-evb "
+                          "-device w25q33pw,bus=ssi.0,cs=0x0,drive=fmc0 "
+                          "-blockdev node-name=fmc0,driver=file,filename=%s",
+                          data->tmp_path);
+
+    /* fmc cs0 with w25q33pw flash */
+    data->flash_base = 0x80000000;
+    data->spi_base = 0x74000000;
+    data->jedec_id = 0xef6016;
+    data->cs = 0;
+    data->node = "/machine/soc/fmc/ssi.0/child[0]";
+    /* beyond 512KB */
+    data->page_addr = 0x800 * FLASH_PAGE_SIZE;
+
+    qtest_add_data_func("/ast1040/smc/read_jedec",
+                        data, aspeed_smc_test_read_jedec);
+    qtest_add_data_func("/ast1040/smc/erase_sector",
+                        data, aspeed_smc_test_erase_sector);
+    qtest_add_data_func("/ast1040/smc/erase_all",
+                        data, aspeed_smc_test_erase_all);
+    qtest_add_data_func("/ast1040/smc/write_page",
+                        data, aspeed_smc_test_write_page);
+    qtest_add_data_func("/ast1040/smc/read_page_mem",
+                        data, aspeed_smc_test_read_page_mem);
+    qtest_add_data_func("/ast1040/smc/write_page_mem",
+                        data, aspeed_smc_test_write_page_mem);
+    qtest_add_data_func("/ast1040/smc/read_status_reg",
+                        data, aspeed_smc_test_read_status_reg);
+    qtest_add_data_func("/ast1040/smc/write_page_qpi",
+                        data, aspeed_smc_test_write_page_qpi);
+    qtest_add_data_func("/ast1040/smc/read_page_mem_fast_read",
+                        data, aspeed_smc_test_read_page_mem_fast_read);
+    qtest_add_data_func("/ast1040/smc/write_page_fast_read",
+                        data, aspeed_smc_test_write_page_fast_read);
+    qtest_add_data_func("/ast1040/smc/read_page_mem_dor",
+                        data, aspeed_smc_test_read_page_mem_dor);
+    qtest_add_data_func("/ast1040/smc/write_page_dor",
+                        data, aspeed_smc_test_write_page_dor);
+    qtest_add_data_func("/ast1040/smc/read_page_mem_qor",
+                        data, aspeed_smc_test_read_page_mem_qor);
+    qtest_add_data_func("/ast1040/smc/write_page_qor",
+                        data, aspeed_smc_test_write_page_qor);
+}
+
 int main(int argc, char **argv)
 {
     AspeedSMCTestData palmetto_data;
     AspeedSMCTestData ast2500_evb_data;
     AspeedSMCTestData ast2600_evb_data;
     AspeedSMCTestData ast1030_evb_data;
+    AspeedSMCTestData ast1040_evb_data;
     int ret;
 
     g_test_init(&argc, &argv, NULL);
@@ -254,20 +311,24 @@ int main(int argc, char **argv)
     test_ast2500_evb(&ast2500_evb_data);
     test_ast2600_evb(&ast2600_evb_data);
     test_ast1030_evb(&ast1030_evb_data);
+    test_ast1040_evb(&ast1040_evb_data);
     ret = g_test_run();
 
     qtest_quit(palmetto_data.s);
     qtest_quit(ast2500_evb_data.s);
     qtest_quit(ast2600_evb_data.s);
     qtest_quit(ast1030_evb_data.s);
+    qtest_quit(ast1040_evb_data.s);
     unlink(palmetto_data.tmp_path);
     unlink(ast2500_evb_data.tmp_path);
     unlink(ast2600_evb_data.tmp_path);
     unlink(ast1030_evb_data.tmp_path);
+    unlink(ast1040_evb_data.tmp_path);
     g_free(palmetto_data.tmp_path);
     g_free(ast2500_evb_data.tmp_path);
     g_free(ast2600_evb_data.tmp_path);
     g_free(ast1030_evb_data.tmp_path);
+    g_free(ast1040_evb_data.tmp_path);
 
     return ret;
 }
-- 
2.56.0


