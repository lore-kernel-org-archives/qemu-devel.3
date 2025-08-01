Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D83C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpNf-0004fr-Ez; Fri, 01 Aug 2025 09:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uhozB-00086h-2r
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 08:35:45 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uhoz7-0006DN-Px
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 08:35:44 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-af913d9d2a1so316060566b.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754051738; x=1754656538; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CT1PMrz4B6Io7IHxrrXB1D/jUOE0VZNJTRC4BpMLJfQ=;
 b=p41XfD9Bg2oAG/n1Ykb2z3AFexeJW6p4i1l6z8b39EYzx/mQkRcCXDNRiMt3UBsBGK
 qvpAu4Rk2VaUIFkQ2f+WSlMBx8Wk9S1j4uD8llQnnxEImCCzykWel04ySZ7teTBFNRKV
 yfxMLogLPwg2w5bmisEPg1sqWeLK0LRyNrcr2quDmZ2TNREVNe5JurtL6xsSS9w2n77s
 u6UMYKpEwgKeP6br7bwsrb5hDW3uJzKvlK3EJWGLYcAXxlQ/HnNmrzJol7MCf6LHlRJu
 otuUU3gx4wRenkiK8QOt6g3kB+bzCf51EmxzYLsuDW1myxW2ULMhPrpBBeKSIXhZhVc4
 l+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754051738; x=1754656538;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CT1PMrz4B6Io7IHxrrXB1D/jUOE0VZNJTRC4BpMLJfQ=;
 b=LGwlYlixzQJGfEg2szPZLDnuN7QPzLVQzgBLB95gneCFze4977dOTK7d4y+zqcGjb/
 gKZ/ktA9gDeRsvlXav8RIPi2Azs+9cQz5bssAEGnOyjnJjU+10a1p+dY3gf5wovTr5iE
 X9aCrM96hFoVjIEFZ8IrziPuJAXUVkaCCNe7Xu4/v9dPCFAdiKlFQYCyq7J5+EIeX4aF
 l+RERfwpHDXvVoZ0Y4qyOrMcT8ts6KJAKGv0tGJlQROrXWrw4c62d/MPbvjcgbqyStL4
 2APhOZli1l/tREKBK6EbalRufFYeHM9GWPURmsbUy1yR7X48Q4LsRafYcfeiD6VWtj+x
 wmig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXTu+DTn0octV3l8xZnPXAa6BTKaEKLNK1IFRbue0qiW055hsqnuWjlL4HqEs5HEYOexxw7h9E5noQ@nongnu.org
X-Gm-Message-State: AOJu0YxcxXOs5qx19s1ZzstwxzLY14rM0dZeLKz90KmJf3OrCH/Qt9QR
 c45AgFvmmJs9ysx/ppds02otTL7UkgNN4h3cuD+s13KA//Ce2IcLkhCr11wqGY3NwAANoV4bfu+
 qSCraDnP/iw6yGlKVF3JNjGcBA7GRb+1SnTd/J3G2PQ==
X-Gm-Gg: ASbGnctftmaYNAVYUyCmIOlE1881tblvNz4uppw3ohCU8j5HBkN+o+Fr+qONkaq8v7L
 eQlIZm7NBaZVI0hRKpVSz1WSz67+KBu7J1QNiIoc+n3KtUhJJCn6vkuTYDYv6zS6Ta2bfJBGtG3
 XeKErdMm2lRlUsd/e2K+X8XMWpDKXSzik66W1C41ziMx0J6SQa4azuGr9jOvurcEWIZxGPQq/qh
 eIGdrMecEbGy9Fc1Q==
X-Google-Smtp-Source: AGHT+IFqRa6oJ+pwx3XYtHNNxqPfFmo41SZ0yGU3QmyWAVaenGaFm9TL8p7SS0BHsMQbyK4fArHiMNZ/FhDODDubd7Y=
X-Received: by 2002:a17:906:ef0b:b0:ade:409c:2cb6 with SMTP id
 a640c23a62f3a-af93196cf84mr302253966b.59.1754051738096; Fri, 01 Aug 2025
 05:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-48-richard.henderson@linaro.org>
 <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
 <f198153f-088c-4196-9ee2-ed1e8e4fc92f@linaro.org>
In-Reply-To: <f198153f-088c-4196-9ee2-ed1e8e4fc92f@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 1 Aug 2025 15:35:11 +0300
X-Gm-Features: Ac12FXxO5CfGPBoAxm3AyJ38bWWFz7PMPhG6csPzhc5qFaePF48uMXRC8i2QldI
Message-ID: <CAAjaMXZvwq=gikvqrEQCZWFnU9mt5cYn84uxuLyCAbQqEEnXag@mail.gmail.com>
Subject: Re: [PATCH 47/82] target/arm: Expand pstate to 64 bits
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 1, 2025 at 7:25=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/1/25 05:13, Pierrick Bouvier wrote:
> > On 7/27/25 1:02 AM, Richard Henderson wrote:
> >> The ARM now defines 36 bits in SPSR_ELx in aarch64 mode, so
> >> it's time to bite the bullet and extend PSTATE to match.
> >>
> >> Most changes are straightforward, adjusting printf formats,
> >> changing local variable types.  More complex is migration,
> >> where to maintain backward compatibility a new pstate64
> >> record is introduced, and only when one of the extensions
> >> that sets bits 32-35 are active.
> >>
> >> The fate of gdbstub is left undecided for the moment.
> ...
> >> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> >> index 64ee9b3b56..3cef47281a 100644
> >> --- a/target/arm/gdbstub64.c
> >> +++ b/target/arm/gdbstub64.c
> >> @@ -47,6 +47,7 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByt=
eArray *mem_buf,
> >> int n)
> >>       case 32:
> >>           return gdb_get_reg64(mem_buf, env->pc);
> >>       case 33:
> >> +        /* pstate is now a 64-bit value; can we simply adjust the xml=
? */
> >>           return gdb_get_reg32(mem_buf, pstate_read(env));
> >>       }
> >
> > If I'm correct, we currently don't expose PSTATE through gdbstub, but o=
nly CPSR. This was
> > a bit confusing for me, considering that CPSR is not even supposed to e=
xist in Aarch64.
>
> Correct.  An old error, for sure.
>
>
> > Maybe it's a good opportunity to expose PSTATE instead, which could hav=
e a 64 bits size.
> > This way, we don't break any workflow.
>
> Hmm, perhaps adding a "org.gnu.gdb.aarch64.pstate" xml with just one 64-b=
it value is the
> best solution.  Thiago?

A single line in gdb-xml/aarch64-core.xml should be enough:

  <reg name=3D"PSTATE" bitsize=3D"64" />

I'd keep cpsr even if it's now effectively duplicated. It comes from
gdb's upstream aarch64 schema so it's deeply ingrained by now.

Then you can do `info registers $PSTATE` in gdb after adding the reg
getter in gdbstub.

I think it could be possible to define a

<flags id=3D"pstate_flags" size=3D"8">
 ...
</flags>

type that re-uses the cpsr_flags type definition by setting a field
<field start=3D"0" end=3D"31" type =3D "cpsr_flags" /> but I haven't tried
it.

>
>
> r~
>

