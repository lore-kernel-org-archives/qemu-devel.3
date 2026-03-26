Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A50110AB808
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5pzC-0007Os-RS; Thu, 26 Mar 2026 15:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5pz9-0007OQ-DP
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:03:15 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5pz6-0005wW-TB
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:03:14 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64c9ebd1369so1332251d50.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 12:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774551791; cv=none;
 d=google.com; s=arc-20240605;
 b=RUORygjQzoq3spOvl5t6BE4kRrZXBH8W8qShWPSAsv5DalJ+zcwuQr+s3csJjpgzC9
 ort80NOUhRJF+4x2G0ERubxtAkUR8EaMkRI8cX0bJNMxpW9Ly3nrv6P1pUHpeKdn6C+f
 u5NQrDApPNlGf3LN9huKLsX6hi+pnpzcGg0iI6843CzT4rfbkGRDAKTl2yuiJ0ssK/q9
 7URdy/jg3gL1jdSIPUxFMXtFvgb5QQcyZFRMPHnxWA5tDtnw0rRVK3nAK+vuVM20FTGG
 D8sBlXMlyMmZtbw3ckQ3ISrCtoA53TeTnu1F4l5Lo9IVvyxruF8KHOhM2+KlfPnGXgMf
 1RGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ML3/v8o7UY/PYCza4nQa1LB5gxOq4O4wOTil8s4joU8=;
 fh=HTPvbb48pvvew7vhUKgLof3MF4iC/k4XA4OrNYti4Kg=;
 b=CUSB6cbGeEDflMLWaPUi0D3VbBEEQoguSVuxg+gdSdbl/OU09/sY/iWp3AW4sI/ynE
 Nx+llNHZzpXW9U5pf+XFK9Yy+bJwugJzb/o4d9EZyILtg6j4adkgeC/cRR3e31DRPS2x
 qKTrjAcljr9K0NzzNVDUw4ud6qvcfMr+PhpbZaEDE1V5shzR5kcRIk8/rnSqKdm1Rv0B
 Xi3drtkVHiT6x+MKdqxdGPOi3A7ddW5An9MrWGwLjOJ9nx1zsUzxaVrFy0Wi1u6M+SXR
 UPltk5wKfCNpnDTSZ29m705c5WYUB4o9dSSJJG4ppX6hQLc+abiqje1ZCijX1Icq+L8S
 yNgA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774551791; x=1775156591; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ML3/v8o7UY/PYCza4nQa1LB5gxOq4O4wOTil8s4joU8=;
 b=ECya8qsU5QtlCcGQWVXkZR9z+Ee8JWRR5Mg+u6UDfoSN1VbdIiMxjKQJQRW6DMpVnP
 dFzvD4BNV/TnKej5jfEsclOcXJqojLg4u2W9yAxAiftA0ZOSToDnmijmzxbOaOvAY/rT
 ei+vu0o59CSoECqFn6d5hnQGxqProhoA3gAX+p+tS6/v4oP7GmwOT/aM0yOjms2qRq6R
 7zVQdG5++oRvPSP+ByIQOZCkyMqUBK4sdRlmOjEkjqQh3GM4IqB0WYexgWEMaN9RIU+W
 GbTyiIT3LVz8GBd8DRw5r9qELgQWV/pGcbxVmp76RqGVlGzjPGwfEacUNcUJ3py3kaG3
 E6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551791; x=1775156591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ML3/v8o7UY/PYCza4nQa1LB5gxOq4O4wOTil8s4joU8=;
 b=SN8lasp+ZOxqN7+Ef8fH/0OzRb6+bVQj4/3ffauWKrsT4XPiTF8Kemi6uwq65WskD9
 O2qS/z2PEpGi0Liw4cNZi8WZ3Q5elVbgTHe2kx3GIN7lFCEgBwA33jYCjV4k1X4C/gsM
 j1mwDEkD08431dAo2dmKe2i5LeCkOn9AFAGfHJCiWQ4JMjeyAQhQxLzfxFzrd/t5rizn
 c7toQbv/RWqBuPaVD7A2O2EnWVrJ5td1ANOYY9p6I9Pd9EH0Rdd4KVhOLUiSKC+OEduJ
 RhAuPIyUzc7D0CF22VGYCJSlRO+gNL9H57OEnB4yO9n798HFATDDmHmBfLgKd9MW/wVX
 bJHQ==
