Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15045C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 11:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq9XL-0006vn-1d; Thu, 06 Mar 2025 06:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tq9XC-0006uT-M9
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 06:37:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tq9XA-0006sA-Eu
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 06:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741261019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLQfEOMGWpxgLXQhNBFjxFx/BKO6TLiimvv3Zx/uBGA=;
 b=II/tJV0P2+rkFL5pX6cyPrBIrsPcXvb4ksEjZOqwb3CGh6+qPFeixnhyhYbdWJ7UuZhLAA
 Znl0J3T1rQSz4C2sqolWel6qT0MejdWxq1RajfliXITnWZ0/1cg7znx5o0S394DWY9Zqco
 dGEAm1zXt0LucV2erABxxHW0vCgYulU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-pNX-QQTNOGifZGzaXFSceg-1; Thu, 06 Mar 2025 06:36:55 -0500
X-MC-Unique: pNX-QQTNOGifZGzaXFSceg-1
X-Mimecast-MFC-AGG-ID: pNX-QQTNOGifZGzaXFSceg_1741261014
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912fe32a30so60808f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 03:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741261014; x=1741865814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZLQfEOMGWpxgLXQhNBFjxFx/BKO6TLiimvv3Zx/uBGA=;
 b=Gaggm9XaBSe6yWBKB8O0mBxIB+jSLqXkmAng+BUZNyn6UqMLadyRgHSxKh4wDrbjwU
 mJxk8DHLqRCbSI+PlbS7rzTVBZh+8b8hdWu/inbQBLGj2M7mZNxD1qaEB/cWGfUT0Ngx
 KOgqHN0IvQmTL3SVfKawo0oajYgFOwTXrXWkiJ5aRu6n4tNBkCqOdMso2mlx80DkC4OJ
 nl8ZgontcMTsZooPLKDRXKFCv26F801jIPMGw78ENF53EFkTpef/nyXMNKl87xREZ5nH
 b8DJ7+oCFvvq1ZUDiyLxC3fe3pRZKeN0/cwa5s3a3v8yFxeYpbuZK1+6EmA1PygVYmqY
 6snQ==
X-Gm-Message-State: AOJu0Ywel1rqRnxmEETpiFNvQBVCgkY+OQbJ7b+20NkWqexnQYc7k8Ap
 w8VaAt2X6WX4BTMnvnxf1ryWjp/43kIqgIITG0shM8hlhFY+sVLxRNRRo+a2/pmWanvPqrDpkq4
 HMwbPI2PDw7YhYK32+z7sYbPCFe8qqrrg0ORbIcS277tFJvgk/E/DlUyzSVeX9tTgkwRzE3GeTS
 edVe/Ol2NDQHKHfYYanHZJx7sauYM=
X-Gm-Gg: ASbGncvEO0pDAasoyx99Q+SkWaSw043VxR23HKlCbaInoLzjrYDS7LHFhmpUagCxe3c
 ka90ikbvF1MLqE/tQbFhhPlkK/1N9eqPap4Gl3tzphKbXE0JL4c8T801tdeSU+ix6lp0gZnCX
X-Received: by 2002:a5d:64aa:0:b0:391:2887:5193 with SMTP id
 ffacd0b85a97d-39128875308mr3174494f8f.40.1741261014171; 
 Thu, 06 Mar 2025 03:36:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhZszNZ9sowu8Gsg1YWalPFEJyJTswgDZR6YsM68RyULJjwNyoEjJKxqftZ/JymgbJ9YbWCc53XCdwtIRsZjc=
X-Received: by 2002:a5d:64aa:0:b0:391:2887:5193 with SMTP id
 ffacd0b85a97d-39128875308mr3174481f8f.40.1741261013863; Thu, 06 Mar 2025
 03:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20250306105306.2064458-1-alex.bennee@linaro.org>
In-Reply-To: <20250306105306.2064458-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Mar 2025 12:36:40 +0100
X-Gm-Features: AQ5f1JrRJ1JrWTZUjbPLD-Hlb7TpcLuGGp-0y7mdz010ApLN8jGChoAvcl-J3mg
Message-ID: <CABgObfZpf7Oki+0rH-3OTBLF_cW8+5e-jAaG=AU58oAn8CP=5w@mail.gmail.com>
Subject: Re: [PATCH v2] meson.build: default to -gsplit-dwarf for debug info
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003160db062faaecc8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--0000000000003160db062faaecc8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 6 mar 2025, 11:53 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scrit=
to:

