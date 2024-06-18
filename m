Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37BAC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 13:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJYZK-0002tE-G5; Tue, 18 Jun 2024 09:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sJYZI-0002so-BT; Tue, 18 Jun 2024 09:08:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1sJYZF-0000sv-C6; Tue, 18 Jun 2024 09:08:12 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxL_CvhnFma+oHAA--.31871S3;
 Tue, 18 Jun 2024 21:07:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxJMWuhnFmkYcnAA--.19305S2; 
 Tue, 18 Jun 2024 21:07:59 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, git@xen0n.name, maobibo@loongson.cn,
 yijun@loongson.cn, qemu-stable@nongnu.org
Subject: [PATCH] tcg/loongarch64: Fix tcg_out_movi tcg_debug_assert() error
Date: Tue, 18 Jun 2024 20:50:44 +0800
Message-Id: <20240618125044.687443-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxJMWuhnFmkYcnAA--.19305S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Loongnix 20.5 systems, QEMU configure with option '--enable-debug'
or '--enable-debug-tcg ', booting the Loongnix 20.5 VM in tcg mode
will get an assertion error.

    "...
    [   31.484992] [drm] Initialized virtio_gpu 0.0.1 0 for virtio1 on minor 0
    qemu-system-loongarch64: /home1/gaosong/code/github/clean/qemu/tcg/loongarch64/tcg-target.c.inc:394：tcg_out_movi: 假设 ‘offset_hi == sextreg(offset_hi, 0, 20)’ 失败。
    ./start.sh: 行 14: 2433006 已放弃               (核心已转储)./build/qemu-system-loongarch64 --accel tcg -m 8G -cpu la464 -machine virt -smp 8 -serial stdio -bios ./QEMU_EFI.fd -monitor telnet:localhost:4498,server,nowait -device virtio-gpu-pci -net nic, -net user -device nec-usb-xhci,id=xhci,addr=0x1b -device usb-tablet,id=tablet,bus=xhci.0,port=1 -device usb-kbd,id=keyboard,bus=xhci.0,port=2 -device virtio-blk-pci,drive=test -drive if=none,id=test,file=./Loongnix-20.5.cartoon.mini.loongarch64.cn.qcow2 "

The values of offset_hi and sextreg(offset_hi, 0, 20) are:

    "[   29.975240] virtio_gpu virtio1: fb0: virtiodrmfb frame buffer device
    offset_hi is 80000
    sextreg(offset_hi, 0, 20) is fffffffffff80000
    offset_hi is 80000
    sextreg(offset_hi, 0, 20) is fffffffffff80000
    offset_hi is 80000
    sextreg(offset_hi, 0, 20) is fffffffffff80000
    ..."

When pcalau12i + ori is not satisfied, we should use other methods instead,
instead of generating an assertion error.

Cc: qemu-stable@nongnu.org
Reported-by: yijun <yijun@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 tcg/loongarch64/tcg-target.c.inc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 06ca1ab11c..592494c48d 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -391,7 +391,9 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
         pc_hi = (val - pc_offset) >> 12;
         offset_hi = val_hi - pc_hi;
 
-        tcg_debug_assert(offset_hi == sextreg(offset_hi, 0, 20));
+        if (offset_hi != sextreg(offset_hi, 0, 20)) {
+            goto out;
+        }
         tcg_out_opc_pcalau12i(s, rd, offset_hi);
         if (val_lo != 0) {
             tcg_out_opc_ori(s, rd, rd, val_lo & 0xfff);
@@ -399,6 +401,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
         return;
     }
 
+out:
     hi12 = sextreg(val, 12, 20);
     hi32 = sextreg(val, 32, 20);
     hi52 = sextreg(val, 52, 12);
-- 
2.39.3


