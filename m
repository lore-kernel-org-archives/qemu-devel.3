Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8002C369C7
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Lbo-0000RY-9R; Thu, 17 Apr 2025 05:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5Lbm-0000Qz-51; Thu, 17 Apr 2025 05:32:34 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5Lbk-0006BM-8Q; Thu, 17 Apr 2025 05:32:33 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso425572a91.0; 
 Thu, 17 Apr 2025 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744882349; x=1745487149; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jg9liQY2yP5Kh3RtgdI7xjFe5GA+ZZN449PB22RqFLM=;
 b=ma1VHJJaOn22cYFMlBz+urkflF7vAK7tuzzzDTTFSWnN3q093LLCC9l/MTOCR9jyV3
 2EBow8xBBkYjThzhUJ6dFaBbBUYboUMoCYWIeKFLiBf2osx3aW5KoDHDze6GLMlUlEFi
 vypvcmONSdUKKp4EmOxk+7SCAI9uddQg1JCJClL4h6D1srwe90scgrVAZlyh1/PyftvX
 PPUyj9EjhyVTqRtj1ZYvlR55v3m0JteKcuStlQeKSXqMniwIxS6NJ1AqSq3I36ZxnCuB
 WR9Mnf5o4/XoGYIy5aBPGY0qddY/Bm84PENzUwCzJ9/vCMd/XcnpdRoq4ejGHSrlbY6m
 kKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744882349; x=1745487149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jg9liQY2yP5Kh3RtgdI7xjFe5GA+ZZN449PB22RqFLM=;
 b=cVocbK+EWKRMSF12eUsGO14PV6q3qCafoowjjOJeh2Ioah+rZVAuIqbWVKxZvZmco1
 /8qVzBVy/t97bhzFfP+0mofZvwVKLo9JYwzrBEDqVDdvsxphA7yH6vC7aUk4MrkrXK6o
 4HfGmmFAg8M1Y5UtIC6newhNwzB2ONCL3Sv3zx0VBPG34C6AuYnr1wn+XTucz74ymhVY
 OIJBYcdzjyS5CTSz1IXWHiCEIuMPw0ocHpWlY7BqsbNQhodQRomeVOfhDnmieNMGDYio
 pw6D+zuPe2Ft8d75LJZjyiPb1DIW6MCu8vjxAr/R2JIUeEhMC+ZB0LBNARf2BISDRWuU
 3F0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCULr3JWbe4vOyxVztdIS0ixtm0ZSSoDkImCZAWVtaNZN91YxYLSh8hyV6wkhK04/GVHEqIvq03OoqU=@nongnu.org,
 AJvYcCUnn0DJsfnYM5G8oGR86yOCFfea7aq+ZnASJsbbW15uJwvLwv1jPEtdIHGwwPAUJ3iSP7v+fcOlofI9bg==@nongnu.org,
 AJvYcCVMjy1EuxxoomAAaAzF853gJKZ3b2TbbnAj9BwBczkN3dZz17UCMrxBx2qwjl/j/QYuHrKi4dot/Q==@nongnu.org,
 AJvYcCWSL2fzZbG2E/yjBMcbIc62HQZf/GOqLZJFb7NyBoNWukQYHmFKvvuAsm3RJ1uHPhL98uB8defjr5sf5g==@nongnu.org,
 AJvYcCX7fzgvaqyZTEACqluLWcFNXuBRRp9U7QsmvrXuKReDxYmeikPFSwrXHm92MNAnSQZd+7C8ZoPkDoaozw==@nongnu.org
X-Gm-Message-State: AOJu0Ywe0NVD/0Q5FXi2g8VfBF6p+Rvbc724uPpV37xn+0BaDj2ykCA3
 ySjglQ/gpp1BUuqQuEGYC2up12QM7mCRQ29gQltf+Fi60TEDAhZMkNSJ9MFRHWlj/T3XcLBKjJG
 tOKx1bshxX+FRO14qqfFxbpcqDTj3E6EK+V0=
X-Gm-Gg: ASbGncuuWZ0oMk8ZWyUCtbMORD4EOA2xrVzvA9bSMgp06B6qqwg+IuJaduV843ikgAu
 RIPmAN8BqCHwWvgLi+9h18fS4iuLUkyq90hqDBG8qr/7oKF4xSiR6wbxjQSFzDIMPHe3kM9IcXb
 A8mpA6r45AFb2hIZiasMP4DEGsksx4H2hoiDbzRN+cgP/M7PQX6at1iBO6BGbRm3M=
X-Google-Smtp-Source: AGHT+IF9pYKO14rulbqXlenJvlINTzUJkAGUA0aliek/nHp4sD+sVre5AM6ZYB1ZP7DJitiPcfZ6l9P0Gbm/9bQdhUo=
X-Received: by 2002:a17:90b:57e6:b0:308:5273:4dee with SMTP id
 98e67ed59e1d1-30863f2c4fcmr8184303a91.15.1744882349418; Thu, 17 Apr 2025
 02:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <9da41d784991f77e2c1f38d0781cd047b593e053.1744787186.git.ktokunaga.mail@gmail.com>
 <afe0abf1-2c33-47d8-bde6-8abc722eb212@linaro.org>
 <2d232dbc-4613-4352-8ede-3fd5dcefc32c@linaro.org>
In-Reply-To: <2d232dbc-4613-4352-8ede-3fd5dcefc32c@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 17 Apr 2025 18:32:17 +0900
X-Gm-Features: ATxdqUGGTv3OArB87npbRxwo9F2RaSZjhfG-gwWP-mNK2kFi5AGNRi4plJgSNmw
Message-ID: <CAEDrbUbQ2h1wj-KJqjYjcGPb4Pyp0te8ycy2DoJGENvT2+Mxcg@mail.gmail.com>
Subject: Re: [PATCH 12/19] block: Update block to compile with Emscripten
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009cbd6d0632f61401"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1030.google.com
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

