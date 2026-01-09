Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0F2D26D7A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 17:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veGDR-0004iv-HU; Fri, 09 Jan 2026 12:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veGDM-0004ev-I7
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 12:23:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veGDK-0005xw-4I
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 12:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767979431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OY/Ypd6s7CfRZspbd8JoeSX1WqFttTQEESZ9i5D8+rM=;
 b=dMSPfLlAJ2NJmajLWJ1BKXHn5I6BpIkzZXS8JspDXoLb7f1fEuu7IEbs34vAsWIhDk02cA
 I2D7uRBHHUsegLkmtUs5YwGbMfKpiZo38Zezl5u4I2MlJ98avL3ndvitICx3TpNCGKD0M3
 LBCxlCmP0fVIkq3bbA0IoVEdO6RKWzc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-YoZRZWguNAu0JxSquuHOig-1; Fri, 09 Jan 2026 12:23:47 -0500
X-MC-Unique: YoZRZWguNAu0JxSquuHOig-1
X-Mimecast-MFC-AGG-ID: YoZRZWguNAu0JxSquuHOig_1767979426
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477a1e2b372so41714725e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 09:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767979426; x=1768584226; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OY/Ypd6s7CfRZspbd8JoeSX1WqFttTQEESZ9i5D8+rM=;
 b=leSRx3nyoH6F0kLMSQAXtmpaLz0QqJavV3ENAIfYRpgZvCDx4gopQKVza5vlxssY/q
 BHXQL2zW4HVaou+inAsXwM9MFIzkXrlFYxvRRgktR5wkPW+XW+LlQGTDKANiCYmV7je/
 fbuAycEqMkOzbaDUdUgSP2Bd/GHgmz3d6DQnalkl2AvsUaSNe2gV9Ru/NT/y319baPmv
 70eWJwMR/C4s9FcFUgoPjxipjfajL8fWDc5AzdXzxef976NVih2qMype1e0TPfE64Uwm
 4r0AwC8wQJI8n6sdaLBk9o6bRdoVmkS8izt/Fl51gtSHT3QUurVMy0eRSAj/h61aVnvB
 L9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767979426; x=1768584226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OY/Ypd6s7CfRZspbd8JoeSX1WqFttTQEESZ9i5D8+rM=;
 b=xCOZYvnOrWphnKx5pxg4hUOi6G0CAHwYm6t88gZ51lhUJPq2wlfK8DTn/RMUFhnGDY
 dDyfYZ+feP9ZJNssP/uY527F+ElJOSuL22rx4/wPX4ujVXYmr89KtLlCS5L3BqxeG908
 eayhMxVAvxOonKKttQz4Nmn0Gn6qfbGmUNDH4KhEwfwEenQQ0AqMN0EEb9qJ4Dwyua16
 1g+g9ZrFPy6OTgbcAOFBd006Ffjg5z00yGan4mQV1HGVlrCbXvRCzWCeciFhYXdn/Oui
 pPiTPBts+8qn75hoecsH9rxPjJLyaGPRGnPjdbQ7/GKRTjz7q7fQUe/81Sqmt/weElL9
 933w==
X-Gm-Message-State: AOJu0YxGWaqGSzkV3n84DU6o3CHYjF+yDn4lsCeqnu1G9pT8j/g0sfwv
 VEBQ9T21PW1pNSpYI+xUlXspa1B86DAKGVh9FPeaSiyuPC4Dn+xJnloAvVu63iZf2ZhrWTr+iUr
 57n8odfiy+NFawxnoTve+mpQvtbQrdyoU9tP6EBa0OkwPD8KHJesDlEkgw26fF13MjAlyRgCjv3
 witMx4NxHhfFg8A0WevZj2KrJoCywGom4=
