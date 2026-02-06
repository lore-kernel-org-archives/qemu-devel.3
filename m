Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3C6EE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 15:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNLp-00068D-JX; Fri, 06 Feb 2026 10:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1voNLY-00061Z-5G
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 10:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1voNLV-0000ue-Q8
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 10:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770390127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1kpBS61qhw+Aryhv7qZCKZ5W2ViG1DM1eZjAnwbVQDE=;
 b=S9j7itdWoT0isw/4rG7s5bNUmx0FM+M7JEi7FgB4wSEoiblt+7fSsJ8BJ3CmsbrhcCMlbu
 ju8sXxGVL+YyEtivh73Avad1IjfalE+Reu/mcrDVgCZ/quMmGBLrx/OC0HlAH/3SHrWXti
 fnj7J2AOBqUXkAQhIB16RN3yEh11RAc=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-MZMafP2ENQK9Fi7W8MtNBA-1; Fri, 06 Feb 2026 10:00:47 -0500
X-MC-Unique: MZMafP2ENQK9Fi7W8MtNBA-1
X-Mimecast-MFC-AGG-ID: MZMafP2ENQK9Fi7W8MtNBA_1770390046
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6640dc1ca05so8262353eaf.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 07:00:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770390046; cv=none;
 d=google.com; s=arc-20240605;
 b=L9ApzMEcLqTLXeJxU0gl4n5iR4ErVXU57+JEey1KidV/OkiEpaFVgoah3j4A3jPiAN
 zDShL8O0hS1q/X8fK5y0OR0o6LngZFyC03sK2xFEQxHmTXEVQBP0tzVI860hX7XxwjL/
 sYgoxwll0rz6Y2YPVRPmv44Qrzy/CLDOSpDaAXVjx+KvP+T73JZPVQc3nNEc7GiE7S0n
 hnq3QqKe2K1I38vkv8HoOhZgGWkk7auupaGJyi0Vk16co6ZD+e1y658sbIapcwoJN2a/
 YiQzsN94RjkbuA2FuEPkAyXKdgcZwMhcP739u9NtWszOhoIqUI7Lsx5vV6srH+BrfhXm
 jwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1kpBS61qhw+Aryhv7qZCKZ5W2ViG1DM1eZjAnwbVQDE=;
 fh=E8s3wkEWEK5ohdKRCvTVy/P6M1dl9RN2hwPVtv/Xezs=;
 b=P8U+t2oAQNyJ6KxLdgIMqJq+HJAWEbDkoSkDlp4Wcndpq8OLTGbwzmUO1hj/BX1l34
 JOv5rOlg/MOn4W3r5uPPeFHOsdMuu1sXf+H/YawxowNzr/r9xajhEwaXXL5/Jnej4AfR
 Ank07R+gp42PyZjqCNX1afzwXEipQ8EWW9TBf7Giv7oq4wlJPmXA+f4I91toOiF/Bs80
 UwW2FXNmcSgGxNIid00ec4xeaCCEowPxEgflnuoktBvC7pdqtLn7hQeX0W0plELebBxb
 i/fObtE6bUSRmkWtF3trbbJGn69PP7Lp9qusNx5e8j73lyvfZbdmtPxPoUJGxFAbofGO
 SO3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770390046; x=1770994846; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1kpBS61qhw+Aryhv7qZCKZ5W2ViG1DM1eZjAnwbVQDE=;
 b=sCVlKCFAfePr5ydvbUOSsRzdoVcbG2tdFscYiH4JrEF4o/UtE+o7M5d/edhGMH+iGd
 F/AqoodQ8VdFWR8ZrYLKkfjwQb8MCc4KUN4YP7ufRO5341DQE5mykwUrhM8lBkAvyqBp
 nsCUj/VW294Fd9//136lJ2zqhAPwMwtLbyY5fcMVggpQeIeiObO0Ve33hg8c+FflCK9l
 9ckRhex9kkBUKzVxFrGqw/nkQtyCBLmK/aYx1iWqcGl9biU00pxeXxLqvo7ODqs2+d4d
 aNPyk1codzNuttqPNKizhDBzRgg2j5hj6Qn+x76pBOx8Xj95bDBWw2/sM3TcWA0giO5e
 kuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770390046; x=1770994846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kpBS61qhw+Aryhv7qZCKZ5W2ViG1DM1eZjAnwbVQDE=;
 b=NoflrqRltsZsNCjbklobCLKx0UGVMTcV9ukJyW0hXUz2NlBEvQV0kE4Ld5x+r3uKQ0
 bRDGTXqhlSE3odOqfwa9FFGDfMvV4s8f8hwC+EGeXkDJeSAhuU+NjfgmsgIVKgci5XUV
 tdZd3pqi1AXOw75ZNaqEKgYM/mTs+heVV+wWHZhOBuqGCdHfBGikHfFIvEukmQr2v8mj
 6zz/GFiql9BCFzYP1skwRfuXLyfnEuGZQIK+GYx2YOM5R9i1bJG3rbh12lC7FUMxG4+y
 L4HMmlFN91ITr6mIJbG3Z7JzuN4TJ/w97k83g8ahzIBV76keJjbWFixkwbcUuDiJnNi9
 UEmQ==
