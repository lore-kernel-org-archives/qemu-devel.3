Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8773105A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 13:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0g6X-000192-Jy; Thu, 12 Mar 2026 09:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1w0g6K-00017c-UG
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 09:29:22 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1w0g6I-0004Vm-66
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 09:29:20 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8297e0b27e5so653126b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 06:29:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773322153; cv=none;
 d=google.com; s=arc-20240605;
 b=eHTlkyVQpx4uDx0zLbv43xzuYUGVNTL5hNUFC5hOrRZXipvVQN5G/7e1Bv1wILvn/x
 ilL7y8OfYUbi18/+Ir48WUthwQhmJrlRmHkbCk2b6jychl04HbIiDV/+TCAJkNH4Ea/h
 safONbnWbVFuW+VFbYXHxikPs1m4cRTWGT65P583qqEv098wOJG7JesofdiuTql8/PXq
 fz2vC1Wumq1xyIOf86lvJS0NQ9OfGAqvmjpf00Ylv7QzzFHsQqHE3kfxH7dQLjpDLh62
 JVNq1MCil2LNyQ6CcFMb+Jp7Cz+SzEnwpQFVk7/C/0xengF8oFoKn1yxdUjT+vN63ZCS
 h/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZHQ6J1nhR6lyDZ4O86uG0E3XXLuB/HJlL5NR6cvRKjI=;
 fh=lm0CxVSc29kRD0RNT+HmebyeZo6ogFRptftWDSqw+GQ=;
 b=RAjMLcGVLlfe+BwpxZDk2gYSjJmY6n1ptr8tdd35cBjnzUyJ+lktmVK7uXiUEIHQMm
 fjqfTMcl5SEmGD0j3XlDZRcm9nGjfQ154vAy3LYawl+rM+4po7dinG+en4zf1dVJhrjN
 kQd23lJIoBtf1K9J+twMee4jt9hOzJ/UwzJQMhXyndl8HY9jrhlRR8YSr7NJ+78oSVzB
 wAvv68gQq4DzUjAGM/QlyCMFQj5i+t5AcSw3SRQ0HevInwqZp15CqvChDx2grZ9dqdAz
 qvQZcDJt7P3QdXLd6VlCCmw8jRrRlxZ6XNLUUzgPUX7znxzFnbnhjXRP+YlQHfvRYUEl
 1obQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1773322153; x=1773926953;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHQ6J1nhR6lyDZ4O86uG0E3XXLuB/HJlL5NR6cvRKjI=;
 b=QFsG+J8zKFrDYtLdGkilOaFY0O85SPSQb/Y1xuayjQRufUdq/9udH24OXvqj4Rkxz9
 ip7qlYZbZpxPYiogsz2RiaZ/EtjLWNeerg42UHtCSRmF7UvW2mNLtH6W+QVJxlFpS0MU
 p8ElX4oOJcCvyU0P+fKoM5hgWfyQ88b61j6v143gJEd1HIAVVqTzqolpix8exwBZBCq4
 67oRuWD/a3bypY3i3y5LHEWiqWwBcletGqTy4l3MrMqzclYqjo+9ssydIa9hj2ZkIszs
 mp8MAWczKYPC/xa+x8kqaOOGCxQuyaFZC3/CDPB4TEcWgyIIaPC7MGwg+Gqwe/d38Xd0
 s9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773322153; x=1773926953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHQ6J1nhR6lyDZ4O86uG0E3XXLuB/HJlL5NR6cvRKjI=;
 b=uN49bqbCmGdh7/v20gjheLIGJYnwpxbGjXAVVypDrZYoqGzBSQZJRgfbpSwNDGTNWL
 5E4X4U3r8WF8dzRwds7rAothja7R5Muv6+78zCcM/R77t7zvcJO+/RJP7aoHvY6oJhfS
 xqEPjqqmt37BkRQpPRzL64t6fD4eu0qT+J73Qf/j7ckfb4Y9MjplUdxHdVjohL0e/88L
 VeVLhBe2fRRivImSc1K8nhRZ22RxmLOprXbfPWseUL0yGq9m5v6h1+vWeqzMfhvu4W2Q
 pmEdJiBZYMlwIunoekyW4UqC/nQrj/jAcuc2ArMnVio+1kZi7KdhZbd5TYZooDIvzjMQ
 LakA==
