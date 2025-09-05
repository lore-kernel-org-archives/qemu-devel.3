Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049B4CA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 16:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuYsI-00072L-DO; Fri, 05 Sep 2025 12:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pefoley@google.com>)
 id 1uuYrU-0006mf-Jd
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 12:00:28 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pefoley@google.com>)
 id 1uuYrQ-00060P-Ax
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 12:00:28 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-31d75b4d485so1416689fac.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 09:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757088022; x=1757692822; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8/GIH0gakxB927qP/Hus6yrqtU6uTHBn/M+1adKgOg=;
 b=ZHvNnEUjwO19I6Gq7i0n1SXRJ9lIfNTjqFfLJGdm5wVjMK0q7BgfvdZltF4fuv28Uf
 FqYGcKxwbri4dQRomdcrHSKg7OEn/aUnzCENeTxFknJdIu1e2mWyJj7eKBGSmy4SWSQO
 oVdP8dUXLeMovjhJr7nmXhzux3MlI3vZqswkYaxsaqQtalKmzKQLaLzVxwEu0Tg21PGY
 RbmZ/PFGpNf+UgxO43ochveX39xOHXBXERpZyGJuPJFcG5eGUzFHLmXeyrrF68x5HvOR
 gq5L7hTdYyr/Gl1wteY9I7fsO3dYIs8wAWqqHa7H5wfvIYLlF/EDAMpPxbf6pdusQ6xA
 LNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757088022; x=1757692822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q8/GIH0gakxB927qP/Hus6yrqtU6uTHBn/M+1adKgOg=;
 b=SXnFuF3pfAoTmSEBXgx+cnTHAzn+IbM58AUGHQ6tGWqvZIfrzmsIzlJ9X1L3/N1kbP
 YRnBUoptkerF/mK6AHspGSYnCDkE/w1fjKkJN4LiU4yNxQaV8DDCHgYf7W/CxWs65h6p
 vguFwwyIsNpzs+Y/FSR5ykr5Dyy3B4U1GXGzH26kS+3V2IQZhWIMPEE4OvqJnZkY+t/P
 YEfnb5Dh8JpNu1z+Lu0Q1rzJraJHvEjLQDpp/N+Xzd2p5n5TNTjAOJWifcgw6erHuvML
 /7+z/KzH43nwraofmIpgQfg4/bsuNDCA2vEeA+ksSQW0OmMuhqvLR1aU70C2DIqGMjcD
 AU/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtYRIPFYtw0z920GkDZHmwi5sZz5v61QRveoUHy0xexsRwJY817POrnjup5NQU6bt+PgodokalyoPv@nongnu.org
X-Gm-Message-State: AOJu0Yxa5XofvIxay9cNVmHClZo0M5z2O8iNw1cfzNapLw6wbhmtGQet
 /mYw+WNxorOAnmqiFNxBxqfM0N+RUKjbu0JcIU/jo3GD7nzxwuxJwYiLJVUt+A3TWvMhuhzA2dC
 tPZdSqhA5pi2tlp+vqIGXbrcnOADJlj8shoA4knNs
X-Gm-Gg: ASbGncsZtbQ7H72ff2mBh8FaAsnEhPsnCoz08Tlbcuj1IKLsB69V8MUD2+i1SyWoYtH
 qxAcxAlNKp/6BKcGpl6MDSz5c8hVJHyJ6b81bvY9Dng4tfntmbLTKVRWN7dupkTgZungdyqGauG
 whnvSlh34DobCKslBWqGs4zHrCQTFWxU9HxeK3PgM1cMREUG5ZmCjKr03PcnJjyEoMBPPMo5B4d
 rsg0zxy0wvRlpE1cId8VK+bezj8iF+vj5Mvc3fglSAR
X-Google-Smtp-Source: AGHT+IGJbYHubhXlc765ltIZnlZMLhPu+1kuFlXNmbNOuedij8bHgew3SoevyS1aKEE0QkSPtHTaZXk/VdWD+qr/fjc=
X-Received: by 2002:a05:6871:5888:b0:315:bcca:be26 with SMTP id
 586e51a60fabf-319633453d9mr11165687fac.32.1757088021570; Fri, 05 Sep 2025
 09:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250904-includes-v1-1-a04a0ea14fd1@google.com>
 <687f76dc-769d-4e8d-9281-5e5f10361bfe@redhat.com>
 <80ba3dae-0bb9-4a45-b1f9-5b80f4fdc47b@linaro.org>
