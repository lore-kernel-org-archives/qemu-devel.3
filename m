Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2730CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCt1-0007Rp-HU; Tue, 09 Apr 2024 10:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruCsz-0007Md-6F
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:55:45 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruCsl-0005Qc-5R
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:55:44 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so2682651a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712674527; x=1713279327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4hk44b0CTtK39ComG0H6DHcrT6hIyE7whcTtxk6ce7I=;
 b=PInQX4QjACzKbLUsh7FXT+zCsGj7SMG+4vaFcHp1oXloYiTZDT02iJkRrHJdp8wQhP
 0u6ZLx+DwhuNj7qc8/+PXIuottNBtTCvS5siKwwpqtIL5gbCtcgIWcLqss7aPJM5vYCJ
 s0N33aA7nLg3ExhgG9LmFi9Vx5XoELf2lZtb5RzfGDVPMSt1ucZxNZxkWIs9samyRqJW
 5HEaO/sHZuZGSY7aFQNDYEiku76NHOrIs2Um1npcWuuXZHc59TJgsrsa56/QOlNUITrB
 v1XG39M8z2X/BrzKb1DiSSzB5rwhnufSJXoCr3gl/omNaEKU3Ipe34N3H+Sbl7Bf0XM8
 ZGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712674527; x=1713279327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4hk44b0CTtK39ComG0H6DHcrT6hIyE7whcTtxk6ce7I=;
 b=jO+N5mBL2dN1MoXsnnEividPEXun7elPXhN2ykpeZ+GBb0KX/++Pud3K0aZU0gG6TT
 73YAOzCWFpe7ZDdkKMrn4FssCRABEw201hWYPuOY3hlaZ8lrYl+rb9n2nJ+9mRCVV12o
 h6R/fCepj6iG3optTNo7fFnjQUx6KxAsS2zLcQsvr8H5KAYiRHb9jhFOG3g2rLiJOKKj
 xPA+jQnLoO5rabfkjQYHXLH8dIZtxQ+w7aaHQc+vv9kegiFwApszufkANP0MOr8AHNR6
 NQ6gO3inE3GJo2kH0CznTUvj2ya2c6iiTnam/DyA9a5V/1D0wTSU78/c4SJ8S+/NyHV4
 X8Bg==
X-Gm-Message-State: AOJu0YxUsW1JmfBDpCqRTD0sjJ2RpBG8kYcV5TpnwGMxgCRstbQ5HgL1
 ppMQ8yJNSFD68z8lkolT+cM4qmemkoX9nosvrFQhLQxI1GBwXfYEJ69zAmXRb4neJ/sRIFoYUeu
 X
X-Google-Smtp-Source: AGHT+IE/l2kTBvA10X0r3qP3E7aKGNfXQojS4/afUdoSqkJhS3J5arfIQ6VnESQ4lYnZF592NVNMiQ==
X-Received: by 2002:a50:9e84:0:b0:56c:24e6:ca7e with SMTP id
 a4-20020a509e84000000b0056c24e6ca7emr7674875edf.2.1712674527594; 
 Tue, 09 Apr 2024 07:55:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 er18-20020a056402449200b0056bfc48406csm5272968edb.7.2024.04.09.07.55.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 07:55:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Chuhong Yuan <hslester96@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH-for-9.0 v2] hw/sd/sdhci: Do not update TRNMOD when Command
 Inhibit (DAT) is set
Date: Tue,  9 Apr 2024 16:55:24 +0200
Message-ID: <20240409145524.27913-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

  * 2.2.5 Transfer Mode Register (Offset 00Ch)

    Writes to this register shall be ignored when the Command
    Inhibit (DAT) in the Present State register is 1.

Do not update the TRNMOD register when Command Inhibit (DAT)
bit is set to avoid the present-status register going out of
sync, leading to malicious guest using DMA mode and overflowing
the FIFO buffer:

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

Add assertions to ensure the fifo_buffer[] is not overflowed by
malicious accesses to the Buffer Data Port register.

Fixes: CVE-2024-3447
Cc: qemu-stable@nongnu.org
Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
Buglink: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=58813
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Reported-by: Chuhong Yuan <hslester96@gmail.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Peter, since it is your patch, can I replace the Suggested-by your
S-o-b tag?

Supersedes: <20240404085549.16987-1-philmd@linaro.org>
---
 hw/sd/sdhci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index c5e0bc018b..27673e1c70 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -473,6 +473,7 @@ static uint32_t sdhci_read_dataport(SDHCIState *s, unsigned size)
     }
 
     for (i = 0; i < size; i++) {
+        assert(s->data_count < s->buf_maxsz);
         value |= s->fifo_buffer[s->data_count] << i * 8;
         s->data_count++;
         /* check if we've read all valid data (blksize bytes) from buffer */
@@ -561,6 +562,7 @@ static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned size)
     }
 
     for (i = 0; i < size; i++) {
+        assert(s->data_count < s->buf_maxsz);
         s->fifo_buffer[s->data_count] = value & 0xFF;
         s->data_count++;
         value >>= 8;
@@ -1208,6 +1210,12 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         if (!(s->capareg & R_SDHC_CAPAB_SDMA_MASK)) {
             value &= ~SDHC_TRNS_DMA;
         }
+
+        /* TRNMOD writes are inhibited while Command Inhibit (DAT) is true */
+        if (s->prnsts & SDHC_DATA_INHIBIT) {
+            mask |= 0xffff;
+        }
+
         MASKED_WRITE(s->trnmod, mask, value & SDHC_TRNMOD_MASK);
         MASKED_WRITE(s->cmdreg, mask >> 16, value >> 16);
 
-- 
2.41.0


