Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE2CC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woOwU-00053F-9H; Mon, 27 Jul 2026 13:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1woOwM-00052S-N1
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 13:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1woOwI-0000eN-Mp
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 13:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785172587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W3mGFXZevARNc878mJv43Auua4IFTv4YphZThywYfhE=;
 b=CJR5dYLnLcVYHErYGDBAts50/28pD1j53NHXhOjNr0YjdgdiW+5BegcnE86/woW6///wjg
 Yw4YySq5GFUL/NlQXEvHLNc6FvwdMUDzTjsIOFIqr8D+pcEHFfwiI3JoDkurzhYzTF617q
 mVmO33KF7lGhUElBOU50gkRefwxvcqU=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-3N6dTpZSM2e48zAsCXn3Vw-1; Mon, 27 Jul 2026 13:16:25 -0400
X-MC-Unique: 3N6dTpZSM2e48zAsCXn3Vw-1
X-Mimecast-MFC-AGG-ID: 3N6dTpZSM2e48zAsCXn3Vw_1785172585
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6648d902a6eso8552766d50.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 10:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785172585; cv=none;
 d=google.com; s=arc-20260327;
 b=WI1aOgabNR9S2kntLrsMHSDiZCbpXvS/wRH0ycykQB6G6d4yEgz7UF7OJnsgPbCGep
 WgYNey96aFKc+j0XK1G24R+ntHXDZBSWGXGIyBOqlNL1DhR9eWnG+u+cAv4OLWoqkdhH
 w/KfjdR+byW+PVrJPIGE+/SesC3KPxYNPEp5SpZomniferACP2Fp2lFgMXZK1oqhU4dg
 J/Q+uQFXlRfRN/Mg/OAYCur4d9PZvjQ+AaYmZ/9ipVFsTs+d9ssIrc28omy7miKa3MY2
 fzFGWFmuKyexyMVvadbgkugyMPIRyDYpNUiXCyeTy93FdapkajQOPC59Q3jXDjBXdXF7
 8tFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W3mGFXZevARNc878mJv43Auua4IFTv4YphZThywYfhE=;
 fh=0c5lhis1tI0Xv2/4xfQOO5bCANYWd25ch3LVSXcjlLc=;
 b=g2Ond8PXMiSKn3ewgOd9yZoO5K5MRCIHWplbl4JOaHwuaJI6HI4oBX2KPLsjUuXb5p
 XJI3UVqXXROltibblFsPSeGB1yMGCPSDN1kzaYxSXBeBQlfnt0qvoTut+c1hcid9ZUMT
 F6OrCj2sEKxN+G94TJF//9arqmjJg4WV/UAnAQSggynPCR8VsSNJlfsuI52PIqBceE5J
 p8n6ZxjQCs3jax/kT7RovnT+7/hUTMLOQF54d7tYGC2cDNZZC1LD5hwQbXzxtHyV0uBM
 YEj9cC06kIYZ+LHx7fjJRR9V5rbcIpkJDZFsS6oyrPu9fwLVe6HtN0vPvtqoIrjdrjvI
 ED9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785172585; x=1785777385; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W3mGFXZevARNc878mJv43Auua4IFTv4YphZThywYfhE=;
 b=bPccjd4HyMgixWnk5x73/Qw0rrcioiouISU62MfdfSiPONWkoDhAduUZwMB5UnIGMA
 xwciDNac5PYuOw8MLMNgiRFuP7nkF3/inMf0Wt/rIguUxoWDDPW70kRcAty81P0PlBuL
 lf/fAgZpWXWceiME3Fr36fEQXTi6DQtd5fhnFTyurwJA9/xSDCUawVxCBAEMo2aGzziL
 l24Jc4vnr0pvWKrDmlo9uHtquC84D/jL/H8jqOSxJPl3sN2DrGdkF20LAz1RNW5T58lg
 +HGV5TvYst8M3U1I0Mc+mVQRjklaTZBpvePFCuoi/a2K0jMFjL2uIePY7OPwzG3SHjj0
 K/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785172585; x=1785777385;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W3mGFXZevARNc878mJv43Auua4IFTv4YphZThywYfhE=;
 b=a9LlH6Z9dQk31HVL7IJcQDnu/QfFqZmGbOPkbKCcg0WY0kVXMeYtVsBjncP1eAfQK1
 XCT3ZCZc7KiuGtGzFAGJ5uMaE87jwxFzy25mpb3IFqq3yeokPYuq8ieCCzAhRH87W0nA
 6ezLrzlwqlUJVp6vAMDwMmhmLxV9iqwDjqXwCEvipbRfqQ57UwBtMC9yEfarvviJkWGS
 Hm4GHATQZ1VxH6LIpN4s+yrvLVB1hhyg4Qv2f5MUvoY1R+sLu9rPzf6/BjjnB4lt/jBv
 6WM57UfJ/bIfkP3fen5vaV9YfmSoaBpcQdlf5FOj1tK51Jy+HAAQ+p+Fe4a2Uy5ng8Tc
 ni8A==
