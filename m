Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7BCE77171
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 09:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIlhU-0005BB-Qq; Wed, 04 Dec 2024 04:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tIlhT-0005Ao-NW
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 04:29:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tIlhR-0006H1-EE
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 04:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733304574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WGIFDMbxTzYO6P9iUk2QKTRF4uyJckQBLanVzeDA/nc=;
 b=JVHQjy3XhsJIGTDWTiE9I132JhtVnHVwONKpa2rNCXWOJvUIR+UisxnrhAHCwZxD8PruY1
 Fw910kz6eXPUq8iRcLtbBB7No17R7dzFER1QiMWBiWbflE9XRjXfREP9i5dRAb9W2Mkhc4
 2iXiRxlZ9ToerxY7AsSC/1CoalKB3kw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Hy-0UH6cPWqhudbm2fU2lA-1; Wed, 04 Dec 2024 04:29:32 -0500
X-MC-Unique: Hy-0UH6cPWqhudbm2fU2lA-1
X-Mimecast-MFC-AGG-ID: Hy-0UH6cPWqhudbm2fU2lA
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d88e7976e3so64794206d6.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 01:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733304572; x=1733909372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WGIFDMbxTzYO6P9iUk2QKTRF4uyJckQBLanVzeDA/nc=;
 b=evJ5GSQ+5K81rCruFPkm0L+WIN2ZOVZ3bqnxrSh5MJy4RgkUWBQw/FH61vUF1rHkrr
 kUxGy2ChYXdJ6dMBNzeZFf/9KrXZfn7NjKNQWDf4JKRNXNE9iZq7bfnCX+3K6CFfT97t
 qA+APxlCZ5mkzCPozLj+uzN5rq015l5Y11JHm4/fvx9g5XcJ8MzsvI14u7gcRn16vHFA
 0IyBZVsoRzIrgCRJWLNXC/wCGe5JefsgteSYOHuA6k5iztigoXjR7ltZj5ggxVSSPPzG
 kccUWydTerwhvX1NYEAd/ETxXyZbYtY3DFpAWoBOIXapi6CVyyheTOEJgKKBJque3tA5
 AgCA==
X-Gm-Message-State: AOJu0Yw7dwd+y0TokQ8XHwJ7xE2sgeuEd2u+o8tJWwkiQbCmwDOjCXaN
 gRr/yFj4Z0FpqEOmKz3sKxY4fLslZpK1DYmrIIFK9+UFoKQhejN6Ktvjdk0ZAbQSgT8P0tqNGet
 yxkLVmA7Tmn2VqqHoEHLhL4qIrYAAoC0EhPpf1sP5xe7tmeA1IUBy4ucWPT9UgNlP7BH/DrxMoF
 iaMjWFVlITyKMCE2Bck/RSvIHc2zA=
X-Gm-Gg: ASbGnctfjGgghIX28wE8YVsNVkpULYQcc1A+gjNEe59ejzmfoAMgMknRlosSQTr8WuT
 Nk9sAvFmhgBQtwbdGCUwoLmzAlc/jG0KMWg==
X-Received: by 2002:ad4:5c6c:0:b0:6d8:68a1:b7aa with SMTP id
 6a1803df08f44-6d8b739fd72mr89663136d6.28.1733304571812; 
 Wed, 04 Dec 2024 01:29:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5M1K7i/9KT5twE2otWw+rb3YCTw+kh08aAV/GVRP/yf35KpVIHQQQyNLRQs6BYvK0hZLSX2T4/WSZjEyAL0o=
X-Received: by 2002:ad4:5c6c:0:b0:6d8:68a1:b7aa with SMTP id
 6a1803df08f44-6d8b739fd72mr89662966d6.28.1733304571478; Wed, 04 Dec 2024
 01:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20241202121927.864335-1-berrange@redhat.com>
In-Reply-To: <20241202121927.864335-1-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 4 Dec 2024 11:29:20 +0200
Message-ID: <CAPMcbCq8OrcTx2oj0=9KVacsbp4p+X3tXyeTwygjRwat+spB6A@mail.gmail.com>
Subject: Re: [PATCH] qga: implement a 'guest-get-load' command
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?B?Sm/Do28gVmlsYcOnYQ==?= <jvilaca@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004553ca06286e6b83"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