X-Gm-Message-State: AOJu0YzWdBklymFxvd1Rh3EVUOebNZtxpOmOSHDhetdlcOtB8YA9U0qD
 RJu3PG9i4HZsYafLTVvOw6E7pQ1fuackQfm8QXr4xEHRiizley7z8iUFEn9MRP2QO4SuLg6YkFM
 XZou3ga0mVbBDq3OehBaTdt9Pv8U5Iyfx32TeX/138T9d1xV3z6Q/09SaOLn3CXWbs64i2O4UDw
 uhnBihrQIBP3o21oYUbjQkbQ9vsgYcThw=
X-Gm-Gg: AZuq6aI82wi4GGY+ykBexJj59Mfni2B4fxlkRvwTzKoeIApN2m5jZIlJNnRXMYYZDgU
 daEXUAZo3XGFgW3B3wEp0Bt8MfXNcNmZ48TW64QFu+CVawggpIvDATYlU97NoA0EX4fHw8Bmnf/
 +/ZvUzzC77pIk4KlAKpLlEGO5VVztKnqoVnGCt0DVQ4RYaFrIr/PdQ5gEFyJvL87IwqglU
X-Received: by 2002:a4a:cb8d:0:b0:66d:cfec:bf37 with SMTP id
 006d021491bc7-66dcfecc03cmr376366eaf.22.1770390045876; 
 Fri, 06 Feb 2026 07:00:45 -0800 (PST)
X-Received: by 2002:a4a:cb8d:0:b0:66d:cfec:bf37 with SMTP id
 006d021491bc7-66dcfecc03cmr376335eaf.22.1770390044477; Fri, 06 Feb 2026
 07:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20251204162129.262745-1-dbassey@redhat.com>
 <55f06323-a0f6-40f0-9f37-743245203c77@tls.msk.ru>
In-Reply-To: <55f06323-a0f6-40f0-9f37-743245203c77@tls.msk.ru>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Fri, 6 Feb 2026 16:00:33 +0100
X-Gm-Features: AZwV_QigoufJXs2oQasXopqdsie6C44QWyO2EmJ3eh3ByTyjxmIOjEN4qiOGo4g
Message-ID: <CACzuRyxeeATksqQQGfGkKVnCP7QMwTaKy_q+dioEPwPka9xzbw@mail.gmail.com>
Subject: Re: [PATCH v3] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
To: mjt@tls.msk.ru
Cc: qemu-devel@nongnu.org, mst@redhat.com, sgarzare@redhat.com, 
 aesteve@redhat.com, marcandre.lureau@redhat.com, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000b76559064a290d10"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dbassey@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--000000000000b76559064a290d10
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Again, this feels like a qemu-stable material.  However, I'm not
> sure under which circumstances the uuid key can be freed before
> referencing.
>
> Please let me know if I shouldn't pick this up for qemu stable
> releases.

I don't think there's a need to pick this up for stable, I found this issue
when testing the `resource_assign_uuid` feature, which is not yet fully
implemented in rust-vmm vhost-device-gpu backend that uses it. So safe to
say no existing users are hitting this code path in the current stable.

Br,
Dorinda.


On Thu, Feb 5, 2026 at 10:50=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:

