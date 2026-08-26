Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29577C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfR-0004iR-Pr; Wed, 26 Aug 2026 07:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfO-0004YF-ST
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:39 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfN-0005mK-1R
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:38 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a5ebf75d62so784158a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743175; x=1788347975; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=URHXHuB5q+jdDgkSRrqqGTDtFQ6LaDVzcDRgrGWT+KY=;
 b=GO/xv7EDH48FRwqFCSnoBTK+q7BBphIRTdcOCE0r8AAumnAa9tdgU3wj+hAqVU4p7w
 gTGYEJOLtezHdMk1tM53lTmSbbqhhhtu02pcAeBrotTTMe5brX+i4HVEkONVIK1jY8zU
 Bb0U7qBQzBYi3m6sfRmwOLXtrfQ3CiU9ky4JLEoz6XRk4lCnNGgFd5pjmS8v7JrUdkxs
 V7jzGAuLaFt6wtYHt0tBkfgje4tc34jepB62Wqic8BLvAP7kpxbzw/ZBJaI4AGLQfGMx
 ZuZkK0OacKV0t5mf5ZQssNFaJZyZmnrTxZcPb6w1KbRTEs+MlgmARgsEudlwm/GpoRXx
 9Mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743175; x=1788347975;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=URHXHuB5q+jdDgkSRrqqGTDtFQ6LaDVzcDRgrGWT+KY=;
 b=FukcbcBa4Gd/V09bXbdx4In1ySvg2xqrXG+x4fzUeYe1wnPKYOlfFadh9kdse+sC72
 FQR60Y7OlfL7y1zTiD4CaDkjHGS94q8J5jtYyZnjjb2HEnadq6HeyNfheX4Q2xUj+XXa
 Z9jH0UAkrXmspEcx89nPSaLalW6Zk/Qu4QdOvEBT5r1xraNfslSkOl5fBCm0QilSol0U
 cPF7JiZjLlVh38TnsQH3RJyjn/VBFKVJO9VIKX5GMvfyAfMhHJK67UgnrIkZdLIJFNip
 SK1xEyBFM79Z0yIHFwQS9PNb02VzBnUj8INrzDh3kyHGqzbGVl2ku80xehAxGM1s/qMK
 uAqQ==
X-Gm-Message-State: AFuF++kcgMgP8R+ZbGh8gN9BpPRyKH/S2FZfaC6lMuiKUjvxxB/2bMZE
 uKBNquzvRuxkzeAZYF6G92RmaIg+VaQdl6aB0aDIeeVqJjh9LininCol5Av+H0mpwHBRaxDyVub
 UehRo
X-Gm-Gg: AR+sD12it/DCU0xIBkVo/FEB3N8Ga24RlK3X85kmllLT3U1EPQjxs4ArN0fl5ZwMT/C
 dADVYDv1F/9e84f/+GhU8T5RiU9jOy7NdZWYTnAeZwC5rczL/j0vT3+kSuvxLRX5Q2k7KK7/csJ
 qmcem6HiPq9M0qBINyAZCCUO/JBZ4XePyQ25xrfpBJquR4n4Jt1uOl5AnHauqrGYRBRZBswaBS2
 0PdCZToq3BO79l1qqFT9zd9Qrg8krkxFWPK/K8jUdA8SLSKs9kSI6xB6WoQGaFfrWDCUm3+PZ+I
 3k6FD0JNkUraqNEhMxBYt4x8OgfpkLcaXfznnnJPnUVQLWXlAPGj7/VbO7HHXOxMU5ejbSfge/d
 bD63uDWCPgODWBwJ1zyGvWWiEBKvOWbbN/hC06Tf/k3ClrVy+G3C+u3NO/WFkBdgk8pfaaKxycw
 Lr4Ap2AJLF6xCfRyhPkJCFECA+X0B7p9zvNaUHMNoYDjoxRY0M
X-Received: by 2002:a05:6402:1515:b0:6a5:d284:1134 with SMTP id
 4fb4d7f45d1cf-6a5d28413a6mr10835722a12.2.1787743175478; 
 Wed, 26 Aug 2026 04:19:35 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:34 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 22/28] tests/qtest/ahci: regression test for a PIO write vs.
 engine stop
Date: Wed, 26 Aug 2026 13:19:09 +0200
Message-ID: <20260826111915.3387926-13-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=den@openvz.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

