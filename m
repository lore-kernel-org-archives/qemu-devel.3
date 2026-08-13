Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC5DC5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuauk-0008OS-P0; Thu, 13 Aug 2026 15:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wuauj-0008N7-Qw
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 15:16:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wuaug-0002wu-PW
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 15:16:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-495590dde14so3811055e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786648584; x=1787253384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HHNGOJ4JW6/xM+akzv3IjGDFyOH8vS5GN6tAHz20i80=;
 b=K1kDNMtiWmV3TrXUWyGJpAkXrF9cm2D8wroERF3Ou4m5xolluLpRnB5cCnRWw7Pj2S
 7woo+Hf/vpwB33POfWZG3MXoV28ltJz99s8PM9fFjb1dWbobjwvSdC0v7xXf/Xy3QcSd
 CCTFMZN7WQpkMxQjrwLQqDVxYpd7eBy9kAQXU/eAp7PYSnVwPlQQxtCcVw/caUoaMXt3
 xFonIcYu403Dfs+4f7m1ZsNYAXl8NXRK6wHF4MR6NLxG4tmC4i493C7i9LNSmoBR0Aet
 htyOcZJ9JTEsg92PBB16udH1c5rD0RP3lh18ms/Nh+B+wD+PU/ZLtBfcEbJzqFKxWUzi
 6JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786648584; x=1787253384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HHNGOJ4JW6/xM+akzv3IjGDFyOH8vS5GN6tAHz20i80=;
 b=W8TsMjzYuHBwWoZ4/BSnnaMhinmyKro3dMQ3uOURn+TzNdCqT/SI5Jod+8SxUH79WX
 86FAlAwwJV/P9TtsScZ2ia5HmPVhmVspht3jdvTd/EfCwj+PvvZY2LqvcVPRkOpofMjt
 21EyHULymqD+fyEa4gQwQq5xYc6NRgt7KDLKH083WtoFPv9E02KHnUMRzwxLUOR+3VC4
 aPILDdcH8nivRvC4cPGx8N4rc9DBdLl1fGHPOqIM0V62TonPUlIRJMjGKRuXOcJk042s
 xZfOqU6YUlW/pCGFthPYZjaabUqdAlbThq/jXaFkZ8Lw0ng2t9CLXvpkJzCnW2az/lGd
 XYnA==
X-Gm-Message-State: AOJu0Yzv+3v1xKbJAgiSNnmuoy344fvRRLk4iG+legr9PZCir76xRU7F
 UdTmwENVhp+quLy90IJGZdSCMyf/pTbxCFpM6eBY62c9kUOCLbvdTPavYh2htia9w02XoUYl9k8
 iD1g0
X-Gm-Gg: AR+sD11SwIjMeJ+RWo7PbxMELUH5AcJEPcmAQxFlwmnJOwqs5LEo6UQR0moXAGY76rd
 AF1L5shQrhQVI1UROPaYKfI5qRWvnxo7+g4DsgH/tCWLSx3ACkPc23qB+b0DUMIfhYXZkktXao+
 /aNAPyqVGwqMoSW1eE641Yq+BsWv8KVexR2gWWseg7YZphL592shdxscb8xfyDziynuJW/jb3Te
 bfwEYOgefzmz1Y77dP+yYWQ+6FSxnbDJ40FoB4f9CKdczjNbkyTKScw4u7xnO6SW9aNcFSunguX
 vApNXdsJYjW73GgcxGejX5nfSeFWXKpbtKc33x+fuPcyrU0KKN7VvXJvJrFQhegCzUb0tbn1f70
 I25AxZ4khP3rs9a2h8hf2WZT3i2E742g4dUOV3S84Tv5tomDU/mfc5DoX0N75XXLgJqlESUo45r
 MODSpeRfRFP/2WAIXtlIdbKVbfiAlZbql2I6zyrSPCwPvPx6jHtm/fwh2V
X-Received: by 2002:a05:600c:8714:b0:495:4d00:2fda with SMTP id
 5b1f17b1804b1-49987935852mr10229455e9.2.1786648584068; 
 Thu, 13 Aug 2026 12:16:24 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:859:6d78:3324:fe2c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1f90sm1312493f8f.18.2026.08.13.12.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:16:23 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 philmd@oss.qualcomm.com, den@openvz.org
Subject: [PULL v3 7/7] tests/qtest/ahci: regression test for ATAPI read vs.
 drain
Date: Thu, 13 Aug 2026 21:16:12 +0200
Message-ID: <20260813191613.2323728-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813191613.2323728-1-den@openvz.org>
References: <20260813191613.2323728-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=den@openvz.org; helo=mail-wm1-x32f.google.com
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

From: Denis V. Lunev <den@openvz.org>

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


