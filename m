Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3965FFD9E19
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjcg-00083C-Vq; Thu, 26 Feb 2026 17:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vvjcf-00082y-SP
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:14:17 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vvjcd-0003UJ-4I
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:14:17 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c636487ccaeso460399a12.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:14:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772144052; cv=none;
 d=google.com; s=arc-20240605;
 b=a+MqN4xtdbhMVQ1w0k1wPd618MXzSH/H0MLaijq2dQUdU6VJIhpfXYoqX8ABgSFBzD
 ZPKimZQAbIFQ0edbmwpwZgLf5LZQcfEz+ikK+WqsUpSeFYjsbz2+B6yiE57ONUx8rz2e
 k6BNjvjuVIYiIdT8Iy2foDJLJJEPxwOyIA6g0rM7YPZl+C0tGdaUYsRUBLcGPQ5KF3GD
 6b1arBfbx/aYW+2+WmElmkTnxsaYaVBYsAq1TFHccrA+6071XPnxnZvgZLhbGxw/UVYw
 2huFdt0BR4qfsKu3zzQhv1YvKWp8Nel2PjorTliXs+S34URwxnHsnsWUKBH5LuaeSO4B
 FH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kwXkN4CQqyUcBSNtyDI2ylAWfliivb/jsiYcZsARlgw=;
 fh=kWGEXuCKDBxGDPzzadhEfRJt01GUdYxxxqyqKtCtcZY=;
 b=Ecs119XscQNCxk9cSNUrN+AZR5XzBO6FqGH+MfTkvlghqj0VEfp7zs7fSrVE/K0T8X
 j0mNYU7zwgsCPflYYhUMfArCXsMOtEyOJ/b2rHBmOC6o5vRi9bKlRFsGfQRiWOyKHwIL
 4U5qEDV/Fa23kdkETTUtxPr+ddtThp6Fo6CTxFOKzAm4j3liicTaM+lRysJTAk4fX0wk
 0EHJCnnLTuU4qMtYXBhXtfwr0SXass+zHUchlKbXYH+coVSsJC6TnSJX8IHro8Ox9kYw
 8+v0t8j9QOFfI0xLIoPJDEueWa30208jHNwdDgfbsjuFr9X3qFHZAywyIIRdJm6SISIB
 LNxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772144052; x=1772748852;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kwXkN4CQqyUcBSNtyDI2ylAWfliivb/jsiYcZsARlgw=;
 b=btoTSdYuRnmbwZj0OSZs63Oz0CHnf3rei/izulzcfX5eD0xj9BJ/9B4FBjmIlJCf9p
 wY+wZGglBpXL/75WwBhZbp0T6+Z3shafR8dMYl9T2eZrpNenoINCtT6PoXjqlqbJO5Tq
 W59lG2WwhWNJkrYRFEM0TFLGoZ7jCtYSPOE5Awfe/HYJ2zpKzYvIMedxmGIDqND52Hm/
 Lai+/e7vTHIqRnkYqioZV9j8mpfH+xSKMM9cPPXoHTSzqLv3GaDk6szB83aRcy4ZwDJy
 n73ERd0boF8P50rE7o5YjKzNd5wJdg8UkgvkmLg98Ucq0Bmy8Bb7JX6274AvH54mhjd5
 FJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772144052; x=1772748852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwXkN4CQqyUcBSNtyDI2ylAWfliivb/jsiYcZsARlgw=;
 b=i6GBHRLqaMlAlFPeol7D8SYeFaJBxZmZq9fPVQ2RvVBAf/fMEKeH6h8LJUWenD01Yc
 0/dTz4NCRphDh6p11fMK0DQpVlkSU1wAUGCT3It150LMlzqgZtam0D14uwkDaCtHZjcM
 dMXJa8brz6HrwIstxTv+g6x+mySRmY0B40aGWqSZJe8FiVRm6o8/RJcEg3YFSLM1mXxf
 EPK4Mxb0TKczYVf3vcC5CT/4fcGnFk8wilv/H767JtuD3hr4r8tGguOnxYHjFOrErF8s
 oaC7Aw5Sv5mktoMKNWuZGLfCyARDY3qauaqMW1Ye1EUKVsZ3EcvBo87UqOzv/0FsOGT1
 3cjQ==