X-Gm-Gg: AY/fxX4h3KGXIa4JFhaLFUd7DC2Zi6QVaIS03L9B9RChJ/kWkb8d4ZD/JIKSWHWq+ko
 RjoCosSSHx93+wKxmWVcvCrFZmnOjZnCgdYksx7JE/ntoxhRd1UTtAedoG5sGTBRsO8nYUa6kSo
 yz8gC7xYQHePyhSWvj5HjeAdlxaZ6TFH8tGaNZSolD09iMtS5kecAnVA4jPSSGk7oH8bOaHBDZg
 9HxTfcJ6CG+7Y5+t+zEbEv+92zxEXSA9fq8TnqM1M7Z2rko02B1UFopuFpeAkflE0pr9A==
X-Received: by 2002:a05:6000:2305:b0:431:a33:d872 with SMTP id
 ffacd0b85a97d-432c378a069mr11036636f8f.8.1767979426319; 
 Fri, 09 Jan 2026 09:23:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOhHzCpBxYS9TnVDb9dTiFvAB6ZyzUZVXoHTdxSLD3iOGMuFXNb7pJHdaYKzdYY6ZDLRcpbcZRr49O0raRSEI=
X-Received: by 2002:a05:6000:2305:b0:431:a33:d872 with SMTP id
 ffacd0b85a97d-432c378a069mr11036606f8f.8.1767979425838; Fri, 09 Jan 2026
 09:23:45 -0800 (PST)
MIME-Version: 1.0
References: <20260109165058.59144-1-philmd@linaro.org>
 <20260109165058.59144-3-philmd@linaro.org>
In-Reply-To: <20260109165058.59144-3-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Jan 2026 18:23:36 +0100
X-Gm-Features: AZwV_QhZrdvFHiFuQSOcmUQwIHiLcP1eaIILtf9WLN5S3Li28macyjjehYOxDdE
Message-ID: <CABgObfYYx4-BcN7gbpNNiZi8nQhqYh-fgJ4j=6udogBnpz_7UQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/22] util: Introduce ldm_p() and stm_p() load/store
 helpers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000a5cc570647f7c90d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000a5cc570647f7c90d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 9 gen 2026, 17:51 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> ha
scritto:

> Introduce load/store helpers which take a MemOp argument.
>
> Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
>

That's a new one. :)

I think they should be inline and so should be
address_space_{ld,st}m_internal (maybe even always_inline). The amount of
optimization enabled by constant MemOp is huge.

One other small change:

+    const unsigned size =3D memop_size(mop);
> +    uint64_t val;
>

This must be initialized to zero.

Otherwise the whole series looks great, thanks. Sorry again for delaying my
review.

Paolo

+    uint8_t *pval =3D (uint8_t *)&val;
> +
> +    if (HOST_BIG_ENDIAN) {
> +        pval +=3D sizeof(val) - size;
> +    }
> +
> +    __builtin_memcpy(pval, ptr, size);
> +    if (unlikely(mop & MO_BSWAP)) {
> +        switch (size) {
> +        case sizeof(uint16_t):
> +            val =3D __builtin_bswap16(val);
> +            break;
> +        case sizeof(uint32_t):
> +            val =3D __builtin_bswap32(val);
> +            break;
> +        case sizeof(uint64_t):
> +            val =3D __builtin_bswap64(val);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }
> +    return val;
> +}
> +
> +void stm_p(void *ptr, MemOp mop, uint64_t val)
> +{
> +    const unsigned size =3D memop_size(mop);
> +    const uint8_t *pval =3D (const uint8_t *)&val;
> +
> +    if (HOST_BIG_ENDIAN) {
> +        pval +=3D sizeof(val) - size;
> +    }
> +
> +    if (unlikely(mop & MO_BSWAP)) {
> +        switch (size) {
> +        case sizeof(uint16_t):
> +            val =3D __builtin_bswap16(val);
> +            break;
> +        case sizeof(uint32_t):
> +            val =3D __builtin_bswap32(val);
> +            break;
> +        case sizeof(uint64_t):
> +            val =3D __builtin_bswap64(val);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }
> +    __builtin_memcpy(ptr, pval, size);
> +}
> diff --git a/util/meson.build b/util/meson.build
> index 35029380a37..b695b6e4728 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -38,6 +38,7 @@ util_ss.add(files('envlist.c', 'path.c', 'module.c'))
>  util_ss.add(files('event.c'))
>  util_ss.add(files('host-utils.c'))
>  util_ss.add(files('bitmap.c', 'bitops.c'))
> +util_ss.add(files('ldst.c'))
>  util_ss.add(files('fifo8.c'))
>  util_ss.add(files('cacheflush.c'))
>  util_ss.add(files('error.c', 'error-report.c'))
> --
> 2.52.0
>
>

--000000000000a5cc570647f7c90d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 9 gen 2026, 17:51 Philipp=
e Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro=
.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Introduce load/store helpers which take a MemOp argument.<br>
<br>
Inspired-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">That&#39;s a new=
 one. :)</div><div dir=3D"auto"><br></div><div dir=3D"auto">I think they sh=
