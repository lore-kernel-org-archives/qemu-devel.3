Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B220DC55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpLtf-000796-O5; Thu, 30 Jul 2026 04:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLtd-00077A-0Z
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:42 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLta-00018p-5i
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:40 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so70852766b.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785399216; x=1786004016; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OtCL941QaxVDzOMEP5QDrXt6XcRnskNWRDsBxWp3Og4=;
 b=R/UWGDLVM3pmtWiemiQ1osrSiMwOw1B+5qpW7FDwC6SVn8vQ2g+bI+B5k4zM2+wRKB
 5hYD/qFRUpetj4cDbhqNrY6hdzxFWzA+dgItRXDsg3OJ2291KVQFwvbZoMpYIpWXZ+7h
 DBGv1dTqYX95nQTaNu586vlC8CmVm8NC0feCAD7ncrLLz1/i+Kkx02czd0NeLv7WW0RB
 LUnrpCfZianM5RB/A0317+RPpUPz+TZZR9tMaR7yWLcp5drqvIFndiy1XsqkVJb34Uif
 EsZU9OVAWx0pevWQUabPcbNTGsPuGzmbOOqwApkgExZHEMlyWKYyQpnOlshY7L1kwEX0
 3MIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785399216; x=1786004016;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OtCL941QaxVDzOMEP5QDrXt6XcRnskNWRDsBxWp3Og4=;
 b=B03P1aSEaAknFb9TLcR9jUVpE5IHLl85vtZQy/UInaX4QfybLs9mbTsnYO9UddVC1v
 /dTDVZjBgyaaYTO+1dOD4kf0zxPTTw/bUh3GElGeIXoWz8eS5Qn4LT9qxvnjoHMSdA8T
 dhf5YSiQpjTW8yVeW5Vxw/s75r1N2pdYl8+cuzUAPJciODyJGd8kStT1mlnjYdGiu0+o
 WRmKRa0L1t/jELDfFY1gXALcY0zaE0B+r+b5c5zw9agvNeIrY4KDstYKblFkSBuycwvA
 tXjLRVsIJoknabbfAhXrpRyvgnVZSQ/Ls+HWtQ7s2KLEhvm9W/HJe1MXZxCDW6WGGioy
 bNPw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8jtFTsBAnLJIWs1YM4q25nn9s65ir/iijYOFWNU7+YEJIJMxsQXBjyIQdrIRsVWptEzzFZzkcI9qI@nongnu.org
X-Gm-Message-State: AOJu0YzHBKkWly+8Ecpx7MEMHlv/18BbC+dql3CUPKUoPHcekYMCLXyS
 RBKFhh6d995XARc92T5zHe+CQIcyu5v7DeVkdubiF8sjJhWHLGFMGl3nQhiI/JzFXwQ=
X-Gm-Gg: AR+sD10XOvpFj6zYJUDKRZyaUPlFCChLFijbsMe7I/bFstieULNodNoTFPzeD96R4Oa
 2tsB7PksbQeK63LlJ2MJyiFuRPEZ6aVY8jt+0HnPmZuMmg3DZdtAkz9q9b9FIqC7Wrocrtn04+L
 6BLBJngth9n04TZ2DUZvNHfR4etpil3Zu2r7U6epoYcPr/ex+W4kX17ua+cUmV1oA7qCKJZP7+x
 qcoMVz4xG0hFuW85ikSbeHAWrOr0K+ejA1iNCUP8nkhZrpI+5hPo4W/I8UkhBm/aqBVK1MxnK+L
 fBGA7Y4OjeVgTxgr+97l64mNGRv/zRKzNI9rJEYTvzfyFMXgzh3AApAc7yX1sSFb2X7ZsoWiefF
 STCdrHcdLjA6uFLtPbi1mkDKowyjd6G7wSuPHnsia8AGxdp1mIyLb+h7ZtrWsmycax+W84uHW/O
 VPBpeVCzrPgadVJWoXpJ6sNOjsuzbSma5cZ/Q5nf2p106NaFjFyA==
X-Received: by 2002:a17:907:d649:b0:c15:ee17:47a with SMTP id
 a640c23a62f3a-c1fad03e323mr56630066b.15.1785399216198; 
 Thu, 30 Jul 2026 01:13:36 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:871f:1fb4:356b:23d9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa857c8e1sm38373466b.19.2026.07.30.01.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:13:35 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 8/8] tests/qtest/ahci: regression test for ATAPI read vs. drain
