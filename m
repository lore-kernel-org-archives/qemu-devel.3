Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE08EE9B269
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutK9-0003qp-Ea; Tue, 24 Feb 2026 09:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vutK5-0003qQ-59
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:23:37 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vutK2-00073t-Je
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:23:36 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-358f3ef464bso231738a91.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:23:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771943012; cv=none;
 d=google.com; s=arc-20240605;
 b=ZsJUPHSl1bixgDA/Q7fezMHfRXzObP5DfLFAY8CxMs8iJpuJgJLGsBYLVmaPrWJkHp
 MNQS8XVVemir7xnpPVDHCJUHCd5WZsvapIkoIRB/tK5Waw02xyELuwFompE/dBFktrzL
 4H5lWzsc1LQuW3kGVE/p16q1kSAWQI+49lkIII3ZjR3y1Dmx0bMyGDjhWfeEoMsUK4Iy
 w2fCfg1U5TZANN5F62tu+do1wr2B9b5pI4e/ZzygZ3qymKWavqRP6nb2VFLqOzbwTJXA
 eSuQLQpAQOtHEcc53KfNqg7SsVXGqv86BRZYfgbjxVhj7toMAHZfqIS7b7VsW4U9c4Kk
 ToOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yKtQqJcAzi9H01h55kxXm5QspNBrpVhL087PYU+0dwA=;
 fh=kWGEXuCKDBxGDPzzadhEfRJt01GUdYxxxqyqKtCtcZY=;
 b=FojBbgOtmRS2cnD5NTQIdTbjjr8WZFwGnmUGkarBnoOvtMp+QI382iRdJqFwbnCCaM
 M55BETRHbV6cm7hEQu9t4osgu+UXRhrB1qJp+L2cpy0JANZqapbG1lhz484kG6bxQEtf
 Jx/l4ebLn3TmE1tIBS71TfpduqGdi0M9QhgZhccPTNphu2htGUYW0V3TM4ovPuUGOWd8
 7pYAf4enBRuzVk3RiLd8geFGbQ4DLpbk4bE65YDS7hIMjqmbpnmDNlCrLOohmT1ogmI6
 Cexm8gFbv1BkN09h40yEALe3WUs45+O6IDEaCj+6NN6Hsew77oCaDMTp/txeH/7QQY6B
 I6fQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771943012; x=1772547812;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yKtQqJcAzi9H01h55kxXm5QspNBrpVhL087PYU+0dwA=;
 b=uDLF91EoBg4zTMuPJz2ljhRcAlulgq7EZVEQXdRkO1lAN41scaQ+rx4uIVefK4E0Nc
 bk6NudhO9b+VU0b/POlLj9Jkje2dZgz+JEw6+EparHMBqy2OWOKNt2x3+z407+ERWfoU
 THekpHBoA25ksDt3XWTGcT5ppd0C/3y3Wn1uIN2Ddj0+GJhe5oAYVtgB17Yk05gZfqhZ
 ZcpOb4mksSu/jpjXyfBsvdstAYl/VcjIM0i2+F7K3Dr27NrYPIUltLnQKk8HlcvdvhaF
 GYhyGwtc8zXmxZYiGT50W8kJDjHGX+pt6NO2OSJyf0MzIiYv0Z1Iu5bLzTcX/e0xcf/r
 pvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943012; x=1772547812;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKtQqJcAzi9H01h55kxXm5QspNBrpVhL087PYU+0dwA=;
 b=sjEiD9DkLUEdAsz9l5ptDH5wK2qR6ehNBgLV4A40tWj/3gNJMmzOAL4WKnwfPppfug
 +5bno1LJ7O28byJBUNXGb7w2mqwW1NXxyAnW4UINdx1FZ45ct/6kfgddTG01KHtWo6h+
 pNBHWJEqzoudxrTXSn7RXYYMOJfGVKB89D7VY7vzshCXeTx5FDHgKV04FFkHt0fJHUyL
 y6SvjB+TLNQrONfgLn1K+E5cxBTvlkiwfV9zUBN6jUQRTg/BdtUsB4RZ0nIVEth97FaJ
 Z1uoQqy3InUNDP/lOeR7NTw+zifhhAqqKa/zTEoYQnsrB0UxTRr8q4Xbda2YSWwND/d3
 Ji8g==
X-Gm-Message-State: AOJu0YyDUzztbvnvSvLxylV+H43vaFztLgsAnhuhvp6UYELdPos4CzpX
 9bV5qo1ErecgmSJT4ZZE9a3GH4zOIz8JiyzCc8W/YGQBoi7elutGA8ix5a/MB7Rw6wVZSFU20Ye
 gH6NxS4fbJy5+eYz9w/JkTEP408o8nZmV33yk8vfmVA==
