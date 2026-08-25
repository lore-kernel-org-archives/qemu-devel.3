Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615C4C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywYl-0006NO-OJ; Tue, 25 Aug 2026 15:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYc-0005qN-0f
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYY-0004BJ-Kx
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Bj3PY7FPChYS4p4u2YPAB+wgehSslQk/bWtqbtzF6g=;
 b=ZhTdIAZVwOZJZxWhRMMRm5p1GDkB4+R+5LcbShQcaxNQ3Yh6/+M0AKpSMAeeob2q+jUsEB
 13wcZs6qoVagvRZjgdoqp0aHVOQDQkjNnZwUjoZhGZsQcifdcFNNtlCP71o4dg0yoEG07B
 dPu4QgEtPvtp2JWfDjgv5jyRVtrIPc4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-pWHVBDl0MNSnQMCE_BJ-Rw-1; Tue,
 25 Aug 2026 15:11:30 -0400
X-MC-Unique: pWHVBDl0MNSnQMCE_BJ-Rw-1
X-Mimecast-MFC-AGG-ID: pWHVBDl0MNSnQMCE_BJ-Rw_1787685089
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66E1219792F3; Tue, 25 Aug 2026 19:11:29 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 964A71944B2A; Tue, 25 Aug 2026 19:11:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:30 +0400
Subject: [PATCH v4 23/49] qtest/ide-test: convert to use qtest qemu-io command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-23-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2379;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eDuJspXtx+5PSIfDzwxXnjJDycfHfyNAMJBOLftcXR8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHXbxghZFfnL8fKreHnF/Uhixkydt46LN5p
 syzjXAidFiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5aSwD/9mybxduOQ8gcLNtMcdQ6zOzk7mnUuI3ogg6k7LnCOGWWGe2HAAQ75oClrBKTPWeejUUw4
 vbM6ktMUs3doSk38gM57TrQzKSzlOaMqDKWZ0ayrtczY4sQs5CeA5LLeA+Kh+YlIQAAP96eVTOT
 DsFslt8lkXlj6J5waDt1HO0wqZ5tnDESl+BHV835qlVbzd7Y7qvEAF66AkcY0+ypuFMiG9+NNSk
 rGVOSONXXqKZkpNWTqBlzJS27XuWrzHAc4JME7+PeiazMGaTZdFWFGhJw4oHgw1S2Mdxh/7E6AR
 rKwCCdfBbOOrJk3dy3Lu+lrGQhzRQxxMIY0LGBO5TU68IC1o2+w9NuOniqp42XTPhEHsOgQogoS
 2/Pigq22hXoSmTVDTX/HZoh0HOK9vk3iZNrD5Vty4yBpCIEfdYrZ39QTAvcAvWO9EC6uPSi/LwP
 rxSoZAYtHclDSIsRPPSYcmPdTBpAu5DwyRIKWwXn+YPIQ8uLn5rH8hcqNT50PWyN+T5UAm37dV0
 v7ufhYgOd6qVc0ZkllMyo2Q/eu8ZzEOAe3EnRMWwv/jop38LwCABi7vMCrcgLKfdEOOZWOjwP/G
 3Lz5U4W/K+FJiXLW45CJC1BQIAMHReod83ELhVgc9cP7rf5vHYn3dRiJnrGGdbB4eHeBPG87gjE
 KMYjjKnY3JIbtJg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/ahci-test.c | 5 ++---
 tests/qtest/ide-test.c  | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 71d23fe56af7..0528a422fafc 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1719,8 +1719,7 @@ static void test_atapi_engine_restart_in_flight(bool dma)
     qtest_memset(ahci->parent->qts, buffer, 0x00, ATAPI_SECTOR_SIZE);
 
     /* Suspend the next backend read so the ATAPI read stays in flight. */
-    g_free(qtest_hmp(ahci->parent->qts,
-                     "qemu-io drive0 \"break read_aio rd\""));
+    qtest_qemu_io(ahci->parent->qts, "drive0", "break read_aio rd");
 
     cmd = ahci_atapi_command_create(CMD_ATAPI_READ_10, ATAPI_SECTOR_SIZE,
                                     dma);
@@ -1732,7 +1731,7 @@ static void test_atapi_engine_restart_in_flight(bool dma)
     ahci_px_clr(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
     ahci_px_set(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
 
-    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"resume rd\""));
+    qtest_qemu_io(ahci->parent->qts, "drive0", "resume rd");
 
     /* Round-trip through the device to confirm qemu is still alive. */
     ahci_px_rreg(ahci, port, AHCI_PX_TFD);
diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index b36b0f8875b2..31692f6925ac 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -836,7 +836,7 @@ static void test_flush(void)
     make_dirty(qts, 0);
 
     /* Delay the completion of the flush request until we explicitly do it */
-    g_free(qtest_hmp(qts, "qemu-io ide0-hd0 \"break flush_to_os A\""));
+    qtest_qemu_io(qts, "ide0-hd0", "break flush_to_os A");
 
     /* FLUSH CACHE command on device 0*/
     qpci_io_writeb(dev, ide_bar, reg_device, 0);
@@ -848,7 +848,7 @@ static void test_flush(void)
     assert_bit_clear(data, DF | ERR | DRQ);
 
     /* Complete the command */
-    g_free(qtest_hmp(qts, "qemu-io ide0-hd0 \"resume A\""));
+    qtest_qemu_io(qts, "ide0-hd0", "resume A");
 
     /* Check registers */
     data = qpci_io_readb(dev, ide_bar, reg_device);

-- 
2.55.0.543.g5ebe2ebe4ea8


