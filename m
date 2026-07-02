Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4967CC43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLt4-0005Wo-PS; Thu, 02 Jul 2026 14:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLt0-0005UF-7G
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:11:42 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLsx-0003JD-P7
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:11:41 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cace7da66eso1485765ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783015898; x=1783620698; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QRTFV/jc3fNdtzGRLG0HBSxvxAm+Y6L7vgSgeIZ2N5o=;
 b=p9RA/0F+V5SRmJb5jhbUNrgK4S7jylTTtvLfS2Bqr5feA1NuCHGadF43B69glPzNIm
 H2XPcxc0HwCq4fGzqXU1+o/Ttc+CFCtSAOxAhmSoZAXEmPA8kVoQko3GKiYz7TRtPbOX
 N2tTqZit4rFQMO9w1LgscrdYv/dJ2NljJ5ywyQ0kcNxOdZ6SDtKLZ9IhIqr+mY+7p7nu
 jZWuH/7cDjzfUQl61JVe+4Nhp6+kGnYqKaupdQo0pS8paVpr8xoATnLkGf+hE6GF67rH
 /Dy2AloMjR2Fsg3fRYEf6K+AYUCR5dmRyFA7ZFkNBAjqY4D2jU4cDBlCrcNYdNpXih+J
 pvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783015898; x=1783620698;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QRTFV/jc3fNdtzGRLG0HBSxvxAm+Y6L7vgSgeIZ2N5o=;
 b=Npl86+CIkTXSK9gIqTdEeD/c32Fj+kYD3inzF09oB+G7Gjp+lgz1DIzcPlsa2GBAuB
 /mFTQLOMF2S4zPhYxOD0nbdHqOgz0DF5aQ6mQqvSde2NjuWiiG+OBk4FdVH6Mv7fHikD
 GQij5zcJ63CXipnQytKNke6b2LIKSOVrWnL26D3EM4fK3vyfIDb3c10jvjAMDUK80RcA
 yAY8jFouZ7GOimRIVdsTZFAhwEleYvg5rukAG/0DvvhfFKa64WL8cazeIWrUrp82oZ05
 1DwBgQSQLn2EoFo0djPoJNm9HT9L6eMTdvkeM5Km07W2L+rKlMQ71G+sJxfAsSxeFRpe
 lW2g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ror1dgkue2ptkkO1Osa6bbKGggDXSMNcGXlQhCsOnyyd3nsFO0wbFxQAHlqnxexHul/EQgz+dWtTKHC@nongnu.org
X-Gm-Message-State: AOJu0Yy5hLhmswygV61EJeXP2cLIgIn0Ox6o5OcoSAXpPbiLU7fDxzVD
 OM4biS9zKRfj/2L2XismsvaGarOnV4HSA/en0v8yc8Gp4Y2AxOQPZjIOeyPpSQ8IZM8=
X-Gm-Gg: AfdE7ckfenrChKzI5rvxilX4lZW/5JlOupNn6KTyD8e8BGSULAdL/omxzZoYuVz/oQV
 Fuo8jnD4FXn1sTHM0dwPzzBK2Fp7f1R3wXATSIcBYSxLvm+WSODmQdh/dduSbxk9YhrHIU2gAOH
 NF6gpa7++2Yz/IPOXTZZAgGXPGVSz1r/RcJCLMLLlXGj/wHYrf72SVp5keVNf86vANTJ65MuowN
 jQOxegE5LbY69Q1d65xKy+2Q20LCOt7PRAZpfcVskZjm8er+g6aUZ1lyZ0Q1AJxAvK8gNi4dk1y
 S+aUNbNP4as4VvCzKwZQXBKsrzwmwCrfu44AWSoZbEf9I5k00dalh61oil06r5/3hVFf+CptRci
 +FFsTm/CkxSyOUdUkzgQ2JhU4dOtPlPJkD75LguTo9VOwMfbaL+J45kve5V5PBd4noLFD1nkA0x
 Aq2Us/lFMbyQEwGm3XD4uLozzDWRdGXk5sCgTVMaup8dY3uJEMJ7Wtdpkayw==
X-Received: by 2002:a17:903:186:b0:2c9:b8e5:5741 with SMTP id
 d9443c01a7336-2ca7e872a9cmr82312465ad.35.1783015898189; 
 Thu, 02 Jul 2026 11:11:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9a8dadf3sm17568705ad.2.2026.07.02.11.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 11:11:37 -0700 (PDT)
Message-ID: <30411570-6d3f-4c84-a262-e8a31da48d0f@linaro.org>
Date: Thu, 2 Jul 2026 11:11:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] cpu: Only check SSTEP_ENABLE flag in
 cpu_single_stepping()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-34-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-34-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 6/30/26 15:01, Philippe Mathieu-Daudé wrote:
> Only the SSTEP_ENABLE bitmask means single-step is enabled.
> 
> Fixes: 60897d369f1 ("Debugger single step without interrupts")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/hw/core/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 27ee0e54327..d092ab8aa5b 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1146,7 +1146,7 @@ void cpu_single_step(CPUState *cpu, int flags);
>    */
>   static inline bool cpu_single_stepping(const CPUState *cpu)
>   {
> -    return cpu->singlestep_flags;
> +    return cpu->singlestep_flags & SSTEP_ENABLE;
>   }
>   
>   int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

