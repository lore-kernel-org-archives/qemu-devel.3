Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2908CD68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC0Cn-00054h-9z; Fri, 15 Nov 2024 12:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tC0Cl-00054G-9C
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:33:59 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tC0Cj-0002W3-NZ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:33:59 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cefa22e9d5so2326513a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731692035; x=1732296835; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0PA7SXM7Hdt7q7y4slXT17KRI24/od2RXZ4c8SxZk8=;
 b=ZNJByGvYkJK+LKXow1Ev/BovIHonNnwV+GzHZDhoSgomBbVAFcpTsTLdCP1jK7WJEp
 J50EmLj6j6hvdRpIpKpzfKLlENxx7aO7Zg5MGdWvyeGSIN7B+Z+ehUfy201Ywb2NL7hG
 nCeHBlKXm3uu814kQYMPRFguLMpO0AapUF6H6wCARmjO+kS2A3lGp573GnYGyU6IJx70
 tS6N/+KNF8GW6FB9lmPtYsYDyLEsErOECXxKAMXyVcDT+jhKaF+QmZcY1E/Mkr5TcwYs
 fld2JojufrXJN4N+tlc5Ac4ikIMwdXsbx3ErQeLAKlaev7jq+/4Qz/zpvECPe0+2ks3S
 YlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731692035; x=1732296835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0PA7SXM7Hdt7q7y4slXT17KRI24/od2RXZ4c8SxZk8=;
 b=fqr9bL6+COgLbZgt6H1COrTevawXVJGv+0OdtRzQ+/c6EMWzL7YYeYqZO+WGnj/d2V
 S9pAIcuyX+6BcuKrSUhwpeDv6/c/GvObgxHNjjr/owkWXEcXuXgGaWswPQXvBgaQ8tpK
 NoU5PhJHv1kpX6ZRFkPR5fYOkIGoK6dUvFCefk/KnsAklBL83g9Z+dQVx6+lqFbOEw8/
 /3sGdQGsC2Fjin5FUpkG2GkQ1R7WwfYyHzPuZpIvGJer0NZzucOS5hPQRnbu4MfoqVA5
 IRxOnuKaAFzZtS4YNU+YX+sxpv3PcgptMWSRCwobDws/4bUEqw/OHdv6bJZGcJFaSccT
 g8zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxTzRERumdgoZFbYT5dqXWURju2pMV5kySZPc9CMiXkXUKunPtUPRReiLRA+mtElJaANgS8OPkNMjX@nongnu.org
X-Gm-Message-State: AOJu0Yy0gLEvmYV6uagwoXD2NCrNrvCxvWXk6Wx3sREutAD3/a9Kgi5P
 VBfSmGpSnjQIIL4iIoToeVPqtVtR/N+bicGVlNyQonenzTp7/NnhPaBDhA7nDI1XY6dFLjjn+i4
 RjyugfsdANQtH5VCEYFkdcOxC9Xb2Drhl2qGhKw==
X-Google-Smtp-Source: AGHT+IEx9Uz0HD9h7iVOfgH+b+YmNiTQuxGr8Pr8by9Lj2+aSIJnz3TYnPgUpEEASKDpGRC4cUaTgXVHH8qm5UtDxKo=
X-Received: by 2002:a05:6402:1d50:b0:5cf:45d4:3f8f with SMTP id
 4fb4d7f45d1cf-5cf8fc396d2mr2464739a12.12.1731692035419; Fri, 15 Nov 2024
 09:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-7-philmd@linaro.org>
 <9796cc60-5efb-4a2d-9437-4832a6c43edf@linaro.org>
In-Reply-To: <9796cc60-5efb-4a2d-9437-4832a6c43edf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 17:33:44 +0000
Message-ID: <CAFEAcA95k0yX+jns13qx0j+u0aJUjYpaqyDX-y-Cd8xQ4Z9kUA@mail.gmail.com>
Subject: Re: [PATCH 06/10] accel/tcg: Remove cpu_unwind_state_data() unused
 CPUState argument
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 15 Nov 2024 at 17:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/15/24 07:20, Philippe Mathieu-Daud=C3=A9 wrote:
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   include/exec/translate-all.h | 3 +--
> >   accel/tcg/translate-all.c    | 2 +-
> >   target/i386/helper.c         | 3 ++-
> >   target/openrisc/sys_helper.c | 7 +++----
> >   4 files changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/exec/translate-all.h b/include/exec/translate-all.=
h
> > index f06cfedd52..9303318953 100644
> > --- a/include/exec/translate-all.h
> > +++ b/include/exec/translate-all.h
> > @@ -23,7 +23,6 @@
> >
> >   /**
> >    * cpu_unwind_state_data:
> > - * @cpu: the cpu context
> >    * @host_pc: the host pc within the translation
> >    * @data: output data
> >    *
> > @@ -32,7 +31,7 @@
> >    * function returns false; otherwise @data is loaded.
> >    * This is the same unwind info as given to restore_state_to_opc.
> >    */
> > -bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t =
*data);
> > +bool cpu_unwind_state_data(uintptr_t host_pc, uint64_t *data);
>
> Hmm.  I wonder if it should be called "cpu_*" at all then?
> Worth renaming to "tcg_*" or something?

Yes, it's odd, isn't it?

What's the plan for this function in a multi-target
emulation world? At the moment it (or functions it
calls) uses TARGET_INSN_START_WORDS which is a
target-CPU-type-specific value. If in the future we're
going to want it instead to look that up as e.g. some
property of the CPU class then maybe we should keep
passing it the CPU pointer? Or would we instead say
that we'll define TARGET_INSN_START_WORDS as the worst
case for any target, since it's always between 1 and 3,
so it doesn't waste that much space if we have a couple
of extra sleb128 zero values for targets that don't need
all 3 words?

thanks
-- PMM

