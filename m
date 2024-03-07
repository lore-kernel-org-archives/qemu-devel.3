Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A8EC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 19:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riJIp-0000Y9-Lt; Thu, 07 Mar 2024 14:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riJIm-0000Xx-MK
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 14:21:12 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riJIk-0007bK-CH
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 14:21:11 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-412e96284b9so10228025e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 11:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709839268; x=1710444068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slxTRvQO0SUX++VBzb8jv4pLcLZ+dy65xCDb0HL6744=;
 b=xRERtFkekCNuQzpg4Vyb7xUYNemP0n92Ehj0ylfzS2HcruUhWhQW8D0bove6wJt7OT
 /NAbHnB0rl44RK+P5dYxMp0rDYZ3u3rRVlXGp30sDE4KklXQTCAsgMT+7TxnbGc3orLS
 sMTz9jXXif9EdJWbrCP9Qgpj20e21HKapNw2QvgJy+pXCDq2KDq9s7du7GM4gexBmyO1
 Rhh525GjpJyT2Ip8E6Gt632EnRPttPuhDbOfZO9nM11tto7iP5woE0XigwrJttU5HNyR
 oPhirzah2GIh1I+ZNZqT77fI/RvTRapkbECE4Hxd9yDA7NUtJubYvSsJ93Y5pfdWA/o+
 dkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709839268; x=1710444068;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=slxTRvQO0SUX++VBzb8jv4pLcLZ+dy65xCDb0HL6744=;
 b=XgUjjrJ9ZUcfg1uAHSJeerEroU6QLyIlj3X6S887eApLRv28lOk4sxDlhuyLHmONrR
 tTXiULIANP8LPmAvTAqyFJEZnLWWcfebyBHFp05WpThIPyEh1TvvlfXK5buvur+Ocpvu
 L85gISm761ha/Z7mWiQ/46sXEMU5h0az3x/tcMWJcSFmeKjFJhAec+gn9ZJTRya3+Yhl
 rzGFSd9cQjNIF+VFWQ9RPK2+rP+PIv8PudcpQcsLXdBLlvcIZhfqey69oMFu+dnV4EXg
 4ohaLujjgJ7R+Do2yDzdkvou01X242+bciy8D8n4cH/zWlJt6UkLKcSNzOyhBsAGcl/u
 kEyw==
X-Gm-Message-State: AOJu0YxtnnFbpp3xEx3QoEBUn59LdrfFHWybkbBMaXOAqkEsb+sLXsig
 5DfZjf3JnGpyoEwvqnTPmSwoE0w46XxVoRH52z+y+BB1rwDCzGYzUs+JMMJLOI4=
X-Google-Smtp-Source: AGHT+IGv9zT7JDhhG5HBpsVfhJcqKRQfIspWGXgz/1f4UlLNU9YPtXpmCBIROlpLSMA99ETvb9KHRg==
X-Received: by 2002:a5d:6252:0:b0:33d:3099:e67b with SMTP id
 m18-20020a5d6252000000b0033d3099e67bmr12965218wrv.63.1709839267702; 
 Thu, 07 Mar 2024 11:21:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c14-20020a056000104e00b0033e72e104c5sm728440wrx.34.2024.03.07.11.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 11:21:07 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0B9CF5F7A7;
 Thu,  7 Mar 2024 19:21:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 peter.maydell@linaro.org,  laurent@vivier.eu,  philmd@linaro.org
Subject: Re: [PATCH v2 2/5] linux-user: Move tswap_siginfo out of target code
In-Reply-To: <20240307182623.1450717-2-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 7 Mar 2024 18:26:20 +0000")
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
 <20240307182623.1450717-2-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Thu, 07 Mar 2024 19:21:07 +0000
Message-ID: <874jdhvof0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Move tswap_siginfo from target code to handle_pending_signal. This will
> allow some cleanups and having the siginfo ready to be used in gdbstub.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/signal.c     |  2 +-
>  linux-user/alpha/signal.c       |  2 +-
>  linux-user/arm/signal.c         |  2 +-
>  linux-user/hexagon/signal.c     |  2 +-
>  linux-user/hppa/signal.c        |  2 +-
>  linux-user/i386/signal.c        |  6 +++---
>  linux-user/loongarch64/signal.c |  2 +-
>  linux-user/m68k/signal.c        |  4 ++--
>  linux-user/microblaze/signal.c  |  2 +-
>  linux-user/mips/signal.c        |  4 ++--
>  linux-user/nios2/signal.c       |  2 +-
>  linux-user/openrisc/signal.c    |  2 +-
>  linux-user/ppc/signal.c         |  4 ++--
>  linux-user/riscv/signal.c       |  2 +-
>  linux-user/s390x/signal.c       |  2 +-
>  linux-user/sh4/signal.c         |  2 +-
>  linux-user/signal-common.h      |  2 --
>  linux-user/signal.c             | 10 ++++++++--
>  linux-user/sparc/signal.c       |  2 +-
>  linux-user/xtensa/signal.c      |  2 +-
>  20 files changed, 31 insertions(+), 27 deletions(-)
>
> diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
<snip>
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -409,8 +409,8 @@ static inline void host_to_target_siginfo_noswap(targ=
et_siginfo_t *tinfo,
>      tinfo->si_code =3D deposit32(si_code, 16, 16, si_type);
>  }
>=20=20
> -void tswap_siginfo(target_siginfo_t *tinfo,
> -                   const target_siginfo_t *info)
> +static void tswap_siginfo(target_siginfo_t *tinfo,
> +                          const target_siginfo_t *info)
>  {
>      int si_type =3D extract32(info->si_code, 16, 16);
>      int si_code =3D sextract32(info->si_code, 0, 16);
> @@ -1180,6 +1180,12 @@ static void handle_pending_signal(CPUArchState *cp=
u_env, int sig,
>      /* dequeue signal */
>      k->pending =3D 0;
>=20=20
> +    /*
> +     * Writes out siginfo values byteswapped, accordingly to the target.=
 It also
> +     * cleans the si_type from si_code making it correct for the target.
> +     */
> +    tswap_siginfo(&k->info, &k->info);
> +

I'm not sure I like this, you have the same pointer to both a const and
non-const arg. Do we assert we come through this once per signal and
don't risk double swapping the contents?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

