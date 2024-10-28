Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9624BD13593
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 01:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5EtO-0000zX-5V; Sun, 27 Oct 2024 21:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t5EtL-0000yy-Rl
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 21:49:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t5EtK-0006bD-27
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 21:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730080197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E9H0dQeR/Uo20wW8hInSF4MnhGyBqEv/w/zJnlsalY4=;
 b=Pq5ATXZldDVM+DMJQZ6heRxL/FMiAiE2dvHxedCvMT8bgbn+M9E9tNyIR3smxsEpHKZCNu
 28ExomO/pVmUpTPeGwZJ/G2KCshTpfQpCz80PFxgvkPkP98YSK8X105HWyFLQDTS2NopuJ
 VzZcBFF56iPTtisqubTThhw7JoMZhyc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-m1QVgsRhNeOTzjrMMWYsmA-1; Sun, 27 Oct 2024 21:49:55 -0400
X-MC-Unique: m1QVgsRhNeOTzjrMMWYsmA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5cbaeb24cb2so1924745a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 18:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730080194; x=1730684994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E9H0dQeR/Uo20wW8hInSF4MnhGyBqEv/w/zJnlsalY4=;
 b=ifrR+IxH6IM68oXwCjjKwBl9sBJLjB7kZWTj81w6oe58/+36iCY8ubF8thewSX+5Bz
 p4+UaHgrKqRNDl0sppY/lZ+uGDuQ/YtdqLfaeAxmHaxSHalqH/BDxT7eSZAlRpx236ST
 hrqtevqRB6HGILmVG+yJ7fUXlXV+853AFWJ8goLEjKwozEBgxZchpIAsTNC7PjBfsWNC
 MFZQLuq/K+OvLiyDoeBp+eGJ7BXnD6f+cz/7GHOOXQCO9T/q/5era9Ei9VDkVoDOLt9Y
 it8QVpx87UdJlldTESBhr42xKKg9pFbHaYY2omp67vM0mDWyaooS9m5pBcJGu6GAKc6J
 8uQQ==
X-Gm-Message-State: AOJu0YyH3BbyFjGh2seiM0uXSDaHuPMIq5yUXlr2VNKO8OnFQL9j8TSl
 t604vUPr7XskQEyyx5QPxGMlsrIQwoWn5LY2Gt2rJrd6Gd6ePGvAq+Nn2AeWXDzd2nlT0up4tw4
 btrsUU8Tc3foGBRcsIX+F+ShzYlA6pK1WcNpCjmGvUa9YttsqrNI92n49GAliHKTvphy33Gu/aH
 0v1BlVOpoLiURVqhIEXYmHQQclchA=
X-Received: by 2002:a05:6402:d09:b0:5c8:8d5e:19b0 with SMTP id
 4fb4d7f45d1cf-5cbbfa74da6mr4498545a12.30.1730080193867; 
 Sun, 27 Oct 2024 18:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZCOl2DzsJG5PdSZSa9YryC/lJ46D6qsh+s3a8YhywkxLKDYmA3w0koUXKNl0csdyHRBIp8lUamZbziDPfO/w=
X-Received: by 2002:a05:6402:d09:b0:5c8:8d5e:19b0 with SMTP id
 4fb4d7f45d1cf-5cbbfa74da6mr4498531a12.30.1730080193517; Sun, 27 Oct 2024
 18:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241022142948.531325-1-demeng@redhat.com>
 <20241022142948.531325-6-demeng@redhat.com>
 <ZxuUI15RQxuEZHbx@redhat.com>
In-Reply-To: <ZxuUI15RQxuEZHbx@redhat.com>
From: Dehan Meng <demeng@redhat.com>
Date: Mon, 28 Oct 2024 09:49:42 +0800
Message-ID: <CA+kPPJzk-vEYDcJbjp_oPkfRyPpo_z+6ouJ7e4ZB3WQXHjY_WA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] qemu-ga: Replace g_new0() with g_autoptr()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com, 
 peter.maydell@linaro.org
Content-Type: multipart/alternative; boundary="0000000000005e36b306257faf62"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
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

--0000000000005e36b306257faf62
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for reviewing, I'll summarize all of the patches.

On Fri, Oct 25, 2024 at 8:50=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Tue, Oct 22, 2024 at 10:29:48PM +0800, Dehan Meng wrote:
> > Replace g_new0() with g_autoptr() to simplify the code
> >
> > Signed-off-by: Dehan Meng <demeng@redhat.com>
> > ---
> >  qga/commands-linux.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> > index 9fb31956b4..ee4f345938 100644
> > --- a/qga/commands-linux.c
> > +++ b/qga/commands-linux.c
> > @@ -2158,15 +2158,13 @@ GuestNetworkRouteList
> *qmp_guest_network_get_route(Error **errp)
> >                      continue;
> >                  }
> >
> > -                GuestNetworkRoute *route =3D g_new0(GuestNetworkRoute,=
 1);