> -option_cflags =3D (get_option('debug') ? ['-g'] : [])
> +option_cflags =3D []
> +if get_option('debug')
> +  option_cflags +=3D get_option('split_debug') ? ['-gsplit-dwarf'] : ['-=
g']
> +endif
>

option_cflags does nothing, it's only for clarity in the final summary. So
you need

if get_option('debug') and get_option('split_debug')
  qemu_cflags +=3D '-gsplit-dwarf'
endif

(I wonder if it should be implemented in meson instead... It should be
beneficial for other projects surely).

Paolo

 if get_option('optimization') !=3D 'plain'
>    option_cflags +=3D ['-O' + get_option('optimization')]
>  endif
> diff --git a/meson_options.txt b/meson_options.txt
> index 59d973bca0..3432123fee 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -362,6 +362,8 @@ option('debug_mutex', type: 'boolean', value: false,
>         description: 'mutex debugging support')
>  option('debug_stack_usage', type: 'boolean', value: false,
>         description: 'measure coroutine stack usage')
> +option('split_debug', type: 'boolean', value: true,
> +       description: 'split debug info from object files')
>  option('qom_cast_debug', type: 'boolean', value: true,
>         description: 'cast debugging support')
>  option('slirp_smbd', type : 'feature', value : 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.s=
h
> index 3e8e00852b..aca6e68830 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -504,6 +504,8 @@ _meson_option_parse() {
>      --disable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=3Dfalse=
 ;;
>      --enable-strip) printf "%s" -Dstrip=3Dtrue ;;
>      --disable-strip) printf "%s" -Dstrip=3Dfalse ;;
> +    --enable-split-debug) printf "%s" -Dsplit_debug=3Dtrue ;;
> +    --disable-split-debug) printf "%s" -Dsplit_debug=3Dfalse ;;
>      --sysconfdir=3D*) quote_sh "-Dsysconfdir=3D$2" ;;
>      --enable-tcg) printf "%s" -Dtcg=3Denabled ;;
>      --disable-tcg) printf "%s" -Dtcg=3Ddisabled ;;
> --
> 2.39.5
>
>

--0000000000003160db062faaecc8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 6 mar 2025, 11:53 Alex Be=
nn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.=
org</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
-option_cflags =3D (get_option(&#39;debug&#39;) ? [&#39;-g&#39;] : [])<br>
+option_cflags =3D []<br>
+if get_option(&#39;debug&#39;)<br>
+=C2=A0 option_cflags +=3D get_option(&#39;split_debug&#39;) ? [&#39;-gspli=
t-dwarf&#39;] : [&#39;-g&#39;]<br>
+endif<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">option_cflags does nothing, it&#39;s only for clarity in the final su=
mmary. So you need</div><div dir=3D"auto"><br></div><div dir=3D"auto">if ge=
t_option(&#39;debug&#39;) and get_option(&#39;split_debug&#39;)</div><div d=
ir=3D"auto">=C2=A0 qemu_cflags +=3D &#39;-gsplit-dwarf&#39;</div><div dir=
=3D"auto">endif</div><div dir=3D"auto"><br></div><div dir=3D"auto">(I wonde=
r if it should be implemented in meson instead... It should be beneficial f=
or other projects surely).</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"g=
mail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
=C2=A0if get_option(&#39;optimization&#39;) !=3D &#39;plain&#39;<br>
=C2=A0 =C2=A0option_cflags +=3D [&#39;-O&#39; + get_option(&#39;optimizatio=
n&#39;)]<br>
=C2=A0endif<br>
diff --git a/meson_options.txt b/meson_options.txt<br>
index 59d973bca0..3432123fee 100644<br>
--- a/meson_options.txt<br>
+++ b/meson_options.txt<br>
@@ -362,6 +362,8 @@ option(&#39;debug_mutex&#39;, type: &#39;boolean&#39;, =
value: false,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;mutex debugging support&#39;)=
<br>
=C2=A0option(&#39;debug_stack_usage&#39;, type: &#39;boolean&#39;, value: f=
alse,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;measure coroutine stack usage=
&#39;)<br>
+option(&#39;split_debug&#39;, type: &#39;boolean&#39;, value: true,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;split debug info from object =
files&#39;)<br>
=C2=A0option(&#39;qom_cast_debug&#39;, type: &#39;boolean&#39;, value: true=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;cast debugging support&#39;)<=
br>
=C2=A0option(&#39;slirp_smbd&#39;, type : &#39;feature&#39;, value : &#39;a=
uto&#39;,<br>
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh<=
br>
index 3e8e00852b..aca6e68830 100644<br>
--- a/scripts/meson-buildoptions.sh<br>
+++ b/scripts/meson-buildoptions.sh<br>
@@ -504,6 +504,8 @@ _meson_option_parse() {<br>
=C2=A0 =C2=A0 =C2=A0--disable-strict-rust-lints) printf &quot;%s&quot; -Dst=
rict_rust_lints=3Dfalse ;;<br>
=C2=A0 =C2=A0 =C2=A0--enable-strip) printf &quot;%s&quot; -Dstrip=3Dtrue ;;=
<br>
=C2=A0 =C2=A0 =C2=A0--disable-strip) printf &quot;%s&quot; -Dstrip=3Dfalse =
;;<br>
+=C2=A0 =C2=A0 --enable-split-debug) printf &quot;%s&quot; -Dsplit_debug=3D=
true ;;<br>
+=C2=A0 =C2=A0 --disable-split-debug) printf &quot;%s&quot; -Dsplit_debug=
=3Dfalse ;;<br>
=C2=A0 =C2=A0 =C2=A0--sysconfdir=3D*) quote_sh &quot;-Dsysconfdir=3D$2&quot=
; ;;<br>
=C2=A0 =C2=A0 =C2=A0--enable-tcg) printf &quot;%s&quot; -Dtcg=3Denabled ;;<=
br>
=C2=A0 =C2=A0 =C2=A0--disable-tcg) printf &quot;%s&quot; -Dtcg=3Ddisabled ;=
;<br>
-- <br>
2.39.5<br>
<br>
</blockquote></div></div></div>

--0000000000003160db062faaecc8--


