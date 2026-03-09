Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02F4EA854C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 01:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzPj5-0005ly-RM; Sun, 08 Mar 2026 21:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPiu-0005lE-DH
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:47:57 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPio-0001HN-Of
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:47:54 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 248845969EA;
 Mon, 09 Mar 2026 02:47:47 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ne-AHmMbVS4c; Mon,  9 Mar 2026 02:47:43 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 337765969E5; Mon, 09 Mar 2026 02:47:43 +0100 (CET)
Message-ID: <cover.1773020351.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v12 0/9] ati-vga: Implement HOST_DATA transfers to enable
 X.org text rendering
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 09 Mar 2026 02:47:43 +0100 (CET)
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

Changes from v11:
- Drop already merged patches in [PULL 00/49] Misc HW patches for 2026-03-08
Based-on: 20260308223433.25503-1-philmd@linaro.org
- Fix build without pixman

Chad Jablonski (9):
  ati-vga: Remove src and dst stride mutation in ati_2d_blt
  ati-vga: Use local variables for register values in ati_2d_blt
  ati-vga: Introduce ATI2DCtx struct for 2D blit context
  ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
  ati-vga: Split ati_2d_do_blt from ati_2d_blt
  ati-vga: Remove ATIVGAState param from ati_2d_do_blt
  ati-vga: Implement scissor rectangle clipping for 2D operations
  ati-vga: Implement HOST_DATA register writes
  ati-vga: Implement HOST_DATA flush to VRAM

 hw/display/ati.c      |  24 +++
 hw/display/ati_2d.c   | 438 ++++++++++++++++++++++++++++++------------
 hw/display/ati_dbg.c  |   9 +
 hw/display/ati_int.h  |  12 ++
 hw/display/ati_regs.h |  13 ++
 5 files changed, 378 insertions(+), 118 deletions(-)

-- 
2.41.3


