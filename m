Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F57CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDdsl-0008Oq-1o; Tue, 28 Oct 2025 03:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDdsi-0008OR-KY
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:12:36 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDdsf-0002Jg-5D
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:12:36 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4270a3464bcso4284629f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761635548; x=1762240348; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2eyPeRdTi9DR6hNz+OGbBGy5k1W4Dg/6JQzzzu/0uuo=;
 b=BzpkTcw1xGpxD86kq5mHVfS8s4cqUucnj1UUeRa/Di9rszytsuzLbWc75L7rgbvF5g
 +MNVZFMb92L5LRxlUebamrkyekJ2lA9vVqOHkxR5PLs1ZPsfLl6I+rkn4XF/X+q1lAyD
 56v+4JDZ1HM28z5lrZBYQf1rXyrEVRBx6FCeR3HRjTlBfUtAzD4lQQliUygX86MDNwC5
 vgbgROv2Wqls5PnX8y9WIUCol79dhlyo7s76ZpPzpF+TNEf4yWhPTK354m9JTdN99hzK
 m+oBBNI0Dqn2aPPsMEamaAOL55be60wknC893J7pY5QnJFLRoVQKyL8S4PhW81AySc1k
 JNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761635548; x=1762240348;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2eyPeRdTi9DR6hNz+OGbBGy5k1W4Dg/6JQzzzu/0uuo=;
 b=DoWxS22PyppbdKUyQDcEG2wU9hiC6VA8wEVOmI53KMq7AeGQveGKc3L8nOdvbkcaRR
 uFHG7AfoG2gssEat6tZTlaiuisA9kaW9mZGHWfCztpElFjFJN4lGHhNCNabqlex0TFrd
 CPS0ue57H3FEnkA0ah2t7u9WSxPePPUTnbUZSOhEleFqcH64ifZw5j6GX4Ji1MUAfwFI
 bDJAwvufyAPRwYvFFqhp6UGjaXX7fMaRWRGHUEx2RVFaSkxh/luzGOwNd/xBh1vjQQN6
 idmGAg71q/epfWQRGrCUMIj7mXRIVNkofWXLVK/g638EvwPnbD8BG5AwU3F/dyXX93nq
 Qwwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+L5JZpCcdN/izw3tAq2zfXD+tTpFWeAOmTOSaOk62cG50XnUDk2jeBqh9MrtuHZCWX8QoB66pv0Bg@nongnu.org
X-Gm-Message-State: AOJu0YyqbUYaec8c1oX9JIV+Eih9+yR/yH3TSS/5vIcWMjEENS8SXP7D
 v/iXgrtcEm27ZFUujULeakhEkmCmttAPh0u+MhXG5esQvTQXehUpU0q7awI+zKwRuJY=
X-Gm-Gg: ASbGnctucyyAwyvvjtYYK9RMdaw5pX5/0sAR8atIeK/IWF5yYuJls6K4Cm4iBKVRXwv
 +WFPDGur1atVfNwhAvgtIMGMLKIMIXov18mhCtE1OBP3PPJO5rwxHSfZyAdGJeA40hHUAOSeq0t
 uL3XgufHPwQAghCUeTqREwd0QBcCJGHVoszum0hxISyg5bI+Adw+pVI0MUYxvQV3qKjoSMFzpWe
 uMzEga46oFV9FcIzUt8hILaimG4JsVO6Dm9D2m4i3t5muK/hALrLllSFOGcy6qlys4cJDmcW9AS
 JNQURyZGXg1YedMaBCBo+LoK5bWPOMi5r3KKdh8KzOFvSN95XoRCX54d1Pe7zZVsH2zeVeREUfW
 QQ39Lnfx7fzV8874fD0DoK/KBSP85pXLj4Q/mJiWyx3J4LtM6YIIzOetnhvnXu9umcBiUIOUjUb
 XdxPNMgOKE95cE1ngzo4oSok+QEutQoNwi2FOCBpuGdVJDrx2r
X-Google-Smtp-Source: AGHT+IGeOPb8PjoRQdvmllBb/t0c+cJMFylm6cnb+Li9e5LasjD7avAjnym0TBCIn16iLyksFyftaw==
X-Received: by 2002:a05:6000:65c:b0:429:a894:a2f2 with SMTP id
 ffacd0b85a97d-429a894a4bcmr1073055f8f.34.1761635548592; 
 Tue, 28 Oct 2025 00:12:28 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952da645sm17818885f8f.30.2025.10.28.00.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 00:12:28 -0700 (PDT)
Message-ID: <94cebbf2-5883-4fa7-9b86-f8bf0f3332c1@linaro.org>
Date: Tue, 28 Oct 2025 08:12:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/ppc: Fix memory leak in get_cpu_state_data()
To: Shivang Upadhyay <shivangu@linux.ibm.com>, peter.maydell@linaro.org
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 sourabhjain@linux.ibm.com
References: <20251028065815.84156-1-shivangu@linux.ibm.com>
 <20251028065815.84156-2-shivangu@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251028065815.84156-2-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi Shivang,

On 28/10/25 07:58, Shivang Upadhyay wrote:
> Fixes coverity (CID 1642024)
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA_Bm52bkPi9MH_uugXRR5fj48RtpbOnPNFQtbX=7Mz_yw@mail.gmail.com/
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   hw/ppc/spapr_fadump.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
> index 883a60cdcf..49d2f862a1 100644
> --- a/hw/ppc/spapr_fadump.c
> +++ b/hw/ppc/spapr_fadump.c
> @@ -453,7 +453,7 @@ static FadumpRegEntry *populate_cpu_reg_entries(CPUState *cpu,
>   static void *get_cpu_state_data(uint64_t *cpu_state_len)
>   {
>       FadumpRegSaveAreaHeader reg_save_hdr;
> -    FadumpRegEntry *reg_entries;
> +    g_autofree FadumpRegEntry *reg_entries;

g_autofree pointers have to be NULL-initialized. I don't remember why,
likely CPP warnings.

>       FadumpRegEntry *curr_reg_entry;
>       CPUState *cpu;
>   


