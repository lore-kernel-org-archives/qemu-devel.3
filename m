Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100FCC2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKDf-0007uS-SN; Fri, 07 Aug 2026 09:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsKDb-0007sZ-GZ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsKDZ-0001xs-6R
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786107751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=niWwnaQNGy1KDUNQ6iEFjPqLRtGRvwhejogbSwcampw=;
 b=ezvgaYNH2sRqSxdAnwMjxRrJt1AMgeVKr/kblkHqVxT55dXaz88O5ED2omPNhWekju7+Tb
 dquCFt47bFqJxF3tD3te+k0jTDUwz/YZZPuEcrsAOTAC3wZ5XCchTvK5WoeD+2a6o+mo07
 LkBf06pkuKOS74hs2OlPfg1B6M9Fedw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-bIDYYKJTPw6_8f6mKhqW4g-1; Fri, 07 Aug 2026 09:02:28 -0400
X-MC-Unique: bIDYYKJTPw6_8f6mKhqW4g-1
X-Mimecast-MFC-AGG-ID: bIDYYKJTPw6_8f6mKhqW4g_1786107747
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47fe85684b9so2757773f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 06:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786107747; cv=none;
 d=google.com; s=arc-20260327;
 b=C6jz7IkmSL27Ip5l8D8s16PEAXZ0riaaciqfLu94rCKJ9dIwowY0n0jLVjmD9dv6hW
 N5uQet78cF5gpBtKcTjAya3HSgwq9F9KeD+5E/5+gEi/Stv/0M9/nupzAhSTLtvg4cSJ
 OC4bEbDvLYoevDJesD1yB9XdUPTqcxUy8oMSm7egw+gxjsXn3dLdWgXUohHRWxmg1wrY
 d/TLIRPpLfsSbv51Ogs7VqZIHtldwZMsVvB2QBtaLfmoLVgmGI+mL/CzJjmb9zv1wAb/
 ad7PofsrPKmwlVwF1PsTy48itJftB7DizxppgzBC6U99M3VXZRTap0NP5q80AdmjAsEL
 M1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=niWwnaQNGy1KDUNQ6iEFjPqLRtGRvwhejogbSwcampw=;
 fh=Xm1ao//qklFdOPp89/6xUzCVv6E/EI6O1lKNAzhngcE=;
 b=nsIJ7xvNMxUtCGTpeH4hEaBDx5+elSO9UcYTlHfsHAissKCo+UOsHmC43OtPvQBi11
 hDWUajgVx3TBfwol7q4uUY+L9O4BLesm/goVf8tAYVladhqBNeKh+ojsHFETh3deEqqE
 5a1/IYEPjmv4Y2AFZCwQYXVbKuphq94ZZgrMfZTpZV7V9YNXIsQ7sNQJZQzaadrhGjgJ
 EhAbe+t2ldOFbAFGQCwdLiyEs9P5nmYC1edFQ1pvbYCkAvK+Q/C5BUQR0Hg8+fYqJBml
 Ub5HcIwuNaZi062u8o2DfTcx0/waeuf1ALfKPQiTWbo5TAxCMvkkrW/7ApH6O0FBqV8S
 YoMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786107747; x=1786712547; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=niWwnaQNGy1KDUNQ6iEFjPqLRtGRvwhejogbSwcampw=;
 b=SrOrEk3z/l/9n1GkTy8PbKW3bwNTFLl1KgLsXg4w0J1UPLSl3/kG4HRIE2z+rD4/ic
 DU+Sx574nlcz7mIFkvNp+qyypO1i7UiJiko47q/M0cq/nhiM1Tx5nVPiFraxrZV30BaA
 m77WZtlaas79CzHIx7LN+bqtgPu/nRmp+O7JHkjDbdHxe6CR4CcL6lmtg3Z/rkwnO4Y7
 wM+dMcOWb/LTT5ahc3wNpFVrZnIpY4IQIodsJztnY4sZCKfqOlHtYgnPDhvT+m3ZjtHy
 rL/Q4wi0GbOXt862ReC9oktZNM6ZQBKw8wOMlFag/h3NOM6IPylF0KPHGAxz2MH+WhLu
 6NiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786107747; x=1786712547;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=niWwnaQNGy1KDUNQ6iEFjPqLRtGRvwhejogbSwcampw=;
 b=bswH7Tm69wONpVgbOZKV2e9v7J/M+qnrv34XroJY0FZdcR3ZXdxPO35Bk1H/sQfpIG
 ivIDwxXDYmy4rCSPssZP9y6RmDoPaJdT1DOkPyLAeczwsseiBAeNyc9kklI3ZSnZGCZc
 MXbLoUqotN7MOQjQFRnMwhOQCLPcIVxe2EqxlZNR9FeDZYTy9owBtVxRIN8H/GEJC6iy
 Utrd4oJ17y8o92YKVbk517JQeSSDgSoAYdi8keejvzuknvEtSt4F7fapRLC7hgbIh19a
 8OG4z23mmTYVp/0IsHlV5qbo+1GyOLtmsmnkE9nEx0V8RSZd0xrFuvwLXOOAfJKuUJPg
 1YvQ==
