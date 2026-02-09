Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1889DE81BC4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 13:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpRjj-0001pM-9P; Mon, 09 Feb 2026 08:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vpRje-0001nN-UQ
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 08:55:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vpRja-0002VA-S1
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 08:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770645323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IYbx074fuAgyO8RGb6D+Pi1xYeIRePOLZjOYGfAnwY4=;
 b=hpgeyon6lY4h13LacBStE1oSz34/H1WpiCGMZLskjA0rNA+e1qY+Y3Zekdk3d9fCjTF+mM
 E3saTtKgyCjGsuG8/0NDG8uRs1SaupRhPGCpRsPzo3/rPtsx7xrp/rMEXdLs5Kbh7eAMmZ
 S6lXDbb9b3o45KL9Cw3x9X5kQXqoCUc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-4YmjsJbPMiWHaJFQ8SJXyw-1; Mon, 09 Feb 2026 08:55:22 -0500
X-MC-Unique: 4YmjsJbPMiWHaJFQ8SJXyw-1
X-Mimecast-MFC-AGG-ID: 4YmjsJbPMiWHaJFQ8SJXyw_1770645321
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aae3810558so17408555ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 05:55:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770645321; cv=none;
 d=google.com; s=arc-20240605;
 b=c50yjrn21gDo2FE0hsvxGJpKOQqihq9jrDhO9aaBB+J8CKY5xNmejreX8AdnVRr28t
 i0qxA3os7QAWi3vesKSATcBn/tNnllGTeHDyEhSlfZS7n2iGueDOyhaVL9Pi7SD9ukRx
 MXor8bvMMSrzXiGdPLioh3jvdPhm2FPcQGTYtM0YskU1Yhdr4cMEw2cw17X6tZi+WBuc
 1PHJvkE1KCkMiapC37lHTrlg54rfWOsVt6l9p3Zgg7+wwTY8pVwGfmrDsu3jEksM6AGL
 HR2ZIDKo1QVt4dPM85g0GxVEx61AL/CbLRNjLK/gu5yRJuKSR66pHVRtnbgm6YHUl4bb
 rI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IYbx074fuAgyO8RGb6D+Pi1xYeIRePOLZjOYGfAnwY4=;
 fh=PFiPKWxEwaUM1pAJhH38nB5+ITN/IE1tW8wH9YTg+b8=;
 b=Ch7h0urHc3mMU2gW91Ji6FECOBQzZTpWP3AL+pXhUV3pW6eO3s5u/ELdCK/VknclUG
 Nfs0oevf52ZJbspPvonqgD1iSE5IM9MGrblD/vq5gCqDf0a3x0Yus197GltJdIoElj3k
 /9lS1O4YbFpL8D2CoIjcY2l5/sKWn7Fc3Nqsnm3XLK+CUu9niy8ePdzM0KmhhwERTu+Q
 0lLtZX7J7YENN+wm04lDiIoMJF7JOUqJxSrKy4Qnpa6MiwZwv8JN2W6k+h8tSrdzsdai
 IkBb8DTWo0rxC2pW5rPt3TrAjlV6VN427HGZzJsk+nrqciFVmeESGTCK7euPDkEUv4w0
 0bBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770645321; x=1771250121; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IYbx074fuAgyO8RGb6D+Pi1xYeIRePOLZjOYGfAnwY4=;
 b=iMcwIYXUZVABADYQqRi0qwobCuTcugosyP+tY9NEmJuGbY24XEGukCKPv8Ms2Tb1H6
 FibPalvQH2i7ll2EAuhpyiWDSvdaASV/mK2psEUIVz8L0ZHTAxcn6aCX/JxP4ZHGzv8c
 uF/X5XdStEOXPH2TCPEEUq8EHPtuFz7QUV1Pyk3Te1UWHbUpY2tCc1RSl4w00OzeUDAG
 OMf4aLW5JxZZp7GgLh1cjvMF9HMnTVGAMPqvEVfS1kqXVVBKeQh2RyIl2ubV0hORCOGz
 nG83yfllMtMBI5BfmRCQ6MlvfO5g1HNWMM/BRqBPYPVLIA7efIw89IoL5yuyK0IyE/RS
 HERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770645321; x=1771250121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IYbx074fuAgyO8RGb6D+Pi1xYeIRePOLZjOYGfAnwY4=;
 b=atT6Zaqwl8INu1NJ2Y1YrkpoGvNE0L4auaYVw2E6Mce2vcT8Wd2IXefvq9HpXbKzBG
 sepRFwHD1BkTn1fdXAvyKNc6NN2cmeR1Mi7D+ad7L50zqpw/H+KhgPPYojvoi5VLQ1+3
 PBJJRJmrnwSqVnmh9DoCo78rPPEcqnu+mvsF7GzCOQ6FlvZ1dkwSSO2nL7eQNyopAOiy
 izIu4ogYKhI0yJNRpttVQ73iAbWy43SW7lkOAzUD43MaZjBD2bkNYHfW9J6L43zlvqah
 1t6a2x5miQNS2k/n2buSB0V7mp/DNc+Jx7iwWorum1vj3Ce4YehxaTZhQ6ysIDNwWaub
 zaiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2s9nlsiMAZ+OaWgqp6yiMTw+G4GxVNfcCX2jp7tB/pVQQ5rzsgLr/FPWMErNxHRZuSLkxaWvZnHvT@nongnu.org
