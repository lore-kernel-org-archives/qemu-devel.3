Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF3A10A88E5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5nmO-0006Di-PV; Thu, 26 Mar 2026 12:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5nmM-0006Cz-TL
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:41:54 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5nmK-0004sn-15
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:41:54 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64ae222d87dso1295564d50.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 09:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774543309; cv=none;
 d=google.com; s=arc-20240605;
 b=lOIYTfsqMClTGeGXzAmgoCOokOMzi/lb9Jp8F3N67+4erGpHbbu6eefmWGb+8Y/hqZ
 SpzI9NfMXYfLjUNvxHbQfdq5eFc0IfSzcoHYHIGMPB63x8jZj3rcM7eXvJQ/ccWTjPjl
 rFFpNuAd94a6xVf6eAmyxagu6Nap5PfceoqjjGNn5FS6GJVe0DDqu4FYvlaVjDd4UD7E
 nIOV8Q/zA2WGNJJ6eioJCfrQEvC6J90DrFSQhvz+pc2iizIVqPCZyurPP5Bzo6vnWgRB
 yNiB3u2GtksR0InuEWSll+KLR8t1649iyhPRupLxHbiZdKabV1Gr3kvKSdvNKK6seMj6
 C48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hco7Gkc+0ixQaeRqi6QROij5fvKNeeFQo3m5kyO/68M=;
 fh=HTPvbb48pvvew7vhUKgLof3MF4iC/k4XA4OrNYti4Kg=;
 b=dzZrlIRq1oZbcWaeLi0dp/uTCONMSPK0zGMyUOXkv0tvwiuK2UDdHjoGDZyEMYr0+X
 md/BNybipBj1S5gQyVOY1ETst3lE6xk9yJr24V+radDc8NsJ1D9OHXlm6IbGvwmLIBD5
 HgeoZGRhOR6Gc9EigM2VIjlspVO4ESFeujrVuQtToQIO7Kj7BXg2lhhQrOyXrTHTvwC2
 uFiZ7QQ3+WGK5V42puqL8ZKV37vuWSN0rB2xkxOymnLCUF7HyhNu9KlLhtMjUCgB8zAp
 8YOqr4/6eT0mUZQQa0VBoWUDdBcHMe9qIeUb7khugzdKNhTdkQyZTmT//bx1NX4/fbSh
 3p3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774543309; x=1775148109; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hco7Gkc+0ixQaeRqi6QROij5fvKNeeFQo3m5kyO/68M=;
 b=K393QxCHkZLYV+hGOx+xN2SJs6wWT1r5frNmksOUReMHaLToGf1A8odddoceQqfuLV
 Q9pHuJdVJJyW14dp1q3f2UNTj6SprbbkfWqyvBwVnDaOBIR1dQ52ABdcc1Ym0rtHGRva
 z9Nvn/B1fa/uEeVE+RtQLpA9cXl2bnqibFmH8m77z3g5jyeICqz78YpsZWx0wB2XbA3v
 1Q77e2JCLDPcDQJW84PS2h6r5SeqBne6JM63WHWAhyZHi5BVsf9WFvZa8q2OkLY6WTZx
 tnbQDoLYOyAYIVkdbz2FdV3USw4SqZJ26ItiumNVoc6zYsAw4WUhq0H58om9aczeNrUL
 8VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774543309; x=1775148109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hco7Gkc+0ixQaeRqi6QROij5fvKNeeFQo3m5kyO/68M=;
 b=qwkQfMaZVXrSlVFIOpaBXiEkk6iw+jD6ffD7tM17gcJ/VDBg+5Q6sRO3y2myUDeFdg
 OSFYllGUdbJVqaLlcY3m+wd98D1nAzgWxI0+gXvVVkVMAOMIU8M1288cTze2oY+3mNFv
 MlUtKpfAm4gVzc71+Fi/Y/Jfln8FMbjbcRvQDMSD7uFe48WB19MSpCf6in37KsiiN9nB
 tdMod4hF9taX7clfgnIA2CYY1o+DOXyg4XiuBfbxj3O3nsuAFUHyy7s0Ekhb9hQIZ8ai
 Owzufh1T1FmdLQ9gY43NaCBOSPQC1yDxftqttFffcoavKsfaPnihkVug5UxtJUi4kSsE
 Ejzg==
