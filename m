Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65105D0E6DB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 12:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNsaV-0005Ow-CC; Tue, 25 Nov 2025 07:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vNsaQ-0005NP-Qb
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:56:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vNsaO-0004n1-0c
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764075356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zoepLKBq04qxCgjJ8tC8SphEXhzZSbT/gsrtVJa8Ow0=;
 b=dNU27HvDvtrHSBGP1mjNkMZ4xPmTFRNezVluH46dz+pwmAqYL2nr+80d3kULznLC6pYtHj
 a5mN57kP8AKntPT/bmTlwbj0jeR1vmYpVXvERsZP4YjbvKYd0zis9l1aE1KmY0LcGFYGmx
 TcpfWbj1N/Mam0dUB3YGWrBRNGDJnFM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-B8vHhQXkMwKcye3FftgZTA-1; Tue, 25 Nov 2025 07:55:54 -0500
X-MC-Unique: B8vHhQXkMwKcye3FftgZTA-1
X-Mimecast-MFC-AGG-ID: B8vHhQXkMwKcye3FftgZTA_1764075354
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3439fe6229aso5096302a91.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 04:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764075354; x=1764680154; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zoepLKBq04qxCgjJ8tC8SphEXhzZSbT/gsrtVJa8Ow0=;
 b=RFmZ3kmula4QCXvWT5bcuE6MqRfKsHhaM5/HRs0owOY6993kAqv3AdFqIACNStHLyr
 AelaXShjnhY/SOAIJGP5uC6MIbef+3pHI/l9I1D/P+WpLoNm1KQ3/eYJyc4NKRozpanR
 cin9EhAmKVd1L+6vMl1AbFNaZxPeZQ1Gv0B/EnKxMHKksyUL3cR3zXQhZkZrR43OAUa+
 YqA0ZM+j8hi3pKtviOBSvNx7KKN8peP11kgLzf/xg+GmHWZ1fqfskWfep4UIrO/JJA2i
 ERviD3HyO6EC1X1//lG9iBGMNSjz7FXC1Xl4fsoHjhx+gpDYHwx3TKh1DK8KmVngl3tl
 4Y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764075354; x=1764680154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zoepLKBq04qxCgjJ8tC8SphEXhzZSbT/gsrtVJa8Ow0=;
 b=hFZPUuRn0COYgQx3XFFiuCLr3BQ8vsBmZTLwPNyMDLw5+EPxewfbAK4ADrf/V/HRB1
 agCjTNApGMMZTifZWo2hE9QxUdhu2cbmOQrzkPRYu9fiuNbIEvP12FZC3wsqfNagTnKP
 C5AyzH91CkEOhWv5aAvyhaie/IzIOSdhbRzQOHCkxsctJi5B4NsOfVgk4yDibslu9jZs
 r9xmQU4yphbaWnpavKStT4/rwrnfonOJCD0u1edEs1VRW/l5rQw4gziIDN7opvrndC8D
 3fmQQ1guSVtzUjNpRCn5PkVk0OptLaFYJe/rNoD9J+3Y0zdj8aSPg5Soj3ygOLD8wma8
 H7Pw==
X-Gm-Message-State: AOJu0YwD++P2CAqf6R9uc/wrsSbkeHCgB5vgLd0bHRBMvgGuG4tYHQKt
 SbxK7vAYVXJnzd3DZa25P86fXoB1fnTBrOvANB9EAFCDOkoCT2Rui6SbyPPazMsS4WH/QA7gjsJ
 YEaXhSrIQFpSn/NfLHpZ+JJA3Yw7QA4DoFU9KN/m4Lf4qYgiiRAmc9M7JhQkpZjbZpf1+hDhJ7a
 DU4nQ4e0Nt3J6OR/meS8jFGWiGUlUGf3U=
X-Gm-Gg: ASbGncuTAy1s/CghNRyDdZkmImWJaF2++u8GyvHuRL51pJgBtud/aT8yizLq9f0L+Yw
 qavY+EIaxaHSjem8bSCn4bRXVx7e27TbuLBDri/g75597ZoUuXHuKtZfiNr8tQZwG/4LSLYG/tn
 TSTnLfkOJVJpI7FyurZc7LJ0K3+S8Z+ljU4h2cR0Q9jw3T0JnS4Ksdxv1MVQ==
X-Received: by 2002:a17:90b:37c6:b0:32e:72bd:6d5a with SMTP id
 98e67ed59e1d1-347331a773cmr15328507a91.1.1764075353694; 
 Tue, 25 Nov 2025 04:55:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG55KnaphMBHAKQOyqLvgskJhhDhXz2MZTcchgr3551Q4TV0p3T4DXGjqj1uJdwUDV1BZswTSVfx79YPAGFu6E=
X-Received: by 2002:a17:90b:37c6:b0:32e:72bd:6d5a with SMTP id
 98e67ed59e1d1-347331a773cmr15328495a91.1.1764075353328; Tue, 25 Nov 2025
 04:55:53 -0800 (PST)
