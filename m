Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22829C25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 09:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8zPA-0002kU-Be; Mon, 20 May 2024 05:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8zOz-0002j7-Tp
 for qemu-devel@nongnu.org; Mon, 20 May 2024 05:33:55 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8zOw-0004t6-TL
 for qemu-devel@nongnu.org; Mon, 20 May 2024 05:33:52 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5238b7d0494so3329538e87.3
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 02:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716197628; x=1716802428; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w2AOh+EoMqmIKnJeq/JoD6gLod5i3xql/C0sFWfSqOE=;
 b=U/gxUCQ203PhtDJJIZ1NfxQzr5sFX1dUy5c124E3iFFpHT0rP5KE1/f5fIE4dQdOfq
 mNpUUNfZzFwZUxKaafiRhv1pLF7q+1QWaJri883qmbp36SupWh/KEzR4zZKcrEWCOGKq
 4xvjJcyVQl3k6zNvbS4ulmoMLzkXg9nIhp/LT53KVckimleZDnXfq3neRFcy1HLer9ns
 wNnSwtD2wYeaaIj1+FQ07cUEDekYWSnwf/NdMqOg/EY2Ev6NzeePc+tj4yf4qwqB9l+j
 iHCEyKaNBfIeYmkkzX162JZbXFAUkw7YfSw5kQpSBZa6bxV4Y0O9ujUBh4dth5tmA+R9
 2gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716197628; x=1716802428;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w2AOh+EoMqmIKnJeq/JoD6gLod5i3xql/C0sFWfSqOE=;
 b=MuNhePw6h3OjA7KYyQF411BBkuCqkDkGVt/rAZhhC5Vh8m6jUNhTiOyWBYzPSjgL4/
 LxYOd6kK+GFax4/2lE4rrweu611TGbgmCmMtAICoNIjd5noIent73Kj+gRt79zOtFpAg
 VfUvfyz5SZ0daqc0tm03hai5P2AoCTQjM3368/SSjeDIeV3+8a/Dtwt82mQ3gB6JHxDX
 WnkNT3U7q7EVL3e4frxffxz2o8mC0+PbvAMoheuG1mMUKje1XveqNAopW357zX5Eeg4A
 xs+kBmif20gBLWLXzBlQOVp/I2+H/1r6Ixy+F0+E9Z77SyYfkjj1VOJaSLXDFooCxNaj
 8QWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1QUjqXTV3gpUOk4zU+y2QYS7sFWV6gSL1jKXBnIo7mEyoxWeQETVgRWnUpbCWL1CMizgtB213uZ/92RUkZgW6aPdVYrk=
X-Gm-Message-State: AOJu0YyYCuxoRDpi17Y/wu3JU2Nw8Nzdjce3NPb0FRNP8QEJGp1ytc1Z
 fAo/HLKR2S31g6BSW21imXjPSypf3xnzrsAu43A2oTF05CB7XlcsveBFHKu3eANP7k81qYkHOy9
 mAmZsS3ZorZlMQPQimPbWTboD3hVqJHTCIk14tg==
X-Google-Smtp-Source: AGHT+IG6CLQT4EmHWhDmPbA9gQoU9CUSKWxZu4+j5OI3WadQe8u9ckiflItR/PwQCeAW6EP4F9B3MPp+UfL32kPe/CU=
X-Received: by 2002:a05:6512:63:b0:51f:ffa:d6f7 with SMTP id
 2adb3069b0e04-52210277ba5mr22603552e87.59.1716197627633; Mon, 20 May 2024
 02:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240423063234.76282-1-rathc@linux.ibm.com>
 <20240423063234.76282-7-rathc@linux.ibm.com>
 <D1BXJXYYCCJF.1KUFFHK83W8CV@gmail.com>
 <eba18599-1e0a-4b57-a728-b5a7847e4f14@linaro.org>
 <D1EAEMSLTZZO.19107537679QR@gmail.com>
In-Reply-To: <D1EAEMSLTZZO.19107537679QR@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 20 May 2024 11:33:34 +0200
Message-ID: <CAFXwXr=xC8g=qM-A1zgzM4ipWySJ6dnaUxn8n_fvASfRsdvUXg@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] target/ppc: Move div/mod fixed-point insns (64
 bits operands) to decodetree.
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 "open list:PowerPC" <qemu-ppc@nongnu.org>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000f5c9110618df65e6"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000f5c9110618df65e6
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024, 09:18 Nicholas Piggin, <npiggin@gmail.com> wrote:

> > That's another option, yes.  The decodetree script will take multiple
> input files to
> > produce one output, so you could separate the insns by base vs 64-bit.
>
> Thinking about it a bit more, I guess the downside is that you
> would usually like to group instruction variants that operate on
> 64-bit data together with the others in the .decode file.
>

A third option is not too care as much about minimising the ppc32 build and
include all of the helpers all of the time.

r~

>

--000000000000f5c9110618df65e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Mon, 20 May 2024, 09:18 Nicholas Piggin, &lt;<a href=3D"mai=
lto:npiggin@gmail.com">npiggin@gmail.com</a>&gt; wrote:</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
&gt; That&#39;s another option, yes.=C2=A0 The decodetree script will take =
multiple input files to <br>
&gt; produce one output, so you could separate the insns by base vs 64-bit.=
<br>
<br>
Thinking about it a bit more, I guess the downside is that you<br>
would usually like to group instruction variants that operate on<br>
64-bit data together with the others in the .decode file.<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">A third option is =
not too care as much about minimising the ppc32 build and include all of th=
e helpers all of the time.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">r~</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
</blockquote></div></div></div>

--000000000000f5c9110618df65e6--

