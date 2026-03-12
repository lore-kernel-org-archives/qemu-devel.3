Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58496105A597
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 12:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0fcv-0001XX-9x; Thu, 12 Mar 2026 08:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w0b0X-00049X-7Y; Thu, 12 Mar 2026 04:03:01 -0400
Received: from m16.mail.163.com ([117.135.210.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w0b0T-000300-PQ; Thu, 12 Mar 2026 04:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iw
 N70IGVIihTn1NebDMIyTrI835ll0xmB6Rk95KoXSY=; b=EAsM5RybTVSFLd3Ui+
 7zTrWx/v6cRaR9dwIxzELPidBTL4F91j8yGe6heF6nA3TZs4IOfoJ9bep+Yvu3b6
 kCUK2HJrVdQugjlGiWyNvndch1XVaS+dwGJtrnSWdQRRmhF4S0LlNVH4og19iP3j
 CP97pygkRbl6Cum+gI2iIMx/4=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wBXHlMcc7JpkIIcAg--.55484S3; 
 Thu, 12 Mar 2026 16:02:37 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Tao Ding <dingtao0430@163.com>
Subject: [PATCH v1 1/3] An interrupt is generated after the DMA transfer
 complete.
Date: Thu, 12 Mar 2026 16:02:33 +0800
Message-ID: <7584486ba62bc6d767c0d132dc843067f8c5efff.1773301927.git.dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773301927.git.dingtao0430@163.com>
References: <cover.1773301927.git.dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXHlMcc7JpkIIcAg--.55484S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4fZryrtFy3ZrWxWw13twb_yoW8Ar1fpF
 9rKFWrKr4kAr45u3W0qr18W3W5Xr42ya9xZwsrXr1qkr98X3ySgryrGryIkrWjyFn3Ar1S
 vFZFqrW3Krs0q3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UheONUUUUU=
X-Originating-IP: [175.152.130.74]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-R3qKWmycx0J2gAA3F
Received-SPF: pass client-ip=117.135.210.2; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_MSPIKE_BL=0.001,
 RCVD_IN_MSPIKE_L3=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Mar 2026 08:58:55 -0400
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

PL080 cannot trigger interrupt correctly. Reproduce this problem in a simple way.

In the versatilpb board, the interrupt output of pl080 is connected to the 17th interrupt input of pl190.
By reading the status register of pl190, determined whether there is an interrupt generated for the corresponding input.

The basic address of pl080 is 0x10130000, and the basic address of pl190 is 0x10140000. 
Read the value of the address through the qemu monitor.

Configuration
    ../configure --target-list=arm-softmmu --enable-debug
Reproducer
    ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
    -device loader,addr=0x00000000,data=0x11223344,data-len=4 \
    -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
    -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
    -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
    -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
    -device loader,addr=0x10130108,data=0x00000000,data-len=4 \
    -device loader,addr=0x1013010C,data=0x9e4bf001,data-len=4 \
    -device loader,addr=0x10130110,data=0x0000c001,data-len=4

Qemu monitor
    (qemu) xp /1wx 0x10140008
    10140008: 0x00000000

The result correctly after fixed
    (qemu) xp /1wx 0x10140008
    10140008: 0x00020000

Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/dma/pl080.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 3f8acb03de..0979a687aa 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -212,6 +212,7 @@ again:
         if (--s->running)
             s->running = 1;
     }
+    pl080_update(s);
 }
 
 static uint64_t pl080_read(void *opaque, hwaddr offset,
-- 
2.43.0


