Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC151C4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 15:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlTMb-0001jm-Uk; Sun, 19 Jul 2026 11:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlTMY-0001ij-Ni
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 11:23:30 -0400
Received: from mail-06.mail-europe.com ([85.9.210.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlTMW-0006iJ-Ln
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 11:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1784474602; x=1784733802;
 bh=3VWGazVo+b6xQQ5maEyg1RJJzo/VUUBxgMTt1r0o56s=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=DXpOUMBHUVjwUXo49FBLvJDwV0FOLQkWWORJMWlN+lS1iJtk2BfnJAY7MN75AtBIY
 igsQhHPN1fxUcYQhvQa4nMpP2ffWJ4ASDOqAsqNTti1/ZMYUFD9Q6anykryQqZhSe8
 zZRA0tdOV1DSR7MUYsgIskEgMi9Vbn3u2VdJ0UfoJ7/+0/U5+x2UuBlF3yqXznUgyU
 2kCuDPzL7Mvy7Mw1m6RlrIukI0A3azKuNwfcjVJWaPa+5+YIqGLr5L+TnTo9F5NvxF
 dRTumuhkr/7jYe1wV1Rvq8ghAyENoiakXk5H1k3M2lyhhmWU0luzaxt3csOtPcuKur
 y9NdXiCKQfhqA==
X-Pm-Submission-Id: 4h36qF1VvWz2Sd3D
From: Matthew Jackson <matthew@pq.io>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH 3/4] hw/display/vmware_vga: advertise EXTENDED_FIFO capability
Date: Sun, 19 Jul 2026 08:23:17 -0700
Message-ID: <20260719152318.69481-4-matthew@pq.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260719152318.69481-1-matthew@pq.io>
References: <20260719152318.69481-1-matthew@pq.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.9.210.45; envelope-from=matthew@pq.io;
 helo=mail-06.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

`SVGA_CAP_EXTENDED_FIFO` (bit 15) signals that the FIFO
register block extends past `SVGA_FIFO_STOP` to include the
capability/flags/fence/3d-version/pitchlock quintuplet. The
upstream device already defines those offsets in the FIFO
enum (`SVGA_FIFO_CAPABILITIES` onwards) but gates their
advertisement behind this capability bit.

Without EXTENDED_FIFO the Linux vmwgfx driver refuses to
probe the fence and 3D-hwversion slots; with it, the driver
treats the device as a modern VMware SVGA II, matching the
behaviour we already implement at the register level.

Tested against the Linux vmwgfx probe path and macOS 15
vmware_vga driver: both now find the extended slots and no
longer log "device lacks extended FIFO" warnings.

Signed-off-by: Matthew Jackson <matthew@pq.io>
---
 hw/display/vmware_vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -896,7 +896,7 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
         break;

     case SVGA_REG_CAPABILITIES:
-        caps = SVGA_CAP_PITCHLOCK;
+        caps = SVGA_CAP_PITCHLOCK | SVGA_CAP_EXTENDED_FIFO;
 #ifdef HW_RECT_ACCEL
         caps |= SVGA_CAP_RECT_COPY;
 #endif
--
2.47.0


