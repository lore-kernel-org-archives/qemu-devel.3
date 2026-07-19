Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23C3C4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 15:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlTMa-0001jJ-Qk; Sun, 19 Jul 2026 11:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlTMW-0001iU-Rq
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 11:23:28 -0400
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlTMS-0006hp-AX
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 11:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1784474600; x=1784733800;
 bh=Ppeg3vIlOjHAeJXWB92HHibIENdjI3KrUH4oO1W8Mgc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=lfSRBLo6A2Q/su92yOqFwZ6bSZlv4amAp6ECHhfFb58AUT8pTLYs0AnAg3vVmxp+0
 Qf/imuRj4NI64rTBIEQ2xd7d/+Zmmi7UdRagfh5ZoUNzgrli+4JAqsrl+6rz67nyT/
 2i+RBhECdPhwv7HwU6U7gZW3Qy8EySCv0dRto6YB4uEqFDa2y9wRDmVEFIwlXtytgG
 N9WjnrZWMYGYC8PMHukS1QGJiw69svZl+iRyEJp9QwnW0rZjbpR+/NI2pd1x/WOSHg
 e/V3vrFwyroEjH5Z2+vEDsrUWUCtqfjMlTAWGtpPjert4KsXdvNo9tZ7VMXOXe5vt0
 I1rvT9nQR/uiA==
X-Pm-Submission-Id: 4h36qD31F9z2ScWZ
From: Matthew Jackson <matthew@pq.io>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH 2/4] hw/display/vmware_vga: advertise PITCHLOCK capability
Date: Sun, 19 Jul 2026 08:23:16 -0700
Message-ID: <20260719152318.69481-3-matthew@pq.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260719152318.69481-1-matthew@pq.io>
References: <20260719152318.69481-1-matthew@pq.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.9.206.169; envelope-from=matthew@pq.io;
 helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

`SVGA_CAP_PITCHLOCK` (bit 17) signals that the device exposes
the pitchlock FIFO register (`SVGA_FIFO_PITCHLOCK`) and that
the guest may request a fixed scanout pitch that is honoured
across mode changes. The upstream device already exposes the
FIFO slot at the correct offset (via the enum block around
`SVGA_FIFO_PITCHLOCK`); only the capability bit is missing.

Without this bit, the Linux vmwgfx driver and macOS
vmware_vga driver both refuse to use the pitchlock path and
fall back to a default software pitch that does not align
with the guest framebuffer layout; the result is a visible
scanline offset on non-power-of-two widths.

Signed-off-by: Matthew Jackson <matthew@pq.io>
---
 hw/display/vmware_vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -896,7 +896,7 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
         break;

     case SVGA_REG_CAPABILITIES:
-        caps = SVGA_CAP_NONE;
+        caps = SVGA_CAP_PITCHLOCK;
 #ifdef HW_RECT_ACCEL
         caps |= SVGA_CAP_RECT_COPY;
 #endif
--
2.47.0


