Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B14EC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 16:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCKe-0002Dz-Cu; Thu, 22 Feb 2024 11:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdCKc-0002B9-DK
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:53:58 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdCKa-0004Xs-HS
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:53:58 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-512bde3d197so4839606e87.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 08:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708620833; x=1709225633; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nf52OA5fILsrybhuloXecF5YCEWCvIiFI5qmVgIWBsc=;
 b=ySdFwsEQktKXx/Pb0DkHzPczsQLjp3dxaNTngWSlwriD63n9/IxEFgUwu3p0Vpab8Z
 WvwkUWpYf6LNmIw4x+VBdkXAks2qKs3jb/5lxO46fxD58uwB3u5bLFHvLd9QQCWdkPNi
 8wp1wWG3AH83nMXNAj8Fy/k85vDcSzNbzbj9gfjCyo/1kTtfAdgOJ3zQzMpNxzuIPOIl
 /qBAloPlfiIjI0jylVxP/DEXu6keax0mSF1z98MKlPjcbYIbLvdAtEnlhc9vfw9B+J4c
 TdoOk4MHQ66BsWn9DfQpILzZSvgPJCky1eURk0YWi3E/tHo5sdg3VdhkE4ryBpYs5KVw
 9Fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708620833; x=1709225633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nf52OA5fILsrybhuloXecF5YCEWCvIiFI5qmVgIWBsc=;
 b=J1Oyay8V87flc9MshxJSzB8OBxrv6ZBCtGbWfqx+wcUO9Atr5v8hxJoNdHlVEs8vAc
 5ukuHKM8Tn7T7n0owLK3hVaGo9bAkSPelp1Ct5vwkk6wnN0Qung7Q4RmFbYSZi89s5y4
 m4o/NhVrOW9yjt65fpI1TnPwfuayOIvS+t8PWD9Ztn8/5M5R+qv4PjMn/zcEUmGB5fpJ
 rH4QL05ckxkFgCmL+dKIkmLdyM4VDm0wt4yLHbraVGK5jl8qc7ZNevNbPWGjNNmf0wx9
 +5jz5QkKVslK+7TDqjUqHb2H+lVtCwT4yCMqClSdHGyoNF1n5sf+HK5iA0zhVc2G6XRC
 6fFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+kkq4wdg1eho+VA2ClpcB36RLQhbAeRhUl/WZYKAEaoMS9XyY9XFaDXiI0RO0O3rzoo3VWYqkA4oIkGoKsy1PdFJt4CA=
X-Gm-Message-State: AOJu0YyZXYnFq7AQcMFl8UrKqwa0tkVKM3m+N8n+g0s/sihn6KzaBh/a
 x9YSBxNxbbjNjmeMQso0YEgQxCcI7NdUiWIeUTgGVHPDruZpT+UJnvxWJidKqe/FTXEbQAMkDZi
 IMNdcbBdsFjqcaIndCQombmohl5goMNMCpEqhxA==
X-Google-Smtp-Source: AGHT+IE0sYXk+nt6bNHkKvSKfU4r3LymUB69Rzts6BOLh/mkQLYHzqDXWupJoXWZ7DUPgrAveMBglcZ1g+0BKjvXh74=
X-Received: by 2002:ac2:5f4d:0:b0:512:b3a0:ea37 with SMTP id
 13-20020ac25f4d000000b00512b3a0ea37mr6736797lfz.38.1708620833623; Thu, 22 Feb
 2024 08:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
 <20240217-cocoa-v11-6-0a17a7e534d4@daynix.com>
In-Reply-To: <20240217-cocoa-v11-6-0a17a7e534d4@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 16:53:42 +0000
Message-ID: <CAFEAcA_QUMsOXbwOSAEZu5Qkc+G85DfchunxQQbEhRAEBv+Xqw@mail.gmail.com>
Subject: Re: [PATCH v11 6/6] ui/cocoa: Remove stretch_video flag
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 17 Feb 2024 at 11:19, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Evaluate [normalWindow styleMask] & NSWindowStyleMaskResizable instead.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  ui/cocoa.m | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 81de8d92669b..401ed0c3f1f5 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -103,7 +103,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
>  static int left_command_key_enabled = 1;
>  static bool swap_opt_cmd;
>
> -static bool stretch_video;
>  static NSTextField *pauseLabel;
>
>  static bool allow_events;
> @@ -533,7 +532,7 @@ - (void) resizeWindow
>  {
>      [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
>
> -    if (!stretch_video) {
> +    if (!([[self window] styleMask] & NSWindowStyleMaskResizable)) {
>          [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
>          [[self window] center];
>      } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
> @@ -1296,7 +1295,7 @@ - (BOOL)windowShouldClose:(id)sender
>
>  - (NSSize) window:(NSWindow *)window willUseFullScreenContentSize:(NSSize)proposedSize
>  {
> -    if (stretch_video) {
> +    if ([normalWindow styleMask] & NSWindowStyleMaskResizable) {
>          return [cocoaView fixZoomedFullScreenSize:proposedSize];
>      }
>
> @@ -1377,8 +1376,7 @@ - (void)showQEMUDoc:(id)sender
>  /* Stretches video to fit host monitor size */
>  - (void)zoomToFit:(id) sender
>  {
> -    stretch_video = !stretch_video;
> -    if (stretch_video == true) {
> +    if (([normalWindow styleMask] & NSWindowStyleMaskResizable) == 0) {
>          [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
>          [sender setState: NSControlStateValueOn];
>      } else {
> @@ -1650,7 +1648,7 @@ static void create_initial_menus(void)
>      menu = [[NSMenu alloc] initWithTitle:@"View"];
>      [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"] autorelease]]; // Fullscreen
>      menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
> -    [menuItem setState: stretch_video ? NSControlStateValueOn : NSControlStateValueOff];
> +    [menuItem setState: [normalWindow styleMask] & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
>      [menu addItem: menuItem];
>      menuItem = [[[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""] autorelease];
>      [menuItem setSubmenu:menu];
> @@ -2036,7 +2034,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
>      }
>
>      if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
> -        stretch_video = true;
>          [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
>      }

It's nice to get rid of the boolean, but
 [normalWindow styleMask] & NSWindowStyleMaskResizable
feels a bit clunky -- maybe we should wrap it in a method with
a suitable name ? (isZoomToFit, maybe? but I'm not too familiar
with what cocoa function naming style is.)

-- PMM

