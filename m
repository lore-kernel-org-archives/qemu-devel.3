Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB029CA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmpi-0001bs-Iz; Wed, 03 Sep 2025 08:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1utmpd-0001a9-18
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:43:21 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1utmpb-0006lG-9Q
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:43:20 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-74548a0b81fso4160548a34.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1756903396; x=1757508196; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TD7RSAs8lK0s4scvG5RhyQOCx+tpakZ0/0Gex9hKCn4=;
 b=RbDzgZZ9htmiDd+GMCYAlSq1Xs4wsEAnI/YmeJ5CSx/obTPg6m4dvNGEqE3UM3OpBT
 N5r2DFt+44EDEVHpAVcXZ/GdxdoKVzot/LMLL8QDquI6jmEBQSg4flzZ3N4SVr1GXQ7M
 /ZqMPUGrVZqK/l9cOyXowCw3wtFSVyHR5Of5eWVIYM2JWtJRjv4lP9xw/tnq4452Uq47
 opWxo1yQWfoHkob+Pj39ADQP7H8aK+UVkgP+XVe6m5FQQh7sG3fXvhlZBd4LWvAads+i
 KLBET5KKZfsN9jmCWI0TLim3rtg9eBVOMb+V3n5oBZ2Wnm8Vkf6ZUGC1iEpkUW8hrlkn
 +cBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756903396; x=1757508196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TD7RSAs8lK0s4scvG5RhyQOCx+tpakZ0/0Gex9hKCn4=;
 b=fHCX79quz06By9XgYtcjKSYcWErPHi+LMmoH0Co5qXqBhmpAUU1xCNf4tbRNQ9RHnT
 jpfvZ2tiwkP35YxDCoszzO1mXeoI2g9qQkWSkFuH+TEba5ZaGrP1A+u/gFRPkVpL5tk+
 qjYKoaYy4VlXojiThEo2CVUn3+W5OOB+9NrBanS45qB8zADkHXpIN5Tn5oe1uaxxfPji
 7VHz1svpA88Hzgi2eKjIMXG1p6trUAqfaYO11oUa4uQgq0l6bGMdWaMv5KdnCPvRmHzh
 qWv+55s7hUDgo8MTI33ShcAfcj0trwG0f4GfBkh2yO7QoHPRc0MgYzj7nyypnGLCJX43
 BPwQ==
X-Gm-Message-State: AOJu0YyOwo8/4vb2YLiC/6t/J40+2AC2oETnEFhU9Rz0DtjFuy2lFC0J
 Ca+TaulXO9EvapA2WMPU/pQrSr8l2cxKw4iHSBuV8NxPA3TK8tZKuEEJCoFSLQdUXqtKxnWdY42
 QqTl8WWH0OfXoNisVjbWZhbG3rUk4AQyyxzR6X76XSQ==
X-Gm-Gg: ASbGncvvbb0yLw6pHSd6p0OrWxKnVjbgRBUdXUfJQQG03fCnRqZuoc29S03bY6TOr4r
 XMWZ6A3mihl8z4PlxMmhodTqfUNvkqoVbaS9g+q7pijsn8741HqgegaesxZfBwnHwZmkmdaY57r
 9egFGBFG4ELSucKugikp6ngrsUH7M25UfbXHj+w/qMsFucPls6nzTvil8izRce2AvecHUe51Acf
 VR7kehWgudTsZGZ2M8=
X-Google-Smtp-Source: AGHT+IH0gwnZfk1Hv7CKxrbUsBX1+Qoh3OYSq8nf8z4JE73WOKPJ6R0d90fu/I/2U1NpsN2xkT7sSpiBQucDangVK/M=
X-Received: by 2002:a05:6808:48d4:b0:437:e5d6:8c2d with SMTP id
 5614622812f47-437f7d20d05mr7031028b6e.2.1756903396593; Wed, 03 Sep 2025
 05:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250901133815.1693077-1-max.chou@sifive.com>
 <20250901133815.1693077-3-max.chou@sifive.com>
 <5d0fe741-9063-441d-8abc-3bb0662c1fbe@linaro.org>
 <CANiaA1sP1KvhFhOOZRYJPzb=cf1DwTJNMTgEx5j2oppFNj6mdA@mail.gmail.com>
 <54f806ed-a393-4ced-8343-877e5e76c586@linaro.org>
In-Reply-To: <54f806ed-a393-4ced-8343-877e5e76c586@linaro.org>
From: Max Chou <max.chou@sifive.com>
Date: Wed, 3 Sep 2025 21:43:05 +0900
X-Gm-Features: Ac12FXxJLhlDfUreUqcK8CJDePN7D4TV6viaCWLTkscTaIRmY7oSO7oqXNlOnCQ
Message-ID: <CANiaA1veZq2YLg1E-3RjH8aZd91nck6XCoq3YdKrszFfN7gBUw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] target/riscv: rvv: Add Zvqdotq support
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000dbe88f063de4f215"
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=max.chou@sifive.com; helo=mail-ot1-x331.google.com
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

--000000000000dbe88f063de4f215
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 12:43=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/3/25 02:26, Max Chou wrote:
> > The partial_sum and the final mask are created to ensure the behavior
> described in the
> > Zvqdotq isa spec section 3 as follows:
> >
> > =E2=80=9CFinally, the four products are accumulated into the correspond=
ing
> element of vd, wrapping
> > around signed overflow.=E2=80=9D
>
> This is accomplished by the -fwrapv argument to the compiler, with which
> all of qemu is
> compiled.
>
Thanks for this information. It=E2=80=99s helpful.
I=E2=80=99ll update version 2 to include this part.

Thanks,
Max

--000000000000dbe88f063de4f215
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>On Wed, Sep 3, 2025 at 12:43=E2=80=
=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
>richard.henderson@linaro.org</a>&gt; wrote:<br></div></div><div class=3D"g=
mail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex">On 9/3/25 02:26, Max C=
hou wrote:<br>
&gt; The partial_sum and the final mask are created to ensure the behavior =
described in the <br>
&gt; Zvqdotq isa spec section 3 as follows:<br>
&gt; <br>
&gt; =E2=80=9CFinally, the four products are accumulated into the correspon=
ding element of vd, wrapping <br>
&gt; around signed overflow.=E2=80=9D<br>
<br>
This is accomplished by the -fwrapv argument to the compiler, with which al=
l of qemu is <br>
compiled.<br></blockquote><div>Thanks for this information. It=E2=80=99s he=
lpful.</div><div>I=E2=80=99ll update version 2 to include this part.</div><=
div><br></div><div>Thanks,</div><div>Max</div></div></div>

--000000000000dbe88f063de4f215--