Date: Thu, 30 Jul 2026 10:13:24 +0200
Message-ID: <20260730081325.1816193-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730081325.1816193-1-den@openvz.org>
References: <20260730081325.1816193-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=den@openvz.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add /ahci/cdrom/drain/{pio,dma}: issue a multi-sector ATAPI read whose
byte-count limit spans two sectors so the device must rebuffer in the
middle of the DRQ burst, hold the backend read in flight with a
blkdebug delay, and fire x-blockdev-set-iothread -- which runs
bdrv_drain_all_begin() exactly like a guest reset does through
virtio_blk_stop_ioeventfd().

On the unfixed PIO path the nested sector fetch is queued behind the
drain and the main loop wedges, so the test hangs. The DMA variant
never rebuffers and serves as a sanity twin.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/qtest/ahci-test.c | 66 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 58bc04b3ef..71d23fe56a 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1754,6 +1754,70 @@ static void test_atapi_engine_restart_dma(void)
     test_atapi_engine_restart_in_flight(true);
 }
 
+/*
+ * Regression test: a multi-sector ATAPI read fetches its later sectors from
+ * inside the first read's completion; a concurrent drain (as a guest reset
+ * triggers via bdrv_drain_all_begin) must not wedge on that nested read.
+ * blkdebug keeps the read in flight across x-blockdev-set-iothread.
+ */
+static void test_atapi_drain_in_flight(bool dma)
+{
+    AHCIQState *ahci;
+    AHCICommand *cmd;
+    unsigned char *tx;
+    char *iso;
+    int fd;
+    uint8_t port;
+    uint64_t buffer;
+    uint16_t bcl = ATAPI_SECTOR_SIZE * 2;
+    uint64_t iso_size = (uint64_t)ATAPI_SECTOR_SIZE * 3;
+
+    fd = prepare_iso(iso_size, &tx, &iso);
+
+    /* 1s read delay: a wide margin so the drain starts before it completes */
+    ahci = ahci_boot_and_enable(
+        "-blockdev driver=file,node-name=file0,filename=%s,read-only=on "
+        "-blockdev driver=blkdebug,node-name=cd0,image=file0,read-only=on,"
+        "inject-error.0.event=none,inject-error.0.iotype=read,"
+        "inject-error.0.errno=0,inject-error.0.delay-ns=1000000000 "
+        "-M q35 "
+        "-device ide-cd,drive=cd0 ", iso);
+    port = ahci_port_select(ahci);
+
+    buffer = ahci_alloc(ahci, bcl);
+    qtest_memset(ahci->parent->qts, buffer, 0x00, bcl);
+
+    cmd = ahci_atapi_command_create(CMD_ATAPI_READ_10, bcl, dma);
+    ahci_command_adjust(cmd, 0, buffer, bcl, 0);
+    ahci_command_commit(ahci, cmd, port);
+    ahci_command_issue_async(ahci, cmd);
+
+    /* Drain (all nodes) while the delayed read is still in flight. */
+    qtest_qmp_assert_success(ahci->parent->qts,
+        "{ 'execute': 'x-blockdev-set-iothread',"
+        "  'arguments': { 'node-name': 'cd0', 'iothread': null,"
+        "                 'force': true } }");
+
+    /* Round-trip through the device to confirm qemu is still alive. */
+    ahci_px_rreg(ahci, port, AHCI_PX_TFD);
+
+    ahci_command_free(cmd);
+    ahci_free(ahci, buffer);
+    g_free(tx);
+    ahci_shutdown(ahci);
+    remove_iso(fd, iso);
+}
+
+static void test_atapi_drain_pio(void)
+{
+    test_atapi_drain_in_flight(false);
+}
+
+static void test_atapi_drain_dma(void)
+{
+    test_atapi_drain_in_flight(true);
+}
+
 /* Regression test: Test that a READ_CD command with a BCL of 0 but a size of 0
  * completes as a NOP instead of erroring out. */
 static void test_atapi_bcl(void)
@@ -2177,6 +2241,8 @@ int main(int argc, char **argv)
                    test_atapi_engine_restart_pio);
     qtest_add_func("/ahci/cdrom/engine_restart/dma",
                    test_atapi_engine_restart_dma);
+    qtest_add_func("/ahci/cdrom/drain/pio", test_atapi_drain_pio);
+    qtest_add_func("/ahci/cdrom/drain/dma", test_atapi_drain_dma);
 
     ret = g_test_run();
 
-- 
2.53.0


