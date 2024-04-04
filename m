Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35864CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 08:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsIt5-0004Vj-V7; Thu, 04 Apr 2024 04:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsIt4-0004TT-7d
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 04:55:58 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsIt1-00042y-QZ
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 04:55:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34388753650so318319f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 01:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712220953; x=1712825753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d675Kf1VTwkAdTecByRBW+ew2Ri5wN4dvsw2IHRaYGs=;
 b=aORh1k/qGMnTnm3Da+4tIqK05K3eXYnFtD3I9AF7jq4vi6/SJJykVitZL+iQhlp+Gi
 mxkYNqFaHF+uEDW2l0fYEH0DQkT/bjChAraiO4ktCFlWMKCHSaKddzSY/Q9lOuNPI5ja
 NcVbbjFSMjP2idKNipxG4BKCibGdDG9BPtYkVO7oCrmGHAqAqJbrTsxkUpyXYziKHDk3
 fmX+PYsbZLDhVOdLoirKdcnIBA86h/bNI03fioqJHq++aqWoqWHaO9X0PF/pU+i+dl7v
 +4SLRL5m9gAh/ee2Kckd5WbZ0DGVAtNNH9m+uwtF+ewpLn2hvs8UBhbv8JH5MixF0r2P
 QATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712220953; x=1712825753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d675Kf1VTwkAdTecByRBW+ew2Ri5wN4dvsw2IHRaYGs=;
 b=TOlAjqsS3oOllwKShrzkszSBRGDR7UftaAYe3HO7OFhp/QVaRhYWQUSO3dx3dh0zIv
 dmmFoCaIrM4vJOdAKqh7CIYCBo7TJ9LRAkYPmN+sNdoIcae/g480YGNxcC/iDppOxp9p
 OS4OJB4G1vFyYO+0lh0SpiKxSc7yd2aPdczWwKcK6+U4K5rNHe596zk+if9HctDgN2qi
 IIgAuec1FzFvoEvu1NnNgNRjUmqPKPM7qa9H4F5Ro6qQeOZEZ9Ex4iSYUYlFi7hYURFT
 qWdvwlr+8NP6B0pt4zOZEOrNIAn96YH8QujColQpEIaxlfbVa/jaGFCFJmfGvjObj+A7
 OuAQ==
X-Gm-Message-State: AOJu0YxauNym4k3IGBQxURvNu3/tpP+fVtodUYsx4+rTF9lC4Xbqx8DI
 b3hnsQJg1b4ucnuiQWuDENntO525Th69XD/C1gL/qlI8KyAQc/ZYawWVNSb6mSbZ16ONZ2ScN3p
 AET4=
X-Google-Smtp-Source: AGHT+IEkXxtPtNTsfKAWm9v/NWKSYGc0uGhHEeWjCRKoLFYhFzmUkN5ofeDfnXCuPVriSujMyvNXAw==
X-Received: by 2002:adf:db4c:0:b0:343:b9e4:7f70 with SMTP id
 f12-20020adfdb4c000000b00343b9e47f70mr890946wrj.53.1712220953083; 
 Thu, 04 Apr 2024 01:55:53 -0700 (PDT)
Received: from localhost.localdomain ([77.205.40.54])
 by smtp.gmail.com with ESMTPSA id
 w18-20020adff9d2000000b00343b09729easm2039339wrr.69.2024.04.04.01.55.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Apr 2024 01:55:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-stable@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH-for-9.0] hw/sd/sdhci: Discard excess of data written to Buffer
 Data Port register
Date: Thu,  4 Apr 2024 10:55:48 +0200
Message-ID: <20240404085549.16987-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Per "SD Host Controller Standard Specification Version 3.00":

  * 1.7 Buffer Control

  - 1.7.1 Control of Buffer Pointer

    (3) Buffer Control with Block Size

    In case of write operation, the buffer accumulates the data
    written through the Buffer Data Port register. When the buffer
    pointer reaches the block size, Buffer Write Enable in the
    Present State register changes 1 to 0. It means no more data
    can be written to the buffer. Excess data of the last write is
    ignored. For example, if just lower 2 bytes data can be written
    to the buffer and a 32-bit (4-byte) block of data is written to
    the Buffer Data Port register, the lower 2 bytes of data is
    written to the buffer and the upper 2 bytes is ignored.

