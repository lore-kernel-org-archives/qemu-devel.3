Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8883C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3zT-0000dR-HV; Thu, 20 Aug 2026 10:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zG-0000ZI-D1
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zE-0005Aj-Mz
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:22 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so14258035e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787236999; x=1787841799; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=URHXHuB5q+jdDgkSRrqqGTDtFQ6LaDVzcDRgrGWT+KY=;
 b=CGYg3sY/Hrd0nGqVYg60nGP6R0Kx3V6VI27QFJzrcdg1vQply1WVDcEFXn9nlEeuk6
 /JJfqvR1usZE3MVAx1dhRLFlJ7c87zAS/DL1NrDOqKps0w86jPwm4hDBR1sWDjOaJKBT
 FE+LAgQx2kaffilwkqbKaqVDe7vZYTaPai5cHoBuXfpn26I0bMNzGMhxxg27Y+yrL/SW
 TEgBawCn2NmHUXKzkxIREOnHAJhrKaPpLa6kj2BXvenYgpsqzD6ZCyz+xWAAh1d0toSj
 n0qwIj4tjZMElWSJO103z3GI+wGxcShHl3rskR0suPLfhaw6ug1qrTFmICZ7HdHSmUcw
 CXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787236999; x=1787841799;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=URHXHuB5q+jdDgkSRrqqGTDtFQ6LaDVzcDRgrGWT+KY=;
 b=AsVHtj/Gq8IPr3klCJjOWfEH3W99dhjIllBKtyCYjcJC3MD6UyCXroqUck/RpYGYaa
 12A7ARG8ROaFm0n/b7NA9gkROmQgzSQcv/2thbrSm0Oyzo+osew4SmSvhH1uM8pCsKSY
 JTOM1qZk38+d/EFLcZI314t2pXxlpzV9QmoszI3LDPswjQipzorr0RsxbPLLYEpwp+iO
 jfzaPPXUzEZ/B25OZtKr1Hl6TCfpX2itApz3oI3i1KIWgCY2BSsoyBlVqTFYF+uT1STG
 9Vyt/4JTJlivWUmZILyTEXvWc+b7NI3c8C4q+WiONUmeJFeSpavwKztMnoWHFXaRBe/h
 Gt+A==
X-Gm-Message-State: AOJu0YysWijsFasfl7mS2mp5EavDAoa29+6bzBfhgVhYfpqq+xstfFWr
 kA2fer/bbJDRzGYNKh06t8YFTzR75NlkBYciul02Wjck/sMXBVfBJqhGo6fPNaH+O1SkWUw6VwD
 Fpk4D
X-Gm-Gg: AR+sD13w6FV8M+rYcs14WUTMVg0DxYvmpBO+kBzxUL0qzfhA+cQJV9IQhtsfyVoCx/+
 /TluaCjyEbk0M8f6HRGwdmbbr8HQbTPD0/G0DjQv08U1Xp/lBYFfBgxwlsu9dd3nh/1RQbiQgMT
 6QE534OGh6aSLh4PByvo5UppxsRnVeNhdy8nZvxnrGOZ5wjthxz9qg0Lun4nZVlJ+hj02tgXDht
 Icg/GWeK9Mz7cmh5UyhiNKjivwQlvgIFZn8r+YS/LAKWjElR5e4EQoXiTVXGCBa04hal3gGOQnD
 n4xIBtwIACv9MOwf62lhEn9rT2Jg1V4oGYC2UnI0xNJm1V+VBGQv53aJrqfc7nU7dXo6jJb7dRb
 iebDM8uuzMm8x8PL1DxuRBsNZlnldUrzpliecxRJabG6DL1EjpOFMp9LxHnbFkqF5/MPN0snVjq
 M5MHJy6IQeVPDUJO1vgfE/DOwt/pe2RuvSj4tGqV6/NGJMVVe0I3hTtmjtjQ==
X-Received: by 2002:a05:600c:3e0f:b0:499:a79a:694d with SMTP id
 5b1f17b1804b1-499aa155e7dmr254530955e9.4.1787236999066; 
 Thu, 20 Aug 2026 07:43:19 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd620sm136791565e9.13.2026.08.20.07.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 07:43:17 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 05/11] tests/qtest/ahci: regression test for a PIO write vs.
 engine stop
Date: Thu, 20 Aug 2026 16:43:03 +0200
Message-ID: <20260820144309.835173-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820144309.835173-1-den@openvz.org>
References: <20260820144309.835173-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=den@openvz.org; helo=mail-wm1-x32e.google.com
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