In-Reply-To: <80ba3dae-0bb9-4a45-b1f9-5b80f4fdc47b@linaro.org>
From: Peter Foley <pefoley@google.com>
Date: Fri, 5 Sep 2025 12:00:09 -0400
X-Gm-Features: Ac12FXwQyMk5T2xBjXU7Dl2HoANjxIof5c0iraTIpnjF4-BoDmVV7-BigVqm4z4
Message-ID: <CAAAKUPPbiQnCzkmnL0Luww1qeFQxVojzfkgJPrGgphXpkrXMGQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Add missing includes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, nabihestefan@google.com
Content-Type: multipart/alternative; boundary="0000000000005df3a7063e0fefe6"
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=pefoley@google.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--0000000000005df3a7063e0fefe6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 4:48=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/5/25 09:31, Paolo Bonzini wrote:
> > On 9/4/25 17:21, Peter Foley wrote:
> >> We're getting errors about this:
> >> linux-user/elfload.c:2770:36: error: use of undeclared identifier
> 'MAP_FIXED_NOREPLACE'
> >
> > Queued, thanks.
> >
> > Paolo
> >
> >>
> >> Signed-off-by: Peter Foley <pefoley@google.com>
> >> ---
> >>   linux-user/elfload.c | 1 +
> >>   linux-user/mmap.c    | 1 +
> >>   linux-user/syscall.c | 1 +
> >>   3 files changed, 3 insertions(+)
> >>
> >> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> >> index
> 26c090c95d3e90ad4a23a927267e4106f68975b0..edbacf041f25d88472c95efb4eb9bdc=
cd81e9902
>
> >> 100644
> >> --- a/linux-user/elfload.c
> >> +++ b/linux-user/elfload.c
> >> @@ -5,6 +5,7 @@
> >>   #include <sys/prctl.h>
> >>   #include <sys/resource.h>
> >>   #include <sys/shm.h>
> >> +#include <linux/mman.h>
>
> There's no reason to include <linux/mman.h>.
>
> This value is provided by <sys/mman.h> directly for musl and by
> <sys/mman.h> via
> <bits/mman-map-flags*> for glibc.
>
> Are you using some other libc?  You're solidly in non-standard territory
> there.
> Perhaps that other libc needs updating.
>

We're using glibc 2.27.
I definitely saw build failures earlier without this patch, but I'm now
unable to reproduce them at head.
So maybe there was an issue with our headers at an earlier point that has
since been fixed?
I'll revert this patch from our local fork and you should probably drop it
upstream as well.


>
> r~
>

--0000000000005df3a7063e0fefe6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 5, =
2025 at 4:48=E2=80=AFAM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 9/5/25 09:31, Paolo Bonzi=
ni wrote:<br>
&gt; On 9/4/25 17:21, Peter Foley wrote:<br>
&gt;&gt; We&#39;re getting errors about this:<br>
&gt;&gt; linux-user/elfload.c:2770:36: error: use of undeclared identifier =
&#39;MAP_FIXED_NOREPLACE&#39;<br>
&gt; <br>
&gt; Queued, thanks.<br>
&gt; <br>
&gt; Paolo<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Peter Foley &lt;<a href=3D"mailto:pefoley@google.co=
m" target=3D"_blank">pefoley@google.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 linux-user/elfload.c | 1 +<br>
&gt;&gt; =C2=A0 linux-user/mmap.c=C2=A0=C2=A0=C2=A0 | 1 +<br>
&gt;&gt; =C2=A0 linux-user/syscall.c | 1 +<br>
&gt;&gt; =C2=A0 3 files changed, 3 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
&gt;&gt; index 26c090c95d3e90ad4a23a927267e4106f68975b0..edbacf041f25d88472=
c95efb4eb9bdccd81e9902 <br>
&gt;&gt; 100644<br>
&gt;&gt; --- a/linux-user/elfload.c<br>
&gt;&gt; +++ b/linux-user/elfload.c<br>
&gt;&gt; @@ -5,6 +5,7 @@<br>
&gt;&gt; =C2=A0 #include &lt;sys/prctl.h&gt;<br>
&gt;&gt; =C2=A0 #include &lt;sys/resource.h&gt;<br>
&gt;&gt; =C2=A0 #include &lt;sys/shm.h&gt;<br>
&gt;&gt; +#include &lt;linux/mman.h&gt;<br>
<br>
There&#39;s no reason to include &lt;linux/mman.h&gt;.<br>
<br>
This value is provided by &lt;sys/mman.h&gt; directly for musl and by &lt;s=
ys/mman.h&gt; via <br>
&lt;bits/mman-map-flags*&gt; for glibc.<br>
<br>
Are you using some other libc?=C2=A0 You&#39;re solidly in non-standard ter=
ritory there.<br>
Perhaps that other libc needs updating.<br></blockquote><div><br></div><div=
>We&#39;re using glibc 2.27.</div><div>I definitely=C2=A0saw build failures=
 earlier without=C2=A0this patch, but I&#39;m now unable to reproduce them =
at head.</div><div>So maybe there was an issue with our headers at an earli=
er point that has since been fixed?</div><div>I&#39;ll revert this patch fr=
om our local fork and you should probably drop it upstream as well.</div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
r~<br>
</blockquote></div></div>

--0000000000005df3a7063e0fefe6--