X-Gm-Message-State: AOJu0Yz//h+ZQ3gkHxLWGfXmojPS4Oqpbhzbdp05kbGYWkn2C/B0xdFs
 EO0XPPk1HeZXGcmzOZnK6t70GXSGBC9l9qOw3w8YuDmVMw2QIRgTT7qcmtAmUnrwK09fuS3u6h0
 hbLjeOCV4oUzB32HfJIkrL4SJVaexifoRyX6+qsWQAZlwKRZapCDd
X-Gm-Gg: ATEYQzzchI4TWl1J5Me61aOfqNXqwUR1U/LODWYTPULMiNisNt6nSeajCvNLgYTSAlC
 lvdk4KE8Gn2rlb8tWi27TgbIm7uBgDPZf3DTEPgu0ITwwZFQ77FuW5LF6NKVhO1lQCRWWkFfPqp
 odUFuKYC3SzG54brwxk1SE1bLgYM7EGvoIbwjhbluKVE/swxY4/+nop9XCYPBW7w1h/WSc/R74w
 YiANKwO/xc7o5vW8xwTXwzB7DAFnszP01xFCiqEfSGQPpjDqCOA4+kZzAfDcd4MO3fDyA1P8O7x
 jAmiE2w=
X-Received: by 2002:a05:6a00:4c8c:b0:827:2995:3b99 with SMTP id
 d2e1a72fcca58-829f71dba64mr5437678b3a.31.1773322152705; Thu, 12 Mar 2026
 06:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260312-share-thunk-v1-1-2f36003a1913@bsdimp.com>
In-Reply-To: <20260312-share-thunk-v1-1-2f36003a1913@bsdimp.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 12 Mar 2026 07:29:01 -0600
X-Gm-Features: AaiRm52fz4wsM8_20T8A4xXT2KazU2FLvCVvgMd0j14Amg5vVI3BpxKw6DRr81g
Message-ID: <CANCZdfqX7GhQxd=zHP-ye6EzdGhNdmgDsJQx9EAVVZCAeUu1Xw@mail.gmail.com>
Subject: Re: [PATCH RFC] common-user: Share thunk.c between bsd-user and
 linux-user
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fc0ec2064cd3bc4e"
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x435.google.com
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

--000000000000fc0ec2064cd3bc4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 7:11=E2=80=AFAM Warner Losh <imp@bsdimp.com> wrote:

> thunk.c is the same between linux-user and bsd-user (out of tree),
> so share it between the two.
>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
> As part of upstream blitz bsd-user, I've discovered that bsd-user and
> linux-user have the same thunk.c file. Rather than copy it, put it into
> the common-user directory and share it. It has to be compiled
> per-target, unlike the rest of common-user, so modify linux-user and
> bsd-user to grab it from there.
>

I can also do the #include "../common-user/thunk.c" hack. But this seemed
more straightforward. I'm also open to other ways to share. I can't just
put it
into the common-user/meson.build list since it needs to be per-target, not
for
the host. There doesn't seem to be a generic '*_user_ss' I can use. the
user_ss
that common-user/meson.build users is in addition to bsd_user_ss or
linux_user_ss.

Warner


> ---
>  bsd-user/meson.build                | 1 +
>  {linux-user =3D> common-user}/thunk.c | 0
>  linux-user/meson.build              | 2 +-
>  3 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/bsd-user/meson.build b/bsd-user/meson.build
> index 00428fc2f8..c19b1f37a7 100644
> --- a/bsd-user/meson.build
> +++ b/bsd-user/meson.build
> @@ -17,6 +17,7 @@ bsd_user_ss.add(files(
>    'plugin-api.c',
>    'signal.c',
>    'strace.c',
> +  '../common-user/thunk.c',
>    'uaccess.c',
>  ))
>
> diff --git a/linux-user/thunk.c b/common-user/thunk.c
> similarity index 100%
> rename from linux-user/thunk.c
> rename to common-user/thunk.c
> diff --git a/linux-user/meson.build b/linux-user/meson.build
> index 332847a621..f98b4a62cc 100644
> --- a/linux-user/meson.build
> +++ b/linux-user/meson.build
> @@ -17,7 +17,7 @@ linux_user_ss.add(files(
>    'signal.c',
>    'strace.c',
>    'syscall.c',
> -  'thunk.c',
> +  '../common-user/thunk.c',
>    'uaccess.c',
>    'uname.c',
>  ))
>
> ---
> base-commit: 769a37d8bd0c81c39128fc292352f01bad0769f4
> change-id: 20260312-share-thunk-ab1585477999
>
> Best regards,
> --
> Warner Losh <imp@bsdimp.com>
>
>