X-Gm-Message-State: AOJu0Yyt2SA5dXfEnzQWt5k7+GKm/Y0N56ld/AbqWSh6AVdCyoCyaB6k
 nOlyMuM08hmSzVWXgVlZd/Z6EdMQLjBvqW+bmKcKs6+8GclW5YoTNl/QvI9Dh99qVh3k4NrmVCJ
 rzDIrUiVxsYrDFs2RKb8FqVKqW70lt2yFEjcWUIn9Pg==
X-Gm-Gg: ATEYQzxOUZE5reoU3pza0wRWoEGprbFyKIRjur3tbFDQSRQ9Ih81QGJBl2JfiVHlml4
 SLK7Wbd7EBW6KQbzx+NLwhkPjJGqIL2pGR5PrLlYLHTuMQ1/WukEuOlVoKMUsXiFl0zGXvetFff
 E7q0vyeuV0eLamXWbZE6JZg76zpK0jCgKNcX0cW1bbI5vd0kJdh/VGgdNYvSlArwVz0w1DIFAuC
 F7e+6pWaItmhG8/gfIVLyySPdHO8h6CacYtoEoMioNDvYX6rc1C5jiRzcHVpJDIy5SDbrfhMe8e
 ZVTNgNA=
X-Received: by 2002:a17:90b:5843:b0:354:a57c:65dd with SMTP id
 98e67ed59e1d1-35965cd0e68mr560148a91.24.1772144052552; Thu, 26 Feb 2026
 14:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
 <20260224-bsd-user-claude-v4-18-8ee5ae17056f@bsdimp.com>
 <07084666-45b2-4829-9352-9efc09a60a4b@linaro.org>
In-Reply-To: <07084666-45b2-4829-9352-9efc09a60a4b@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 26 Feb 2026 15:14:00 -0700
X-Gm-Features: AaiRm52ET930l2nh785CUJfIQxu_UWujQtloRUokRmAyeYmwrqdOOCGUq0DZom8
Message-ID: <CANCZdfpgzcT=u0RptF+p0bCHzK3apPT3DS0rHM7tDuLmXz6qhg@mail.gmail.com>
Subject: Re: [PATCH v4 18/24] bsd-user: Add do_bsd___semctl implementation
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000be5259064bc17004"
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x52e.google.com
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

--000000000000be5259064bc17004
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 12:56=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@linaro.org> wrote:

