Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC30D29C33
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 15:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqqw-0000T1-Ua; Mon, 19 Jan 2026 10:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vhqqS-0000Bw-FX
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 10:07:09 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vhqqQ-0003pz-9I
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 10:07:08 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-34c718c5481so2080833a91.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 07:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1768835224; x=1769440024;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=diPHIL1dxCFpL24zXsr3hGAMHV/7C+G0fHwFWdjWEnM=;
 b=2taQYqGjQuHMJAm3LCVcpx1XReXEfPENGkIjUMhERE4giZenA5NOzzAi5aHK6zAB3/
 f2edwNuVhFJPOzEHneqb7C9XPkiE2vd/k72vHBMLce3bP2X7HcHta2txp+r4teO0WV9M
 lBo8BSb2VXLqM+ogWHv1WDwMtlsj7R8IkC7KgGYlSOk1A+oSaJM8OrQW2HQbsjZ2bNTo
 8UjU0blGfdBYcqf2HIfdbKf5oJgwLZkoWaB95Frr2kjEht3sJgvFc2HHND7We++9xGIE
 du0nMqwN3mQy2TJWVDVO/CvkVo6M4G2Lmbas7ot4+jaN+TQHJ5cPCu47eN8lwcf2MwTb
 Sekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768835224; x=1769440024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diPHIL1dxCFpL24zXsr3hGAMHV/7C+G0fHwFWdjWEnM=;
 b=mYg8nCH2TDKsWHovioIJPbi03HZX1tcn6OlobPJjiPJsfUUiuo1KZ9qmAJSl4MO6VU
 Rme1MVBEJmgxEVbLGeG7rjYm0r7Lp2eh1/v9o3SQEMZjI4L0KVTJVxnXwP8AsC7aFAbs
 tqVqUImDFWUXO0QJuOjiNOJKtM58rCXRThyx7nkc8Nml3BTh4+jfBnQcZw7WjDFvasD+
 PsAFdnGiwP+I77E1J0cP50q54RxXKCcPIDMILnLx2t6nxEnPQ2a7h7g34dVguyNxJVjr
 UZM+GO2lpp4YvUWoVgFHwJ5kmCGoUIAXUQc96OS8+RHDyvD6Hyw+p5FdQzryGlcKEX7F
 CVOw==
X-Gm-Message-State: AOJu0YxQ6Ujjfq9Ved6z/Y0TpWQnlo2RfQMFhPrkfBJSsIgZX5Dh1xEt
 Jce0kugHIHgc4sysF/rdbqnsXYWYvv3snepgWvbF7wH5rlC3TbGziyw1JNpqx/aeVywF5GRgdfk
 hX5QmKZS/0MCVd+Lq9tWG4HiZPiDvKBS4dc7x/DLOGQ==
X-Gm-Gg: AZuq6aL2eHXuMQRQ/gR+EoSNNha5+M0/vOqAv39hvP/+fFjFOdhB47nhxUeEmQqm7NH
 NeIfF93Ildd+Nxt6OHOHJQ52M0R8+/OAf4cDMib6usKfRWAqAfmRUI0lcXhejgH/vcrzUrYb7YY
 C33VfsZe2JC4ghyseyHxd9NR6B89MheCBIrCLUxWe3cvYfkcUyQ/qxtHkxtgYAfleOcBD39X6LP
 nto/h41SdvjAkL3GxzHRIFHC8Z2zyDliwr5RxaoL/7TlMNsEGKO3YJEU8nMYgKjOOU6FlUhVdCa
 72eM6A==
X-Received: by 2002:a17:90b:58cf:b0:349:162d:ae1e with SMTP id
 98e67ed59e1d1-3527327df4fmr10218891a91.33.1768835224060; Mon, 19 Jan 2026
 07:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20260119075738.712207-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260119075738.712207-1-pierrick.bouvier@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 19 Jan 2026 08:06:52 -0700
X-Gm-Features: AZwV_QiRqqWDWXaX6xy2P4eFqD74sLKh9WBqwOSMQu42famt7IpJltH4oT-Mf1E
Message-ID: <CANCZdfqJr7yEv=GhV=D9hBqqYeiWnNGA=xybpX6TUn50jiUn9g@mail.gmail.com>
Subject: Re: [PATCH] bsd-user/syscall_defs.h: define STAT_TIME_T_EXT only for
 32 bits
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, richard.henderson@linaro.org, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000032545f0648bf0b79"
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1029.google.com
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

