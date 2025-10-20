Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8668CCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAspf-0002pw-Na; Mon, 20 Oct 2025 12:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAspe-0002pV-GX
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:34:02 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAspb-0002dr-Ih
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:34:02 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-63e1b52b452so3515040d50.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760978037; x=1761582837; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Za1PTbEGKLvIR+r5FTw1gSIFLQh+d20XLkrwVISLkrA=;
 b=UGeW6orJ/KyZoBO6ZXEqIEW9nPsAjWaoeV7ac9usOJ7EtCinDxFc3RByrjLILAP+fQ
 OxMg4470l8ihEWp1qDa1a0f8SJHraa+YVZvWW8pDP9p/MNi/JQ8/cvJqzsJ5Je7IOn+a
 ieULS2PptLNyoGNp4r2SLtFvW/12nu8+LREhw5SuOkv6W8cvT3Ihl0qJygE1K1MAoQLr
 FXurx8vzgTJGyk6qIk6+/PdXEbMgyMABz7trLBlormkNMSRAe+jYgNbdia5qh6iNNc7/
 AGA549IaDIJeJHLTcWOJpFMI4te1ZM26IxaXcgIMl8J7Y2yQspEeyQcM85uoieg3N1/r
 rzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760978037; x=1761582837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Za1PTbEGKLvIR+r5FTw1gSIFLQh+d20XLkrwVISLkrA=;
 b=PfMWFhFHLFfvrYG/eYQOUhMxobxJna0sH8JQzdpbTbBf0/8RuihJo6TIKFo2U9MBfU
 yLwhqrXygO8qcf+YZMkpzf6bP+DSQURIbbkdLnqx/TPzIejVt+hJMXrqvCRnat7ZFsJL
 FlAmzl2jbNuY/1dIiE8Cw6Q1q+CetfXtShs0RZ6cUDfr/dYznxrSsplCD8GGzFa9gEha
 6ev97TxAkrKGaMyp4XUZctH2w0sB7jOvrkhY8BhpchHiMV8MCV915yGuobL84BZP9f1M
 oWmfzSZcSap4bijkrj3c32djpa3d6xqFgJEtGf43kofDf1eac6OXw0oAIL2m2LqLoo/V
 CYRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlMPd6eHqFYLbuK26hsgmaTcpeuoAf8wJBvEXr1UAHTzF/zSwIUouNFsS0YI3gv2SLCsY+ovd8fExl@nongnu.org
X-Gm-Message-State: AOJu0YwQRx1EENvGEMD2dDLTnPU/e2ms35GATphUE/NipF7npLwovxfN
 SrmEl8kK0j/0QpOz2798IyPva4gPa6nm2cS8qGNINGGsMHhCcVI0Fpkrw8pxI6iw/W8AhwQey9L
 Ec6Mz+6+pqfGe5IxdILWuV5gS5Fva2k2LLgSlZM/uUQ==
X-Gm-Gg: ASbGncu8V3c7kraCpKefxImybG7V4akJBhfYA0wBrns8Ld8yR8O8d2zLv/6LEI5Qfsp
 nae5iJ7X3/qB+DaNJtiUkwt3M+WYqUiCBMTeJJZa/wiurEBHUJYcQHBHtAJOVDeqd3BWZeyVus+
 4EjnG+GPRQ2EHn19UaPmOZkW6jA9W+mijODATO4p4Upj1wP9uIrRFdkLjKuv/Nf814fPf7ueSmv
 uC62OzCYoqE27eD4LnaJokx6KkQ/pa/GKtbVj3INuvk4SYzlWZCSpyKswu47aAUWvh/mTV5
X-Google-Smtp-Source: AGHT+IGluNTbBaUGcL5PmdS159soo+8r6q7ZjdpURFMh42TSBbUjvvbWnaoHQUq9WoDuwE0VrarK4/nEVfBhHJ0bSKE=
X-Received: by 2002:a53:b7ce:0:b0:63e:8e4:45a6 with SMTP id
 956f58d0204a3-63e161c6bc6mr7781692d50.35.1760978037431; Mon, 20 Oct 2025
 09:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251017213529.998267-1-sean.anderson@linux.dev>
 <20251017213529.998267-4-sean.anderson@linux.dev>
 <4d1a679a-f1c2-487b-bddb-eaf7dd56fd0e@canonical.com>
 <56d70072-67ee-471a-9b9a-c3257886d668@linux.dev>
