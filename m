Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18259FD9E0C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 19:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvhIp-00070E-Eh; Thu, 26 Feb 2026 14:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vvhIm-000702-Uw
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 14:45:37 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vvhIk-0003qe-Bn
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 14:45:36 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c636487ccaeso421626a12.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 11:45:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772135131; cv=none;
 d=google.com; s=arc-20240605;
 b=LnfFfuhTDTkucoE8916HgWwQs6Dr5c2ciFPDvZQradVRMIff6ewDvZqDqBRgHN7Xky
 F0xqYQMWiQYWVeKIz34AKYp5VMTg+Z3ObN65Vn9tGvFDc9hrG/NW73LWdtcwwJ5ZbvH3
 L1YvvYMdz6+yIXwFnmiYNI3lqNKCH08WdvJcJmN+WPsOt30VqxSo9s2QQZuExhDaZDu4
 X9UQgZ0sCEbVfwWp2GPOk9Q73gsemq9MY4CLERpDwiCqhWvvKWWamRQAEHsfiSyv4GBB
 sC0SdrcANHvkRxZyx7A7QH3eBR1nCjYk0EeeO9LOuqbRemf5bTadAgdHjO31Yd8cbrgi
 61Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3MQIk7HJyyz3wWjaMqvQ9eOFY56Kc3QpLksJJV+ebAE=;
 fh=cq819jh9oSL24vqifi6AV/7dkQiP3bwHkRxDhxh4wwo=;
 b=EIfNXwgLiZepDsFlv85Asutsu6Qj7KN0A8lkkGZe/+11BWh8oI3T3CxtM3G1G/uhr2
 ERwC70eKm+Tmblpdkxp+SbaU/wAv2avQmOHXIWbaQsx5czIBCcxRssv1fTOHVqcXaHEo
 g6pvIjyf9JjwvN2EBJ4pIe+H7uiXMK/S4B0e3oiUArTRGeSDg/Xm0enxoeEzT4AMh/F2
 8k9md+r/B/UtZKbM/DOB5CBmCpOVAS4G29VdfzJv3DygYSZPXy7K56Fe8ulnltn2Tynv
 RyfbfuSe+UjiuA4x2F9vl9agjCbMaF4M0zQe/eaupvS42zkrjxIjaxUWRP72uyN+Tgkq
 1umQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772135131; x=1772739931;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3MQIk7HJyyz3wWjaMqvQ9eOFY56Kc3QpLksJJV+ebAE=;
 b=2tDvPZnkt7Rw/b/NcHaSzOiA5sBwKanRa48tImbCxkbkPotzUAssZxKhhchzzU79B5
 lSFTzXSNi8EZOEl+pZ9Q3AKATe9N3EnW+Q3l/T8DEQBF20SnRw9VsYEQIDfCtQQ6MQr/
 bOI3Epr5F9JpfMMDD7TfB2F8KjYoEGve6am42A5NhIqYWejoIr+9Deq+OesVMkopuz2h
 HGGgolkdsrc4Isep1vZo5oNLktXkZA/azmIjldkyUIJAS5ELmddc+IOWn+17mXw0UITU
 QCLO6rWDRjibquBeL1r48WnJuFlhMf4s5F8WMwY3s4QRQj+x+Ve3pppIXup/HqF8tnkf
 Aqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772135131; x=1772739931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MQIk7HJyyz3wWjaMqvQ9eOFY56Kc3QpLksJJV+ebAE=;
 b=X/eQUjjRiyR+q1fc+olh53Ee8cI9O+Tu7vHQ9mxQkA8NjiVvGkWVXcj6ccFZpMRnby
 k5BVnWiaZKcaBSfFAlfhaUk/o9ZAkZtpAjx85oLZBtFVGkNMPK+ukcbFCkdaTfnQobxA
 E0vsWDZcKaTgZAi14UUvwka1Bxh0KehMqWC1Ng28lIoji++do9JJCiDqXp7pfe+C9eOA
 hyB8BOSr2MOlulDBwkHjQjTsvyqJ+o9fXiOF1NfWHGMeCqgUstE4EuahLIRZ7y1PIE+F
 pPBPgGr1snNtCfgwHBhgkyrn/CriUqYirPv8eRJqLEjp9CONmj37/mEljR5xUWbuGj76
 Ga1g==
