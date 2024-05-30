Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0791FC25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCaSE-0000GL-Vz; Thu, 30 May 2024 03:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sCaSD-0000FE-98
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sCaS7-0002dH-3s
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717055037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=63oiXoERr6pp1NQNMVwgxytciVZk7VBbeGuwCbtW2lU=;
 b=bch+wXuMUKL8v8B4y1zB7LUj+Tk3bxEjM5kcLUFYQ4dAtQ1bES5ecJB8741gUEjIoKSTQI
 YCCTvTPn82RFVg/qj99/gp33L62wwJUS1OfmQtq+TsRW+ivDEQr3K5bMb6ClhPuVGWkhKp
 eqsdTZ2Xiwc/B1cH8mxl+AhvyKM1+Ec=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-CRYFHnmyOjulF-g29hR2Qw-1; Thu, 30 May 2024 03:43:54 -0400
X-MC-Unique: CRYFHnmyOjulF-g29hR2Qw-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dfa4b878450so909444276.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717055034; x=1717659834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=63oiXoERr6pp1NQNMVwgxytciVZk7VBbeGuwCbtW2lU=;
 b=IFosc0vuLymHiUaKKCDjPd29ZH2/181R9edLHdfcHA5ZAucQEr7yBp1SPnGkE6gww+
 2h3frDEBjb35bnLi9yeAPFUcfRNVg2LUnQ7i3p9GkcdFWaUzgCvCRs79NlLLdeoRS+yt
 6XI4Q9n3OK4rl0iGIsxBkz8zWoaoexHaWUUtNkSD7+nKCC3WRiZMEoXzRpQOPgVYhyq6
 msjk7016Lbwqv34TnmA68MfMEH6GKC8yOTMzmQQ/K6tJcC7AgSQF+9DmVebwUcPsPMEW
 r7jnlhJ3Q20B1NyhTw/YR6FOl7TwSn8ZRsKPaYA6LVtUFUl8XyCpmsD7cyAQcMQ/wXdD
 Al/g==
X-Gm-Message-State: AOJu0YwjytVRlo/3S7tvlxes1F7HfAlxUkKJrH1poulraREEFPnXhfia
 6ZpClk30+cUP52nYsjWiAeoPVQDNqNCJESA+qUDeMobrYTeMC6n84OwNUWiA3FMYhgsidK9kS0H
 vpX+vrdU4+cnoGbXhHdNFVRvtcR6vniTyjU5B0QGn/dIM7WU1Ty2izHdTkC+avMK+tboBFYqfBW
 AOs3ywBlf4lKQmcpd30N97qdMMLsM=
X-Received: by 2002:a25:ac9a:0:b0:de5:5b9c:4452 with SMTP id
 3f1490d57ef6-dfa5a5e76bcmr1628342276.21.1717055034119; 
 Thu, 30 May 2024 00:43:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnJoKH682WYgeL5yMeU5jMJTF3ZN2dZ1lyZhTlOMeEwZAM9n5YQfAx7EP0HSGUoytPm6rxsGGjyeS1ONmArY0=
X-Received: by 2002:a25:ac9a:0:b0:de5:5b9c:4452 with SMTP id
 3f1490d57ef6-dfa5a5e76bcmr1628325276.21.1717055033710; Thu, 30 May 2024
 00:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240530070413.19181-1-philmd@linaro.org>
In-Reply-To: <20240530070413.19181-1-philmd@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 30 May 2024 10:43:42 +0300
Message-ID: <CAPMcbCoiF2c7HhyqwLH31yZ83DkaU0V=6uyJOLBrWUScMCEvKg@mail.gmail.com>
Subject: Re: [PATCH] qga: Remove deprecated 'blacklist' argument / config key
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000058365f0619a70733"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000058365f0619a70733
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>



