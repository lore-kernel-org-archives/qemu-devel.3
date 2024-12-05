Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F43E77171
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJYg-0007sa-69; Thu, 05 Dec 2024 16:38:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJYe-0007sP-GU
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:38:48 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJYc-0008MC-RE
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:38:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434a766b475so14267365e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733434725; x=1734039525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CVE8/vXra0xBx2yWpDKBpr2ah7PrNfu9cQJFFaJXkH8=;
 b=mr3gfn15yBGYrgxBGyRn7bhM/UP0cPFCfj/1zs06pHxeGSpwViZGYBY9d9b8pA6QTJ
 ORWAE5gfluuCwaxJW0OcRqbQf6P9k72sulI6+7U2W4l5fMb/kWqYmWiX3B1ytvK6ILl8
 44wYPNtfPrwkSs7b2z1SoQT84IqPX4lwyYJjqKKLyTI4WV9JsbD/RTtBbVFLkFJMdv21
 UmqJBk3T5CnBwDHTPrgBqqP6Zk8HVEKiZU8ieai4ABsKMNQxJNLFjfq+J5IriiXg3orl
 QUkOAb4s5gR39Q0Kjk4UmbCYHZh2I1TcAHTL47d9Fl3gAymzCkZqY7o+9uQf3SfndzVK
 Udhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733434725; x=1734039525;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CVE8/vXra0xBx2yWpDKBpr2ah7PrNfu9cQJFFaJXkH8=;
 b=WcReyC1Atv2bT2uyRhnBURpjra4HB8ObFXMUIzPbvFCyhsVQYogx66hmED+ZDtvPqy
 sABWaoZFpAREncvQ2e+Pcqftu3OcD575MctdvKffEAn3lgDTJlKHRP/Mu41k2jJJU1DD
 xBNaUzmcI1u3YkRRKiR9SCrFGprYqB0rl9U69GkV7YHKK2RBowAEqAlHxrPloXMKHcPU
 qCHzTOQUn0hOrC1RbXb0PBY1OAws5FO7fkHh4hknr+scZRdKcEwWBgbjEZlssMuYYFZ0
 wZ+MF+r5J3VNuLhZVlA6eMPVzHoJRXXfpXn68sXCWdVv6/HfSPJZxtxap+j7IvMhW6/9
 foeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQFzAmRqwYal5lI4/AoFQz1RaYOFfHwc8/SsVDesX+yJVKfaleyDw0/CIgjCA3ogxGHN63Q0eAcoNc@nongnu.org
X-Gm-Message-State: AOJu0Yyby+IJ2GCkFCzFaB40+wJs3Qv8mCYT+DqKjdfxh/t8WS06vuRT
 hvlgffY9meZtWR0nsrnHtQ84X9tvK6U/85CLi9+9umYtfn7QmbY62Ba8ADxZaSk=
X-Gm-Gg: ASbGncsdvthvnhzM5jZ9QlTKhndWZMCGFdORXx4tZBrImWctS9pRHbpkIWd7NscR1oA
 yt/Sxk7XD5+DLDF9qwLg566bqe88M9rX6wiMUNl8G2gutOil0RkR26b0fyxfGqgtx3csObiggC+
 OuYSmQauwG0gVAq01karJG8u2l14xWWLwpNbfBy4LBnui6Aj9G0K5pVyX9qbV/gTNrGWTrfHeby
 4dOXyD9OWKNdnaqybgVnuFV1mo/n3AAFGMWNN1eOCoS0sBkLF6xTEk13voC6AB/iP52j9cPDgc8
 fMDm4CNpgtsCgO52bQ==
X-Google-Smtp-Source: AGHT+IH0UQ4sD3dYXkL6wjPpnHj0gzW4qC/7vgSFxhd9OI1rG+YfENzexAb2xK3SIqILzXog7fMFmQ==
X-Received: by 2002:a05:6000:a05:b0:386:8ff:d20b with SMTP id
 ffacd0b85a97d-3862b36c085mr480415f8f.27.1733434724705; 
 Thu, 05 Dec 2024 13:38:44 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861f59cceesm2928708f8f.33.2024.12.05.13.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 13:38:43 -0800 (PST)
Message-ID: <f9793791-2aaa-42b8-9830-86401a020205@linaro.org>
Date: Thu, 5 Dec 2024 22:38:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] i386: Extract a common fucntion to setup value of
 MSR_CORE_THREAD_COUNT
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
 <20241205145716.472456-3-xiaoyao.li@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241205145716.472456-3-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Xiaoyao,

On 5/12/24 15:57, Xiaoyao Li wrote:
> There are duplicated code to setup the value of MSR_CORE_THREAD_COUNT.
> Extract a common function for it.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   target/i386/cpu.h                    | 11 +++++++++++
>   target/i386/hvf/x86_emu.c            |  3 +--
>   target/i386/kvm/kvm.c                |  5 +----
>   target/i386/tcg/sysemu/misc_helper.c |  3 +--
>   4 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 4c239a6970fd..5795a497e567 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2390,6 +2390,17 @@ static inline void cpu_x86_load_seg_cache_sipi(X86CPU *cpu,
>       cs->halted = 0;
>   }
>   
> +static inline uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu)

Please do not add more inlined functions in this huge file, the
inlining performance isn't justified at all.

target/i386/cpu-sysemu.c looks the correct place for this helper.

> +{
> +    CPUState *cs = CPU(cpu);
> +    uint64_t val;
> +
> +    val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
> +    val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */

Personally I'd change to:

        return deposit64(cs->nr_threads * cs->nr_cores, 16, 16,
                         cs->nr_cores);

> +
> +    return val;
> +}

