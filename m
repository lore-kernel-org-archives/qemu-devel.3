Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83B0FEFB54
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzLn-0004nO-3S; Fri, 27 Feb 2026 10:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzL7-0004Ze-VI
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:01:15 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzL4-0003Sl-T0
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:01:12 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-65f89c40547so4314885a12.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 07:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772204469; x=1772809269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXnoSBUwX34u+aPZUSePM/Lkim5KWvJVjqYSISaeK6A=;
 b=cajzw++IVrfSe7zccI98C+hd0sNO11XPnentrOHB5+xuXdnh44EDdGjSXEIIQoKsGc
 hkaEPwqPK37yesUWPTXikhUNB2yIq4zqvVkXDLF8kQ8II3ZpFj8ahxKKbQebcYzh9sUm
 TWEFeOPHj0do3wGAnDliQrt3bkBXb1BsiA6BhQV1/X2YEzC4H5sFOGw1iD0QwhYYia1S
 xRwSFyYoajKicJF2ecyf8ohauMXCOO8wNveuTrFakEQYDFaMOXiR3rOT/x1FE297Hevp
 zY/JKEp0wFNWnolDge8AnMEEyvfnYXXO2WXVOs68VWlI4bAhheFBrdKytN7x9izuf2HV
 zBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772204469; x=1772809269;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aXnoSBUwX34u+aPZUSePM/Lkim5KWvJVjqYSISaeK6A=;
 b=UvuX1U1c9Qh/XAP2rdVWWAONDhwlMb+Dlh08tOYWPlfJIst5IibF2nebqBE2Kyzrk0
 XPDB2xs1yXP6D3oyerjZCEZtT0WMHkLlwhckghizaHEJA2YwoLZK8l4Q9HMQDTYvLOwF
 8+6mh3fRANhKr2BnfaNn/nEP3e1fFOwRMlQKAWNTQtjsJeJKr+NHQdtdbtcXm0+pc+xN
 zIlRcJRZkGBnRel1y4YUXZf0l7MtTQNJDx/TUbSKwUj/xWrA2LDOXZnlFft9n2LiwQon
 bCLIchlNRYIlIqWgmMt+Rj4hQW3mwaRlAExmp70rKsebGyHBKKe3MI7dANXTvZ50wipW
 SYvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhUt2HYLURKi0J8DlGcv9fPgHsG3/fn8qw44hEurzROJMkAxE6tFMYyfIZh43FsrQnmx7Oo/GIgI2Q@nongnu.org
X-Gm-Message-State: AOJu0YzmmtT5Zd8griESrVXLraJiPHpbj584TJDtZP6AzrA8/sY6a2Zp
 wkorR0kWPs6x/YZBEBDMxveTtdru/pGQ6Xupxp+pWx2QcwWmrWRdOEGAvAEfeQH8OjxdFit5ukt
 B1N9F
X-Gm-Gg: ATEYQzw1O1Mi75rW+eGhu+V6qto183sTt4UhIil3EjbTNktRBuf+xKbffIbF0NOxG/+
 UfBNf40k3IJhh7gO/pkpbZjE1Bu8EpzxvLpTQsmMHoc8Rr0XYtMQp9vJK7KaWd5LUWidiMdvaE8
 NEbC9j5+RdeZF8VQigcQjffUeTdiQv621G3ZFU5zkuIElwaxWIwfAAMa9r1nv5nFobk4pRkzZJe
 E/gAfmV3rnVeI6fpZZEfgJNXzs0i1FdJe8aPmGKccM2w6JyAE2OnydPtteTOUrP9F4dFisSSgk6
 iuz6nfEkopJrDDQ5H5vDlmSEIWEQ70nLN6g954CuoT4vkKDgm8Azsj4AUfGdQcVl71ImpdnDjQb
 iWZImwZd8IhMrdM/UWxEyl9A9B3VqWqLINeaNZR7R3MDWuR/BFhQYdxLGnsM6Llty6q1sxf3kaN
 ftp1t189ebJ/MLCiCbsYlRkuo=
