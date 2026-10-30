Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD5606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O5HQ/mQi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtvi-0007FO-6y; Fri, 30 Oct 2026 17:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvg-0007ED-L5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvf-0007oh-0j
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793394866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xbKx7ithkCYoBDJFObateEMj2fJdHrwotW+r3fji9mQ=;
 b=O5HQ/mQipXPuDZEeJPhDRJJ65Lr3jy0dOlLjsQJil82BDnReLW6/GGTWf3y/ulF8yd1ie+
 rMSE7tgVaVQEX2e+vX1Q+FaNlsKq7+/7vR9560hsq/CvnTwLfulAj93pGM56vBm1wLNGDn
 WYLvweBbc36Jkxr0Ibk2Cp0CNYhyRQY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-F7nQEz_KO2qu1SQOu0jEOQ-1; Fri,
 30 Oct 2026 17:14:21 -0400
X-MC-Unique: F7nQEz_KO2qu1SQOu0jEOQ-1
X-Mimecast-MFC-AGG-ID: F7nQEz_KO2qu1SQOu0jEOQ_1793394859
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3C3318005AB; Fri, 30 Oct 2026 21:14:19 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE427767; Fri, 30 Oct 2026 21:14:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 31 Oct 2026 01:14:05 +0400
Subject: [GIT PULL 02/10] tests/launchupdate-test: correctly release qs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261031-nohmp-next-v1-2-9a9fb205cf3f@redhat.com>
References: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
In-Reply-To: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2940;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8/0zlPBP/tCXApsGacYkJPRwrIYUhprqOiNL47y6/eU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5Qig1/NL8q956+NFDfKCx0ENK7Mv1PTm5Nc8G
 +pCw6F5hNyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauUIoAAKCRDa6OEJdZac
 5QClD/9K2GfMcKLjtzQ23n/lHUmSb83yNNNUxT6cDVBrtPWh2E7TPH+ApLriiOpU8GoXCkiRP4n
 fEDVdFAGGz3U6f0NDjBb0wTEi7pu6uWgl7PffYOBWk+SWnlqSb2yhEXNaPv/ShdfVJIDqxeRySw
 UUGCcJA5ejmW+X9eHAjCqzh2QGzrUaWvN/rzW+BpCLU/qPrNAP6hYfR2z7h5ym6k0zI/J5k5I2E
 U9PAFS+Ut6C8Pn3nElHrxuyfj8SplqRDrqtPA+RSkQyLrC+Ac/EYj0E5G9L7uxD5LKHNa2hRwpC
 QsIQS+ubEoXJM4AxmFDUELk/PtJxYXYRrjM0PywcvCzEUy3WvNcOkL+ntyK3nDIjuKM4JDXW+Do
 vFs+4qZBc2cqB9cV31xYTM71sn+/baPyho/bxVvQRLzE2KpI4UvgT3Y/o9nWIIBsDcwT9lTwcdG
 TAi5m8DmjMLTM/EDppqsc7UNZrvWmkgmu1IOazZeg893Q+zg8GlnxxD7NXri3zOASN/OAteNtn1
 pesx9+IUaOFOV/hrDwrpFIbpIXba/PbXWthHRbsEjLgHB32TdYGtN8ax57j2yGsEK9fkqnSFcYg
 otuShrpL0Bd0sEbklpL2tcIKmJIiiFPlE0PTKTq8IXEbK0bde2hBHccCsHoQTbHKOcy1Lkgywvx
 moFXuQC5ish2sMw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

QOSState must be released with qtest_shutdown().

Fixes: 0b70c6ce7b31 ("Add functional and unit tests for the vm-launch-update device")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/launchupdate-test.c | 13 ++++---------
 tests/qtest/libqos/libqos.h     |  2 ++
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/launchupdate-test.c b/tests/qtest/launchupdate-test.c
index ed007cdce29f..ea35da81feb9 100644
--- a/tests/qtest/launchupdate-test.c
+++ b/tests/qtest/launchupdate-test.c
@@ -51,7 +51,7 @@ static void test_vm_launch_update_capability(void)
 static void test_vm_launch_update_disable(void)
 {
     QFWCFG *fw_cfg;
-    QOSState *qs;
+    g_autoptr(QOSState) qs = NULL;
     VMLaunchUpdate launch_update;
     uint64_t control;
     size_t filesize;
@@ -95,13 +95,12 @@ static void test_vm_launch_update_disable(void)
     g_assert_cmpint(VM_LAUNCHUPDATE_CTL_DISABLE & control, ==, 1);
 
     pc_fw_cfg_uninit(fw_cfg);
-    qtest_shutdown(qs);
 }
 
 static void check_error(void)
 {
     QFWCFG *fw_cfg;
-    QOSState *qs;
+    g_autoptr(QOSState) qs = NULL;
     VMLaunchUpdate launch_update;
     uint16_t status;
     size_t filesize;
@@ -326,7 +325,7 @@ static void test_load_igvm(void)
     size_t igvm_sz;
     size_t filesize;
     QFWCFG *fw_cfg;
-    QOSState *qs;
+    g_autoptr(QOSState) qs = NULL;
     VMLaunchUpdate launch_update;
 
     if (!trace) {
@@ -456,8 +455,6 @@ static void test_load_igvm(void)
     close(ser_fd);
     guest_free(&qs->alloc, gaddr);
     pc_fw_cfg_uninit(fw_cfg);
-    /* qtest_quit() kils QEMU, first by sending SIGTERM, then SIGKILL */
-    qtest_quit(qs->qts);
 }
 
 static void test_set_ctrl_once_and_reset_to_host_igvm(void)
@@ -475,7 +472,7 @@ static void test_set_ctrl_once_and_reset_to_host_igvm(void)
     size_t igvm_sz;
     size_t filesize;
     QFWCFG *fw_cfg;
-    QOSState *qs;
+    g_autoptr(QOSState) qs = NULL;
     VMLaunchUpdate launch_update;
 
     if (!qtest_has_machine("q35")) {
@@ -585,8 +582,6 @@ static void test_set_ctrl_once_and_reset_to_host_igvm(void)
     close(ser_fd);
     guest_free(&qs->alloc, gaddr);
     pc_fw_cfg_uninit(fw_cfg);
-    /* qtest_quit() kils QEMU, first by sending SIGTERM, then SIGKILL */
-    qtest_quit(qs->qts);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/qtest/libqos/libqos.h b/tests/qtest/libqos/libqos.h
index c04950e2b19d..b2d02825a9af 100644
--- a/tests/qtest/libqos/libqos.h
+++ b/tests/qtest/libqos/libqos.h
@@ -42,4 +42,6 @@ static inline void qfree(QOSState *q, uint64_t addr)
     guest_free(&q->alloc, addr);
 }
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QOSState, qtest_shutdown)
+
 #endif

-- 
2.56.0.116.g6de20f6092dc


