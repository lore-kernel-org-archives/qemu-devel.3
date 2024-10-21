Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AA1D0E6C5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 17:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vz3-0004Up-7m; Mon, 21 Oct 2024 13:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t2vyv-0004SL-Ct
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:14:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t2vyq-00026q-7s
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729530846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SxvroOBHtwJSU4tFwRZqi/ojarY+NKu1w+Ypnz1XsHc=;
 b=cO6tn8VqpRipaQY359Uq54YvB9AFunsd8Op1bz3MkfohlhH5T/tHjkDwbATo1oBbR5GVPE
 RqgJTC6oq44rLX8y8ZIiqLcPd+5QkMfRxaSTIFB41+CxyJx4ueGTxvyxQ91KZ8Uo3dsgiu
 gbT7k2s2RUaC0LSgqFs3Unz0BLklYj4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-szDZ76xgNSmlTZvfvfiylA-1; Mon, 21 Oct 2024 13:14:04 -0400
X-MC-Unique: szDZ76xgNSmlTZvfvfiylA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cbd2cb2f78so102868166d6.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 10:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729530844; x=1730135644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SxvroOBHtwJSU4tFwRZqi/ojarY+NKu1w+Ypnz1XsHc=;
 b=RmJc7Yd8dxBS5tz1MtOJQEa/DPyAdFzOxa0chFbzr9/SSx4UbUfeldxWTlk3T03iFd
 hK84q0dRyExvi3NsC1A59z2Jjjp+O+D9yOxEXh6zt7+0n+7eWIWU6RaP3ob5bECvuoRL
 QV0i8XASuEhZlbxrONg3eWGY2Ech5Cxb9AYTIV/5e/5ncAp0HkDoHtiPfdLLblIVh3Dt
 usCI1mRKB15AXWbWOjeg5VairLNtCijqIccuDZveHt8tft1Ykfanama3GauyqYOUc5wh
 7VDuG/q7hP2MI3awWWJY2T/4jf3222S56rIxiuH3hiftoDMwX7TffbZ1x2ro0hmz6DL/
 AA0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtFeXjHpEJjpYmQhpXN6HsuTg8DR4kY/qUw+PD11xHj9rlfmURx5WNfgZxBl1tsohGkVxgOaq/FOMU@nongnu.org
X-Gm-Message-State: AOJu0YxdHfhY5G+/hvCeKGbFZsxbrsanrJwPQCfToeZXbmy0KSt+F8e/
 xhougIzfXLbbdIzltiRsRrLY1EiNEgs7AUVgj/pptSyF+m+mkA1UhjXiif2JErsvS9Waf5wARZf
 u9u1/YRkDjZtNux6pH3VdA+BRTi6uqDLAyfd/1M7k75rdlm+ZTttKWCmPJSLcqAeuZQnOrt5tOb
 3OjW5nSnlzKN4kEbfGjzJ86/JR5C0=
X-Received: by 2002:a05:6214:568b:b0:6cc:255:2038 with SMTP id
 6a1803df08f44-6ce21892c8dmr6132196d6.4.1729530843959; 
 Mon, 21 Oct 2024 10:14:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgiV51157IZmHUCa4+0y2tU9eRnmleq3cV7TMa7q95cs5VtS1UigQVYP7/8OjjGhSa2Jzr1HeKBTAAVOQdyn8=
X-Received: by 2002:a05:6214:568b:b0:6cc:255:2038 with SMTP id
 6a1803df08f44-6ce21892c8dmr6132016d6.4.1729530843643; Mon, 21 Oct 2024
 10:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20241021132839.463255-1-demeng@redhat.com>
 <20241021132839.463255-7-demeng@redhat.com>
 <ZxaFOdhqE54A5vWf@redhat.com>