Add /ahci/io/pio/engine_stop: hold the backend write of a two-sector
PIO write with a blkdebug breakpoint, clear PxCMD.ST so the command
list is unmapped underneath it, then let the write complete. The
second DRQ phase runs from that completion and reaches
ahci_pio_transfer() with no command header.

Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ahci-test.c | 72 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 30d7005626..84d4e6b0a5 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1793,6 +1793,76 @@ static void test_atapi_engine_restart_dma(void)
     test_atapi_engine_restart_in_flight(true);
 }
 
+/*
+ * Regression test: a PIO write outlives the command list it was issued from.
+ * ide_cancel_dma_sync() does not reach s->pio_aiocb, so the second DRQ phase
+ * runs from the write completion after PxCLB has been unmapped and must not
+ * touch the command header any more.
+ */
+static void test_write_engine_stop_in_flight(void)
+{
+    AHCIQState *ahci;
+    AHCICommand *cmd;
+    unsigned char *tx;
+    unsigned char *rx;
+    uint64_t ptr;
+    uint8_t port;
+    size_t bufsize = AHCI_SECTOR_SIZE * 2;
+    size_t i;
+
+    ahci = ahci_boot_and_enable("-drive file=blkdebug::%s,if=none,id=drive0,"
+                                "format=%s,cache=writeback "
+                                "-M q35 "
+                                "-device ide-hd,drive=drive0 ",
+                                tmp_path, imgfmt);
+    port = ahci_port_select(ahci);
+    ahci_port_clear(ahci, port);
+
+    tx = g_malloc(bufsize);
+    generate_pattern(tx, bufsize, AHCI_SECTOR_SIZE);
+    ptr = ahci_alloc(ahci, bufsize);
+    g_assert(ptr);
+    qtest_memwrite(ahci->parent->qts, ptr, tx, bufsize);
+
+    /* Zero the second sector, which the abandoned command must not reach. */
+    rx = g_malloc0(AHCI_SECTOR_SIZE);
+    ahci_io(ahci, port, CMD_WRITE_DMA, rx, AHCI_SECTOR_SIZE, 1);
+
+    /* Suspend the backend write so the first sector stays in flight. */
+    g_free(qtest_hmp(ahci->parent->qts,
+                     "qemu-io drive0 \"break write_aio wr\""));
+
+    cmd = ahci_command_create(CMD_WRITE_PIO);
+    ahci_command_adjust(cmd, 0, ptr, bufsize, 0);
+    ahci_command_commit(ahci, cmd, port);
+    ahci_command_issue_async(ahci, cmd);
+
+    /* Drop the command list while the write is still outstanding. */
+    ahci_px_clr(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+
+    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"resume wr\""));
+
+    /* Round-trip through the device to confirm qemu is still alive. */
+    ahci_px_rreg(ahci, port, AHCI_PX_TFD);
+
+    /*
+     * The second DRQ phase never fetched its data, so the sector it would
+     * have carried has to be untouched rather than hold a copy of the first.
+     */
+    ahci_px_set(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+    memset(rx, 0xff, AHCI_SECTOR_SIZE);
+    ahci_io(ahci, port, CMD_READ_DMA, rx, AHCI_SECTOR_SIZE, 1);
+    for (i = 0; i < AHCI_SECTOR_SIZE; i++) {
+        g_assert_cmpint(rx[i], ==, 0);
+    }
+
+    ahci_command_free(cmd);
+    ahci_free(ahci, ptr);
+    g_free(rx);
+    g_free(tx);
+    ahci_shutdown(ahci);
+}
+
 /*
  * Regression test: a multi-sector ATAPI read fetches its later sectors from
  * inside the first read's completion; a concurrent drain (as a guest reset
@@ -2281,6 +2351,8 @@ int main(int argc, char **argv)
                    test_atapi_engine_restart_pio);
     qtest_add_func("/ahci/cdrom/engine_restart/dma",
                    test_atapi_engine_restart_dma);
+    qtest_add_func("/ahci/io/pio/engine_stop",
+                   test_write_engine_stop_in_flight);
     qtest_add_func("/ahci/cdrom/drain/pio", test_atapi_drain_pio);
     qtest_add_func("/ahci/cdrom/drain/dma", test_atapi_drain_dma);
 
-- 
2.53.0