X-Gm-Message-State: AOJu0YxUq4obnA1VvwTyaU3GsNsnmdD/dUFB6uSZXhL98cME/kmbwAs3
 p38JUNVFyWbepWwAL8cP7WJ5EVqpqbj5A3uznAjMCG35eKaODBmTV9KOSH4EBd7CHtghGSf3TmQ
 mB7hFiyX1xlZH5+A2QKC5rZaicwHWbjvRqxymPEDN9bnRGpjtaJgTuuRAP6NBL8DiecEakFa3Qw
 y0/fUeRqcvvPSJ4QnJbxU8UNLhYyk8OCg=
X-Gm-Gg: AZuq6aIKLEbyv022nxJ1AVaBZRxl363RtkEqoF6ljzcHKQ6FNDhT7I9JJk0bs18A0KU
 0ycInjXRXeT9nzn8uzjjb6co0lkhB52J1jgVitbcogc77cMmPuMwwV+7byBvzriLM0qfuevbXpB
 JSvdHxDNv896h2vgc+hjpOcnyJFf1WgbWJ5BATHZJ6iJZ06Pbo+puyAjvVT40V5byF/D1bu+Bwc
 GE4xVgtHB3lwK+pVktQKT9yrA==
X-Received: by 2002:a17:902:f70e:b0:2a9:4c2:e46 with SMTP id
 d9443c01a7336-2a95225f9bfmr119989005ad.54.1770645321184; 
 Mon, 09 Feb 2026 05:55:21 -0800 (PST)
X-Received: by 2002:a17:902:f70e:b0:2a9:4c2:e46 with SMTP id
 d9443c01a7336-2a95225f9bfmr119988785ad.54.1770645320784; Mon, 09 Feb 2026
 05:55:20 -0800 (PST)
MIME-Version: 1.0
References: <20260106183620.2144309-1-marcandre.lureau@redhat.com>
 <aV41CQP0JODTdRqy@redhat.com> <87qzrzku9z.fsf@pond.sub.org>
 <aWDMU7WOlGIdNush@redhat.com> <87jyxrksug.fsf@pond.sub.org>
 <aWDTXvXxPRj2fs2b@redhat.com> <87cy3jkrj8.fsf@pond.sub.org>
 <aWDatqLQYBV9fznm@redhat.com> <871pjzkm4y.fsf@pond.sub.org>
In-Reply-To: <871pjzkm4y.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 9 Feb 2026 17:55:09 +0400
X-Gm-Features: AZwV_Qg-c5YMc2Yci-hcpbp6t1Zog-FShbSeXdhMcIJyFPyyUkzxXGfQHrcVbCE
Message-ID: <CAMxuvay0yrQ1hp-zBFxwGy42eCG0_kUmi+rmX8U=BOLNRKgfdQ@mail.gmail.com>
Subject: Re: [PATCH] Add query-tdx-capabilities
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
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