X-Gm-Message-State: AOJu0YxTChcZTyfSvoX5AN9Ni7yevYdZWHuyxkJOQFHLMym+VYC+PtxH
 nHrTJykT9wgYAbIgancfPJozEGo7rGyJ+HoNlWFXf1MbQfxL5HnXjn79Tfs8fpQUZa4kNhCIwrI
 sqgzs9JOWFwvCoZg9dx8woraWaE6pvJtNYEkOWuiIlPNITNeF1SjZiG4=
X-Gm-Gg: ATEYQzzllESJBWEDnZmSkjwe4KyQuhxvepeDEJmeVFJjJRi3yxII4xz/Fda0faAd056
 /uH30n0/Xe53M5lEpdE5TkckGHuU5l5tB64b+07eitAuF1dnSi5DY7Le7bqVEsnl0DW03dTFVUX
 sIFiZ0eXqidD+cKS92fW8UKBf8O+08nGYbq3Z305uW+qseb6fRwaZ0qID9RI+91DvfJ1gRTOfWi
 eBexXcQULBLRX4vfV7yJcXMMcVyJoT1fypbtNa80MU322clIzrHlWNKb2lRTDTsDQxoxoJo6pQf
 WWWT5GU=
X-Received: by 2002:a17:90a:fc4d:b0:359:3088:6ab1 with SMTP id
 98e67ed59e1d1-35965c24299mr247441a91.1.1772135131247; Thu, 26 Feb 2026
 11:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
 <20260224-bsd-user-claude-v4-18-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-18-8ee5ae17056f@bsdimp.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 26 Feb 2026 12:45:19 -0700
X-Gm-Features: AaiRm51LW8AzwQqOwEQ8ldIK796NMcs9xPLS20N8Yrg3vu7Nox-nJhPb2DgVv-g
Message-ID: <CANCZdfoN2fYH4pgN-fNPh-QWG8sSRa7-427iy4i8=8_3vvWk3Q@mail.gmail.com>
Subject: Re: [PATCH v4 18/24] bsd-user: Add do_bsd___semctl implementation
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fe0647064bbf5c56"
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x535.google.com
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

--000000000000fe0647064bbf5c56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

PING?

I'm planning on sending a pull request with this in it Monday March 2nd
unless anybody objects.

Thanks!

