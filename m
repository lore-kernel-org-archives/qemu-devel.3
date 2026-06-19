Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC883CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waXIZ-0002Pk-DG; Fri, 19 Jun 2026 07:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIT-0002KE-Jg; Fri, 19 Jun 2026 07:22:05 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIQ-0005yQ-Qd; Fri, 19 Jun 2026 07:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=s31N2WSzGJMifOsR5kGPV+f7nNm1CIU04brTAJY0Gk8=; b=XTEBtmoY4jAt
 A+rtchLPwjbgyRKLPUhV19rtRerk+2iyfWkalEc2jU9t3MslykAkA9vm8yOeTp2WXAiq17glihCC1
 Nh4AJFn3YlI6m9Gp3Du6d/6iNBQhsDUQxIqkaQv5XOAlzB9vkJSWnd7nYhVQZL7uJARo06bFlA0Cu
 8TIsFmQvJD9YUmu5ackhForC8Vzh71XW8iMuXHqbd7nPVLetT37cIBvq+2jLI+LoC8HebofF55fhA
 aPoD7gTWb7kF8v/wRKiXkYS6lBD2ly99MViOiWGW8zrSsq61GaWip3s1SHm4sshcfpPbVo4J33UTP
 nekGaLch1RGixerqzAyJew==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waXHp-0089QU-2Z;
 Fri, 19 Jun 2026 13:21:57 +0200
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 7/9] tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
Date: Fri, 19 Jun 2026 13:21:55 +0200
Message-ID: <20260619112158.304782-8-den@openvz.org>
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

Add /ahci/cdrom/{pio,dma}/raw: read several sectors with READ CD in
raw mode (atapi_raw), so the ATAPI 2352-byte unpack path is exercised
through the AHCI delivery, which IDE coverage does not reach. Each
sector's 2048-byte payload is verified at its in-sector offset.

The PIO case uses a byte-count limit of one raw sector per DRQ burst:
libqos asserts a one-sector PIO transfer, and the multi-sector unpack
loop is already covered by the IDE raw test.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ahci-test.c | 68 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 44799eea15..58bc04b3ef 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1565,6 +1565,31 @@ static int ahci_cb_cmp_buff(AHCIQState *ahci, AHCICommand *cmd,
     return 0;
 }
 
+static int ahci_cb_cmp_raw(AHCIQState *ahci, AHCICommand *cmd,
+                           const AHCIOpts *opts)
+{
+    unsigned char *tx = opts->opaque;
+    unsigned char *rx;
+    unsigned i, nsectors;
+
+    if (!opts->size) {
+        return 0;
+    }
+
+    nsectors = opts->size / ATAPI_RAW_SECTOR_SIZE;
+    rx = g_malloc0(opts->size);
+    qtest_bufread(ahci->parent->qts, opts->buffer, rx, opts->size);
+    /* Each raw sector carries its 2048-byte payload past a 16-byte header. */
+    for (i = 0; i < nsectors; i++) {
+        g_assert_cmphex(memcmp(rx + i * ATAPI_RAW_SECTOR_SIZE + 16,
+                               tx + i * ATAPI_SECTOR_SIZE,
+                               ATAPI_SECTOR_SIZE), ==, 0);
+    }
+    g_free(rx);
+
+    return 0;
+}
+
 static void ahci_test_cdrom(int nsectors, bool dma, uint8_t cmd,
                             bool override_bcl, uint16_t bcl)
 {
@@ -1625,6 +1650,47 @@ static void test_cdrom_pio_multi(void)
     ahci_test_cdrom_read10(3, false);
 }
 
+static void ahci_test_cdrom_raw(int nsectors, bool dma)
+{
+    AHCIQState *ahci;
+    unsigned char *tx;
+    char *iso;
+    int fd;
+    AHCIOpts opts = {
+        .size = (uint64_t)ATAPI_RAW_SECTOR_SIZE * nsectors,
+        .atapi = true,
+        .atapi_dma = dma,
+        .atapi_raw = true,
+        .set_bcl = true,
+        .bcl = ATAPI_RAW_SECTOR_SIZE, /* one raw sector per DRQ burst */
+        .post_cb = ahci_cb_cmp_raw,
+    };
+    uint64_t iso_size = (uint64_t)ATAPI_SECTOR_SIZE * (nsectors + 1);
+
+    fd = prepare_iso(iso_size, &tx, &iso);
+    opts.opaque = tx;
+
+    ahci = ahci_boot_and_enable("-drive if=none,id=drive0,file=%s,format=raw "
+                                "-M q35 "
+                                "-device ide-cd,drive=drive0 ", iso);
+
+    ahci_exec(ahci, ahci_port_select(ahci), CMD_ATAPI_READ_CD, &opts);
+
+    g_free(tx);
+    ahci_shutdown(ahci);
+    remove_iso(fd, iso);
+}
+
+static void test_cdrom_dma_raw(void)
+{
+    ahci_test_cdrom_raw(3, true);
+}
+
+static void test_cdrom_pio_raw(void)
+{
+    ahci_test_cdrom_raw(3, false);
+}
+
 /*
  * Regression test: a buffered ATAPI read completing after a command
  * engine restart must not dereference the cleared cur_cmd. Cover both
@@ -2100,8 +2166,10 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ahci/cdrom/dma/single", test_cdrom_dma);
     qtest_add_func("/ahci/cdrom/dma/multi", test_cdrom_dma_multi);
+    qtest_add_func("/ahci/cdrom/dma/raw", test_cdrom_dma_raw);
     qtest_add_func("/ahci/cdrom/pio/single", test_cdrom_pio);
     qtest_add_func("/ahci/cdrom/pio/multi", test_cdrom_pio_multi);
+    qtest_add_func("/ahci/cdrom/pio/raw", test_cdrom_pio_raw);
 
     qtest_add_func("/ahci/cdrom/pio/bcl", test_atapi_bcl);
     qtest_add_func("/ahci/cdrom/eject", test_atapi_tray);
-- 
2.53.0