--000000000000fc0ec2064cd3bc4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 12,=
 2026 at 7:11=E2=80=AFAM Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">=
imp@bsdimp.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">thunk.c is the same between linux-user and bsd-user (out of t=
ree),<br>
so share it between the two.<br>
<br>
Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"=
_blank">imp@bsdimp.com</a>&gt;<br>
---<br>
As part of upstream blitz bsd-user, I&#39;ve discovered that bsd-user and<b=
r>
linux-user have the same thunk.c file. Rather than copy it, put it into<br>
the common-user directory and share it. It has to be compiled<br>
per-target, unlike the rest of common-user, so modify linux-user and<br>
bsd-user to grab it from there.<br></blockquote><div><br></div><div>I can a=
lso do the #include &quot;../common-user/thunk.c&quot; hack. But this seeme=
d</div><div>more straightforward. I&#39;m also open to other ways to share.=
 I can&#39;t just put it</div><div>into the common-user/meson.build list si=
nce it needs to be per-target, not for</div><div>the host. There doesn&#39;=
t seem to be a generic &#39;*_user_ss&#39; I can use. the user_ss</div><div=
>that common-user/meson.build users is in addition to bsd_user_ss or linux_=
user_ss.</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0bsd-user/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 1 +<br>
=C2=A0{linux-user =3D&gt; common-user}/thunk.c | 0<br>
=C2=A0linux-user/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 2 +-<br>
=C2=A03 files changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/bsd-user/meson.build b/bsd-user/meson.build<br>
index 00428fc2f8..c19b1f37a7 100644<br>
--- a/bsd-user/meson.build<br>
+++ b/bsd-user/meson.build<br>
@@ -17,6 +17,7 @@ bsd_user_ss.add(files(<br>
=C2=A0 =C2=A0&#39;plugin-api.c&#39;,<br>
=C2=A0 =C2=A0&#39;signal.c&#39;,<br>
=C2=A0 =C2=A0&#39;strace.c&#39;,<br>
+=C2=A0 &#39;../common-user/thunk.c&#39;,<br>
=C2=A0 =C2=A0&#39;uaccess.c&#39;,<br>
=C2=A0))<br>
<br>
diff --git a/linux-user/thunk.c b/common-user/thunk.c<br>
similarity index 100%<br>
rename from linux-user/thunk.c<br>
rename to common-user/thunk.c<br>
diff --git a/linux-user/meson.build b/linux-user/meson.build<br>
index 332847a621..f98b4a62cc 100644<br>
--- a/linux-user/meson.build<br>
+++ b/linux-user/meson.build<br>
@@ -17,7 +17,7 @@ linux_user_ss.add(files(<br>
=C2=A0 =C2=A0&#39;signal.c&#39;,<br>
=C2=A0 =C2=A0&#39;strace.c&#39;,<br>
=C2=A0 =C2=A0&#39;syscall.c&#39;,<br>
-=C2=A0 &#39;thunk.c&#39;,<br>
+=C2=A0 &#39;../common-user/thunk.c&#39;,<br>
=C2=A0 =C2=A0&#39;uaccess.c&#39;,<br>
=C2=A0 =C2=A0&#39;uname.c&#39;,<br>
=C2=A0))<br>
<br>
---<br>
base-commit: 769a37d8bd0c81c39128fc292352f01bad0769f4<br>
change-id: 20260312-share-thunk-ab1585477999<br>
<br>
Best regards,<br>
-- <br>
Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsd=
imp.com</a>&gt;<br>
<br>
</blockquote></div></div>

--000000000000fc0ec2064cd3bc4e--