MIME-Version: 1.0
References: <20251125122059.24420-1-AlanoSong@163.com>
In-Reply-To: <20251125122059.24420-1-AlanoSong@163.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Nov 2025 16:55:41 +0400
X-Gm-Features: AWmQ_bkUdAQBdsexcYFMN8zFjfkPAOdCRGDvj1fPuYesM4nwGsdg0EMasUYQr_s
Message-ID: <CAMxuvazL4=qUO4TNQ0xb865z=PvxzKcbq_-dmfwBRBKgnH2PBA@mail.gmail.com>
Subject: Re: [RFC] ui/vnc: Fix qemu abort when query vnc info
To: AlanoSong@163.com
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000cae8f506446accb8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000cae8f506446accb8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Nov 25, 2025 at 4:32=E2=80=AFPM <AlanoSong@163.com> wrote:

> From: Alano Song <AlanoSong@163.com>
>
> When there is no display device on qemu machine,
> and user only access qemu by remote vnc.
> At the same time user input `info vnc` by QMP,
> the qemu will abort.
>
> To avoid the abort above, I add display device check,
> when query vnc info in qmp_query_vnc_servers().
>
> Signed-off-by: Alano Song <AlanoSong@163.com>
>

Good catch, lgtm


> ---
>  ui/vnc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 0d499b208b..2fa79a5494 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -556,9 +556,20 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
>          qmp_query_auth(vd->auth, vd->subauth, &info->auth,
>                         &info->vencrypt, &info->has_vencrypt);
>          if (vd->dcl.con) {
> -            dev =3D DEVICE(object_property_get_link(OBJECT(vd->dcl.con),
> -                                                  "device",
> &error_abort));
> -            info->display =3D g_strdup(dev->id);
> +            Error *err =3D NULL;
> +            Object *obj =3D object_property_get_link(OBJECT(vd->dcl.con)=
,
> +                                                   "device", &err);
> +            if (obj) {
> +                dev =3D DEVICE(obj);
> +                if (dev && dev->id) {
> +                    info->display =3D g_strdup(dev->id);
> +                } else {
> +                    info->display =3D g_strdup("unknown");
> +                }
>

info->display =3D g_strdup(dev->id);

as it is fine, it will set it to NULL if doesn't have an id.

+            } else {
> +                info->display =3D g_strdup("none");
>

This should be dropped. This way the "display" field isn't even produced,
and client can distinguish the case of associated/non-associated display.



+                error_free(err);
> +            }
>          }
>          if (vd->listener !=3D NULL) {
>              nsioc =3D qio_net_listener_nsioc(vd->listener);
> --
> 2.43.0
>
>

--000000000000cae8f506446accb8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 25, 2=
025 at 4:32=E2=80=AFPM &lt;<a href=3D"mailto:AlanoSong@163.com">AlanoSong@1=
63.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">From: Alano Song &lt;<a href=3D"mailto:AlanoSong@163.com" target=3D"_=
blank">AlanoSong@163.com</a>&gt;<br>
<br>
When there is no display device on qemu machine,<br>
and user only access qemu by remote vnc.<br>
At the same time user input `info vnc` by QMP,<br>
the qemu will abort.<br>
<br>
To avoid the abort above, I add display device check,<br>
when query vnc info in qmp_query_vnc_servers().<br>
<br>
Signed-off-by: Alano Song &lt;<a href=3D"mailto:AlanoSong@163.com" target=
=3D"_blank">AlanoSong@163.com</a>&gt;<br></blockquote><div><br></div><div>G=
ood catch, lgtm</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
---<br>
=C2=A0ui/vnc.c | 17 ++++++++++++++---<br>
=C2=A01 file changed, 14 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/ui/vnc.c b/ui/vnc.c<br>
index 0d499b208b..2fa79a5494 100644<br>
--- a/ui/vnc.c<br>
+++ b/ui/vnc.c<br>
@@ -556,9 +556,20 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qmp_query_auth(vd-&gt;auth, vd-&gt;subaut=
h, &amp;info-&gt;auth,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;info-&gt;vencrypt, &amp;info-&gt;has_vencrypt);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vd-&gt;dcl.con) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D DEVICE(object_property_g=
et_link(OBJECT(vd-&gt;dcl.con),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;device&quot;, &amp;error_abort));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;display =3D g_strdup(de=
v-&gt;id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error *err =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Object *obj =3D object_property_=
get_link(OBJECT(vd-&gt;dcl.con),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;device&quot;, &amp;err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (obj) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D DEVICE(obj=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev &amp;&amp;=
 dev-&gt;id) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info=
-&gt;display =3D g_strdup(dev-&gt;id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info=
-&gt;display =3D g_strdup(&quot;unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote>=
<div><br></div><div>info-&gt;display =3D g_strdup(dev-&gt;id);</div><div><b=
r></div><div>as it is fine, it will set it to NULL if doesn&#39;t have an i=
d.=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;display =
=3D g_strdup(&quot;none&quot;);<br></blockquote><div><br></div><div>This sh=
ould be dropped. This way the &quot;display&quot; field isn&#39;t even prod=
uced, and client can distinguish the case of associated/non-associated disp=
lay.</div><div>=C2=A0</div><div><br></div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(err);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vd-&gt;listener !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nsioc =3D qio_net_listener_=
nsioc(vd-&gt;listener);<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000cae8f506446accb8--


