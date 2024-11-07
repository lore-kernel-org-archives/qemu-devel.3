Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751DDD5D674
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 17:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t96S7-0006cG-Fj; Thu, 07 Nov 2024 12:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1t96S5-0006bn-Hs
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 12:37:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1t96S2-0007AU-CA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 12:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731001064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jSfupj5ZIvmaNgj31SQca3O9ts8+C7CzwiLfj5o55TM=;
 b=T3IMGMm5cRdSQ/lv8UKJG3k46iLRfutasvSqSgyLz3RfXndnIKmjWpssDFYNUK4r4iBOAR
 ueLJMv5NdfXpZFPJcOdneRQH0ah5urML9itWqoBQQ4oFYpK5Rk0R3cfPyYQUUaD+/CIRyk
 Fcgu8TBd7a+ONWEJJM0vVhoEMzzdFSM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-sPCIEPdFOf6RwX7xhgIcgA-1; Thu, 07 Nov 2024 12:37:42 -0500
X-MC-Unique: sPCIEPdFOf6RwX7xhgIcgA-1
X-Mimecast-MFC-AGG-ID: sPCIEPdFOf6RwX7xhgIcgA
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3a6bf539ceaso20414995ab.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 09:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731001061; x=1731605861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jSfupj5ZIvmaNgj31SQca3O9ts8+C7CzwiLfj5o55TM=;
 b=BS+u9EjhZtmA+zTWQSgpX48SIyK0wh1qnHEDTzzBVqnAyvcyYpFdMnDiNgyUSegnEI
 QNThbjysmeXKLYOGpGB2USOZXR1edTiP01RneBdDGRFQP9drzpCz1w/fSsn02GZtMK8p
 cZKdAqVVxxK6p3b4MGnOj3HGXZOfgi/Bhd904HvG6+XwXvZz5yr3Rk+6wI4At0w7ey2A
 Fgj99Konjfrsx7q2/y+I5bD3p8reyobZYCJkmWOzKFd3W/NvOrBjp3CJt/wes2pwlhMx
 Wv7EdDBurwCgvsDN55Iv9AdYvhRrmrTING6zqu8gSqsEFI2oIKQYCli28Z2HbwQckfiE
 7kdg==
X-Gm-Message-State: AOJu0Yz6syUD5qZeQ5UBR2PnTEDkMatqSjiaireFZh4V/e+S55XB9n2S
 lTqofqpbqG7DG8SYKufjVBzU4C0f62maJCOKEZFLigK9cZ533DPJGxCWnJ1oZ3FuHoNyo3i9xFh
 d3qbLdJOSQqOzLekhqpeAfzFLNILL7/fnR5HmHujVJNqhTECuo6wBC9s3ptEdKG5xoWpv9T7+j8
 vRI0MoFsG9ajgfOeicNPc5rgeoPGw=
X-Received: by 2002:a05:6e02:1708:b0:3a6:c9b4:e2e7 with SMTP id
 e9e14a558f8ab-3a6f115a03cmr3991575ab.3.1731001061415; 
 Thu, 07 Nov 2024 09:37:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMOjz75r68Mt9BSI9n74nYKeGTHSELSu951HB4BvsEqo1Ld43RRqjuiwqdNGz02yn+ZeHPn38tbu5kg4Z+5cI=
X-Received: by 2002:a05:6e02:1708:b0:3a6:c9b4:e2e7 with SMTP id
 e9e14a558f8ab-3a6f115a03cmr3991435ab.3.1731001061089; Thu, 07 Nov 2024
 09:37:41 -0800 (PST)
MIME-Version: 1.0
References: <20241107125201.1640759-1-dbassey@redhat.com>
 <2lsvukkntdselhhjw726kmnixmp7yue5sojhosyaqre5mwrlyq@7x4vwbniwulv>
 <CAGxU2F5L5GBpk19aPDazYRFCDupa6+4FKk7Vjq9QNsFp0tu_kg@mail.gmail.com>
In-Reply-To: <CAGxU2F5L5GBpk19aPDazYRFCDupa6+4FKk7Vjq9QNsFp0tu_kg@mail.gmail.com>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Thu, 7 Nov 2024 18:37:30 +0100
Message-ID: <CACzuRywxUYpqZL6G6o11z_Qb_iDYQ29do1CPsuktH27+zGYzZw@mail.gmail.com>
Subject: Re: [PATCH] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, aesteve@redhat.com, marcandre.lureau@redhat.com
Content-Type: multipart/alternative; boundary="0000000000005a3c5b06265617a1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dbassey@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000005a3c5b06265617a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Since now we allocate memory for the key, we should provide the
> `key_destroy_func` when calling g_hash_table_new_full(), otherwise
> this new memory will not be de-allocated.
>

