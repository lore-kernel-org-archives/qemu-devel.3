Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5EFF3ED66
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 21:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBgGy-00088P-Q4; Sat, 11 Apr 2026 17:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wBgGr-00088A-4r
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 17:53:41 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wBgGo-0006Ax-HV
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 17:53:40 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3BB525969F2;
 Sat, 11 Apr 2026 23:53:32 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id BD_q4EQKvFkN; Sat, 11 Apr 2026 23:53:29 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D992C5968DE; Sat, 11 Apr 2026 23:53:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D7C6A5968DD;
 Sat, 11 Apr 2026 23:53:29 +0200 (CEST)
Date: Sat, 11 Apr 2026 23:53:29 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: sdl2 mouse pointer issue
Message-ID: <91023e77-8838-c89f-481f-86174ee830e1@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

There's a long standing bug with -display sdl that host side mouse pointer 
does not follow guest or jumps around or otherwise behaves erratically. 
There are several tickets about this as well but gitlab does not make it 
easy to find them so these are just a few I think might be related, there 
might be more:

https://gitlab.com/qemu-project/qemu/-/work_items/1550
https://gitlab.com/qemu-project/qemu/-/work_items/2960
https://gitlab.com/qemu-project/qemu/-/work_items/2948

I can also reproduce it with

qemu-system-ppc -M pegasos2 -display sdl -device ati-vga -kernel boot.img -cdrom morphos.iso

(boot.img is from the root dir of the morphos iso). Mouse pointer mostly 
works as long as don't move it too fast or you don't switch to full screen 
with Ctrl+Alt+F then it does not work even if you switch back to window. 
This can be avoided using disabling host side cursor with -device 
ati-vga,guest_hwcursor=on.

After not finding any cause in ati-vga I've added some diagnostics to sdl 
backend:

diff --git a/ui/sdl2.c b/ui/sdl2.c
index aaaede56e0..4f625365ab 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -333,6 +333,7 @@ static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
         qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_Y,
                              y, 0, surface_height(scon->surface));
     } else {
+fprintf(stderr,"%s(%d,%d,%d,%d,%d), %d %d,%d,",__func__,dx,dy,x,y,state,guest_cursor,guest_x,guest_y);
         if (guest_cursor) {
             x -= guest_x;
             y -= guest_y;
@@ -341,6 +342,7 @@ static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
             dx = x;
             dy = y;
         }
+fprintf(stderr," -> %d,%d %d,%d\n",dx,dy,guest_x,guest_y);
         qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_X, dx);
         qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_Y, dy);
     }
@@ -525,6 +527,7 @@ static void handle_mousemotion(SDL_Event *ev)
     dx = (int64_t)ev->motion.xrel * surf_w / scr_w;
     dy = (int64_t)ev->motion.yrel * surf_h / scr_h;
     if (gui_grab || qemu_input_is_absolute(scon->dcl.con) || absolute_enabled) {
+fprintf(stderr, "%s(%d,%d,%d,%d, %d,%d,%d,%d)\n",__func__,surf_w,surf_h,scr_w,scr_h,x,y,dx,dy);
         sdl_send_mouse_event(scon, dx, dy, x, y, ev->motion.state);
     }
 }
@@ -750,6 +753,7 @@ static void sdl_mouse_warp(DisplayChangeListener *dcl,
     } else if (gui_grab) {
         sdl_hide_cursor(scon);
     }
+fprintf(stderr,"%s(%d,%d,%d)\n",__func__,x,y,on);
     guest_cursor = on;
     guest_x = x, guest_y = y;
 }

and got this output just booting the iso without clicking in the window or 
moving the mouse. First this is the guest moving the cursor by writing the 
HW cursor register for position to place the pointer in the middle:

sdl_mouse_warp(1024,576,1)
sdl_mouse_warp(1024,576,1)
sdl_mouse_warp(1024,576,1)
sdl_mouse_warp(1024,576,1)

then just switching to full screen with Crtl+Alt+F without moving the 
mouse in the guest I get these:

handle_mousemotion(2048,1152,2560,1440, 655,368,0,0)
sdl_send_mouse_event(0,0,655,368,0), 1 1024,576, -> -369,-208 655,368
sdl_mouse_warp(286,160,1)
handle_mousemotion(2048,1152,2560,1440, 182,102,0,0)
sdl_send_mouse_event(0,0,182,102,0), 1 286,160, -> -104,-58 182,102
sdl_mouse_warp(78,44,1)
handle_mousemotion(2048,1152,2560,1440, 49,28,0,0)
sdl_send_mouse_event(0,0,49,28,0), 1 78,44, -> -29,-16 49,28
sdl_mouse_warp(20,12,1)
handle_mousemotion(2048,1152,2560,1440, 12,7,0,0)
sdl_send_mouse_event(0,0,12,7,0), 1 20,12, -> -8,-5 12,7
sdl_mouse_warp(4,2,1)
handle_mousemotion(2048,1152,2560,1440, 2,0,0,0)
sdl_send_mouse_event(0,0,2,0,0), 1 4,2, -> -2,-2 2,0
sdl_mouse_warp(2,0,1)
handle_mousemotion(2048,1152,2560,1440, 0,0,0,0)
sdl_send_mouse_event(0,0,0,0,0), 1 2,0, -> -2,0 0,0
sdl_mouse_warp(0,0,1)
handle_mousemotion(2048,1152,2560,1440, 0,0,0,0)
sdl_send_mouse_event(0,0,0,0,0), 1 0,0, -> 0,0 0,0
sdl_mouse_warp(0,0,1)
handle_mousemotion(2048,1152,2560,1440, 0,0,0,0)
sdl_send_mouse_event(0,0,0,0,0), 1 0,0, -> 0,0 0,0
sdl_mouse_warp(0,0,1)

The pointer is moved to the top left without any input from the user and 
cannot leave it any more (less severe cases could cause laggy mouse 
pointer or other issues). Trying to move the mouse afterwards can only 
move vertically.

On the ati-vga side writing CUR_HORZ_VERT_POSN register that the guest 
does to move the HW cursor calls

dpy_mouse_set(s->vga.con, s->regs.cur_hv_pos >> 16,
              s->regs.cur_hv_pos & 0xffff, true);

which ends up in sdl_mouse_warp that sets guest_x,guest_y but then other 
parts of sdl.c also try to also set it differently. That's what I could 
find out but I don't understand how it should work and why it doesn't. It 
looks like there is some confusion about what guest_x and guest_y should 
be. Could somebody give some clue how this could be fixed? Or even better 
fix it as I'm quite lost on this.

Thank you,
BALATON Zoltan

