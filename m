Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5942FFEDA17
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 01:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2fol-0006Zh-Bl; Tue, 17 Mar 2026 21:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2foj-0006Yu-0I
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 21:35:25 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2fog-0001i1-Jg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 21:35:24 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 35961596ABD;
 Wed, 18 Mar 2026 02:35:19 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 79tVNxluwVec; Wed, 18 Mar 2026 02:35:16 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B27F8596A4B; Wed, 18 Mar 2026 02:35:16 +0100 (CET)
Message-ID: <cover.1773797056.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 0/6] ati-vga fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Wed, 18 Mar 2026 02:35:16 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

v4:
- compile fix in patch 5
- new patch 6 to work around fuloong2e issue:
https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg06308.html
v3:
- fix patch 1 to work with 8 and 16 bit modes too
- new patch 5 to fix display updates with 8 and 16 bit modes
v2:
- fix patch 4 to really avoid warnings

These are some fixes to ati-vga for 11.0.

Patch 1 fixes problem reported in
https://lists.nongnu.org/archive/html/qemu-ppc/2026-01/msg00105.html

Patch 2 fixes output from Solaris install iso
Rendering still not always correct as it uses some unimplemented
features but it's now readable. I did not test full install though.

Patch 3 fixes vram overrun errors seen with Solaris and MorphOS when
crtc offset is non-zero (this happens on MorphOS when additional
screen is opened)

Patch 4 tries to avoid Coverity warning matching what other places
already do

Patch 5 fixes dirty region tracking when guest display depth is not
the same as the host's

Patch 6 adds work around for fuloong2e to keep working with partial
machine model

BALATON Zoltan (6):
  ati-vga: Fix colors when frame buffer endianness does not match host
  ati-vga: Also switch mode on HW cursor enable bit change
  ati-vga: Do not add crtc offset to src and dst data address
  ati-vga: Avoid warnings about sign extension
  ati-vga: Fix display updates in non-32 bit modes
  ati-vga: Add work around for fuloong2e

 hw/display/ati.c     | 26 ++++++++++++++++--------
 hw/display/ati_2d.c  | 47 ++++++++++++++++++++++++++++++--------------
 hw/display/ati_int.h |  1 +
 hw/mips/fuloong2e.c  |  1 +
 4 files changed, 52 insertions(+), 23 deletions(-)

-- 
2.41.3


