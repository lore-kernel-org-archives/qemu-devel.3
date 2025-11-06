Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC7FCCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 10:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGxcd-0004V9-K5; Thu, 06 Nov 2025 05:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGxcb-0004S4-85
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:53:41 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGxcZ-0003aC-No
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:53:41 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7868b7b90b8so7151447b3.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 02:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762426418; x=1763031218; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q5UqKqzixkyhCrmKyU16eLnEU5O1ewEKG2IZTjLJxng=;
 b=m8wZF5qxW4pCEWuxJmWD5YSUvEjZZXLVdmqmfrLS/4CyWBWioPhfZAbGhw1aN5aNvu
 ZmYi4vyWEKbqkuZtr0tYsU6DO+Y439Q5s78Xnrv5HQceEG2VjbW/D4KxFmYZRBy9IV3N
 m7m/r2wiXE/+99lxC0thnBUJ5bPXuh13iOwF2Jt78TPenthvv7PIeLX49OzMYpmDLUdp
 PQtPHyucEV3j97s3wG5njHqjQWOVeRZ0PavY6M472jZvMBgFaRI09LVW9vUnHC0aywq9
 EH+gUhyc62qFX4/qLsjRYuL+LHK0YHpI5wIBtusZOsDl8GKTEduDRX9cYl8RSbOWEnI7
 mEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762426418; x=1763031218;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q5UqKqzixkyhCrmKyU16eLnEU5O1ewEKG2IZTjLJxng=;
 b=ZlJeApgdrfxdKz8rGy7/2PTzx7zc3oRQr1ZenMpUD9U5/Hi1TGfp4ZO9jAroiNZKAT
 bJFZgg6LPggQsi190HdA+mXUAwYbxl+at/KWAzV2P3jq4Ic8sovKm70n6bCWSeU9ZPfJ
 bZfjv9lqMFao2WvwUAkhpaAMdhQE42eXjnxXl13VnIuO3aMC5dEHSEAuxc90hEHsqncw
 SZU0kN4nmWKbrxFtTEmzRPgHhTq+3bIJQD5Tbt1+WSV0WDOsgZHb1FQLTc3894+onb/Y
 6HhzYjrTXmqrMix2qGeKMw1Rl06IdmM7ekM508PV3bBkiBKACiLSJleAX9oo8P4usioX
 Mmmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1O+PQA0P6BEs9sGAnzAO8s5iEMES8mmaZt11+IfGPqiMTKM9y33lqVgjmfFDSuDHnGgk74Vz25G8O@nongnu.org
X-Gm-Message-State: AOJu0YwRn0vzkh6WKW5opGaCr4ENMCaQ4HGK5H+pcw8aRwgDY++W/MyC
 xfBLeMn4dt3HzbJjIv3Jlrve9OGsAYk0RmAOq4Yiksw9vwhP0H607Y8cvdtsev6Gr3U2hQtkeN4
 O0D6nsXAhYkhWrgOYdnv3c8VDxUk7KHrzIajSYIOH6g==
X-Gm-Gg: ASbGncvV9eYpXsw8ZY/v5oEXy9+J6cbb38hIl5RY05EyNRaMa8ObIK5rMNNkx6gzlxl
 u/fPmMTUijh7aJb4cvxpxUgsb+Fk+MXB5Pi6URMbAyK0ITGBZTvsKZWEUHjcrh6+Iz9sGiZuffT
 9B/s9XkIVhwZmQcAmc0ZgCVdRj/fFyHNda3aVcHzBFdHMtWFT1ze6Ar4qGdKPXyxGCWyCEMr+Cd
 wgAuI4ugEVw3JNSXA2qqq1J1R7rG21eQqSmuIp1nSG4j+8iniHThIwYmpfelJxyMIGB5xw0
X-Google-Smtp-Source: AGHT+IHoo/kEocXEMBcNoNO3/UPShnET6BvkUK+1C47bKr6biOi57sVEFqXxU86/MsBn1vlqTx5SHZ2M0zF2+Eh5IJU=
X-Received: by 2002:a53:d04a:0:20b0:63f:9dba:355e with SMTP id
 956f58d0204a3-63fd34db325mr4836273d50.29.1762426418002; Thu, 06 Nov 2025
 02:53:38 -0800 (PST)
