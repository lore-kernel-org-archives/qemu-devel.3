Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F00FD9E26
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 00:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvmAP-0001jQ-5O; Thu, 26 Feb 2026 19:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vvmAN-0001j7-S1
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 19:57:15 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vvmAM-0004yR-11
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 19:57:15 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b935ff845c8so147872466b.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 16:57:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772153832; cv=none;
 d=google.com; s=arc-20240605;
 b=YbtW2UGZVcFAzTDhRCVyVB7DLdj9qdtK8GFmt+FCvvgG7lDsT56GXuBdRix36EHz6m
 XDIskc0pItqv/jeIYJEE54qYfa8yCoZFr+XLj0stJULTSNMhln8IlzMbbaf3o7FwIFms
 TwplljSptZKHp/8cGU70GuWl8BnN93g0MlT/u9Lk8MXctXAC5rDBUNxCKAgt9Zr2x9Mi
 SmThNuSDkhyn2d6Y+G94QN17BlJdB8g8/sZmHhhQ8aOrYhiriVChdZv3IYOYSX9x8xZF
 08TmgHg7sTj1UJyiAw6Pcw645WnZp9G/0pWIAoUWAOPLfHAF9mFnZ1E6NxzV6hkxOQUc
 rqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OeEH7cjJvxswiRt9os69dOxS5OWFpSmEL5EP1a5GYTw=;
 fh=/8jdTGK0l0H/iuO79WuiGUe7AMSBif11PN0kSXuFZyo=;
 b=jr8/h7t8reIyC4Au6jTCu+umSaa8icnEqIcLDiIY2Fr3W73MZBa5bTTD9vXfpJNqfx
 9RuhCc3y3dhqLRu5ZqvABeUc4sq+w/ICIUJs/vurLo5fLSn8Qjeq91OZ9lpHHmHMKNgr
 /qk6pvPLySc+x3X1wkUk0ALCRp/54FOiQs0YWc8Y0OFgnq8OIyxA5djhgNQoqAX6O8lq
 RdJEdTrezGmoovHfgQgkQek5pVEEoRG/j7wiKH3ddaqrIGq1tyECaGwbn20tR6F2czdA
 l5CUwkzr2yfsfzFqd0SmlJ8Zo+WPJNzit9deyC+cdvYA5Bowllwaig3oHPASdtb9TlB0
 021g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772153832; x=1772758632; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeEH7cjJvxswiRt9os69dOxS5OWFpSmEL5EP1a5GYTw=;
 b=KSbmwjtcEKY35/Ve45IuldWyhr1B03EM7uyIxi0QAm2couF/7z/U8QKkUHm4I37z5N
 bzr1Y5ljxyTxdIslGZpJcBxMTyU5M8O8MgWaXk4gQUwPUvw0BO+5j4FYO0D0D0xedFVk
 yGgr6QoErG745gqbbWZX06IsX+u9p3C//6lQD5RnAfLaEBqfk0FAtSF1+UD7NWbjklBQ
 g+vGk2NaIEgtKSXvJRkOFRr74xm8XBGHqQSBx9AtT3RUCklpaCikht9x2FSKqxITspeh
 O/IMe/LKUUUf/NdFButeDt57qkUOoF1lUrUimPh3HqPR+0evxkI/d1T4JwSmh+2t+IYw
 KiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772153832; x=1772758632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OeEH7cjJvxswiRt9os69dOxS5OWFpSmEL5EP1a5GYTw=;
 b=g2XSgpsHjUl2EM3bG98WkIGGaJpmVV7ia4ZS8o9BS3L5Zz39kcjSK8s1wRA4OqL72A
 RiCMlqtfmeMjMznDHwfItqnyp6DlbiKrXk/7Aba3LO7Hj8nn0iNWgflwk1IzE3H0hxOE
 NvgT/Zy6dUFVh5GFSDz70jQzfLYpxkoSgK4KY8RH1mCzAPfpF5OftjLJWXKeFBIucQxy
 qoNyHHbqGZ5IAO28CyoLzPneeXVU8Cc8zvLfK17qa4bQXYqa07AHcvvpDk7yOnP+IzzY
 WEWo4lafoj6k4Q45q9HNfP94xXd+ehtbHxKdgXAjZe+yo4N6upkJlri7US89phvqvSx7
 81XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0eVE+151T+Uek7BKcFw/M1JCRrgI5ecnBMo3WoSFYxqOpp4DzAOQymZwX548NmtBIwuYuFI5B9Lrr@nongnu.org