X-Received: by 2002:a17:906:f590:b0:b83:3295:15d2 with SMTP id
 a640c23a62f3a-b9375a97109mr190791866b.30.1772204468936; 
 Fri, 27 Feb 2026 07:01:08 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935aee39a7sm151672466b.62.2026.02.27.07.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 07:01:07 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ECBC35F7F3;
 Fri, 27 Feb 2026 15:01:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 qemu-ppc@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: ppc-linux-user GDB stub broken
In-Reply-To: <70d4f460-c5c5-45ac-9ef0-2307ea4834f2@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 27 Feb 2026 14:09:14
 +0100")
References: <e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de>
 <CAPMQPEL1__biyd5e81EW78OA1rmVYqfsdEOmH5cs-nOvwnB3cg@mail.gmail.com>
 <70d4f460-c5c5-45ac-9ef0-2307ea4834f2@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Fri, 27 Feb 2026 15:01:06 +0000
Message-ID: <87bjhaxmbx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 27/2/26 10:58, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Florian,
>
>
>>> on current master (d8a9d97317d03190b34498741f98f22e2a9afe3e), the basic
>>> gdb stub test fails for ppc-linux-user when running "make check-tcg".
>
>
>>> I've debugged around a bit but I don't know my way around the gdbstub
>>> internals enough to propose a patch right away, so I'll just summarize
>>> what I figured out so far.
>>> 1. Due to cc->gdb_num_core_regs not being set explicitly anymore, it is
>>>     set to 0 at the end of gdbstub/gdbstub.c:gdb_init_cpu(). In the same
>>>     function, cpu->gdb_num_regs gets set to 70.
>>> 2. When the test tries to read a register in gdbstub/gdbstub.c:gdb_read=
_register(),
>>>     the first condition of "reg < cc->gdb_num_core_regs" is always fals=
e.
>>>     Also, the register number for fpscr passed to the function is is 10=
3,
>>>     and cpu->gdb_num_regs is also 103. If the register number is suppos=
ed
>>>     to be an index (as I understand it), this would indicate an
>>>     off-by-one error somewhere.
>>>
>>> If you have some pointers on where to look / what to check out for
>>> fixing this, I'll happily try to work on a patch. But I suppose that
>>> somebody more experienced with this could probably fix this much faster
>>> than I can.
>> I'll have a look.
>
> Short term, this seems to fix it:
>
> -- >8 --
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 90f4b95135b..0b0a5d1e044 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -610,6 +610,10 @@ void gdb_register_coprocessor(CPUState *cpu,
>      guint i;
>      int base_reg =3D cpu->gdb_num_regs;
>
> +    if (g_pos && g_pos !=3D base_reg) {
> +        base_reg =3D g_pos;
> +    }
> +
>      for (i =3D 0; i < cpu->gdb_regs->len; i++) {
>          /* Check for duplicates.  */
>          s =3D &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
> @@ -622,14 +626,7 @@ void gdb_register_coprocessor(CPUState *cpu,
>
>      /* Add to end of list.  */
>      cpu->gdb_num_regs +=3D feature->num_regs;
> -    if (g_pos) {
> -        if (g_pos !=3D base_reg) {
> -            error_report("Error: Bad gdb register numbering for '%s', "
> -                         "expected %d got %d", feature->xml, g_pos,
>                           base_reg);
> -        } else {
> -            cpu->gdb_num_g_regs =3D cpu->gdb_num_regs;
> -        }
> -    }
> +    cpu->gdb_num_g_regs =3D cpu->gdb_num_regs;
>  }
>
>  void gdb_unregister_coprocessor_all(CPUState *cpu)
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index e0aae9c9eaf..51b14b95b9f 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -502,7 +502,7 @@ void ppc_gdb_init(CPUState *cs, PowerPCCPUClass *pcc)
>  {
>      if (pcc->insns_flags & PPC_FLOAT) {
>          gdb_register_coprocessor(cs, gdb_get_float_reg, gdb_set_float_re=
g,
> - gdb_find_static_feature("power-fpu.xml"), 0);
> + gdb_find_static_feature("power-fpu.xml"), 71);
>      }
>      if (pcc->insns_flags & PPC_ALTIVEC) {
>          gdb_register_coprocessor(cs, gdb_get_avr_reg, gdb_set_avr_reg,
>
> ---

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

