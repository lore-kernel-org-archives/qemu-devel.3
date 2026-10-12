Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE2ECA9EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHOB-00059i-Pz; Mon, 12 Oct 2026 10:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGHO8-00058g-L7
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:52:29 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGHO6-0004dv-Sp
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:52:28 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so11798975e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791816745; x=1792421545; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fLzMp1A3ozgbn70hBtf1k8ONvAjHQDnWvGVsd1mYHyM=;
 b=G2lJRLY4QSg/hBqTl8adw3n7tb9FaLVSyCl4rYds9IAB2SCFtzx1Qmx5u3fWU5suzz
 r7vaHQpFj/qRZK6u0LA6CQB+pSBo7vb+difH9pdwzhkpY4WPc79OYZk7HYcGXiTkHo/0
 MfC7dp/t//LO1pLluEvYaEq0pWpZKBPRCcjClkkGoYaJyldOKCtOkQ02gciafJOPbpAP
 mTpt5Rl9ihYOC86UkqUawW8+MjafdTs4uBrN8yjj98jjFDWrXLf7b7b6faTJhHsAU9DW
 6bblS2mamarJwfqSloZ1khrHLhfXjKOj+y+AneXremog/oj0qS9VDMyPgD4/JNrFGkFN
 yN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791816745; x=1792421545;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fLzMp1A3ozgbn70hBtf1k8ONvAjHQDnWvGVsd1mYHyM=;
 b=yN3I6WsnHkgDl6IS+18TFbrhe6bwknzpINi6W1M3qo9uXTVlTBZ+glkFJgw3Qlcg+/
 2fxxo/1kO+iukmjTNc8GmzEKtSaNLIh//erxLJSfR0D0tSzVMSOqAFajKYmDSdMhTHiz
 GNmh/jFhWMzbqJWAQFyb7W1eKOGdfq8rsc/5+ih9fkAPZkkwWwGCDzBdq9FWV+3661Xt
 GI0aC8XneieU6AVBVdE3y5dOdNWGrcXxGTRcEVtAa/FpY4iAQpnaVoopi1EjLnFySIdg
 2YStobVzSGVmv5DEStvTKbRli9Hf5c6W6y1bHjp7P/0gUU6b0nroDUuZCJY5upoX2tVx
 CPdQ==
X-Gm-Message-State: AFq9FYLuUs0M+oRlJ97yNaJKm0vYCR48WxxBNWrVnkyJHvfz4D+/2LRN
 dmJXW+DYnKSs1Kl9qhA7d8f2R+GOS5vM0Mi1Hq/W30fhlUISSwtfXyQhehiA9sAvodA=
X-Gm-Gg: AYBFou3qTKwr//10wHKD8Dx0yKqs7QGPYcFjX+9mTqR5jhKGlKEWWumnpzM/qir82j2
 qaQU2GY2k26+DvauxPhDEBe74V4/DDrzB15Qt9BKqk17G55v/x+lYVvCRHajIWe4/zhBqblgDr0
 mm2bWhfklJGK4DLcsNqzcvoeNvWmb7tfgxqoIVrtQOUPgzFCmUjAf7hdeCGMwdMzje8d/mnnzgS
 gAwdaVRZuvmLI/Fu1m38NxjCMgr6L3UP1GBUcPq+4LyGymDCR7MTgtBq/BtjPSQpng5Ibptafoh
 2Q6PHwPlUIifXiqH6L5nqS1d9kMnH+iBn81wuvu5TloVsm9ZHHdh8Tcb2SaMg73NTFygkVgBv/N
 KIj1U52LFJ3liyBdyIMPO6OZ6UST+NkwRHwYbAwe3yOzhTIr4EVaTCmO0W4lOfpXSqm3tdHulpa
 uYOUQWtRYSIDtrgay89czuOt1+SbLCk2Xmqt6adabCYq8Zpg51lZAgvHZ9DpNYAuJuni+iCw==
X-Received: by 2002:a05:600c:698d:b0:4a1:98ed:7a79 with SMTP id
 5b1f17b1804b1-4a198ed7aecmr93600765e9.8.1791816744824; 
 Mon, 12 Oct 2026 07:52:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19c8244edsm125419475e9.2.2026.10.12.07.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:52:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 174C95F8CE;
 Mon, 12 Oct 2026 15:52:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: Re: [RFC PATCH] target/arm: hold bql when SEV sets the event_register
In-Reply-To: <20261012134840.1051969-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Mon, 12 Oct 2026 14:48:40 +0100")
References: <20261012134840.1051969-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.4-pre5; emacs 30.1
Date: Mon, 12 Oct 2026 15:52:23 +0100
Message-ID: <87fqybx97c.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> There is a race in qemu_process_cpu_events and sleeping on halt_cond
> where we can miss the setting of the event_register which would cause
> arm_cpu_has_work to report we shouldn't sleep. As by definition the
> bql has to be held when we go to sleep against halt_cond guard the
> kicking of the cpus by the SEV helper with the BQL to ensure things
> are properly serialised.
>
> The other places that set event_register are fine as they are either
> in the same vCPU context or are already serialised by the BQL.
>
> Also use qemu_cond_wait_bql like the other halt_cond users.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4660

This also fixes 4670=20

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  system/cpus.c              | 2 +-
>  target/arm/tcg/op_helper.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/system/cpus.c b/system/cpus.c
> index e11a5aab6a6..985732217fb 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -412,7 +412,7 @@ void qemu_process_cpu_events(CPUState *cpu)
>              slept =3D true;
>              qemu_plugin_vcpu_idle_cb(cpu);
>          }
> -        qemu_cond_wait(cpu->halt_cond, &bql);
> +        qemu_cond_wait_bql(cpu->halt_cond);
>      }
>      if (slept) {
>          qemu_plugin_vcpu_resume_cb(cpu);
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index af56eff9f18..7c1fdab79d7 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -471,6 +471,9 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
>  void HELPER(sev)(CPUARMState *env)
>  {
>      CPUState *cs =3D env_cpu(env);
> +
> +    BQL_LOCK_GUARD();
> +
>      CPU_FOREACH(cs) {
>          ARMCPU *target_cpu =3D ARM_CPU(cs);
>          target_cpu->env.event_register =3D true;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

