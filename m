Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77105CDB466
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waXIZ-0002Ph-BM; Fri, 19 Jun 2026 07:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIU-0002Lq-DS; Fri, 19 Jun 2026 07:22:06 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIQ-0005yG-EU; Fri, 19 Jun 2026 07:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=J9ToOT6z/gq7DtSjqnTgcFtuRjS+7vrlrxcJw76UIi4=; b=TFtlyTMDuoz/
 op4skxeFAFLV6Sy92M+hXP6s3gy1RgxH2go1+lOelJB+erb9r+Estzqn6d7L8Irh6avxodyxv+nvO
 R8s3g2e0sDV/WO4Wb6X+wzEiNPKErtcD5wn1WkcJlWUs3JvN/kq42dkCGfjX+Tm9fzc5uWchauC7p
 vjfA1vTtkIQu9MPggzpohl13PO1JWDKitSFOJSIVxjMEPZmcOtrobFtX9Cs04rbXO6E3XWUxAHNfQ
 ODCt4UugrmLEJdkigkFPJU5l+dVcP2ziVj3Tyi1LhDKtwY4VGo42RT3oZy/OEDHFC7pGnS/FWHDRT
 WSJEtUxpFFoRqOPoZmLDeg==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waXHo-0089QU-29;
 Fri, 19 Jun 2026 13:21:56 +0200
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 4/9] tests/qtest/ide-test: add a multi-sector ATAPI DMA read
 test
Date: Fri, 19 Jun 2026 13:21:52 +0200
Message-ID: <20260619112158.304782-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619112158.304782-1-den@openvz.org>
References: <20260619112158.304782-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

test_cdrom_pio_large() already exercises a multi-sector PIO read.
Add the DMA counterpart through the same cdrom_read_impl() helper so
the multi-block ATAPI DMA read path gets equivalent coverage.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ide-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 0fcfd0688c..2c674edf15 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -1159,6 +1159,11 @@ static void test_cdrom_dma(void)
     cdrom_read_impl(1, CDROM_DMA);
 }
 
+static void test_cdrom_dma_large(void)
+{
+    cdrom_read_impl(BYTE_COUNT_LIMIT * 4 / ATAPI_BLOCK_SIZE, CDROM_DMA);
+}
+
 int main(int argc, char **argv)
 {
     const char *base;
@@ -1218,6 +1223,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ide/cdrom/pio", test_cdrom_pio);
     qtest_add_func("/ide/cdrom/pio_large", test_cdrom_pio_large);
     qtest_add_func("/ide/cdrom/dma", test_cdrom_dma);
+    qtest_add_func("/ide/cdrom/dma_large", test_cdrom_dma_large);
 
     ret = g_test_run();
 
-- 
2.53.0


