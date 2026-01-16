Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253C0D4A5F6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgarz-0000uc-UJ; Thu, 15 Jan 2026 22:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vgarx-0000pd-HC
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:51:29 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vgarv-0005xt-IE
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:51:29 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-29f30233d8aso11105425ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1768535485; x=1769140285;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VD9vI+H8h2Y/AZLPWdtSH7aUriuk4uFXlIP0xDC18ro=;
 b=SF9uHA+6gT1K05lAw791DupAxgAFbRtlcwZOB8+ER/UEYjE9+6/9vu7sC9xeQvo0AV
 E6TB562NX12TpOq4FJggovE0fy6QWRnThxMNXASrk7q7IbeXeTJcg+pOeWxDx0wWHEC3
 m64m9UTczElhec2JvqTjXk+TTkKJ8wR3S1iXLLL892N/EAj0nAOWSrqSKFYyVUXKKQdc
 palun4VTB5mLD5Y12Gvqhzi25D33QjALxRe0l9ReQEtS4qB9D9felEbVifa4CR5lEFez
 qPlP2rKrI4RV0bd894CeK59l9RvGbyQWxla3Ua847yd18YeEhjlI3PFFD0fOvdJUymX5
 48hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768535485; x=1769140285;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VD9vI+H8h2Y/AZLPWdtSH7aUriuk4uFXlIP0xDC18ro=;
 b=BvsT+pTskuNs2bxaaZCEtewL58jdw2OThk8/dyRDs70/mwVBJv5BMLywkrBRufSj3K
 dQZEjHhq3Aw5Mm2NL0qHm2EKCLAZQ5Y4IqwVOEefTINn9H4upXApCEt4utSnA5Qhg7HC
 cM4/jVCMITYRKrYeETCdXqlnpxzKFWzzz1ViQbBTtjCEFNSCg6NNH98YiBml0ufEcei0
 ZudkWy7N9nyka8ZxnC1Kff3uh114LKnfYMqMMSlISzWKJivFHzmLrphEaheLqe9rxAhu
 OAhNyzSmMJTjNf3EiNJKT/nMNWrP7eGiRIF7AeraW5wUK2n5LJOTT3vPg+6Z/wcXp3Qj
 nF6A==
X-Gm-Message-State: AOJu0YxVzXv/Afpz6yokEuT86I2G3Ec6vsRJP0mf4+ksG7PF9j4agVZC
 j5dYx3t43ddOFW08Mxw3picij0u4+2duTPC72zw6jhYc/xgMxmQFkpUvPsD2tXyRz93OnUaP3P4
 97h9+XYxuEmoE/h6EQRvnbTLC899sHJakKLCiKPC8vnVfYOG/kFfn
X-Gm-Gg: AY/fxX4bYNuKw8lWoaMqkpNPluqNayLwK6PYQr95RMSk3dOWPT1nkZE7MuyCX4n7ZsK
 Z5cMfVU02HvIkcVvglkeoOkr2XFr5UkhAymE9WrU5XeQcb15FdBC0EV0Vxlyrx6WAAMOTgsJSUB
 bsuxqBRRLwlverJrGarV7Tf0uU9JGGdwXdLfqMBvTVJ7U8CnCimlNkWEAJ7c8K4PWgx3lIvFz9m
 Zh8WVLcW3n2aLSHegn+AViY99Vz1nvaSwTRbzrkz1ek/MwOk5LzIjnB3QNs0AN7lN/L7SkgARPE
 wUShCOlLMWnMYu7WXgzzNfMOqA==
X-Received: by 2002:a17:903:2f8a:b0:2a1:3cd9:a73a with SMTP id
 d9443c01a7336-2a7189482fbmr13106205ad.40.1768535485414; Thu, 15 Jan 2026
 19:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20260116033305.51162-1-richard.henderson@linaro.org>
 <20260116033305.51162-12-richard.henderson@linaro.org>
In-Reply-To: <20260116033305.51162-12-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 15 Jan 2026 20:51:14 -0700
X-Gm-Features: AZwV_QhOGQFdx2JqjGSCwgtNxXE7v2QyPY2RpuTb6HKjZlIv4F81BEgG5w_1Z14
Message-ID: <CANCZdfoX4g=K4Z7cCeuyRzAnrQBhmzLoLxckhPqp15J0L74ufg@mail.gmail.com>
Subject: Re: [PATCH v2 11/58] bsd-user: Fix __i386__ test for
 TARGET_HAS_STAT_TIME_T_EXT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, ktokunaga.mail@gmail.com, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000618e2a06487941ba"
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000618e2a06487941ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026, 8:34=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> The target test is TARGET_I386, not __i386__.
>
> Cc: Warner Losh <imp@bsdimp.com>
> Cc: Kyle Evans <kevans@freebsd.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/syscall_defs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
> index 52f84d5dd1..c49be32bdc 100644
> --- a/bsd-user/syscall_defs.h
> +++ b/bsd-user/syscall_defs.h
> @@ -247,7 +247,7 @@ struct target_freebsd11_stat {
>      unsigned int:(8 / 2) * (16 - (int)sizeof(struct
> target_freebsd_timespec));
>  } __packed;
>
> -#if defined(__i386__)
> +#if defined(TARGET_I386)
>  #define TARGET_HAS_STAT_TIME_T_EXT       1
>  #endif
>
> --
> 2.43.0
>
>

--000000000000618e2a06487941ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 15, 2026, 8:34=E2=80=
=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
>richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">The target test is TARGET_I386, not __i386__.<br>
<br>
Cc: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank" rel=
=3D"noreferrer">imp@bsdimp.com</a>&gt;<br>
Cc: Kyle Evans &lt;<a href=3D"mailto:kevans@freebsd.org" target=3D"_blank" =
rel=3D"noreferrer">kevans@freebsd.org</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro=
.org" target=3D"_blank" rel=3D"noreferrer">pierrick.bouvier@linaro.org</a>&=
gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org=
</a>&gt;<br>
---<br>
=C2=A0bsd-user/syscall_defs.h | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-by: Warner Losh=
 &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div clas=
s=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h<br>
index 52f84d5dd1..c49be32bdc 100644<br>
--- a/bsd-user/syscall_defs.h<br>
+++ b/bsd-user/syscall_defs.h<br>
@@ -247,7 +247,7 @@ struct target_freebsd11_stat {<br>
=C2=A0 =C2=A0 =C2=A0unsigned int:(8 / 2) * (16 - (int)sizeof(struct target_=
freebsd_timespec));<br>
=C2=A0} __packed;<br>
<br>
-#if defined(__i386__)<br>
+#if defined(TARGET_I386)<br>
=C2=A0#define TARGET_HAS_STAT_TIME_T_EXT=C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
=C2=A0#endif<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div></div>

--000000000000618e2a06487941ba--

