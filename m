Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE04C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpl3R-0005X2-Ll; Fri, 31 Jul 2026 07:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wpl3Q-0005Wk-H8; Fri, 31 Jul 2026 07:05:28 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wpl3O-0007Zf-Kf; Fri, 31 Jul 2026 07:05:28 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 50AF3583223;
 Fri, 31 Jul 2026 13:05:21 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id L98_J9gTYeOG; Fri, 31 Jul 2026 13:05:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4C46B583736; Fri, 31 Jul 2026 13:05:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4A98F583709;
 Fri, 31 Jul 2026 13:05:19 +0200 (CEST)
Date: Fri, 31 Jul 2026 13:05:19 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Oliver Clarke <oliverhenryc@gmail.com>
cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 marcandre.lureau@redhat.com
Subject: Re: [PATCH] sdl2: fix HighDPI display scaling
In-Reply-To: <20260730230449.963-1-oliverhenryc@gmail.com>
Message-ID: <92c3b7f6-4afa-7a61-1843-fbfe855cb9c4@eik.bme.hu>
References: <20260730230449.963-1-oliverhenryc@gmail.com>
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

On Thu, 30 Jul 2026, Oliver Clarke wrote:
> This makes sdl2 windows work well with dpi scaling. It fixes the issue 
> of the display surface being stretched to fit the dpi corrected window 
> (which created a blurry result).
>
> Note, this does not do any scaling, it just tells the os to not scale 
> the window. Before, when the console requested size 640x480, the logical 
> size of the window was 640x480, and the physical size was scaled by the 
> dpi scaling. Now, both the logical and physical size will be 640x480. 
> This is unlike most dpi aware programs which usually do have the scaled 
> physical size, then also make the render target that scaled size as 
> well. This doesn't make as much sense for QEMU, since the guest is 
> responsible for modesetting, and they should get the exact physical 
> pixels they request (if i modeset to 3840x2160, I wouldn't want this to 
> be scaled in any way).

Despite the patch is just two lines maybe it's not a trivial change. Does 
this mean that on hiDPI displays now a 640x480 guest screen (like BIOS or 
legacy guest) shows a tiny unusable window? In that case maybe this needs 
to be switchable with a property or turn off scaling of 4k and higher 
resolutions but then we get to the issue that other ui backends should do 
the same so just changing one backend may lead to inconsistency. Did you 
check how is this handled in other ui backends?

Regards,
BALATON Zoltan

> Signed-off-by: Oliver Clarke <oliverhenryc@gmail.com>
> ---
> ui/sdl2.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 1c97d23a47..1910477db4 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -102,7 +102,7 @@ void sdl2_window_create(struct sdl2_console *scon)
>         flags |= SDL_WINDOW_OPENGL;
>     }
> #endif
> -
> +    flags |= SDL_WINDOW_ALLOW_HIGHDPI;
>     scon->real_window = SDL_CreateWindow("", SDL_WINDOWPOS_UNDEFINED,
>                                          SDL_WINDOWPOS_UNDEFINED,
>                                          surface_width(scon->surface),
> @@ -907,6 +907,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>     char *dir;
>
>     assert(o->type == DISPLAY_TYPE_SDL);
> +    SDL_SetHint(SDL_HINT_WINDOWS_DPI_AWARENESS, "permonitorv2");
>
>     if (SDL_GetHintBoolean("QEMU_ENABLE_SDL_LOGGING", SDL_FALSE)) {
>         SDL_LogSetAllPriority(SDL_LOG_PRIORITY_VERBOSE);
>

