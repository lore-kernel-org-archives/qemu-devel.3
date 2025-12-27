Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFB2E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 08:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQ6H-0002uc-MP; Sat, 27 Dec 2025 03:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQ6F-0002uE-O3
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 03:56:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQ6E-0002Af-5W
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 03:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766825792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wVQTTxAlSm7uaINqK/t71AApv1AnT8OGVNySVSVWrPk=;
 b=Lh7NLCkBml8M90kvcO2ZXTb4Rkfx7DC6LHgC8C7s0ZyCFHodpEF5DBmkr5d0Z07rh4TjtC
 wLhUO1dvs5qKZ7ORtwlM02beYQNwWlNurc4iXWtuCdZ5f6c9FBsInY485+mi0i6QuW9Mhb
 SaqT1qLGv9G7KwgZu+xRIZUuqlj+5Iw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-dID0uJx3ORiAC78AkcgD5A-1; Sat, 27 Dec 2025 03:56:30 -0500
X-MC-Unique: dID0uJx3ORiAC78AkcgD5A-1
X-Mimecast-MFC-AGG-ID: dID0uJx3ORiAC78AkcgD5A_1766825789
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477cf25ceccso85424145e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 00:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766825789; x=1767430589; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wVQTTxAlSm7uaINqK/t71AApv1AnT8OGVNySVSVWrPk=;
 b=hYwCeq1WfA5n8sF/R6LpQPgOkuR4DwXgDxbnyD9EuFQKNYGD2LY+NtvyDSnuSDj+aJ
 7wB1lFG5ToW1R3Be4acG1qDyNzHl4CiWlsayKspi+Rc+O2eN7YGh/gJD5Qg9CZwb74Ua
 722dJUPpO8JUuZNE8xuE7ai5kDrHBe1UOOEs5SmqFp9OuJz7JVZ//M6kINsHgJF/5yn3
 aH/Nsh5nMU5qIujXMNlnHMzXCPGFvm0SxLpjwF8QIe601lZ+NRUPsYXjn093JEW/+TrM
 UKSkMuqtJAU/2/lKGALdzYS5IBKYakqeugt14k3t5pqAd/JORYdo1hbiUm3qzzJ5brqX
 D1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766825789; x=1767430589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVQTTxAlSm7uaINqK/t71AApv1AnT8OGVNySVSVWrPk=;
 b=vtbg6WVxJjwgq61Z/TBzfbgnJHs2OKRkO+D54YCo/R6RLkmmeQhcAGKX8a1ux6LyNF
 +ejRpK2KP9AYmtKfGPPw0/4VlxtfVhyn1//bNJjer4iJtqXvh2X60WtoDiZs8LZk16fx
 rejUyBuVhIV8oyk9gE/hg+AZdB0galYmy+gq0DA/jIKo2TO777nr/mXv1UQM1i9bpz/P
 hY6f86NC5Y4tFom8XJR/6jlH2zQR4OrFQFSREdPXeqoYkdf1gAQdlerXaH8hBE2FBlJp
 aDRdDWcjvlaQPd4AWfsxPA9V/ovmc02SEdMvhzmvX0NLa9JkOn2YaNjkvC8Dd7ry5hdx
 9LRw==
X-Gm-Message-State: AOJu0YyvvUa6S3MAKWiPjPwXKtP9Guihi3ui6NrkinifG9YZz99OO0WD
 b6Cwfb8B5XphARWgP7TgxPSQVBvM5rwO3+p10wEdJLYeU7aBcv4rXumpBXUDilBlcPsANA4npLB
 uULJRps0yBFisAKrYm+8EJGSTUwhhHBPVFtGjXWpxk450uLHbuCz56/iueymEjX+On6gfW39NHG
 GGThH+7tFeGG6NOmcfLd+NrSvfgS/5jtA=
X-Gm-Gg: AY/fxX60FXVqNjy+pNcwpJVfVPyOQm7isr7LUMNzCUiQpwAmzvG6//MWlKB8jZ5NBPN
 13pHZ+ydChgJ0943dwSGl7lMW2jUSVu+SHqdxoduVDNW+kBigl52vTlNYJ2q8/MZjaBEDx0CA1r
 kdQHVo1TT8jsYdgueFCrs02T+EPGYgfrUBAHOXE0G3vDcoOQ/QyogTGmy/J/ic0cfZQveKbow++
 xlWxZch7BeQkSW51sBKGvtDi++DEl0GdME4dcTVlEwXW8vkkJKJ/o1GsGGzBzO24hAW97M=
