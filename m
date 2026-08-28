Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F94C61DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03QG-0008Di-89; Fri, 28 Aug 2026 16:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03QD-0008B6-Kz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03QB-00005O-0S
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D00l5FTSxYFuzcd1Y5U4YFVNswLFPmD71iWlEb8JX7M=;
 b=NrSe/oKobZ3T1py6NbWfvkUcE+kfzR8osKGtqKrYwjRKWXEuVmYrd7pAsFTXCkNBUQ0lPc
 IH71OuSXAU+l3aNPf1Io6QtlkEuZJnxdL8Awx/oDqHQYTJ3RrjJghrHnHnl/Lsc7JT83eP
 8xIxgALctCyprKHUtc9ESwxMer2s3MA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-hk2LE6W_MrWFR9LIfMh-2Q-1; Fri,
 28 Aug 2026 16:43:26 -0400
X-MC-Unique: hk2LE6W_MrWFR9LIfMh-2Q-1
X-Mimecast-MFC-AGG-ID: hk2LE6W_MrWFR9LIfMh-2Q_1787949805
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA655190A0BF; Fri, 28 Aug 2026 20:43:25 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFD441955F0A; Fri, 28 Aug 2026 20:43:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:03 +0400
Subject: [GIT PULL 24/50] qtest/ide-test: convert to use qtest qemu-io command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-24-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2509;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/fv4qfoBrfSIQzPmJEBy59uUqC32wRREnpe5HVVqozU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUxH8K8ul0Os3u4DcIyOAeDAlS05zrk+G7d
 ZeyWWJDkRiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5fkFD/9kswX39QAe0OPs7XqreTCh70kIHrkqImRarWqD0oJ6syY1lGGzBqh+T5nDq6irB3FB7SY
 1kgQ2esi27fxFvO9DJHG6ZdzuJLKJs3Ta0tRd495LeCg5NdIF4b09hDagGPhk+2qVp7CRCT+Gk7
 qUTyMAgL1qTmvLsrkRMku7KhhvsHeoa2xwt1Xq4g2WqLeuoSp795Ouly8IhcSBzAfOLLlpC0GB+
 9ei15TAHhtioSNpHnZoOG/WBS1rd8P0/eFSsk3+sNbHTwosTTtmIvnUIT8cuM/Zb+7zPYQCRHAj
 G3VHPE9l5ni6NAAXLkAqF9NTDWamt9OCnPluBgqlW15+Egy4zYBmbjpHg/zdk97GOSv4CjcJ76o
 RRerLi2Ys4b5ZCC8gEfehyDn2wQ7CnRKooAad6RpedtkKjgwFHZC3+ob9kyNua9Fnj9B91ZjMLK
 RiAu7yR0kUUNabu9bWQGy0Sf0tHMn0wAkGpF9FClK+vErJ76eJENBWaS+zocFNwP1OG+kM9pS5r
 vm4+qU9ity2TjVKg0HqrSHimG/yRXUKbzTDVBgkdZFovYxZ4NQUVn00n0Yr1mgRaarNdB42iAwM
 TJYtJUbj8KkjWGk9QDAcr8hJAVksGh/JT3rfZf+YZ2vEbn/zmcJqyoKCNvB6R8R6bAwluATBWL8
 BKCqPkWiQJ/B5+Q==
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
Message-ID: <20260828-qemu-no-hmp-v5-24-9227de146347@redhat.com>
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


