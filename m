Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A93CEACCA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdZF-0002DN-CA; Tue, 01 Oct 2024 10:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svdZ6-00020Y-7l
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:09:25 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svdZ2-0002DG-Dl
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:09:23 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c88c9e45c2so5010374a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727791759; x=1728396559; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UpW4yH467d0379s5Vgwk5GAfGeKWVP/pynA3yjAnFWQ=;
 b=AqD7h+7uCybNUE3C5BHW8Kk7M2nGSaPzmlaVzlZPhSAUlidVXoTZAntyJJNyt2rZ7M
 T7OhRQPiToaLff+7JJfS7Qf46FHoOCxOdThyUJiMxqXjJtOS2K1sLz4FaCkAeuqPGhRG
 G00pAKeDL8F3uC9jpSYXnSGzQ44EEXAmDnREQTF3WVHI0RKnDwTOx8ltQZ5RaM1Xo+cP
 ruq1vOYnZqQ60q0N/fTVluN0Lx6YREKR2k2HO4zPj8AZyYxYhAk/Xx2PgEYb8I+5nvl2
 wXyEsg6UQJIETqtB7KR1yGXtlrXBmb5sYD8vCySWBIE+jVgPR7sKjx0YFAw61HeFalfV
 eZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727791759; x=1728396559;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UpW4yH467d0379s5Vgwk5GAfGeKWVP/pynA3yjAnFWQ=;
 b=lPMEnmQwJPiP/vqGJC12U6y1NP/NwdyUJF4L+S9Jwi5UCmx2WPpbweBJ4opLJngp8g
 KERe0MudWeexLgloFJqph4NddcMSqlLNhnp0E3qSPN4EAHVmJG3TSSSrs8nR6trwdDFS
 aJYMpp5jJTTVu3q1MMsXdnZ3XtO9argNJkjblXCAhCU3L8K9D+adpxgCRPg8pEyGDIkG
 UALi0n874n3ghAahVJCBaZtGbIQS7Wo4Jt7Wx4e0d/snwsb68zBvYJUQDS3Ur0pDeCR6
 DLfGmyteAArQoBHEXuWFJamAqKlQioRQ2UaCIvV4sGWJQYrYJFLSCmVaMe72Gu1f5LdL
 fLiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw673baRlOQrXrjusCpREvL9AB7keggd74E7O09cHS5FVYi6BDt/E89YCA2W6iB0nEJSgAfaNjfBLF@nongnu.org
X-Gm-Message-State: AOJu0YxtdmotPwjMBvSwdwo3FmH0PrgzHgZMzdbnjBORBwYvNY1OxFMM
 FK4gg+7cWbQiE982T5YoR2R7My+a6PK821gjpPTxt9Efcklhhs85m1cpkbCU3D7NOYiHGAQNv/z
 pSLlFxo0XcgLMIu8l1DuYDeyz/mxzoliwp6+u6aLDJJu7tg+q
X-Google-Smtp-Source: AGHT+IGyHcJ05tj28COGPO4EKwC6iV9XRQZLVNhtmi0wqIoloskb4hMdogzbvNhi/gNi7BTpvOvwMTtRvqGwSJbT1v0=
X-Received: by 2002:a05:6402:2550:b0:5c4:2d5d:b25f with SMTP id
 4fb4d7f45d1cf-5c8a2a4d72cmr3213218a12.13.1727787882522; Tue, 01 Oct 2024
 06:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <CAFEAcA9hH6b72pVMAVkGHWXye9t+RXHE13RD73AabQN+p_JOyw@mail.gmail.com>
In-Reply-To: <CAFEAcA9hH6b72pVMAVkGHWXye9t+RXHE13RD73AabQN+p_JOyw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2024 14:04:31 +0100
Message-ID: <CAFEAcA9P+Eu+aFag1vpXTzevLDBuUk8zXd=kZVeYHbnvEL=80g@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/53] arm: Drop deprecated boards
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 16 Sept 2024 at 11:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 3 Sept 2024 at 17:07, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > This patchset removes the various Arm machines which we deprecated
> > for the 9.0 release and are therefore allowed to remove for the 9.2
> > release:
> >  akita, borzoi, cheetah, connex, mainstone, n800, n810,
> >  spitz, terrier, tosa, verdex, z2
> > We get to drop over 30,000 lines of unmaintained code. So it's
> > a big patchset but it's almost all deletions.
>
> Hi -- ping for review on at least patches 06, 08, 18:
>
> >   hw/display: Remove tc6393xb device
> >   hw/arm: Remove 'cheetah' machine
> >   hw/display: Remove pxa2xx_lcd.c
>
> These are all straightforward removals of either
> deprecated machines or devices that are definitely
> exclusively used by those machines. That would be
> enough for me to get the bulk of the uncontroversial
> reviewed parts of this series upstream. I can then
> roll a much smaller v2 with the parts still under
> discussion.
>
> Patches 22, 26 would also be helpful but they're a
> bit further down the patchstack so less critical:
>
> >   hw/arm: Remove pxa2xx_pic
> >   hw/misc: Remove cbus

In the absence of further review I'm taking these patches
anyway; they're only removals, so not complex stuff that
benefits from close review, and this patchset is too big to be
sat unapplied for long.

thanks
-- PMM

