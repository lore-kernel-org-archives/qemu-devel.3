Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565FCD4920C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 11:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCzVl-0003yA-7s; Mon, 18 Nov 2024 06:01:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCzVd-0003xH-Rb
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 06:01:35 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCzVb-0005H9-73
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 06:01:32 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so171289166b.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 03:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731927689; x=1732532489; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+A2WmAOSm5CSFV5k/PxFQuxZqU5UrjQlYj2eC5Xi8g=;
 b=MDWy+UwW8hP1qwhnJtK3szzBBNha7esO6DT/HRH8paMdI38zrFIsc1Dyy+ccBSD7fH
 oAQguBJey5mBGJc4arnYnAhKke7ULxZegMRaA4/HTo1bA1sN/xSzlArsnk4JRqIFI+yH
 o0+FT2D/DMEuZe3wXajdAw2MMXAewfKGBMnvY013f/+yZ80L0HQEWXQuHAAU4UdHct4U
 6fFoHUBdTXCXpidSrFHwJTbJ4KEUlr9OLOY8NH4yAN/9KTNkPzcHWUq8sVEPL8DpTe/C
 9cKghJiABk6x/cYI9hHyEaYG1xWH3JTZMzrUUosEwbrFj/HZD1VG+3piRB1AS94iL6K8
 JtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731927689; x=1732532489;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+A2WmAOSm5CSFV5k/PxFQuxZqU5UrjQlYj2eC5Xi8g=;
 b=qLi/76yiOVx+O1y5JRH9N9fEuEm9dl+jy1W2fM0WNreve4f+N3/rsySkUnrxP1J1+Q
 2wnVDWha2bOFjH0SMwNzFbIy/nvLgb25Yg+/oRkWWAxpQ13F7uRWQ6gulIOPjgygeWDj
 EFTBNdiTnAl1zVrKCESBE8b72rAdpwaMgV8ZRx3U0ivnPF+MAXaboOhED65x8FF2cnTx
 IY4dWN57MewGfwpU0T90Qfyk6rvZv1hrrRhwTR6lcevpONBn0QHjFXSM7MFXsElqi8UN
 ux4Y1cqdywf383d7OpHkhnqWPrdi0RwawfcVrCJz7S/mx0lmit8RpizxQEDVW9/fHYS3
 95Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNyG9xEmkZdYY2lC5UAYJM6ftKQXcnHjpoY5Dt1yCVLQ4ljMPsazompuRpJOWG/cphZ6KYRp7UjZxz@nongnu.org
X-Gm-Message-State: AOJu0YyLf+953td8Av8AI32Vbgysk8kHoKsEQ7D6N7BBsk6pdHDzTJ5k
 2r3uRSYrj0zuwXzJyXhoOXFOfFropJezFNz0TYIUmD3rdIm6Pk0DygKp2eF1vEzxK8oFtajTtZW
 XT2+QEPoK//bqWfY212fYhEoNZcaqZBQOABQ1tA==
X-Google-Smtp-Source: AGHT+IEppW6Uq/DWBc+4O5rf2M6AaB/0rv/a3bI9xKaVuE5XSwpkQxIfylaJp+TQJKYevTz1GLCJRWcoQLpK2hSEe8U=
X-Received: by 2002:a05:6402:2794:b0:5cf:66d1:f97a with SMTP id
 4fb4d7f45d1cf-5cf8fcc6f29mr15718930a12.15.1731927688636; Mon, 18 Nov 2024
 03:01:28 -0800 (PST)
MIME-Version: 1.0
References: <401F6B10-2316-42B4-BFAA-863E9B2B8F87@artins.org>
 <84975169-3c87-42c8-96e3-7ae724cc4692@linaro.org>
In-Reply-To: <84975169-3c87-42c8-96e3-7ae724cc4692@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2024 11:01:17 +0000
Message-ID: <CAFEAcA-pBf2HywiWmAUSZ05a4bK0+5ovtS=K7ggXZ6pHRe8L6g@mail.gmail.com>
Subject: Re: avr5 not found in qemu-avr 9.1.1 on macOS
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Iris Artin <iris@artins.org>, Gavin Shan <gshan@redhat.com>,
 qemu-discuss@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

On Mon, 18 Nov 2024 at 10:54, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Iris,
>
> Thanks for this bug report.
>
> On 17/11/24 02:51, Iris Artin wrote:
> > $ brew install qemu
> > Warning: qemu 9.1.1 is already installed and up-to-date.
> > $ qemu-system-avr -version
> > QEMU emulator version 9.1.1
> > Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers
> > $ qemu-system-avr -machine 2009 -cpu help
> > Available CPUs:
> >    avr5
> >    avr51
> >    avr6
> > $ qemu-system-avr -machine 2009 -cpu avr5
> > qemu-system-avr: unable to find CPU model 'avr5'
> >
> > What am I missing? Thanks!
>
> Gavin, this seems related to your commit:
>
> commit 7db8f7e895bff8b2eac08dfbc977d22a5a9fff36
> Author: Gavin Shan <gshan@redhat.com>
> Date:   Wed Nov 15 09:56:06 2023 +1000
>
>      target/avr: Use generic cpu_list()
>
>      Before it's applied:
>
>      [gshan@gshan q]$ ./build/qemu-system-avr -cpu ?
>      avr5-avr-cpu
>      avr51-avr-cpu
>      avr6-avr-cpu
>
>      After it's applied:
>
>      [gshan@gshan q]$ ./build/qemu-system-avr -cpu ?
>      Available CPUs:
>        avr5
>        avr51
>        avr6
>
> FYI this works:
>
> $ qemu-system-avr -M 2009 -cpu avr5-avr-cpu
> -> OK

I think the new help output is correct (in the sense that it's
what we intend it to say), and the place we want to get to here
is that -cpu accepts the correct "avr5" name. (We should probably for
back-compat have it also accept the long-form names I guess.)

We don't require "-cpu cortex-a15-arm-cpu" for arm targets,
for instance.

thanks
-- PMM