> > +                g_autoptr(GuestNetworkRoute) route =3D
> g_new0(GuestNetworkRoute, 1);
> >
> >                  route->destination =3D hex_to_ip_address(destination, =
1);
> > -                if (route->destination =3D=3D NULL) {
> > -                    g_free(route);
> > +                route->iface =3D g_strdup(iface);
> > +                if (route->destination =3D=3D NULL  || route->iface =
=3D=3D
> NULL) {
>
> Checking "iface" for NULL is not required, since  g_strdup will never
> fail to allocate memory.
>
> Also, these changes to use g_autoptr need to be part of the first patch,
> as each step in the patch series needs to be correct.
>
> >                      continue;
> >                  }
> > -                route->iface =3D g_strdup(iface);
> > -                route->destination =3D hex_to_ip_address(destination, =
1);
> >                  route->source =3D hex_to_ip_address(source, 1);
> >                  route->nexthop =3D hex_to_ip_address(next_hop, 1);
> >                  route->desprefixlen =3D g_strdup_printf("%d",
> des_prefixlen);
> > @@ -2188,15 +2186,13 @@ GuestNetworkRouteList
> *qmp_guest_network_get_route(Error **errp)
> >                      continue;
> >                  }
> >
> > -                GuestNetworkRoute *route =3D g_new0(GuestNetworkRoute,=
 1);
> > +                g_autoptr(GuestNetworkRoute) route =3D
> g_new0(GuestNetworkRoute, 1);
> >
> >                  route->destination =3D hex_to_ip_address(destination, =
1);
> > -                if (route->destination =3D=3D NULL) {
> > -                    g_free(route);
> > +                route->iface =3D g_strdup(iface);
> > +                if (route->destination =3D=3D NULL  || route->iface =
=3D=3D
> NULL) {
> >                      continue;
> >                  }
> > -                route->iface =3D g_strdup(iface);
> > -                route->destination =3D hex_to_ip_address(&destination,=
 0);
> >                  route->gateway =3D hex_to_ip_address(&gateway, 0);
> >                  route->mask =3D hex_to_ip_address(&mask, 0);
> >                  route->metric =3D metric;
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

--0000000000005e36b306257faf62
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for reviewing, I&#39;ll summarize all of the pat=
ches.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Fri, Oct 25, 2024 at 8:50=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a=
 href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Oct 22, 202=
4 at 10:29:48PM +0800, Dehan Meng wrote:<br>
&gt; Replace g_new0() with g_autoptr() to simplify the code<br>
&gt; <br>
&gt; Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" tar=
get=3D"_blank">demeng@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-linux.c | 16 ++++++----------<br>
&gt;=C2=A0 1 file changed, 6 insertions(+), 10 deletions(-)<br>
&gt; <br>
&gt; diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
&gt; index 9fb31956b4..ee4f345938 100644<br>
&gt; --- a/qga/commands-linux.c<br>
&gt; +++ b/qga/commands-linux.c<br>
&gt; @@ -2158,15 +2158,13 @@ GuestNetworkRouteList *qmp_guest_network_get_r=
oute(Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 continue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNetworkR=
oute *route =3D g_new0(GuestNetworkRoute, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autoptr(Gue=
stNetworkRoute) route =3D g_new0(GuestNetworkRoute, 1);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&g=
t;destination =3D hex_to_ip_address(destination, 1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (route-&gt=
;destination =3D=3D NULL) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 g_free(route);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;ifa=
ce =3D g_strdup(iface);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (route-&gt=
;destination =3D=3D NULL=C2=A0 || route-&gt;iface =3D=3D NULL) {<br>
<br>
Checking &quot;iface&quot; for NULL is not required, since=C2=A0 g_strdup w=
ill never<br>
fail to allocate memory.<br>
<br>
Also, these changes to use g_autoptr need to be part of the first patch,<br=
>
as each step in the patch series needs to be correct.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 continue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;ifa=
ce =3D g_strdup(iface);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;des=
tination =3D hex_to_ip_address(destination, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&g=
t;source =3D hex_to_ip_address(source, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&g=
t;nexthop =3D hex_to_ip_address(next_hop, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&g=
t;desprefixlen =3D g_strdup_printf(&quot;%d&quot;, des_prefixlen);<br>
&gt; @@ -2188,15 +2186,13 @@ GuestNetworkRouteList *qmp_guest_network_get_r=
oute(Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 continue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNetworkR=
oute *route =3D g_new0(GuestNetworkRoute, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autoptr(Gue=
stNetworkRoute) route =3D g_new0(GuestNetworkRoute, 1);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&g=
t;destination =3D hex_to_ip_address(destination, 1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (route-&gt=
;destination =3D=3D NULL) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 g_free(route);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;ifa=
ce =3D g_strdup(iface);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (route-&gt=
;destination =3D=3D NULL=C2=A0 || route-&gt;iface =3D=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 continue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;ifa=
ce =3D g_strdup(iface);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;des=
tination =3D hex_to_ip_address(&amp;destination, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&g=
t;gateway =3D hex_to_ip_address(&amp;gateway, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&g=
t;mask =3D hex_to_ip_address(&amp;mask, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&g=
t;metric =3D metric;<br>
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
</blockquote></div>

--0000000000005e36b306257faf62--


