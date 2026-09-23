Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBC5C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9SU0-00078g-GY; Wed, 23 Sep 2026 15:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9STv-00077t-13
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:18:16 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9STs-0005ev-Ra
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:18:14 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccd5cef0so822051a91.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 12:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790191091; x=1790795891; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iTcmsIZxlHcLEj4Nb7hdWcReyZmF3W5VheB1cCrtj9Q=;
 b=i78wbcVcfKG6qTrpoO39XNrZ9+vb52jfHx9KjR5SSjfiz8gM6pc4WT4G7J18YZpXr7
 xc/nxelFsMuHbfAIBtT/9YeLaT+ayunGz6OI2NGpTsys5r4WJcFh3Wyn6yfUGiHOMemQ
 QjK7rheFB3vqaGDRo6cSF5R1Z0+SwZz7Sq86BS2xYy+1ROl7ylPQkjVw/stjo2W9VSBf
 vwaB8wlB91II51xU7zUhRvqyKOvu6d62DWyOD6YcHBPZT/FSeWKr2T5an3IHe0S0zlpR
 CMOnIN7D5DL+CZNGpemkK7SNi+7usgpfhSUT5AoplN0MSnX5gaQUK8DIJ4HNSmNqu51N
 Fy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790191091; x=1790795891;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iTcmsIZxlHcLEj4Nb7hdWcReyZmF3W5VheB1cCrtj9Q=;
 b=GzH970D8A2T0AwnrAWROGNkENP348C3ku8zfX4gObk5h7bqwJyxv88H8OUI1k0lTJy
 ih46KfMNA8fxRcSNhitwX1m1bSmeR1mjUmkW39DlhXQGqylDWi/rcVhYpU/EEtYOmdfE
 uYuA5MdmrFXoVnJSnI3L2sT7RUVnPth41e8GiqlRceVtGy/0y8Kp9fqb1iQvh0BlLEP2
 qXE7Wu68ywPKnspa04hRr5iUcXugaTkrJZJLAEb8MtTOsUKuHQTAJofA0zdQmNW2IGLL
 ojDBryr3o8qp5TntjnruHVNASdvz10wPNA3+N5EbslX4+gDOudvPmXpF+lmNHtRk9Pz2
 ZNfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzL5OJ4nBnamsNt4KE9+iCcBtNjXuC1MIzMk3JOZKC81iwCSp350L5HOZbsEU53AgBvbjHmRwlrY486@nongnu.org
X-Gm-Message-State: AFuF++melhqwFT9OrP6ar7md7Kp/4GQHIS4hdP8Cz7hyihkOPhyDbbO7
 Oeq16g8g4p87t7p58PKZsuCLhE8lIsWMJzQuuA8D8WkaIZXdgdPrFbAjG0rct5aVy54=
X-Gm-Gg: AYBFou0eBlP4nsW0S3fovUndPgnEZpzkV9ZDRkW6xhD6xvV028MD0gLATxLFqqaZJW7
 uSUmSadGT7XFDseBKRB3QoZUwYOigQsiXFuV5qEMzKFSwSHNsu4ZlX6bZ7C7uEyoCbAdh1QOoiw
 UgsVDyTvi+wUIaKqUGvmkDJbiLEC69Mze8SbIHqr4xkVJcmrJitVEzXhypywzFs1LWSBmVvXmZ9
 NIX/CF13ELks4gBNBuGxqqpu9in4QJrhCi7D1jE5BO9Xt6UYkBs+LXi84RcnqxdBBk/GOYEN2P0
 npgXpYchZVd08qQNnarQ+JD6Kdc0VAwgcD7ERF4pSuQA9Ulh5fPfk7s6HO7klq2QLbSaeTNmOIt
 0ulVEzw9PO28YR4rYCwNr9vdt+8D2cMG3ik64GnjZn1J7tMiHUlfcEpC/fLBR5zfM49bGnhsu3z
 Q52IYj/ovTJhrhWI3yekhnLJ1af9g5pZ51XGP8ItIzrwUphkGkbZi+uXZeEpPJ0wsoTvsVV8dz5
 H/tqkTLJLDXLr6kNFKtx1PWgJeMJfUaK7IbsWcqC0mJbmUoljA=
X-Received: by 2002:a17:90b:3b48:b0:39e:6c69:f471 with SMTP id
 98e67ed59e1d1-3a098cf4f03mr99491a91.48.1790191090462; 
 Wed, 23 Sep 2026 12:18:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0812c87e9sm2184194a91.3.2026.09.23.12.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:18:09 -0700 (PDT)
Message-ID: <a1572edb-536e-47ff-9220-7146304b1a07@linaro.org>
Date: Wed, 23 Sep 2026 12:18:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/21] target/i386: Use an acquire load for
 interrupt_request
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
 <20260923171116.31276-18-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923171116.31276-18-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/23/26 10:11, Philippe Mathieu-Daudé wrote:
> x86_cpu_has_work() may run without the BQL, but currently reads
> CPUState::interrupt_request directly. Other threads update this
> field with qatomic_or() in cpu_set_interrupt(), so the direct
> read races with an atomic access.
> 
> Load the interrupt request with qatomic_load_acquire(), matching
> cpu_test_interrupt(). This provides the acquire ordering required
> before x86_cpu_pending_interrupt() inspects the CPU state.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/i386/cpu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b97f144aea5..ee1aa3a5a70 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -10640,7 +10640,10 @@ int x86_cpu_pending_interrupt(const CPUState *cs, int interrupt_request)
>   
>   static bool x86_cpu_has_work(CPUState *cs)
>   {
> -    return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
> +    uint32_t pending_interrupts;
> +
> +    pending_interrupts = qatomic_load_acquire(&cs->interrupt_request);
> +    return x86_cpu_pending_interrupt(cs, pending_interrupts) != 0;
>   }
>   #endif /* !CONFIG_USER_ONLY */
>   

For the change overall,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Because of -ftrivial-auto-var-init=zero, I am now in general against 
uninitialized local variables, if at all possible, everywhere.

I know you've added the local variable due to wrapping, and split the 
initialization for the same reason.  In this case, perhaps best to just 
use a shorter variable name:

     uint32_t ir = qatomic_load_acquire(&cs->interrupt_request);
     return x86_cpu_pending_interrupt(cs, ir) != 0;

but in others, just wrap the initialization:

     uint32_t pending_interrupts
         = qatomic_load_acquire(&cs->interrupt_request);


r~