ould be inline and so should be address_space_{ld,st}m_internal (maybe even=
 always_inline). The amount of optimization enabled by constant MemOp is hu=
ge.</div><div dir=3D"auto"><br></div><div dir=3D"auto">One other small chan=
ge:</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">+=C2=A0 =C2=A0 const unsigned size =3D memop_size(mop);<br>
+=C2=A0 =C2=A0 uint64_t val;<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">This must be initialized to zero.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Otherwise the whole series looks grea=
t, thanks. Sorry again for delaying my review.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 uint8_t *pval =3D (uint8_t *)&amp;val;<br>
+<br>
+=C2=A0 =C2=A0 if (HOST_BIG_ENDIAN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pval +=3D sizeof(val) - size;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 __builtin_memcpy(pval, ptr, size);<br>
+=C2=A0 =C2=A0 if (unlikely(mop &amp; MO_BSWAP)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case sizeof(uint16_t):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D __builtin_bswap16(val);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case sizeof(uint32_t):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D __builtin_bswap32(val);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case sizeof(uint64_t):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D __builtin_bswap64(val);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return val;<br>
+}<br>
+<br>
+void stm_p(void *ptr, MemOp mop, uint64_t val)<br>
+{<br>
+=C2=A0 =C2=A0 const unsigned size =3D memop_size(mop);<br>
+=C2=A0 =C2=A0 const uint8_t *pval =3D (const uint8_t *)&amp;val;<br>
+<br>
+=C2=A0 =C2=A0 if (HOST_BIG_ENDIAN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pval +=3D sizeof(val) - size;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (unlikely(mop &amp; MO_BSWAP)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case sizeof(uint16_t):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D __builtin_bswap16(val);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case sizeof(uint32_t):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D __builtin_bswap32(val);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case sizeof(uint64_t):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D __builtin_bswap64(val);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 __builtin_memcpy(ptr, pval, size);<br>
+}<br>
diff --git a/util/meson.build b/util/meson.build<br>
index 35029380a37..b695b6e4728 100644<br>
--- a/util/meson.build<br>
+++ b/util/meson.build<br>
@@ -38,6 +38,7 @@ util_ss.add(files(&#39;envlist.c&#39;, &#39;path.c&#39;, =
&#39;module.c&#39;))<br>
=C2=A0util_ss.add(files(&#39;event.c&#39;))<br>
=C2=A0util_ss.add(files(&#39;host-utils.c&#39;))<br>
=C2=A0util_ss.add(files(&#39;bitmap.c&#39;, &#39;bitops.c&#39;))<br>
+util_ss.add(files(&#39;ldst.c&#39;))<br>
=C2=A0util_ss.add(files(&#39;fifo8.c&#39;))<br>
=C2=A0util_ss.add(files(&#39;cacheflush.c&#39;))<br>
=C2=A0util_ss.add(files(&#39;error.c&#39;, &#39;error-report.c&#39;))<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div></div>

--000000000000a5cc570647f7c90d--