X-Gm-Message-State: AOJu0YxZG91F1tkyZSOrw51uV1to7DDItF0tDnPYR1Kzg/0iW/Vxd97a
 /sym7FCdVsNwm+zAHGgXuJILotB5pfoznORWZehpm45Ze7XemFVJ2nUnoHgfTCrzrtsXD9nZSNy
 smH4IneZw2zrAObFtNzD5+/tJ3IEWbNRB4AyUOG+Z7w==
X-Gm-Gg: ATEYQzwsq6hf9JyL2XjLyQyJFE+dcZ26Gc5OLMnqM04r5LPZJmOYbTtKT6Vi6XhfgCY
 xKkr0z49rsrjBEuZrnmEHaF42ouF36Ne1nIwr4rkr0bGedBs6VyWPEuOD+q7j763o+n6TbzxVuw
 1ddKhUNlYZmR/ddDGwE0qckyvh4kOWzTuvzk9ohy5TSKR5vKE1KNBmsXpuCdu+YteFzesKpph8C
 ynPULyJYcHkY99kMNK00zo7A+7kJ1YKmbr9CZj4T0Tlw8FToaEBkPd7U8DxVq1PwGFWMbhLRC/M
 U5AWSTBYj1M4sqYSVe902eQQZqj45B7XePfj9hl41b2D/W7zBRPXZJWCb8b9egbFTXw=
X-Received: by 2002:a05:690e:dc9:b0:64e:8cd1:3b8d with SMTP id
 956f58d0204a3-64ee6180f36mr8139752d50.80.1774543308827; Thu, 26 Mar 2026
 09:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <20260326160033.68318-4-kkostiuk@redhat.com>
 <CAFEAcA9-j6qnKJEyk1F9Nkr0NNP9D9Oue=ptPb5py6ex=mdQnQ@mail.gmail.com>
 <CAPMcbCqzvcHU2GGKt1fjTdhY0M=6_NVD61TFoRevQ0S1ba-DNQ@mail.gmail.com>
In-Reply-To: <CAPMcbCqzvcHU2GGKt1fjTdhY0M=6_NVD61TFoRevQ0S1ba-DNQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 16:41:37 +0000
X-Gm-Features: AQROBzAQE5LjmHO11t4owcvyzLd4_ZtyCyYCvvkIUgjU_d_GsXm-AJDFs9joI9s
Message-ID: <CAFEAcA8VgyEuue8Hojp2wLbzyA+2H1EGJCsGTJ_yFRRt+Wo0RQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] osdep: Remove unused strings.h
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 26 Mar 2026 at 16:32, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrot=
e:
>
>
>
>
>
> On Thu, Mar 26, 2026 at 6:20=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
>>
>> On Thu, 26 Mar 2026 at 16:02, Kostiantyn Kostiuk <kkostiuk@redhat.com> w=
rote:
>> >
>> > Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
>> > ---
>> >  include/qemu/osdep.h | 1 -
>> >  1 file changed, 1 deletion(-)
>> >
>> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> > index f151578b5c..2f0e61ad6b 100644
>> > --- a/include/qemu/osdep.h
>> > +++ b/include/qemu/osdep.h
>> > @@ -114,7 +114,6 @@ QEMU_EXTERN_C int daemon(int, int);
>> >  #include <stdio.h>
>> >
>> >  #include <string.h>
>> > -#include <strings.h>
>> >  #include <inttypes.h>
>> >  #include <limits.h>
>> >  /* Put unistd.h before time.h as that triggers localtime_r/gmtime_r
>>
>> This needs more rationale about why we can drop the header.
>> POSIX says it brings in ffs(), strncasecmp_l() and strcasecmp_l(),
>> which we don't use, but also strcasecmp() and strncasecmp()
>> which we definitely do use.
>
>
> Will be ok if I replace strcasecmp with g_ascii_strcasecmp (and other fun=
ctions)
> in the full QEMU tree?
>
> Currently, I see in QEMU we have a mix of strcasecmp/g_ascii_strcasecmp.
> In some places we use glb2, in some libc.

Yes, it would be OK, but we need to be a bit careful, because
strcasecmp() and g_ascii_strcasecmp() aren't identical; the
former honours locale and the latter is a pure ASCII comparison.
So we need to check that that's what we want. A quick look at
the grep results suggests that in fact we really do want an
ASCII comparison in all these places (and the locale stuff
in strcasecmp can be a source of bugs, as noted e.g. here:
https://daniel.haxx.se/blog/2008/10/15/strcasecmp-in-turkish/ );
but it does need a little bit of a check of the context where
the functions are used. Where we're doing something like "check
this input value matches 'off'" this is a code cleanup regardless
of portability requirements.

thanks
-- PMM