In-Reply-To: <ZxaFOdhqE54A5vWf@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 21 Oct 2024 20:13:52 +0300
Message-ID: <CAPMcbCqa-1i6zVwF_YmecbADyVBSzeJCJRF=a7rMXkLRbznvUw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] qemu-ga: 'Null' check for mandatory parameters
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Dehan Meng <demeng@redhat.com>, qemu-devel@nongnu.org, michael.roth@amd.com,
 peter.maydell@linaro.org
Content-Type: multipart/alternative; boundary="000000000000905c1d0624ffc75b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

--000000000000905c1d0624ffc75b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 7:45=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Mon, Oct 21, 2024 at 09:28:36PM +0800, Dehan Meng wrote:
> > sscanf return values are checked and add 'Null' check for
> > mandatory parameters.
> >
> > Signed-off-by: Dehan Meng <demeng@redhat.com>
> > ---
> >  qga/commands-linux.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> > index 51d5e3d927..f0e9cdd27c 100644
> > --- a/qga/commands-linux.c
> > +++ b/qga/commands-linux.c
> > @@ -2103,7 +2103,9 @@ static char *hexToIPAddress(const void *hexValue,
> int is_ipv6)
> >          int i;
> >
> >          for (i =3D 0; i < 16; i++) {
> > -            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);
> > +            if (sscanf(&hex_str[i * 2], "%02hhx", &in6.s6_addr[i]) !=
=3D
> 1) {
> > +                return NULL;
> > +            }
> >          }
> >          inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);
> >
> > @@ -2164,6 +2166,10 @@ GuestNetworkRouteList
> *qmp_guest_network_get_route(Error **errp)
> >                  networkroute =3D route;
> >                  networkroute->iface =3D g_strdup(Iface);
> >                  networkroute->destination =3D hexToIPAddress(Destinati=
on,
> 1);
> > +                if (networkroute->destination =3D=3D NULL) {
> > +                    g_free(route);
> > +                    continue;
> > +                }
>
> This is still leaking the 'networkroute->iface' string.
>
> The existing code is a bit strange having 'route' and 'networkroute'
> variables.
>
> I'd suggest removing the "route" variable entirely.
>

This part was done in patch 4/4


>
> Then have a code pattern that relies on g_autoptr to automatically
> free the struct & all its fields.
>

Agree with this