> On 2/24/26 6:40 AM, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Add implementation of __semctl(2) syscall for System V semaphore contro=
l
> > operations. Handles command translation, endianness conversion for
> GETVAL/
> > SETVAL, and array/structure conversions for
> GETALL/SETALL/IPC_STAT/IPC_SET.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/bsd-misc.h | 111
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 111 insertions(+)
> >
> > diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> > index e1e552b58f..72b3db0b74 100644
> > --- a/bsd-user/bsd-misc.h
> > +++ b/bsd-user/bsd-misc.h
> > @@ -99,6 +99,117 @@ static inline abi_long do_bsd_semop(int semid,
> abi_long ptr, unsigned nsops)
> >       return semop(semid, sops, nsops);
> >   }
> >
> > +/* __semctl(2) */
> > +static inline abi_long do_bsd___semctl(int semid, int semnum, int
> target_cmd,
> > +                                       abi_ptr un_ptr)
> > +{
> > +    void *target_un;
> > +    union semun arg;
> > +    struct semid_ds dsarg;
> > +    unsigned short *array =3D NULL;
> > +    int host_cmd;
> > +    abi_long ret =3D 0;
> > +    abi_long err;
> > +    abi_ulong target_array, target_buffer;
> > +
> > +    switch (target_cmd) {
> > +    case TARGET_GETVAL:
> > +        host_cmd =3D GETVAL;
> > +        break;
> > +
> > +    case TARGET_SETVAL:
> > +        host_cmd =3D SETVAL;
> > +        break;
> > +
> > +    case TARGET_GETALL:
> > +        host_cmd =3D GETALL;
> > +        break;
> > +
> > +    case TARGET_SETALL:
> > +        host_cmd =3D SETALL;
> > +        break;
> > +
> > +    case TARGET_IPC_STAT:
> > +        host_cmd =3D IPC_STAT;
> > +        break;
> > +
> > +    case TARGET_IPC_SET:
> > +        host_cmd =3D IPC_SET;
> > +        break;
> > +
> > +    case TARGET_IPC_RMID:
> > +        host_cmd =3D IPC_RMID;
> > +        break;
> > +
> > +    case TARGET_GETPID:
> > +        host_cmd =3D GETPID;
> > +        break;
> > +
> > +    case TARGET_GETNCNT:
> > +        host_cmd =3D GETNCNT;
> > +        break;
> > +
> > +    case TARGET_GETZCNT:
> > +        host_cmd =3D GETZCNT;
> > +        break;
> > +
> > +    default:
> > +        return -TARGET_EINVAL;
> > +    }
> > +
> > +    /*
> > +     * Unlike Linux and the semctl system call, we take a pointer
> > +     * to the union arg here.
> > +     */
> > +    target_un =3D lock_user(VERIFY_READ, un_ptr, sizeof(union
> target_semun), 1);
> > +
> > +    switch (host_cmd) {
> > +    case GETVAL:
> > +    case SETVAL:
> > +        __get_user(arg.val, (abi_int *)target_un);
> > +        ret =3D get_errno(semctl(semid, semnum, host_cmd, arg));
> > +        break;
> > +
> > +    case GETALL:
> > +    case SETALL:
> > +        __get_user(target_array, (abi_ulong *)target_un);
> > +        err =3D target_to_host_semarray(semid, &array, target_array);
> > +        if (is_error(err)) {
> > +            goto out;
> > +        }
>
> Seems like ret should be set to an error also, else we'll silently
> return default value 0. I'm not sure which error code we should return
> (EINVAL?)
>

Ah yes. I'll look at it and fix it.


> > +        arg.array =3D array;
> > +        ret =3D get_errno(semctl(semid, semnum, host_cmd, arg));
> > +        err =3D host_to_target_semarray(semid, target_array, &array);
>

And this is starting to look wrong too. I'll fix that.


> > +        break;
> > +
> > +    case IPC_STAT:
> > +    case IPC_SET:
> > +        __get_user(target_buffer, (abi_ulong *)target_un);
> > +        err =3D target_to_host_semid_ds(&dsarg, target_buffer);
> > +        if (is_error(err)) {
> > +            goto out;
> > +        }
> > +        arg.buf =3D &dsarg;
> > +        ret =3D get_errno(semctl(semid, semnum, host_cmd, arg));
> > +        err =3D host_to_target_semid_ds(target_buffer, &dsarg);
> > +        break;
> > +
> > +    case IPC_RMID:
> > +    case GETPID:
> > +    case GETNCNT:
> > +    case GETZCNT:
> > +        ret =3D get_errno(semctl(semid, semnum, host_cmd, NULL));
> > +        break;
> > +
> > +    default:
> > +        ret =3D -TARGET_EINVAL;
> > +        break;
> > +    }
> > +out:
> > +    unlock_user(target_un, un_ptr, 1);
> > +    return ret;
> > +}
> > +
> >   /* getdtablesize(2) */
> >   static inline abi_long do_bsd_getdtablesize(void)
> >   {
> >
>
> With that,
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>
> Feel free to add the fix and pull directly without reposting so you can
> save some time before softfreeze.
>

Thanks! Most of these errors are rare, but still gotta get them right.

Warner

--000000000000be5259064bc17004
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 26,=
 2026 at 12:56=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.b=
ouvier@linaro.org">pierrick.bouvier@linaro.org</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">On 2/24/26 6:40 AM, Warner Lo=
sh wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Add implementation of __semctl(2) syscall for System V semaphore contr=
ol<br>
&gt; operations. Handles command translation, endianness conversion for GET=
VAL/<br>
&gt; SETVAL, and array/structure conversions for GETALL/SETALL/IPC_STAT/IPC=
_SET.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Cc: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro.org=
" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-misc.h | 111 ++++++++++++++++++++++++++++++++=
++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 111 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h<br>
&gt; index e1e552b58f..72b3db0b74 100644<br>
&gt; --- a/bsd-user/bsd-misc.h<br>
&gt; +++ b/bsd-user/bsd-misc.h<br>
&gt; @@ -99,6 +99,117 @@ static inline abi_long do_bsd_semop(int semid, abi=
_long ptr, unsigned nsops)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return semop(semid, sops, nsops);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* __semctl(2) */<br>
&gt; +static inline abi_long do_bsd___semctl(int semid, int semnum, int tar=
get_cmd,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_p=
tr un_ptr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 void *target_un;<br>
&gt; +=C2=A0 =C2=A0 union semun arg;<br>
&gt; +=C2=A0 =C2=A0 struct semid_ds dsarg;<br>
&gt; +=C2=A0 =C2=A0 unsigned short *array =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 int host_cmd;<br>
&gt; +=C2=A0 =C2=A0 abi_long ret =3D 0;<br>
&gt; +=C2=A0 =C2=A0 abi_long err;<br>
&gt; +=C2=A0 =C2=A0 abi_ulong target_array, target_buffer;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (target_cmd) {<br>
&gt; +=C2=A0 =C2=A0 case TARGET_GETVAL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_SETVAL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D SETVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_GETALL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETALL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_SETALL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D SETALL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_IPC_STAT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D IPC_STAT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_IPC_SET:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D IPC_SET;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_IPC_RMID:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D IPC_RMID;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_GETPID:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETPID;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_GETNCNT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETNCNT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case TARGET_GETZCNT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_cmd =3D GETZCNT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EINVAL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Unlike Linux and the semctl system call, we tak=
e a pointer<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* to the union arg here.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 target_un =3D lock_user(VERIFY_READ, un_ptr, sizeof(uni=
on target_semun), 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (host_cmd) {<br>
&gt; +=C2=A0 =C2=A0 case GETVAL:<br>
&gt; +=C2=A0 =C2=A0 case SETVAL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(arg.val, (abi_int *)target_un)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(semctl(semid, semnum, h=
ost_cmd, arg));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case GETALL:<br>
&gt; +=C2=A0 =C2=A0 case SETALL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(target_array, (abi_ulong *)tar=
get_un);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D target_to_host_semarray(semid, &a=
mp;array, target_array);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(err)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Seems like ret should be set to an error also, else we&#39;ll silently <br>
return default value 0. I&#39;m not sure which error code we should return =
<br>
(EINVAL?)<br></blockquote><div><br></div><div>Ah yes. I&#39;ll look at it a=
nd fix it.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 arg.array =3D array;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(semctl(semid, semnum, h=
ost_cmd, arg));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D host_to_target_semarray(semid, ta=
rget_array, &amp;array);<br></blockquote><div><br></div><div>And this is st=
arting to look wrong too. I&#39;ll fix that.</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case IPC_STAT:<br>
&gt; +=C2=A0 =C2=A0 case IPC_SET:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(target_buffer, (abi_ulong *)ta=
rget_un);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D target_to_host_semid_ds(&amp;dsar=
g, target_buffer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(err)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 arg.buf =3D &amp;dsarg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(semctl(semid, semnum, h=
ost_cmd, arg));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D host_to_target_semid_ds(target_bu=
ffer, &amp;dsarg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case IPC_RMID:<br>
&gt; +=C2=A0 =C2=A0 case GETPID:<br>
&gt; +=C2=A0 =C2=A0 case GETNCNT:<br>
&gt; +=C2=A0 =C2=A0 case GETZCNT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(semctl(semid, semnum, h=
ost_cmd, NULL));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 unlock_user(target_un, un_ptr, 1);<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/* getdtablesize(2) */<br>
&gt;=C2=A0 =C2=A0static inline abi_long do_bsd_getdtablesize(void)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; <br>
<br>
With that,<br>
Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro=
.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br>
<br>
Feel free to add the fix and pull directly without reposting so you can <br=
>
save some time before softfreeze.<br></blockquote><div><br></div><div>Thank=
s! Most of these errors are rare, but still gotta get them right.</div><div=
><br></div><div>Warner=C2=A0</div></div></div>

--000000000000be5259064bc17004--

