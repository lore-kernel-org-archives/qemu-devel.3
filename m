Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837D9D39415
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8GTo-0001fG-7A; Thu, 02 Apr 2026 07:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w8GTl-0001et-De
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 07:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w8GTj-0003XS-KR
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 07:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775130289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmypjSOO8NHtiaI3BzWg8w1pL57Rt7rMIDp86Itz9/I=;
 b=ceMtAtm+vUrJsT0tBUoAfJ/G5+dvU5grYUPzTK88s8Hp5zQbLNlV+NEyuhi6ZEO8SwAnev
 Ie1QWB4j7+I1Pj25UJVi8No/dTUXA/pI5AvI9UHzFpQ4Ay8Fr49utS7Q2mZUc0fDFBim4R
 ma51Ghfb9gOy2/FlMLDyXciEgzip7p8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-tjwVCw0ZNj6-D6y9u04paQ-1; Thu, 02 Apr 2026 07:44:48 -0400
X-MC-Unique: tjwVCw0ZNj6-D6y9u04paQ-1
X-Mimecast-MFC-AGG-ID: tjwVCw0ZNj6-D6y9u04paQ_1775130287
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354490889b6so1108999a91.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 04:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775130287; cv=none;
 d=google.com; s=arc-20240605;
 b=U/Ozx9nDp91EqtPBakYjPUdN92saC8Da3IiCnUchK9m7eY8yNUpnKF/uORT5GG7L2j
 WMLuG/7MT3J/uA9GKZ5pQ8onUkb4UMYljqPk2ENgZPq76yiYd9dBUreCUdBQGOTb1m/c
 U4xXyaHBkE5FAgZ3tbvj0WWL4qaHpuwDKvQSV1Cl9Z8QFBa2lBBTkCIfLFliikobtvOn
 GMgjPgDGWCmjIcZotQvRt8nleJAnhKibncrP4Ai3tcFjhM0Dhkl5w3wU5i8FrjNcUjBW
 tnvlW5VvlG1sVmTm5bGsjqu8MtLo+/Vir/HVl4H3JyIRC8+1C0U1gftZlB9agpwY7WaX
 /aAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nmypjSOO8NHtiaI3BzWg8w1pL57Rt7rMIDp86Itz9/I=;
 fh=pljgQb51SI5T8fJjT4f89PH4vuf7hUTqYcKOSXi3vR8=;
 b=lMC39AySx0F83mLRXKSIMvDRgZWCKZkdqc9qwnSw3m0ABtrWecYXOb9oprkgmkeWXa
 iFh8zotK8zXneaAmnHl4nFqWpoiwdeRnA4/ZUhcA0T3HsowQRQzKpQMRi/gMBRwW/oSQ
 ldI57UP+1NtLWVFcrYy8/oHevrmrm6L7qg9E7jGR0Ye7jQEVVKZLuO5kfOB3RkC1KyPP
 Lg24/oeB9qLRdUh/2NEncfYx4PcyM5/EgHsIoIJEcrXWTZ8womDNiCTmWW794su0RSMH
 F4v+bezvYiYUFlfEoi+DY9RqzZRp/2QHFoeslX5xmyIvXpmmHiKfuc2sLNtCR1lXXMwQ
 ilPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775130287; x=1775735087; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmypjSOO8NHtiaI3BzWg8w1pL57Rt7rMIDp86Itz9/I=;
 b=GUpFZG+6ExSNBW0dzd/5GSyv9nxiK0Cv6UsAHEj0Ic3eeuIEfi8oyM99wclBe7cGZx
 Jy7RfffET0TyWcST3i34Ew2nGOfKCAy/QWB+YheXhyW3gsq6/oznRCCkT1u1ptJ1pVZ+
 sb00Z3jUzF2xUIgDDY8IF8wHwdA1QQkq3uSKgNb/LzEqfteKqAMB1/Bwbp+Lrac0veJ+
 3F0QrkIAsGZYg/fJGyYudhpsCncRVXUPbgZYZCBwDT4Ktt9jfubOuhOq78M5ApfMSlFr
 WQpAB25jE0ORLu6OvWKDMU+TWVR847jKT8790218ZehRTedy4gRkInGyGJqSTrwxMKWv
 2zxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775130287; x=1775735087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nmypjSOO8NHtiaI3BzWg8w1pL57Rt7rMIDp86Itz9/I=;
 b=GW+bigWhHuQ/mUlCndSXFjcXdARy0nCPHNADzmFCpLF2m1H7Sx2WKIpD8QUlpnVp+V
 5b5fwgCGk/A2bqH2J2ysHP4qrB0ZXnXZMVwVzcGpx991ZeEcAhQuz1DlrA4pfsCo7do+
 4PuFaThOXfV2RcbKV4YZuDRLlvoVbrSdf9Dc7ACmdptbXfah+V2ni/CkubSftz7S4Gbj
 QqD7riiMu+eh35rwyhSYMqR3+sFWbCdFyW6aIUsevnMKOvplmXCLdeQVYpdkZI0fnvwC
 bdDogSpUZpP5Zu/DWwsqGZgJAAGo+VAC+/Y5cAwhVjlgbvXaJyXSItalRw7lGN5XsY3x
 Mmog==
