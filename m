Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2C7C44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeUs-0001Gt-F5; Fri, 17 Jul 2026 05:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkeUr-0001GR-LK
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:04:41 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkeUo-0006Cn-Vk
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:04:41 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-81ecf499af9so43847607b3.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 02:04:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784279077; cv=none;
 d=google.com; s=arc-20260327;
 b=GeYbSIXsQUWJBSPGb7jU0u+qpjk/fpqhsWcpH6CMcnTXcvhUvEykD5YuJFm3I/dmHI
 cZoNnB9yRShKLg08aBBtzL/u8T00lVF0C/E9wScSHEQ0i77BWoUhIK3dn6qIzZcxtjY7
 IXAFLY//MCRtUaOem/NQkOspZTBkQFGHxON4baa9DB+HpHluS7xJb0ByeWRiRb4vu1dI
 q3shzyaL/ljqAdgsv8sNAMk2o+SOvLf8baEDP+SxFfuWDHLg8P9H+tLq/50lkm3TWdD1
 AIFfRJuuuCISLsjiZSjohWwC1TC6b3iSPz8kDTwC+u5D2/ATJAJ6ZAKGU5l/Zbg2r1qX
 cznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P8nJbFTwijDQXHnHUxqAc5yYHgnENsgRFp7K23oSfL4=;
 fh=JZRbMaK6XI/G3VFS9BOCv5MpQN+HOAIaxbGDlg5Rjkw=;
 b=lrNv+tQ2dl6rmPZWAq+tCLS+Hw8xmCcIcDkLBbvCbfXz9TyVJvO+zyOGqP5d6KOD7Y
 trllOuxOnhj2poEh4JiYf5SmGV2LmpqM9JfH+Zs9Zh0oN6YTA8C4cG7f7ZyVbC56BpOb
 /zMjDHuHJ0UUm0B1dQ5Q8QTSZLpeSuSAWUGLMNpBjl2qGbT9o+BAEket/xh/hTaIE1ph
 UPLRLZdoNPCneGvQR36ImIPKX9SdmcNDCS691reNieJKi296zAqd/iGQwnNVVPTKvePn
 cYTFSG5XCMsWH1VYjLTGq1yjQrk8lClQLGFI3MyebJ5NtNzOBN27VoDNG3JJBkPSZ7rC
 zppg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784279077; x=1784883877; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P8nJbFTwijDQXHnHUxqAc5yYHgnENsgRFp7K23oSfL4=;
 b=VbBBsW6wesagi8OIjUqulDorC1zV8hm63883uDObCtAWvJLt9pYZoWxkVNiQZi3jDp
 zFJK+H+aJHFT4+Ap+yDKkn741SFqv+PPDdkLnfupHQtmI9Vszx7AV93NtBPFN4G443uH
 iLwuB/7xat/M+WVBpaY35g5eXouY4cl9jhpoziUWCrFZYs2KboAWsRGEXZZmquCHd0pe
 EvA5SSJ8HqTuI+WlZbhIJ5GOMuybJryJ+XkDaz7V1LFT+uIqCF0/bOXBctYJWpiCo37/
 XwI7zFcOyiseKU/eIfGjH19oKo7uo9bGMEQVUgZSZ5kP08puBDmVnYrJvJntt5Xt7V5J
 +fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784279077; x=1784883877;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P8nJbFTwijDQXHnHUxqAc5yYHgnENsgRFp7K23oSfL4=;
 b=ectspmLGAB49A+5OZuLnJdWrtLold7gl9YHWlCYIfpOmrKt89MIzjuAsnyYp5mvWgx
 JquzC52Ed+3yeXTRkYfeAUs3p5iuMi2HM6Hcvd5WxFkuY/xd01B4rBo0iCaVQ5aaeTI1
 LyVB/VZYLjGraFoQ02mk0l70lI6p8ASgXpZK3sS+nBcnQ5M6VRqkEwlT99PfF/9CZMv9
 X62ox0NWTDTYnZr2LpJt4z8SwpMqFDvCr0LM9QXopkrJJ2RNpHM/lVEZjDrP/u+vCr4y
 zJovBZeZbjlU303GA9i4u6GhIJbyuzBnOzWNpB2xxZeGWNe5yTjbKmtz2ppedVrNkMAo
 AgvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrsM5XfM6sPV2wtuPKyf/RyoW5084ii2tsGkm1DdVVrX/55mvjmHkrWNYKfTnLKYziwFCSFGynq3ezb@nongnu.org
X-Gm-Message-State: AOJu0YxQvRvG77AwZ9PVkBRLtGdVSj7iVYFjUsIkQDN61Xsn175y7S3V
 Kpc4mGSA0OZ0T/NZNES90I/KAMk5x3MgBXxZGD/X4LQvsnPhZgs0uj0c0Qdedocb961GLHK5d5B
 qN9V52KC9zPbwfUd5DYsb8Fp5tQAQ51GBh6fCTW/z9g==
