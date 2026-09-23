Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8041C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9T0Y-0007dV-2s; Wed, 23 Sep 2026 15:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9T0T-0007d3-Ts
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:51:54 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9T0S-0000am-De
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:51:53 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea34ef4so1084215a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790193111; x=1790797911; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vI+bs9iTqiV7ZAQJi6IULRrFYc8AQ6+MWuy2KKG1r6s=;
 b=fNUQLRKZIrhMZBpGheR+fZf7XTkxqZs+u9kCYm8GsDUzfvHofhVcaQ7TxhfXyHppwJ
 lCHpFvT1C2sDd1MbIAnFJ7QjtFe6YCvCR89ArQ9JTmT4V95/e6x//xybFzQPUkfAFz6q
 koGhzW0So4rvQ+Udkse0yH7EL3pctLtt2DkDc7xouQMU5WUALLqhbo/N74ietpgDS09t
 C6qe4xzIzmcP/SNF+dkLCo9DWkmGOOtzM4Ae6q1dkX+Ln5BIqXakFF1Mujfr4t+ktWox
 4Ld/+z285yDk3dYeY0srsSTQ1sXdHdLdMERPAdbWHxrBCK/YrIKlX4ABQ1gK++96agV+
 t2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790193111; x=1790797911;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vI+bs9iTqiV7ZAQJi6IULRrFYc8AQ6+MWuy2KKG1r6s=;
 b=vAiJ/pPM1FtJxXk5JQbIxz3vcEvyBgUYrORg3FH1SbrO7SdnN0K/wZhCvx/pPNqxmS
 OdSvVyqPO5+yk5vwTtypvio3SMUXVMrfbCUvLFA/IpD3szqZl7HRDUKifazMFD2wbVyB
 LxkwZGNMda6fSvlVpi50/gL4lzdEO/LoCDLjvCI+mrUwwj962y8D+SHmg3v7ExKPV6o7
 4+Tn75rzSQRgGy0DKVKXF/lk9H657ypiUfgHcBXlQ8pIjOAFYokNVWl/jlUDlukcTszX
 a4asFCswRE9mUXi2DGMfH+3cvyTwlACkf2x78GA0nhXV0pp22mLoa6uteug2gGEtZgDs
 lMxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/TMjYzIIGP/k/81bdd+uy7TfdOUFkwj8PEtmnPgaanb2KdVB76/KsRmnO01aQMTSOC3wUKaH3evoX@nongnu.org
X-Gm-Message-State: AFuF++nTDuQ8Ene236wbISfbJl1IyI5Y0StclWZ8EtwK3qfhAzwTKboy
 goZv4weeJr+owD9CIuqn/MuPF05G1M9wg1FD1hzrIPPI9y+NBJodBruKXFcmg0ePScY=
X-Gm-Gg: AYBFou3tmM46ORs6/HJ8lk0PBQaIpuqc5+rUO3Cry1JVNgCKaKFSS+X/O2oeAB1FMl3
 QrUuyu4TKpR/N1b+kIPsS+bH4NJdK1Vlv+XlUfzkkcVyrE9soBN2w7PXieJbsvuEv6vbjcsFFdt
 rH6FgdzdPZBHgT3LrNXJz9lLMlfBR8hrsBcXTYpVZBap6IOLC7l7kllMby1L1QyD4JTi/rwULA0
 IIBhPThpnCgdSdqpd+Bs4O97ygcSee2E+Duaxu+s35ScBM1yT2LavuZBGrCObw7kS9TzH234QE4
 5t3aCL1UebmesZW/9Q+cQrwR1jxznC1JHZ+oCGhHuFxMI3MwrMz8m+jc+Hje/vZNM6M5od+UW2z
 ewtBgQpVheH+jzoMBEukV3rtn4E1OzHj8Lttag0HaDt9ZKN5kzvbmb3aLvH5qK0mzox/eCLyAIs
 ulM+MH42cI4OgzisRYlfmbzru+1WROtaGqP96MfJYcbX2Yl8KnYe67HMFdM0TyIwgAiVAE8CSpX
 06t/LmF9gl3ys6SG3X1mkGHBIuWlqpLqt0STXwA
X-Received: by 2002:a17:90b:1b44:b0:3a0:8050:2ecc with SMTP id
 98e67ed59e1d1-3a098dad731mr155900a91.25.1790193110642; 
 Wed, 23 Sep 2026 12:51:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972efa00sm764384a91.5.2026.09.23.12.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:51:50 -0700 (PDT)
Message-ID: <be7d4953-e8cd-4ddc-ae45-88486500ffb0@linaro.org>
Date: Wed, 23 Sep 2026 12:51:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] target/i386/tcg: treat 0x0F as a prefix
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com, zhao1.liu@intel.com
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-9-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923173021.317809-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/23/26 10:30, Paolo Bonzini wrote:
> Because 0x0F cannot come after REX2, pick the 0F opcode map
> during prefix decoding instead of doing so via the root opcode map.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index c4f12ba6c13..bcb23c6fae1 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -1848,7 +1848,6 @@ static const X86OpEntry opcodes_root[256] = {
>       [0x0C] = X86_OP_ENTRY2(OR, 0,b, I,b, lock),   /* AL, Ib */
>       [0x0D] = X86_OP_ENTRY2(OR, 0,v, I,z, lock),   /* rAX, Iz */
>       [0x0E] = X86_OP_ENTRYr(PUSH, CS, w, chk(i64)),
> -    [0x0F] = X86_OP_GROUP0(0F),
>   
>       [0x18] = X86_OP_ENTRY2(SBB, E,b, G,b, lock),
>       [0x19] = X86_OP_ENTRY2(SBB, E,v, G,v, lock),
> @@ -2824,6 +2823,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
>   
>       /* Collect prefixes.  */
>       switch (b) {
> +    case 0x0f:
> +        decode_func = decode_0F;
> +        break;
>       case 0xf3:
>           s->prefix |= PREFIX_REPZ;
>           s->prefix &= ~PREFIX_REPNZ;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