MIME-Version: 1.0
References: <aQtAotYvzFY0Vpft@tcarey.uk>
 <5c356c12-55b8-4d01-bc0f-025d3a3b9293@suse.cz>
 <CAFEAcA9c0Y=ndvd-yV5tTr_+nbBO7W-TDcF4+=qCoknzyGPxAg@mail.gmail.com>
 <508e699e-ba3e-4977-9507-8da7da14fa28@suse.cz>
In-Reply-To: <508e699e-ba3e-4977-9507-8da7da14fa28@suse.cz>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Nov 2025 10:53:25 +0000
X-Gm-Features: AWmQ_bnhdfKQTKhrXJzgngfR1vyhxXf-LJuq4ktt0Xcm0yV5Ln0Zy0AYssfgHE4
Message-ID: <CAFEAcA8z-voiUiBx2bTjUq-GuYJgL96ai81aPAyhYTJvg-uieg@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/edu: restrict dma access to dma buffer
To: Jiri Slaby <jslaby@suse.cz>
Cc: Torin Carey <torin@tcarey.uk>, qemu-devel@nongnu.org, 
 Chris Friedt <chrisfriedt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 6 Nov 2025 at 10:45, Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 06. 11. 25, 11:38, Peter Maydell wrote:
> > On Thu, 6 Nov 2025 at 06:29, Jiri Slaby <jslaby@suse.cz> wrote:
> >>
> >> On 05. 11. 25, 13:18, Torin Carey wrote:
> >>> The EDU device doesn't enforce any bound checks on the addresses provided,
> >>> allowing users of the device to perform arbitrary reads and writes to QEMU's
> >>> address space.
> >>
> >> Hmm, it was the intention to crash qemu before:
> >> commit 7b608e5d6c1d61430e81cd5c71b0277b99b03f3a
> >> Author: Chris Friedt <chrisfriedt@gmail.com>
> >> Date:   Tue Oct 18 08:25:51 2022 -0400
> >>
> >>       hw: misc: edu: use qemu_log_mask instead of hw_error
> >>
> >>       Log a guest error instead of a hardware error when
> >>       the guest tries to DMA to / from an invalid address.
> >>
> >>
> >>
> >> As with a standard device when you program it badly. I don't understand
> >> why the commit changed it to log only and let the code to corrupt the
> >> memory?
> >
> > It's a PCI device. Unless something in the spec of
> > the device says "if you try to DMA outside this range
> > it will be ignored", then typically devices will let you
> > DMA anywhere in the address space. If the guest chooses
> > to program the device to DMA somewhere silly, that's its choice.
> >
> > Is there a spec for this device anywhere? If so, we should
> > follow that. If not, then it's a "make a best guess", and
> > "don't arbitrarily constrain DMA" is a reasonable guess.
>
> It's an educational, fictional device, there is of course no spec for that.

I think that for teaching purposes you would want a decent
spec for the device: there will be a steady stream of new
students who need to know how it works.

In fact I've just noticed we do have a spec, in docs/specs/edu.rst.
(It doesn't specify the behaviour if you attempt to DMA outside
the range it documents.)

> > The reason for the commit above is that devices should
> > not call hw_error() as that crashes QEMU itself.
>
> But that was exactly my intention. Students should see an immediate
> crash, not random, undebuggable (in the given class hours) writes
> somewhere. And crashing a qemu instance was an intended pun.

Sorry, your educational device doesn't get to break QEMU's
usual rules. (Eventually we might be able to get rid of
hw_error() altogether, though it's hardly a high priority.)
People debugging drivers can turn on the GUEST_ERROR logging
which should be a big clue.

Incidentally, restricting DMA to "4K starting at 0x40000"
makes the device not usable on all machine types -- there is
no guarantee that the machine even has any RAM there at all.

thanks
-- PMM

