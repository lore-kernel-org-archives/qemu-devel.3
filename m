Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EECC5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuQ8S-000629-QA; Thu, 13 Aug 2026 03:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuQ8M-00061h-HD
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 03:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuQ8K-0004R6-VV
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 03:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786607148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qo90mwusqtJd4erUUSdS04fYZqAIFWQ0hw6l8D3peL4=;
 b=fP9N4LEtt0SvJ2kWPMPi/fCtK5PyW+n4ruQZ+LZtjuNsyrFETT8bX2rOa4kcVd9LfOjo18
 +nv8ckqAvneeIduCackwzb3w+J+Env1nEsaW9ES06YGar3t/A2j0KnyotoVdwtKFEkgJog
 Iyvwfb+44L+Ar0PR9b+P9Ulx7ooTax4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-lcd0f8gaPdeAO2d_GXyTcQ-1; Thu, 13 Aug 2026 03:45:44 -0400
X-MC-Unique: lcd0f8gaPdeAO2d_GXyTcQ-1
X-Mimecast-MFC-AGG-ID: lcd0f8gaPdeAO2d_GXyTcQ_1786607144
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84865f326efso539936b3a.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 00:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786607143; cv=none;
 d=google.com; s=arc-20260327;
 b=OSz2NNAxRd7jQe8kvaBotQ8BkVivU7zYg+s2tbb/iT3qEgX1YA5+iKVlJU9hv5sDSS
 vliKNLOZhSNyYoEmc/A3GVTBs8BV0rBK4qOaSwSE6pDFNTgZyWTgyOXdTKoErYXZ2zcw
 poV2E/zmrhz5mHIaToo14GbEmYwY/N6bTgNvAmatJgc7y07J12IrVbXUtmoAcTZGWKaq
 Mfoo2bQOcGWeC/4KUXefqOA394g75gXvr/Ipls2pzP4ofussL8tfwJTZGILwsbiMQeHc
 wBRWC+BoG4kgpt/miLbjB+HeWovm9qrsPUAaLLlJGAQ1n7Ba+pXe0pmY3wsuXopcJo2Z
 1Avw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qo90mwusqtJd4erUUSdS04fYZqAIFWQ0hw6l8D3peL4=;
 fh=/dMNiWP/UJp0ib95kJpEXmCAYazcCM53J8+UCiPYHqE=;
 b=pIDu3c0Xklh15cVmcl/UofJVZq93FblcsXdP6XyRfTSQcCQL4ue5vn6JpPKJZzIoaQ
 ZPsSUdw99jDV13Y0VhHOIwpKW2yRK1D1cEQtAjncHJeH79YXuFbbdxSFTH88xt5SrZ02
 aeZKFfqGGl0zcuwDVou2HncV5aEAOBYA0HHS0GY+twVxAOvnchsMIzWs2faL2Jgi5q+2
 oNz2yFjvYHEKeXdEaQKJK6pBGw6pJg/q6dtBaIdl4C85g9az61oK4wfqnz2Fwent8qFY
 o7tmPdGAJI1mc1x3fiqn/D7IlDtIz0M0sF9b78uhG97ycC5Cz3Gv9qLKGZXiqNRp1DGm
 04Kg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786607143; x=1787211943; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qo90mwusqtJd4erUUSdS04fYZqAIFWQ0hw6l8D3peL4=;
 b=IcBQ1q/JcF4drgV5GzjeWoeVnlfyED8JoACBpxT5E/VLVvU5aMc5uKN6DJLteaydA/
 Qu09YJlTxbQXyajjU29xJCTUVp5xxyyoB4TACqmYhLjXb9IN/etWTRaFAPXtZJiBMO7O
 EKQT5L7CEds8AcUnOmS51IB88Ue3g9uLpj2JdMvNz6JTfYyhkle5RMt+ImDxr75Lyyyh
 bW18jeZ7EgPLJZ3CPOWxcE4wG6YCEnSc7iSNezKnyDpGUnTNfpam2MMdBqI80Lx4/COa
 h2D0Prwm+4S9nKJIioxAnS7bUpBztNoXm4WzQ0YAlL8+YzQ9sSj7sBSlzjcRDlKj7vZD
 T/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786607143; x=1787211943;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qo90mwusqtJd4erUUSdS04fYZqAIFWQ0hw6l8D3peL4=;
 b=gVNITBpDPLVXTuBwompq+ZUHXq8KLbiaXh3dpXoiIyqJswVPKnn2FMxsfXCmHpllOz
 oO0+64ZMwdC7Z2bKwppjJd+VJcZKZARjI7C5BVpjr5aYVTM573X/4ncGRjmojikFghcR
 QeYjre710mXrFish5DTX3myRzx9tmsg++KmjIhrEcCYH5QaEToIuFadrmrzmhl10h7es
 X5BhlMfVok8LFWMcNjQ/q21RD5yR6QeXOW+HnexAqaY8PwOHPZEpb8jjpxyCg3c8dTxu
 pMapoFEYXkYDRuF67k2C8uFa9QpvYHEaGmJCRfZb+KA+AAMjcoXZUivKoJH2jETsRDHK
 yOtQ==