--00000000000032545f0648bf0b79
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 12:57=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@linaro.org> wrote:

> Commit 369c1ba2b changed the wrong conditional "#if defined(__i386__)" to
> "#if defined(TARGET_I386)".
> However, TARGET_I386 is defined for target x86_64 also.
>

Oh I always forget about that...


> This commit fixes it by identifying correctly 32 bits target.
>
> Found with:
> $ ./build/qemu-x86_64 \
>   -plugin ./build/contrib/plugins/libstoptrigger,icount=3D1000000 \
>   -plugin ./build/tests/tcg/plugins/libinsn \
>   -d plugin \
>   ./build/qemu-system-x86_64 --version
> ld-elf.so.1: /lib/libz.so.6: invalid file format
> cpu 0 insns: 59746
> total insns: 59746
>
> Fixes: 369c1ba2b ("Fix __i386__ test for TARGET_HAS_STAT_TIME_T_EXT")
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  bsd-user/syscall_defs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
> index c49be32bdc0..cc4b484f3ab 100644
> --- a/bsd-user/syscall_defs.h
> +++ b/bsd-user/syscall_defs.h
> @@ -247,7 +247,7 @@ struct target_freebsd11_stat {
>      unsigned int:(8 / 2) * (16 - (int)sizeof(struct
> target_freebsd_timespec));
>  } __packed;
>
> -#if defined(TARGET_I386)
> +#if defined(TARGET_I386) && !defined(TARGET_X86_64)
>  #define TARGET_HAS_STAT_TIME_T_EXT       1
>  #endif
>
> --
> 2.47.3
>
>

--00000000000032545f0648bf0b79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 19,=
 2026 at 12:57=E2=80=AFAM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.b=
ouvier@linaro.org">pierrick.bouvier@linaro.org</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Commit 369c1ba2b changed the =
wrong conditional &quot;#if defined(__i386__)&quot; to<br>
&quot;#if defined(TARGET_I386)&quot;.<br>
However, TARGET_I386 is defined for target x86_64 also.<br></blockquote><di=
v><br></div><div>Oh I always forget about that...</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
This commit fixes it by identifying correctly 32 bits target.<br>
<br>
Found with:<br>
$ ./build/qemu-x86_64 \<br>
=C2=A0 -plugin ./build/contrib/plugins/libstoptrigger,icount=3D1000000 \<br=
>
=C2=A0 -plugin ./build/tests/tcg/plugins/libinsn \<br>
=C2=A0 -d plugin \<br>
=C2=A0 ./build/qemu-system-x86_64 --version<br>
ld-elf.so.1: /lib/libz.so.6: invalid file format<br>
cpu 0 insns: 59746<br>
total insns: 59746<br>
<br>
Fixes: 369c1ba2b (&quot;Fix __i386__ test for TARGET_HAS_STAT_TIME_T_EXT&qu=
ot;)<br>
Signed-off-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@lina=
ro.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/syscall_defs.h | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br></blockquote><div><b=
r></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com"=
>imp@bsdimp.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h<br>
index c49be32bdc0..cc4b484f3ab 100644<br>
--- a/bsd-user/syscall_defs.h<br>
+++ b/bsd-user/syscall_defs.h<br>
@@ -247,7 +247,7 @@ struct target_freebsd11_stat {<br>
=C2=A0 =C2=A0 =C2=A0unsigned int:(8 / 2) * (16 - (int)sizeof(struct target_=
freebsd_timespec));<br>
=C2=A0} __packed;<br>
<br>
-#if defined(TARGET_I386)<br>
+#if defined(TARGET_I386) &amp;&amp; !defined(TARGET_X86_64)<br>
=C2=A0#define TARGET_HAS_STAT_TIME_T_EXT=C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
=C2=A0#endif<br>
<br>
-- <br>
2.47.3<br>
<br>
</blockquote></div></div>

--00000000000032545f0648bf0b79--