X-Gm-Message-State: AOJu0YyRonn15NvazUT9OALb6WAoQROraFOm64zCbt92NxrkWBH7Vt8H
 ep6HBzRCqsNDgzStlzARd2iM0kGuFSSobgQZ/OGkx4e09l4K0GofAqAfgoad4VN6AlLNJdscjZ4
 g7XfYnNW60CVhSxPLOqwUubTdDuDKJ1nKlQnGID/xqktmopKMVSvGgSHKYisYMR2tg/vKPz4gvI
 5qLnbaRv355hLZANWbbiVPefDoUT6IRvI=
X-Gm-Gg: ATEYQzzHNbM7Lc0keEo2Aqpy38PO7a3BYYBdvGhmfRsATh+f06Ot8xrYbc9o1NuPRxY
 4RtQp5gAlyNtMWr7Ub1YWgYvjfH/gPaMwBIKPqryVS/c4uTJOEC8feVNlwNG96W6XRgM+d4gMzO
 U1z+MVUWZB4fR5l6OvuN0TJAS2ZCDM/7qq6OFTWj9sBxg/B8Y0a/BB7m9pLJV8cxtkMcaK1Bfmz
 4SLVQxnysEM2QiJKE3cySAahYtZga3/bLC6iW7jZcxUS97HraSdHEg6FC1cHR4v5CQ/o9f62gDD
 5umKxgT/VRhBZ1YtD2mV8Uw=
X-Received: by 2002:a05:6a20:918a:b0:398:c4e6:fec1 with SMTP id
 adf61e73a8af0-39f10a19b55mr3409943637.23.1775130287247; 
 Thu, 02 Apr 2026 04:44:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:918a:b0:398:c4e6:fec1 with SMTP id
 adf61e73a8af0-39f10a19b55mr3409925637.23.1775130286810; Thu, 02 Apr 2026
 04:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-11-48eb1dcf7b76@redhat.com>
 <878qbgpj31.fsf@pond.sub.org>
 <CAMxuvayGCvJwyUgrHSGwfLhqAbVC61dEbgbL4Ji_0YQHyv4LJA@mail.gmail.com>
In-Reply-To: <CAMxuvayGCvJwyUgrHSGwfLhqAbVC61dEbgbL4Ji_0YQHyv4LJA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 2 Apr 2026 15:44:35 +0400
X-Gm-Features: AQROBzDdZ66uAV7U5WprtiinBf3mQzx5WMgdxSvvvbS1d7sUXoW2VWrVabZm_Jo
Message-ID: <CAMxuvazy-_DjAVJN2=ie___VxFMKGyLkEiEP0OBNbipN1nxoSA@mail.gmail.com>
Subject: Re: [PATCH 11/60] ui/console-vc: add UTF-8 input decoding with CP437
 rendering
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Markus

On Wed, Mar 25, 2026 at 10:48=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> HI
>
> On Wed, Mar 25, 2026 at 9:35=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
> >
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >
> > > The text console receives bytes that may be UTF-8 encoded (e.g. from
> > > a guest running a modern distro), but currently treats each byte as a
> > > raw character index into the VGA/CP437 font, producing garbled output
> > > for any multi-byte sequence.
> > >
> > > Add a proper UTF-8 decoder using Bjoern Hoehrmann's DFA.
> > > The DFA inherently rejects overlong encodings, surrogates, and
> > > codepoints above U+10FFFF.  Completed codepoints are then mapped to
> > > CP437, unmappable characters are displayed as '?'.
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Have you considered the decoder in util/unicode.c?  Do we need two
> > decoders, or could we replace one by the other?
> >
>
> Oh! I missed it, I should definitely try to use it.

The vt100 receives characters one at a time. The DFA is suited for
this. mod_utf8_codepoint() works with whole buffers. It's possible to
write one with the other, but we lose in performance, and we need
extra quirks. I don't think it's worth it.

>
> > There's a mad UTF-8 test suite buried in tests/unit/check-qjson.c
> > derived from Markus Kuhn's UTF-8 decoder capability and stress test at
> > <http://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-test.txt>.  How does
> > this decoder do on these tests?
> >
>
> According to the author original article, it should pass
> https://bjoern.hoehrmann.de/utf-8/decoder/dfa/


