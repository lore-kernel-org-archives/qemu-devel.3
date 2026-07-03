Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0951FC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfamA-0006Tg-7C; Fri, 03 Jul 2026 06:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfam9-0006TQ-6U
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:05:37 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfam7-0001cF-Lf
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:05:36 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-664dd23829eso353335d50.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 03:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783073134; cv=none;
 d=google.com; s=arc-20260327;
 b=YoA4iROxcHdt1t1szFcrdIChyVORnHPvgPJUGfLqFBUkecIU5W7r/PacgLZiNVW35S
 ATm99FNFUkUDy+EketfLH/JMNUqhuWtWaA9y2g//Qn6adWiw6HWdwTfDsA2DTJm3mw42
 lKTpqipjRm4kWa1VdWv7mRxm3xXJ7ga9ABiMDujJPvdCcY+UQoehjqURv25Ct/DVCh05
 unvJm0NZgfaDMpcIX36gCFGXJbML4phaJaZuxUzhgLzSarWfquLFJ/10hGfkWiBOAvJ6
 R3WbdLv2FUzy+zeyvytY40IfvLrgH+m/bsLhAEZNAi1Lgc3e9wb9crRnMz4mJ9Mi3kZH
 GSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oeUGoLGxhy4xRJ1+R8hWN/3fx/m6Juhe2wVH5KdxEzA=;
 fh=VdU0ZIHHM7Xuu0AoHAY9TnsLw+Rmx6THNQ8Qxyqt4ys=;
 b=DDaJcKkMfo2sUNFWkdUjM+QlXnEXUXED17AA8DFFTPiimdO4cB6XbqygLzchUdGUlS
 pugNR/llAdb7nh00s1U3q2ICx7VGGHsSQt6AD6u2MVJr46aROLGtni7SZSRKxqDHZ0yk
 T0i277Plg+v1fa6c2O2wJ1jDxGYLUkU5n2bB32MhtthpHLx1YcABhc3eUAvipBSL12xl
 ZB2XD7B+RZS2th76V0R8fprVn2EVUcvODdfkx5BKAXH5pY3BPbku36XPcYEZlZMXtEhf
 W4uivy9OMbhjb3GKW8/VT0gACqcllc+ePQ6U0Vps/kZVSWErmg5Y7PQBpcjrtkOlGpBZ
 F2vQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783073134; x=1783677934; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oeUGoLGxhy4xRJ1+R8hWN/3fx/m6Juhe2wVH5KdxEzA=;
 b=tsEAyBKU+m4IWbOgwNFQyCAc9IE3KZY5zHXqND7QdAZqIYU437dvO5+7LDAwA6HUtx
 eULoHjbLdEYgwok8CUFSUsJyr7vv7kpCHny8Ne60+SwTPoUK+cx9Lq+5abti1QDFHBAi
 td5fRv9hlXappUT87N14uOhUnUPyOkkQDPa7nvBt16VHUrHJjgQgaxztbXepa0FUgUic
 QxmDKW5qmJQyLrW5Prc/DEhOU9pRxf0qOeqpjS4zEikkjvfdB6tdDFGs+zkDYqxGFOCW
 jJ0GdmAfT878fJpAwuOzJljiA2J+5uiTPSqJPD381UO45URHIUgUYW/biBX7CBZMK4+H
 4kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783073134; x=1783677934;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oeUGoLGxhy4xRJ1+R8hWN/3fx/m6Juhe2wVH5KdxEzA=;
 b=FrPiYqPoeLe8Ey4DakSIQDzIjNwjZ3oeLv2MOgbgDwlN4rRNeMcX69ndHms6FquJFZ
 c7+9M4S/aczWak6jeEEW9JoP5tvJocUdjHNBNk15hHOIZO03xAt1tpXFycEJSvSAnavt
 lLoHwirfsVicHP23fgo6zWCc8YVvMshqdLDtyOFTDzulD66xSO9oxLQsdl1VXD1nl1kI
 kTNQHaEM5rq0KhBlU4X+x1vuEMlxWmqZsXTkTgvjIjdXtBlLNsL5oG5Fxbeeu4VWwpll
 1x0ijb3b8frT8ADl/8bmeobRb+zBRk56XBkRDl+/SN21yyHOUAmZ2ptA6KN8Jp2iZ5Um
 G0Rg==
X-Gm-Message-State: AOJu0YwrtPdPfD7G0mHy7y2Ub3rjZrLp6di+Cdr7JjG0Sfm7G5oZGLRn
 tEiUDolSZFThcYIJMsH+xwt5j0dSr+pzTKF0pVkfg9VmrfqpsjVnAYCnadZcu8hzObPIo6NN2ka
 G+PaFH+9Ojbk3S7DxzlexWoaAajIw+0cVQtgaoK8L/g==
X-Gm-Gg: AfdE7ck0gIUqhnvRopUiEBU300wLXLq82hXEEEgr82B5YdeUmzP0WmqvJbPtzvNgoVz
 XblDUvwn/lNPF6fDw8VgNfU3U5bTPJZIJGqJyQ1ybPELwsdoiGeicjhMHMGsIUhG8ji1PbeFQ8N
 ZXxW1lDjXJJ7cMNKryFN5NJD+AshqMPl93sw8aTGwFMydEwguE5b4nX/8HbDYP4n4WUjGkQVdIw
 WthW98RBec0EFxOGpJqjg2hWhue52WPQ7vuoBvNi0xZ3rcBpoB26Da+s+990bLmN+r34RaEJOOx
 iL6Oze+AmzzKQM1/Eeo+18NIXVPC6pVO46iVCYkZdOj91o+Focex5FRQ
X-Received: by 2002:a05:690e:e8c:b0:664:c8af:1910 with SMTP id
 956f58d0204a3-66596526562mr8313213d50.26.1783073134242; Fri, 03 Jul 2026
 03:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260521112806.504961-1-kraxel@redhat.com>
 <CAFEAcA8hbObntY8Tp+kOV7btb-io92O9GW99-6SPxigPJUjPrw@mail.gmail.com>
 <akYylBa-3xSn-qTB@sirius.home.kraxel.org>
In-Reply-To: <akYylBa-3xSn-qTB@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 11:05:22 +0100
X-Gm-Features: AVVi8CfLfy8GeBdihJNHxF49XNVmbqaBfwYa5rbFKiB5-WTSvqLeFQdiMTQpwu8
Message-ID: <CAFEAcA9=Tz4OX3O5eRXb8vQwJZB9EoU4ZAv5Xo3hhbf7TCj1QA@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm: add support for shim loading
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Thu, 2 Jul 2026 at 10:45, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, May 28, 2026 at 03:28:05PM +0100, Peter Maydell wrote:
> > On Thu, 21 May 2026 at 12:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Also little refactoring in preparation
> > > to avoid code duplication.
> > >
> > > Gerd Hoffmann (3):
> > >   hw/nvram: add load_image_to_fw_cfg_file()
> > >   hw/i386: switch shim loading to load_image_to_fw_cfg_file
> > >   hw/arm: add support for shim loading
> >
> > Any chance of some information on what this is?
>
> Ping.  The doc update with additional info is merged,
> this isn't yet.
>
> Do you want take this through the arm queue?
> Alternatively I can merge this via firmware queue.

I've applied it to target-arm.next; thanks.

-- PMM