X-Gm-Message-State: AOJu0YyswMk+Oi34mGLJspRqBz3r1nyqs6Je0B1hgOuZJ9tIuiiG49IN
 EqS9p1u2B+d2Jror82fR+jDKtfVoYsydXdjFTxup86i40WU7WFMR+pIRxnffrAY7NuELijV7AUW
 OWeTvXbyZGTFsxzafJNRnvxlsVmKltY928HSCIcxjFULhqT2LEKJs6ikCTAXNkwl5dO4broAfS+
 0Qfk4DeTlqTvyCf/j/ojFJYpFYpUiCUxY=
X-Gm-Gg: AR+sD13/caPWhe2u61yYqA7VIdpQZnguNKciHzEjiSUucalnckEZpS2J1prBDO2oF45
 8kJTzIu5hj48lsQrbB6URdK6ZlP1RqPRKgzESnu4Iy3StjTT691r8fq1jVrWeD3JCh4ryHfEAOK
 PHhTqYOuIlZThuK+Uu0tC5XPP18wODYEWuGqQyAUBTfxV5Aj01k2XQCNdbNd+yc3ek1Ba1ERVkU
 ig4vScNef6ZPedy
X-Received: by 2002:a53:d94e:0:b0:667:af58:8d68 with SMTP id
 956f58d0204a3-668ffdf6f05mr48372d50.61.1785172584871; 
 Mon, 27 Jul 2026 10:16:24 -0700 (PDT)
X-Received: by 2002:a53:d94e:0:b0:667:af58:8d68 with SMTP id
 956f58d0204a3-668ffdf6f05mr48336d50.61.1785172584382; Mon, 27 Jul 2026
 10:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260723044805.527643-1-jsnow@redhat.com>
 <87ik65g8xm.fsf@pond.sub.org> <87h5lobypc.fsf@pond.sub.org>
In-Reply-To: <87h5lobypc.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 27 Jul 2026 13:16:13 -0400
X-Gm-Features: AUfX_mxQww8G_sDN4rPtGqGYLANzGPwYtpBIHqm73aQVX56k63-nE7PKd7bUCQA
Message-ID: <CAFn=p-Z0Ys6FoUqRPY7d5CaN4YfHE4DUN6VLtMeWRJgUk3Khkg@mail.gmail.com>
Subject: Re: [PATCH v2 00/44] qapi: convert trivial intro sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Lukas Straub <lukasstraub2@web.de>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Laurent Vivier <laurent@vivier.eu>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Alex Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>,
 Hanna Reitz <hreitz@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-edac@vger.kernel.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Jul 24, 2026 at 4:04=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Markus Armbruster <armbru@redhat.com> writes:
>
> [...]
>
> > Converting single first paragraps is mechanical.  For it to be correct,
> > this single paragraph must actually be the overview, and not some other
> > crap.  I expect it to be almost always overview.  Not sure how to best
> > look for the exceptions.
>
> The separation truly matters only when the inliner inlines the doc
> comment.  It potentially matters when it would inline it if the type was
> used differently.

It also (potentially) matters for auto-generated docs, such as
undocumented members, return types, features*, errors*. The break
point is where these fields get inserted.

(*Not currently performed. Not asserting that it will be performed, or
that it is necessarily valuable to do so. Just fleshing out the
category.)

>
> If I remember correctly, the inliner inlines doc of struct / union base
> type, union branch type, command / event argument type.
>
> Argument can only be struct or union.  Base and branch can only be
> struct.
>
> We talked about maybe inlining return types some day.  This would be
> struct, union, or array of struct or union.
>
> So, for anything other than struct and union, the inliner doesn't get
> involved, and separating the overview cleanly is just a matter of
> writing style.  I'm not sure we care.  Even if we elect to care,
> cleaning it up is hardly this series' business.  In short, your
> mechanical conversion of single first paragraphs to overview syntax
> should be fine even where a paragraph's contents isn't clearly overview.

Except in cases where stub positioning matters, see also the former
"TODO:" syntax used to delineate intro/details.

>
> Structs and unions, however, could use an eye-over.
>
> [...]
>


