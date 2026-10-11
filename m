Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497FECA9EC9
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 08:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFoj4-0004n0-Ri; Sun, 11 Oct 2026 04:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xFoib-0004lY-Eo; Sun, 11 Oct 2026 04:15:43 -0400
Received: from nx32.node02.secure-mailgate.com ([192.162.87.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xFoiX-0007zf-VU; Sun, 11 Oct 2026 04:15:40 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xFoiQ-006Bkm-RI; Sun, 11 Oct 2026 10:15:32 +0200
Received: from Zeuss.fritz.box (p57b2f030.dip0.t-ipconnect.de [87.178.240.48])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 6A6902822BF;
 Sun, 11 Oct 2026 10:15:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1791706530;
 bh=N9CW0umtO5jHS1FKkB4i45mVJvOBd+DrUfypt5Lfr60=;
 h=From:To:Cc:Subject:Date:From;
 b=j5uD7n06nbr0OUQHppMaY2HTUJMwR4ZslwVaeTeRe5EXZ2JncKJck3LOVYeJ37fk1
 hzrFNUxsKglqQTnlikz0/RX1t907uAuELP8KxBpYJZknLlfyvgPUTlhkXc6A4L5xAw
 Y34MIDi7xwzHddjk39qDNxUaVyE9wsXQxN12E9GM=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest/fdc-test: check block accounting of non-DMA reads
Date: Sun, 11 Oct 2026 10:14:23 +0200
Message-ID: <20261011081433.73397-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179170652962.461305.5772288224786867367@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (0.000809823774037)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVjurkRo2qtXosESzvqMEMVm/WLvIrIKqE+
 sN+qrxiXRSu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4bYmmOs//ygbGr8eLVtMExwS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMjhCsHWm9UVSw2wJDtNO9+dOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS78HF9DWBc0WhbQl3RlROHMl5OjAPt7LlMbhgG9BOAmXwBM2j5REykHorDckk/GS
 XOeJ+u+yrSHikBnwQI7OhPtOt12UKwWWu0uRyF+HHpfXfr5pxnekR5gKyX+MMXIWKOkgxlD67q1I
 Gx5c0htKd4nZUthSv47vkSPENH+ftmELJxpLJ3Xc+Mv8qa2UQxOJ7ZnRFg37IGw7dk2dYrO1zkmH
 CpwS2oZfMuFqjF2RVWG3hy/E+UX+2HRZAwqk+0mElDSRI7NMK5S50kjVVp4t0URWpqFpLVefeduZ
 N+JHmMpG0x9NEum6+ayztSJ+2CI/y5AKvo1HkBEmDLlSM9m2plnfARM40/5kvSvjPlK9O7dFaIfV
 aCHpEB6cFH6WJxE4ZtnMSo/WKlRNZzf4XVeCGinmRmCJWk4HLhMwFIOYGQXuduMQtc9+zeM/bn6i
 zqBlxYgWIjAfssmYooOojbMVMkKJo3dG96axRy+iXygDw2+Bm+JDUQg6tT9MLS0x/f6bZfTkD6Gr
 5MDzFdkrr3JxFjrsNjMV9Ofg1ecGMS6f0O9nWShVoZrkssanAkdYnqPukWYYHCxVMyzsJd+YpoKs
 GdJH0Xy50uUJhMQ8Rx8ikSDcs2jZfddmferlOspaJYe9WqCSNqEnoVfavZrdfSy9x20RFhzyp4dK
 iG0rpA0WSV5yoHDFJZLqjzsPy9CtBkGhUMOpyKA69LF1Ge2GaGfxmfrvYx9wAiRqmOW8oSbE6cLC
 SuWjiWw7Q/zMGXa1uX3ak8AmaAdePjOfvAeIcA+vxeovAu21kK656rT9uyJ/sjgT/6bByKmsrCbi
 xnqDMpbNOpXQ8IocMdGcSaiMqwNDMscPOKPwWY9jlVwvLaNUlXdN
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.32; envelope-from=christian@quante.one;
 helo=nx32.node02.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since commit 9c4c09d2a663 ("hw/block/fdc: account for read and write
requests"), the floppy reports its reads and writes in query-blockstats.
Check this for the existing non-DMA reads: send_read_no_dma_command()
now compares rd_operations and rd_bytes before and after the command,
one 512-byte request for every sector the test reads through the FIFO.

Without the accounting, read_no_dma_1, read_no_dma_18 and
read_no_dma_19 fail with rd_operations at 0 instead of 2, 36 and 38.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Christian Quante <christian@quante.one>
---
 tests/qtest/fdc-test.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
index 33d1b83aeb..a10951f204 100644
--- a/tests/qtest/fdc-test.c
+++ b/tests/qtest/fdc-test.c
@@ -27,6 +27,7 @@
 
 #include "libqtest-single.h"
 #include "qobject/qdict.h"
+#include "qobject/qlist.h"
 
 #define DRIVE_FLOPPY_BLANK \
     "-drive if=floppy,file=null-co://,file.read-zeroes=on,format=raw,size=1440k"
@@ -177,6 +178,34 @@ static uint8_t send_read_command(uint8_t cmd)
     return ret;
 }
 
+/* Returns a counter that query-blockstats reports for floppy0 */
+static int64_t floppy_blockstat(const char *counter)
+{
+    QDict *response;
+    QList *list;
+    QListEntry *entry;
+    QDict *stats = NULL;
+    int64_t value;
+
+    response = qtest_qmp(global_qtest, "{'execute': 'query-blockstats'}");
+    g_assert(response && qdict_haskey(response, "return"));
+    list = qdict_get_qlist(response, "return");
+
+    QLIST_FOREACH_ENTRY(list, entry) {
+        QDict *entry_dict = qobject_to(QDict, entry->value);
+
+        if (!g_strcmp0(qdict_get_try_str(entry_dict, "qdev"), "floppy0")) {
+            stats = qdict_get_qdict(entry_dict, "stats");
+            break;
+        }
+    }
+
+    g_assert(stats);
+    value = qdict_get_int(stats, counter);
+    qobject_unref(response);
+    return value;
+}
+
 static uint8_t send_read_no_dma_command(int nb_sect, uint8_t expected_st0)
 {
     uint8_t drive = 0;
@@ -193,6 +222,9 @@ static uint8_t send_read_no_dma_command(int nb_sect, uint8_t expected_st0)
 
     uint8_t ret = 0;
 
+    int64_t rd_ops_before = floppy_blockstat("rd_operations");
+    int64_t rd_bytes_before = floppy_blockstat("rd_bytes");
+
     floppy_send(CMD_READ);
     floppy_send(head << 2 | drive);
     g_assert(!get_irq(FLOPPY_IRQ));
@@ -248,6 +280,16 @@ static uint8_t send_read_no_dma_command(int nb_sect, uint8_t expected_st0)
     assert_bit_set(msr, RQM);
     g_assert(!get_irq(FLOPPY_IRQ));
 
+    /*
+     * The non-DMA loop above has read 2 * nb_sect sectors through the FIFO,
+     * and the controller fetches each of them from the image with a request
+     * of its own.
+     */
+    g_assert_cmpint(floppy_blockstat("rd_operations") - rd_ops_before, ==,
+                    2 * nb_sect);
+    g_assert_cmpint(floppy_blockstat("rd_bytes") - rd_bytes_before, ==,
+                    512 * 2 * nb_sect);
+
     return ret;
 }
 
-- 
2.53.0


