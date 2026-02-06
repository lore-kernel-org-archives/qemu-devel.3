Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0D4EE6B44
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPtz-00085v-N6; Fri, 06 Feb 2026 12:45:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1voPtw-00084v-VJ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:45:53 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1voPtu-00052n-2u
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:45:52 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-66a4780b4abso311942eaf.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:45:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770399949; cv=none;
 d=google.com; s=arc-20240605;
 b=RGKmhB8FvcSUI6XwxhXEccxKgueH00mZbgft+U0TUWGZnkODZvDsxbHwV0w22GXY5E
 cwVhP0oQDeQJmn8674lBDr1yzyD2NZtdGx3+nOfSdUTKkorIndpdVn8uZT3UQ4lMfPX7
 O0Yf4i/m0xVkHJs9FlcqvpG4Gtel/bbvxEfxuSyhJYR30R5tSM7VSvp5zx/1aeC46VnF
 UViIidaQVVA8d7C68Br0S2eTvvx6j877GFDgHSMqzikFFEJX+RX5xzxXa9w6RZ4DLYJa
 8HUQLq+meAIKnVj0zIPDLYn6oEcewb6AS+Gn2awQkU2Ka9scarJGD4t04ZVAThQZ8ri5
 0vww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Eo7CP+XVtidcjtLY5cGx7zYrM1SKz8QfuI3uW5LNb9c=;
 fh=9Xh+R7zIRm5O897kxCGh+dkL2L1w6BVeJfthgI/kLZI=;
 b=Tkp/B5SOrCLyVAr4y08w0pYrDgHueL0pbXH5/YdAp2IkmI4qBz7RmOGMS1/EGIQPkr
 6gvI2zjKLf7TjDRaRzruEmetvv57PUVSpaWRdZLo4heJdstjfF0+tqEzy0YswuEiR1qz
 F8wT0pG3g7k9oq/Sw5PEIKZqKuIfeC0j+OpxNLa3LDMy1f7kOttMKw79N5DsaUIF8Q4v
 ZYZh5g808k9WEQn2ZvlWxCK6wonpcmJKLJ+tcoPbafI+G36Z7PNaES+qI4RFeh2UsXvB
 IC1d/RhClSsyvk2anwEruveCI9huaw7BlA5yGUJLLKrt3EWxa9FluKnqsWsBp/mfX/7x
 jtfQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770399949; x=1771004749; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eo7CP+XVtidcjtLY5cGx7zYrM1SKz8QfuI3uW5LNb9c=;
 b=cjqRaxJmDnr6pjmmcW2ORZVXY0lKsAuhTQbJWagT+graUtrkjT6OPHDUVxlGWEAZw8
 xBtOTBO4tzMfLWYgE8QTuZGgSou4xoUzPreM2oJqxVQ0qJdkeDP4N6Ef+Frco0EQWx2r
 TGufIZQmG0WLvBatYPTR+cPYAZ5t1g7pZbDkDY1tHELxB2AF3zOpfKXUZIf95tDv3P4r
 +vPuETgB02Or7eQUuIF1kajt7WFFObmgaxBDUfJTZ2M6GjbL0z0lXlT+gRfn11f5eLJh
 mMD2zgmkpzuRWeEvFm/L/6Cqnm6w5qQdvVQwgTe0AGEXkxMbv1jP3pXZkWIrlpqIgg/7
 3foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770399949; x=1771004749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Eo7CP+XVtidcjtLY5cGx7zYrM1SKz8QfuI3uW5LNb9c=;
 b=MGr6+P0fWh4x4UQg4k9lO2LklSaN992F3PGXaI6CoX1iHXozPLMNcjM7rlbIbtshuo
 Qf/TKN2BSXOMGIbRqVwWXp9M1Cqf9c0ektAwcslYLIjAnpMSy8OD4kmr5MEuCgqCcDYi
 5rGdQsumxWJS4G5W4NHZq44CFV7erHTEpHBcPJim4OlFVm0q+Mgl+tzQQ+u8AoiQMOUE
 cFcIK/7tBlH6kvaLbnSccZuLXh1gIiXb1HIliqkJzbHHHD9YG9/wlvdsNWANEfSdibcH
 nrw50MuW2YLyuNiU+QZqSS9MCCVzNx3VaTHJ+VyGeTXSmiTmWjqwI9x0sWmlfxQBqwvJ
 OlXQ==
X-Gm-Message-State: AOJu0Yxja1caIsJ7R5fyfN16/nZZ6kuYGGw02XrgJdcMI8syvbT9Sma9
 xRml6WCUPOzsPxQdBunHwMmGkmmBkbH3aD86D7v8+vFYN3fAZO32Se1K99yvz4mS7X0kM7RokJW
 exLSxnGYfARW1WcK1ETPJA8g9cwHV8YQ=
X-Gm-Gg: AZuq6aJrVv6T12U1cYUWTak733C8XH140wiglwFDh6YLy9Ul+8eyILdsm0xKDvAuYYM
 rQI0CCQddJ8Znnf3ErAwodCZeTI/WuypNcZpxZN497wjiXIgYYgmW0wjBGBhgSJXRo78oUzGkoh
 HV6dqSVaSNgETf1Lgdh/iq9CFUQQRkQTR1WlGOoh8THa0GYsNup1SCV/xAEyTcQVkOjLQW8g6kt
 Y03KsQG9KWviCaYZhzIF/lYX2oGwfsNbixpbKnRd66KgUgBU48hu1J+44EjT6LRfNxwTseD
