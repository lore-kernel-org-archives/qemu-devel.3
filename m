Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F28E81BD3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 15:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpTI9-0007Nw-Oy; Mon, 09 Feb 2026 10:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vpTI7-0007M6-Li
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 10:35:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vpTI5-00083Q-7S
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 10:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770651306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HkkqsGe2lUfdPf4uwuH3biqh+Xm+JhrEt/KOrYTBOXw=;
 b=F6FK3EbKgyImy3f2wo8G0vxWHHW2mnsPnkFTVvBIsGMwd//sl4mq6nOvuGdRorVqVJX1ZJ
 FCkmr0B54X2gRivNsbMjK87XR8SRPYN+gkugaC2raahOqJEyr8uK7ftTz60AD1XEFlQTSk
 XJdJLPRwa2CEi7gtP1lTXGhgpHAsLd0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-yopxXfcmPgmXujKCvgY1VA-1; Mon, 09 Feb 2026 10:35:05 -0500
X-MC-Unique: yopxXfcmPgmXujKCvgY1VA-1
X-Mimecast-MFC-AGG-ID: yopxXfcmPgmXujKCvgY1VA_1770651305
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7962e684413so35370547b3.1
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 07:35:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770651305; cv=none;
 d=google.com; s=arc-20240605;
 b=PRyXdqCeB8e5ZG5Q2IEHW6CTlul6QPift0gw8BLLzi2W3g4cK7aTgio3OQPFU835gK
 2eyfXpiIZ7obL4MSv4RRmObo3lfZ0dSNnlukukKdRPPqUqzoWn8arfUQmidTtSXwj8AX
 aTX1Wv7OoooVthyZRAU4wxgqrvPfrAE0jVX1xcDKPdkVg3Pw4Rzx6/NCzTxEJNSJ2EiD
 w1iY/rTBlfXAr9stK4PXw2q6mZjnDVLdTz/s1FNyOxYdLAgFavumdjNvEArYvLd/677H
 TnhZXU8l8wJYvLHlth87qc+Ea0tMhUwALR2oKL54MN1wvw8A9H8wxIEgQsP1cKPkbhjd
 vwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HkkqsGe2lUfdPf4uwuH3biqh+Xm+JhrEt/KOrYTBOXw=;
 fh=f0DsqyzYnC8d8x0wCFNQTT7sVRqvPmtvFhArQ12Mx/c=;
 b=JjNZ/cD4LlPt0dtG8IaNib4EtkzpKBXn4PJI+PqN8bxs55p2C54jz/qlcBqo3yryoY
 5YXhsogH5CR4NR8PXgpwoqnMaI/APTyM7XubzEOjfx6pOuZ3uycK7lHNjLQ0/dPSBzN9
 6SwlWMEdod/Yy4085RhPpEYHS0GMAxxElmIyPXKlPJcT2SdjQ0dWJKxfRL9DWO7prL71
 oM6kmjO9Sp68mWBrqYWv5LWW+Zo9P98B6KVk9oCCT5sMPwsylKReEc31XWw7nzk7leka
 TfnD5aNpkwD1Cb3Np3yna4cAI28WZDSzW3bG9iCWinAJoAplFUN4uimfHzHatOYTpFV/
 xspg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770651305; x=1771256105; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkkqsGe2lUfdPf4uwuH3biqh+Xm+JhrEt/KOrYTBOXw=;
 b=hrjmm95/EPmnwgAv+6mCbLIu9Q2x4kS1nSdvztNoXJ8bajseudPWOaSF+jdPM2s2gR
 tXcoXSW2qSxz8wGrCqvegALlS3dKJzxDmJu5aczHv2AvhDdzTS/Ls2BZ9cUQp0raapsV
 aTMBVNWS+O6ow88Qu+DfzaNpk6lClOdELyzDwbM1EJ+vbNzr+Fk8Stdujn0XM1j86gAo
 FjW7CF4a/TE0M9wh6pBQX8wbVgzcS1vAjvGm7IDZpsBUB+lM6kdPeX8lRm0GIYYYKHnJ
 /35ZshwoFQMribYnvwKMAYJnjTTXRzLA98FfkRmI8DdmKDdDhXnxIKzecd/TuMPuvwl2
 R6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770651305; x=1771256105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HkkqsGe2lUfdPf4uwuH3biqh+Xm+JhrEt/KOrYTBOXw=;
 b=ka62Bc/q00oms1cdpouYTqEDsSWqOSoFdQQLsY08I9cvDaL9QP6+0EjPvjqotmUnAH
 m+fC/KZK8kV4KiaW7meeUB3dYqJjmHGMd2B8GlL/4hJHE/mtJ53LQkvZ5nZmbb0oWxO8
 QI4jVGrFF4Kt7s5bA4n5mhhpcqc6J4xXC8iOEGfzvAOQGMd2o0lrh0bhqyhCe7oHaIST
 2qIO20U0CV7f4M7dhUYM+ms0Ft91r3Nea87FCyuikPTqL7/QLWiUhRzWr1vwnypp8yQL
 X45RR/FHMP85UNXKCI2WD79yi4sk26nA4N6h+8w1GqYW/O+GZMySyWJPyq6ak2RoYS93
 x6jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrL8kfv9OcEgYYEh8R2dMCYgmsd9TXTHk6krj/UVLiCHZA5Qh2J7v+OWC2QRNXFPQvgaRSmmLCsYnY@nongnu.org
