Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3E1CA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 16:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuYxe-0002AQ-2g; Fri, 05 Sep 2025 12:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pefoley@google.com>)
 id 1uuYxb-00029v-CB
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 12:06:47 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pefoley@google.com>)
 id 1uuYxO-0006iS-Hm
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 12:06:46 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3197f534179so1971857fac.2
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757088391; x=1757693191; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZkwYenxbNptuB5XO2JT/ncPJyISuD2ZsJZv7biEBP7k=;
 b=3BmMjjd97PGltpHPB8FKgQ6UinXJ0K7Dn3HXrqG6hej3Jnp5GNha4KkAhi6m2KFrX6
 rLfs6T8ObxeJI1pYXhoVTUTG4Yc064/8Y4GmJoZhP7X9f3DuXnI6eNabubmRhWHbWyjJ
 piS5nWRUAaNvWjObHC7GQnTgckIryf2fniG83Q6bdfPBU0Aww1OQSW7Bc+Mc7cHWfwBq
 igWJZL58YTlQe6RC/jz7L5BN5BBZU1ONnB0YU4NzrCP6d2z2+tcveA1nFkesUVb3dRDF
 53Ay7EQmm2y4yHDxcwVh/atOOXhDfVrVNGm5C/Ldrud2W7nmK5krsmp9T6o611bTr8Wr
 YUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757088391; x=1757693191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZkwYenxbNptuB5XO2JT/ncPJyISuD2ZsJZv7biEBP7k=;
 b=N+q9V8+jGZl64sOzHKbsi91qUEemuN7NWBrUysGffvz6GM6VMRvv22HR218Xt9caoU
 xDxQdMXCI3yhTLi8HqK5nJ3zjWCxz0czf9T4B1ms3e3wHNw3tKk6AR0vnKBHEEi64KPf
 bMLP/OL/yYtRbU1hag9cs8KDNjT4Q+ZH673pJw01BlmNhPtL7TMyFRC8ZwX7sThNhWZ9
 IxLqBPGrXumPeV4MJ73NATZicJ6YNcGvIJtdsFq+nsSQSR4LCE383Q0Xvf5ISNU5K8R3
 EqU355rI0Z2OJh4cEazSNoghDLE2Ao7drEy29b96Hy8LmUOEK3HmrMoMZwQierH0ym28
 RQEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXnjBG8MToAg0KIgq1YA+Wo+0d6Y8jvsZylRkJAmn/XftZlKR+yx81p7y6cnQXgk5CNURn4YS5OMXr@nongnu.org
X-Gm-Message-State: AOJu0Yyj7Sl3clTKRLOWpv8E99YTx39HrGbhN9Xc/P+GJpo2qcl/5iMt
 T+SWc92bk/E0ty8scT3ObSdprOwfjozxD5N2WUAjWcGHLc9TI+npdBnCtqVkyaOCFuOelbxa2VO
 H+b6tjqasIwKdE9c05Xn72kuNGjFAN3xZ6Xo/o5jyht39ffhsXqUQnfyIAXw=
X-Gm-Gg: ASbGnctm94h7VQU2/qJfrixdW/CFi+2h/ZeJDGzQbjqHqfxmu9QKUice68EPehte0U4
 ZJpkDKhf/4PS6Ao/l9R0qTQCcm25Qo4tAO1p+uvQ0zknoRK1eEG2LMi2Uh65RvkiKx9I8a/qvr7
 dE1xiMcm7nOD0JMDtUtFimm725ousio208xV9Gj0Y7CgM2C3By5eJ+dn8KmOfdIyhPb+gHmNVz0
 aDZfZdq5w152WS5tYqKyJr+jFLVCH7beIcvm0BFfufcZLWWBnrplzc=
X-Google-Smtp-Source: AGHT+IF4iNHpSUur+DRUbeIaNgTK4VKyTBZKX+8gGCqktOahIzCASnJvvBMdC1IHlFusZDhLRJMT0ZxdhHin8IsA6Go=
X-Received: by 2002:a05:6870:1494:b0:315:c0bc:4bb6 with SMTP id
 586e51a60fabf-3196306b5e2mr13119778fac.5.1757088390555; Fri, 05 Sep 2025
 09:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250904-includes-v1-1-a04a0ea14fd1@google.com>
 <687f76dc-769d-4e8d-9281-5e5f10361bfe@redhat.com>
 <80ba3dae-0bb9-4a45-b1f9-5b80f4fdc47b@linaro.org>
 <CAAAKUPPbiQnCzkmnL0Luww1qeFQxVojzfkgJPrGgphXpkrXMGQ@mail.gmail.com>