On Thu, May 30, 2024 at 10:04=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> The 'blacklist' argument / config key are deprecated since commi
> 582a098e6c ("qga: Replace 'blacklist' command line and config file
> options by 'block-rpcs'"), time to remove them.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  docs/about/deprecated.rst       | 18 ------------------
>  docs/about/removed-features.rst | 18 ++++++++++++++++++
>  qga/main.c                      |  6 ------
>  3 files changed, 18 insertions(+), 24 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 40585ca7d5..a32e0e2564 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -478,24 +478,6 @@ versions, aliases will point to newer CPU model
> versions
>  depending on the machine type, so management software must
>  resolve CPU model aliases before starting a virtual machine.
>
> -QEMU guest agent
> -----------------
> -
> -``--blacklist`` command line option (since 7.2)
> -'''''''''''''''''''''''''''''''''''''''''''''''
> -
> -``--blacklist`` has been replaced by ``--block-rpcs`` (which is a better
> -wording for what this option does). The short form ``-b`` still stays
> -the same and thus is the preferred way for scripts that should run with
> -both, older and future versions of QEMU.
> -
> -``blacklist`` config file option (since 7.2)
> -''''''''''''''''''''''''''''''''''''''''''''
> -
> -The ``blacklist`` config file option has been renamed to ``block-rpcs``
> -(to be in sync with the renaming of the corresponding command line
> -option).
> -
>  Migration
>  ---------
>
> diff --git a/docs/about/removed-features.rst
> b/docs/about/removed-features.rst
> index fba0cfb0b0..deca066b21 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -1129,4 +1129,22 @@ stable for some time and is now widely used.
>  The command line and feature set is very close to the removed
>  C implementation.
>
> +QEMU guest agent
> +----------------
> +
> +``--blacklist`` command line option (removed in 9.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +``--blacklist`` has been replaced by ``--block-rpcs`` (which is a better
> +wording for what this option does). The short form ``-b`` still stays
> +the same and thus is the preferred way for scripts that should run with
> +both, older and future versions of QEMU.
> +
> +``blacklist`` config file option (removed in 9.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``blacklist`` config file option has been renamed to ``block-rpcs``
> +(to be in sync with the renaming of the corresponding command line
> +option).
> +
>  .. _Intel discontinuance notification:
> https://www.intel.com/content/www/us/en/content-details/781327/intel-is-d=
iscontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip.html
> diff --git a/qga/main.c b/qga/main.c
> index bdf5344584..f4d5f15bb3 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -1071,11 +1071,6 @@ static void config_load(GAConfig *config)
>              g_key_file_get_boolean(keyfile, "general", "retry-path",
> &gerr);
>      }
>
> -    if (g_key_file_has_key(keyfile, "general", "blacklist", NULL)) {
> -        g_warning("config using deprecated 'blacklist' key, should be
> replaced"
> -                  " with the 'block-rpcs' key.");
> -        blockrpcs_key =3D "blacklist";
> -    }
>      if (g_key_file_has_key(keyfile, "general", blockrpcs_key, NULL)) {
>          config->bliststr =3D
>              g_key_file_get_string(keyfile, "general", blockrpcs_key,
> &gerr);
> @@ -1190,7 +1185,6 @@ static void config_parse(GAConfig *config, int argc=
,
> char **argv)
>          { "path", 1, NULL, 'p' },
>          { "daemonize", 0, NULL, 'd' },
>          { "block-rpcs", 1, NULL, 'b' },
> -        { "blacklist", 1, NULL, 'b' },  /* deprecated alias for
> 'block-rpcs' */
>          { "allow-rpcs", 1, NULL, 'a' },
>  #ifdef _WIN32
>          { "service", 1, NULL, 's' },
> --
> 2.41.0
>
>

--00000000000058365f0619a70733
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<div><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div =
dir=3D"ltr"><br></div></div></div><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 30, 2024 at 10:04=E2=80=
=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">=
philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">The &#39;blacklist&#39; argument / config key are deprecat=
ed since commi<br>
582a098e6c (&quot;qga: Replace &#39;blacklist&#39; command line and config =
file<br>
options by &#39;block-rpcs&#39;&quot;), time to remove them.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0docs/about/deprecated.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0| 18 ------------=
------<br>
=C2=A0docs/about/removed-features.rst | 18 ++++++++++++++++++<br>
=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 6 ------<br>
=C2=A03 files changed, 18 insertions(+), 24 deletions(-)<br>
<br>
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst<br>
index 40585ca7d5..a32e0e2564 100644<br>
--- a/docs/about/deprecated.rst<br>
+++ b/docs/about/deprecated.rst<br>
@@ -478,24 +478,6 @@ versions, aliases will point to newer CPU model versio=
ns<br>
=C2=A0depending on the machine type, so management software must<br>
=C2=A0resolve CPU model aliases before starting a virtual machine.<br>
<br>
-QEMU guest agent<br>
-----------------<br>
-<br>
-``--blacklist`` command line option (since 7.2)<br>
-&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;<br>
-<br>
-``--blacklist`` has been replaced by ``--block-rpcs`` (which is a better<b=
r>
-wording for what this option does). The short form ``-b`` still stays<br>
-the same and thus is the preferred way for scripts that should run with<br=
>
-both, older and future versions of QEMU.<br>
-<br>
-``blacklist`` config file option (since 7.2)<br>
-&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
-<br>
-The ``blacklist`` config file option has been renamed to ``block-rpcs``<br=
>
-(to be in sync with the renaming of the corresponding command line<br>
-option).<br>
-<br>
=C2=A0Migration<br>
=C2=A0---------<br>
<br>
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.=
rst<br>
index fba0cfb0b0..deca066b21 100644<br>
--- a/docs/about/removed-features.rst<br>
+++ b/docs/about/removed-features.rst<br>
@@ -1129,4 +1129,22 @@ stable for some time and is now widely used.<br>
=C2=A0The command line and feature set is very close to the removed<br>
=C2=A0C implementation.<br>
<br>
+QEMU guest agent<br>
+----------------<br>
+<br>
+``--blacklist`` command line option (removed in 9.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+``--blacklist`` has been replaced by ``--block-rpcs`` (which is a better<b=
r>
+wording for what this option does). The short form ``-b`` still stays<br>
+the same and thus is the preferred way for scripts that should run with<br=
>
+both, older and future versions of QEMU.<br>
+<br>
+``blacklist`` config file option (removed in 9.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``blacklist`` config file option has been renamed to ``block-rpcs``<br=
>
+(to be in sync with the renaming of the corresponding command line<br>
+option).<br>
+<br>
=C2=A0.. _Intel discontinuance notification: <a href=3D"https://www.intel.c=
om/content/www/us/en/content-details/781327/intel-is-discontinuing-ip-order=
ing-codes-listed-in-pdn2312-for-nios-ii-ip.html" rel=3D"noreferrer" target=
=3D"_blank">https://www.intel.com/content/www/us/en/content-details/781327/=
intel-is-discontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip.h=
tml</a><br>
diff --git a/qga/main.c b/qga/main.c<br>
index bdf5344584..f4d5f15bb3 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -1071,11 +1071,6 @@ static void config_load(GAConfig *config)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_key_file_get_boolean(keyf=
ile, &quot;general&quot;, &quot;retry-path&quot;, &amp;gerr);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (g_key_file_has_key(keyfile, &quot;general&quot;, &quot;b=
lacklist&quot;, NULL)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_warning(&quot;config using deprecated &#39;b=
lacklist&#39; key, should be replaced&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; with=
 the &#39;block-rpcs&#39; key.&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 blockrpcs_key =3D &quot;blacklist&quot;;<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0if (g_key_file_has_key(keyfile, &quot;general&quot;, bl=
ockrpcs_key, NULL)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;bliststr =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_key_file_get_string(keyfi=
le, &quot;general&quot;, blockrpcs_key, &amp;gerr);<br>
@@ -1190,7 +1185,6 @@ static void config_parse(GAConfig *config, int argc, =
char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;path&quot;, 1, NULL, &#39;p&#39; =
},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;daemonize&quot;, 0, NULL, &#39;d&=
#39; },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;block-rpcs&quot;, 1, NULL, &#39;b=
&#39; },<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;blacklist&quot;, 1, NULL, &#39;b&#39; =
},=C2=A0 /* deprecated alias for &#39;block-rpcs&#39; */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;allow-rpcs&quot;, 1, NULL, &#39;a=
&#39; },<br>
=C2=A0#ifdef _WIN32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;service&quot;, 1, NULL, &#39;s&#3=
9; },<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div>

--00000000000058365f0619a70733--