On Fri, Jan 9, 2026 at 4:26=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > On Fri, Jan 09, 2026 at 11:29:47AM +0100, Markus Armbruster wrote:
> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >>
> >> > On Fri, Jan 09, 2026 at 11:01:27AM +0100, Markus Armbruster wrote:
> >> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >> >>
> >> >> > On Fri, Jan 09, 2026 at 10:30:32AM +0100, Markus Armbruster wrote=
:
> >> >> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >> >> >>
> >> >> >> > On Tue, Jan 06, 2026 at 10:36:20PM +0400, marcandre.lureau@red=
hat.com wrote:
> >> >> >> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> >> >> >>
> >> >> >> >> Return an empty TdxCapability struct, for extensibility and m=
atching
> >> >> >> >> query-sev-capabilities return type.
> >> >> >> >>
> >> >> >> >> Fixes: https://issues.redhat.com/browse/RHEL-129674
> >> >> >> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redha=
t.com>
> >> >>
> >> >> [...]
> >> >>
> >> >> >> > This matches the conceptual design used with query-sev-capabil=
ities,
> >> >> >> > where the lack of SEV support has to be inferred from the comm=
and
> >> >> >> > returning "GenericError".
> >> >> >>
> >> >> >> Such guesswork is brittle.  An interface requiring it is flawed,=
 and
> >> >> >> should be improved.
> >> >> >>
> >> >> >> Our SEV interface doesn't actually require it: query-sev tells y=
ou
> >> >> >> whether we have SEV.  Just run that first.
> >> >> >
> >> >> > Actually these commands are intended for different use cases.
> >> >> >
> >> >> > "query-sev" only returns info if you have launched qemu with
> >> >> >
> >> >> >   $QEMU -object sev-guest,id=3Dcgs0  -machine confidential-guest-=
support=3Dcgs0
> >> >> >
> >> >> > The goal of "query-sev-capabilities" is to allow you to determine
> >> >> > if the combination of host+kvm+qemu are capable of running a gues=
t
> >> >> > with "sev-guest".
> >> >> >
> >> >> > IOW, query-sev-capabilities alone is what you want/need in order
> >> >> > to probe host features.
> >> >> >
> >> >> > query-sev is for examining running guest configuration
> >> >>
> >> >> The doc comments fail to explain this.  Needs fixing.
> >> >>
> >> >> Do management applications need to know more than "this combination=
 of
> >> >> host + KVM + QEMU can do SEV, yes / no?
> >> >>
> >> >> If yes, what do they need?  "No" split up into serval "No, because =
X"?
> >> >
> >> > When libvirt runs  query-sev-capabilities it does not care about the
> >> > reason for it being unsupported.   Any "GenericError" is considered
> >> > to mark the lack of host support, and no fine grained checks are
> >> > performed on the err msg.
> >> >
> >> > If query-sev-capabilities succeeds (indicating SEV is supported), th=
en
> >> > all the returned info is exposed to mgmt apps in the libvirt domain
> >> > capabilities XML document.
> >>
> >> So query-sev-capabilities is good enough as is?
> >
> > IIUC, essentially all QEMU errors that could possibly be seen with
> > query-sev-capabilities are "GenericError" these days, except for
> > the small possibility of "CommandNotFound".
> >
> > The two scenarios with lack of SEV support are covered by GenericError
> > but I'm concerned that other things that should be considered fatal
> > will also fall under GenericError.
> >
> > eg take a look at qmp_dispatch() and see countless places where we can
> > return GenericError which ought to be treated as fatal by callers.
> >
> > IMHO  "SEV not supported" is not conceptually an error, it is an
> > expected informational result of query-sev-capabilities, and thus
> > shouldn't be using the QMP error object, it should have been a
> > boolean result field.
>
> I agree that errors should be used only for "abnormal" outcomes, not for
> the "no" answer to a simple question like "is SEV available, and if yes,
> what are its capabilities?"
>
> I further agree that encoding "no" as GenericError runs the risk of
> conflating "no" with other errors.  Since query-sev itself can fail just
> one way, these can only come from the QMP core.  For the core's syntax
> and type errors, the risk is only theoretical: just don't do that.
> Errors triggered by state, like the one in qmp_command_available(), are
> a bit more worrying.  I think they're easy enough to avoid if you're
> aware, but "if you're aware" is admittedly rittle.
>
> Anyway, that's what we have.  Badly designed, but it seems to be
> workable.
>
> Is the bad enough to justify revising the interface?  I can't see how to
> do that compatibly.
>
> Is it bad enough to justify new interfaces for similar things to be
> dissimilar?
>

Markus, as our QAPI maintainer, you have more weight on the decision.
Should the query return an union ( "unavailable": "reason..",
"available":  TdxCapability ) or the proposed patch is okay?


> >> If yes, then the proposed query-tdx-capabilities should also be good
> >> enough, shouldn't it?
> >
> > With regards,
> > Daniel
>