X-Gm-Gg: AfdE7cnd3BNz+d1hQZCgYvIVqNZJy3xyDiPnl2KxLFAbFl61MxtGWJT00WONQwmy5Ve
 EW45Iw5L9gykkPoz9w74LC0+uLrVy3kNkCNIENjnR4nHKZko7faVoJNM7GyBdABOcT5nnyNHnEL
 8XTo+XHZ8vSLZtpfp8DuMZszT37niL5WR7PAWptvSe9NOTxhXA8IQV4A9sCDDzNRvoYA7i3XK2/
 PaSh7S+NaS/ty/8X7+x3myGmXV1IK4Eo6Pxd+R7fZZcT9D0iJq8YVC88BIE9aqqqEe7mp0eo6ng
 QsplQlPVwNqMkbw4707h/agVdpHRUBNVWFcwJjcygJDIzQ==
X-Received: by 2002:a05:690c:e3c6:b0:80c:85e5:872d with SMTP id
 00721157ae682-81ef26b97bcmr4629817b3.59.1784279077354; Fri, 17 Jul 2026
 02:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260623-guest-panic-unhandle-v1-1-6adfb6d4221e@ooseel.net>
 <CAFEAcA9LCRKmU+r77zGp+4Rgd-uaZLPnoPPQDSfG8X5eeiynJA@mail.gmail.com>
 <91ad4c80-adc6-4f37-8346-20230638e5f0@oss.qualcomm.com>
 <CAFEAcA-hnm17d4PR0wmaKwQmM-K50nHeRYv0a-pCk3J1qUbPsg@mail.gmail.com>
 <CANTT7qh6X7ESRwgfM5PRkfCx9BSVUXHy8GL+n8SmX3LtusWiGw@mail.gmail.com>
In-Reply-To: <CANTT7qh6X7ESRwgfM5PRkfCx9BSVUXHy8GL+n8SmX3LtusWiGw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2026 10:04:24 +0100
X-Gm-Features: AUfX_myAcVGgxGl7E5kSTzl0FlyaoeC_z5epinFqPxAeHx2PntIyQ7ihGC8s3Dc
Message-ID: <CAFEAcA_Q1O16RUkLk+LvMjyi7L8O2txFrUkbna911QBQjAQLFA@mail.gmail.com>
Subject: Re: [PATCH] target/arm/hvf: panic the guest if an unhandled exception
 occurs
To: Leesoo Ahn <lsahn@ooseel.net>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Thu, 16 Jul 2026 at 18:27, Leesoo Ahn <lsahn@ooseel.net> wrote:
>
> 2026=EB=85=84 7=EC=9B=94 13=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 6:34,=
 Peter Maydell <peter.maydell@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> > On Fri, 10 Jul 2026 at 23:56, Philippe Mathieu-Daud=C3=A9
> > <philmd@oss.qualcomm.com> wrote:
> > >
> > > On 10/7/26 17:37, Peter Maydell wrote:
> > > > On Tue, 23 Jun 2026 at 13:56, Leesoo Ahn <lsahn@ooseel.net> wrote:
> > > >>
> > > >> It's worth cleaning up all resources that the guest taking and to =
quit
> > > >> if an exception in el1 could not be resolved.
> > > >>
> > > >> Otherwise, the guest will get in the infinite black-hole by
> > > >> unmodified pc.
> > > >>
> > > >> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> > > >> ---
> > > >>   target/arm/hvf/hvf.c | 1 +
> > > >>   1 file changed, 1 insertion(+)
> > > >>
> > > >> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> > > >> index 8b902c6882..4358cf90e8 100644
> > > >> --- a/target/arm/hvf/hvf.c
> > > >> +++ b/target/arm/hvf/hvf.c
> > > >> @@ -2533,6 +2533,7 @@ static int hvf_handle_exception(CPUState *cp=
u, hv_vcpu_exit_exception_t *excp)
> > > >>           cpu_synchronize_state(cpu);
> > > >>           trace_hvf_exit(syndrome, ec, env->pc);
> > > >>           error_report("0x%llx: unhandled exception ec=3D0x%x", en=
v->pc, ec);
> > > >> +        qemu_system_guest_panicked(cpu_get_crash_info(cpu));
> > > >>       }

> > For this specific patch: what is the case where we get into this
> > codepath (and in particular what is the EC_FOO exception subtype)?
> > Maybe the fix is to handle that case. Compare an earlier thread:
> > https://lore.kernel.org/qemu-devel/8D0BCB24-BB1B-40EF-A361-0F79D65600AE=
@unpredictable.fr/
> >
> > If we're getting here by falling through from EC_INSNABORT,
> > I think that can happen if the guest tries to execute from
> > an MMIO region.
>
> EC_DATABORT already deals with traps by accessing MMIO regions.
> Yet I have no idea what kind of instruction abort could be raised in MMIO=
.

Yeah, we can't support emulating of execution from an MMIO region
with hvf. I think it will only really happen if the guest has
a bug and jumps to a bad address that happens to have a device.

Did you submit this patch because you saw a VM get into this
state? What did the guest do to cause it?

thanks
-- PMM

