Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5B9CE7B08
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 13:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJtj9-0000je-6H; Fri, 14 Nov 2025 08:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJthx-0008Qg-Ev
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:19:25 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJthw-0002YM-2P
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:19:21 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64107188baeso1802676d50.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 05:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763126359; x=1763731159; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jq07g6e7KH5zYtT1Neb6ACLpqUPUkVb01NhBRq7Mqjs=;
 b=xmKYLZGtIDWwcNyzqH9sm8nhyXsV/U7vygTHy4HCD164FLAtlrbwa8NTOlu4ZoqTLc
 f9TxWDFkDYDjlzzQaKN/ovCZjpQo5MH9XrZnEUn9FJKnQSZ1KGInFF8NOz+7glaj1N42
 W+yvaTjewvcNr4Ehiyjd8huIhEcU9WzOtetuVs1J2rORDLaUDRJU0fft84EBjL1ihJVm
 R8dafjxxWzWerMWIYUiLF+Bh5dj4kHVyXBjMXW4K/u5acGUqEmqBo9fJgtx9Bi3K+Ob3
 yD1uMbxlNDVCWCf2grLP8BQBndo1Z5L+bKrYQH9XyDP5CGIGzx8yNB466Qs930kCIa5Z
 nizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763126359; x=1763731159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jq07g6e7KH5zYtT1Neb6ACLpqUPUkVb01NhBRq7Mqjs=;
 b=HhqhpeZPYgF7YymNvq/2olYelTZDf9ou2ejtqty9s0yMLlxiwhM9/XFgS52ap3S5jY
 UNy9sYUWZIH/V3T6XhR80m266vH1txNjUe+xYI0TE9fkUSArLmsjKRf1v8BRCe9TjoVg
 /0w+z3DkbBUHEwUWEr17574U+yOVqpb9uWj8riQGHsFz5Gg49EhE18f8YV6GUJuUAnGw
 ZpPUmB8Zy5bR8bIU8gBNjIC/b0VAqn+gkzjUqmBGM/zxvHuaHnPwA/vMvPIrD45qfZN/
 U6AarTvIjzcZgDcCPKMnsPzsT31NkfHjoGKKmE8o0M+SvjWEtE/8Y50Q7bxaZxFz1N6t
 Lw3w==
X-Gm-Message-State: AOJu0Yz08VjD4OyYKg2ONBu8K0ucscF3YzSRvMNXk1H1zASYfVJixL9u
 Rv7tnINN5vga3tliIu6COgFgni3exADPpJ5yZItjWNi/EXYeB6DZjnV+FlpqbXMRoJ8k9yQibhG
 ezEkTEoXfL0UQJpKkF2F6wVPvmlGR5zt1Fb6sYqJ4PtbuUsTM4hudyOo=
X-Gm-Gg: ASbGncuS+C+jYFi8tB/bPPP39+GAQc1bl/1w/AAircglb74iUM1U63BL0dbKcQ2hrX4
 2ZQ4d3yx5zqpOTLl7Pv2CVsPJr7iuA227qvI5HWaH3D9ovqXUnbuEIZ+6KxGl4Ny/JsoBha7tj6
 RQIoYoH0kQHgQ4gOajrzeOUltBw3rkWFyyOKDgNCLD+EbgSk4TWTrjUspB/piEBIGWe2f0EeU6V
 2b4OU7oCOHR8M/zSRKLlhsvDZtzRC9EXKZVQiwdaqhPAmTyG5DyvcJ74eAr+5rkGMplblq+
X-Google-Smtp-Source: AGHT+IELRTcYwCLeMbbgI0mZjBxd+vizbfKskfOSc9LF1PtuZvoNn2Mewu2FRSwVP2V8QZyU9aM9EbyCrgJmohjuXZA=
X-Received: by 2002:a05:690e:d4a:b0:63e:1f47:f504 with SMTP id
 956f58d0204a3-641e766148fmr2490148d50.50.1763126358942; Fri, 14 Nov 2025
 05:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20251104160943.751997-1-peter.maydell@linaro.org>
In-Reply-To: <20251104160943.751997-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Nov 2025 13:19:07 +0000
X-Gm-Features: AWmQ_bllXjllp5Uw_WMcfw4bENWzQy4518jlI7hUg1ADWSjsepiWDigwz4pWRag
Message-ID: <CAFEAcA_0gVKvQTcL0NXq3Z1kZALDVG9M-0L0e9mZXvRhhh=7OQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] clean-includes: improve exclude list, run on cxl,
 vfio, tests
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 4 Nov 2025 at 16:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> I realised that we haven't run clean-includes recently, and
> unsurprisingly various violations of our include policy have
> crept in to the tree. The exclude-list of files it shouldn't
> be run on has also grown rather out of date.
>
> While looking at this I realised that one reason the exclude list
> is stale is that it's encoded in the script in a really awkward
> single long line extended regex. So the main thing this patch
> series does is fix that to instead use a list of regexes, one
> per line, with comments permitted.
>
> The other useful new feature here is that you can now point
> the script at a directory (previously your only options were
> an explicit list of files, or '--all' to scan everything).
>
> The other changes to the script itself are minor cleanups.
>
> Finally, I have a couple of patches which are the result of
> running the script on some subdirectories. I do think that all
> the changes that the script now suggests are correct (it wants
> to make changes to 28 files other than these) but I wanted to
> get the script changes through review first, and then perhaps
> send those last changes a bit more broken up per-subsystem.
>
> thanks
> -- PMM
>
> Peter Maydell (9):
>   scripts/clean-includes: Allow directories on command line
>   scripts/clean-includes: Remove outdated comment
>   scripts/clean-includes: Make ignore-regexes one per line
>   scripts/clean-includes: Do all our exclusions with REGEXFILE
>   scripts/clean-includes: Give the args in git commit messages
>   scripts/clean-includes: Update exclude list
>   cxl: Clean up includes
>   vfio: Clean up includes
>   tests: Clean up includes

I've taken the "actually clean some include files" patches
into target-arm.next, since those have been reviewed.
Review of the actual script changes would still be
appreciated.

thanks
-- PMM