In-Reply-To: <56d70072-67ee-471a-9b9a-c3257886d668@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 17:33:45 +0100
X-Gm-Features: AS18NWAEXwsG6Wypd77uJXP6xZYgFM-7A964vHTO4bz5WMZi7lvVz1zMAd8RNzs
Message-ID: <CAFEAcA_-08zVV6U2jVhNbYAwkLYXdjOzmRP-ZutjAKPuiGQ-_w@mail.gmail.com>
Subject: Re: [PATCH 3/3] semihosting: Check for overflow in FLEN on 32-bit
 systems
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Luc Michel <lmichel@kalray.eu>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Mon, 20 Oct 2025 at 16:01, Sean Anderson <sean.anderson@linux.dev> wrote:
>
> On 10/18/25 03:21, Heinrich Schuchardt wrote:
> > On 10/17/25 23:35, Sean Anderson wrote:
> >> When semihosting 32-bit systems, the return value of FLEN will be stored
> >> in a 32-bit integer. To prevent wraparound, return -1 and set EOVERFLOW.
> >> This matches the behavior of stat(2). Static files don't need to be
> >> checked, since are always small.
> >>
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> ---
> >>
> >>   semihosting/arm-compat-semi.c | 17 ++++++++++++++---
> >>   1 file changed, 14 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
> >> index c5a07cb947..57453ca6be 100644
> >> --- a/semihosting/arm-compat-semi.c
> >> +++ b/semihosting/arm-compat-semi.c
> >> @@ -305,8 +305,19 @@ static uint64_t common_semi_flen_buf(CPUState *cs)
> >>       return sp - 64;
> >>   }
> >>   +static void common_semi_flen_cb(CPUState *cs, uint64_t ret, int err)
> >> +{
> >> +    CPUArchState *env = cpu_env(cs);
> >> +
> >> +    if (!err && !is_64bit_semihosting(env) && ret > INT32_MAX) {
> >
> >
> > The issue with the current implementation is that files with file sizes over 4 GiB will be reported as file size < 4 -GiB on 32bit systems. Thanks for addressing this.
> >
> > But unfortunately with your change you are additionally dropping support for file sizes 2 GiB to 4 GiB on 32bit devices. This should be avoided.
> >
> > The semihosting specification specifies that the value returned in r0 should be -1 if an error occurs. So on 32 bit systems 0xffffffff should be returned.
> >
> > As file sizes cannot be negative there is not reason to assume that the value in r0 has to be interpreted by semihosting clients as signed.
> >
> > Please, change your commit to check against 0xffffffff.
> >
> > It might make sense to contact ARM to make their specification clearer.
>
> stat(2) will return -1/EOVERFLOW on 32-bit hosts for files over 2 GiB. I believe we should be consistent.

I can see both sides of this one -- the semihosting spec
is pretty old and was designed (to the extent it was designed)
back in an era when 2GB of RAM or a 2GB file was pretty
implausible sounding. (And today there's not much appetite
for making updates to it for AArch32, because 32-bit is
the past, not the future, and in any case you have to deal
with all the existing implementations of the spec so
changes are super painful to try to promulgate.)

Our QEMU implementation of SYS_ISERROR() says "anything that's
a negative 32-bit integer is an error number" for 32-bit hosts,
which I suppose you might count on the side of "check
against INT32_MAX".

I think overall that if we think that anybody is or might be
using semihosting with files in that 2..4GB size, we should
err on the side of preserving that functionality. Otherwise
somebody will report it as a bug and we'll want to fix it
as a regression. And it doesn't seem impossible that somebody
out there is doing so.

If we report 2..4GB file sizes as if the file size value
was an unsigned integer, then clients that expect that will
work, and clients that treat any negative 32-bit value as
an error will also work in the sense that they'll handle it
as an error in the same way they would have done for -1.
So that is the safest approach from a back-compat point
of view, and I think that's what I lean towards doing.

thanks
-- PMM

