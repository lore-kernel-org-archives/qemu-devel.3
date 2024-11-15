Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8F5D68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tByZB-00065i-V1; Fri, 15 Nov 2024 10:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tByZA-00065Q-2a
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:49:00 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tByZ7-0001Ly-Mx
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:48:59 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cf8b788f5fso1384865a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731685735; x=1732290535; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3oLIbhbGFpIagNbl8SS3tL7w2DT7PFMChyH3XEb9kX4=;
 b=NDAwNWLbQCd7zU3IR7upkYROUWlj5pGnjsRJ6rKOYOOpbR/gw2UiuclSDvhsYCT7Er
 Rwj/N2o1th9yDh0EKpUBNlRSFh9+/TMCz1PiuAlnf4Z1lyClefcEVaTc93twXRv7gV91
 Lb9gCR60Z+04JvSPCz7cRONsBOSsL4D/Fzo+wdh4fMM6+qJWB8Ux3ALsE3RVPHbL6d8u
 By62VsXfnovXffqqo4dYbbDfT11Yr6LElRBgYc33YDtY2CmsdCZdvvpm5hpYS4hC1KEV
 npsffgfhRUjWsD0CM64j+t85MLok+uOB28ZVbkibbOzupklwCpA7lTtLM6+UGuWhZEyl
 97zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731685735; x=1732290535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3oLIbhbGFpIagNbl8SS3tL7w2DT7PFMChyH3XEb9kX4=;
 b=gPctpFTcq8HAtcKD/NIBVDDVz9dwnEZwvMDW9pDFS8OrRmS5S/l29KzqlEml1n/25B
 xBJdshwa+TP1QUnGOpXfP5iRpi/fS5jS1mXVvbyj4+dpdNPiaSSf0tcjWeldYZA7UmO5
 t+6njIp2WpRjH2GmCdX+K7goL4QcadYKifIemj4bvxzuF+m0Wmsdg/ZYt7iTMNFLbApf
 DUsmUNlpQaPB/FmqNxU4yBcTNMdpDLPJnLNZmCFK1iKmv3OYMeGYiNqSms1etKrBYqmX
 6FUXc55ILwT0C3hwt78l5nrTyPhvjgEXJSk1Ws9bloNnevizPpXlLW2ZrGHszJZ4tkUS
 sClA==
X-Gm-Message-State: AOJu0YxKdk8Q+UDKE3YJUCxjXrSrtr3rb76zJS6fz5Ua2oJR1uYzTbRH
 tUgFmoshBiEK9M8JFmwc5fIU16YKsPtSMwZSEImAj5n1ByFc/WXvhpz5GvCSs/ChTGvr3CRCCHA
 SrD460pBaP/1lD38MQR/FE2b7/zSvyOF+S1rX9g==
X-Google-Smtp-Source: AGHT+IEsU7gHUk/jKN+HgFvnlj0y1KKq59Ixnki7WeWtP4e3d2ls/sN3k5kYmbcN2Ibq7Lw5Wm4NeOF94hWP067Y8S0=
X-Received: by 2002:a05:6402:34ce:b0:5cf:99c:a7c9 with SMTP id
 4fb4d7f45d1cf-5cf8fc8b633mr1942813a12.9.1731685735394; Fri, 15 Nov 2024
 07:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-6-philmd@linaro.org>
In-Reply-To: <20241115152053.66442-6-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 15:48:44 +0000
Message-ID: <CAFEAcA-07TbFe1RYs47qb5jsmdQ1eH70+5nVVB5+3jRaFKhzAQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] accel/tcg: Move cpu_unwind_state_data() declaration
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 15 Nov 2024 at 15:21, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> cpu_unwind_state_data() is specific to TCG accelerator,
> move it to "exec/translate-all.h".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/exec/cpu-common.h    | 13 -------------
>  include/exec/translate-all.h | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 638dc806a5..b36fbf2a39 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -193,19 +193,6 @@ void tcg_cflags_set(CPUState *cpu, uint32_t flags);
>  /* current cflags for hashing/comparison */
>  uint32_t curr_cflags(CPUState *cpu);
>
> -/**
> - * cpu_unwind_state_data:
> - * @cpu: the cpu context
> - * @host_pc: the host pc within the translation
> - * @data: output data
> - *
> - * Attempt to load the the unwind state for a host pc occurring in
> - * translated code.  If @host_pc is not in translated code, the
> - * function returns false; otherwise @data is loaded.
> - * This is the same unwind info as given to restore_state_to_opc.
> - */
> -bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *d=
ata);
> -
>  /**
>   * cpu_restore_state:
>   * @cpu: the cpu context
> diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
> index 85c9460c7c..f06cfedd52 100644
> --- a/include/exec/translate-all.h
> +++ b/include/exec/translate-all.h
> @@ -21,6 +21,18 @@
>
>  #include "exec/exec-all.h"
>
> +/**
> + * cpu_unwind_state_data:
> + * @cpu: the cpu context
> + * @host_pc: the host pc within the translation
> + * @data: output data
> + *
> + * Attempt to load the the unwind state for a host pc occurring in
> + * translated code.  If @host_pc is not in translated code, the
> + * function returns false; otherwise @data is loaded.
> + * This is the same unwind info as given to restore_state_to_opc.
> + */
> +bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *d=
ata);
>
>  /* translate-all.c */
>  void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);

This function is used by some code in target/i386 and
target/openrisc, but a quick grep suggests that they don't
include translate-all.h or any other header that would pull
it in indirectly.

It also seems a bit odd to move the cpu_unwind_state_data()
prototype but not the similar cpu_restore_state() (which is
also TCG-only).

thanks
-- PMM

