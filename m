Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9DDCCF9EE
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiV8-0002Ht-FZ; Tue, 28 Oct 2025 08:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiUs-0002E7-UB
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:08:18 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiUi-0001MB-IK
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:08:18 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-63d6ee383bdso12649619a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761653278; x=1762258078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mRWm1zs1ZSTsjB0/sE2IVoBc6nV+MdO1F7LWXGLtaaY=;
 b=GrNse1OV9vSrxZAr4eLwny1CIRRYQppTbuLxVYI02WUu1eR7GuHG+WsIu+/wSi/XiF
 zyzwxGySqN84sqR2zyT/MVP7j1MDOf7Qn/catbriS4rDYlkQLMNNSwJlwiLgxIlo7sEh
 MezstI7vyw3mwOLCHs5vy2iolGrVgXTK8toxJLuwjijPO1u9XLqe60qomfXRuzJSUrA5
 mM230pmIMLpCeQbf1Z2GyEp22G7cObF7cEubarrRMQJdMYF0u2om5KYVJjjrwTAfQNe/
 xgsFLUcHMi0KQVka1T/AxW8HpLezhsBuf3rN3+imS0jGuZdw2vras/hP+oxnx7fOodSd
 Dohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761653278; x=1762258078;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mRWm1zs1ZSTsjB0/sE2IVoBc6nV+MdO1F7LWXGLtaaY=;
 b=ANfqpLWq81ri3XQ3ns/BiCLDNiKFxrtQCRachTIKfuQE/SNBupMv5sQp+yRQ9vBIW2
 yItATH2yyJvY0V6OM/65wdHNtIviiHqEXC6OpIHy+tNyVc3Qks/N6O30T0iTJvReYv1E
 bQvD0Iz8vfPzGEDz4WPveTbSg7WmjJaHdVcplzdDzxLQ3pJBYaEIAa8AlXx2y0JveNCE
 utUNTO1zdHPMjrdRO8NOnBsLPCVo5nlzL1j+pIDSaNyQiw8XaLGjoKQe8zyPbX67cp9i
 05pqbn3hn9lA7j+huOLXiprphMrF115VIGf2c15ecXAV1FZakBzyAjWIepPPmbg60JK9
 sIpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcT0LlLqcyudIDj9b03BfhaJ2eMSMUCyU9+pbquI7dCaKRTxjU+HoPCVLtyYARNPHiaCc2G11xu/1X@nongnu.org
X-Gm-Message-State: AOJu0YxRLdcPhKy5+SKgc2R/5+n6BIjc3POQXr8BVGqNBS2r5p6vmbME
 CeQfS7TIiVgChdqJtzdtJUbDISwSRPWH0eBT8fIqXbbwQ8ZBAnRGJsEcgu9FQ9k14H8=
X-Gm-Gg: ASbGnctruXic4SdU1FMDxtVBWeazqLepPVkKIsFtgDMB+Q4ZdNZEutGHRxASlzz7JMb
 fUmlbZ7cJjnWgMJb8MtkwBMjwnEpvKALQ0c1BNG8FvEcNF7HxORDEb9LrbXnfgeX7eTp6YBZvPr
 KlzOsMy/GhdQnfkfnLizgk4sBeoBi8gi1hnrMrzfW1Xsh+xh5m8sDHduZgwPGLk1J7QeoRMznIm
 3sHuLcmz5/2MChgg9kMc9GvvzTwtpXCruhtMHffd04DReejFgIBSl015EgJZb3bVQLUvCSUqkPU
 0xdHFC4Vd2tmU7wEO2QLhLluwvjT4gTiK2itnoUfh//1Vbc0IuiNNqkoVmgpEGYKq7bZ7IZso20
 M0N5OJcOEwrfuQ4CXT68cTli64dk/Yadx6YSnPIEVZzuslowvNVPj15aS23X4VinSIbfEfHCybt
 JqonSpNDNutk06R1JL
X-Google-Smtp-Source: AGHT+IGzklmrJDc07AX8M1iJoNpr/arLebtD6ln73xdt0NlP+vQAZznadXDb9QxJrRy2RBPEDDayYg==
X-Received: by 2002:a05:6402:5110:b0:63c:3efe:d98a with SMTP id
 4fb4d7f45d1cf-63ed84999abmr2850628a12.32.1761653278130; 
 Tue, 28 Oct 2025 05:07:58 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef9a5cbsm8973675a12.23.2025.10.28.05.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 05:07:57 -0700 (PDT)
Message-ID: <cd27bf13-a8ef-4b7a-bfea-0e4220091ec1@linaro.org>
Date: Tue, 28 Oct 2025 13:07:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 51/59] hw/arm/virt: Warn when HVF doesn't report IPA
 bit length
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-52-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028054238.14949-52-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52d.google.com
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

On 10/28/25 06:42, Philippe Mathieu-Daudé wrote:
> Emit a warning when HVF doesn't return the IPA bit length
> and return -1 as "this accelerator is not usable", allowing
> QEMU to try with the next one (when using '-accel hvf:tcg').
> 
> Reported-by: Ivan Krasilnikov
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2981
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 175023897a7..1d65fa471dc 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3225,8 +3225,12 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
>   {
>       VirtMachineState *vms = VIRT_MACHINE(ms);
>   
> -    int default_ipa_size = hvf_arm_get_default_ipa_bit_size();
> -    int max_ipa_size = hvf_arm_get_max_ipa_bit_size();
> +    uint32_t default_ipa_size = hvf_arm_get_default_ipa_bit_size();
> +    uint32_t max_ipa_size = hvf_arm_get_max_ipa_bit_size();
> +    if (!default_ipa_size || !max_ipa_size) {
> +        warn_report("HVF didn't report IPA bit length");
> +        return -1;
> +    }

I suppose this goes back to the previous patch.
It might have been slightly less confusing to merge them, but the underlying questions 
about when and how this can fail remain.


r~

