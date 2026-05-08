Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4BECD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 20:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLSAh-0005Dn-MK; Fri, 08 May 2026 16:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLSAf-0005Dd-Ss
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:51:42 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLSAe-0004qC-Ba
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:51:41 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4645dde00a7so2986892b6e.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 13:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778273499; x=1778878299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xc3PbEbBStGIO86GS4bBdb+CpCEF6qp9AqH6wNuVAII=;
 b=Au8ggFlFQNEE+nH7kf59H6sSGh66YRp6EX9tD0nK2W4e/G42/1pg0+wz4WQuLL5cRG
 8S0Nbb5oKap+G1hY6aNN81ARMzLc+eVsjDAlyuMiSUE2dh4lGLF1cCLlVT7xaLhqHa2Y
 lyCiOgBv4PYF2SapbwmPuMOkCC3+Jt4RWui4gDDDXWFOlZbwDUDf5UOXcVyiCuaLTfJ6
 8851mFV5TPCYUDka9nh8aRhn+vS7sxof/qNjBwz7Je8vlF0UGJsjihUgVoGATMYy3j8g
 iHNfThe1GbrklbM1y+XwCvhPOhwDTnRJ3mC2Gtcs1RJ4hEI4k5y/Sr5BTlQenRjRwULM
 ieuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778273499; x=1778878299;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xc3PbEbBStGIO86GS4bBdb+CpCEF6qp9AqH6wNuVAII=;
 b=fxZGpDS6N5aJc4vERPIOBEd6MhN1ztZysgTkl3W2pCCJ/gY/6ISTuZq2+KNdOB64tK
 QJCt5DpFiTE1FEAIrPz2XDG3E7QHehKr3d3NZ2nOrxDEV2jenqjFVesnfr/uCyliBdV/
 aHjEENV/Vpmx6lsGF5ptlyXgQuFS+HMB1d7EiIntqTzuD/pukPNfws/PY+mlV+RVZsTE
 kgjq4cGNVBHC3VPwbEQTahwV/DNKxbtmVaAd89afIgDD7j9PZavLPMOWhoqbpAO+uZ8E
 QZb6r862VSoPDjYsTvT6i6PCcY3FLxr9lKG7G5lGEo084P0k8IwcNTFJMqyDvZ10IQiW
 Lc9w==
X-Gm-Message-State: AOJu0YyqCH/gnHFB5opz46n52Og9CsIdURxaCGHoGOzy2H002vGTdwYy
 Oo8YiS1frTsBqAhznp/YFmQCuJNmwQJoo3kGrue3WjOT3cXH7tfhC3Ff+S7Mcz4zJRotQpYYWc5
 YORlg
X-Gm-Gg: AeBDiet9zgEh7E6cxNqvKK0fqqYGmeeF/H6X/aWuqOeNriUVX4L9DEBEAIagDXTpdMZ
 UR/UcG7+WbXNCVkWoleBa8VtOR9wF963D6GJ2EmuUtUISx4bhbsTDKD8k2CyCiOUcuXDn0My0q+
 SzNWwJDTvD2t6rhmyfE/wBEFrCzh1S1bxAc8y5NkUvIQ18prU/IHSJzzV3jKnWLLiQF9TGohWM/
 bFj4llq0L+8Z4CYgjzeMWhsmdUrwAISiMNXqk8/ImA92jLQin8WoRdJEuz6CzduLvDjRKYlCCpG
 pzzeRKZqYV076CexJmxnKjKqTQFryj3Nnqqtb9VIVL0+Ju4oXTBeGrpGN4Ko9SiDcrpnQQlLlHP
 a8+XHvTJaOoGBhHQ0069JZdgfXcunUhFS92vVCrBYZxbXi2/yrE14zQ2bVLjlQCa6g8oRLR6PHV
 IaqKXqj9ABBT83PIICAKK5dzYK24njQ/DIU5Ux4KGK7oX/fmocYdwEu73TuX42uM+yo4cdsZkck
 snBt0jcwmF1b37MiA==
X-Received: by 2002:a05:6808:5087:b0:470:d1f:de69 with SMTP id
 5614622812f47-48061cbb0abmr4500243b6e.26.1778273498759; 
 Fri, 08 May 2026 13:51:38 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1a91:1de:21e3:45a9:5df:5a65?
 ([2607:fb91:1a91:1de:21e3:45a9:5df:5a65])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435570ac21csm2739769fac.3.2026.05.08.13.51.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 13:51:38 -0700 (PDT)
Message-ID: <b1dc5a1e-9abf-47cf-8f71-31494d434a3e@linaro.org>
Date: Fri, 8 May 2026 15:51:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] tests/functional/test_kvm.py: Use -cpu max, not
 cortex-a72
To: qemu-devel@nongnu.org
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
 <20260507194728.2034696-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260507194728.2034696-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 5/7/26 14:47, Peter Maydell wrote:
> The test_kvm test claims to run on any accelerator supporting
> nested virtualization, but it specifies the cortex-a72 CPU.
> This doesn't exist for KVM-only builds. Use max instead.
> 
> This fixes a failure like
>    Output: qemu-system-aarch64: unable to find CPU model 'cortex-a72'
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/functional/aarch64/test_kvm.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
> index 7545f5ed55..fed18aba60 100755
> --- a/tests/functional/aarch64/test_kvm.py
> +++ b/tests/functional/aarch64/test_kvm.py
> @@ -38,7 +38,7 @@ def _launch_guest(self, kvm_mode="nvhe"):
>           kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>                                  f"console=ttyAMA0 kvm-arm.mode={kvm_mode}")
>   
> -        self.vm.add_args("-cpu", "cortex-a72")
> +        self.vm.add_args("-cpu", "max")
>           self.vm.add_args("-machine", "virt,gic-version=3,virtualization=on",
>                            '-kernel', kernel_path,
>                            '-append', kernel_command_line)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