X-Gm-Message-State: AOJu0YwLoz5n8WLkgLYyD+pItJt4BkK+JovAu49H9zZ+2lkn93GoLFjZ
 hNrCDBB87IbFg4hG+LVPaauGUoyXr9O7AZdCHMX1IP5UY9WzOTmJ7gjoG0ol8lG1CQk9Rw2E85d
 kxO0zONXqXhGyjXxtpXzEAKwRDUJRuIg=
X-Gm-Gg: ATEYQzwdZZTgDOA8c7H0OdwJI5GNu//GsHKgmzGVGWzeLY8ODDu2DzwI4M2pGJlGgUa
 j86AlK0uMzluk7HcZY9CIbhuTjYRBM/FOiwkatzfCRTIkvyP5pzJr9zZHnDV0lp/XBzgn/ylLQw
 zljNndv2QaCIAxQo5loKcJb/rlrIRya9fhrX9y0tlBWOBf3jdrbgRONcGhPZHPTd55TZv1Jppcs
 UNEbWpICN/ecGJZZeJkT3IdJUSfsBlyfTd18jcHy8gNv5omOXDGhczZldTPnNA+k200yIAc/01X
 bi7ycn3PCcQ6vJgwhJfdFXF6GAxFSBYRBW6fDA==
X-Received: by 2002:a17:906:fe41:b0:b87:2bd6:6bc3 with SMTP id
 a640c23a62f3a-b937658c8b1mr37014466b.61.1772153831703; Thu, 26 Feb 2026
 16:57:11 -0800 (PST)
MIME-Version: 1.0
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <A02120BF-779D-4B2C-B29D-A9CB044EA895@unpredictable.fr>
 <CAKmqyKO6ioRt+h_tZrudbriv-QDVsOG1LNJ+GFQJ3ZO-fEhjiA@mail.gmail.com>
 <20260226-hangout-satin-fd7913f18f2b@spud>
In-Reply-To: <20260226-hangout-satin-fd7913f18f2b@spud>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Feb 2026 10:56:45 +1000
X-Gm-Features: AaiRm51TJlngsHz2exMV-hMk9Hy4RD1pyLY1kohhPZ2hbXq_bt7JFBuzz0kUe9E
Message-ID: <CAKmqyKNST9ExmpcFE3iejmzZZRtMNSiVXkzfUK4GhhcketrCEw@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Add RISC-V big-endian target support
To: Conor Dooley <conor@kernel.org>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Feb 27, 2026 at 9:47=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Feb 27, 2026 at 09:30:00AM +1000, Alistair Francis wrote:
> > On Wed, Feb 25, 2026 at 9:39=E2=80=AFPM Mohamed Mediouni
> > <mohamed@unpredictable.fr> wrote:
> > >
> > >
> > >
> > > > On 25. Feb 2026, at 11:20, Djordje Todorovic <Djordje.Todorovic@hte=
cgroup.com> wrote:
> > > >
> > > > This series adds big-endian (BE) RISC-V target support to QEMU,
> > > > covering both softmmu and linux-user emulation for riscv32be and
> > > > riscv64be.
> > > Hello,
> > >
> > > There=E2=80=99s no Linux RISC-V big endian. Maybe the right thing to =
do is to not
> > > support it unless we=E2=80=99re sure that it can get to Linux upstrea=
m (for the linux-user mode)?
> >
> > Agreed. We really need upstream Linux support before user mode
>
> On that front, Ben posted patches for it and Linus was really really not
> enthused when he became aware of it:
> https://lore.kernel.org/linux-riscv/066d70c7-b0a7-45e5-9337-17901bc95664@=
codethink.co.uk
> Even without Linus' take, I feel like there's absolutely no chance of
> upstream support without meaningful shipping hardware that requires
> big endian support, because basically everyone else was also opposed to
> adding it...

Yeah... I saw that.

A few thoughts, just because Linus doesn't like it doesn't mean QEMU
can't support it. But I am hesitant to support BE considering the lack
of ecosystem support everywhere else.

There are a bunch of changes in this series that could easily go into
QEMU. They aren't intrusive and just involve changing or using helper
functions to handle endianness. I think those could be split out and
go upstream, reducing the size of this series and reducing the
maintenance burden of out of tree patches.

The core BE support is a different problem. But if softmmu works in
the existing binaries then maybe it's worth accepting. linux user mode
is a whole other problem that we probably won't be able to accept.

Alistair

