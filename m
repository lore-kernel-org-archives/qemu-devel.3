Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC70C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNrL-0004gd-TL; Tue, 18 Aug 2026 13:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wwNrJ-0004ZB-Ip
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wwNrH-0008PZ-0F
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787075057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KRNRdUsigN3fYihqJNVjQLMyHylRcTokEV0b8Up8PC8=;
 b=co18Pl858J9WSDsG9mv1DIXcM7nx6MEIYyoaMtffO24QS+NXhs7r5eM1I1gWcwprn8uk/L
 SOykLgKDJS60tLrVKGcQkdLbgoyw3J9/K5S2VuPjaXIuavfybQJqwVqYCGGwRa7CRbcT//
 +4uIk1pWposkW7a2ti6tf5bv63nvau0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-dunzfPHQM6WUiVUsQfDUmw-1; Tue, 18 Aug 2026 13:44:15 -0400
X-MC-Unique: dunzfPHQM6WUiVUsQfDUmw-1
X-Mimecast-MFC-AGG-ID: dunzfPHQM6WUiVUsQfDUmw_1787075055
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47feac2021eso19336f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787075054; cv=none;
 d=google.com; s=arc-20260327;
 b=Vw7gd7R898v+Tlnm8gd2Bbcy+DikW28pYSkUQ0eGefk23rlRxjoTKjmZcQ4Cx5JGFN
 j7ZRt1fOpzdrSg5i8dDlpTbzH1XppR279oVusfU81MkLlbCOIYpqZ5vWzTo2HRvj5Ond
 NQnMfhAHS7+l8jQkwHvuXgbic+3lXm4ez0xcODLD1I7Dl9wwumalDx8cjoMWb40h9fLt
 OWK1KOXEnVwLxkhWfJRhywZqBALnVF6+scLhJR1Am7ceB2AQQt0AFkHBzzhrcbtmeKch
 ltXaJWHOQsyJzgSpOkstqPW2UTFStJG5wp3aMHqu8bCof8nOQy7ioYEKaadpyu1XPXcH
 YOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KRNRdUsigN3fYihqJNVjQLMyHylRcTokEV0b8Up8PC8=;
 fh=qS+XlxfZEiyHDJVjYGATJqBgBx4KVTOneSG+muUkCzo=;
 b=qSpbFVFjkfVFxsg634hIdFWz13y+71h2S3JwiGygOxxlkhQvnid01tmD7ut2taCHWn
 g+SYAPY1cUTD9XyuaBg6mPv7yAanMsNU8l954ZW5vncYKz/3eOo7LhCcFiAy9L+9YBMB
 BSdWYcFUDlGCkL8wDkVcUW+cHxKHBH2Kk80SNk3xW8cFlNZaAj0bRPCuR/UKqfYlLK2i
 BsXabVzia52Eky2obpjEk3H179Zaf+kigf4wauaebEkTp6tElwhaxtgzG8l5mELZ+6ht
 rPVTc2Ke7zXdD8Y4hJqNkplvc4FKnMaiR/2PP7KF6PXkCq8z+c1yjztLHLqPK1ZaftmZ
 S56g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787075054; x=1787679854; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KRNRdUsigN3fYihqJNVjQLMyHylRcTokEV0b8Up8PC8=;
 b=lOFe4HIWz5J8D5Kj+8lLVhuGn6JTmzqJ4TV0D1wITkExEgu51fSq3jmmqOsAnuKES8
 G9sdU/Bben0plxkIhd4ooRFkvBtK49bAj4xFIPxEdAZl5hcI4AoJD/CTxPzTaDpawrXu
 qASljyBB+ssfd99llfiCzhk8S9fLcCmKjx0MAmzsQU9kyNli/oX0kOBi0ZFKFagxIGz6
 hsWZ2Cc3av20kmsRdXVxONdBz3c/gHErPP2NtVUyoI1j/eQ8dws+870owD4cTCgbJdEr
 i+XGQEnyjEBf2c1G3OAAj3Hn4LgGDzoBU+BhVrN9fffTKHz/KYiqj0sMBzXbfphvs0UZ
 wYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787075054; x=1787679854;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KRNRdUsigN3fYihqJNVjQLMyHylRcTokEV0b8Up8PC8=;
 b=N3g/cfjXsUQkv3cBgvhJh+glHLVkmEhHjR4qKYNy1id5PEhZuGhrfUAwpgB0sUf9Km
 mgYUIXF+yhIMxXXpL6mbhGb5Op7PBHxV1zBjS7kjTaQHwGEhhnI9nNZ9L5XVKu7SrHyJ
 IPVZ++twpzSuZYT/jVnWqYIEliXLL+AC+DBNI9LOGoSElnyCEbiJ9ORC+oqqELBw3B19
 fGOoVANLTiqAVQkitWhgVPCrvR1sbd880S/86/39QJlXG5gadS0o58heCoOx1whec68U
 gpOqtIkTVkcIsW3RSerFEeiSf45L3AmhPYLlndkuLlYWY/bMcjGDVhi/TXqYwajRT7Eu
 R1Nw==