Ack

IIUC it can be null, only if `uuid` was null since glib memory
> API usually terminates the application if memory allocation fails,
> see https://docs.gtk.org/glib/memory.html


Ok, but the documentation doesn't explicitly state what `g_memdup2` returns
on failure, I checked it manually and it terminates the application on
failure. So indeed this check is not necessary.

I think it may be worth clarifying that it can also return false if
> the resource failed
> to be added.


Hence, I think this is not needed since `g_memdup2` will terminate the
application if memory allocation fails and no return value is provided then=
.

Thanks,
Dorinda.

On Thu, Nov 7, 2024 at 2:47=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com>
wrote:

> On Thu, Nov 7, 2024 at 2:43=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com>
> wrote:
> >
> > On Thu, Nov 07, 2024 at 01:52:01PM +0100, Dorinda Bassey wrote:
> > >In `virtio_add_resource` function, the UUID used as a key for
> > >`g_hash_table_insert` was temporary, which could lead to
> > >invalid lookups when accessed later. This patch ensures that
> > >the UUID remains valid by duplicating it into a newly allocated
> > >memory space (persistent_uuid). The value is then inserted into
> > >the hash table with this persistent UUID key to ensure that the
> > >key stored in the hash table remains valid as long as the hash
> > >table entry exists.
> >
> > It's a fix right, so maybe better to add a Fixes tag:
> >
> > Fixes: faefdba847 ("hw/display: introduce virtio-dmabuf")
> >
> > >
> > >Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> > >---
> > > hw/display/virtio-dmabuf.c | 7 ++++++-
> > > 1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > >diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> > >index 3dba4577ca7..4353970bc87 100644
> > >--- a/hw/display/virtio-dmabuf.c
> > >+++ b/hw/display/virtio-dmabuf.c
> > >@@ -39,7 +39,12 @@ static bool virtio_add_resource(QemuUUID *uuid,
> VirtioSharedObject *value)
> > >                                                g_free);
> > >     }
> > >     if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NULL) {
> > >-        g_hash_table_insert(resource_uuids, uuid, value);
> > >+        QemuUUID *persistent_uuid =3D g_memdup2(uuid, sizeof(QemuUUID=
));
> >
> > Since now we allocate memory for the key, we should provide the
> > `key_destroy_func` when calling g_hash_table_new_full(), otherwise
> > this new memory will not be de-allocated.
> >
> > >+        if (persistent_uuid =3D=3D NULL) {
> >
> > IIUC it can be null, only if `uuid` was null since glib memory
> > API usually terminates the application if memory allocation fails,
> > see https://docs.gtk.org/glib/memory.html
> >
> > So maybe we can just do:
> >            g_hash_table_insert(resource_uuids, g_memdup2(uuid,
> sizeof(QemuUUID)),
> >                                value);
>
> Or even better:
>              g_hash_table_insert(resource_uuids, g_memdup2(uuid,
> sizeof(*uuid)),
>                                  value);
>
> Thanks,
> Stefano
>
> >
> > >+            result =3D false;
> > >+        } else {
> > >+            g_hash_table_insert(resource_uuids, persistent_uuid,
> value);
> > >+        }
> > >     } else {
> > >         result =3D false;
> > >     }
> > >--
> > >2.47.0
> > >
>
>