X-Gm-Message-State: AOJu0YzbjJmwE+accUf7ugzkPNHMLPPd4piC/1QMsT9ybJ2+F2cuRDFf
 ChVdiCSqmMgsq3reLgBIRseMT2a0hY1sK4A8plTpRcL6RJo4BGRn2jFHUBT89o8oDhOzXaFClq0
 zD8zMxSSPg2ofy4ZKyGaYa/iOyLLUilVAIfrzf8rJAyBzWrs1di4deukCAplJojR9hunN/anh1C
 GeBYah8GIIGH72fSpas6iAAKoeijXn5lc=
X-Gm-Gg: AR+sD13MMOjElhCeK8gPYo3a/Y6RlrZ3JN94nexpnxhr/WzMq1oUF8aK3U8zUxz/N1u
 WPxq/KnagUv4vSBEFHL1E0DN3+LxEiaGGsF9xMZjyH5x6tHGNHC+MuxwpWXM5WPGMVBlPJ0n9cy
 Gsf7ZsAEOa48YQG3VXgHDri2xQNdt6L7XD4rL8oAiCIMfb+j3rq9lcjNC/JDRrhhBmRqwsmaJBR
 T9Rwcaddlx/NthAuWurxtzWkzw+adM7Na/TxZ4QPy15r7ZJNo87U62M4Sbbz97uo+uCU7x/XBf7
 Iw==
X-Received: by 2002:a05:6a00:4504:b0:842:2419:6bfe with SMTP id
 d2e1a72fcca58-84fc6c848b3mr4345652b3a.7.1786607143524; 
 Thu, 13 Aug 2026 00:45:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:4504:b0:842:2419:6bfe with SMTP id
 d2e1a72fcca58-84fc6c848b3mr4345604b3a.7.1786607143040; Thu, 13 Aug 2026
 00:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-4-cc9396b9c18c@redhat.com> <8733wqtrtb.fsf@pond.sub.org>
In-Reply-To: <8733wqtrtb.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Aug 2026 11:45:31 +0400
X-Gm-Features: AUfX_mxGWSqJ9NunSwKve5NUAZ-An1fUgY_aL39T0TGrHlLuaN7zmyM80ONCbUQ
Message-ID: <CAMxuvaxcB_-=_5hrcn5NVZYimdfeBrscSpX7mXLPFxT9ykbXbg@mail.gmail.com>
Subject: Re: [PATCH v2 04/53] qapi/backend: wire up type-infos generation
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 7, 2026 at 9:37=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Call gen_type_infos() after gen_introspect(), passing the name map so
> > type-info constants get the correct masked names.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi/backend.py | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
> > index 49ae6ecdd33..353f7801149 100644
> > --- a/scripts/qapi/backend.py
> > +++ b/scripts/qapi/backend.py
> > @@ -8,6 +8,7 @@
> >  from .features import gen_features
> >  from .introspect import gen_introspect
> >  from .schema import QAPISchema
> > +from .type_infos import gen_type_infos
> >  from .types import gen_types
> >  from .visit import gen_visit
> >
> > @@ -62,4 +63,5 @@ def generate(self,
> >          gen_visit(schema, output_dir, prefix, builtins)
> >          gen_commands(schema, output_dir, prefix, gen_tracing)
> >          gen_events(schema, output_dir, prefix)
> > -        gen_introspect(schema, output_dir, prefix, unmask)
> > +        name_map =3D gen_introspect(schema, output_dir, prefix, unmask=
)
> > +        gen_type_infos(schema, output_dir, prefix, builtins, name_map)
>
> Squash this into the previous patch?

ok

>


