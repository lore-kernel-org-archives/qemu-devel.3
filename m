Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAB3D132A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7uHa-0002dd-Ox; Mon, 04 Nov 2024 05:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t7uHR-0002cl-I7
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:25:54 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t7uGu-0008Kg-Bs
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:25:26 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 124B34E6010;
 Mon, 04 Nov 2024 11:25:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 9Ui66ACffY3Z; Mon,  4 Nov 2024 11:25:14 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 18F144E6004; Mon, 04 Nov 2024 11:25:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1713B746F60;
 Mon, 04 Nov 2024 11:25:14 +0100 (CET)
Date: Mon, 4 Nov 2024 11:25:14 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Lei Huang <Lei.Huang@amd.com>
cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, 
 pierre-eric.pelloux-prayer@amd.com, ken.xue@amd.com, hsp.cat7@gmail.com
Subject: Re: [PATCH v3] ui/sdl: Mouse event optimization
In-Reply-To: <20241104084255.1721-1-Lei.Huang@amd.com>
Message-ID: <ab5ea4f2-96f1-09a3-a629-6bd21bf1b903@eik.bme.hu>
References: <20241104084255.1721-1-Lei.Huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Mon, 4 Nov 2024, Lei Huang wrote:
> Use a convergence factor to make the VM's input
> global coordinates more closely approach the global
> coordinates of host.
>
> Change-Id: I2c3f12f1fe7dfb9306d1fc40c4fd4d299937f4c6
> Signed-off-by: Lei Huang <Lei.Huang@amd.com>

The explanation in the comment is still not clear to me so I don't fully 
understand the problem and can't tell if this is the best fix but it's now 
grammatically OK and the patch looks OK too so

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> ---
> ui/sdl2.c | 45 +++++++++++++++++++++++++++++++++++++--------
> 1 file changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index bd4f5a9da14..7c815d276a2 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -303,6 +303,35 @@ static void sdl_mouse_mode_change(Notifier *notify, void *data)
>     }
> }
>
> +/*
> + * guest_x and guest_y represent the global coordinates on the VM side,
> + * while x and y represent the global coordinates on the host side.
> + * The goal of this entire process is to align the global coordinates
> + * of the VM with those of host using dx and dy. The current approach
> + * aims for precise calibration in one attempt; however, because guest_x
> + * and guest_y are non-zero values, they are not accurate values when
> + * they are counted out to become negative. Therefore, achieving perfect
> + * alignment in one attempt is impossible. Since the same calibration
> + * method is used each time, repeated attempts cannot achieve alignment
> + * either. By introducing a convergence factor, guest_x and guest_y can
> + * be made to approach host x and y indefinitely.
> + *
> + *           QEMU                             VM
> + *    calculates (dx, dy)                  (dx, dy)
> + * using (guest_x, guest_y) ------------>input driver
> + *           ^                                 |
> + *           |                                 |
> + *           |       update                    V
> + *           | (guest_x, guest_y)            input
> + *           |                            dispatcher ---> WindowManager
> + *           |                                 |             |
> + *           |                                 |             |
> + *           |             libdrm              V             |
> + * display device <-- drmModeMoveCursor <-- compositor <---- |
> + * (e.g. virtio-gpu)  (guest_x, guest_y)   calculates (guest_x, guest_y)
> + *                                         using (dx, dy)
> + */
> +#define CONVERGENCE_FACTOR 3
> static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
>                                  int x, int y, int state)
> {
> @@ -327,15 +356,15 @@ static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
>                              y, 0, surface_height(scon->surface));
>     } else {
>         if (guest_cursor) {
> -            x -= guest_x;
> -            y -= guest_y;
> -            guest_x += x;
> -            guest_y += y;
> -            dx = x;
> -            dy = y;
> +            dx = x - guest_x;
> +            dy = y - guest_y;
> +            guest_x = x;
> +            guest_y = y;
>         }
> -        qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_X, dx);
> -        qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_Y, dy);
> +        qemu_input_queue_rel(scon->dcl.con,
> +                             INPUT_AXIS_X, dx / CONVERGENCE_FACTOR);
> +        qemu_input_queue_rel(scon->dcl.con,
> +                             INPUT_AXIS_Y, dy / CONVERGENCE_FACTOR);
>     }
>     qemu_input_event_sync();
> }
>

