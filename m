Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED637D0C5F8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 09:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4GlG-0000b0-9X; Fri, 25 Oct 2024 05:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1t4GlE-0000ak-9q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:37:36 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1t4Gl9-0002yK-6F
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:37:36 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 4AAE7A0128; Fri, 25 Oct 2024 11:30:15 +0200 (CEST)
Date: Fri, 25 Oct 2024 11:30:15 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Lei Huang <Lei.Huang@amd.com>
cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, 
 pierre-eric.pelloux-prayer@amd.com, ken.xue@amd.com
Subject: Re: [PATCH] ui/sdl: Mouse event optimization
In-Reply-To: <20241025065205.1222-1-Lei.Huang@amd.com>
Message-ID: <alpine.LMD.2.03.2410251127250.22275@eik.bme.hu>
References: <20241025065205.1222-1-Lei.Huang@amd.com>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, 25 Oct 2024, Lei Huang wrote:
> Use a convergence factor to make the VM's input
> global coordinates more closely approach the global
> coordinates of DOM0.

Dom0 is some Xen terminology. Do you mean "host" which is more often used 
in QEMU?

> Change-Id: I2c3f12f1fe7dfb9306d1fc40c4fd4d299937f4c6
> Signed-off-by: Lei Huang <Lei.Huang@amd.com>
> ---
> ui/sdl2.c | 32 ++++++++++++++++++++++++++++++--
> 1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index bd4f5a9da14..8f504dd8727 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -303,6 +303,34 @@ static void sdl_mouse_mode_change(Notifier *notify, void *data)
>     }
> }
>
> +/*
> + *guest_x and guest_y represent the global coordinates on the VM side,
> + *while x and y represent the global coordinates on the dom0 side.
> + *The goal of this entire process is to align the global coordinates of
> + *the VM with those of dom0 using dx and dy. The current approach aims
> + *for precise calibration in once attempt; however, because guest_x

"in one attempt" also add a space after the * at the beginning of lines.

> + *and guest_y are non-zero values, they are not accurate values when
> + *they are counted out to become negative.Therefore, achieving perfect
> + *alignment in one attempt is impossible.Since the same calibration method
> + *is used each time, repeated attempts cannot achieve alignment either.
> + *By introducing a convergence factor, guest_x and guest_y can be made to
> + *approach dom0's x and y indefinitely.
> + *
> + *                   QEMU                       (dx,dy)  VM
> + *calculates dx and dy using guest_x and guest_y ---->  input driver
> + *           ^                                            |
> + *           |                                            |
> + *           |                                            V
> + *           |     update
> + *           | guest_x,guest_y              input dispatcher ---> WindowManager
> + *           |                                            |                 |
> + *           |                                            |                 |
> + *           |                 libdrm                     V                 |
> + *       virtio-gpu  <------ drmModeMoveCursor <------ compositor <-------  |
> + *                           (guest_x,guest_y)   calculates guest_x and
> + *                                               guest_y dy using dx and dy
> + */

What about other display devices than virtio-gpu? Does this work with 
those or do they need some update? If this is independent of graphics 
device maybe add a note that virtio-gpu is an example and could be any 
graphics device.

Regards,
BALATON Zoltan

> +#define CONVERGENCE_FACTOR 3
> static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
>                                  int x, int y, int state)
> {
> @@ -331,8 +359,8 @@ static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
>             y -= guest_y;
>             guest_x += x;
>             guest_y += y;
> -            dx = x;
> -            dy = y;
> +            dx = x / CONVERGENCE_FACTOR;
> +            dy = y / CONVERGENCE_FACTOR;
>         }
>         qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_X, dx);
>         qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_Y, dy);
> -- 
> 2.45.2
>
>
>

