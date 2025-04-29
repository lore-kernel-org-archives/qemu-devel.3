Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19B2C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9lrV-0008GT-Pf; Tue, 29 Apr 2025 10:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9lrU-0008GH-UT
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9lrT-0000kt-3L
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745936581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m/F6qdLbwT/m3Y8gvVFDIPxMdu7TnuhnEGcEmtvyn3w=;
 b=BCPf3SGvnyI9BOlOImyjzeGtGlwsUOrUDUj7hjI9Vdl1gpBUSAJ5i4VvjP5LXLOPkLi6sP
 KbjBAArMBNUJMxQst5Xfa/8+XTPvjOJiLZoeUmrJ9XZTqvbgj0cysTTeY2IZu/r0nfTUdL
 l4OJq0HLdQPLNremg05RRVCknZT/Ie0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-xgZk4NBWMX6V5n2qxbVU1A-1; Tue, 29 Apr 2025 10:22:59 -0400
X-MC-Unique: xgZk4NBWMX6V5n2qxbVU1A-1
X-Mimecast-MFC-AGG-ID: xgZk4NBWMX6V5n2qxbVU1A_1745936578
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39141ffa913so2892645f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745936578; x=1746541378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m/F6qdLbwT/m3Y8gvVFDIPxMdu7TnuhnEGcEmtvyn3w=;
 b=m4dB/L9g6WVDNQR+lZpl/AOpK8i7VyfPggLEbP5Cq7iKkx4ZYSF15v/0ULESKdOCuL
 TE7byMKT7/hVJ9XDJfE8ZQqGvbc5eF3+8OBK3uAIO66IxZ783iyypEsD0jvPUy4xRvS5
 mUA/X6tXnsWNOguthOr7KTLlMp7xF8U5yXIht4wnq179Z3ceRmkTJrqUnxdPAbmKqe7u
 UyBYOiNjIhxKYGil7cNIY/3vVDP7SEUPfDWdEJVd4rlJkZaiE3nhk1e5BDW65CWb2ig2
 v2tRRdYq6IUoSOyV982BV4w9/JqOqaHRjoIebeJcnbTWH+hMDIeRDugjYmhnZEwXKDuU
 U9tA==
X-Gm-Message-State: AOJu0Yy3czUcoo93pE7upCPvIrhIFzeRXAM8brG5GzJ8uRHGhNfTukgv
 r0nHVtzmukgIpwf2tIMXlO7qiH1XMYazo6N9cUISTGAt7gvLHIqZhsbCE8+Lu/rWwFKcgT+FN0Z
 BNhGW5mF2qlYxNYiDhVtaPTDOszh5iYZyPU9zGiL8Dz3AoduyN6nq90SK6vigcJWLQKPtkbAmPh
 VsSnCnnSH83+Xc8rHDA1IBfRql8hc=
X-Gm-Gg: ASbGncv8j9qX/yJWLs1HelyeKebE+0VXEGvSfTtRtEnPIKSSAFVUc6WMNTZul++iw6y
 JWMSwfPDBkwauxLP3dVhABB/7ajF4/ocjJN2y0AzsECPVLMaQ5l3/fh7mvTo/XNMNbiA=
X-Received: by 2002:a05:6000:1cc9:b0:38f:30a3:51fe with SMTP id
 ffacd0b85a97d-3a08949d784mr2417781f8f.42.1745936578462; 
 Tue, 29 Apr 2025 07:22:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKAIAo7fDZAR7vTT49NwYTreQJojBQaXRvlol6mjhM/QfM5UMOvZOXGoPDVQp5zQztIQEUt+U+FLcrt+CYD2Q=
X-Received: by 2002:a05:6000:1cc9:b0:38f:30a3:51fe with SMTP id
 ffacd0b85a97d-3a08949d784mr2417768f8f.42.1745936578148; Tue, 29 Apr 2025
 07:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250429140306.190384-1-marcandre.lureau@redhat.com>
 <20250429140306.190384-7-marcandre.lureau@redhat.com>
In-Reply-To: <20250429140306.190384-7-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 29 Apr 2025 16:22:45 +0200
X-Gm-Features: ATxdqUG_ye0uQwt4esUkxPy2GJ_wwIXxi90gBNItFiwPl6mNzGhDrQZYZ8sj8PA
Message-ID: <CABgObfY03pS2DV6ttABt0-82RGvRbVKq8atM9Eoki2-WFELhXA@mail.gmail.com>
Subject: Re: [PATCH 6/6] RFC: qom/object: simplify object_property_del_all()
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008a95e10633eb899e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000008a95e10633eb899e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 29 apr 2025, 16:03 <marcandre.lureau@redhat.com> ha scritto:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Since commit 9859fac ("object: release all props"), the code was changed
> to tracks the already released properties in a hash table. I am not sure
> why this was done, perhaps to prevent from potential crashes if
> properties are being added dynamically during release. I am not sure if
> it's a valid concern though.
>

You always need object_property_iter_init in case prop->release deletes a
property, thus invalidating the GHashTable iterator. The hash table instead
is needed in case prop->release does *not* delete a property, because then
the property reappears on subsequent recreations of the iterator.

Paolo


> -    bool released;
>
> -    do {
> -        released =3D false;
> -        object_property_iter_init(&iter, obj);
> -        while ((prop =3D object_property_iter_next(&iter)) !=3D NULL) {
> -            if (g_hash_table_add(done, prop)) {
> -                if (prop->release) {
> -                    prop->release(obj, prop->name, prop->opaque);
> -                    released =3D true;
> -                    break;
> -                }
> -            }
> +    object_property_iter_init(&iter, obj);
> +    while ((prop =3D object_property_iter_next(&iter)) !=3D NULL) {
> +        if (prop->release) {
> +            prop->release(obj, prop->name, prop->opaque);
>          }
> -    } while (released);
> +    }
>
>      g_hash_table_unref(obj->properties);
>  }
> --
> 2.49.0
>
>

--0000000000008a95e10633eb899e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 29 apr 2025, 16:03  &lt;<=
a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</=
a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redh=
at.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a=
>&gt;<br>
<br>
Since commit 9859fac (&quot;object: release all props&quot;), the code was =
changed<br>
to tracks the already released properties in a hash table. I am not sure<br=
>
why this was done, perhaps to prevent from potential crashes if<br>
properties are being added dynamically during release. I am not sure if<br>
it&#39;s a valid concern though.<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">You always need object_property_iter_init i=
n case prop-&gt;release deletes a property, thus invalidating the GHashTabl=
e iterator. The hash table instead is needed in case prop-&gt;release does =
*not* delete a property, because then the property reappears on subsequent =
recreations of the iterator.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br>
-=C2=A0 =C2=A0 bool released;<br>
<br>
-=C2=A0 =C2=A0 do {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 released =3D false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_iter_init(&amp;iter, obj);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while ((prop =3D object_property_iter_next(&am=
p;iter)) !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_hash_table_add(done, prop)=
) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prop-&gt;relea=
se) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prop=
-&gt;release(obj, prop-&gt;name, prop-&gt;opaque);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rele=
ased =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 object_property_iter_init(&amp;iter, obj);<br>
+=C2=A0 =C2=A0 while ((prop =3D object_property_iter_next(&amp;iter)) !=3D =
NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prop-&gt;release) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;release(obj, prop-&gt;n=
ame, prop-&gt;opaque);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 } while (released);<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_hash_table_unref(obj-&gt;properties);<br>
=C2=A0}<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div></div>

--0000000000008a95e10633eb899e--