X-Gm-Message-State: AOJu0YxgwONeGVrytIpqRocjlWdPs67KkGtDvp8zXwW+ZGj4HPNa9ccj
 gEBjcX7ueq9TewqXUKIv52KUvFrKSFW0qvMRvmT8/DBvNq+OoANK8ahmzWweKiZLG6irKW/Phpz
 PSEvjI5G2AN+iScAQn1z5eOFl8PdBtlCfMXkr0IWjqA==
X-Gm-Gg: ATEYQzzjwM3ikLZUE9t18Ms0S0ATu3LuBS5w59xHIsX1aw3yRcNLd86mNzqKXnE3ErS
 O/Tm08R1vDl9xqYLlW7qawA2dSRK3xqPGvVXN3N4r8r+14z+0EY5n0meoYYxLB2tAYJlvrDdvrR
 IPyXf5MFStZj8KJE1ttHkpRkXr2hDeQfqW8mIQJCzVndWmjM6ShbYOUkC+jbjE259WEPE3pkbzR
 Qw3LIHBnG1XAiAGpq/GMQ7EVngEosZtclmpWdzdNIbkBC1kb1j8AE46KNR1pE4l4lYJlgaCPu4M
 jlQxFM0gylkP/t5TXNf5wN/Ip4LFUnzv06OW6nGxD0gF/A5/lREh8i93DMrehTSIAPc=
X-Received: by 2002:a05:690e:13cf:b0:64a:d74f:258c with SMTP id
 956f58d0204a3-64ee607614cmr8555897d50.5.1774551791214; Thu, 26 Mar 2026
 12:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <20260326160033.68318-4-kkostiuk@redhat.com>
 <CAFEAcA9-j6qnKJEyk1F9Nkr0NNP9D9Oue=ptPb5py6ex=mdQnQ@mail.gmail.com>
 <CAPMcbCqzvcHU2GGKt1fjTdhY0M=6_NVD61TFoRevQ0S1ba-DNQ@mail.gmail.com>
 <CAFEAcA8VgyEuue8Hojp2wLbzyA+2H1EGJCsGTJ_yFRRt+Wo0RQ@mail.gmail.com>
 <CAPMcbCr+hqVvfsm9t33Rkd47LjkYgH-e6A-OHpksvb+BvMiUWw@mail.gmail.com>
In-Reply-To: <CAPMcbCr+hqVvfsm9t33Rkd47LjkYgH-e6A-OHpksvb+BvMiUWw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 19:02:58 +0000
X-Gm-Features: AQROBzD6WrvJWaGEldmP5a86NnIzQomFNBbNImP8nKSBpGdtx_J0WTSUtE1DXAs
Message-ID: <CAFEAcA80iCqRTm7+Fv7pJZ8dHdKb90zwecDCiUKZ+yzcSu2JUg@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 26 Mar 2026 at 18:26, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrot=
e:
>
>
>
> On Thu, Mar 26, 2026 at 6:41=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
>>
>> On Thu, 26 Mar 2026 at 16:32, Kostiantyn Kostiuk <kkostiuk@redhat.com> w=
rote:
>> > Will be ok if I replace strcasecmp with g_ascii_strcasecmp (and other =
functions)
>> > in the full QEMU tree?
>> >
>> > Currently, I see in QEMU we have a mix of strcasecmp/g_ascii_strcasecm=
p.
>> > In some places we use glb2, in some libc.
>>
>> Yes, it would be OK, but we need to be a bit careful, because
>> strcasecmp() and g_ascii_strcasecmp() aren't identical; the
>> former honours locale and the latter is a pure ASCII comparison.
>> So we need to check that that's what we want. A quick look at
>> the grep results suggests that in fact we really do want an
>> ASCII comparison in all these places (and the locale stuff
>> in strcasecmp can be a source of bugs, as noted e.g. here:
>> https://daniel.haxx.se/blog/2008/10/15/strcasecmp-in-turkish/ );
>> but it does need a little bit of a check of the context where
>> the functions are used. Where we're doing something like "check
>> this input value matches 'off'" this is a code cleanup regardless
>> of portability requirements.
>>
>
> Is this ok to update several strcasecmp usage in one commit,
> or better to split it per component?

I think I would split it per component, because the people
who might care about it are different in each case.

-- PMM

