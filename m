Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D115CF58FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 21:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLpS4-0005On-PR; Wed, 19 Nov 2025 16:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vLpRw-0005HW-SZ
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 16:10:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vLpRs-0005QN-W3
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 16:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763586640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3G/yMSmeiaHu0ai1qgXat33N91OmESjwqHGusqfpqPo=;
 b=SlN1ZapPnb6tln+VQbsnpN5k8TDwFWwj/TgO5w+kNzYRfgtyMtgVEoFWkOO7Hq4Cb+0TWc
 DUJ2a8eGclp/yRUqHPgx9n/zwnhoo7xVmW3cr7VL07+VM8WViHJQcNt/ZkxvvFzNCggC9L
 qBlKzYYurO0TBRV3Qz2sTkRq8M37XWs=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-l6BwxLrbPvyvKW6SuolYmw-1; Wed, 19 Nov 2025 16:10:39 -0500
X-MC-Unique: l6BwxLrbPvyvKW6SuolYmw-1
X-Mimecast-MFC-AGG-ID: l6BwxLrbPvyvKW6SuolYmw_1763586638
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-63e1e96b6d3so188597d50.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 13:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763586638; x=1764191438; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3G/yMSmeiaHu0ai1qgXat33N91OmESjwqHGusqfpqPo=;
 b=J7gLtbdQFipURNY5hpbqRgMy3tbhM2lg4yZWd3V3nxAgnLab+CUHV2O8r5N+jVl6wZ
 fDc8TRTzBH13HZvIKWrmOZGqWXXOmR/7YkMOa53jxs2VHFoIUMctFZwe9wcrqLssP9td
 vSIjJhaBHM/PPZwRoTlcuS/lqPoT9MNbSzWzaL/GHQl92Xkw5UbfnNDdJpPuoOppTcbv
 u3gUM1Hm79PBx3BwRawqZINiJji3YMGwBb1IoYMlwFBjELT7Ob7/gIgqX63l8tyDMbEB
 obJoe/YDh3oYg3C79sP1VOpevLYBEsrR152eWOOIdXXdIbecYmnMi7v1qUlLHCjL9x8M
 M/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763586638; x=1764191438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3G/yMSmeiaHu0ai1qgXat33N91OmESjwqHGusqfpqPo=;
 b=riiDJWCNYapD4g+6K+eWpIhlDvX2gHRecJWsqJ/i7QdmpV2tNkib/ploPcMwm8Wr1J
 4D4Kfr1Ef80sNlOSeedX0I0pG/ybirnhS5cMb+l9c1PyVaNiqARbYsAcNPxIkyTMczNm
 JmiB3Ppvn761cRDgfRsoGS8JPRBgBey5WxLBeqiJZ7obqyjb4u7vF1VFbhOouzyPgjoE
 iN+H4E+mPo8GbR53dyD3uZ12NtlT6X9/w8FWOdy6yWipaUqkq56eZU3EBsWr6oAPJUhY
 OMHq2zKT0CML+rPhcEogOqr+2O8Ytrq/yERW/lL/k+q0JAwo4ZlGAT7TpUP9rWnp3nMB
 JeZQ==
X-Gm-Message-State: AOJu0Ywo2mSmVbOLU2b0CkNKXUpeFoFEQLex42iJrIUjaop0LE900Umy
 ISmHyQPIMn1THQLY0FjJ7Fay2YA5W9/wYTf71KTN89k9w01hnPzXw5ANwJePYy3sKNCROfGjlSU
 zSwTlsEpsTYuSgJPBelnAPgBK4rnib3R8uFPTsakYQiuvX7HNWJMIVujpPfIBxlgbFgUyDauh3g
 Gh+3PxUJYJnhH4gAQ5FrcGaUrOVmmUmVQ=
X-Gm-Gg: ASbGnctDqiGNYrj6vpKpj4ar1u/6m3MLYD2eWIRrSxOJ9W0UUtw/wIMAOY86vaVzsYG
 VZ7ol5n3W/5R8xsCjEayQsjHCIsC8FFMJXlvVI3L8vezs8rlPgkqKzTrVK6hlAHTujumG60QzMn
 EDoo4pxl2A1OI/hSODBiNAg33NI64aHhRleUgYHfzYkrebr+ZlH4OvWztnbMKxI3EZexHmIjqzA
 Qwsid4E6Np6rhjqKwpNTwf5qQ==
X-Received: by 2002:a05:690e:c48:b0:641:f5bc:6972 with SMTP id
 956f58d0204a3-642f7a48f1amr494638d50.78.1763586638544; 
 Wed, 19 Nov 2025 13:10:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFILDbGodEY4MaNpvlCaB40hcYMrlYDyP367mQjISYsPSJGRZgTe/K39kCpOXxJlEjLvOatGHeRzZBDSi1DVBE=
X-Received: by 2002:a05:690e:c48:b0:641:f5bc:6972 with SMTP id
 956f58d0204a3-642f7a48f1amr494616d50.78.1763586638211; Wed, 19 Nov 2025
 13:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-6-jsnow@redhat.com>
 <a3b2509d-fa97-4627-ab88-7e0175c6bae1@redhat.com>
In-Reply-To: <a3b2509d-fa97-4627-ab88-7e0175c6bae1@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 19 Nov 2025 16:10:26 -0500
X-Gm-Features: AWmQ_bnhykGsrC8AbvxglfuiEJLR6gw-Cjwa-LrsWVtIv4HWgMSPu3LnnVGttAE
Message-ID: <CAFn=p-aszQ-+Z+eri4dohc_-7SxaSEy_uLu0igVwf85GtQHomw@mail.gmail.com>
Subject: Re: [PATCH 05/22] python/mkvenv: bump 'qemu.qmp' dependency for
 testdeps
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Nov 19, 2025 at 4:19=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 17/11/2025 19.51, John Snow wrote:
> > First up, use the newest v0.0.5 instead of the older v0.0.3.
> >
> > Secondly, the use of a period in the key name does not behave as
> > expected when installing and checking for dependencies, so quote this
> > string instead.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   pythondeps.toml | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/pythondeps.toml b/pythondeps.toml
> > index 98e99e79005..1657953ff65 100644
> > --- a/pythondeps.toml
> > +++ b/pythondeps.toml
> > @@ -32,5 +32,5 @@ sphinx =3D { accepted =3D ">=3D3.4.3", installed =3D =
"6.2.1", canary =3D "sphinx-build" }
> >   sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", installed =3D "1.2.2" =
}
> >
> >   [testdeps]
> > -qemu.qmp =3D { accepted =3D ">=3D0.0.3", installed =3D "0.0.3" }
> > +"qemu.qmp" =3D { accepted =3D ">=3D0.0.5", installed =3D "0.0.5" }
>
> Question from a still-python-ignorant: Isn't a dot in a python module nam=
e a
> bad idea after all? I mean if at one point in time, the "qemu" module com=
es
> to live and also contains a "qmp" submodule, isn't this calling for troub=
le?

The "qemu" package that lives in our tree is actually a namespace that
contains several namespaced packages: qmp, machine, utils, etc. It
just so happens that the internal "qemu" package comes along with
"qemu.qmp".

I probably ought to update that placeholder qemu package and have it
at least pull in qemu.qmp as a dependency ...

>
> Maybe it would be a good point in time now to start populating
> https://pypi.org/project/qemu instead?
>
>   Thomas
>


