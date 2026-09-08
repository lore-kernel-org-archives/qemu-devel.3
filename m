Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D5CC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3rJE-0007Gj-SH; Tue, 08 Sep 2026 04:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3rJC-0007DA-Nl
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3rJA-0007G6-Vo
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788856560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o4wZ10w5TCyFWkISKjZMdAhqDtOFEX7Ga9DDoZ/ZUjk=;
 b=ZhjJmiAGBezFJq7/qgpFUx58KihqoTgIcPc8r3t/XDjgtU1Gy46Ywm2RNwxxqGALvl7no0
 DXVYIZvNOY7o5Oc1GMi3Wzt9iJXH3coBO4jWUvNG0Xd3OWZkTZUExYTKwFFAK9cZdm0jsE
 0ivWd6qKshjsrLqJwP3ZaFFL2u2/pFc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-sgzIFUi6O06VLz9U2NzibQ-1; Tue,
 08 Sep 2026 04:35:59 -0400
X-MC-Unique: sgzIFUi6O06VLz9U2NzibQ-1
X-Mimecast-MFC-AGG-ID: sgzIFUi6O06VLz9U2NzibQ_1788856558
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFD02180257B; Tue,  8 Sep 2026 08:35:57 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D4EA1955F08; Tue,  8 Sep 2026 08:35:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 12:35:37 +0400
Subject: [GIT PULL 05/10] tests/ahci-test: replace HMP usage with QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-5-7a3d1f0f1caf@redhat.com>
References: <20260908-nohmp-v1-0-7a3d1f0f1caf@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-7a3d1f0f1caf@redhat.com>
Cc: peter.maydell@linaro.org, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1464;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=b+lTBCsun6YleRr58wgZMzenJkZsl+BywditbLZ0aZE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn8jY4uPjZ6aGiVgR4eWzgPQHtsTH5bVPeIzvK
 hPRZhu1kkWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/I2AAKCRDa6OEJdZac
 5cCnD/oDxrmYAMz2L/sSNdvlAbvR3s9fympvgS2871b5Z+vACKAUmSt3SjZTA9i/g49SvzYoHhG
 u67fIPFwB0OT0BuTDByyknRxOqgAuVZI7KtJcEM1D0uvCI3pOc2hU2uB1gF+Qtyzx5rUE21ARsQ
 0EslYDY3HmegssCryx+BEUj/czFtuCzp2MlH51bgkh/POJUtD1HBpQfG9JDRIYy82Cc5xENVaNT
 CzvxC7rRHDLAYx2P6kxTTsFjgHp6ULDnhkjeQn6z5VfsKtwnHrgnvIQUTz8Q5hc494K+8WXMGWZ
 zBZAVFDSsw5NfNtgr2fS6ChOol7KMtCCHeZueN61eSZaP3DsKbpau4kqfaYq47ouUWgNndSpB/N
 UhPo5YwgXuToZhg0fuD9d3l77ICr/1+arYTchG7fmnzhO2IFi6s3JzJ//eN8JZvYHcJmLd9VFoA
 EMTaoms6Tw2jY3Ba/IQIN29vxqtAo0WZT4QuKQP4YhkO0tVWiOCV3lhQ0O3vyL8aCXNO5rJYaPy
 lKSj2E6B7VUk8HVprOm7jcTqKwWLPdK1YXt7t8VCzWYrgofcI9xLK6bA5XB4L/M8uvyFjqz2+Tr
 4Rhr6qYi4qf/dd1MjOkPW8OMszyzFWjDXg5Q/2NXu6j6YVJxl3zZCO7tHQ8emRz44kNyF+jd3DR
 A8V/z4D1LJZp8Lw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

Use qemu-io command instead.

Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/ahci-test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 3406ca884fb4..eb8d23999738 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1900,8 +1900,7 @@ static void test_write_engine_stop_in_flight(void)
     ahci_io(ahci, port, CMD_WRITE_DMA, rx, AHCI_SECTOR_SIZE, 1);
 
     /* Suspend the backend write so the first sector stays in flight. */
-    g_free(qtest_hmp(ahci->parent->qts,
-                     "qemu-io drive0 \"break write_aio wr\""));
+    qtest_qemu_io(ahci->parent->qts, "drive0", "break write_aio wr");
 
     cmd = ahci_command_create(CMD_WRITE_PIO);
     ahci_command_adjust(cmd, 0, ptr, bufsize, 0);
@@ -1911,7 +1910,7 @@ static void test_write_engine_stop_in_flight(void)
     /* Drop the command list while the write is still outstanding. */
     ahci_px_clr(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
 
-    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"resume wr\""));
+    qtest_qemu_io(ahci->parent->qts, "drive0", "resume wr");
 
     /* Round-trip through the device to confirm qemu is still alive. */
     ahci_px_rreg(ahci, port, AHCI_PX_TFD);

-- 
2.55.0.543.g5ebe2ebe4ea8


