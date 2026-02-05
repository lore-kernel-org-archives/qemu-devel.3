Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407F3ECD9B5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 23:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo8O8-0001Lw-I3; Thu, 05 Feb 2026 18:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vo8O6-0001Ln-97
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 18:03:50 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vo8O4-0000la-8k
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 18:03:49 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c6c444e89bcso493662a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 15:03:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770332626; cv=none;
 d=google.com; s=arc-20240605;
 b=BJhDhduXoJh/1uXbI39n9pdTnZybhXw5kartmGINCVop36RVwVFDeAOv5RhmvDS8c4
 fh/nx/f3P5+8x4D1nydD5/G+6hJj0r9HdPx1RRT+78CdAXob6t0RyN+Nv0Jq6vYv1Kjj
 QxCw8336JIkH96S1RbC0JoUZqcPkNTQG+yl6bBkq50CUlSQu9YAX5INY0OX7QQyVQgV2
 6J0mC72ua23qEQqhiuZxGYO5/AK2mg3EXd/NZe+lkrBPuXKsQehZllo6R8yx8lpBXOr2
 ixLzWb3k2V8aAS9EER79DAMauqJT5H9HTD8FqAjPY6H8hyDP86ks28UXqix4aSn3pehq
 flVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NNoCQdB0k5hxEugyNlFmXo9WzL7CVCEToXzthXJqTUk=;
 fh=9GkkxhMrmIJ4R8ls9uxYh1Yld2vRBd22xVCh9C7mDT8=;
 b=fOx0H9TrD+ChWbTRUbP8VCkezJuwNlj7QOun8ll65hiCbUCkUdwwHwa3aJpKGDMiYA
 GYkvXxl6OPK35eJimfktl9gHxVlnebLr4BlC9hXDN/DBE3j+bXyvsO6NpQSmOy4gyx7+
 ASiirQKiliGY1+UAH4l3TneaFRzz/XCf/HfqUKbY7YmDDT5gTGoD42uiQnevKbZuuQDw
 lbdMuMPpdW7FHv41UzgxySUpIctp2tbXXNqbn1mNx1BdhI1NprqyQtedWtdAx469NxKO
 nzdb+fAZr+kAm6OyKVxxPP+N9QeB43qLWo7uZo1F5EmhFQxAu9lga7X8oTFQbEzsgljr
 ujkg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770332626; x=1770937426;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NNoCQdB0k5hxEugyNlFmXo9WzL7CVCEToXzthXJqTUk=;
 b=eLmtLP4wKCXeL4wIWvmHxJTbXLzMy/iy+EPA0nBeuZlgS4VfxVW6P+kBNBR1vh5An9
 LYEWCflgzo5BK02ZrSY7RCRVQfMQjcOQKmJe3Pc4lzm4OUwlqtH+plVF21UgBcOqTg/F
 ACtYOMVolf/JYEMB+6BPaHi5kleA32R5u3HYHzV9MR9UeonIfg4bMetAQZXvk5ts1R7T
 78eGnFGIxMWcATUE/8163bP7L17UBco2gYuu+9Y6FIp8yuBafT5hnuQVpdxuv0i95SBA
 1hArfBZjozA4XIWf+6y0L5+C5jvgPO0y8Bjq86KypfBdwOKO2Kgx0xtAQvCjxSnTt7c/
 EltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770332626; x=1770937426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNoCQdB0k5hxEugyNlFmXo9WzL7CVCEToXzthXJqTUk=;
 b=XMxKz8EtIpiGLBTNyAvsxbEkkogH8R6npNPcC53jw99qzkhsQbDOzSXNLXa8UbD0vi
 sgWYsrfGtRR3o790WeR5zjrv5GtmbqB01f646QHw9cXxuSTrTw6gtWbXxvocmF19OcCk
 odUqq6LdzyXRtUwJt01rWgwhe4oL5rfOUzgwxNmrWKbV8OwaFOAkl7QxWgvt39Vqjh5A
 iZbF69036W9zS6qiZWDapChB+pMmYbv3DPv3wVQlWGWhdD/JzvNgkgpwV69H9cyjW5mc
 k+/7LJpR9uPpEZdQKCySONXS+mGuPGjIAOgnZz4hOpqkZ1czk0b//eorunygE4+kagsC
 9QEQ==
X-Gm-Message-State: AOJu0Yx3m+L2ffsIDF6ccBiz/JJK2VLMNSlP6YCJfEbllVykvOhJzHDc
 w8u2qSJ5/2wTwo6q4We7jWYhPKNuSVapOVWBmr7Bgac4pF5YidH+FZQ/y3hTPC8KaIcPz8/1l8o
 k2kcWzdeDulmejIK1zKkL7QwwpClb2IyPbLunizsi5Q==