--0000000000004553ca06286e6b83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Mon, Dec 2, 2024 at 2:19=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> Provide a way to report the process load average, via a new
> 'guest-get-load' command.
>
> This is only implemented for POSIX platforms providing 'getloadavg'.
>
> Example illustrated with qmp-shell:
>
> (QEMU) guest-get-load
> {
>     "return": {
>         "load15m": 1.546875,
>         "load1m": 1.669921875,
>         "load5m": 1.9306640625
>     }
> }
>
> Windows has no native equivalent API, but it would be possible to
> simulate it as illustrated here (BSD-3-Clause):
>
>   https://github.com/giampaolo/psutil/pull/1485
>
> This is left as an exercise for future contributors.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  meson.build          |  1 +
>  qga/commands-posix.c | 20 ++++++++++++++++++++
>  qga/qapi-schema.json | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index a290dbfa33..9c65e56fff 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2619,6 +2619,7 @@ config_host_data.set('CONFIG_SETNS',
> cc.has_function('setns') and cc.has_functio
>  config_host_data.set('CONFIG_SYNCFS', cc.has_function('syncfs'))
>  config_host_data.set('CONFIG_SYNC_FILE_RANGE',
> cc.has_function('sync_file_range'))
>  config_host_data.set('CONFIG_TIMERFD', cc.has_function('timerfd_create')=
)
> +config_host_data.set('CONFIG_GETLOADAVG', cc.has_function('getloadavg'))
>  config_host_data.set('HAVE_COPY_FILE_RANGE',
> cc.has_function('copy_file_range'))
>  config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
>  config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 636307bedf..6e3c15f539 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1368,3 +1368,23 @@ char *qga_get_host_name(Error **errp)
>
>      return g_steal_pointer(&hostname);
>  }
> +
> +#ifdef CONFIG_GETLOADAVG
> +GuestLoadAverage *qmp_guest_get_load(Error **errp)
> +{
> +    double loadavg[3];
> +    GuestLoadAverage *ret =3D NULL;
> +
> +    if (getloadavg(loadavg, G_N_ELEMENTS(loadavg)) < 0) {
> +        error_setg_errno(errp, errno,
> +                         "cannot query load average");
> +        return NULL;
> +    }
> +
> +    ret =3D g_new0(GuestLoadAverage, 1);
> +    ret->load1m =3D loadavg[0];
> +    ret->load5m =3D loadavg[1];
> +    ret->load15m =3D loadavg[2];
> +    return ret;
> +}
> +#endif
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 0537bb7886..995594aaf4 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1843,6 +1843,43 @@
>    'if': 'CONFIG_LINUX'
>  }
>
> +
> +##
> +# @GuestLoadAverage:
> +#
> +# Statistics about process load information
> +#
> +# @load1m: 1-minute load avage
> +#
> +# @load5m: 5-minute load avage
> +#
> +# @load15m: 15-minute load avage
> +#
> +# Since: 10.0
> +##
> +{ 'struct': 'GuestLoadAverage',
> +  'data': {
> +      'load1m': 'number',
> +      'load5m': 'number',
> +      'load15m': 'number'
> +  },
> +  'if': 'CONFIG_GETLOADAVG'
> +}
> +
> +##
> +# @guest-get-load:
> +#
> +# Retrieve CPU process load information
> +#
> +# Returns: load information
> +#
> +# Since: 10.0
> +##
> +{ 'command': 'guest-get-load',
> +  'returns': 'GuestLoadAverage',
> +  'if': 'CONFIG_GETLOADAVG'
> +}
> +
>  ##
>  # @GuestNetworkRoute:
>  #
> --
> 2.46.0
>
>