> On 12/4/25 19:20, Dorinda Bassey wrote:
> > In `virtio_add_resource` function, the UUID used as a key for
> > `g_hash_table_insert` was temporary, which could lead to
> > invalid lookups when accessed later. This patch ensures that
> > the UUID remains valid by duplicating it into a newly allocated
> > memory space. The value is then inserted into the hash table
> > with this persistent UUID key to ensure that the key stored in
> > the hash table remains valid as long as the hash table entry
> > exists.
> >
> > Fixes: faefdba847 ("hw/display: introduce virtio-dmabuf")
> > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Reviewed-by: Albert Esteve <aesteve@redhat.com>
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Again, this feels like a qemu-stable material.  However, I'm not
> sure under which circumstances the uuid key can be freed before
> referencing.
>
> Please let me know if I shouldn't pick this up for qemu stable
> releases.
>
> Thanks,
>
> /mjt
>
> > ---
> > v3: removed blank line between trailers
> >
> >   hw/display/virtio-dmabuf.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> > index 3dba4577ca..5e0395be77 100644
> > --- a/hw/display/virtio-dmabuf.c
> > +++ b/hw/display/virtio-dmabuf.c
> > @@ -35,11 +35,13 @@ static bool virtio_add_resource(QemuUUID *uuid,
> VirtioSharedObject *value)
> >       if (resource_uuids =3D=3D NULL) {
> >           resource_uuids =3D g_hash_table_new_full(qemu_uuid_hash,
> >                                                  uuid_equal_func,
> > -                                               NULL,
> > +                                               g_free,
> >                                                  g_free);
> >       }
> >       if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NULL) {
> > -        g_hash_table_insert(resource_uuids, uuid, value);
> > +        g_hash_table_insert(resource_uuids,
> > +                            g_memdup2(uuid, sizeof(*uuid)),
> > +                            value);
> >       } else {
> >           result =3D false;
> >       }
>
>

--000000000000b76559064a290d10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Again, this feels like a qemu-stable material.=C2=A0 H=
owever, I&#39;m not<br>
sure under which circumstances the uuid key can be freed before<br>
referencing.<br>
<br>
Please let me know if I shouldn&#39;t pick this up for qemu stable<br>
releases.</blockquote><div>I don&#39;t think there&#39;s a need to pick thi=
s up for stable, I found this issue when testing the `resource_assign_uuid`=
 feature, which is not yet fully implemented in rust-vmm vhost-device-gpu b=
ackend that uses it. So safe to say no existing users are hitting this code=
 path in the current stable.</div><div><br></div><div>Br,</div><div>Dorinda=
.</div><div><br></div></div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, 2026 at 10:50=E2=
=80=AFPM Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.=
ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On 12/4/25 19:20, Dorinda Bassey wrote:<br>
&gt; In `virtio_add_resource` function, the UUID used as a key for<br>
&gt; `g_hash_table_insert` was temporary, which could lead to<br>
&gt; invalid lookups when accessed later. This patch ensures that<br>
&gt; the UUID remains valid by duplicating it into a newly allocated<br>
&gt; memory space. The value is then inserted into the hash table<br>
&gt; with this persistent UUID key to ensure that the key stored in<br>
&gt; the hash table remains valid as long as the hash table entry<br>
&gt; exists.<br>
&gt; <br>
&gt; Fixes: faefdba847 (&quot;hw/display: introduce virtio-dmabuf&quot;)<br=
>
&gt; Signed-off-by: Dorinda Bassey &lt;<a href=3D"mailto:dbassey@redhat.com=
" target=3D"_blank">dbassey@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Stefano Garzarella &lt;<a href=3D"mailto:sgarzare@redhat.=
com" target=3D"_blank">sgarzare@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" t=
arget=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lu=
reau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
Again, this feels like a qemu-stable material.=C2=A0 However, I&#39;m not<b=
r>
sure under which circumstances the uuid key can be freed before<br>
referencing.<br>
<br>
Please let me know if I shouldn&#39;t pick this up for qemu stable<br>
releases.<br>
<br>
Thanks,<br>
<br>
/mjt<br>
<br>
&gt; ---<br>
&gt; v3: removed blank line between trailers<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/display/virtio-dmabuf.c | 6 ++++--<br>
&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c<b=
r>
&gt; index 3dba4577ca..5e0395be77 100644<br>
&gt; --- a/hw/display/virtio-dmabuf.c<br>
&gt; +++ b/hw/display/virtio-dmabuf.c<br>
&gt; @@ -35,11 +35,13 @@ static bool virtio_add_resource(QemuUUID *uuid, Vi=
rtioSharedObject *value)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (resource_uuids =3D=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resource_uuids =3D g_hash_tabl=
e_new_full(qemu_uuid_hash,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid_equal_func,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0g_free,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (g_hash_table_lookup(resource_uuids, uuid=
) =3D=3D NULL) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_insert(resource_uuids, uuid,=
 value);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_insert(resource_uuids,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_memdup2(uuid, sizeof(*uuid)),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
</blockquote></div>

--000000000000b76559064a290d10--