X-Gm-Message-State: AOJu0YzFThLNpVp7WxIDdLsqvs6i5W0QD9ooyjQRL1+WLK9RgFY9/8Pd
 s2jUxyLo/iQEDy42HzbaTvB2/5v2i92zU1BZAIFfIIECtIFbdZVJ+x8OPz8c/sNKXsAxWWhdStH
 zGYUcdl9e+t7Ay9818GijIMJd1koPvDhN9MF5HOSlZuUCgVxyem+11czCW72kb7Bp3EmUvjBiUR
 yTPe9ZmFnd+3dI7fXoXlPED08adrXQShc8B7mPngpLyA==
X-Gm-Gg: AR+sD10E6/2X4cugLtzpIwQVBUgLnvKDDOLhtIgRiX2QhqB/Jd8Pt93xmQN9W2hEHTi
 bMPtrDZU5ckda1He2i3if0iQzgDyA4l1/SSXIYnm9LLc0cQlv7Za7krYKPfNFLQIKzy4nk2To+Z
 goep4uwg8+3DyXFpGEQ8oXepgZ6wHLtw26coQ8P/hLo+cfLjiSry3XToSZQqPV4D2eAh2vEG9ix
 d3YDtfc2LfAYIif2uWUzuBTcVkZzIJ+gHUkO31m2MeMBk5K+6XkExnm/Ic=
X-Received: by 2002:a05:6000:2989:20b0:47f:ece1:5d with SMTP id
 ffacd0b85a97d-47fece100b6mr29703360f8f.27.1786107747268; 
 Fri, 07 Aug 2026 06:02:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2989:20b0:47f:ece1:5d with SMTP id
 ffacd0b85a97d-47fece100b6mr29703292f8f.27.1786107746870; Fri, 07 Aug 2026
 06:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260724130044.1369843-1-pbonzini@redhat.com>
 <20260724130044.1369843-2-pbonzini@redhat.com>
 <87a4rf61e9.fsf@pond.sub.org>
 <CABgObfaAnbH6eV3Gu305KjNBN9MCJN0TwPbbrE2ZkMWO4Mcxcg@mail.gmail.com>
 <87qzkozskq.fsf@pond.sub.org>
 <69be7bb2-cc30-4788-8bb5-6a6c51a65bb9@redhat.com>
 <87ldajwx5p.fsf@pond.sub.org>
In-Reply-To: <87ldajwx5p.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Aug 2026 15:02:14 +0200
X-Gm-Features: AUfX_mw1rpCBrnOGXET8nhOZuFexJDChnnerUY75Z6g3etVzr_YUNQtHUYWWq1A
Message-ID: <CABgObfbOVY5mpyhxQHOCvVDZkOHgTK=SmJ-gQ3A6_4Ywhhew_Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] scripts/qapi: enum with conditional first item must
 be optional
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Aug 6, 2026 at 9:01=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
> >                Qcow2CompressionType could grow one in case zlib option
> > becomes mandatory.
>
> Do you mean "becomes optional?"
>
> Note that @zlib can't become optional without a compatibility break,
> because @compression-type defaults to it in BlockdevCreateOptionsQcow2.
>
> Moreover, Qcow2CompressionType needs members, because @compression-type
> is mandatory in ImageInfoSpecificQCow2.
>
> [...]
>
> > BlockExportType is the most potentially problematic, because it does
> > not make sense to have 'none' there.
>
> BlockExportType also needs members, because BlockExportOptions and
> BlockExportInfo have a mandatory member @type of BlockExportType.

That would only mean you can't construct a valid one; but it would be
dead code, not an error.

> Joking aside, I wouldn't call it a feature, because "feature" implies
> "good for something".  "Bug" implies "has some undesirable effect".  If
> we volunteer for the mission "don't let the programmer specify useless
> interfaces", then this is a bug.  If we go "you're asking for rope, have
> some" instead, it's not.

There's some advantage in avoiding #ifdefs of this kind:

#if defined CONFIG_FOO1 || defined CONFIG_FOO2 || defined CONFIG_FOO3
#define CONFIG_FOO_AVAILABLE
#endif

and let other stuff compile; sometimes even if you cannot rely on dead
code elimination of some sort (which could be *another* language
problem).

But as you said, this was indeed a bit of an excursion into the weeds.

> >> * Forbid empty enums [PATCH 2].  They are allowed simply because I nev=
er
> >>   found a compelling reason to forbid them.  Yes, they're useless, but
> >>   users can figure that out without the QAPI generator insisting.
> >>
> >>   Does forbidding them help Rust?
> >
> > Somewhat; I cannot generate Default::default() for them.  It would be
> > easy enough to skip generation of that method, but you'd still get a
> > Rust compilation error if you put them in a struct.
> >
> > IMO this is telling us that empty enums should indeed fail to compile
> > even earlier, in the QAPI schema generator.
> >
> > Empty enum types cannot be created, and neither can any structs or
> > commands they contain.  There's simply no way to have code that refers
> > to them, unless they're wrapped in something else that lets the code
> > pretend they can exist: for example you can make a field optional and
> > write "None" for it.
> >
> > With conditionally empty enums, this at least makes sense as a concept;=
 on the other hand I just don't see the point in unconditionally empty enum=
s, even if they're optional, so I left them out.
>
> If forbidding empty enums makes Rust generation simpler or easier,
> that's a compelling reason, isn't it?
>
> You should mention the Rust reason(s) in the commit message then.

Rust can live with it.  I'm just taking a clue from the language.

> I might have banned conditional first members from the start if I had
> thought out things back then.

Ok, then let's do it.

Paolo


