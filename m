Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D368CC6B1D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiAT-0001qX-6q; Tue, 13 Oct 2026 15:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGiAR-0001pd-HM
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:28:07 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGiAP-00087K-IW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=bGCC+1IM6EtPlwTo/Twu06y3VzSJXBilqfWZgD+6UIg=; b=iNKTeU8UxpFAVgzDiWnCzCLDpn
 8Q1AUzdVCLVjQn9Uyxc37bmK549q/4y+K2oco1C99jJCUH7/xGhEmjhY0AwxiJBZmE3b/jXHabsjf
 jOJiSMj/IWz+O+sjraCZE1rTF22onPnKvwK7L2MFLzXGwhNFtVhiwC8t3cyyL5UQ4Y/2dWk2Wl267
 EjCgOT3b66RRf7GJpAtPcqXL1+FC7GkljF8+8IfcZqjT/yiz3OSvUfiT6Ny/994migu9TigFzGcoo
 E0tUYl8Xg/m9JT/LNS5nBz3DtBNGBFQVoqJNI+9xSN4n6DQ+BUWLHH6VGkhDOukiR4d8LTweRYuCs
 SBbrvExpNdY91lh+zRXOBOWMkb52Oqtu+oMT4CVrVtK0nuLP30ADRMCe7sdEkxke3OfM9YJ9Vr/p9
 pqIg3a96t/exppeEP2pdmNIevyt0SaaArp7IR0FMCTmNyIQ2rWvBA/ho8EUAAgpfFFCNLTRRE0+aP
 CS4YLetMUxC7hnf0Z/z1Bsksdx3gUR5sUnHqyhOS9RCCtodzcU6tJgWYKACzGBsHyWI4185PFBJe8
 qHmW4ePHnEY0BUOIeoLXnA99P25LA0aQSkgg1bMnFLYH34YDgL4Rh4r4sPcRk18KuZ0bOPQmlHUmq
 D7A4vKkIBC9/SllASb00pBAP4TdlWoEFYlW2NtA64=;
Received: from [2a02:8012:2f01:0:b2a5:667b:71e2:6751]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1xGi9k-001aAM-Gr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:27:24 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Tue, 13 Oct 2026 20:27:36 +0100
Message-ID: <20261013192751.196204-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013192751.196204-1-mark.cave-ayland@ilande.co.uk>
References: <20261013192751.196204-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:b2a5:667b:71e2:6751
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 4/5] cuda: Make shift register delay configurable
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

From: "Kirill A. Korinsky" <kirill@korins.ky>

The CUDA model assumes a 20 microsecond delay before each shift
register interrupt. OpenBSD times out during device discovery with that
timing, so retain the existing default but allow an override.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20261001230058.11465-5-kirill@korins.ky>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/cuda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index ccb3e1d74b0..f06583377a2 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -535,7 +535,6 @@ static void cuda_realize(DeviceState *dev, Error **errp)
     s->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
 
     s->sr_delay_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_set_sr_int, s);
-    s->sr_delay_ns = 20 * SCALE_US;
 
     adb_register_autopoll_callback(adb_bus, cuda_adb_poll, s);
 }
@@ -557,6 +556,8 @@ static void cuda_init(Object *obj)
 
 static const Property cuda_properties[] = {
     DEFINE_PROP_UINT64("timebase-frequency", CUDAState, tb_frequency, 0),
+    DEFINE_PROP_UINT64("x-sr-delay-ns", CUDAState, sr_delay_ns,
+                       20 * SCALE_US),
 };
 
 static void cuda_class_init(ObjectClass *oc, const void *data)
-- 
2.47.3


