Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4321FE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 17:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL3y0-0007Et-53; Tue, 10 Dec 2024 12:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL3xy-0007AH-Ro
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:24:10 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL3xx-0002in-HT
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:24:10 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6efed201f1dso31670157b3.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 09:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733851448; x=1734456248; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HmHgk6WwodGHclyfp/wP2e4PoKaUnncNSXo+kPo8+eo=;
 b=G7PNioO1dgN8Uo22r6G4p0RMrOsr2lYJi4ten8D3j+pvzhpNYsZWygnd+e9+tJsO4Z
 T1Q2pzYAfRr5kbJ0J4PGF+90Qh0Rm7ZWeq6FaGyAkZA8Hza3eptOxeTJ6wC0SepNO0Pd
 xFIBSKAr+9OGHnWguRCjpWc+FTJp2+feQwB7ta9sDtbDBSsYlUcMj5m0HcqE+KO7wAp9
 1ev8x9xfxu2LhDpGK4nUhWnKdfbqXgD+nh0htr1TfOjaQjpqPkQds8fuHFjhdvYRZvNE
 BWQWaUQ61dLa1XdaAaHw0hod6Jdq1l1i7QzcGI/MoU5W9k04+3lbAWmLEs+SZTgWoiAR
 UpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733851448; x=1734456248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HmHgk6WwodGHclyfp/wP2e4PoKaUnncNSXo+kPo8+eo=;
 b=KP1xwzROW8G/lri5nSBUy9XUiEpGaxmVYkZhtAFPxkcR4pcWNKQ8rCDmjUETJhnf2A
 jnYwlY8ggwWjPgY5YTawridYByeaITdaw8su12yOGRaextYAwkfKJv/09GyEoNZ28p5m
 U4A2uNC/Co21SWJjt4MiahMTLmDIOuhlKhD3VAE+YtixRhERRXxc6qB3pIVZTW5NkLTU
 TScq3jZZvM6UdIa8SlUOKbwW+OotpwYIoKCLih1f/CGEvWQk6In1rAwndk9AhO8hgn/q
 i2eanKOm8EmRgN2rdv+2FCNxosN5p+GpPc81tKzttzqzSctSyJ71AOBPX307o959DPhP
 MNQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEdyCGvv1QD7NWlzyPWPPXGwm3vLjlaaHfy4R6ffPo1DNdlSg16sQTSyocl6iu22B2qV8iCsPSx4WW@nongnu.org
X-Gm-Message-State: AOJu0YzmCxAKRz0JJd/oDnoXA1uAgFs/McSUJbcX2Xzdvuo3/uBbehHM
 BOEhF/5MkUV4JmCY1vfpmm4TIRaJCta8+PIc9RMQ0B0L0xnDcosU0ydx2agMCX4z2wtQk7SCTVk
 A1vLAWnTJ+URlYGCeqLm1euLyvWbiXsRn+lpB4A==
X-Gm-Gg: ASbGnctwymSNfz+GVYDlgtSlheaYRSxMzQlO0kQQIEC1202E0ra9KxNgHOmlMe1rt0e
 51Belneav4ASHx1PSKZe1r4DDfKwN1hgALEe0
X-Google-Smtp-Source: AGHT+IHHF/c0aaT7yqGZX5BeV+qB6P5f6weGxD2/KErNle2caBWmJ57TJ4l/uYt0w3tsduCIuZF0nGAKbRO9YvyL8Jo=
X-Received: by 2002:a81:b54d:0:b0:6ef:6536:bb6f with SMTP id
 00721157ae682-6f1462446a4mr10709737b3.22.1733851448348; Tue, 10 Dec 2024
 09:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20241204184205.12952-1-vikram.garhwal@bytedance.com>
 <Z1TO5a5QbMyrqhRt@xse-figlesia-l2.amd.com>
In-Reply-To: <Z1TO5a5QbMyrqhRt@xse-figlesia-l2.amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2024 17:23:57 +0000
Message-ID: <CAFEAcA-nGEJ0H0=xtOjuOJhpvf4ABpUcVQ=_-8ujqtuRrTX3Ag@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add correct email address for Vikram Garhwal
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: Vikram Garhwal <vikram.garhwal@bytedance.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Sat, 7 Dec 2024 at 22:40, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> On Wed, Dec 04, 2024 at 10:42:05AM -0800, Vikram Garhwal wrote:
> > Previously, maintainer role was paused due to inactive email id. Commit id:
> > c009d715721861984c4987bcc78b7ee183e86d75.
> >
> > Signed-off-by: Vikram Garhwal <vikram.garhwal@bytedance.com>
>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

Queued to target-arm.next for 10.0; thanks.

-- PMM

