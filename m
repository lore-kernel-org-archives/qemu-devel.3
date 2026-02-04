Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A01CE95392
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncIH-0006P6-Cj; Wed, 04 Feb 2026 07:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vncIC-0006Kw-Do
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:47:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vncIA-0002Kb-1d
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770209250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hWpQmUsnBeLX0z7/OQbTCsee2cd6Jrf1WiGQd1NY4nQ=;
 b=Lpzo6UCQZPqDQH850cbRpIlmShKeG1J/ApMNzm5ewoHtZbj1bfRtg091BvPNIhuU+D42kG
 I/f+Wc1pOQjL0Xlt/1yJjVZznhEKXQGQSZaUaKbny0dvJ+QW/u0VH7hM7QnuS2HcZprbbC
 rQuzazd85HrLxGq1DL7jx5RxEksNtWQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-PijlQ1OEMoKyS86B0JAIZw-1; Wed, 04 Feb 2026 07:47:29 -0500
X-MC-Unique: PijlQ1OEMoKyS86B0JAIZw-1
X-Mimecast-MFC-AGG-ID: PijlQ1OEMoKyS86B0JAIZw_1770209248
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a90e8b54f0so111301025ad.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 04:47:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770209248; cv=none;
 d=google.com; s=arc-20240605;
 b=e2NoWv7/QuQFRingHz3yiglMNssfOLnQsUjZNYJjNnf2QLkXaTFpNzrD/cG4NF5C0I
 r0CvT+fqxoAG0qICwY7Q5jmkr3L/KMmGRKvxARExLRVtWb0BbjWwyEeAmYixQAUtF6qo
 V3GUMe9rzf3S7gsphbky6aAEAsE+JztfUyXhn8eTCJuCIRWbSgtvYbcUmX+S2Wv3lOAV
 JPg2k6lp1f8UEHURI2gWlyox1swmn1jv63hG6OEVs+qP3m/lrVckUUco8B8dKfNS+8lg
 3SKQSSmJpn3zOnm9sZPqgDYrle8xgk0qojny1dyUWMOzAB0DFWbJFkiEEuNgBDqihAfN
 Hc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hWpQmUsnBeLX0z7/OQbTCsee2cd6Jrf1WiGQd1NY4nQ=;
 fh=h0ZoEG5U1FASe64sqFkBdBCcpkS3SnOYO0cH5Qr5s2o=;
 b=RH9yvp2Eq2S/kSu5dAFD4do/ur7jc+XIGiPv+DP2pJDNzgRQ65hF5sLSAFei7s0umE
 BvAABnPEh8QJiq3x9j4y8uDWpfBg053KJkRcok5DRDw32/s0U7BZJzJlfgh0O0z563xY
 EpQv/1i4wSgPdPBXn5Hqf7MhephHbwJ7zyJOfhmQ5+j97UHIrf9EYsDjk4QbFWNyBtFm
 2qpq7G9WbvoKX8GRM3OLRTsagBpqNi5H9tAz5Lca2SkkC1qR1pNoT0BCHLP0uCXjQbOz
 gD67G/N/DXtJ5PmP/9keoZATNr8Yx5LwGHPNDoBjfdlWIiM6Do6UH/tGlnPu9eAPA5Xf
 NnyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770209248; x=1770814048; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWpQmUsnBeLX0z7/OQbTCsee2cd6Jrf1WiGQd1NY4nQ=;
 b=kVdhtJem/5FClA3irOnnNLQVgePiBfxsnlk/Tu/5CmWJ0URt+z1gcedCEluENFvRmw
 OIjYsoRW0KJ8yh2RBHBpJSSIj5d3rkWD5W2/YChyBVe2wJp8bGjQ7KWh+uNaXxsJ5G1B
 1kAxHkuI3k9Lc3WoyGCf1t+mpfyP6dy0YrnjWGQ1cJQ0Uh60FvADn60bokGUnw+mpY4o
 AWeeWjPUCX4H6O607I6fYj+wz1H09hc3xZAQXcfi6j8FTvwnLOOQcE5dVcYklezOlIzL
 IBCYN/QBtOG26SocGWlwsQCw00Z4EUMP3rzR5nzHrsEhcp86vid8U9GNcJtCuQUMZrF7
 0MVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770209248; x=1770814048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hWpQmUsnBeLX0z7/OQbTCsee2cd6Jrf1WiGQd1NY4nQ=;
 b=J30QQbGNAqMgPHPXfzx9colb/+ymAf/nXJZCjRZ6ZHCZoiqTjQbjUdm1vm3BdqaPpH
 JnRFxdSlVICWRREybWLM56kiAz6rX0zlsamI/KtsQwQjT8GfafnakjtpskspjWSxayEE
 SYqHTuhppiEOsPGLOk5GqgGLbv9ZqUs8/EOo2Iwyg99Z8bPag+VFR/7vxXgjmJfdB9lu
 6Wsx7Bqgy/CUWJ0hGmlXeny93Ek+kDA+IKO284C6HQIYs/4uY41ZZZUGR+x5R6GfEXAm
 JIMkkHcv7pB0gT1etdqFAI9Y/tikEMlm05WWGQU4fxI78lL83B7UmYMiM7SpLqK/Q0MZ
 OoHA==
