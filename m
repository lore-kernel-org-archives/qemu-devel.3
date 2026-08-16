Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD6BC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgJT-0001K1-Sn; Sun, 16 Aug 2026 15:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgJQ-0001AZ-Ke
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgJO-0007dF-7M
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7+XpusORW4wlCqscaWWAqiyBJltRvz0lRaxsdzjW7Q=;
 b=IaNlKzjZjVJzb026AqxGq2rRFXB7ey2kZtSiSoPGCvlF+X1Fn+Dvg3pQfwxw3BEA2Pyga0
 99dwD1culGY+OXP/ymWOUNHkl27zqDOvf67TU7gRj4bUfCAjbqE0LBGoxvBLIhNDJU69Am
 y/CEh8sLItV7NJmOnmgGHqItWMQD9ks=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-HFgsIqcBMJ6QLizbnhQjWw-1; Sun,
 16 Aug 2026 15:14:22 -0400
X-MC-Unique: HFgsIqcBMJ6QLizbnhQjWw-1
X-Mimecast-MFC-AGG-ID: HFgsIqcBMJ6QLizbnhQjWw_1786907661
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 467E71800471; Sun, 16 Aug 2026 19:14:21 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 333F830001A2; Sun, 16 Aug 2026 19:14:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:50 +0400
Subject: [PATCH v3 23/49] qtest/ide-test: convert to use qtest qemu-io command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-23-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2333;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EDFCU7tM+yp0a1oNO/cFTsJ8k7Zu6kbTjv7+XwDG1Gw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguyferYHa5P+TlAS0W59P3fJm1KL8lyZKG0a
 heocQj8KHuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsgAKCRDa6OEJdZac
 5VBtD/wLAAzDi2rhKSnZhmDZqnvDleHMWKclr7BgiT5J5Om5ImNumghosc4pwYBYDf32YwWRv4I
 R2Gi9Fbyd9gNlDNk+RilK3dWerWWAKbeioDuNDFsPzOh3WQYsehRbrvUzNA+G2OiEPH0j512SlG
 E+ueuDmt76uQJe6PeucYE4eVO2/r8eAcmlqbee1l1BSb8RLVhDLsdB8iB5Mnbg+a+L65WqfoBv9
 WxnovFS4uY2EoXMu45R44iqMG8EbH3er2FrzCDh7wQCy5o0rxY2DrQrW/HZuukLv4x+OfFqanKD
 Tvg3DxCflUeMayOdWAUPux51aK2Gvu8dGFSuQUo/gZ6mB3Oi7JJVmVEjb0qKzFp1UbYsxfI0rLI
 1P397izZmAoZ+TKFD45UyeY//rkVaVabISKyHlz+bE/ewvl67L52wEztn3LsynuiI1/buo/Fask
 giKudTi8m5QOjccsveihm7VOGoFZNOAY1ii/TGqBWFChlYb7HN2QbtDztNECdztWEd2VOXiqD8d
 +1vO5y/UJ1garEE7TyFAlHhm9PLUrHOp1z5Ggzm6Ks1kyNf0/N3PZFEEm/4ZiP8paVS2Io//Cga
 +YO+DsyZ4cclB4GFxJr6DROLiw934Wo8mMWRScFqC92rjCs/RgaU4Y5TdHusf7PP0Of0N99SeXi
 jAQAab1bMLPYKuA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


