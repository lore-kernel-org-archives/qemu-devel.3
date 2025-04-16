Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9D8C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4z7d-00034q-5y; Wed, 16 Apr 2025 05:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4z7Z-00032l-EL
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4z7V-00037Q-OW
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744795908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=skqtdhN7QA0IcUoH1fCyWPFAlYDxTTbWK90TW3BN9pg=;
 b=d9bfqHVNe75dzQb8HqjB+yO3qU8HxW/8+W/HV4sQnthlBHw/S44jQw77GnI1JU4bCG0wuI
 hku195j2uE5XL8VJxvD/CeRKBrAuuUZcuniJfdmb8GCj8ZthP8Es0X2S443Dyz/SHVKSs+
 QYogAilXRP+qzfu+I55G0Q9dYZeGTso=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-U7D2O42HNJG_k30ipD3CzA-1; Wed, 16 Apr 2025 05:31:45 -0400
X-MC-Unique: U7D2O42HNJG_k30ipD3CzA-1
X-Mimecast-MFC-AGG-ID: U7D2O42HNJG_k30ipD3CzA_1744795904
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912d5f6689so3598324f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744795904; x=1745400704;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=skqtdhN7QA0IcUoH1fCyWPFAlYDxTTbWK90TW3BN9pg=;
 b=HllGLEED8TQUi/cYa6nbTiq2iA3sLoCbzxhatf54+P5MN5wl85suqWeameM1COU8W3
 3sgO0pNxXWapJsvoOp8d3huFPUDr/VJ3Ni3dO2ik3rMkgF+V5f81YgWNnVIrBdBrR8WP
 GmfNWNwBA2wTcrmLmcnr+XRPeGUi2eMvvTcjjg8KDTFDIC/hUgnIGJjwPGHrHTNeOcXY
 fbsR48mpBHgDAP/fUETxTaW+0QOeIWn+lSE4P7XhYqQQakMzdugZPCKT7gRRCvxtnGaR
 BKMW4QnYNge4eKNZ57q/hUydzeMVKuDlVIylzJtKzJWhLLtp28oS+SraaQolIHqikTfz
 Yeag==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6kgK7SF297zhlSVQKKnmzH1Y9IMhxkzqwXt5cNax6eNTG7WJZBQnA0zX8NLl7dZv+pS4GHTqSmRG/@nongnu.org
X-Gm-Message-State: AOJu0YwP5T5tI8EbTo9r/HaczsZWCGy83BJQdBfl+cLZHWHvMRTFLZYf
 hgghZJej6zRAzEwbjk7TVUEn3a4awFkorQGmCL2LxrguBRTj81KNjxGj2KFJtogzgpsjWJzVp15
 br9DTT/aDLdy17PaVTGfT5gqizBNc+HAOFDDTkESOiDy3NKN1LyRlAXuxqusPfAgCt+C87v6v3y
 9AudCn0W6BuXf3Uki112tF4YrNE4w=
X-Gm-Gg: ASbGncvrK7vF3CGPIFLOrbXMfl0IwTF75zU6d8MjRw5owpM60Qok7uR697KyHxnp6sC
 SlnrupQ16i723u784H96L09R55GGXyqIpNnjmq37ImZawWYmDw+cj+/RofSDD4pHPpiypqQ==
X-Received: by 2002:a05:6000:2489:b0:39c:12f2:2f86 with SMTP id
 ffacd0b85a97d-39ee5b1393bmr860315f8f.8.1744795903943; 
 Wed, 16 Apr 2025 02:31:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcIxVV+dMChUV63DYn4QjoWWK3NdcMXuQuPjvWVtigTS84i6TNiKoLblOb/ZQTgJn++vmQgHmnPdcMni+BvUc=
X-Received: by 2002:a05:6000:2489:b0:39c:12f2:2f86 with SMTP id
 ffacd0b85a97d-39ee5b1393bmr860296f8f.8.1744795903544; Wed, 16 Apr 2025
 02:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <44e9ef95ea6e8aa33560ca8580db0033623f0e91.1744787186.git.ktokunaga.mail@gmail.com>
 <Z_9qIQhjsI5zOwXA@redhat.com>
 <CABgObfaj0ycyc2jVSJEVvQJ1m+uLf=_HYiOafn2MECgU36aspw@mail.gmail.com>
 <Z_90aqNE74sonn8O@redhat.com>
In-Reply-To: <Z_90aqNE74sonn8O@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 16 Apr 2025 11:31:31 +0200
X-Gm-Features: ATxdqUFJ48Fhcc32Y40PChLtT5VWGv4yNFczwgamedATrI6jPJV30diLkw6OozY
Message-ID: <CABgObfaNAEsRQrr8O8fpuGGoQHq14Q_niBnQf1Yj4iD33a0LVA@mail.gmail.com>
Subject: Re: [PATCH 01/19] hw/core/loader.c: Fix type conflict of GLib
 function pointers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>, 
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 qemu-arm <qemu-arm@nongnu.org>, 
 "zmta06.collab.prod.int.phx2.redhat.com, list@suse.de" <qemu-ppc@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000000972e20632e1f4de"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000000972e20632e1f4de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 16 apr 2025, 11:12 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> > I suggested this solution to Kohei because it's easy to check that we'r=
e
> > converting all users and not introducing new ones in the future (see
> > poisoning in patch 10).
>
> It is easy to check this /one/ example, but this pattern of bad casts
> is typical in glib with likely many more examples, so avoidance in this
> way does not feel like a sustainable long term strategy to me.
>

If you refer to the general case of function casting then yes, I agree that
there could be other problems in the future but that would have to be
solved in glib.

However QEMU's use of glib is overall relatively limited and for now this
seems to be the only case we hit. What this patch is doing is both
effective at solving the immediate issue, and future proof.

Paolo


>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--0000000000000972e20632e1f4de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 16 apr 2025, 11:12 Daniel P. Berrang=C3=A9 &lt;=
<a href=3D"mailto:berrange@redhat.com" target=3D"_blank" rel=3D"noreferrer"=
>berrange@redhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">&gt; I suggested this solution to Kohei because it=
&#39;s easy to check that we&#39;re<br>
&gt; converting all users and not introducing new ones in the future (see<b=
r>
&gt; poisoning in patch 10).<br>
<br>
It is easy to check this /one/ example, but this pattern of bad casts<br>
is typical in glib with likely many more examples, so avoidance in this<br>
way does not feel like a sustainable long term strategy to me.<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">If you refer =
to the general case of function casting then yes, I agree that there could =
be other problems in the future but that would have to be solved in glib.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">However QEMU&#39;s use of=
 glib is overall relatively limited and for now this seems to be the only c=
ase we hit. What this patch is doing is both effective at solving the immed=
iate issue, and future proof.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer noreferrer=
" target=3D"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =
=C2=A0 <a href=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferre=
r noreferrer noreferrer" target=3D"_blank">https://www.flickr.com/photos/db=
errange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer noreferrer"=
 target=3D"_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-o-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138=
.berrange.com" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">h=
ttps://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer nore=
ferrer" target=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=
=C2=A0 =C2=A0 <a href=3D"https://www.instagram.com/dberrange" rel=3D"norefe=
rrer noreferrer noreferrer" target=3D"_blank">https://www.instagram.com/dbe=
rrange</a> :|<br>
<br>
</blockquote></div></div></div>

--0000000000000972e20632e1f4de--


