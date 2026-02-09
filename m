Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4282E81BAC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 12:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpQL4-0002iA-TW; Mon, 09 Feb 2026 07:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vpQL2-0002hl-HY
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 07:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vpQL0-00008i-Kq
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 07:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770639955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3YA2rhIJPzb0gHlkZF0sV50+XzXC6raUhE3rMw9/FDE=;
 b=eDxvGe4GMCYLUhpZW7MsKfNWpxjpTpPp+oT6iFabY5ogZy8rW9WilnlVrjSbZWsgB7LXr9
 RWGzuBSRt91a1Eg37YJPvmI8iHjZKYYu8wNNZY1oa0cwhVuZOUmWtc3/XSiHDVUwzpHzuN
 7cgXy65N5pGGC6Sw8Q+Cgm3IXnbMZx0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-gROdxjv1PpGZWR9FINaVdA-1; Mon, 09 Feb 2026 07:25:53 -0500
X-MC-Unique: gROdxjv1PpGZWR9FINaVdA-1
X-Mimecast-MFC-AGG-ID: gROdxjv1PpGZWR9FINaVdA_1770639952
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a79164b686so56464935ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 04:25:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770639952; cv=none;
 d=google.com; s=arc-20240605;
 b=HvWvV3eOMcHKdBiE98VrOXx/GStXr4IlUe43+k8Apv0DWl2gQtb909EkWSXaNtQx0w
 OwvcTrJi77YcG+C3bijLExpaWVm5Bf3JOAW585nImdM+l7WhIWxzM+LYkW05IZ6uAD+0
 fzaImzU6HZhluTQRj49edwQJzT7oLAByC8lFD2li3zMrQfSw5eWmCUNegFThiKss7tVV
 iM7IHfacNUCsezIQnXLeR8nDq1Ci4HaEna0x4nPnTYqeY+WhFpU+jCdpEusRRgwlLTke
 csKxiEkg16fmsLLfb3jy5Y5xWmkws12sDo+1TGnlypLRn6KdDilgkd4/a040Ka0sO54F
 sFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3YA2rhIJPzb0gHlkZF0sV50+XzXC6raUhE3rMw9/FDE=;
 fh=h0ZoEG5U1FASe64sqFkBdBCcpkS3SnOYO0cH5Qr5s2o=;
 b=RlebhaJx3ywQJhKyutata0Jw35uvIdn0Pa7RqLKAtGU9vHSERIlVRMY2eG1tOkPU9k
 ndIPbG3xV0Hfc2b69VtliCwIHeS1pH8xzcfARbk2MQK2sgHvHTh7RnsVAKooEhHPmc6j
 0nycDJcM4g/K4MzcVosts+yIU4L0UZvRur6FheTdNPvKaAWi9hci2PbfOZHRWSgjbtJN
 6MZXvAFX+tHny6+Ocq8hpewBbB9WN3t3m98Qp4eHfPjDtsTv/P+Wt9jSg2Kx18M1uR9Z
 aNcE/XJH2Hxojr8k4qyU1kUQMTLV3J2/DmH10I0sDKc5zbnzsTrMJGQ1uQj6R15vXMqQ
 QRxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770639952; x=1771244752; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YA2rhIJPzb0gHlkZF0sV50+XzXC6raUhE3rMw9/FDE=;
 b=Sj5m8aL6hrG6KpXNH3Y+IhnkiWvnQvRAKzgjT0iMB9y3Bi+a7UUhysjpjcZgiwzqwV
 aeee61tEleUTiw43QbkL7l5xgG1n3HnOYR1hQiYBSisSpWa5jeOrSfa6usp8sKOTjJYO
 NC6A48k9tAs6o46yoyvyylKtScDqpMbRRLj+tbEGg6Dy53auRuYqphY3eEd4v3Grrwt/
 Kzet3ZLoLVtuxGIouLeuEemyI5mLso3Ydf5RXK/iWJoMCheB7TARJFDKywN9B4rqe8L9
 HN7vR9gYYbTgXY4xebp5Ajx7oh4YxoFj4hB5yT7FO9Ke/JrCm5wvtJu0psz8D98vlDPk
 x3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770639952; x=1771244752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3YA2rhIJPzb0gHlkZF0sV50+XzXC6raUhE3rMw9/FDE=;
 b=QpYeS446Wjn6Bml76ep98kJgJLnobehMSYe1V2OFOR7zzEWl7HgaKVbJSRHTGF46Vu
 Sv8kzm7KmgFRO04g52bxMqqprfadNVsnEqBeVMfjEYlr4st7fGtnbWNoy3je7pZmyUNN
 HYmrA0nRH5gANdA6AgZXhyVjbnzEnXgKhXa3AZeCA+Okv/q2fYiKN+BNuwVa3AClc3Y1
 FTBWF6MIIoiBN7Afj8CCrhoysRGZYlzMidLB0568CprEJrNB5f1S4XyR6jJF+UyCCSqQ
 wxWxEteyx6dF8KAr9lEicp89lnOpSgns437pVpy/9G/RCyatFIzmK79sO2sbmqGN54gj
 qh3g==
