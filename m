Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4735CD5CCB0
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 13:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t68uY-0006z2-3A; Wed, 30 Oct 2024 09:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t68uV-0006x4-L8
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 09:38:55 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t68uQ-0004gx-Es
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 09:38:53 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 766EE4E600E;
 Wed, 30 Oct 2024 14:38:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id NYy-M8Pw9tsH; Wed, 30 Oct 2024 14:38:42 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 78B624E600F; Wed, 30 Oct 2024 14:38:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 76D8A746F60;
 Wed, 30 Oct 2024 14:38:42 +0100 (CET)
Date: Wed, 30 Oct 2024 14:38:42 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Lei Huang <Lei.Huang@amd.com>
cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, 
 pierre-eric.pelloux-prayer@amd.com, ken.xue@amd.com, 
 Howard Spoelstra <hsp.cat7@gmail.com>
Subject: Re: [PATCH v2] ui/sdl: Mouse event optimization
In-Reply-To: <20241030034353.1588-1-Lei.Huang@amd.com>
Message-ID: <73cd533a-8818-4212-f7ea-0f89bd2b78cd@eik.bme.hu>
References: <20241030032014.1564-1-Lei.Huang@amd.com>
 <20241030034353.1588-1-Lei.Huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 30 Oct 2024, Lei Huang wrote:
> Use a convergence factor to make the VM's input
> global coordinates more closely approach the global
> coordinates of host.
>
> Change-Id: I2c3f12f1fe7dfb9306d1fc40c4fd4d299937f4c6
> Signed-off-by: Lei Huang <Lei.Huang@amd.com>
> ---
> ui/sdl2.c | 32 ++++++++++++++++++++++++++++++--
> 1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index bd4f5a9da14..ea3fd74dd63 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -303,6 +303,34 @@ static void sdl_mouse_mode_change(Notifier *notify, void *data)
>     }
> }
>
> +/*
> + * guest_x and guest_y represent the global coordinates on the VM side,
> + * while x and y represent the global coordinates on the host side.
> + * The goal of this entire process is to align the global coordinates of
> + * the VM with those of host using dx and dy. The current approach aims
> + * for precise calibration in once attempt; however, because guest_x

There's still another one here. You can say "in one attempt" or "at once" 
but combining the two is not correct.

> + * and guest_y are non-zero values, they are not accurate values when
> + * they are counted out to become negative. Therefore, achieving perfect
> + * alignment in one attempt is impossible. Since the same calibration method
> + * is used each time, repeated attempts cannot achieve alignment either.
> + * By introducing a convergence factor, guest_x and guest_y can be made to
> + * approach host x and y indefinitely.
> + *
> + *                   QEMU                       (dx,dy)  VM
> + * calculates dx and dy using guest_x and guest_y ---->  input driver
> + *            ^                                            |
> + *            |                                            |
> + *            |                                            V
> + *            |     update
> + *            | guest_x,guest_y              input dispatcher ---> WindowManager
> + *            |                                            |                 |
> + *            |                                            |                 |
> + *            |                 libdrm                     V                 |
> + *    display device  <------ drmModeMoveCursor <------ compositor <-------  |
> + *                            (guest_x,guest_y)   calculates guest_x and
> + *                                                guest_y dy using dx and dy

Maybe adding (e.g. virtio-gpu) below display device would make it clearer. 
Also under compositor there's "guest_y dy" where the dy seems to be left 
there by mistake from some editing or I don't get this sentence. (Did 
checkpatch.pl complain about too long lines? Maybe you could shorten the 
arrows a bit and wrap the text under QEMU in two lines to try to fit in 80 
chars.)

Sorry that I can only comment on the comments and not the actual change 
but I've cc'd Howard who I think saw this issue before so may be able to 
give it a test.

> + */
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

Looking at this calculation I don't quite get what's intended here and I 
think this could be simplified. Originally in 47c03744b37 it seems the 
qemu_input_queue_rel() was called with the modified value of x and y but 
then afbc0dd6498 have introduced dx, dy. After that changing x and y seems 
unnecessary as they are locals never used after this calculation. If I try 
to expand these equations I get:

x = x - guest_x;
guest_x = guest_x + x - guest_x;

So isn't this equivalent to just:

dx = x - guest_x;
guest_x = x;

which seems to make more sense but I don't know if it's correct.

Then this patch takes the third of dx to avoid it overshooting the desired 
value. The question is what causes this overshoot and can we calculate the 
actual value of it to compensate for it in one calculation? Isn't it the 
other line that sets guest_x to x that needs some correction?

Regards,
BALATON Zoltan

>         }
>         qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_X, dx);
>         qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_Y, dy);
>

