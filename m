Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113B5CFA462
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 19:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3hPo-0003mv-G0; Wed, 23 Oct 2024 15:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3hPm-0003ma-CB
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:53:06 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3hPk-0003RG-Ms
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:53:06 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c96936065dso146137a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729713183; x=1730317983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QT0fsmeUUu55WfC8QvMKGZaDpBsFX4XCwi0kKbXfBWg=;
 b=QvBinTK2U6j0QJUPsm/dHBP8VjnI3g09HPulsgZK76Fa8W9ZE4dRY41l8ODfavLBIu
 Ej64gcmVfQ1Kc7SBwM+13Qwb4P7occeXkgEjsiLGHf/f2pyNByWbxxmuWygECRvJnqeC
 sw+dDmjTPM/imT52Q4Vz3ska04auFkvzveWc1K/mGxJvrVRr+owtuWPkhvqK1QYdxiAs
 VxpFIiRuW1dgCEYPOJP36bzLJTZn/YFfGoqY9GRrIuAjYWmyl/5QNICWYnLEt6rElGfj
 6OnUcOBm5HF8kpjZiqsFUUOBWJYmq/GRXoefE77owKkZJnsT6evm9LnPbLiRHXiCEw6+
 3b2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729713183; x=1730317983;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QT0fsmeUUu55WfC8QvMKGZaDpBsFX4XCwi0kKbXfBWg=;
 b=fLPT6R7K/rMTEk/DOgRELtHsK8EZXSOChk4M8k29coVeWpchmGGpP9EQZhVEtuS5VW
 Z67pXPRDI4BV7/8YKVc/t6/rOSYFOPDXq2xUX/Kd61eJh5xNSZQKk5U+96efC3qlaRNF
 o9gyxFwNFtEAlrYmF88m3uVI3+kaXcQmudKkM9FmJ1yZZKnbsRggUKTUQAEZKMRDf135
 Uks3gJiViYnbYARFc0h2eVnfuBZTwIILjlDqb0sXAV1XN4GnuRXn4qnfimWyvHtnID0u
 9oJTkTdYNddNE9YF0yi2U7j0X1l8323F6HTe+ImG8+jmGko0+vJ6fu1fA5dGcYgiTQFz
 9Ldg==
X-Gm-Message-State: AOJu0YynP+hZuAk4otDiysd3I6abe/3gaq2DfXDtu4Y3I9lZDrXdWxff
 7Y3NSyOmP4uSNSVSemcvlz6yr6DNh7U3ocfwbFI1LFPtSmJkd8HZTaQSp4UZtLw=
X-Google-Smtp-Source: AGHT+IFdcrHmqD9fNUlvupmugonhdeOCD6uYFsd/3JVqrXmNmPFd8SYhePk4PeM841jeXm46M9/MGQ==
X-Received: by 2002:a05:6402:34cc:b0:5c8:8bde:a1d3 with SMTP id
 4fb4d7f45d1cf-5cb8af8e752mr3874776a12.22.1729713182838; 
 Wed, 23 Oct 2024 12:53:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb6696b4dcsm5043038a12.4.2024.10.23.12.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 12:53:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8AAD15F897;
 Wed, 23 Oct 2024 20:53:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,  Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH] hvf: remove unused but set variable
In-Reply-To: <20241023182922.1040964-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Wed, 23 Oct 2024 11:29:22 -0700")
References: <20241023182922.1040964-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 23 Oct 2024 20:53:01 +0100
Message-ID: <87zfmuk34y.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> fixes associated warning when building on MacOS.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  target/i386/hvf/x86_task.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
> index f09bfbdda5b..cdea2ea69d9 100644
> --- a/target/i386/hvf/x86_task.c
> +++ b/target/i386/hvf/x86_task.c
> @@ -122,7 +122,6 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segmen=
t_selector tss_sel, int rea
>      load_regs(cpu);
>=20=20
>      struct x86_segment_descriptor curr_tss_desc, next_tss_desc;
> -    int ret;
>      x68_segment_selector old_tss_sel =3D vmx_read_segment_selector(cpu, =
R_TR);
>      uint64_t old_tss_base =3D vmx_read_segment_base(cpu, R_TR);
>      uint32_t desc_limit;
> @@ -138,7 +137,7 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segmen=
t_selector tss_sel, int rea
>      if (reason =3D=3D TSR_IDT_GATE && gate_valid) {
>          int dpl;
>=20=20
> -        ret =3D x86_read_call_gate(cpu, &task_gate_desc, gate);
> +        x86_read_call_gate(cpu, &task_gate_desc, gate);

If we don't care and this is the only caller we fix up
x86_read_call_gate not to return a value. It looks like it fails safe
with an empty entry (but also the function x86_read_call_gate needs the
printf removing).

>=20=20
>          dpl =3D task_gate_desc.dpl;
>          x68_segment_selector cs =3D vmx_read_segment_selector(cpu, R_CS);
> @@ -167,11 +166,12 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segm=
ent_selector tss_sel, int rea
>          x86_write_segment_descriptor(cpu, &next_tss_desc, tss_sel);
>      }
>=20=20
> -    if (next_tss_desc.type & 8)
> -        ret =3D task_switch_32(cpu, tss_sel, old_tss_sel, old_tss_base, =
&next_tss_desc);
> -    else
> +    if (next_tss_desc.type & 8) {
> +        task_switch_32(cpu, tss_sel, old_tss_sel, old_tss_base, &next_ts=
s_desc);
> +    } else {
>          //ret =3D task_switch_16(cpu, tss_sel, old_tss_sel, old_tss_base=
, &next_tss_desc);
>          VM_PANIC("task_switch_16");
> +    }
>=20=20
>      macvm_set_cr0(cpu->accel->fd, rvmcs(cpu->accel->fd, VMCS_GUEST_CR0) |
>                                  CR0_TS_MASK);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

