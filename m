Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64800E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 06:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLGH7-0006Wr-F1; Wed, 11 Dec 2024 01:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGGU-0005AU-TU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:32:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGGQ-000071-80
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733898714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dp8cN/Re5CjwVH//34TjuIYELnEzdRHS/3JO2tzYX34=;
 b=AQptyYpSE0NLBuufROrjumcod95NADbwYiFwzNQqcIA7PikjFClpV2FHmMrjb4JuOtqiPN
 hM3wubuSxag/r5dm92XrlMMX9t93xlernjlFK0gMKAcE9IZbN5RmY5w/MmAiYIIZGfKimL
 2hy/MRDeB0L6LdMuffSozA+rkB7oAo8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-A1PjmvB7OqWsvKxS33kzrQ-1; Wed,
 11 Dec 2024 01:31:50 -0500
X-MC-Unique: A1PjmvB7OqWsvKxS33kzrQ-1
X-Mimecast-MFC-AGG-ID: A1PjmvB7OqWsvKxS33kzrQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDE161955EB1; Wed, 11 Dec 2024 06:31:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E6461956054; Wed, 11 Dec 2024 06:31:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/24] test/qtest/aspeed_smc-test: Support to test AST1030
Date: Wed, 11 Dec 2024 07:30:55 +0100
Message-ID: <20241211063058.1222038-22-clg@redhat.com>
In-Reply-To: <20241211063058.1222038-1-clg@redhat.com>
References: <20241211063058.1222038-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add test_ast1030_evb function and reused testcases for AST1030 testing.
The base address, flash base address and ce index of fmc_cs0 are
0x7E620000, 0x80000000 and 0, respectively.
The default flash model of fmc_cs0 is "w25q80bl" whose size is 1MB,
so set jedec_id 0xef4014.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20241127091543.1243114-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed_smc-test.c | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index 30f997679ce2..c5c38e23c5b2 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -774,11 +774,50 @@ static void test_ast2600_evb(TestData *data)
     qtest_add_data_func("/ast2600/smc/read_status_reg",
                         data, test_read_status_reg);
 }
+
+static void test_ast1030_evb(TestData *data)
+{
+    int ret;
+    int fd;
+
+    fd = g_file_open_tmp("qtest.m25p80.w25q80bl.XXXXXX",
+                         &data->tmp_path, NULL);
+    g_assert(fd >= 0);
+    ret = ftruncate(fd, 1 * 1024 * 1024);
+    g_assert(ret == 0);
+    close(fd);
+
+    data->s = qtest_initf("-machine ast1030-evb "
+                          "-drive file=%s,format=raw,if=mtd",
+                          data->tmp_path);
+
+    /* fmc cs0 with w25q80bl flash */
+    data->flash_base = 0x80000000;
+    data->spi_base = 0x7E620000;
+    data->jedec_id = 0xef4014;
+    data->cs = 0;
+    data->node = "/machine/soc/fmc/ssi.0/child[0]";
+    /* beyond 512KB */
+    data->page_addr = 0x800 * FLASH_PAGE_SIZE;
+
+    qtest_add_data_func("/ast1030/smc/read_jedec", data, test_read_jedec);
+    qtest_add_data_func("/ast1030/smc/erase_sector", data, test_erase_sector);
+    qtest_add_data_func("/ast1030/smc/erase_all",  data, test_erase_all);
+    qtest_add_data_func("/ast1030/smc/write_page", data, test_write_page);
+    qtest_add_data_func("/ast1030/smc/read_page_mem",
+                        data, test_read_page_mem);
+    qtest_add_data_func("/ast1030/smc/write_page_mem",
+                        data, test_write_page_mem);
+    qtest_add_data_func("/ast1030/smc/read_status_reg",
+                        data, test_read_status_reg);
+}
+
 int main(int argc, char **argv)
 {
     TestData palmetto_data;
     TestData ast2500_evb_data;
     TestData ast2600_evb_data;
+    TestData ast1030_evb_data;
     int ret;
 
     g_test_init(&argc, &argv, NULL);
@@ -786,13 +825,16 @@ int main(int argc, char **argv)
     test_palmetto_bmc(&palmetto_data);
     test_ast2500_evb(&ast2500_evb_data);
     test_ast2600_evb(&ast2600_evb_data);
+    test_ast1030_evb(&ast1030_evb_data);
     ret = g_test_run();
 
     qtest_quit(palmetto_data.s);
     qtest_quit(ast2500_evb_data.s);
     qtest_quit(ast2600_evb_data.s);
+    qtest_quit(ast1030_evb_data.s);
     unlink(palmetto_data.tmp_path);
     unlink(ast2500_evb_data.tmp_path);
     unlink(ast2600_evb_data.tmp_path);
+    unlink(ast1030_evb_data.tmp_path);
     return ret;
 }
-- 
2.47.1