X-Received: by 2002:a05:6820:818b:b0:662:f42e:7cfe with SMTP id
 006d021491bc7-66d0bea535fmr1624778eaf.54.1770399948687; Fri, 06 Feb 2026
 09:45:48 -0800 (PST)
MIME-Version: 1.0
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
 <20260205195824.2610192-2-ruslichenko.r@gmail.com>
 <aYT_4NYQDbCyfS1c@redhat.com>
In-Reply-To: <aYT_4NYQDbCyfS1c@redhat.com>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Fri, 6 Feb 2026 18:45:37 +0100
X-Gm-Features: AZwV_QjB54-VahsoPMF85sMfreSW76Ko_2BCkX6qMXSB3cTC5fW0uU4KRDmkStY
Message-ID: <CAN-aV1HdTaJEtLU8uWcatB-9EZkNu=AkB_ZC5CdwMo6zXe9yXQ@mail.gmail.com>
Subject: Re: [PATCH 01/29] hw/core: Add Remote Port protocol packet definition
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, 
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com, 
 takahiro.nakata.wr@renesas.com, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, francisco.iglesias@amd.com, 
 Ruslan_Ruslichenko@epam.com, "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 5, 2026 at 9:39=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Thu, Feb 05, 2026 at 08:57:56PM +0100, Ruslan Ruslichenko wrote:
> > From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >
> > Introduce packet definition for Remote Port protocol.
> >
> > Remote Port is a socket based inter-simulation protocol
> > designed to connect QEMU to external simulator (such as
> > SystemC models, RTL simulators, etc) for hardware co-
> > simulation.
> >
> > The protocol supports bidirectional communication for:
> > - Connection setup, version negotiation (Hello/Cfg packets)
> > - Memory and MMIO transactions (Read/Write packets)
> > - Interrupts and GPIO signaling (Interrupt packets)
> > - Time synchronization (Sync packets)
> >
> > The patch introduces header file with packet definition
> > used by protocol.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
> > Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> > ---
> >  include/hw/core/remote-port-proto.h | 305 ++++++++++++++++++++++++++++
> >  1 file changed, 305 insertions(+)
> >  create mode 100644 include/hw/core/remote-port-proto.h
> >
> > diff --git a/include/hw/core/remote-port-proto.h b/include/hw/core/remo=
te-port-proto.h
> > new file mode 100644
> > index 0000000000..cbe1498df0
> > --- /dev/null
> > +++ b/include/hw/core/remote-port-proto.h
> > @@ -0,0 +1,305 @@
> > +// SPDX-License-Identifier: MIT
>
> Preferrably stick this inside the comment block below instead of
> mixing C and C++ style comments.
>
> > +/*
> > + * QEMU remote port protocol parts.
> > + *
> > + * Copyright (c) 2013 Xilinx Inc
> > + * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> > + * of this software and associated documentation files (the "Software"=
), to deal
> > + * in the Software without restriction, including without limitation t=
he rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> > + * THE SOFTWARE.
>
> Including this is OK, since IIUC in this case you're carrying on
> with someone else's code, and so aren't permitted to remove their
> license comment.
>
> If there are any files later in the series that you wrote yourself
> from scratch though, they can omit any license comments, only the
> SPDX is need.
>

Understood.
Basically all headers in the patch series were already present, which
is the reason I left them.

>
> > + */
> > +#ifndef REMOTE_PORT_PROTO_H__
> > +#define REMOTE_PORT_PROTO_H__
> > +
> > +/*
> > + * Remote-Port (RP) is an inter-simulator protocol. It assumes a relia=
ble
> > + * point to point communcation with the remote simulation environment.
> > + *
> > + * Setup
> > + * In the SETUP phase a mandatory HELLO packet is exchanged with optio=
nal
> > + * CFG packets following. HELLO packets are useful to ensure that both
> > + * sides are speaking the same protocol and using compatible versions.
> > + *
> > + * CFG packets are used to negotiate configuration options. At the mom=
ent
> > + * these remain unimplemented.
> > + *
> > + * Once the session is up, communication can start through various oth=
er
> > + * commands. The list can be found further down this document.
> > + * Commands are carried over RP packets. Every RP packet contains a he=
ader
> > + * with length, flags and an ID to track potential responses.
> > + * The header is followed by a packet specific payload. You'll find th=
e
> > + * details of the various commands packet layouts here. Some commands =
can
> > + * carry data/blobs in their payload.
> > + */
> > +
> > +
> > +#define RP_VERSION_MAJOR 4
> > +#define RP_VERSION_MINOR 3
> > +
> > +#if defined(_WIN32) && defined(__MINGW32__)
> > +/* mingw GCC has a bug with packed attributes.  */
> > +#define PACKED __attribute__ ((gcc_struct, packed))
> > +#else
> > +#define PACKED __attribute__ ((packed))
> > +#endif
>
> Is this comment & conditional #define still relevant today ?
>
> For the rest of QEMU we just use  QEMU_PACKED whose definition matches
> the #else clause. Ideally change the patch to use QEMU_PACKED, if not,
> mention in the commit message why it can't be used.
>

I will double check. Might be some old mingw version which is not actual to=
day.

>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

--
BR,
Ruslan

