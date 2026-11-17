Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB3E606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AoFabRzQ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=L1eVQ+sC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNO1-0006lB-Pv; Tue, 17 Nov 2026 12:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xTNO0-0006l1-LP
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:54:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xTNNy-0004Z9-TX
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794938062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bcz2C3M0nBV7LPJ6x+8JDDRrADUanvmWqDNeY+7M2RU=;
 b=AoFabRzQ3ZzAL1OKxoNHUkXizx2khl38oiOiMeepw8odup+MIVHqohF/rAPc7w6Vrcl9Bb
 /OnJ01wtIdJIHLQaV6LoHWeXQEUjW5JIVg0SvncL5Z/B/MD0mpaniM/zPpJ9U3PLNbAW44
 WwtjcIkQiGOf2KsADTzu/CtFt4zsPP8=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-nLlnptSPPJ2yueuhAlxTJw-1; Tue, 17 Nov 2026 12:54:21 -0500
X-MC-Unique: nLlnptSPPJ2yueuhAlxTJw-1
X-Mimecast-MFC-AGG-ID: nLlnptSPPJ2yueuhAlxTJw_1794938060
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-67dabc6d5dfso5026765d50.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 09:54:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794938060; cv=none;
 d=google.com; s=arc-20260327;
 b=rtgVL6e+GkDMB/P7B1BgsC1nSedOFS+22i5cCYz3I7U2f9kVLndX9HxJP5dIy2vLqM
 pLWu3Nv5SwNzDAwxkZ8fUO2bCZuVRLp0XIwAG79W30nKM/F0VUOLXdE8Z2b9jkfmrF3r
 YeHR2V7yqMKv26erQaVewVR0GvVO3ZY6xCr5Em8Z/zPg4vVDZ3L/1Jw4XBrmq1mKSMmy
 A7zMLaRjRC5Rx3ljrpVB7zkEc4sEZdbYEJpPhC0Vr9a+jAuwO3tFtz/CXKk15RchKpYr
 mmZ5sCBThmvchSlhtOB7S8CRdWM0pWpSBlxzYMEv1ScbP7BSaZ5ncgQJADQifzn0d7Nh
 9GEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bcz2C3M0nBV7LPJ6x+8JDDRrADUanvmWqDNeY+7M2RU=;
 fh=aM8heEw08rewKoAzVI8T3Lmgm/CRSAFyugkfKMMnfg8=;
 b=jmJZEqMr5FOD1fKusUrT80e+yy18iWmUrNiG6DPZPV1L+YCLrNdIhkce6siNzRfM8I
 Beq9VgyUXsl9B5bds9pPXfmKr1YX7NUt2t36G4ErY1RQS+aWFK/ppCSZsF5oYllpSq5i
 9JmenaOEykSwBpob3fDatBBK9V6fIXRr8o/F+ozyfzlgMYVOpgYacYTYKIzNgKQ1PFy1
 vBJQluz9wYDu23zTUhRL4v6buu9ZLo11VbcCjlTyp4Q8z/kP1C8YqCgqiUvptze3WKzn
 fvpOG9VwqKNvj5RZ0alDUZT/D49OJKDe2OS4bCTPaGZCNgjW+olS/E3CnOEBJY8u2JCZ
 7F3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794938060; x=1795542860; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bcz2C3M0nBV7LPJ6x+8JDDRrADUanvmWqDNeY+7M2RU=;
 b=L1eVQ+sCiAjVnnjW9yUxSfvKqsPjG4wrNyxs78PoW/25pGcFTaK+wrMt17vuxbGUuh
 aqmvtdBGT9xDtrnvWntrnoGpETunh72PpDxNXlwDnfzaREmT1uH1uY773JJCiPKKv3dn
 6jzNtRfqpe/wM3cUHOUODKH0hLTaeNBnXaoVVmUhWFDW9uRYcTRuhUxbtwkLn6ODtcMh
 8ccCWs7o20BMrnStgDk8BRHRfoiewH/CbygHttuwT/3DxFp7SWTGmeYpfcsYS6VFQIm0
 27g/Byp7hBkOIY2evq/1QyfN22dcQEpVewYkMJAN4nvzV3z8Bby48REMagd2irHX9vPf
 UkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794938060; x=1795542860;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bcz2C3M0nBV7LPJ6x+8JDDRrADUanvmWqDNeY+7M2RU=;
 b=Ii2+z908PgMF2hqMb3b+nwmP0e7Ye+ykIBCu9SsSWY6mXO2aaMNT5JFljTBQBTKGsp
 nmHPHlZMXqlddqoxOefZtqQ9aE5sJHEHwdH8uryD588ZDw3j7QJoCXi3esDg+c/lRA5u
 /kjHS2lTminwmihv8UJKi7/BmqpCtWofM0PkquoqYuULAGI5B7kN38T/8mXS98K/0ox3
 e1kWhtmphgJXkrakvjsjn2u+Zo1CDCJBVqKYeY7mq6fH614Bcvae1D7eNNZrNa1DUCoa
 Um387+H2IGeqVJd/q7unBfMuQhIadoLuBwMMUwXPepHLo9vaUNmd3FvrMag1P03TDla+
 Yd9g==