Discard the excess of data to avoid overflow reported by fuzzer:

  $ cat << EOF | qemu-system-i386 \
                     -display none -nodefaults \
                     -machine accel=qtest -m 512M \
                     -device sdhci-pci,sd-spec-version=3 \
                     -device sd-card,drive=mydrive \
                     -drive if=none,index=0,file=null-co://,format=raw,id=mydrive -nographic \
                     -qtest stdio
  outl 0xcf8 0x80001013
  outl 0xcfc 0x91
  outl 0xcf8 0x80001001
  outl 0xcfc 0x06000000
  write 0x9100002c 0x1 0x05
  write 0x91000058 0x1 0x16
  write 0x91000005 0x1 0x04
  write 0x91000028 0x1 0x08
  write 0x16 0x1 0x21
  write 0x19 0x1 0x20
  write 0x9100000c 0x1 0x01
  write 0x9100000e 0x1 0x20
  write 0x9100000f 0x1 0x00
  write 0x9100000c 0x1 0x00
  write 0x91000020 0x1 0x00
  EOF

Stack trace (part):
=================================================================
==89993==ERROR: AddressSanitizer: heap-buffer-overflow on address
0x615000029900 at pc 0x55d5f885700d bp 0x7ffc1e1e9470 sp 0x7ffc1e1e9468
WRITE of size 1 at 0x615000029900 thread T0
    #0 0x55d5f885700c in sdhci_write_dataport hw/sd/sdhci.c:564:39
    #1 0x55d5f8849150 in sdhci_write hw/sd/sdhci.c:1223:13
    #2 0x55d5fa01db63 in memory_region_write_accessor system/memory.c:497:5
    #3 0x55d5fa01d245 in access_with_adjusted_size system/memory.c:573:18
    #4 0x55d5fa01b1a9 in memory_region_dispatch_write system/memory.c:1521:16
    #5 0x55d5fa09f5c9 in flatview_write_continue system/physmem.c:2711:23
    #6 0x55d5fa08f78b in flatview_write system/physmem.c:2753:12
    #7 0x55d5fa08f258 in address_space_write system/physmem.c:2860:18
    ...
0x615000029900 is located 0 bytes to the right of 512-byte region
[0x615000029700,0x615000029900) allocated by thread T0 here:
    #0 0x55d5f7237b27 in __interceptor_calloc
    #1 0x7f9e36dd4c50 in g_malloc0
    #2 0x55d5f88672f7 in sdhci_pci_realize hw/sd/sdhci-pci.c:36:5
    #3 0x55d5f844b582 in pci_qdev_realize hw/pci/pci.c:2092:9
    #4 0x55d5fa2ee74b in device_set_realized hw/core/qdev.c:510:13
    #5 0x55d5fa325bfb in property_set_bool qom/object.c:2358:5
    #6 0x55d5fa31ea45 in object_property_set qom/object.c:1472:5
    #7 0x55d5fa332509 in object_property_set_qobject om/qom-qobject.c:28:10
    #8 0x55d5fa31f6ed in object_property_set_bool qom/object.c:1541:15
    #9 0x55d5fa2e2948 in qdev_realize hw/core/qdev.c:292:12
    #10 0x55d5f8eed3f1 in qdev_device_add_from_qdict system/qdev-monitor.c:719:10
    #11 0x55d5f8eef7ff in qdev_device_add system/qdev-monitor.c:738:11
    #12 0x55d5f8f211f0 in device_init_func system/vl.c:1200:11
    #13 0x55d5fad0877d in qemu_opts_foreach util/qemu-option.c:1135:14
    #14 0x55d5f8f0df9c in qemu_create_cli_devices system/vl.c:2638:5
    #15 0x55d5f8f0db24 in qmp_x_exit_preconfig system/vl.c:2706:5
    #16 0x55d5f8f14dc0 in qemu_init system/vl.c:3737:9
    ...
SUMMARY: AddressSanitizer: heap-buffer-overflow hw/sd/sdhci.c:564:39
in sdhci_write_dataport

Cc: qemu-stable@nongnu.org
Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
Buglink: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=58813
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Reported-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index c5e0bc018b..2dd88fa139 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -552,7 +552,7 @@ static void sdhci_write_block_to_card(SDHCIState *s)
  * register */
 static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned size)
 {
-    unsigned i;
+    unsigned i, available;
 
     /* Check that there is free space left in a buffer */
     if (!(s->prnsts & SDHC_SPACE_AVAILABLE)) {
@@ -560,6 +560,14 @@ static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned size)
         return;
     }
 
+    available = s->buf_maxsz - s->data_count;
+    if (size > available) {
+        qemu_log_mask(LOG_GUEST_ERROR, "SDHC buffer data full (size: %"PRIu32")"
+                                       " discarding %u byte%s\n",
+                                       s->buf_maxsz, size - available,
+                                       size - available > 1 ? "s" : "");
+        size = available; /* Excess data of the last write is ignored. */
+    }
     for (i = 0; i < size; i++) {
         s->fifo_buffer[s->data_count] = value & 0xFF;
         s->data_count++;
-- 
2.41.0