X-Gm-Gg: ATEYQzyAzBSQ+7DPUtpfDIr+qKRm6kqIp9/L0IJgNyJ7qTQYZ3mOd8vHRywWuKO8Q/l
 N7/abs9pi7VOwtQG6DeCFpjMAL1mfDaKehQq6LCnyhpq5c7SU+MBiMbaIcmE87CHkWo41iqYHiT
 thYIj2UD39AH+jpHb4izH3UG41pMtMHhygsb9IEPoK3TKykpGfQrCH2e91bfVqonTntvzuiYbAZ
 0B7UQF6Gar1solhKPu5CUN/PVrwowDWyNjPhKJ8lArJaDcivyhfr+bG0RvWqO18CufeCRXHB1ZH
 r9+XY/PVD98aRDax5A==
X-Received: by 2002:a17:90b:5146:b0:341:8c8b:b8e6 with SMTP id
 98e67ed59e1d1-358ae8b79ccmr10853024a91.16.1771943012492; Tue, 24 Feb 2026
 06:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
 <20260218-bsd-user-claude-v3-18-0137b37b221e@bsdimp.com>
 <27465be5-5964-4402-8034-f0c7c4edc3b1@linaro.org>
In-Reply-To: <27465be5-5964-4402-8034-f0c7c4edc3b1@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:23:19 -0700
X-Gm-Features: AaiRm52Tbk1IzPLo37tdx3f5r1-aFzexClso2zN86HnAF2L1akigede9Qf0ulR8
Message-ID: <CANCZdfotG-JP_us-=GhV9=jTHbSvpRmm=tmv+y9c3kwcPag+vQ@mail.gmail.com>
Subject: Re: [PATCH v3 18/24] bsd-user: Add do_bsd___semctl implementation
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000d27735064b92a1c8"
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

--000000000000d27735064b92a1c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 10:01=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@linaro.org> wrote:

> On 2/18/26 9:22 PM, Warner Losh wrote:
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
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/bsd-misc.h | 116
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 116 insertions(+)
> >
> > diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> > index e1e552b58f..cb7fe1d6d0 100644
> > --- a/bsd-user/bsd-misc.h
> > +++ b/bsd-user/bsd-misc.h
> ...
>
> > +    case IPC_STAT:
> > +    case IPC_SET:
> > +        __get_user(target_buffer, (abi_ulong *)target_un);
> > +        err =3D target_to_host_semid_ds(&dsarg, target_buffer);
> > +        if (is_error(err)) {
> > +            return err;
> > +        }
> > +        arg.buf =3D &dsarg;
> > +        ret =3D get_errno(semctl(semid, semnum, host_cmd, arg));
> > +        err =3D host_to_target_semid_ds(target_buffer, &dsarg);
> > +        if (is_error(err)) {
> > +            return err;
> > +        }
> > +        break;
> >
>
> For all the cases using this pattern:
>
> ```
> if (is_error(err)) {
>      return err;
> }
> ```
>

Well, the first one in this section needs the goto. The second one just
needs to be deleted because the 'break' following does the right thing.


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
>
> Shouldn't we instead goto this epilogue to ensure we call unlock_user?
>

I think so too. It's obvious in hindsight. Thanks!

Warner


> > +    unlock_user(target_un, un_ptr, 1);
> > +    return ret;
> > +}
> > +
> Regards,
> Pierrick
>

--000000000000d27735064b92a1c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 19,=
 2026 at 10:01=E2=80=AFAM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.b=
ouvier@linaro.org">pierrick.bouvier@linaro.org</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">On 2/18/26 9:22 PM, Warner Lo=
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
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-misc.h | 116 ++++++++++++++++++++++++++++++++=
++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 116 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h<br>
&gt; index e1e552b58f..cb7fe1d6d0 100644<br>
&gt; --- a/bsd-user/bsd-misc.h<br>
&gt; +++ b/bsd-user/bsd-misc.h<br>
...<br>
<br>
&gt; +=C2=A0 =C2=A0 case IPC_STAT:<br>
&gt; +=C2=A0 =C2=A0 case IPC_SET:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(target_buffer, (abi_ulong *)ta=
rget_un);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D target_to_host_semid_ds(&amp;dsar=
g, target_buffer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(err)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 arg.buf =3D &amp;dsarg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(semctl(semid, semnum, h=
ost_cmd, arg));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D host_to_target_semid_ds(target_bu=
ffer, &amp;dsarg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(err)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;<br>
<br>
For all the cases using this pattern:<br>
<br>
```<br>
if (is_error(err)) {<br>
=C2=A0 =C2=A0 =C2=A0return err;<br>
}<br>
```<br></blockquote><div><br></div><div>Well, the first one in this section=
 needs the goto. The second one just needs to be deleted because the &#39;b=
reak&#39; following does the right thing.</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
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
<br>
Shouldn&#39;t we instead goto this epilogue to ensure we call unlock_user?<=
br></blockquote><div><br></div><div>I think so too. It&#39;s obvious in hin=
dsight. Thanks!</div><div><br></div><div>Warner=C2=A0</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 unlock_user(target_un, un_ptr, 1);<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
Regards,<br>
Pierrick<br>
</blockquote></div></div>

--000000000000d27735064b92a1c8--