X-Gm-Message-State: AOJu0YxyFQy1txqxfDAb8PXrZCycFPpmCIGTU/ME25vq6t4SDlw9Cy7t
 AR6Nsik+eNWmb6m4czJl7OSPfQNwz4X8aqMfBJ0CNx/K8cPAPkPbHvPpDskNinZKcgPlBEysOu0
 qT77ek6vxrmHLre6jmkQ9a0lJrYpA4RAw/CLcoy2E/jYTy7EzTQXSw7edYwFLp07+qxsxvxohra
 TJE0VIu2Wpo4b+9IIrGrwacSvSbLkP5Y8=
X-Gm-Gg: AZuq6aL+1Vy7AgNX2Rvw3kdf2ZnduXHE+fN1OVpLkAwDebIAhcZ18VbJJwHLR3Wp1hZ
 3ypYJjJPAPFu5XmnUTcmzyV35H5GgNOaH2ebxXBS+yIl9FhyfMFB9JwimedDcekK0EL+JU8uo0M
 FAmCwDxRwYds+P3XXMJ9qBptCzK4zlUvP2N4De1kg5sDU6YgGTZCzSpTANuOdU+DjaL5PQ83NDD
 32xlmV6Q2RIkzMoiUWh6fZ5BA==
X-Received: by 2002:a17:903:1b04:b0:2a2:f0cb:dfa2 with SMTP id
 d9443c01a7336-2a951625455mr102519835ad.13.1770639952178; 
 Mon, 09 Feb 2026 04:25:52 -0800 (PST)
X-Received: by 2002:a17:903:1b04:b0:2a2:f0cb:dfa2 with SMTP id
 d9443c01a7336-2a951625455mr102519665ad.13.1770639951763; Mon, 09 Feb 2026
 04:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-17-marcandre.lureau@redhat.com>
 <f660298d-6a92-4b6f-a113-e0bd239818d5@nutanix.com>
 <CAMxuvawiiAMOfPfO1jdXXXf4b6BxD7X1+AeqmXY0FdGsv+6evQ@mail.gmail.com>
 <a6b42494-4abe-4651-a61b-5a6b3b1c2ecd@nutanix.com>
In-Reply-To: <a6b42494-4abe-4651-a61b-5a6b3b1c2ecd@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 9 Feb 2026 16:25:40 +0400
X-Gm-Features: AZwV_QiKxEhdIjJVRBLiBbxVXQgNk9t0FndcAWqc99HGSZNWdHUQOWJT3NVXPaI
Message-ID: <CAMxuvaw3sRONVTsnLDR5SrapJ=rXd9fdLwUA5JwPvbfiRuDWfA@mail.gmail.com>
Subject: Re: [PATCH 16/37] tests: start manual audio backend test
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Thu, Feb 5, 2026 at 8:23=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 04/02/2026 12:47, Marc-Andr=C3=A9 Lureau wrote:
>
> > Hi Mark
> >
> > On Wed, Feb 4, 2026 at 2:38=E2=80=AFPM Mark Cave-Ayland
> > <mark.caveayland@nutanix.com> wrote:
> >>
> >> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
> >>
> >>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>
> >>> Start a simple test program that will exercise the QEMU audio APIs.
> >>>
> >>> It is meant to run manually for now, as it accesses the sound system =
and
> >>> produces sound by default, and also runs for a few seconds. We may wa=
nt
> >>> to make it silent or use the "none" (noaudio) backend by default thou=
gh,
> >>> so it can run as part of the automated test suite.
> >>
> >> I wonder if it makes sense to have some kind of qtest audio backend th=
at
> >> can write the resulting data to a file for tests like this without
> >> generating audio?
> >
> > Yes, we could have some tests using the "wav" backend. Although I
> > think this is pretty limited. I'd rather leave that for now.
> >
> >>
> >>> +
> >>> +# manual audio test - not part of automated test suite
> >>> +# as it relies on audio system
> >>> +executable('test-audio',
> >>> +    sources: files('test-audio.c', 'audio-stubs.c'),
> >>> +    dependencies: [audio, qemuutil, spice, modinfo_dep],
> >>
> >> Does this test really need spice to function?
> >>
> >>> +    build_by_default: false)
> >>
> >> It took me a few seconds to see why the test-audio executable wasn't
> >> being produced, even if it has to be run manually. Is there any reason
> >> it shouldn't be built by default?
> >
> > No, I thought if it is manual it should perhaps be that way, but
> > that's also not a good idea. I will change it.
> >
> > btw, I also fixed the test so it can run with -a wav,file=3Doutput.wav
> > (the test currently requires input handling, which is not handled by
> > wav)
>
> This sounds great. Did you manage to find out if the spice dependency
> above is still necessary for the test? I don't build with spice by
> default here, so I wouldn't ordinarily be able to run it.

spice is not required to build the test, I'll drop it from the
explicit dependencies.

There was a hurdle to support both modules & non-modules and default
build, but it should be ok now.

thanks


