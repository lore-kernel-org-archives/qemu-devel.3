Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961C7C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 16:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rywrj-0000Zd-9e; Mon, 22 Apr 2024 12:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rywra-0000ZF-Mi
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 12:49:55 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rywrX-0001Pv-HO
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 12:49:53 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a55ab8e8766so180929366b.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713804588; x=1714409388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OssoGd+toe+Da9gRJ63PPtqR7YzCuATHxJhuhYStOfo=;
 b=WtOgffA4wDJHf4bfvNy8isdGJcfEkXNrCDW2LdK1FIQf2a2YG7s7h4tBbQWY/VMFIV
 6g2PSIlNy2+AwcIwgaiLqZGlhH+z0NR+FUZFI+d658cf0AWT5lom4kvfypDZZMRyTV2N
 E+r0WK1pnjVYg9rSP4Oi1RnqrjoI5TF2JfvY2wwXlY/enXjJ3582eJeWP3EpVSAouyls
 /B9N5TqW7aGLzfYmpK5QZocDYsJmhHiBRq3QjQeIxqhZTisoxz9xfDmWt2nd7N/+4011
 LJX33Tc/6LzPe2D/hbOR4t5ny6i3MEHnRHq7qa9rSabCHMlRmXwAlvM/+czmWhOCL00g
 QGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713804588; x=1714409388;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OssoGd+toe+Da9gRJ63PPtqR7YzCuATHxJhuhYStOfo=;
 b=J7NNelCP1kR8ibVr3wGTV1hcuBfY/sNF1wfqCRn7BrCvxcR7/xIWXygzHcBR7tOUsV
 z5YAuEkueIyCDU7UOq8ULMPrLyaJ5t3mSk+yhG96Y+NGbx2gh5tirh/ugdkE1Dxbas7G
 THws6Y4lzddQv93L42W2/qwkU5Xaml19RkZy9lflJdYE/0Nr3SOv8pRJoFnSK1k64Pi5
 IQa9AZJdRTvHs/NORwima9e2ErhLxPsqGmselB88i0UvAHtFGgiQy/2WuhI/uccwjP7w
 XSlkzAb8qrNoX5O579qpvLSrdEmNRsmBPOOuf2q19JezsuNAxPsrXY6jSxGW9d0t6ykp
 ARMQ==
X-Gm-Message-State: AOJu0YyfgtIgnH1Bf4lk4NmPmNjKXEBV9bwVCPcvohBDLJBcVA20g0/b
 e25OrF7uHLp3bc7t9DeIXdIPQLVoiFvqPUK7fTj0KwShDbO/dVRS7Ji+wnkMG20=
X-Google-Smtp-Source: AGHT+IFRPWoZcOhaZgF5S2zxvFA5vuQy49m+m9yMSmvh69Rc6PC68CsLMa2wfsB+LWyUAcn0lhXlrw==
X-Received: by 2002:a17:907:9447:b0:a55:b331:73c0 with SMTP id
 dl7-20020a170907944700b00a55b33173c0mr3267939ejc.24.1713804588395; 
 Mon, 22 Apr 2024 09:49:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 lu10-20020a170906faca00b00a52299d8eecsm5860505ejb.135.2024.04.22.09.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 09:49:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 86C995F790;
 Mon, 22 Apr 2024 17:49:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 0/7] plugins: Use unwind info for special gdb registers
In-Reply-To: <20240416040609.1313605-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Mon, 15 Apr 2024 21:06:02 -0700")
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.4; emacs 29.2
Date: Mon, 22 Apr 2024 17:49:47 +0100
Message-ID: <87o7a1qr4k.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Based-on: 20240404230611.21231-1-richard.henderson@linaro.org
> ("[PATCH v2 00/21] Rewrite plugin code generation")

I'm getting code conflicts w.r.t to the above (which is already merged?)
so it would be helpful to get a re-base.

>
> This is an attempt to fix
> https://gitlab.com/qemu-project/qemu/-/issues/2208
> ("PC is not updated for each instruction in TCG plugins")

The issue raises another question about PCREL support which makes me
wonder if we need to deprecate get_vaddr at translation time and make it
a run time only value?

>
> I have only updated target/i386 so far, but basically all targets
> need updating for the new callbacks.  Extra points to anyone who
> sees how to avoid the extra code duplication.  :-)
>
>
> r~
>
>
> Richard Henderson (7):
>   tcg: Introduce INDEX_op_plugin_pc
>   accel/tcg: Set CPUState.plugin_ra before all plugin callbacks
>   accel/tcg: Return the TranslationBlock from cpu_unwind_state_data
>   plugins: Introduce TCGCPUOps callbacks for mid-tb register reads
>   target/i386: Split out gdb-internal.h
>   target/i386: Introduce cpu_compute_eflags_ccop
>   target/i386: Implement TCGCPUOps for plugin register reads
>
>  include/exec/cpu-common.h     |  9 +++--
>  include/hw/core/cpu.h         |  1 +
>  include/hw/core/tcg-cpu-ops.h | 13 +++++++
>  include/tcg/tcg-op-common.h   |  1 +
>  include/tcg/tcg-opc.h         |  1 +
>  target/i386/cpu.h             |  2 +
>  target/i386/gdb-internal.h    | 65 +++++++++++++++++++++++++++++++
>  accel/tcg/plugin-gen.c        | 50 +++++++++++++++++++++---
>  accel/tcg/translate-all.c     |  9 +++--
>  plugins/api.c                 | 36 +++++++++++++++++-
>  target/i386/gdbstub.c         |  1 +
>  target/i386/helper.c          |  6 ++-
>  target/i386/tcg/cc_helper.c   | 10 +++++
>  target/i386/tcg/tcg-cpu.c     | 72 +++++++++++++++++++++++++++--------
>  tcg/tcg-op.c                  |  5 +++
>  tcg/tcg.c                     | 10 +++++
>  16 files changed, 258 insertions(+), 33 deletions(-)
>  create mode 100644 target/i386/gdb-internal.h

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

