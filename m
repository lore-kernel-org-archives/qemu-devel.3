Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6512EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCYg-0005J4-Sc; Mon, 29 Jun 2026 10:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weCYY-0005I4-CC
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:01:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weCYW-0008Sj-Cm
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:01:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493a5d32e8cso17159055e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782741706; x=1783346506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+TWHxiw/UhhyLv2Z7QTCjbZXmpvwWXJtjMFmHukF1+w=;
 b=Gkw0hSuXhr+3aaJVSq2ffKsYdWXcT3nW43OqHA1G8gHjsqRgcfUfjWW3pM2Sf1JP4p
 1RBHer9A01gK3nkJDntZNV0WWC+S7touW7nBjnVHdArBjzp9koaEb6118xEofE4PkSZv
 rInfWknMJp8QMck42swGqiQuqGALc+HrXN3rAY3h2edVG8OPi2D2saD5hRHNBeIDn2/O
 Hfo97hVY1O2PhO2U8iZfiDzBULJakSwvFy3vYlTuDnO83ehFdq6zVv7iC6B/gANqK/Zw
 7S83uG4RaJG1ACSn3Q4tN5EUO4v+vJzC5lZFfVX9tNuAjk0ndi/UvVF2gxCphj1VunUx
 quDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782741706; x=1783346506;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+TWHxiw/UhhyLv2Z7QTCjbZXmpvwWXJtjMFmHukF1+w=;
 b=Gl1/AiYtp/X78l2rekCGZl8N5NDrnpdQk5WOXq+b3FdCinIoEZnkTEQ9oQt527uxFG
 dKRVWeksfMXmC73625e90+38VL/pm1xYQIijEi3tVPMMr0ESJneIRXEUl4Cg9uPxai05
 vX/hheoQHoyeAHbESTgNdeIAblRrvEln11mAUsixLbg947cmky+F721/d/uC+6qSOuNx
 kHlCV69iib9TcPD/IvQ5kJxxIA+mfJc362Xikujgr1s81GBB8+Mde1vKBRDMpyVKqS0H
 Ifb5i27omW/z1DnSCo0pk/RuAR92mUQyFfDBmdARQBQX0IcI8025+8RT/KcGmxegZB4n
 EMBQ==
X-Gm-Message-State: AOJu0Yx0+H4Q7GEabk9HXBN/+HiW4Rv2ZoX2L6FE0yq4VX7JU8If5WPL
 8fv+HvT4TXF7UDaKS2RGGvadBL6icL7KgHkvvRHOnUJ52tuar+s58ykf68RGrN6OZ6Ot3Rjij7U
 mf0aE
X-Gm-Gg: AfdE7cmAzaJ5VavCH8N5bM2+UFiQxIPYMTVNVO9baVzQFMs38wox+/TyTgXsNhbZ2RH
 R7DAbgxpZiGOHPaNf/wk+8bBLVc02r70slWZTd53i9vcLq1vK1B+ZPyNRUfbQMYbL1C0j/8zbHF
 CgqTP/mYb1eSkkuKqe5SPSYM/oJufF435A50Va/IRIP7+EdwYI8dvnD0Jk+uBhbYdwhCHm+VNl4
 OXMAYHdzni2UTwz1VZOr+4IbnJY8ETkmoRjOMJy0gf/LFFAjdDtH7D1bktqJJjWzyngMVcidbDo
 LKd1MATvz40018cVTJUN9XI6MmLSuGtbuYWdPMVhdUwJD19hvZWm/Rz5dMOacbYk13aJmeBZfjo
 XZl2I2XWB/FlF3wjrSWfSKHvdKxadZAAC4k+XZ5/MPaCkmuLcUOScvsKqoGwiL4ge9McN5v3XKM
 Uq2EdMOlElFswNTdVwstdrTBM6q4SpW6/G7ZDUlnOMlGtKcwXqV9z7ACqifpGukdSqjSXAkPRwB
 Y1Z8oN2pnUzpmBsDrBFqw==
X-Received: by 2002:a05:600c:1914:b0:493:a56b:d915 with SMTP id
 5b1f17b1804b1-493a56bd94amr98823055e9.31.1782741691148; 
 Mon, 29 Jun 2026 07:01:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268ff9f40sm292848455e9.6.2026.06.29.07.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:01:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] hw/dma/i8257: Return zeroes for read_memory in verify mode
Date: Mon, 29 Jun 2026 15:01:28 +0100
Message-ID: <20260629140128.1900095-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
---
 hw/dma/i8257.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 7d7e543427..5771549889 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -408,6 +408,19 @@ static int i8257_dma_read_memory(IsaDma *obj, int nchan, void *buf, int pos,
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
2.43.0


