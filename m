Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A793CF34A9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 14:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swNEM-0006nq-EH; Thu, 03 Oct 2024 10:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swNEK-0006nQ-P9
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:55:00 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swNEJ-0003oL-4B
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:55:00 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fabc9bc5dfso15043711fa.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727967297; x=1728572097; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cqimRBy0v2IPGVyeJPgjgqfnG1RerwuQyi6dDHbl1Fw=;
 b=AlfPmvRxKgN3idZo705X2wlJlGl1N7YBS6/9ZViminyNbd26snTsJD0BFuyL75FPu4
 yIn7VDeGUcD00ZnRmtg3eQ7CCwYdRjh/a7zT3nYUwrc1QmFuTHR0rUjQQcn4TOnUzyDs
 9NYgVB5I3miHe3l1MOJK75uScSb6AhJknsVi+hvVVXVTqPcqnTnoODaKFXoQZ3d10RZI
 8cmHnRSvAYLbL1Q75Y/tlX81WQtcJStUuXgJo0X2B/FeDmirPfiEhiMQCYN2iz9WpFIa
 paGaB0eBm7t/dn33nnYdeSUuwvfrjHn5rutKxdG2enQ0+voI8NGswQr8IxBa5zDSC/RT
 3bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727967297; x=1728572097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cqimRBy0v2IPGVyeJPgjgqfnG1RerwuQyi6dDHbl1Fw=;
 b=Q+cPioo0EH+aKMPV2iEy8M6SAAqp13e6UHqWaQH0rlMGNO0eTQmQwJ/D45V4g4gMbv
 LSRo7YBvuyBPmEjy7pnjthwP/dYWhB31UyL8HoAHCgGhpGWlIXnxZHsVFAgMjQU38t+9
 yzzpYwsolDs/2hkmunVR4IKzVX4ek4Mjz30EWrMl7GSeQYfpSCkPCxx2T1GiAw+67S7u
 xpvB11Y+lAUcd3o2+lKpg390Vgllt2AoieIqE3uBkPPZgX4jGNu+nyoDxmnGJuLQHyu0
 HlzcTZxPgJwnja5e6FAfFfM7D3yobDAZau2deQcoksqrEQq5d0IJ+4QA/S0m65OIjDc+
 j1xw==
X-Gm-Message-State: AOJu0Yx7qwGA+IOzxgauejqgbEjFxQ1JSZqYVhyxSBvfqBddX/iy1/Eu
 XSqjMFinqYGQUJlWbAN0NyTaYNu1CWm2ATYa46b4JArWvCGlmr5EQDQuNOvwtlNyPheJ4q/UBBD
 cwLEM2ylVgh8XBw26Uag3ZK/n9ah/i2W8qbZc3x4C+8PRTFyc
X-Google-Smtp-Source: AGHT+IFeK3n+Mcg7Pa026KsNGRj6MLPZFmBS8CFcuQypa6Z79Ys5GPTvpHaPx2dAOxHYAA4nysaNGV5jcoDup/XIdr8=
X-Received: by 2002:a05:651c:2209:b0:2fa:d296:6fbf with SMTP id
 38308e7fff4ca-2fae0ffcb20mr48393961fa.1.1727967297107; Thu, 03 Oct 2024
 07:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240819144303.37852-1-peter.maydell@linaro.org>
 <20240910110344.10e4805e@imammedo.users.ipa.redhat.com>
 <CAFEAcA_Rjiy1so28OVPpL=+++XuU+gSXhn-v_WHMcpc_wa_xMw@mail.gmail.com>
 <CAFEAcA94EdUOOk71nv4oFRJXNBM=62FCD9dfwVSWMS-VM_OZtw@mail.gmail.com>
 <20240920124551.56f1e832@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240920124551.56f1e832@imammedo.users.ipa.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Oct 2024 15:54:45 +0100
Message-ID: <CAFEAcA9weMO1Djm16fQB4JBDUCggXnOfzZ4cXHjqeMseXQRyEw@mail.gmail.com>
Subject: Re: [PATCH] docs/system/cpu-hotplug: Update example's
 socket-id/core-id
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Fri, 20 Sept 2024 at 11:45, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu, 19 Sep 2024 13:34:54 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Tue, 10 Sept 2024 at 10:38, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Tue, 10 Sept 2024 at 10:03, Igor Mammedov <imammedo@redhat.com> wrote:
> > > >
> > > > On Mon, 19 Aug 2024 15:43:03 +0100
> > > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > > > > @@ -83,34 +83,32 @@ vCPU hotplug
> > > > >
> > > > >        (QEMU) query-cpus-fast
> > > > >        {
> > > > > -          "execute": "query-cpus-fast",
> > > > >            "arguments": {}
> > > > > +          "execute": "query-cpus-fast",
> > > > >        }
> > > > >        {
> > > > >            "return": [
> > > > >                {
> > > > > -                  "qom-path": "/machine/unattached/device[0]",
> > > > > -                  "target": "x86_64",
> > > > > -                  "thread-id": 11534,
> > > > >                    "cpu-index": 0,
> > > > >                    "props": {
> > > > > -                      "socket-id": 0,
> > > > >                        "core-id": 0,
> > > > > +                      "socket-id": 0,
> > > > >                        "thread-id": 0
> > > > >                    },
> > > > > -                  "arch": "x86"
> > > > > +                  "qom-path": "/machine/unattached/device[0]",
> > > > > +                  "target": "x86_64",
> > > > > +                  "thread-id": 28957
> > > > >                },
> > > > >                {
> > > > > -                  "qom-path": "/machine/peripheral/cpu-2",
> > > > > -                  "target": "x86_64",
> > > > > -                  "thread-id": 12106,
> > > > >                    "cpu-index": 1,
> > > > >                    "props": {
> > > > > -                      "socket-id": 1,
> > > > > -                      "core-id": 0,
> > > > > +                      "core-id": 1,
> > > > > +                      "socket-id": 0,
> > > > >                        "thread-id": 0
> > > > >                    },
> > > > > -                  "arch": "x86"
> > > > > +                  "qom-path": "/machine/peripheral/cpu-2",
> > > > > +                  "target": "x86_64",
> > > > > +                  "thread-id": 29095
> > > > >                }
> > > >
> > > > beside reordering, which seems fine, this hunk also introduces target change
> > > > perhaps a separate patch for that?
> > >
> > > What target change? It all says "target": "x86_64" both before
> > > and after.
>
> my mistake,
> I should've said  '"arch": "x86"' instead, which is gone after the patch

This is because the "arch" output member was removed
from the query-cpus-fast output in QEMU 6.0. If we
mention this also in the commit message, is that OK?

======
docs/system/cpu-hotplug: Update example to match current QEMU

The example of how to do vCPU hotplug and hot-unlpug in the
cpu-hotplug documentation no longer works, because the way
we allocate socket-id and core-id to CPUs by default has
changed at some point. The output also no longer matches what
current QEMU produces in some more cosmetic ways.

Update the example to match current QEMU. The differences are:
 * the second CPU is now socket-id=0 core-id=1,
   not socket-id=1 core-id=0
 * the order of fields from the qmp_shell is now in
   alphabetical order
 * the "arch" member is no longer present in the query-cpus-fast
   output (it was removed in QEMU 6.0)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
======

If that seems OK to you I'll send out a v2 with the updated
commit message and the fix to the device_add line.

thanks
-- PMM

