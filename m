Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D957CCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 08:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utMW2-0002Xy-U4; Tue, 02 Sep 2025 04:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utMW1-0002Xh-Vd
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 04:37:22 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utMVv-00005j-TL
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 04:37:21 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71d6059f490so49501257b3.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756802233; x=1757407033; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZwuSFY+pTsC+w5AU4jPLpDL5qHDH/HL1FzNoAKfG6g=;
 b=gLujFfPjVJsS45r04JyzrAwfgsn1JLiZp9x58d/+VLZ+E79HP09tFP2+vaWgdnWlWU
 tAicRGy8DR0/vVnmxJI7ktJRTUebLaOoilujx+BkFZDjFLQoncpxgOtaIy8/VpMJhy8Q
 9eOu5/sMvxfPK3RgaqIDtYcuAEP0UZCyKlpVY1t9xkiAJgqfb09YlqOtoRD/wbVZeZaq
 R7l/5KA5RdddEnuK71AwHMO0lYtXQPqUqZqBI+oCG8dQEtahi63PdsfG2xoEr6uq0r2L
 BkqaNkV7KnZLwgoremEuOceOk3Bq66EkX0Ipf0++yJHcxlGgL4gITCImRvUdxlDN68q6
 ewHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756802233; x=1757407033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZwuSFY+pTsC+w5AU4jPLpDL5qHDH/HL1FzNoAKfG6g=;
 b=Zrsi/sS9Etuvli9Ar5vsiuXqAaLdXPYolqD3eA83dq/VfIlapjx/2sFMfemZxg8Bf/
 +lIRYO7Fk2l9V8xhPyQIpxkBvHhxCv1WoExtYPt93vpX4+u5YrjZQCHVPsz1f2ga9ZlO
 0EIsKQXDZjWHA5Bs7qjTfm9BQDi2qN5q4ejTxeSVPlJqXcA1DnfrPthAV8mUga1yluJl
 ftsao9UYpDWhV8ygSQrsepJjsvUEmOswfrr3o38a7Qjg0ePk4qy1d1ilZTEo9A/+Y0Xn
 Cu1dX2yOIbqEoZ5c2xxY2SeXVpkdgix3MG/U1FlX9TZNdprjzmj8q7DKXL/PYoJ/SDPs
 C4zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBSmlbv1rLAThIIasWymWRYuDygl+MBUBa8dnhANu8W9YIbCjxnbljaKhSbq4BnKGs6rLyW2wg5kze@nongnu.org
X-Gm-Message-State: AOJu0Yzs2NfLxsrLXbwH+Um5y9tzARYNZ5TfI4BmYsS+d/6nAmyeCZsA
 4NWRieMxi1TG7WG2lwvwn7VPd1bU0FjWd4vrNpbsh2ME4yMJMpD+mFx3ASsKmwzujh1sektBKxY
 cO4EwNj89W9mpqAkAK8f2MlhQS6ZHv7iwAPRpn9pdvw==
X-Gm-Gg: ASbGnctyq+8mdpEyeLJvRrNm2HiZM5QlYPeolYoA0f+rOCEkx+ksWIlc88/OmJVJUll
 9zOcyum2B6GsFQhME+YIuyP69/ySfFBJsYc2Z1Emagyc4uOa1aU5bl35DbuNPKJZXEH/rHaRoeL
 GMOAdW+Q8yhN/FloNsEnd1BtMnNOM+Eebja0A0BhxKHpz4twUtzgk89dC061rTCqG2PFExzOX5f
 NAVY8lqKJbY6Yywyaw=
X-Google-Smtp-Source: AGHT+IHvQxyGulWY+jSAYvzI+GjUsPPaeULmRNYWOnRbQm5AGJ/xBnon+BcqRbxLtqmuKXLI6rNzYSxfppUW2RZSjOE=
X-Received: by 2002:a05:690c:9416:20b0:722:7a7f:5381 with SMTP id
 00721157ae682-7227a7f6e8cmr98264057b3.14.1756802233489; Tue, 02 Sep 2025
 01:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250823150321.135527-1-osama.abdelkader@gmail.com>
 <CAFEAcA-GpC3ouaXTQ18VhcY7c-jXK_SF0MLiCMFW471U5Cqr9Q@mail.gmail.com>
 <874itm2joo.fsf@draig.linaro.org>
In-Reply-To: <874itm2joo.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Sep 2025 09:37:01 +0100
X-Gm-Features: Ac12FXxpBeebNS8HOKvinRdI7P3NOo5WJmhGvq4kMy0irumov-naOnhGIuK2PnQ
Message-ID: <CAFEAcA97ExN_f7WY17gn7uwHXmJkyRseRRucwJqPD85mvdK2rw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/boot: replace fprintf with error_report
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 1 Sept 2025 at 17:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Sat, 23 Aug 2025 at 16:03, Osama Abdelkader
> > <osama.abdelkader@gmail.com> wrote:
> >>
> >> Replace direct fprintf(stderr, =E2=80=A6) with QEMU's error_report() A=
PI,
> >> which ensures consistent formatting and integrates with QEMU's
> >> logging infrastructure.
> >>
> >> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> >> ---
> >>  hw/arm/boot.c | 22 +++++++++++-----------
> >>  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> >
> >
> > Applied to target-arm.next, thanks.
>
> I didn't see this had been posted but I did a more extensive clean-up
> here:
>
>   Message-ID: <20250901125304.1047624-1-alex.bennee@linaro.org>
>   Date: Mon,  1 Sep 2025 13:53:00 +0100
>   Subject: [PATCH 0/4] arm_load_dtb cleanups
>   From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

OK, I'll drop this one and take that series instead: it
does look like it does a more comprehensive approach.

-- PMM