--0000000000004553ca06286e6b83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 2=
, 2024 at 2:19=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:ber=
range@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Provide a way to rep=
ort the process load average, via a new<br>
&#39;guest-get-load&#39; command.<br>
<br>
This is only implemented for POSIX platforms providing &#39;getloadavg&#39;=
.<br>
<br>
Example illustrated with qmp-shell:<br>
<br>
(QEMU) guest-get-load<br>
{<br>
=C2=A0 =C2=A0 &quot;return&quot;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;load15m&quot;: 1.546875,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;load1m&quot;: 1.669921875,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;load5m&quot;: 1.9306640625<br>
=C2=A0 =C2=A0 }<br>
}<br>
<br>
Windows has no native equivalent API, but it would be possible to<br>
simulate it as illustrated here (BSD-3-Clause):<br>
<br>
=C2=A0 <a href=3D"https://github.com/giampaolo/psutil/pull/1485" rel=3D"nor=
eferrer" target=3D"_blank">https://github.com/giampaolo/psutil/pull/1485</a=
><br>
<br>
This is left as an exercise for future contributors.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0qga/commands-posix.c | 20 ++++++++++++++++++++<br>
=C2=A0qga/qapi-schema.json | 37 +++++++++++++++++++++++++++++++++++++<br>
=C2=A03 files changed, 58 insertions(+)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index a290dbfa33..9c65e56fff 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -2619,6 +2619,7 @@ config_host_data.set(&#39;CONFIG_SETNS&#39;, cc.has_f=
unction(&#39;setns&#39;) and cc.has_functio<br>
=C2=A0config_host_data.set(&#39;CONFIG_SYNCFS&#39;, cc.has_function(&#39;sy=
ncfs&#39;))<br>
=C2=A0config_host_data.set(&#39;CONFIG_SYNC_FILE_RANGE&#39;, cc.has_functio=
n(&#39;sync_file_range&#39;))<br>
=C2=A0config_host_data.set(&#39;CONFIG_TIMERFD&#39;, cc.has_function(&#39;t=
imerfd_create&#39;))<br>
+config_host_data.set(&#39;CONFIG_GETLOADAVG&#39;, cc.has_function(&#39;get=
loadavg&#39;))<br>
=C2=A0config_host_data.set(&#39;HAVE_COPY_FILE_RANGE&#39;, cc.has_function(=
&#39;copy_file_range&#39;))<br>
=C2=A0config_host_data.set(&#39;HAVE_GETIFADDRS&#39;, cc.has_function(&#39;=
getifaddrs&#39;))<br>
=C2=A0config_host_data.set(&#39;HAVE_GLIB_WITH_SLICE_ALLOCATOR&#39;, glib_h=
as_gslice)<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 636307bedf..6e3c15f539 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1368,3 +1368,23 @@ char *qga_get_host_name(Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0return g_steal_pointer(&amp;hostname);<br>
=C2=A0}<br>
+<br>
+#ifdef CONFIG_GETLOADAVG<br>
+GuestLoadAverage *qmp_guest_get_load(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 double loadavg[3];<br>
+=C2=A0 =C2=A0 GuestLoadAverage *ret =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 if (getloadavg(loadavg, G_N_ELEMENTS(loadavg)) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;cannot query load average&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 ret =3D g_new0(GuestLoadAverage, 1);<br>
+=C2=A0 =C2=A0 ret-&gt;load1m =3D loadavg[0];<br>
+=C2=A0 =C2=A0 ret-&gt;load5m =3D loadavg[1];<br>
+=C2=A0 =C2=A0 ret-&gt;load15m =3D loadavg[2];<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+#endif<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 0537bb7886..995594aaf4 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1843,6 +1843,43 @@<br>
=C2=A0 =C2=A0&#39;if&#39;: &#39;CONFIG_LINUX&#39;<br>
=C2=A0}<br>
<br>
+<br>
+##<br>
+# @GuestLoadAverage:<br>
+#<br>
+# Statistics about process load information<br>
+#<br>
+# @load1m: 1-minute load avage<br>
+#<br>
+# @load5m: 5-minute load avage<br>
+#<br>
+# @load15m: 15-minute load avage<br>
+#<br>
+# Since: 10.0<br>
+##<br>
+{ &#39;struct&#39;: &#39;GuestLoadAverage&#39;,<br>
+=C2=A0 &#39;data&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;load1m&#39;: &#39;number&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;load5m&#39;: &#39;number&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;load15m&#39;: &#39;number&#39;<br>
+=C2=A0 },<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_GETLOADAVG&#39;<br>
+}<br>
+<br>
+##<br>
+# @guest-get-load:<br>
+#<br>
+# Retrieve CPU process load information<br>
+#<br>
+# Returns: load information<br>
+#<br>
+# Since: 10.0<br>
+##<br>
+{ &#39;command&#39;: &#39;guest-get-load&#39;,<br>
+=C2=A0 &#39;returns&#39;: &#39;GuestLoadAverage&#39;,<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_GETLOADAVG&#39;<br>
+}<br>
+<br>
=C2=A0##<br>
=C2=A0# @GuestNetworkRoute:<br>
=C2=A0#<br>
-- <br>
2.46.0<br>
<br>
</blockquote></div>

--0000000000004553ca06286e6b83--