X-Gm-Message-State: AOJu0YxSSCsvpsNBBjUSubKa3XaQUnFkX2/8I0CYDZ+mViOWwkzOMgtO
 R9ZaOiCNjWAuH4HIgwNk0wpFg+ADJI/alFnh9XfPBmsjHGAWg+k5QCgxbfX4hiROoGh/miRQXyD
 HQRjrBUP4heBXzmZuX7mdlv9XBT+pyIA4MxmAApZzrcWlIJxFeVIjmsyrolRXBWmeXvtHfBU9Mj
 Ev4Jb+xW68M7ALgrkWnoXMkZvk+UV5XXAqkgMbRyE=
X-Gm-Gg: AR+sD11RKPIUvYVcECrmd0X/gN9XWKayheHaK3UMRPCcHTNwxPBRPtG5SHT6a9X5LAv
 etXnZQB8lI/EGTvYD5tgysxRIMZ/qyP00ftjPrH9J3E30/DbNjInp5YIVLoWE6wwCDHYcI7N8g+
 09jxkU8nZ48MqEld72/XnyNTby2FzXaslHkbgnIXpgEDAKJlKKO7cXipYkHm4jg0tnn//TePcX5
 TI+dqJ/9nDsfO6wnF1lBsUDwvobz8C5RxxaFzGqUafusRL8PQTXx/xYOtU=
X-Received: by 2002:a5d:4b45:0:b0:47f:8f8f:db74 with SMTP id
 ffacd0b85a97d-482a908a3ddmr14300698f8f.12.1787075054534; 
 Tue, 18 Aug 2026 10:44:14 -0700 (PDT)
X-Received: by 2002:a5d:4b45:0:b0:47f:8f8f:db74 with SMTP id
 ffacd0b85a97d-482a908a3ddmr14300630f8f.12.1787075054112; Tue, 18 Aug 2026
 10:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260818142836.1664990-1-pbonzini@redhat.com>
 <CAJ+F1CKuBR9TWnCzTjyFC=6Xn8q9ZDiXRXSoD+6if=cJRDkPMw@mail.gmail.com>
In-Reply-To: <CAJ+F1CKuBR9TWnCzTjyFC=6Xn8q9ZDiXRXSoD+6if=cJRDkPMw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 19:44:01 +0200
X-Gm-Features: AcwNN1WbbrYLdnbkZoRYqpxjIOU5lCb2JFAtpX_pi_n3mrBtVo1i4xUbvDnW8XY
Message-ID: <CABgObfauvyUoptW8GBizUu36S=CpYL7LQ582sPgoEHnnJYAzow@mail.gmail.com>
Subject: Re: [PATCH] serial: clear transmit retry callback on unrealize
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000c9ad0d065955d5fe"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--000000000000c9ad0d065955d5fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 18 ago 2026, 16:42 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.co=
m> ha
scritto:

> Hi
>
> On Tue, Aug 18, 2026 at 6:29=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > The GSource is removed when resetting but remains active (and can
> > cause use-after-free) on hot-unplug.  Remove it before the character
> > device is disconnected.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4125
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> it fixes a use-after-free, so
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> But should we care about flushing pending data?
>

To where, :) since the transmit channel was not ready?

Paolo


> > ---
> >  hw/char/serial.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/char/serial.c b/hw/char/serial.c
> > index 0729cd2ce9d..4339562ab00 100644
> > --- a/hw/char/serial.c
> > +++ b/hw/char/serial.c
> > @@ -936,6 +936,7 @@ static void serial_unrealize(DeviceState *dev)
> >  {
> >      SerialState *s =3D SERIAL(dev);
> >
> > +    g_clear_handle_id(&s->watch_tag, g_source_remove);
> >      qemu_chr_fe_deinit(&s->chr, false);
> >
> >      timer_free(s->modem_status_poll);
> > --
> > 2.55.0
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>
>

--000000000000c9ad0d065955d5fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 18 ago 2026, 16:42 Marc-A=
ndr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com">marcandr=
e.lureau@gmail.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Hi<br>
<br>
On Tue, Aug 18, 2026 at 6:29=E2=80=AFPM Paolo Bonzini &lt;<a href=3D"mailto=
:pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt; The GSource is removed when resetting but remains active (and can<br>
&gt; cause use-after-free) on hot-unplug.=C2=A0 Remove it before the charac=
ter<br>
&gt; device is disconnected.<br>
&gt;<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items=
/4125" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/q=
emu-project/qemu/-/work_items/4125</a><br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
<br>
it fixes a use-after-free, so<br>
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.co=
m</a>&gt;<br>
<br>
But should we care about flushing pending data?<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">To where, :) since the trans=
mit channel was not ready?</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"g=
mail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 hw/char/serial.c | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt;<br>
&gt; diff --git a/hw/char/serial.c b/hw/char/serial.c<br>
&gt; index 0729cd2ce9d..4339562ab00 100644<br>
&gt; --- a/hw/char/serial.c<br>
&gt; +++ b/hw/char/serial.c<br>
&gt; @@ -936,6 +936,7 @@ static void serial_unrealize(DeviceState *dev)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SerialState *s =3D SERIAL(dev);<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 g_clear_handle_id(&amp;s-&gt;watch_tag, g_source_remove=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_deinit(&amp;s-&gt;chr, false);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 timer_free(s-&gt;modem_status_poll);<br>
&gt; --<br>
&gt; 2.55.0<br>
&gt;<br>
&gt;<br>
<br>
<br>
-- <br>
Marc-Andr=C3=A9 Lureau<br>
<br>
</blockquote></div></div></div>

--000000000000c9ad0d065955d5fe--


