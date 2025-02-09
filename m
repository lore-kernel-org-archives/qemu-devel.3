Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5A9C0219B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 17:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thBQK-0004kB-Ht; Sun, 09 Feb 2025 12:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thBQI-0004jm-Fd
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 12:48:50 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thBQ6-0000TL-VU
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 12:48:50 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso23890865e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 09:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739123316; x=1739728116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MfUfwyyOf6ikTKqC5ppl2P595P0uuLiq/UPwbIU/2wE=;
 b=lT/5vakUwq3GvdoSAxQHe33wJafFEfvDTrha2ZnEFGb42Qoah8bUTcRO7c8ydoZbgX
 pYPwfN7y8LOz9/6jiy/IwGCEctr2XAO5EZk/1/AoBbOG4Z5z8T6bmZjRQwM6hfCP2LR8
 QIVUPsp/NMOm7shHdBGjJCDuOAyMz8i376y2OMMXOjAVmQIiyYWo/2Xq+aklV84UvH11
 PIUNgIJOSoHspDQ9i4dJC8S7ta8w2GvrkBbzFeGDrgHIJfRO9DiXRlpxcgtQsjnpl2Kp
 HnQ7STClk5NKbEKcgCB2AM2O4r1heV4Zj88lQy5S8Ibck2L+hxV/9Ee/TuMcFi9zQSCg
 jjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739123316; x=1739728116;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MfUfwyyOf6ikTKqC5ppl2P595P0uuLiq/UPwbIU/2wE=;
 b=a3wLM04wgGd7IS0vEjJWTDvk3+s5FCHKDiNjE3132sn/pXsoRkx2OeKnVLmehFNmw3
 sIgddonUWzXV744gmikHsqH5969wz6Wnnz3in+OBUiCuHEjBaV4TBHKfRKFIR//t/OPF
 WF5+cKx9hEq6cjk1uIMjUldEuSfe6sz+XRJPCG5Wu5C8/PRqJL+EU98Zq2wDrRg1ISmD
 SVKgVhFyV/o/mPbCLPR8gKUe9PvH0f11oIt9qjmmCzkcsWLqAzs1gnAIRy/qL4nXEKnL
 UqGJY/pUOXGUAw7aDerAbWePq6DW6WfueFpL2axugxIL1XhpkE4xBsDV99oVWA93e1hV
 ns9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCULXMztyoI6RvIXZTqYxedV35T03CZ0DDSyBlcPIZXU5q842luxLOGMXWFDdMzzbTStB4kUaA52Dtfl@nongnu.org
X-Gm-Message-State: AOJu0YyOgr8vUyUhCMTLri9uIjqsTkGqFao9xWRSq9iqfQDmaboAiADA
 enDcHYq6dp+cfTISxc95KbDuk7NqQWOcGnUcR2lw80SpMwnTD7I6xjp0eRqkgiU=
X-Gm-Gg: ASbGncvNn09SotwOPxW2eWb3HkyqQNma89ztEt+i3FTNwxb82zkOLfGBPEbnXK4gnST
 3Np+/1FcBC1OyKtVnDTlomnRrCDdA9DtNzdvZsZrWmCZOjXfru6F4KbTy8zzT0x1FVgwKj2rFxp
 1xhvyUEeFlXy3tmcFKApti82UBoFmBnFMh3Gu1hvXBDhX6mV1meVSezn1A/ihavlxSB5uiSzho2
 ZlgPYR2tN5EdsyHv7e6CM44ztOeCONcLkEW5gyxn85YtSpDn9rHX8dccgODEhO6iBWGkGfawVQI
 Yson2D/9kM4IVMpYmijMs7M2D8/l6LQMGPPbxm5De6eygV6idkoECr4DSu4=
X-Google-Smtp-Source: AGHT+IGd/XDb34EkKfmSFZhWJPhrnA7A7SmQh2tvM08VpfMHBBzMH15Yi4MnSVh5ay2LnzkfnAYyag==
X-Received: by 2002:a05:600c:895:b0:439:331b:e34d with SMTP id
 5b1f17b1804b1-439331be5aemr46083675e9.5.1739123316433; 
 Sun, 09 Feb 2025 09:48:36 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4394376118esm10137065e9.40.2025.02.09.09.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2025 09:48:35 -0800 (PST)
Message-ID: <62ad5a5b-9860-42dc-a4f3-37f504f3ded6@linaro.org>
Date: Sun, 9 Feb 2025 18:48:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] target/loongarch: fix vcpu reset command word issue
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 kvm-devel <kvm@vger.kernel.org>
Cc: Bibo Mao <Maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <20250208075023.5647-1-lixianglai@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250208075023.5647-1-lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi,

On 8/2/25 08:50, Xianglai Li wrote:
> When the KVM_REG_LOONGARCH_VCPU_RESET command word
> is sent to the kernel through the kvm_set_one_reg interface,
> the parameter source needs to be a legal address,
> otherwise the kernel will return an error and the command word
> will fail to be sent.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <Maobibo@loongson.cn>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Xianglai Li <lixianglai@loongson.cn>
> 
> CHANGE:
> V2<-V1:
>    1.Sets the initial value of the variable and
>    adds a function return value judgment and prints a log
> 
>   target/loongarch/kvm/kvm.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index a3f55155b0..3f499e60ab 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -581,9 +581,14 @@ static int kvm_loongarch_get_lbt(CPUState *cs)
>   void kvm_arch_reset_vcpu(CPUState *cs)
>   {
>       CPULoongArchState *env = cpu_env(cs);
> +    int ret = 0;
> +    uint64_t unused = 0;
>   
>       env->mp_state = KVM_MP_STATE_RUNNABLE;
> -    kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, 0);
> +    ret = kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, &unused);
> +    if (ret) {
> +        error_report("Failed to set KVM_REG_LOONGARCH_VCPU_RESET");

If this call fails, I'd not rely on the state of the VM. What about:

if (ret < 0) {
     error_report("Failed to set KVM_REG_LOONGARCH_VCPU_RESET: %s",
                  strerror(errno));
     exit(EXIT_FAILURE);
}

?

> +    }
>   }
>   
>   static int kvm_loongarch_get_mpstate(CPUState *cs)


