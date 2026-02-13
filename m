Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068A2EDF176
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvDx-0006C4-Ii; Fri, 13 Feb 2026 10:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqvDv-00066z-RH
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:36:51 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqvDu-0005Ba-5V
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:36:51 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so8829055e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 07:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770997008; x=1771601808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mRrt6FDcvrPGqPJKpoRNTYSfkw83mwungKnlR9AezbA=;
 b=kehwMvas7r1Bu8x5cb+EyWjd9ZK2/mwO0fS2lFgGl0hLve8l08GMZa9dt1s4c81Zx3
 s7FhfQc9gjdibbscvJaqbGWOfVLjr6Idp968yxgttQBXuQluf6gqFOZ/4x+eMLlxiRg4
 SKi0mF12dHxzRYEC88sSBHL8FrFjC3fV9vmRkdiYKeb4s0cxY0YR10ieIUGdqjFTeoWX
 cMzDjL2SsKH9lI3LmE+XpVt3qrUuu/oCB1HrSleCKmsn2zabDQmXMjk/KE1pHe6uV/ix
 6ymDAbUZvf4E71Ap9ZFUJAIrKR7mqronOAPhIU9lyzqkAfrx3pU35xms6V5b1O64GYY8
 0FpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770997008; x=1771601808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mRrt6FDcvrPGqPJKpoRNTYSfkw83mwungKnlR9AezbA=;
 b=BDh076uTjb8AGw+Lr1kh3zdwBtzcTxHz7snTp7Bwn5C+tf4pIeTUOrlbPda/Nqgqft
 GnFIKHi/TmRv/8s0EBYl8PnhyZlQp5i7bm93SQh4yAiO8XHUdNcerKrzbHUA2dDc5JPX
 7VoA2VKibwNGIN0Vq1ohCgyK1KaBy8YTNT3Rp450GfP2NX6mNSL2KkCmUnW1WkknfbAe
 YXlvcyxxD3hD1e8rsyLGqYnf2rBFzYhEw4X7ewZH2ZKcsQ+ActxRjitWETlBDYHK+a+a
 IwaMvyv56x3xeqsNoqb3gEuhisFnccbWquZ050PutLPmxMg3jIPkRfpzGhR0MUbJZ+Sd
 sjAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhoVMuxkGNsk0Uit9WvcHSTf/rFBBAghWqtl/hMFCEldg/rvam5EfRXSWppOs67rsljZy88r5yB1Q6@nongnu.org
X-Gm-Message-State: AOJu0YwpkpcDAAuvv4ugEpAKS6G7XK2WvIJMmU2RGk2+tIg9xyA/ODm2
 QMoqiH8X1tOWpCcAAMp4+g2UNt4PzyFBizWfDyevHxpgtkGWPJbERLgNXPp6ZKudhH4=
X-Gm-Gg: AZuq6aI4xMHG441bWWMv/PhwVJzEiURGSRbL0AFZoLy/95TUfy0yi0XmBpoRYSE1pbg
 0Os7CpKrNNOUZ/tRqilthrhqAmDQ+G569UoMP4FB5nff5yTJEGFBoaz4JFwwr8M2v6SrHuErbxz
 Vu2RE1mF6IOAbPExVM2428Fl6P/aX/58s9Ia/K87uQ+PsoWvOTKA2heeC3WVf2+BQry9pq3tJRB
 4f53l/yJdGalSwAswgDKhNuScTy9qETtKKaWSBkgMGCKWVBlAi0aiyesCGgsSroPkjQqpUQKzDN
 UHu03SdHkTZYI+gfTiKcceDqzPB2taur1RGn87aiD/nJcdzfz/t0HXS8nw/BemSoDAQbG6pZL1r
 2nB2zyxm7nJWS4VGVgvWn3MRx64A4ykEoVnVdojz8XxWicVLL9rH4B4vtpDYNhHFQYr92GkAXrF
 ZzLKxCtKzAgUkqlhT1ltsJXbArVCs5XEvUGLFuyN0QcZB9jrBVrIq5tE4TZq5u/8DwZg==
X-Received: by 2002:a05:600c:1da8:b0:477:7af8:c8ad with SMTP id
 5b1f17b1804b1-48373a74abbmr38181435e9.31.1770997008300; 
 Fri, 13 Feb 2026 07:36:48 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483709f8812sm42049755e9.0.2026.02.13.07.36.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 07:36:47 -0800 (PST)
Message-ID: <dcf48643-91c1-4ec9-af15-d3abb1b1993e@linaro.org>
Date: Fri, 13 Feb 2026 16:36:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] whpx: x86: optimise MMIO vmexit by only
 restoring needed registers
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Cameron Esfahani <dirty@apple.com>, Peter Maydell
 <peter.maydell@linaro.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260213034556.13471-1-mohamed@unpredictable.fr>
 <20260213034556.13471-11-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260213034556.13471-11-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 13/2/26 04:45, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   include/system/whpx-accel-ops.h |  8 +++++---
>   target/i386/whpx/whpx-all.c     | 12 ++++++++++--
>   2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/include/system/whpx-accel-ops.h b/include/system/whpx-accel-ops.h
> index ed9d4c49f4..469a3a4350 100644
> --- a/include/system/whpx-accel-ops.h
> +++ b/include/system/whpx-accel-ops.h
> @@ -22,11 +22,13 @@ void whpx_cpu_synchronize_post_reset(CPUState *cpu);
>   void whpx_cpu_synchronize_post_init(CPUState *cpu);
>   void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu);
>   
> +/* subset of runtime state for faster returns from vmexit */
> +#define WHPX_SET_FAST_RUNTIME_STATE   1
>   /* state subset only touched by the VCPU itself during runtime */
> -#define WHPX_SET_RUNTIME_STATE   1
> +#define WHPX_SET_RUNTIME_STATE   2
>   /* state subset modified during VCPU reset */
> -#define WHPX_SET_RESET_STATE     2
> +#define WHPX_SET_RESET_STATE     3
>   /* full state set, modified during initialization or on vmload */
> -#define WHPX_SET_FULL_STATE      3
> +#define WHPX_SET_FULL_STATE      4

Could we make this an enum used by whpx_set_registers() @level argument?

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