X-Gm-Message-State: AOJu0YzfCtDL4lUoRrn4P08i2J2fytyC14S2IrsQK/6CdqavQBi+meom
 OhFlG7EGN7xyHbEyyJ5u57JiMx3+9cUfR8UHqMzYNO21kKqKEkn20i6EMCjwfYNmOR7AJI7A5FV
 Yaw4erpm+OrUN0hroZ6i6Xn+d+D/TLcjXj6J6lFhMYmz35JqJH38XWezb0t8gqJoGNxfC6ifUhL
 M7zpSik7bmQEnYBZqIh2I/iqBME7BkcpI=
X-Gm-Gg: AZuq6aI+LA4ryMG+J/0ztZ2RW/gvFBDo9Xtu+0m/nrxsDmAg2q+/CDNZG99wi6LrdvM
 cR8Anaa1XLvcu+ge6Io2KGSCs8+qxao6svb8J+EGg3QcN+RW1fk5qEzWBx3QpwfP/hZxZ2LSBtF
 ND/fEcov/LdCWDpl/kcFPydgxjhw69/6PQZqh2Zd5ddDNc+CeH6iLsXgiHEKluacgE87JdbNE11
 Lfl/TzOGHUK8emmPRvxypoYDg==
X-Received: by 2002:a17:903:b47:b0:2a9:db7:4472 with SMTP id
 d9443c01a7336-2a933bbb43amr28621575ad.10.1770209248321; 
 Wed, 04 Feb 2026 04:47:28 -0800 (PST)
X-Received: by 2002:a17:903:b47:b0:2a9:db7:4472 with SMTP id
 d9443c01a7336-2a933bbb43amr28621375ad.10.1770209247953; Wed, 04 Feb 2026
 04:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-17-marcandre.lureau@redhat.com>
 <f660298d-6a92-4b6f-a113-e0bd239818d5@nutanix.com>
In-Reply-To: <f660298d-6a92-4b6f-a113-e0bd239818d5@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Feb 2026 16:47:16 +0400
X-Gm-Features: AZwV_QiiId6oZovqYnDnnYYfpW7ipW8RqoOSLU2L2hUFkjWiLD6vr2OdtTDJDSE
Message-ID: <CAMxuvawiiAMOfPfO1jdXXXf4b6BxD7X1+AeqmXY0FdGsv+6evQ@mail.gmail.com>
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

Hi Mark

On Wed, Feb 4, 2026 at 2:38=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Start a simple test program that will exercise the QEMU audio APIs.
> >
> > It is meant to run manually for now, as it accesses the sound system an=
d
> > produces sound by default, and also runs for a few seconds. We may want
> > to make it silent or use the "none" (noaudio) backend by default though=
,
> > so it can run as part of the automated test suite.
>
> I wonder if it makes sense to have some kind of qtest audio backend that
> can write the resulting data to a file for tests like this without
> generating audio?

Yes, we could have some tests using the "wav" backend. Although I
think this is pretty limited. I'd rather leave that for now.

>
> > +
> > +# manual audio test - not part of automated test suite
> > +# as it relies on audio system
> > +executable('test-audio',
> > +    sources: files('test-audio.c', 'audio-stubs.c'),
> > +    dependencies: [audio, qemuutil, spice, modinfo_dep],
>
> Does this test really need spice to function?
>
> > +    build_by_default: false)
>
> It took me a few seconds to see why the test-audio executable wasn't
> being produced, even if it has to be run manually. Is there any reason
> it shouldn't be built by default?

No, I thought if it is manual it should perhaps be that way, but
that's also not a good idea. I will change it.

btw, I also fixed the test so it can run with -a wav,file=3Doutput.wav
(the test currently requires input handling, which is not handled by
wav)