--0000000000009cbd6d0632f61401
Content-Type: text/plain; charset="UTF-8"

Hi Philippe and Richard, thank you for the feedback.

> Actually what about checking the symbol presence in meson?
> Something like (untested):
>
> -- >8 --
> diff --git a/meson.build b/meson.build
> index b18c46d16a2..33185fdf315 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2654,3 +2654,2 @@ config_host_data.set('CONFIG_TIMERFD',
> cc.has_function('timerfd_create'))
>   config_host_data.set('CONFIG_GETLOADAVG', cc.has_function('getloadavg'))
> -config_host_data.set('HAVE_COPY_FILE_RANGE',
> cc.has_function('copy_file_range'))
>   config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
> @@ -2756,2 +2755,6 @@ config_host_data.set('HAVE_UTMPX',
>
> +config_host_data.set('HAVE_COPY_FILE_RANGE', cc.links(gnu_source_prefix
> + '''
> +  #include <unistd.h>
> +  int main(void) { return copy_file_range(-1, NULL, -1, NULL, 0, 0);
}'''))
>   config_host_data.set('CONFIG_EVENTFD', cc.links('''
> ---

Emscripten doesn't provide copy_file_range implementation but it declares
this function in its headers. Meson correctly detects the missing
implementation and unsets HAVE_COPY_FILE_RANGE. However, the stub defined in
file-posix.c causes a type conflict with the declaration from Emscripten
during compilation:

> ../qemu/block/file-posix.c:2019:14: error: static declaration of
'copy_file_range' follows non-static declaration
>  2019 | static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>       |              ^
> /emsdk/upstream/emscripten/cache/sysroot/include/unistd.h:207:9: note:
previous declaration is here
>   207 | ssize_t copy_file_range(int, off_t *, int, off_t *, size_t,
unsigned);
>       |         ^
> 1 error generated.

If introducing a new stub isn't preferable, we could update the existing
stub in file-posix.c to match the declaration used by Emscripten. The
manpage[1] also aligns with this signature.

[1] https://man7.org/linux/man-pages/man2/copy_file_range.2.html

--0000000000009cbd6d0632f61401
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div>Hi Philippe and Richard, t=
hank you for the feedback.</div><div><br></div><div>&gt; Actually what abou=
t checking the symbol presence in meson?<br>&gt; Something like (untested):=
<br>&gt; <br>&gt; -- &gt;8 --<br>&gt; diff --git a/meson.build b/meson.buil=
d<br>&gt; index b18c46d16a2..33185fdf315 100644<br>&gt; --- a/meson.build<b=
r>&gt; +++ b/meson.build<br>&gt; @@ -2654,3 +2654,2 @@ config_host_data.set=
(&#39;CONFIG_TIMERFD&#39;,<br>&gt; cc.has_function(&#39;timerfd_create&#39;=
))<br>&gt; =C2=A0 config_host_data.set(&#39;CONFIG_GETLOADAVG&#39;, cc.has_=
function(&#39;getloadavg&#39;))<br>&gt; -config_host_data.set(&#39;HAVE_COP=
Y_FILE_RANGE&#39;,<br>&gt; cc.has_function(&#39;copy_file_range&#39;))<br>&=
gt; =C2=A0 config_host_data.set(&#39;HAVE_GETIFADDRS&#39;, cc.has_function(=
&#39;getifaddrs&#39;))<br>&gt; @@ -2756,2 +2755,6 @@ config_host_data.set(&=
#39;HAVE_UTMPX&#39;,<br>&gt; <br>&gt; +config_host_data.set(&#39;HAVE_COPY_=
FILE_RANGE&#39;, cc.links(gnu_source_prefix<br>&gt; + &#39;&#39;&#39;<br>&g=
t; + =C2=A0#include &lt;unistd.h&gt;<br>&gt; + =C2=A0int main(void) { retur=
n copy_file_range(-1, NULL, -1, NULL, 0, 0); }&#39;&#39;&#39;))<br>&gt; =C2=
=A0 config_host_data.set(&#39;CONFIG_EVENTFD&#39;, cc.links(&#39;&#39;&#39;=
<br>&gt; ---</div><div><br></div>Emscripten doesn&#39;t provide copy_file_r=
ange implementation but it declares<br>this function in its headers. Meson =
correctly detects the missing<br>implementation and unsets HAVE_COPY_FILE_R=
ANGE. However, the stub defined in<br>file-posix.c causes a type conflict w=
ith the declaration from Emscripten<br>during compilation:<br><br>&gt; ../q=
emu/block/file-posix.c:2019:14: error: static declaration of &#39;copy_file=
_range&#39; follows non-static declaration<br>&gt; =C2=A02019 | static off_=
t copy_file_range(int in_fd, off_t *in_off, int out_fd,<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>&gt; /ems=
dk/upstream/emscripten/cache/sysroot/include/unistd.h:207:9: note: previous=
 declaration is here<br>&gt; =C2=A0 207 | ssize_t copy_file_range(int, off_=
t *, int, off_t *, size_t, unsigned);<br>&gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 ^<br>&gt; 1 error generated.<br><br>If introducing a =
new stub isn&#39;t preferable, we could update the existing<br>stub in file=
-posix.c to match the declaration used by Emscripten. The<br>manpage[1] als=
o aligns with this signature.<br><br>[1] <a href=3D"https://man7.org/linux/=
man-pages/man2/copy_file_range.2.html">https://man7.org/linux/man-pages/man=
2/copy_file_range.2.html</a><br><br></div>

--0000000000009cbd6d0632f61401--

