Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD659C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ydw-000249-Pq; Wed, 16 Apr 2025 05:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4ydu-00023n-E4
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4ydp-0005XR-Ed
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744794068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t4cUu06qS+cFN9mZzfjcJYWfoQ19aC/j63DrCIx4FSQ=;
 b=QjqGBAGh49g9+uKVwgabGxsM/ey3qBB2lFzpj15fGe/HX5kn1QHjJx2iNyCdVUyKBJTA/4
 keR/0vvOhicv+Sv6LsXypVCk2sTs7YcupY3kNXMeXaT/FeLw87RXTIAaKX9FRj97kVbQvK
 S6xQk/qoC6g7TssMllsh/WTka7nlxEU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-CwgsROHvOleMVs-Y5vG6Ug-1; Wed, 16 Apr 2025 05:00:52 -0400
X-MC-Unique: CwgsROHvOleMVs-Y5vG6Ug-1
X-Mimecast-MFC-AGG-ID: CwgsROHvOleMVs-Y5vG6Ug_1744794050
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso2541847f8f.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744794050; x=1745398850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t4cUu06qS+cFN9mZzfjcJYWfoQ19aC/j63DrCIx4FSQ=;
 b=E6njo4px+h+Oq9jr/zl+2abHrVF2Fv5Fu9LyzWXAom4p3grjEqqZ9kRmE5fC6Sn9Zx
 S3N1vDAIwSHGt2fOC4nGXnsj0djijfVRCC7aMJYyOzzMLrI2m6hjRmQNO6YI0yQ+xsCA
 r2X0k9wHJsBp5PpzeNIm9f1HwFklIrCpPQtkYtfJ4TmAKdYEgSMcCmq3f5qy5YqmJYav
 az3QI+wKl9x5blgmtIHdGTQ3TQuaAEuyeQJ4PAs2CSjJA35NawYdcqGVuTWIF4wL+Z4n
 ZmIQUosr3Bq4g3aase/6vX1E0An6YhkNJQxM8gCJxlyne+LKj2QSDg0V2q0sm8wkdPAO
 rSew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXVmdie8yKqqax3+PK6JpUs6w+IzQE2tsfRKdaMSak79KI5Vl7nTsqKtfTe4j/QPdxFfE3b9L02/gq@nongnu.org
X-Gm-Message-State: AOJu0Yx6zS+01mfv0IRQI0PO2/rY4G7d03gwlEV7OWtzSrG2MHSXULfK
 S/1Uj7DFoU9v5L1Bw8IXCH9QfjeC2ZrUIsoMVJG4k2rLiiBkZKmpYHz79e9GC14LbSb8Uqmfq42
 Bddy+pevGvUM5huqUu7KfHPuDBtDtgtL534HaeMzs9PH7jtbFJurc+8q2WKn569JHYR4gje4dEv
 l4IEzRuAig+hDsdZsEk6v3fvRvYfI=
X-Gm-Gg: ASbGncsO0TH89f5fY9XzrcvqW76RoRIqq8XoOb9TsPwzCST1diRNHTZAhVivqLkGdrF
 ilsEFtj/73uL/deL+le/oY2iJCym5dK+hgC65dALgIQuNgGxQUgHnpoC28NOUSZieJEOZjw==
X-Received: by 2002:a05:6000:4282:b0:391:4231:40a with SMTP id
 ffacd0b85a97d-39ee5b35cc7mr868402f8f.33.1744794049957; 
 Wed, 16 Apr 2025 02:00:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj0+ccl+XK8tbzEj/nsGfAwLeEoY8WarkpDtVV3VQFp9ObdgD98L1kk0o7dIu7/JFArmGrwmn61FmlkqM67gE=
X-Received: by 2002:a05:6000:4282:b0:391:4231:40a with SMTP id
 ffacd0b85a97d-39ee5b35cc7mr868327f8f.33.1744794049313; Wed, 16 Apr 2025
 02:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <44e9ef95ea6e8aa33560ca8580db0033623f0e91.1744787186.git.ktokunaga.mail@gmail.com>
 <Z_9qIQhjsI5zOwXA@redhat.com>
In-Reply-To: <Z_9qIQhjsI5zOwXA@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 16 Apr 2025 11:00:37 +0200
X-Gm-Features: ATxdqUF_yxp8UmiitEgBJlwXgw5fD6l4Tq_i7Q_t6dBFJg29p48TP3GllPE74hs
Message-ID: <CABgObfaj0ycyc2jVSJEVvQJ1m+uLf=_HYiOafn2MECgU36aspw@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000841ee60632e185e4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

--000000000000841ee60632e185e4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 16 apr 2025, 10:29 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> > -    secs =3D g_list_sort(secs, sort_secs);
> > +    secs =3D g_list_sort_with_data(secs, sort_secs, NULL);
>
> I don't see what the problem is with the original code.
>
> The commit message says we have a bad function cast, but the original
> method decl is
>
>   GList *g_list_sort(GList*list, GCompareFunc compare_func);
>
> where the callback is
>
>    typedef gint (*GCompareFunc)(gconstpointer a, gconstpointer b);
>
> Our code complies with that GCompareFunc signature.
>

The cast is inside glib; g_list_sort casts the function pointer and calls
g_list_sort_with_data.

I suggested this solution to Kohei because it's easy to check that we're
converting all users and not introducing new ones in the future (see
poisoning in patch 10).

Paolo

For comparison the new code uses:
>
>   GList *g_list_sort_with_data(GList *list, GCompareDataFunc
> compare_func, gpointer user_data);
>
> where the callback is
>
>   typedef gint (*GCompareDataFunc)(gconstpointer a, gconstpointer b,
> gpointer user_data);
>
> which the new code complies with, but it is undesirable since we
> have no use for the data parameter.
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

--000000000000841ee60632e185e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 16 apr 2025, 10:29 Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt; -=C2=A0 =C2=A0 secs =3D g_list_sort(secs, sort_secs);<br>
&gt; +=C2=A0 =C2=A0 secs =3D g_list_sort_with_data(secs, sort_secs, NULL);<=
br>
<br>
I don&#39;t see what the problem is with the original code.<br>
<br>
The commit message says we have a bad function cast, but the original<br>
method decl is<br>
<br>
=C2=A0 GList *g_list_sort(GList*list, GCompareFunc compare_func);<br>
<br>
where the callback is<br>
<br>
=C2=A0 =C2=A0typedef gint (*GCompareFunc)(gconstpointer a, gconstpointer b)=
;<br>
<br>
Our code complies with that GCompareFunc signature.<br></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">The cast is inside glib;=
 g_list_sort casts the function pointer and calls g_list_sort_with_data.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">I suggested this solution =
to Kohei because it&#39;s easy to check that we&#39;re converting all users=
 and not introducing new ones in the future (see poisoning in patch 10).</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contai=
ner"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
For comparison the new code uses:<br>
<br>
=C2=A0 GList *g_list_sort_with_data(GList *list, GCompareDataFunc=C2=A0 com=
pare_func, gpointer user_data);<br>
<br>
where the callback is<br>
<br>
=C2=A0 typedef gint (*GCompareDataFunc)(gconstpointer a, gconstpointer b, g=
pointer user_data);<br>
<br>
which the new code complies with, but it is undesirable since we<br>
have no use for the data parameter.<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div></div>

--000000000000841ee60632e185e4--


