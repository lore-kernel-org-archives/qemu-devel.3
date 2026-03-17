Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296DBFD8748
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Spc-0004F0-4c; Tue, 17 Mar 2026 07:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2SpW-0004EC-G4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 07:43:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2SpT-0000aG-Gz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 07:43:21 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DE5DB596A48;
 Tue, 17 Mar 2026 12:43:15 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id MGAUPylw9zxW; Tue, 17 Mar 2026 12:43:13 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D08525969F3; Tue, 17 Mar 2026 12:43:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CCDFD5968DE;
 Tue, 17 Mar 2026 12:43:13 +0100 (CET)
Date: Tue, 17 Mar 2026 12:43:13 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 53/60] ui/console: return completion status from gfx_update
 callback
In-Reply-To: <20260317-qemu-vnc-v1-53-48eb1dcf7b76@redhat.com>
Message-ID: <e18e7a83-0c7c-5d83-a000-146c23d6c350@eik.bme.hu>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-53-48eb1dcf7b76@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1468147829-1773747793=:98342"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1468147829-1773747793=:98342
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 17 Mar 2026, Marc-André Lureau wrote:
> Replace the two-field design (gfx_update void callback + gfx_update_async
> flag) with a single bool return value from gfx_update. Returning true
> means the update completed synchronously and graphic_hw_update_done()
> should be called by the console layer. Returning false means the update
> is deferred and the device will call graphic_hw_update_done() itself
> later (as done by QXL/SPICE and Apple GFX).
>
> This simplifies the interface and makes the async contract explicit at
> each call site rather than relying on a separate struct field.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> hw/display/qxl.h              |  2 +-
> include/ui/console.h          |  3 +--
> hw/arm/musicpal.c             |  3 ++-
> hw/display/artist.c           |  4 +++-
> hw/display/bcm2835_fb.c       |  7 ++++---
> hw/display/bochs-display.c    |  6 ++++--
> hw/display/cg3.c              |  5 +++--
> hw/display/dm163.c            |  4 +++-
> hw/display/exynos4210_fimd.c  |  6 ++++--
> hw/display/g364fb.c           |  9 ++++++---
> hw/display/jazz_led.c         |  6 ++++--
> hw/display/macfb.c            |  6 ++++--
> hw/display/next-fb.c          |  4 +++-
> hw/display/omap_lcdc.c        | 14 ++++++++------
> hw/display/pl110.c            |  5 +++--
> hw/display/qxl-render.c       |  6 +++---
> hw/display/qxl.c              |  7 +++----
> hw/display/ramfb-standalone.c |  4 +++-
> hw/display/sm501.c            |  8 +++++---
> hw/display/ssd0303.c          | 10 ++++++----
> hw/display/ssd0323.c          | 11 ++++++-----
> hw/display/tcx.c              |  6 ++++--
> hw/display/vga.c              |  4 +++-
> hw/display/virtio-gpu-base.c  |  3 ++-
> hw/display/virtio-vga.c       |  6 +++---
> hw/display/vmware_vga.c       |  7 ++++---
> hw/display/xenfb.c            |  6 ++++--
> hw/display/xlnx_dp.c          | 10 ++++++----
> hw/vfio/display.c             | 17 ++++++++++-------
> ui/console.c                  |  7 +------
> hw/display/apple-gfx.m        | 10 +++++-----
> 31 files changed, 121 insertions(+), 85 deletions(-)
>
> diff --git a/hw/display/qxl.h b/hw/display/qxl.h
> index e0a85a5ca49..ad8a9128785 100644
> --- a/hw/display/qxl.h
> +++ b/hw/display/qxl.h
> @@ -187,7 +187,7 @@ int qxl_log_command(PCIQXLDevice *qxl, const char *ring, QXLCommandExt *ext);
>
> /* qxl-render.c */
> void qxl_render_resize(PCIQXLDevice *qxl);
> -void qxl_render_update(PCIQXLDevice *qxl);
> +bool qxl_render_update(PCIQXLDevice *qxl);
> int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt *ext);
> void qxl_render_update_area_done(PCIQXLDevice *qxl, QXLCookie *cookie);
> void qxl_render_update_area_bh(void *opaque);
> diff --git a/include/ui/console.h b/include/ui/console.h
> index c695b433fe3..2ac9c59e151 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -363,8 +363,7 @@ enum {
> typedef struct GraphicHwOps {
>     int (*get_flags)(void *opaque); /* optional, default 0 */
>     void (*invalidate)(void *opaque);
> -    void (*gfx_update)(void *opaque);
> -    bool gfx_update_async; /* if true, calls graphic_hw_update_done() */
> +    bool (*gfx_update)(void *opaque); /* false if deferred update_done */

This short comment (and the commit message) seems to be the only 
documentation. Is it worth documenting better somewhere or at least make 
the comment more descriptive such as "true: graphic_hw_update_done() is 
needed, false: deferred update_done" or something more easily understood 
by somebody not familiar with console internal working.

Also when returning from update functions from an error at the beginning 
without any update is graphic_hw_update_done needed when nothing changed?

Regards,
BALATON Zoltan
--3866299591-1468147829-1773747793=:98342--