X-Gm-Message-State: APuU4Z+9Okm6J0fv14+Xk0XBIJ1mx35cnSMCBdQIFZdgp7vMmO3XN7JR
 r7IyBi/tuVfKDeDI8ukMXgdoEdcZtOLcIkGYEmpU0NpdOx8C4fiohfXU4J+O34Qo3hb/O16/j+m
 itOojlnfAJiVE/2yZtGIzqXFJWSvq0CoXFjKci4+DJ14CweO2vMpJJcz3PZ3S361mLIRNQJl97B
 JQILBwnVLG4hE5Kr34mCHhEiRLB+ndEdc=
X-Gm-Gg: AZFdTZfnZNm+y0b7d4pQcAFS7STl5tOqL9WeB+BKXfmZLGY/Y79Z9vy8hUEgt6MyCfo
 BUwOy7i+8nXSmU19WLifDvARm+VfvbFvPXIlHVls/H95Scp/rLbSAM87Mp93rlFyJTfB75x4ser
 UMfCrd1/jNL3q8KlObjBxnhlGk4bGBgchSjtPIf6RvAD2ATcQ7NMitQ8DX+yURKGvyXmtKdEwPA
 D+WWlgYGZyCeYxM
X-Received: by 2002:a05:690e:144a:b0:67c:1d44:7897 with SMTP id
 956f58d0204a3-67dd3d4f896mr229637d50.12.1794938060583; 
 Tue, 17 Nov 2026 09:54:20 -0800 (PST)
X-Received: by 2002:a05:690e:144a:b0:67c:1d44:7897 with SMTP id
 956f58d0204a3-67dd3d4f896mr229622d50.12.1794938060030; Tue, 17 Nov 2026
 09:54:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116165002.30939-1-jsnow@redhat.com>
 <20261116165002.30939-6-jsnow@redhat.com>
 <avxa4ZVUP5GcWi5v@redhat.com>
In-Reply-To: <avxa4ZVUP5GcWi5v@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 17 Nov 2026 12:54:07 -0500
X-Gm-Features: AclHuK9JBg0lxzsrWkkVeYrlg-5ShEC8ITTTmo5RceCDv2_djJuCATVOvfKauC8
Message-ID: <CAFn=p-ZKZ_S_33e_PZ-5tyU=DHczE=cVSCWEvkSZRJsKkbo3PA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] debug/mem: name coroutine stacks
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 kvm@vger.kernel.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Fabiano Rosas <farosas@suse.de>, Alistair Francis <alistair.francis@wdc.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 8:47=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Nov 16, 2026 at 11:50:00AM -0500, John Snow wrote:
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  util/oslib-posix.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> >
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index dc001da66dd..454579c72df 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -60,6 +60,7 @@
> >
> >  #include "qemu/memalign.h"
> >  #include "qemu/mmap-alloc.h"
> > +#include "qemu/mmap-vma.h"
> >
> >  #define MAX_MEM_PREALLOC_THREAD_COUNT 32
> >
> > @@ -742,6 +743,8 @@ void *qemu_alloc_stack(size_t *sz)
> >          abort();
> >      }
> >
> > +    qemu_name_vma(ptr, *sz, "coroutine-stack");
>
> Our coroutines are crying out to be named in the future :-)

I know :)

I looked for five minutes but wasn't exactly sure how to name them. My
understanding is each coroutine stack could theoretically service
different routines, but only one at a time. I am not so clear on our
model that I felt I could confidently give them meaningful names, so I
left it as an exercise to a future reader.

(Naughty, naughty.)

Since we're in freeze and it seems unlikely we'll agree this is rc1
fodder, I'm happy to take some extra time and improve the helpers, but
some pointed suggestions would not go wrong :)

--js

>
> > +
> >      /* Stack grows down -- guard page at the bottom. */
> >      if (mprotect(ptr, pagesz, PROT_NONE) !=3D 0) {
> >          perror("failed to set up stack guard page");
> > --
> > 2.56.1
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


