Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F34C531F9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 10:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnvwU-0004GB-N9; Sun, 26 Jul 2026 06:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wnvwQ-0004Ec-Bo
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 06:18:42 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wnvwM-00032l-R3
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 06:18:40 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-667923d86a7so2359325d50.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 03:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785061117; cv=none;
 d=google.com; s=arc-20260327;
 b=V+5aXlGZLTeJ8I4Orvn3wJeL29KlCGASHqMwrs0nZMAo0MxkJzxZryisAX5K4cuD2+
 3y3CLgoSw7TRtiNr51fQGPn2xHw9LL+a3lGSobjoe9A3chP5GxLuAl45zpg77Bj7itVi
 R5y14bZ8sisDyK675wZy9CbegjxfRY5ErWpQOLXaZIBeU5PPyM5PWGd2CuvQNZKScAbZ
 cmK7miJBscN7MBcN2Hgi8k9ndhxhX1RB8gXCv7z2mXn56UQ4bMsCajeNE1PWE2zaA6d3
 vvLkHYqZ965yztW+00hnlXpD8PofJ4FYHKu70AaSb+HD8PxhlPZnccsLEoqmv3M3IGRo
 gpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EBjlcfDfIu3z/AJpw8nsv9CjirNhmFFiLD6FknCXBqg=;
 fh=w8E0DUJP32rtZI6BueBvqUbEMj+LBV/APR6eSOdi2ww=;
 b=YBr+sZp7FmlwA6SfjXBkg021rjCjZ9oBjKnSKXnbFvNF2PY74NSsek+gMrsPpv1nl4
 WFX6bYRFlH3wFo9oIWCzFwPqGx0QW9fPNkejKCS5ENyVWdr37baSDqKnoPjySJqmCCvv
 I5K6VFOR3cjxaIxFc02aaWM/hEmvBi6HGH9VTRMlGcnJJreFLltQRMIUHDdVrpRCt0+Q
 sKei8AMh08CRWF9I3C+Xh/dTo74WCEqmX5Uf9f6kjA5lrpy/R0uQJubnUQo8U3Msq8CY
 N8Qt8UWfIWPWrCQlWqzJOY7XXnGRgiDoZplHNTQvEQPtvgwD0OI1OFFh1wCrMquQhePb
 2qdw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785061117; x=1785665917; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EBjlcfDfIu3z/AJpw8nsv9CjirNhmFFiLD6FknCXBqg=;
 b=HlqlalY5C23Ulo5QBDMstv1upkRpR2vOa3zHD7C5dJykjZnJ0Fm7wEj50ahCTRT8HX
 RgBP1kPqqdCOIu8CkrqQUu/QLreYUigp+uLaiQmQLV0dZvJurE+xkSuXy/cemErwxlhy
 oN/s+0NLlqAISZjCW1yHhZF3p5OwfYQLzRTKgUxRAWhVp8P5PcTCXb691kWA/Ldvd9E3
 uklGjuHxW7tZwUOemfB1i1hwl/TNKqvro1NIjnS1l74A6jj9vi/hcAiPtrQofBe9CGOl
 z/Ipx+tqOVhDc9exYlwSO3zo4aLUlgQVvVTcGnPChb5km4heE0lcYJEgiKZ+qu1J/frR
 n7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785061117; x=1785665917;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EBjlcfDfIu3z/AJpw8nsv9CjirNhmFFiLD6FknCXBqg=;
 b=PQwW+VTKkMYNId7zAHyHoXKcpgq10OIOLqOnm9uSXt/fu9Bc3CsPitgZ++z2kKSXJi
 BAu+mfDVjUDm7dQ0b2NuLDAB2fHQzO4wUnuTaUm9J9nsZnXACSFoT5GhmeaxN0RKJqQW
 cUlBIkePTfYDHG9pSf5lHzWLYoeTh4fFipYOBoXUeIZaZMmSgFwBHPIvWlCVN5TCM/WP
 IiNDckl7nuayCs5MJFzOV4MERLSHunOwa1OpOB58NGYspZC8QjlzTtgbjBWUn60Xhwl7
 3tJ4MADzt7J6wMl0NSqVoYGRsafiFBMS+04PALqRF4Jnm9tasAyXaAKZVCYRvRVjBY4R
 PyhA==
X-Gm-Message-State: AOJu0YzNaRpH9QfsSXK5Ya5Y3ZFkLMkpG898mgZ1E3FDj6GUi7FhtA+l
 7ylfAl8gO361JXWabPRZfOf8oZTUsPMcgYj1EEr4Qbk3dgF7O1Fa42+GjiVLdNl69RPeLt+3P4U
 VFtkb3D5dATHKjS8PGg75+13J6rh4IuuCfUh7
X-Gm-Gg: AR+sD13IhlQwgqNYki9Z2sjUnRGCBtSCoZAXLnSRpzsBqCCF5A8GiKDvakMMkU/7kME
 XdTTIFdpk4T1dH8iIvEuTGU7cW0S7EoJU056Q3QB1TefLi85qtyOAtgjf+s4c9mSExCMgCWQIfw
 ZF43wCpa/jAbxEtCjkq3KbP6A/H9CnO9hZWdHi1XVTCGSk4IMXoJEGol14GlQUpa9/NVzfzkUhX
 B1ZP0s51jNkxtSDOnZVIzFP9Mv/KDGM+CC51LEJ0TMyvUNLf3phjlEV/MufTG4=
