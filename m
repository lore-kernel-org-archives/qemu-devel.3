Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D3FC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZBC-0004Of-MS; Mon, 07 Sep 2026 09:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZB7-0004GA-RZ
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZB6-0006Ur-Dp
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788786867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pw8oM7XvTZ8UrOcsyDmNklaQrGBxEBQh+OPjYQaTMXA=;
 b=BQYaFfRtDiDqZ3t5nYHGQ8lZ8XNT20atLzVaL8brOpi1amb3Duk9tGUsVMilHBubd97W9E
 2kA/Jd1xTrxHgGo7KyXsT1RRvxO+tVLAvkWnSMKE1+4rxznIiBtIcYPsolf/DwO70YVpSo
 v6BsgBJLMbLj+6PLfNEUYjHT+jyDi+g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-LYzyo8GAMNubhkpZBvJncQ-1; Mon,
 07 Sep 2026 09:14:24 -0400
X-MC-Unique: LYzyo8GAMNubhkpZBvJncQ-1
X-Mimecast-MFC-AGG-ID: LYzyo8GAMNubhkpZBvJncQ_1788786862
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3A1118052CD; Mon,  7 Sep 2026 13:14:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5123423; Mon,  7 Sep 2026 13:14:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 17:13:59 +0400
Subject: [PATCH v3 5/9] tests/ahci-test: replace HMP usage with QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v3-5-c11e7d0d3d7d@redhat.com>
References: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
In-Reply-To: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tLrFlT/tcpYg1fK592+t5TVWs+WZQ4KtzWrEIWmaBQ8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnriXc5LBDgVtbRkRFePpShWWIeLUbC2OeKKV3
 ZhZa5PYU+uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap64lwAKCRDa6OEJdZac
 5XcMD/9/GCmU93V7jB5BV2PvDd5SZsGfXacd27sSJFRRaVZRDRSvWYCNAofPYDmGv6qdiT9bupk
 AjGM5M21NJ6lRZoQXbI59pzAQZhA1xVVW4oXwafLyvUPJIMkXdWyzYQMKi++Gz4r5YGXmalPk2J
 pfTGpAVhsfxxinOoB82y7Rih9544vN6h5a8v1T9OngE/9gf4+jzEPsghyCVq5/gyHF2Ejp1BkWC
 LslAN5zjextgdPDwNBpiM6OCNuV5F7MuzDSBZTAjoYlBiBFl7R2CA+TWuoHhuSE0t17htENuDLd
 2GedE2IZBhfZKaujjPzP1ju2Tk1uYA+KvE1WutipxUBsJDbRWzrc829HMHfsHq5RsrRdtPOZ3d0
 hTVkrmGd3jpcJClOY3oqM+Zzl6WmkALRuDQ6SPprbqYrTX/M4Z/TfMk9g21ZsVXfelCKafuAuWp
 MuREqiSqoeYPwlHCFuvltIG666noYYbBoIBosEbpxwEJ3378tWyfc9T8moFGEjtfawE9G2RXfbw
 8TQWMmLo3I/Dqyw9NAZePOP0MNAVpE541ZJxv4YQbGIceFucDsZOVZnYK9LRY5U8gwF7J70PM4X
 pqGN9MnD1VJqM5qUT0oS8hanNupn7CL+J8qdYDnNUk+JWIYEiraskTZ1Yc+2v3U1CkU/prB+0Wq
 SgRAzmyGy9tdssw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Use qemu-io command instead.

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


