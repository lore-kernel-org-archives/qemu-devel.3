Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A03606A325
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dbs0GkmQ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AhIV6GBT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnLF-0002Hn-1V; Tue, 10 Nov 2026 10:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQnKJ-0002Ed-EV
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:00:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQnKG-00084U-Be
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 09:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794322795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=noGgIRsp/LqIFgSdL+GAYetddOTUc+9j5OAtYdXRfzQ=;
 b=Dbs0GkmQHv1qRPRnMWhB2L9Jvp2IELzLktQnNVDvA90CBIba88AcA5DuG5qf1WQjMCR9L8
 EXZhu2fzQjr/QIRbf+UY6p6pVwu8V7Jk5TDwL6KgcKtyNUuX3/yB3vq/6LnvUIqPNWLqML
 JeIdBRWd+OhV8kbo8KnT7RHOd8/Bbq0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-qB2iKVEMNFecIBk_yP4stA-1; Tue, 10 Nov 2026 09:59:53 -0500
X-MC-Unique: qB2iKVEMNFecIBk_yP4stA-1
X-Mimecast-MFC-AGG-ID: qB2iKVEMNFecIBk_yP4stA_1794322793
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-836caf085e0so21416327b3.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 06:59:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794322793; cv=none;
 d=google.com; s=arc-20260327;
 b=JPEFLowugr6C+4ge0niZxXRpZffYus5rHvHF8SWEgesXZubLL6Al9L9o7oBg6g0Y9c
 1lMMRVK7anzFOm4aUOvcL5wfzat8u3FdspdZ+kobg4kjDYzcGW2ygU8RNb7lGZzeYQHT
 3KHgdBGkC0CNul09UPO3Ghsx4Z2n0wAZFckG1LX5vesnaME9GMAJ+NFb+N4ogulZVJ0N
 VcsbXKFQakHfLDsIal4wKQN8u/z7kt5w1HmylU4uSFh9t1rPgUApjBo0Z3QKLYEt+wes
 DziugQFSniizn8xt+GK7zAV/pt3h8NbgwZOc9AO1DBw4wutVWknf2Ho2oVOQOrs8n359
 PbZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=noGgIRsp/LqIFgSdL+GAYetddOTUc+9j5OAtYdXRfzQ=;
 fh=LAyx3mfFXbRBPATRx1Fkx31vQAKfLNCUDosgEQ1FNls=;
 b=RT5cux455Wv10J8SHHcIdBh+6og0L0z1yh+mV9WbW9djlIeNYcUYikNiGZUXin9hJ8
 mrQtzhnRmz865SCyMjxkmUrM3F6+Wm7MMgtcOP71RqRLN66NmJxRa80OV7mmYV7KBLn9
 v+Ke1Po9FOPE5fSP11ncAz95o6mU6j0D24fqTNId5jzCdaisxMGaxfGHYOY55wll+XKC
 RriLScN5bBnCXe2sjbZRXufhjCq6COSwEzEbomjgw3IjVmoQMqClO0kgpjegago1kP8t
 pwitymv5khxJO2AO8p7X0fWAAJPGW/JAKaUQ0ctGloZCIKlhzB1X4sN2hJAht1BYbJoP
 VAyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794322793; x=1794927593; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=noGgIRsp/LqIFgSdL+GAYetddOTUc+9j5OAtYdXRfzQ=;
 b=AhIV6GBTSYIKYcxh2cmVGtoZPjUJF/BDCo8BZI3Gf3cPfA6KbnPCcpKsuJDsONSbfP
 +bX+DjcAJXkKpgGNL5FrGuAcIdrK+XnL2ArULb3X9O3uimsw3Q/Q6rCG6o5XcOYvTuoN
 UH8VfZWs0uvF/w9gQmYaTZUn1bc0HXd6xyTiMESD27tQXrGBxGSmLmVKGFqJM4LUQZTl
 QZVjyFCpdrsri+FN00x4KRSuPH8QASg7V7izqqSWFgaYnqac/G67EzZrdV7KpktCdC+b
 Yxf8zti6qk8O3E9bB+JT/egSs1KLb0n3zS7VrYmxChbZxl5X4PtU/3neg4vi39DYMt6o
 wSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794322793; x=1794927593;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=noGgIRsp/LqIFgSdL+GAYetddOTUc+9j5OAtYdXRfzQ=;
 b=zHDVa0LLNqCbo6t8MuyiIr7VIDqZWVVekzmPnFIoEXxmKou/fNHQjeIqkDNlFTRoSD
 unxWXLXVFsbQ/Y5Ciw/Mk37tLPH1xiuLRcyexNpRr2YIhnmckxqJj4E7mSCX6lFnRLO5
 y4g3U2v2QnzMPz41hKKSK+KyOpuKVT1Xa87tlElc7pQvhjUL0/p/afqNzf02VtDqhCGX
 8UrILm5ySI9GjcKjCBeL6MDWfpld/zw/UnMTeXS+hP1PkxSaEIUhKR6VDNno2Yz14OwS
 +CB8d1nmp9milDpCValfp0UxWKxDbCg+zCrWeojbJv+IuzfdMTqfOFQnF2TDIqwhHFAb
 yDQw==
