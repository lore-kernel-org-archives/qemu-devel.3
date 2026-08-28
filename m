Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD0BC61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvMK-0002OE-4b; Fri, 28 Aug 2026 08:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvLt-0001en-Sf
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvLs-0002zk-B1
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R00mpWgcBZYvxhr3fEsxzMGizSnq4M+/8hFVrKIvsds=;
 b=Cs2ii4BAWWWuzSuBlIywmleGgmh2bLCQVnScjt1AFFCwwf1ba2fLKtYmLeWBikY9C9UHJb
 0voxOmYHWGTRDJAUG9A6/axBSOur5T9ZJknmrclj6tsKqOCMeVgbSof5sgTkk3gTRwW1Kn
 05F22lcKQZnApGDhpKm5z2LfoNGwWnQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-axtdhlIiOL2TifPFDeKwaA-1; Fri,
 28 Aug 2026 08:06:28 -0400
X-MC-Unique: axtdhlIiOL2TifPFDeKwaA-1
X-Mimecast-MFC-AGG-ID: axtdhlIiOL2TifPFDeKwaA_1787918787
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 123ED193E892; Fri, 28 Aug 2026 12:06:27 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 410A41955F05; Fri, 28 Aug 2026 12:06:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:21 +0400
Subject: [PATCH v5 24/50] qtest/ide-test: convert to use qtest qemu-io command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-24-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2443;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=R39oLjKgSwOqAzKN+pihOCywIlIupCfohdvnpnuBvSQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk401/9IVWCmVjdwb+0GY/GrcENm9sksJ+zU
 YhcwcX0KUOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OAAKCRDa6OEJdZac
 5SEcD/9SH0y+CFFxK/78Jyd4Uli3GvQ1y7H+gOYLLQU+o9CwJvFdQvLDBaGqCoq37cY6hf39h0+
 CsxzelG9H2HYVLGtrprGY0DIIB1XV+ZvVMRsLNejV3AK4kBy97Enj2QN4PjSLD7aud8eJZ51nR5
 3j1Wl+wAy887X0RT6ObzsrpTn1OqxreYRPWAOOkFOulxkADS4IeFynVK3XPDwzEtsyNsp8WolbH
 u320bbbCn3FnfllzFxs8hdGZ0ZvRCubBTGi5Yac8GcL5pEgJLFnQHefJzvdSe0SqAHamRIB548j
 +FWihi4u0pCl6ERiOcbLPj4QX+Es498bN5rhPRs54wmCRDfWpWhCh4NHbiuCGj+Jv2dSPf/O0mR
 bpxVObMSVbZ0x163X3p2w8ovS6yhyNr1a2qLo52eCEwPMQEclg6jA+kZtyyjKhivu9BkC9/7ykY
 1PWpop4imYCCCjNyk82P7uMvvE0/SThBwpRgnfjy7iiQ3NC+Vhv8sSAz7e3PyYqW93OxNpt8wiF
 YuJleiZd5aVrPWW5cy1m/8Y57uxHQIpgc3cwIK8dE4/vErTR68HKQyGxWWtXZpinfT+FqngYW8y
 wSMe/hUQGR92LxUlH2QnwQAB2yi3SBtiRyaMf48ulkPbNDe7uUyl4wXExuDB0J+PJCRv2jR3hnH
 fZGkTr6F5jzyzwA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/ahci-test.c | 5 ++---
 tests/qtest/ide-test.c  | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index b143862ce70c..3406ca884fb4 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1758,8 +1758,7 @@ static void test_atapi_engine_restart_in_flight(bool dma)
     qtest_memset(ahci->parent->qts, buffer, 0x00, ATAPI_SECTOR_SIZE);
 
     /* Suspend the next backend read so the ATAPI read stays in flight. */
-    g_free(qtest_hmp(ahci->parent->qts,
-                     "qemu-io drive0 \"break read_aio rd\""));
+    qtest_qemu_io(ahci->parent->qts, "drive0", "break read_aio rd");
 
     cmd = ahci_atapi_command_create(CMD_ATAPI_READ_10, ATAPI_SECTOR_SIZE,
                                     dma);
@@ -1771,7 +1770,7 @@ static void test_atapi_engine_restart_in_flight(bool dma)
     ahci_px_clr(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
     ahci_px_set(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
 
-    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"resume rd\""));
+    qtest_qemu_io(ahci->parent->qts, "drive0", "resume rd");
 
     /* Round-trip through the device to confirm qemu is still alive. */
     ahci_px_rreg(ahci, port, AHCI_PX_TFD);
diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 92e3d9b3437e..05ec58f8c528 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -839,7 +839,7 @@ static void test_flush(void)
     make_dirty(qts, 0);
 
     /* Delay the completion of the flush request until we explicitly do it */
-    g_free(qtest_hmp(qts, "qemu-io ide0-hd0 \"break flush_to_os A\""));
+    qtest_qemu_io(qts, "ide0-hd0", "break flush_to_os A");
 
     /* FLUSH CACHE command on device 0*/
     qpci_io_writeb(dev, ide_bar, reg_device, 0);
@@ -851,7 +851,7 @@ static void test_flush(void)
     assert_bit_clear(data, DF | ERR | DRQ);
 
     /* Complete the command */
-    g_free(qtest_hmp(qts, "qemu-io ide0-hd0 \"resume A\""));
+    qtest_qemu_io(qts, "ide0-hd0", "resume A");
 
     /* Check registers */
     data = qpci_io_readb(dev, ide_bar, reg_device);

-- 
2.55.0.543.g5ebe2ebe4ea8