X-Gm-Message-State: AOJu0YzgJw0Z6I+XXE2M23LpN/hEbygY41Duql7oABBJ/yqp6AuT5WRU
 NwqeT/c6bVlhqRjgA9jQy/5Dd/GJur1H/8gmJ+8ajNosNgBK25fzxp2RxiXvgkMEo7BQI7g8d1s
 NeBbfzDWOjfanOR2IncmH1B2JupzsWvSW8GIGBuFmLkAJNUKPVIdkiZd0b0m/tElY7wjYF4KgRF
 AHu7ZtFZKj1HDJ7G+4nbdly5Pg4iEXNi0=
X-Gm-Gg: AZuq6aIAeNWERA1aRgJ3BZsvfPh6MBFBBt2RmjdyJHS+jXxGXtzWgSmOshiVuYBsu/+
 MM828vJQ21KH/EsGs52ZlP0wJ1+CdhwtxAyDLE9+XNTrgZGp1vGEgn0PyYAwaA+w5JUk7TNvw8+
 zDndcfpC61Dlrz7smKBa7LUn16+irTeRaOXVncdfGSz+B9i/AB3szEBB1E4Evc81AHi0e4ox3oG
 G17KwXH6/i6zVI8iKJQif5BAQ==
X-Received: by 2002:a53:acc2:0:10b0:649:e546:62e2 with SMTP id
 956f58d0204a3-649f1f42018mr8756743d50.44.1770651304700; 
 Mon, 09 Feb 2026 07:35:04 -0800 (PST)
X-Received: by 2002:a53:acc2:0:10b0:649:e546:62e2 with SMTP id
 956f58d0204a3-649f1f42018mr8756715d50.44.1770651304174; Mon, 09 Feb 2026
 07:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-12-jsnow@redhat.com>
 <CABgObfYtKr88BvhPUL4KfX464u=T4d7BP70XRLMdn28sXSKU4g@mail.gmail.com>
 <CAFn=p-bq8siBh0f2bs=x6ZeHQn6y2_2RuwKVnVrH+CvOTe-4ig@mail.gmail.com>
 <CABgObfYA12a08yXPsn84hX8dv59x7DDDLW0X3u5Cre3od6iMFw@mail.gmail.com>
 <CAFn=p-aforipvpRhUyLbStYPSRC4Pc0Oadcq8HzT7GzEGL+BnQ@mail.gmail.com>
 <CABgObfYOYykc+af+HawH9-vVj7vpUikrVPYDmY-ykD8cEVv-TQ@mail.gmail.com>
 <f26f58c0-cae5-471c-a12c-0a429b8875cb@redhat.com>
In-Reply-To: <f26f58c0-cae5-471c-a12c-0a429b8875cb@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 9 Feb 2026 10:34:53 -0500
X-Gm-Features: AZwV_QjKCk8I_YLPFWlmUMWqrO83JQSp4rExiBMGgjBylPq24qAxMB6_JThfsnA
Message-ID: <CAFn=p-Ydefd1Ej0r7YZo=1Rg7byQoF7aCBZA1_H47EqZ9APpow@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] meson, mkvenv: add qemu.git/python/qemu package
 to pythondeps.toml
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Maksim Davydov <davydov-max@yandex-team.ru>, 
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 5, 2026 at 2:52=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote=
:
>
> On 04/02/2026 18.53, Paolo Bonzini wrote:
> > On Wed, Feb 4, 2026 at 6:03=E2=80=AFPM John Snow <jsnow@redhat.com> wro=
te:
> >>> Use whatever is in bookworm or 22.04?
> >>>
> >>
> >> OpenSUSE Leap 15.6 and 22.04 until April
>
> I don't think we really really have to support OpenSUSE 15 anymore, do we=
?
> 16.0 has been released since a while, and we state that "The project aims=
 to
> support the most recent major version at all times for up to five years
> after its initial release." - and OpenSUSE 15.0 has been released more th=
an
> 5 years ago.
>

15.6 was released much more recently, and 16.0 only came out recently,
so I think we are still on the hook. However, 15.6 does have a full
set of Python 3.11 packages, so it doesn't matter. 22.04 is the
blocker until April.

> > Technically for OpenSUSE we would use py3XX-setuptools;
> > py310-setuptools in particular is 67.6. But yeah, 22.04 is the oldest
> > at this point and we might as well pick that one for our accepted
> > version.
> Sounds reasonable. But in case it's causing trouble, 22.04 goes EOL on
> 2026-04-25 and the next QEMU release is planned for 2026-04-14, so IMHO
> that's close enough to at least consider to ignore it?

Not causing enough trouble to drop it early, we can give it one more
release IMHO.

The real problem with mandating certain levels of Python ecosystem
packages right now is actually the large number of cross compiler
containers we are still using that are running Debian 11, I have since
learned, so I am dropping the suggestion for the time being until that
can be addressed.

>
>   Thomas
>


