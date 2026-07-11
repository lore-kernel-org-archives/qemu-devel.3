Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB35FC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifo8-000266-Ph; Sat, 11 Jul 2026 18:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifo6-0001tZ-8V; Sat, 11 Jul 2026 18:04:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifo4-0000I3-7q; Sat, 11 Jul 2026 18:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=6o4QXKrAfHBv/13iR2iSq2AMyvJa+9WDo2zhcCyCTys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Gs/EfHj8frV8v00zuTmgXqxAsAIGD766vr1Jm7eNaR9ULIfe/Ea6QmEQgjylKe4fn
 zIpLgkDATFy/1MQqnZsKR3qCcHS7kUrDw7Oz3LxOP0cQifr9ahWORP8IhqfExelxVR
 RfoLBPEA6wbj5bxDkjsT+UFELAhdsdDXIfgWaoPH0fLgZTADRJsyrstt5Ta/iefaQ6
 l7qmzFLf8tPJnLW+5JgXbQs8w3RAVQ2N3j1xV4jqbjrkt3/wKw0jpD8lorsRS3MvsD
 R5ZeBtAxOcctnR+2VXOmT4E/XwY2ST0mbt3zl2ZD9aLXn9xI9Tw53ONCF2eJiuQA3C
 V0MnF5Ee4/RHg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 444551C0ABD;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EFAC93EAF48;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AFEB413347; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 50/81] hw/dma/i8257: Return zeroes for read_memory in
 verify mode
Date: Sun, 12 Jul 2026 00:58:28 +0300
Message-ID: <20260711215904.3757-50-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The i8257 DMA controller has a "verify" mode, which the datasheet
describes like this:

> DMA verify, which does not actually involve the transfer of data.
> When an 8257 channel is in the DMA verify mode, it will respond the
> same as described for transfer operations, except that no memory or
> I/O read/write control signals will be generated.  When an 8257
> channel is in the DMA verify mode, it will respond the same as
> described for transfer operations, except that no memory or I/O read
> /write control signals will be generated, thus preventing the
> transfer of data.  The 8257, however, will gain control of the system
> bus and will acknowledge the peripheral's DMA request for each DMA
> cycle.  The perihperal can use these acknowledge signals to enable an
> internal access of each byte of a data block in order to execute some
> verification procedure, such as the accumulation of a CRC check word.

In practice, for QEMU's purposes the only real user of this is the
floppy controller, which can be made to perform a "read data from
floppy disk and check the checksum" by telling the fdc to do a read
and the DMA controller to do a verify.  This causes the fdc to do all
the usual read actions including the checksum, but the data is never
written to memory.  However, it is possible for a guest doing
something silly to program the DMA controller to do a verify
operation for a device that wants to read from memory.  Currently we
simply return early from i8257_dma_read_memory() without writing to
the buffer.  None of the callers (the GUS, sb16 and cs4231a sound
cards, plus the fdc) expect this, so they will take the uninitialized
data as if it were from the guest.  This can cause us to leak host
data off the stack into the guest.

Make i8257_dma_read_memory() fill the buffer with zeroes rather
than leaving it untouched for a verify operation.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3487
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260629140128.1900095-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 03071f99a3e1549b3acc9b9534961632df016f76)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 3637d8f82d7..34c19dbd84e 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -407,6 +407,19 @@ static int i8257_dma_read_memory(IsaDma *obj, int nchan, void *buf, int pos,
     hwaddr addr = ((r->pageh & 0x7f) << 24) | (r->page << 16) | r->now[ADDR];
 
     if (i8257_is_verify_transfer(r)) {
+        /*
+         * If the device is expecting this verify operation then
+         * it won't care about the nonexistent data. But if it
+         * is expecting a real read (i.e. the guest has misprogrammed
+         * the DMA controller and the device) it's going to try to do
+         * something with the buffer contents. Give it zeroes.
+         * (It's not clear whether this is exactly what happens if
+         * you do this on real hardware. In practice no device QEMU
+         * emulates has a use for verify on a memory-read transfer,
+         * so we don't care beyond avoiding the guest being able to
+         * trigger the caller reading uninitialized data.)
+         */
+        memset(buf, 0, len);
         return len;
     }
 
-- 
2.47.3