In-Reply-To: <CAAAKUPPbiQnCzkmnL0Luww1qeFQxVojzfkgJPrGgphXpkrXMGQ@mail.gmail.com>
From: Peter Foley <pefoley@google.com>
Date: Fri, 5 Sep 2025 12:06:19 -0400
X-Gm-Features: Ac12FXySkWd3jiAQko5gZJFVxOk6NZZ2q8-sDz1cp2CcZmRNnLYt601OVTTeTt8
Message-ID: <CAAAKUPO+OnFtkwydwqnj53BZuBsiNKxrb+E8A7kc5H4zbkMQgg@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Add missing includes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, nabihestefan@google.com
Content-Type: multipart/alternative; boundary="0000000000005c7e66063e100554"
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=pefoley@google.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

--0000000000005c7e66063e100554
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:00=E2=80=AFPM Peter Foley <pefoley@google.com> wr=
ote:

>
>
> On Fri, Sep 5, 2025 at 4:48=E2=80=AFAM Richard Henderson <
> richard.henderson@linaro.org> wrote:
>
>> On 9/5/25 09:31, Paolo Bonzini wrote:
>> > On 9/4/25 17:21, Peter Foley wrote:
>> >> We're getting errors about this:
>> >> linux-user/elfload.c:2770:36: error: use of undeclared identifier
>> 'MAP_FIXED_NOREPLACE'
>> >
>> > Queued, thanks.
>> >
>> > Paolo
>> >
>> >>
>> >> Signed-off-by: Peter Foley <pefoley@google.com>
>> >> ---
>> >>   linux-user/elfload.c | 1 +
>> >>   linux-user/mmap.c    | 1 +
>> >>   linux-user/syscall.c | 1 +
>> >>   3 files changed, 3 insertions(+)
>> >>
>> >> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> >> index
>> 26c090c95d3e90ad4a23a927267e4106f68975b0..edbacf041f25d88472c95efb4eb9bd=
ccd81e9902
>>
>> >> 100644
>> >> --- a/linux-user/elfload.c
>> >> +++ b/linux-user/elfload.c
>> >> @@ -5,6 +5,7 @@
>> >>   #include <sys/prctl.h>
>> >>   #include <sys/resource.h>
>> >>   #include <sys/shm.h>
>> >> +#include <linux/mman.h>
>>
>> There's no reason to include <linux/mman.h>.
>>
>> This value is provided by <sys/mman.h> directly for musl and by
>> <sys/mman.h> via
>> <bits/mman-map-flags*> for glibc.
>>
>> Are you using some other libc?  You're solidly in non-standard territory
>> there.
>> Perhaps that other libc needs updating.
>>
>
> We're using glibc 2.27.
> I definitely saw build failures earlier without this patch, but I'm now
> unable to reproduce them at head.
> So maybe there was an issue with our headers at an earlier point that has
> since been fixed?
> I'll revert this patch from our local fork and you should probably drop i=
t
> upstream as well.
>
>
Oh, I figured out why I couldn't reproduce the issue.
We had a separate patch we were carrying that added linux/mman.h
to linux-user/user-mmap.h.
If I revert both patches, I see this:
third_party/qemu/linux-user/mmap.c:602:40: error: use of undeclared
identifier 'MAP_FIXED_NOREPLACE'
  602 |     if (start || (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {



>
>>
>> r~
>>
>

--0000000000005c7e66063e100554
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 5, =
2025 at 12:00=E2=80=AFPM Peter Foley &lt;<a href=3D"mailto:pefoley@google.c=
om">pefoley@google.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 5, =
2025 at 4:48=E2=80=AFAM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 9/5/25 =
09:31, Paolo Bonzini wrote:<br>
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
iv><br></div></div></div></blockquote><div><br></div><div>Oh, I figured out=
 why I couldn&#39;t reproduce the issue.</div><div>We had a separate patch =
we were carrying that added=C2=A0linux/mman.h to=C2=A0linux-user/user-mmap.=
h.</div><div>If I revert both patches, I see this:</div><div>third_party/qe=
mu/linux-user/mmap.c:602:40: error: use of undeclared identifier &#39;MAP_F=
IXED_NOREPLACE&#39;<br>=C2=A0 602 | =C2=A0 =C2=A0 if (start || (flags &amp;=
 (MAP_FIXED | MAP_FIXED_NOREPLACE))) {<br></div><div><br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><di=
v class=3D"gmail_quote"><div></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
<br>
r~<br>
</blockquote></div></div>
</blockquote></div></div>

--0000000000005c7e66063e100554--