X-Received: by 2002:a05:690e:c4f:b0:660:6e93:1958 with SMTP id
 956f58d0204a3-668c77a5de9mr1031044d50.0.1785061116962; Sun, 26 Jul 2026
 03:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260621130626.19073-1-randomjack94dev@gmail.com>
In-Reply-To: <20260621130626.19073-1-randomjack94dev@gmail.com>
From: Evgeny <randomjack94dev@gmail.com>
Date: Sun, 26 Jul 2026 13:18:25 +0300
X-Gm-Features: AUfX_mxV2vda-b72waRc3wykuOXWTVQJv31SzDsbGRv951ImIx3_0Y6U-iaIKbg
Message-ID: <CAFvcSaTjtztrJvc72e8i3gaGcfhkBVEVURJZxvSsHtpuA987kw@mail.gmail.com>
Subject: Re: [PATCH] util/oslib-win32: Implement qemu_get_pid_name()
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de
Content-Type: multipart/alternative; boundary="000000000000c76cb8065780edb4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=randomjack94dev@gmail.com; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000c76cb8065780edb4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

https://patchew.org/QEMU/20260621130626.19073-1-randomjack94dev@gmail.com/
https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg05258.html

On Sun, Jun 21, 2026 at 4:08=E2=80=AFPM Evgeny Kolmakov <randomjack94dev@gm=
ail.com>
wrote:

> Replace the abort() stub with a proper implementation using
> QueryFullProcessImageNameW() and g_utf16_to_utf8() to retrieve
> the process executable name on Windows. Returns NULL on error
> to match POSIX behavior.
>
> Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
> ---
>  util/oslib-win32.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 5f3e8f4d98..2b083b5d7a 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -287,8 +287,23 @@ bool qemu_finish_async_prealloc_mem(Error **errp)
>
>  char *qemu_get_pid_name(pid_t pid)
>  {
> -    /* XXX Implement me */
> -    abort();
> +    HANDLE hProcess;
> +    WCHAR path[4096];
> +    DWORD size =3D G_N_ELEMENTS(path);
> +    char *name =3D NULL;
> +
> +    hProcess =3D OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, FALSE,
> (DWORD)pid);
> +    if (!hProcess) {
> +        return NULL;
> +    }
> +
> +    if (QueryFullProcessImageNameW(hProcess, 0, path, &size)) {
> +        const WCHAR *base =3D wcsrchr(path, L'\\');
> +        name =3D g_utf16_to_utf8(base ? base + 1 : path, -1, NULL, NULL,
> NULL);
> +    }
> +
> +    CloseHandle(hProcess);
> +    return name;
>  }
>
>
> --
> 2.43.0
>
>

--000000000000c76cb8065780edb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ping<br><br><a href=3D"https://patchew.org/QEMU/2026062113=
0626.19073-1-randomjack94dev@gmail.com/">https://patchew.org/QEMU/202606211=
30626.19073-1-randomjack94dev@gmail.com/</a><br><a href=3D"https://lists.gn=
u.org/archive/html/qemu-devel/2026-06/msg05258.html">https://lists.gnu.org/=
archive/html/qemu-devel/2026-06/msg05258.html</a></div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On S=
un, Jun 21, 2026 at 4:08=E2=80=AFPM Evgeny Kolmakov &lt;<a href=3D"mailto:r=
andomjack94dev@gmail.com">randomjack94dev@gmail.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">Replace the abort() stub=
 with a proper implementation using<br>
QueryFullProcessImageNameW() and g_utf16_to_utf8() to retrieve<br>
the process executable name on Windows. Returns NULL on error<br>
to match POSIX behavior.<br>
<br>
Signed-off-by: Evgeny Kolmakov &lt;<a href=3D"mailto:randomjack94dev@gmail.=
com" target=3D"_blank">randomjack94dev@gmail.com</a>&gt;<br>
---<br>
=C2=A0util/oslib-win32.c | 19 +++++++++++++++++--<br>
=C2=A01 file changed, 17 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/util/oslib-win32.c b/util/oslib-win32.c<br>
index 5f3e8f4d98..2b083b5d7a 100644<br>
--- a/util/oslib-win32.c<br>
+++ b/util/oslib-win32.c<br>
@@ -287,8 +287,23 @@ bool qemu_finish_async_prealloc_mem(Error **errp)<br>
<br>
=C2=A0char *qemu_get_pid_name(pid_t pid)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 /* XXX Implement me */<br>
-=C2=A0 =C2=A0 abort();<br>
+=C2=A0 =C2=A0 HANDLE hProcess;<br>
+=C2=A0 =C2=A0 WCHAR path[4096];<br>
+=C2=A0 =C2=A0 DWORD size =3D G_N_ELEMENTS(path);<br>
+=C2=A0 =C2=A0 char *name =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 hProcess =3D OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, =
FALSE, (DWORD)pid);<br>
+=C2=A0 =C2=A0 if (!hProcess) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (QueryFullProcessImageNameW(hProcess, 0, path, &amp;size)=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const WCHAR *base =3D wcsrchr(path, L&#39;\\&#=
39;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D g_utf16_to_utf8(base ? base + 1 : pat=
h, -1, NULL, NULL, NULL);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 CloseHandle(hProcess);<br>
+=C2=A0 =C2=A0 return name;<br>
=C2=A0}<br>
<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000c76cb8065780edb4--

