Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00AD606B0DE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BEaZW3CN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvT-0006It-19; Mon, 02 Nov 2026 11:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvI-0006AR-3E
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvC-000233-Du
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDLJc7RtNeTUK+69yS662HWGNKPt2jaI7l7JlqfUxTA=;
 b=BEaZW3CNGipUCNBn6xVe8i5jYiISUZdI7rqv/IxFzniA/LOxQwNUI2UeVI/WWJvA8fbFkW
 59apSxmwWmxHqmWFsJ8fdnIVPZFwAUB3PaFzqT4sI78W+UWriL9ypGSD5dp/r5SjHCoGu2
 b/G//fivYprZP2PbIISDdQl++LaMRTE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-5vJzN5P7PnuzSrLNeyRE1w-1; Mon,
 02 Nov 2026 11:30:06 -0500
X-MC-Unique: 5vJzN5P7PnuzSrLNeyRE1w-1
X-Mimecast-MFC-AGG-ID: 5vJzN5P7PnuzSrLNeyRE1w_1793637005
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67F891800611; Mon,  2 Nov 2026 16:30:05 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 939901956087; Mon,  2 Nov 2026 16:30:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 01/17] tests/qtest/fdc-test: check block accounting of non-DMA
 reads
Date: Mon,  2 Nov 2026 17:29:39 +0100
Message-ID: <20261102162955.268763-2-kwolf@redhat.com>
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
References: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

From: Christian Quante <christian@quante.one>

Since commit 9c4c09d2a663 ("hw/block/fdc: account for read and write
requests"), the floppy reports its reads and writes in query-blockstats.
Check this for the existing non-DMA reads: send_read_no_dma_command()
now compares rd_operations and rd_bytes before and after the command,
one 512-byte request for every sector the test reads through the FIFO.

Without the accounting, read_no_dma_1, read_no_dma_18 and
read_no_dma_19 fail with rd_operations at 0 instead of 2, 36 and 38.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Christian Quante <christian@quante.one>
Message-ID: <20261011081433.73397-1-christian@quante.one>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qtest/fdc-test.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
index 33d1b83aebc..a10951f204d 100644
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
2.56.0