--0000000000005a3c5b06265617a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br></div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Since now we allocate memory for the key, we shoul=
d provide the<br>
`key_destroy_func` when calling g_hash_table_new_full(), otherwise<br>
this new memory will not be de-allocated.<span class=3D"gmail-im"><br></spa=
n></blockquote><div><br></div><div>Ack</div><div><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">IIUC it can be null, only if `uuid` was n=
ull since glib memory<br>
API usually terminates the application if memory allocation fails,<br>
see <a href=3D"https://docs.gtk.org/glib/memory.html" rel=3D"noreferrer" ta=
rget=3D"_blank">https://docs.gtk.org/glib/memory.html</a></blockquote><div>=
<br></div><div>Ok, but the documentation doesn&#39;t=C2=A0explicitly state =
what `g_memdup2` returns on failure, I checked it manually and it terminate=
s the application on failure. So indeed this check is not necessary.</div><=
div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I think it =
may be worth clarifying that it can also return false if<br>
the resource failed<br>
to be added.</blockquote><div><br></div><div>Hence, I think this is not nee=
ded since `g_memdup2` will terminate the application if memory allocation f=
ails and no return value is provided then.</div><div><br></div><div>Thanks,=
</div><div>Dorinda.<br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Nov 7, 2024 at 2:47=E2=80=AFPM Stefan=
o Garzarella &lt;<a href=3D"mailto:sgarzare@redhat.com">sgarzare@redhat.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On Thu, Nov 7, 2024 at 2:43=E2=80=AFPM Stefano Garzarella &lt;<a href=3D"ma=
ilto:sgarzare@redhat.com" target=3D"_blank">sgarzare@redhat.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt; On Thu, Nov 07, 2024 at 01:52:01PM +0100, Dorinda Bassey wrote:<br>
&gt; &gt;In `virtio_add_resource` function, the UUID used as a key for<br>
&gt; &gt;`g_hash_table_insert` was temporary, which could lead to<br>
&gt; &gt;invalid lookups when accessed later. This patch ensures that<br>
&gt; &gt;the UUID remains valid by duplicating it into a newly allocated<br=
>
&gt; &gt;memory space (persistent_uuid). The value is then inserted into<br=
>
&gt; &gt;the hash table with this persistent UUID key to ensure that the<br=
>
&gt; &gt;key stored in the hash table remains valid as long as the hash<br>
&gt; &gt;table entry exists.<br>
&gt;<br>
&gt; It&#39;s a fix right, so maybe better to add a Fixes tag:<br>
&gt;<br>
&gt; Fixes: faefdba847 (&quot;hw/display: introduce virtio-dmabuf&quot;)<br=
>
&gt;<br>
&gt; &gt;<br>
&gt; &gt;Signed-off-by: Dorinda Bassey &lt;<a href=3D"mailto:dbassey@redhat=
.com" target=3D"_blank">dbassey@redhat.com</a>&gt;<br>
&gt; &gt;---<br>
&gt; &gt; hw/display/virtio-dmabuf.c | 7 ++++++-<br>
&gt; &gt; 1 file changed, 6 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt;diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf=
.c<br>
&gt; &gt;index 3dba4577ca7..4353970bc87 100644<br>
&gt; &gt;--- a/hw/display/virtio-dmabuf.c<br>
&gt; &gt;+++ b/hw/display/virtio-dmabuf.c<br>
&gt; &gt;@@ -39,7 +39,12 @@ static bool virtio_add_resource(QemuUUID *uuid,=
 VirtioSharedObject *value)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0if (g_hash_table_lookup(resource_uuids, uuid) =
=3D=3D NULL) {<br>
&gt; &gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_insert(resource_uuids, u=
uid, value);<br>
&gt; &gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QemuUUID *persistent_uuid =3D g_memdu=
p2(uuid, sizeof(QemuUUID));<br>
&gt;<br>
&gt; Since now we allocate memory for the key, we should provide the<br>
&gt; `key_destroy_func` when calling g_hash_table_new_full(), otherwise<br>
&gt; this new memory will not be de-allocated.<br>
&gt;<br>
&gt; &gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (persistent_uuid =3D=3D NULL) {<br=
>
&gt;<br>
&gt; IIUC it can be null, only if `uuid` was null since glib memory<br>
&gt; API usually terminates the application if memory allocation fails,<br>
&gt; see <a href=3D"https://docs.gtk.org/glib/memory.html" rel=3D"noreferre=
r" target=3D"_blank">https://docs.gtk.org/glib/memory.html</a><br>
&gt;<br>
&gt; So maybe we can just do:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_insert(resource_=
uuids, g_memdup2(uuid, sizeof(QemuUUID)),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value);<br>
<br>
Or even better:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_hash_table_insert(resourc=
e_uuids, g_memdup2(uuid, sizeof(*uuid)),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value);<br>
<br>
Thanks,<br>
Stefano<br>
<br>
&gt;<br>
&gt; &gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D false;<br>
&gt; &gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_insert(res=
ource_uuids, persistent_uuid, value);<br>
&gt; &gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D false;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;--<br>
&gt; &gt;2.47.0<br>
&gt; &gt;<br>
<br>
</blockquote></div>

--0000000000005a3c5b06265617a1--