On Tue, Feb 24, 2026 at 7:41=E2=80=AFAM Warner Losh <imp@bsdimp.com> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Add implementation of __semctl(2) syscall for System V semaphore control
> operations. Handles command translation, endianness conversion for GETVAL=
/
> SETVAL, and array/structure conversions for GETALL/SETALL/IPC_STAT/IPC_SE=
T.
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/bsd-misc.h | 111
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
>
> diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> index e1e552b58f..72b3db0b74 100644
> --- a/bsd-user/bsd-misc.h
> +++ b/bsd-user/bsd-misc.h
> @@ -99,6 +99,117 @@ static inline abi_long do_bsd_semop(int semid,
> abi_long ptr, unsigned nsops)
>      return semop(semid, sops, nsops);
>  }
>
> +/* __semctl(2) */
> +static inline abi_long do_bsd___semctl(int semid, int semnum, int
> target_cmd,
> +                                       abi_ptr un_ptr)
> +{
> +    void *target_un;
> +    union semun arg;
> +    struct semid_ds dsarg;
> +    unsigned short *array =3D NULL;
> +    int host_cmd;
> +    abi_long ret =3D 0;
> +    abi_long err;
> +    abi_ulong target_array, target_buffer;
> +
> +    switch (target_cmd) {
> +    case TARGET_GETVAL:
> +        host_cmd =3D GETVAL;
> +        break;
> +
> +    case TARGET_SETVAL:
> +        host_cmd =3D SETVAL;
> +        break;
> +
> +    case TARGET_GETALL:
> +        host_cmd =3D GETALL;
> +        break;
> +
> +    case TARGET_SETALL:
> +        host_cmd =3D SETALL;
> +        break;
> +
> +    case TARGET_IPC_STAT:
> +        host_cmd =3D IPC_STAT;
> +        break;
> +
> +    case TARGET_IPC_SET:
> +        host_cmd =3D IPC_SET;
> +        break;
> +
> +    case TARGET_IPC_RMID:
> +        host_cmd =3D IPC_RMID;
> +        break;
> +
> +    case TARGET_GETPID:
> +        host_cmd =3D GETPID;
> +        break;
> +
> +    case TARGET_GETNCNT:
> +        host_cmd =3D GETNCNT;
> +        break;
> +
> +    case TARGET_GETZCNT:
> +        host_cmd =3D GETZCNT;
> +        break;
> +
> +    default:
> +        return -TARGET_EINVAL;
> +    }
> +
> +    /*
> +     * Unlike Linux and the semctl system call, we take a pointer
> +     * to the union arg here.
> +     */
> +    target_un =3D lock_user(VERIFY_READ, un_ptr, sizeof(union
> target_semun), 1);
> +
> +    switch (host_cmd) {
> +    case GETVAL:
> +    case SETVAL:
> +        __get_user(arg.val, (abi_int *)target_un);
> +        ret =3D get_errno(semctl(semid, semnum, host_cmd, arg));
> +        break;
> +
> +    case GETALL:
> +    case SETALL:
> +        __get_user(target_array, (abi_ulong *)target_un);
> +        err =3D target_to_host_semarray(semid, &array, target_array);
> +        if (is_error(err)) {
> +            goto out;
> +        }
> +        arg.array =3D array;
> +        ret =3D get_errno(semctl(semid, semnum, host_cmd, arg));
> +        err =3D host_to_target_semarray(semid, target_array, &array);
> +        break;
> +
> +    case IPC_STAT:
> +    case IPC_SET:
> +        __get_user(target_buffer, (abi_ulong *)target_un);
> +        err =3D target_to_host_semid_ds(&dsarg, target_buffer);
> +        if (is_error(err)) {
> +            goto out;
> +        }
> +        arg.buf =3D &dsarg;
> +        ret =3D get_errno(semctl(semid, semnum, host_cmd, arg));
> +        err =3D host_to_target_semid_ds(target_buffer, &dsarg);
> +        break;
> +
> +    case IPC_RMID:
> +    case GETPID:
> +    case GETNCNT:
> +    case GETZCNT:
> +        ret =3D get_errno(semctl(semid, semnum, host_cmd, NULL));
> +        break;
> +
> +    default:
> +        ret =3D -TARGET_EINVAL;
> +        break;
> +    }
> +out:
> +    unlock_user(target_un, un_ptr, 1);
> +    return ret;
> +}
> +
>  /* getdtablesize(2) */
>  static inline abi_long do_bsd_getdtablesize(void)
>  {
>
> --
> 2.52.0
>
>

--000000000000fe0647064bbf5c56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">PING?<div><br></div><div>I&#39;m planning on sending a pul=
l request with this in it Monday March 2nd unless anybody objects.</div><di=
v><br></div><div>Thanks!</div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 24, 2026 at=
 7:41=E2=80=AFAM Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdi=
mp.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Add implementation of __semctl(2) syscall for System V semaphore control<br=
>
operations. Handles command translation, endianness conversion for GETVAL/<=
br>
SETVAL, and array/structure conversions for GETALL/SETALL/IPC_STAT/IPC_SET.=
<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Cc: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro.org" tar=
get=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br>
Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"=
_blank">imp@bsdimp.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-misc.h | 111 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++<br>
=C2=A01 file changed, 111 insertions(+)<br>
<br>
diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h<br>
index e1e552b58f..72b3db0b74 100644<br>
--- a/bsd-user/bsd-misc.h<br>
+++ b/bsd-user/bsd-misc.h<br>
@@ -99,6 +99,117 @@ static inline abi_long do_bsd_semop(int semid, abi_long=
 ptr, unsigned nsops)<br>
=C2=A0 =C2=A0 =C2=A0return semop(semid, sops, nsops);<br>
=C2=A0}<br>
<br>
+/* __semctl(2) */<br>
+static inline abi_long do_bsd___semctl(int semid, int semnum, int target_c=
md,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_ptr u=
n_ptr)<br>
+{<br>
+=C2=A0 =C2=A0 void *target_un;<br>
+=C2=A0 =C2=A0 union semun arg;<br>
+=C2=A0 =C2=A0 struct semid_ds dsarg;<br>
+=C2=A0 =C2=A0 unsigned short *array =3D NULL;<br>
+=C2=A0 =C2=A0 int host_cmd;<br>
+=C2=A0 =C2=A0 abi_long ret =3D 0;<br>
+=C2=A0 =C2=A0 abi_long err;<br>
+=C2=A0 =C2=A0 abi_ulong target_array, target_buffer;<br>
+<br>
+=C2=A0 =C2=A0 switch (target_cmd) {<br>
+=C2=A0 =C2=A0 case TARGET_GETVAL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_SETVAL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D SETVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_GETALL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETALL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_SETALL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D SETALL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_IPC_STAT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D IPC_STAT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_IPC_SET:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D IPC_SET;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_IPC_RMID:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D IPC_RMID;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_GETPID:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETPID;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_GETNCNT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETNCNT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_GETZCNT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETZCNT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EINVAL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Unlike Linux and the semctl system call, we take a p=
ointer<br>
+=C2=A0 =C2=A0 =C2=A0* to the union arg here.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 target_un =3D lock_user(VERIFY_READ, un_ptr, sizeof(union ta=
rget_semun), 1);<br>
+<br>
+=C2=A0 =C2=A0 switch (host_cmd) {<br>
+=C2=A0 =C2=A0 case GETVAL:<br>
+=C2=A0 =C2=A0 case SETVAL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(arg.val, (abi_int *)target_un);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(semctl(semid, semnum, host_c=
md, arg));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case GETALL:<br>
+=C2=A0 =C2=A0 case SETALL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(target_array, (abi_ulong *)target_u=
n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D target_to_host_semarray(semid, &amp;ar=
ray, target_array);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 arg.array =3D array;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(semctl(semid, semnum, host_c=
md, arg));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D host_to_target_semarray(semid, target_=
array, &amp;array);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case IPC_STAT:<br>
+=C2=A0 =C2=A0 case IPC_SET:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(target_buffer, (abi_ulong *)target_=
un);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D target_to_host_semid_ds(&amp;dsarg, ta=
rget_buffer);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 arg.buf =3D &amp;dsarg;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(semctl(semid, semnum, host_c=
md, arg));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D host_to_target_semid_ds(target_buffer,=
 &amp;dsarg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case IPC_RMID:<br>
+=C2=A0 =C2=A0 case GETPID:<br>
+=C2=A0 =C2=A0 case GETNCNT:<br>
+=C2=A0 =C2=A0 case GETZCNT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(semctl(semid, semnum, host_c=
md, NULL));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+out:<br>
+=C2=A0 =C2=A0 unlock_user(target_un, un_ptr, 1);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
=C2=A0/* getdtablesize(2) */<br>
=C2=A0static inline abi_long do_bsd_getdtablesize(void)<br>
=C2=A0{<br>
<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div>

--000000000000fe0647064bbf5c56--

