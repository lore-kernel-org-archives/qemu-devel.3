Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104B6C4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 15:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlTMb-0001jS-Aq; Sun, 19 Jul 2026 11:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlTMY-0001iX-2t
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 11:23:30 -0400
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlTMW-0006i5-LP
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 11:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1784474601; x=1784733801;
 bh=UBwPutl+85R5/ITqbrIxd0Q0rL5pfkY//QmCMUqWtZI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=XWvekGekywrw+MBvr6DXx0BKmK/AkIOp3Rvg6pttuh6YMZPJcW+1eIeF3SKDaDHk7
 jyfbB+ElIdc0UaueQcfkKoa3YP3FYnz+pScJYTh5WgQiiYsrwd35eh1KHoZ60zdT3Z
 D9eRsQTLnNjKsce+RI+vwH6/MceEE3mdeQg0yPDFDuDIgpcEWF4c0jCTYEK/l39Rqm
 KmKRRteN5L4n4UXNw753cxNW1ffggCMpfSi/MCHbu5KaBpiSB0xZOcfeyFLZE3Xycg
 Pi/89GIUD0ETma0BrRjgv+RsHOKRZruDVWGe9wHPx8Z96wLfzAx6onFS0zWtV2eHHY
 vyUqe8wBKdo/Q==
X-Pm-Submission-Id: 4h36qD0N9Yz1DDrb
From: Matthew Jackson <matthew@pq.io>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH 4/4] hw/display/vmware_vga: advertise 8BIT_EMULATION,
 ALPHA_BLEND and ALPHA_CURSOR
Date: Sun, 19 Jul 2026 08:23:18 -0700
Message-ID: <20260719152318.69481-5-matthew@pq.io>
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

Modern VMware SVGA II guest drivers expect the 8-bit palette
emulation capability (`SVGA_CAP_8BIT_EMULATION`, bit 8) and
the two alpha-blending cursor bits (`SVGA_CAP_ALPHA_BLEND`
bit 13, `SVGA_CAP_ALPHA_CURSOR` bit 9) to be advertised by
any device that presents a modern feature set. The upstream
device already implements the machinery behind all three:

  * 8-bit palette is handled by the legacy vga core that
    vmware_vga extends, so advertising 8BIT_EMULATION is a
    pure capability-bit change.
  * ALPHA_CURSOR is satisfied by `SVGA_CMD_DEFINE_ALPHA_CURSOR`
    which the FIFO command dispatcher already handles.
  * ALPHA_BLEND is a generic "host supports alpha blending on
    ARGB surfaces" bit; macOS's driver uses it to gate the
    ARGB cursor upload path.

Without these bits, macOS's vmware_vga driver falls back to
the monochrome cursor path and the guest cursor flickers or
renders without anti-aliasing.

Signed-off-by: Matthew Jackson <matthew@pq.io>
---
 hw/display/vmware_vga.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -896,7 +896,18 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
         break;

     case SVGA_REG_CAPABILITIES:
-        caps = SVGA_CAP_PITCHLOCK | SVGA_CAP_EXTENDED_FIFO;
+        /*
+         * Advertise the capability bits that modern VMware SVGA II guest
+         * drivers (Linux vmwgfx, macOS 10.13+, Windows 10+) expect at a
+         * minimum. PITCHLOCK lets the guest pin the scanout pitch across
+         * mode changes; EXTENDED_FIFO exposes the pitchlock/fence/3d-hw
+         * FIFO registers above SVGA_FIFO_STOP; 8BIT_EMULATION advertises
+         * legacy palette support; ALPHA_BLEND / ALPHA_CURSOR are
+         * required for the 32-bit ARGB hardware cursor path.
+         */
+        caps = SVGA_CAP_PITCHLOCK | SVGA_CAP_EXTENDED_FIFO |
+               SVGA_CAP_8BIT_EMULATION | SVGA_CAP_ALPHA_BLEND |
+               SVGA_CAP_ALPHA_CURSOR;
 #ifdef HW_RECT_ACCEL
         caps |= SVGA_CAP_RECT_COPY;
 #endif
--
2.47.0


