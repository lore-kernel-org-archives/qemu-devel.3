Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54897CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 09:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSARj-00079K-MN; Wed, 27 May 2026 05:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSARh-00078u-ER
 for qemu-devel@nongnu.org; Wed, 27 May 2026 05:21:01 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSARf-0000Be-Ca
 for qemu-devel@nongnu.org; Wed, 27 May 2026 05:21:01 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49056b9f04aso51353375e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779873657; x=1780478457; darn=nongnu.org;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fZc/2epVtxsSF5dBX0Uqe2VcfjpXL6wihdF61Lb5eyw=;
 b=H2tXfnH8g5AwfoqvNeCl8LM8f4+jDLjoANg8turJG+LWYblA3YPPkXvi03zXFjZdsC
 m/f6cw2uOKc+BXqPSrj3MSsKjY+hc0uWVUAMWVXdcXvZRNbnIdgJXI3OeQCA/Xxlajqd
 lhupepp6y9A2xVB+j8XX0zozwS5QecKlFD9oE6ZUavVwc9Ig5TZdsy0lxMK7aO5JyYQt
 n94DnR/RbhXqeu9QZ1hSMSdp/gsxAlS0rYP76gvCiK57GWMak6m7NGMv9SK+wxwWjIgh
 PyU00HdVgZJpr/c6pz8CDkiSEYM99QG+0OmMAVHpW8mT+CtjF2ENMprFADzgQGLHudmt
 53Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779873657; x=1780478457;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fZc/2epVtxsSF5dBX0Uqe2VcfjpXL6wihdF61Lb5eyw=;
 b=Z4WtSsr0uFP4vvsvV65peoynCIH+mj59tKwBveV5X92XCk7t11+EJ9xKiUYCt/PywO
 UiDBtDJ+69Ib3bvN+7N+PMxXFwYYL0WNJoCk2kEeKe34lS+uMNAAfRr3j6PwljRPWjvb
 HIwCjbAHcZNaTEFK+r28Hf5MiAMFOnIc2ztKzRWRZdL8O+88lvINc4JJS39hRswd1Ouf
 +54ET7CHZ5WSjg74G72RteXFQH4I2bsICLtjUEAbQ3790kG1ouzVtt+tvd3Sir/NI+a3
 lC2yXdKDpYlYGCxltRTzivUBsy7fWsk67xFkjEO6o8mqhu8jz/fQrxhbuQpJhhdNTimw
 82Fg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uTPApleGWWSaztxAUzBiX4+l8IW6Cj45DsA7+qV37pEnRu1ppA+LlmBvhd5GRVgz0ao2BNu7zWXYi@nongnu.org
X-Gm-Message-State: AOJu0Yyh11S6PQrNH4SUKe6HPwRR7nsLMQY/TVK/leJAlmty6YR91yVH
 2Qy5iz9S5z3gmsqU0bemjOjjHn8r7QCyjfQwZa710NPtNbK/SEscYR+0y2MO/2tzvW0=
X-Gm-Gg: Acq92OHvLY7Nx/33y2Z0k9sacD5/NissMB8IB24b9KIIWRCHbWSFSI5uY4Hf2JVqV3k
 72sOUNAEebLRgzYfjgQIhGHDR4eC65K2OnI8Xq9wcsouBERYTCwlwgX5AQRaxtKC2Cf+dHTvLZv
 sx/3M3vNc3Z4Stpq2LPhS+XPsLWdNei0iEfX/m+b7J1uYPf8/HB80mhnS4ujXR5Lna9x6MbY9u7
 nkNLecajqE9BoPsIMYUIfd4CzgnNualgudz1x6e6F2Kc1uwnu9XO5UWMo/AvtVUVJpSoHeA1XYJ
 F9hvbjg0XYO99Qt2zZPasyhfrL1oxt3HWK3fZ0ft/PJNNQKWC2Ch2+WaVopFwMSnsXgjTPuQ7Hk
 40MdzBa1dzNY+jsTp9Wn7Y3ax+gPL28k7zpmOW8+zVfmYYdBrfbNGkPSWShdMk9xHb4hFfiwaJt
 8fz59Nw9OgDpcXpy8pNDb/g0UodTIluzmm/A==