X-Received: by 2002:a05:600c:1912:b0:477:89d5:fdac with SMTP id
 5b1f17b1804b1-47d1959f714mr323558555e9.31.1766825789084; 
 Sat, 27 Dec 2025 00:56:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPtpOZQCRNN2KUr80gb+tw/nraPJwlFhATpuBokbXFZilVXivfSuWx+4r1yS17xpd//5LaC/IZ02vTdb0M5wY=
X-Received: by 2002:a05:600c:1912:b0:477:89d5:fdac with SMTP id
 5b1f17b1804b1-47d1959f714mr323558405e9.31.1766825788721; Sat, 27 Dec 2025
 00:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-17-philmd@linaro.org>
In-Reply-To: <20251224152210.87880-17-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 27 Dec 2025 09:56:18 +0100
X-Gm-Features: AQt7F2pndtzbEr_lz1-0lcMZQeO3qYWkDYOBTOgplfR_mHfG9Q62zewwgBaLLyg
Message-ID: <CABgObfa9gHpK3CR8Aa6MA4YqfaMs3bn70pba58QQ2+32+xwxzQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/25] system: Allow restricting the legacy ld/st_he()
 'native-endian' API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Content-Type: multipart/alternative; boundary="000000000000845e0b0646eb2f0c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000845e0b0646eb2f0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 24 dic 2025, 16:24 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> Guard the native endian APIs we want to remove by surrounding
> them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.
>
> Once a target gets cleaned we'll set the definition in the
> target config, then the target won't be able to use the legacy
> API anymore.
>

Host endianness APIs are fine and are used when talking to the kernel.
These functions that take a void* should not be included in
TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API.

(And also they are the same for all targets so they don't get in the way of
the single binary effort).

If the only change needed in the series is to drop this patch, don't bother
with reposting.

Paolo


> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/qemu/bswap.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 65a1b3634f4..d1c889e7bc9 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -412,7 +412,9 @@ static inline void stq_be_p(void *ptr, uint64_t v)
>          }                                                               =
\
>      }
>
> +#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
>  DO_STN_LDN_P(he)
> +#endif
>  DO_STN_LDN_P(le)
>  DO_STN_LDN_P(be)
>
> @@ -423,6 +425,7 @@ DO_STN_LDN_P(be)
>  #undef le_bswaps
>  #undef be_bswaps
>
> +#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
>
>  /* Return ld{word}_{le,be}_p following target endianness. */
>  #define LOAD_IMPL(word, args...)                    \
> @@ -494,4 +497,6 @@ static inline void stn_p(void *ptr, int sz, uint64_t =
v)
>
>  #undef STORE_IMPL
>
> +#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
> +
>  #endif /* BSWAP_H */
> --
> 2.52.0
>
>

--000000000000845e0b0646eb2f0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 24 dic 2025, 16:24 Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linar=
o.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Guard the native endian APIs we want to remove by surrounding<br=
>
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef&#39;ry.<br>
<br>
Once a target gets cleaned we&#39;ll set the definition in the<br>
target config, then the target won&#39;t be able to use the legacy<br>
API anymore.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Host endianness APIs are fine and are used when talking to the =
kernel. These functions that take a void* should not be included in TARGET_=
NOT_USING_LEGACY_NATIVE_ENDIAN_API.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">(And also they are the same for all targets so they don&#39;t g=
et in the way of the single binary effort).</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">If the only change needed in the series is to drop this=
 patch, don&#39;t bother with reposting.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0include/qemu/bswap.h | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h<br>
index 65a1b3634f4..d1c889e7bc9 100644<br>
--- a/include/qemu/bswap.h<br>
+++ b/include/qemu/bswap.h<br>
@@ -412,7 +412,9 @@ static inline void stq_be_p(void *ptr, uint64_t v)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API<br>
=C2=A0DO_STN_LDN_P(he)<br>
+#endif<br>
=C2=A0DO_STN_LDN_P(le)<br>
=C2=A0DO_STN_LDN_P(be)<br>
<br>
@@ -423,6 +425,7 @@ DO_STN_LDN_P(be)<br>
=C2=A0#undef le_bswaps<br>
=C2=A0#undef be_bswaps<br>
<br>
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API<br>
<br>
=C2=A0/* Return ld{word}_{le,be}_p following target endianness. */<br>
=C2=A0#define LOAD_IMPL(word, args...)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
@@ -494,4 +497,6 @@ static inline void stn_p(void *ptr, int sz, uint64_t v)=
<br>
<br>
=C2=A0#undef STORE_IMPL<br>
<br>
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */<br>
+<br>
=C2=A0#endif /* BSWAP_H */<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div></div>

--000000000000845e0b0646eb2f0c--


