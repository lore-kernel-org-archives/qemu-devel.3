Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F99D26D94
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 20:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJCQ-0001CD-Ml; Fri, 09 Jan 2026 15:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veJCN-0001Bw-DN
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:35:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veJCL-0004wb-DB
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767990904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uBgRj/d0NCpsWyyO6BhJdHolKVxgc+AaXa8HEyZ4OMI=;
 b=OywjB73qoIYMiRnjVNfJvmU6edNSJhEsHTl3uBYfzgpsJN/bHijIQ66augem3y7bNW6Vgo
 Ly2BjYJlDJZJb7wrM10Fn0swVZdakGB246xWr25/4B19YuINnl+2zRmcQWVzYC2fvAJzHo
 gkQm6EgXyquZA/azsNBSg1Sn5zOw7NM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-xmS98a_YMe2CG0Zw5sugog-1; Fri, 09 Jan 2026 15:35:02 -0500
X-MC-Unique: xmS98a_YMe2CG0Zw5sugog-1
X-Mimecast-MFC-AGG-ID: xmS98a_YMe2CG0Zw5sugog_1767990901
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-432586f2c82so2192265f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 12:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767990901; x=1768595701; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uBgRj/d0NCpsWyyO6BhJdHolKVxgc+AaXa8HEyZ4OMI=;
 b=V3g1xq+lPyBtDXct2hjOQB86mjO6xwSQzXO2lCs8dnUvTzL904ARQABUiVePfVtOZ5
 SUvYL55qqpkDTMQ0dhYYJfGWssSXwqL8gs5VhlFkXTydv3KHi2ZY5lNygDRRwLl8wDbJ
 RvF+xtA9T02wEvgkuLPxPYfG8Rr7nyd6h+RxjPhKbvZb+JZTcczHEIgziviT8p/lfLSt
 9CrE8P06NfvKIejibigqEe9mG3ZLf4XyxTa+qhl7udgzWpzQi0LkROmb+bpRYYlNVmOO
 tkDQ+pgmIvSBvzuGUyHlfeAWQXef9Tyexzar81pfGz5C3gxAqiSOIimrgPn8ifzLLSi7
 2nOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767990901; x=1768595701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uBgRj/d0NCpsWyyO6BhJdHolKVxgc+AaXa8HEyZ4OMI=;
 b=N7i5141lhMlZIRKHT7XSPfWojnP2SE1DEE+ODN+mOyWGdJ5jwVhaR99C0+Ub2eGvV4
 E0IGZquarBIilNLp93Gyo8J4qyZ2mKYN4OJffESb9uVpibvQ+KZybqPKStzhlAwzUIeD
 VMw0B+vnyt57KEpLHX6+FYeCHBI1ovKZoihNMPiLvpeMMvGFoY7w5tP/QVkOyuOmvKMf
 EIG+eUsI+IuU66CgR/kP3s/Ks7uqMFFXwITuDJ4Oh9zQmqaQqV/eJo5eXfix+BCtwRxr
 h8tmHA7VV/WgKw/ZaifdxSs5f9BLKXedj3fFv9cJAYBWZhnpKrtwRuh0nagnZ8dy4qCb
 a8tg==
X-Gm-Message-State: AOJu0YyDomqQNGiiERIZKX1sBOIAHfeiYd74ymAjygB3o/7QBz1wzZQ7
 6Rolc68rLKlvi7kU2jWJA84T47FBnMLrK7paF/HT2dWkWTohOvtuTYjjQzXIMvNgZJ2z9E9uVKD
 Ipe1ZtQjmULR9/LOcPwNA+Bl12iL5f6lPnzO3jiQnIJ9Ixqz4IixrCKdDiMCJatW/NYbUuBNWqK
 HHbG3oKL41ShGM6Hno+gFeXTUSlT1Dhdo=