>
> eg something that looks approx like this:
>
>    g_autoptr(GuestNetorkRoute) networkroute =3D NULL;
>
>    ...
>
>    if (is_ipv6) {
>        ...
>        networkroute =3D g_new0(GuestNetorkRoute, 1);
>        networkroute->iface =3D g_strdup(Iface);
>        networkroute->destination =3D hexToIPAddress(Destination, 1);
>        if (networkroute->destination =3D=3D NULL) {
>           continue;
>        }
>        ...
>    } else {
>        ...
>        networkroute =3D g_new0(GuestNetorkRoute, 1);
>        networkroute->iface =3D g_strdup(Iface);
>        networkroute->destination =3D hexToIPAddress(Destination, 1);
>        if (networkroute->destination =3D=3D NULL) {
>           continue;
>        }
>        ...
>    }
>
>    QAPI_LIST_APPEND(tail, g_steal_pointer(&networkroute));
>
>
> >                  networkroute->metric =3D Metric;
> >                  networkroute->source =3D hexToIPAddress(Source, 1);
> >                  networkroute->desprefixlen =3D g_strdup_printf(
> > @@ -2195,6 +2201,10 @@ GuestNetworkRouteList
> *qmp_guest_network_get_route(Error **errp)
> >                  networkroute =3D route;
> >                  networkroute->iface =3D g_strdup(Iface);
> >                  networkroute->destination =3D
> hexToIPAddress(&Destination, 0);
> > +                if (networkroute->destination =3D=3D NULL) {
> > +                    g_free(route);
> > +                    continue;
> > +                }
> >                  networkroute->gateway =3D hexToIPAddress(&Gateway, 0);
> >                  networkroute->mask =3D hexToIPAddress(&Mask, 0);
> >                  networkroute->metric =3D Metric;
> > --
> > 2.40.1
> >
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

--000000000000905c1d0624ffc75b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 21, 2024=
 at 7:45=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@=
redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Oct 21, 2024 at 09=
:28:36PM +0800, Dehan Meng wrote:<br>
&gt; sscanf return values are checked and add &#39;Null&#39; check for<br>
&gt; mandatory parameters.<br>
&gt; <br>
&gt; Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" tar=
get=3D"_blank">demeng@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-linux.c | 12 +++++++++++-<br>
&gt;=C2=A0 1 file changed, 11 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
&gt; index 51d5e3d927..f0e9cdd27c 100644<br>
&gt; --- a/qga/commands-linux.c<br>
&gt; +++ b/qga/commands-linux.c<br>
&gt; @@ -2103,7 +2103,9 @@ static char *hexToIPAddress(const void *hexValue=
, int is_ipv6)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; 16; i++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sscanf(&amp;hexStr[i * 2], =
&quot;%02hhx&quot;, &amp;in6.s6_addr[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sscanf(&amp;hex_str[i *=
 2], &quot;%02hhx&quot;, &amp;in6.s6_addr[i]) !=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 inet_ntop(AF_INET6, &amp;in6, addr, =
INET6_ADDRSTRLEN);<br>
&gt;=C2=A0 <br>
&gt; @@ -2164,6 +2166,10 @@ GuestNetworkRouteList *qmp_guest_network_get_ro=
ute(Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute =3D route;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;iface =3D g_strdup(Iface);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;destination =3D hexToIPAddress(Destination, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (networkro=
ute-&gt;destination =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 g_free(route);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
This is still leaking the &#39;networkroute-&gt;iface&#39; string.<br>
<br>
The existing code is a bit strange having &#39;route&#39; and &#39;networkr=
oute&#39;<br>
variables.<br>
<br>
I&#39;d suggest removing the &quot;route&quot; variable entirely.<br></bloc=
kquote><div><br></div><div>This part was done in patch 4/4<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Then have a code pattern that relies on g_autoptr to automatically<br>
free the struct &amp; all its fields.<br></blockquote><div><br></div><div>A=
gree with this<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
eg something that looks approx like this:<br>
<br>
=C2=A0 =C2=A0g_autoptr(GuestNetorkRoute) networkroute =3D NULL;<br>
<br>
=C2=A0 =C2=A0...<br>
<br>
=C2=A0 =C2=A0if (is_ipv6) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0networkroute =3D g_new0(GuestNetorkRoute, 1);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0networkroute-&gt;iface =3D g_strdup(Iface);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0networkroute-&gt;destination =3D hexToIPAddress(=
Destination, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (networkroute-&gt;destination =3D=3D NULL) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0networkroute =3D g_new0(GuestNetorkRoute, 1);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0networkroute-&gt;iface =3D g_strdup(Iface);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0networkroute-&gt;destination =3D hexToIPAddress(=
Destination, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (networkroute-&gt;destination =3D=3D NULL) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0QAPI_LIST_APPEND(tail, g_steal_pointer(&amp;networkroute));<br=
>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;metric =3D Metric;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;source =3D hexToIPAddress(Source, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;desprefixlen =3D g_strdup_printf(<br>
&gt; @@ -2195,6 +2201,10 @@ GuestNetworkRouteList *qmp_guest_network_get_ro=
ute(Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute =3D route;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;iface =3D g_strdup(Iface);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;destination =3D hexToIPAddress(&amp;Destination, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (networkro=
ute-&gt;destination =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 g_free(route);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;gateway =3D hexToIPAddress(&amp;Gateway, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;mask =3D hexToIPAddress(&amp;Mask, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;metric =3D Metric;<br>
&gt; -- <br>
&gt; 2.40.1<br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div>
</div>

--000000000000905c1d0624ffc75b--