X-Received: by 2002:a05:600c:4f0f:b0:490:50e4:7224 with SMTP id
 5b1f17b1804b1-49050e474d4mr354362315e9.3.1779873657420; 
 Wed, 27 May 2026 02:20:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454db285sm356591905e9.5.2026.05.27.02.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 02:20:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B28E5F7F0;
 Wed, 27 May 2026 10:20:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alyssa Ross <hi@alyssa.is>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Demi Marie
 Obenour <demiobenour@gmail.com>,  Albert Esteve <aesteve@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  "Daniel P. Berrange"
 <berrange@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake
 <eblake@redhat.com>,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Elena Ufimtseva
 <elena.ufimtseva@oracle.com>,  Auger Eric <eric.auger@redhat.com>,
 felipe@nutanix.com,  Jan Kiszka <jan.kiszka@web.de>,  Joao Martins
 <joao.m.martins@oracle.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  QEMU Developers <qemu-devel@nongnu.org>,  Richard
 Henderson <richard.henderson@linaro.org>,  Bernhard Beschow
 <shentey@gmail.com>,  Stefan Hajnoczi <stefanha@gmail.com>,  Thomas Huth
 <thuth@redhat.com>,  Wei Wang <wei.w.wang@intel.com>
Subject: Re: vhost-user(?) breaking changes
In-Reply-To: <87mrxlgt6u.fsf@alyssa.is> (Alyssa Ross's message of "Wed, 27 May
 2026 10:20:09 +0200")
References: <875x4fmzcv.fsf@draig.linaro.org>
 <96181e0d-4c75-430a-9b80-9d8d0eabcce7@gmail.com>
 <CAAjaMXbFhtiHgiUwmJFXti25+vXRebjtaD6fFD+GkOHsDny=Bg@mail.gmail.com>
 <878q961nkz.fsf@draig.linaro.org> <87mrxlgt6u.fsf@alyssa.is>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Wed, 27 May 2026 10:20:34 +0100
Message-ID: <87y0h5xl7h.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alyssa Ross <hi@alyssa.is> writes:

> [Trimming CC substantially.]
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>>
>>> On Mon, May 25, 2026 at 5:03=E2=80=AFAM Demi Marie Obenour
>>> <demiobenour@gmail.com> wrote:
>>>>
>>>> The first is whether vhost-user memory regions
>>>> are guaranteed to not overlap.  I sent a patch in
>>>> https://lore.kernel.org/qemu-devel/20260522-vhost-user-dev-v1-1-b31646=
cf19b8@gmail.com
>>>> to guarantee this is not the case.  However, this is technically a
>>>> breaking spec change.  The virtio vhost-user device I'm working on
>>>> requires this.
>>
>> Breaking spec changes are always a red flag because of whats already
>> deployed. Are you sure there is no way to make changes optional with use
>> of feature flags?
>
> There's some nuance between breaking changes and clarifications though,
> right?  e.g. 97f24a0496 ("vhost-user.rst: clarify when FDs can be sent")
> tightened things up, so could also have been in principle have been seen
> as a breaking change, but not practically.

Sure - if in practice we are encoding an assumption that wasn't explicit
but everyone* was making anyway I think that fair.

> Are there likely to be devices that use overlapping memory regions
> today?  Would we expect that to work?

I personally don't know - and I didn't feel qualified to opine either
way. This opens up the wider question of who would know and are they
following discussions about this on qemu-devel?

For that see the other thread I've just started where you and a bunch of
others are CC'd ;-)

*everyone - do we have a comprehensive list of who implements vhost-user
 these days?

=2D-=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCgA1FiEEZoWumedRZ7yvyN81+9DbCVqeKkQFAmoWt3UXHGFsZXguYmVu
bmVlQGxpbmFyby5vcmcACgkQ+9DbCVqeKkTTrQf+NvYrK9nKnEvqM5cJwadRVyIy
T+qXEE8++L2jTeyjyap/XRZM2ng2oNt4zwnV0tSSzJ2xd4KeLMYB5WrGhxzo5Ki3
Vj2t8S8vjtL+4/Gb9Eeh6uZzRdMyPuPr/JTia0FOqV27p4SWEdHgug9zlytLUNKv
KfqPQau9ItetzfwFkI0Qa1wTmK6wtD668ft4L/g8raS6RqgowGv57dtvVM2cfhZC
bhKlELEAtxAn/QsHYQ7mmaj0ZuqCGRIKghVBTww1rGWlqWW8ck++g9RMr/DYJh1j
tjEaGvvSlCWayiIFaY+Dq5zDNrkAHj1aygP/Qr+xLWK+whTgPiROmbUoVj1Cxw==
=RlWk
-----END PGP SIGNATURE-----
--=-=-=--