X-Gm-Message-State: APuU4Z/ZqHH0ryDKiZiWoO9QOgb5jwJAmg+B6GDdkIJEliVU4pkK1uQ+
 1+Sb6eR+jn4eM5/cwvkMqd2Gm8qUsg2nyD22c4befw3kDGFxtSwOF0vntVsQ1GIlzzEBkb1MBp5
 VtSwIDqW/Bf6ERcqzwQXh3QR5N2BJG6k7TH0AAos0pk7zzFaJifqir++Nbx6NMMhvxON/wEPcxH
 dFWZKmNanVxU8gPOMsULvtvuo5HXLKIdc=
X-Gm-Gg: AYBFou28OCVGC6MU/xHMih3oCUn/q6cfJfGu9ygh3GJ5U69DSSlN4N1QoF5L5JEpKGA
 rBZUm2lT7byD1Lkd0Mz16EuIMatTtUnBg7LdGZFqApbC/CesZ8G5PhB5LONUpex4gB+b44n3mc0
 y+V/Ba0LI6+/4xuJY+dL9rNyF0RAU9f9XzU6gleV9jEwX2yVH11ebyCOby4BpNwPGDUbMOBqi/T
 n4BaT5jPVOdyWz2
X-Received: by 2002:a53:ed04:0:b0:679:b810:6df3 with SMTP id
 956f58d0204a3-67c568c72d0mr1315890d50.84.1794322792674; 
 Tue, 10 Nov 2026 06:59:52 -0800 (PST)
X-Received: by 2002:a53:ed04:0:b0:679:b810:6df3 with SMTP id
 956f58d0204a3-67c568c72d0mr1315871d50.84.1794322792214; Tue, 10 Nov 2026
 06:59:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109183605.3210043-1-jsnow@redhat.com>
 <20261109183605.3210043-4-jsnow@redhat.com>
 <avIeunGVydLiZ9O8@redhat.com>
In-Reply-To: <avIeunGVydLiZ9O8@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 10 Nov 2026 09:59:41 -0500
X-Gm-Features: AclHuK86s0uwPlB1DcbQgWTnzDZwEbRwFAXuD5iiTciWy1uD6UmU2NQyRVvbuiY
Message-ID: <CAFn=p-a+4_jg=Bp=Vy94GGaUgSBUOn51fpck76FjdUK5sQ-=TA@mail.gmail.com>
Subject: Re: [PATCH 3/3] build: Add "-d keeprsp" to Ninja flags
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 9, 2026 at 2:28=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Mon, Nov 09, 2026 at 01:36:05PM -0500, John Snow wrote:
> > When auditing compilation, it is helpful to be able to see all of the
> > object files passed during the linking step, which ninja can obscure
> > behind temporary .rsp "response files". Normally, these are deleted
> > immediately afterwards - but for debugging purposes, it is helpful to
> > leave them behind to understand what went wrong.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Thanks!

> > diff --git a/Makefile b/Makefile
> > index 54547a37b1a..9dda1b3c89a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -151,7 +151,7 @@ NINJAFLAGS =3D \
> >          $(filter-out -j, \
> >            $(or $(filter -l% -j%, $(MAKEFLAGS)), \
> >                 $(if $(filter --jobserver-auth=3D%, $(MAKEFLAGS)),, -j1=
))) \
> > -        -d keepdepfile
> > +        -d keepdepfile $(if $(DEBUG),-d keeprsp)
> >  ninja-cmd-goals +=3D $(or $(MAKECMDGOALS), all)
> >  ninja-cmd-goals +=3D $(foreach g, $(MAKECMDGOALS), $(.ninja-goals.$g))
>
> Alternatively we hardcode our makefile to raise meson's
> annoyingly pessimistic defaults
>
>   export MESON_RSP_THRESHOLD=3D126976
>
> provided we detect we're not running a build inside Wine, or just
> blindly assume no one is quite that crazy :-)

I'll leave this to someone braver than me :')

>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