X-Gm-Gg: AZuq6aIs0R3WoRaIS7tExlrU0Db/9Gh0EXzzHOHq01ErL9K57PbgUF+PqpCv5GvSR/2
 iNwiWFoFemkbi77cAaiFTS95RgewDc3ZFg1LvGCDduUw4T/TrZ4RCbg21XfvI0bsECZeRm7D4Z4
 AswvzlJDKjmqojdL/4gIS43uaADKZudfJx+vqqppYa7sJRHA+Cdd3Fw986FGTAFBCW/ZBhb+teZ
 EKCi7ekgPmjkKmR+wsjrxlE5UMS1X4zzLV59ZWqTNJLfJkfMInmMPm6QRb3XOKvCVt08eA=
X-Received: by 2002:a17:90b:5146:b0:354:a1bc:f989 with SMTP id
 98e67ed59e1d1-354b3e2be9emr485533a91.37.1770332625710; Thu, 05 Feb 2026
 15:03:45 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-2-8d8ff0035372@bsdimp.com>
 <455b6a6e-21be-4d24-ac1e-290309758996@linaro.org>
In-Reply-To: <455b6a6e-21be-4d24-ac1e-290309758996@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 5 Feb 2026 16:03:34 -0700
X-Gm-Features: AZwV_QiLMUVRHW7qLgdYMLFIwZy4V40r3FEp2x48fxt9FoltP6FT0i9JH6JIGp0
Message-ID: <CANCZdfr8wfw1ZhRb1EicpzyU2MoQkOUeMUfQtoAJ7hAGLmQWGg@mail.gmail.com>
Subject: Re: [PATCH 02/24] bsd-user: FreeBSD needs this too,
 so drop linux ifdef
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>
Content-Type: multipart/alternative; boundary="0000000000004a3cbc064a1bafef"
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x536.google.com
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

--0000000000004a3cbc064a1bafef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 3:51=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > This is more of a toolchain than an OS issue, and all the toolchains ar=
e
> > headed to requiring this. There's nothing Linux specific about it.
> >
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   common-user/safe-syscall.S | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/common-user/safe-syscall.S b/common-user/safe-syscall.S
> > index 74f7e35694..2f714cfbe8 100644
> > --- a/common-user/safe-syscall.S
> > +++ b/common-user/safe-syscall.S
> > @@ -22,6 +22,6 @@
> >    * assembly needs an executable stack and the whole QEMU binary will
> >    * needlessly end up with one. This should be the last thing in this
> file.
> >    */
> > -#if defined(__linux__) && defined(__ELF__)
> > +#if defined(__ELF__)
> >   .section        .note.GNU-stack, "", %progbits
> >   #endif
> >
>
> It feels like you dropped the actual subject line, letting the first line
> of the
> description become the new subject.  Perhaps
>
> common-user: Drop __linux__ around .note.GNU-stack
>

Oh! That's a good idea. Thanks!


> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>

--0000000000004a3cbc064a1bafef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, =
2026 at 3:51=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/6/26 03:26, Warner Losh=
 wrote:<br>
&gt; This is more of a toolchain than an OS issue, and all the toolchains a=
re<br>
&gt; headed to requiring this. There&#39;s nothing Linux specific about it.=
<br>
&gt; <br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0common-user/safe-syscall.S | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/common-user/safe-syscall.S b/common-user/safe-syscall.S<b=
r>
&gt; index 74f7e35694..2f714cfbe8 100644<br>
&gt; --- a/common-user/safe-syscall.S<br>
&gt; +++ b/common-user/safe-syscall.S<br>
&gt; @@ -22,6 +22,6 @@<br>
&gt;=C2=A0 =C2=A0 * assembly needs an executable stack and the whole QEMU b=
inary will<br>
&gt;=C2=A0 =C2=A0 * needlessly end up with one. This should be the last thi=
ng in this file.<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt; -#if defined(__linux__) &amp;&amp; defined(__ELF__)<br>
&gt; +#if defined(__ELF__)<br>
&gt;=C2=A0 =C2=A0.section=C2=A0 =C2=A0 =C2=A0 =C2=A0 .note.GNU-stack, &quot=
;&quot;, %progbits<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; <br>
<br>
It feels like you dropped the actual subject line, letting the first line o=
f the <br>
description become the new subject.=C2=A0 Perhaps<br>
<br>
common-user: Drop __linux__ around .note.GNU-stack<br></blockquote><div><br=
></div><div>Oh! That&#39;s a good idea. Thanks!</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
Anyway,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
<br>
r~<br>
</blockquote></div></div>

--0000000000004a3cbc064a1bafef--