X-Gm-Gg: AY/fxX7sFN2Uap26fjngZGbz2y6HjYitrqiUKQNSZ2z94MTfHot/t1oRwxnQOVCT3r1
 0FtR/lY9GG0pGe8xaVxkhHAtnXF7H+MrBKt0k4oCFiiSmeNFgHCgUxS36FPWCzMOI5mlul6/hzd
 AwpWuFtMzMvBYwOVofkwNsjvzjFyp8fgLSEbZmZ0zdFaUrWhBAuAJ+gWxZukVbs8t+OfSeSZlxc
 nzQ0HxlS8J4Y+iCozY2wKsKHrNmZywa0vGqYy/XogAUOxmlPJ6lYdFPTEdZNI/X6t5HKQ==
X-Received: by 2002:a05:6000:2c0f:b0:430:fca5:7353 with SMTP id
 ffacd0b85a97d-432bcfa1031mr18414163f8f.8.1767990901135; 
 Fri, 09 Jan 2026 12:35:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYZ+g396moRdMy+XdN/Vx1GDjnlOiwhHOTpjQ8PQwnxsRsN0YSb3gAOVs+Z7PhqHMJVqd3bqisoV1HvzfZonQ=
X-Received: by 2002:a05:6000:2c0f:b0:430:fca5:7353 with SMTP id
 ffacd0b85a97d-432bcfa1031mr18414145f8f.8.1767990900785; Fri, 09 Jan 2026
 12:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-16-pierrick.bouvier@linaro.org>
 <73ac5b61-ebd1-4451-884f-0b78eaf0ff02@redhat.com>
 <44f59945-0de8-48e7-91da-6322182b4721@linaro.org>
 <CABgObfZ6qCCS89u7i+QW=FU-_aKe9ytFuwqFHNEqNNLm6=tEEQ@mail.gmail.com>
 <a89124ba-3011-46f9-884e-938586c46955@linaro.org>
In-Reply-To: <a89124ba-3011-46f9-884e-938586c46955@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Jan 2026 21:34:51 +0100
X-Gm-Features: AZwV_Qgk-9eGru22W6WLL0t8gv_R1XAtRHrB7bOhh45rpp2yi66Cu46K1yNnvDY
Message-ID: <CABgObfYdW93DW5m=S-3f9MNZ+ovE+Dx0+=V1wmVzOP6e=UZbLg@mail.gmail.com>
Subject: Re: [PATCH 15/29] accel/tcg/translate-all.c: detect addr_type
 dynamically
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: multipart/alternative; boundary="0000000000009b983a0647fa75eb"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000009b983a0647fa75eb
Content-Type: text/plain; charset="UTF-8"

Il ven 9 gen 2026, 19:38 Pierrick Bouvier <pierrick.bouvier@linaro.org> ha
scritto:

> Do you want to see explicitly .addr_type = TCG_ADDR_TYPE_TARGET_LONG
> everywhere (except arm which specialize this), instead of relying on
> default value?
>

That would be one way, but in the get_tb_cpu_state function you *could*
return
.addr_type = TCG_TYPE_TL, even if it's not constant, couldn't you?

Arm would specialize it, but the other targets don't have their
get_tb_cpu_state function in a common file.

Paolo

Or do you expect something different?
>
> >      > Also, please call it addr_type since tcgv_type makes less sense
> >     in the
> >      > long run.
> >      >
> >
> >     Ok!
> >
> >
> > Thanks,
> >
> > Paolo
>
>

--0000000000009b983a0647fa75eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 9 gen 2026, 19:38 Pierric=
k Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro.org">pierrick.bouvi=
er@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Do you want to see explicitly .addr_type =3D TCG_ADDR_TYP=
E_TARGET_LONG <br>
everywhere (except arm which specialize this), instead of relying on <br>
default value?<br></blockquote></div></div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">That would be one way, but in the get_tb_cpu_state function y=
ou *could* return=C2=A0</div><div dir=3D"auto">.addr_type =3D TCG_TYPE_TL, =
even if it&#39;s not constant, couldn&#39;t you?</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Arm would specialize it, but the other targets don=
&#39;t have their get_tb_cpu_state function in a common file.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
Or do you expect something different?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Also, please call it addr_type since tcgv_typ=
e makes less sense<br>
&gt;=C2=A0 =C2=A0 =C2=A0in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; long run.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Ok!<br>
&gt; <br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; Paolo<br>
<br>
</blockquote></div></div></div>

--0000000000009b983a0647fa75eb--


