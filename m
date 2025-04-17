Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D2FC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Ln9-0002qb-5X; Thu, 17 Apr 2025 05:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5Ln5-0002pL-GF; Thu, 17 Apr 2025 05:44:15 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5Ln3-0008JV-L5; Thu, 17 Apr 2025 05:44:15 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b061a775ac3so463169a12.0; 
 Thu, 17 Apr 2025 02:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744883050; x=1745487850; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PA0EhDX6QJBxQ9JHECAPsX3Ldf9jQbhyeu8Jda0RX8k=;
 b=fc4LL/s9DEUAEUW8Ajqi65w4tO5wCgA37GEcGoQi7BKpmJEZ2a24q3NjNdfF1IydId
 cDkepCD4ImV9MPrsAaC7owErhr+6Tvm1q0iQQoDgXHUHlyNvCquqX7zH9js1yCMSDC20
 JTXnCFXNq2T+KxFdkVk2UU6KMEgzGXeoQYbEIGwVy+S+ue2aehJwIsivNN2N6lALTcRQ
 3tM8A7siQYRNhwQ69+pCCG1p8J3f4VI6xv+CHgMjBYq74e2Rr3rLC71i3s76ZWorJwuy
 FjYt2x/tx0WmiRToPGoGVkMrvMTSo1pFL3eVJcHCMkA+Cdz2R6cXAbcpCrwtnDJceCrX
 H2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744883050; x=1745487850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PA0EhDX6QJBxQ9JHECAPsX3Ldf9jQbhyeu8Jda0RX8k=;
 b=QSmf8E8I61Euc4YxJuwKlz9a7yohSabb4DyaOux8PVlyJgdB6SAekoUnUb8KUGKPMz
 WvOiCgb5O4jgym7FRQKaNt+iONIQD2NNrHSUKo4ayG9D6Ld03/D796CPP0S1qc8Fm0Ln
 n6pQWjt9RwWucnbyJkieInBr1InK82jyig5rkKs7AaLGFRy+Q60QL3CCphkGdjrBGlMM
 DvJZBsTnXz7GJsjP9fM0bBjcD3BfUkefFPWQ6ONEM9nB3pHx3Yctg8TyBbqNw879KN7y
 wOVnWYHp/PNSuXztBlVQ27mhs2g6Tzo+3nQ1yhptZdbiH9whTRWsWyZavdhG12YK0ZZl
 7aJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAPpsh4IbJ0KuzeW0tCsNYX1mSaDojiMFG91g8jG26pUilyBo0gjbY2uBVaDpAhgLGT1kHztXIha316g==@nongnu.org,
 AJvYcCVd52oHbwhFWtM3vUmn9wBhtWhJjk8utZabBs5fWRm7SfkKrzwI9na+D4Zggo2LuKl+CFklEbvsy+bWuA==@nongnu.org,
 AJvYcCVysYRtRpXyV57Xf2RKoP5X8JCyqlLVowWjfOQur8UH68rkIwLXDOA6KQni3IXfhDnfIKMn3o3E4VRWGg==@nongnu.org,
 AJvYcCXGO6FauVxqDWe0ntRHyHX8Lka0IBR7Cff2A247ZaIkGgZrIAS+8gpxdj/J7rLQoDJTMEm5K4VRXiE=@nongnu.org,
 AJvYcCXIgqmZRB0smcIVKFa5FQKE+JOXrmJhcyKmQdnGQqR2hgSe/E1JDdz9OzJnh/L9yJc/4IwBWgtjUw==@nongnu.org
X-Gm-Message-State: AOJu0YyJl3v6kUqW1AUCoZYnqHRK//x3MEy15Ry7yxRSdOi/zgkeR3zc
 4rr7kcgbCiYqJCaL5r6c66kW1IqB7X6RrGmB0sUgN4Hfyr0bSBuiz9jApfqolqJVVMVAHttCV8d
 TL5nLxhUx/cVBIkaI+qUKq/dDSgs=
X-Gm-Gg: ASbGncsq8XzXgrYvU9S+tUuRlEpjxU572e+X80xXYS52BjjHJW87K95ZqvPNhCcADRB
 1eClxaxZlRzv4bPjGVwFHhiH+H331/3MO1PKK3Di3v4UmOHECKTq1Blja/VHH90ArEKfANsUnxL
 1ncA8f+XGZE4fKX9r9q01riUNL87wK/5h8Ql3QiBjFLleUWqeGxBPjKw6gMMeU+6o=
X-Google-Smtp-Source: AGHT+IHP+JdDahQbg6xYUOyNaJJYXnktpp96kZVSTGHw6qU/aRtTi9EOIC5ZHd/OTbOGXwEL72s43vG5bJrGFksqvzE=
X-Received: by 2002:a17:90b:2751:b0:2ee:db1a:2e3c with SMTP id
 98e67ed59e1d1-30863d1de40mr7383316a91.1.1744883050265; Thu, 17 Apr 2025
 02:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <9da41d784991f77e2c1f38d0781cd047b593e053.1744787186.git.ktokunaga.mail@gmail.com>
 <afe0abf1-2c33-47d8-bde6-8abc722eb212@linaro.org>
In-Reply-To: <afe0abf1-2c33-47d8-bde6-8abc722eb212@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 17 Apr 2025 18:43:58 +0900
X-Gm-Features: ATxdqUH24IWgEAi8slkXOhtMExdzhUW_bsxEeDlGrnxlTkQ4nrqfQ0a-aKKUpPM
Message-ID: <CAEDrbUZwqRnxhxAfSJXPHqpAiYWwxo0+QNP311H2H6rX8Tyjpw@mail.gmail.com>
Subject: Re: [PATCH 12/19] block: Update block to compile with Emscripten
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
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
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000062c6830632f63e52"
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x530.google.com
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

--00000000000062c6830632f63e52
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

> I'd include in this patch this hunk from patch 17:
>
> -- >8 --
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 63392f5e78..4fd4d362f9 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -89,3 +89,7 @@ if have_system or have_user
>     stub_ss.add(files('hotplug-stubs.c'))
>     stub_ss.add(files('sysbus.c'))
>   endif
> +
> +if host_os == 'emscripten'
> +  stub_ss.add(files('emscripten.c'))
> +endif
> ---

Sure, I'll move that hunk into this patch.

--00000000000062c6830632f63e52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,</div><br>&gt; I&#39;d includ=
e in this patch this hunk from patch 17:<br>&gt; <br>&gt; -- &gt;8 --<br>&g=
t; diff --git a/stubs/meson.build b/stubs/meson.build<br>&gt; index 63392f5=
e78..4fd4d362f9 100644<br>&gt; --- a/stubs/meson.build<br>&gt; +++ b/stubs/=
meson.build<br>&gt; @@ -89,3 +89,7 @@ if have_system or have_user<br>&gt; =
=C2=A0 =C2=A0 stub_ss.add(files(&#39;hotplug-stubs.c&#39;))<br>&gt; =C2=A0 =
=C2=A0 stub_ss.add(files(&#39;sysbus.c&#39;))<br>&gt; =C2=A0 endif<br>&gt; =
+<br>&gt; +if host_os =3D=3D &#39;emscripten&#39;<br>&gt; + =C2=A0stub_ss.a=
dd(files(&#39;emscripten.c&#39;))<br>&gt; +endif<br>&gt; ---<br><br>Sure, I=
&#39;ll move that hunk into this patch.<br><br></div>

--00000000000062c6830632f63e52--

