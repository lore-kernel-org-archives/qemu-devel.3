Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BA5CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 08:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9JaD-00079c-Kw; Thu, 16 Oct 2025 04:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9JaC-00079F-65
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:43:36 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Ja8-0004I6-DP
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:43:35 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so251566f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760604209; x=1761209009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PfO8Bqw24aY8UQfvgDISQNPAy8UKhI0RZGjusezawN4=;
 b=i3PeQo/TU1On2eOk+pYLQTLRx/0fRc7QUucbqk8R5QkpW2Rr3c+HNSwSVGVYPKqKz8
 w33PV2oPAETePWTx0Ug6tiLMc3epHJKISQrvoeh1eAfrYKQ6YNbA69AZ4rFOAwMD/l+u
 C2pYmLhU3Kc5t/VquW8VP1RM4CkG1L5E1mFcq9G5gLKuBNClV1BQ2tWTd4wKpxON54ZO
 1YoYN2cZDFyGdo6eOuGZDUpEHYPAthvi5GDvohEWtdE03x7vaH/5xGEGIa/q0IPXRUfH
 tw31CCpBS+KsiFEKs1tbja5tiY1t63lXVGSwlCvug/Rdi57pB8bTQTCTEIF11qcFs02t
 Xfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760604209; x=1761209009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PfO8Bqw24aY8UQfvgDISQNPAy8UKhI0RZGjusezawN4=;
 b=wEcD40CfI4j+szZxzk9Ty4Y4nExKCTGfVulAhgQoHHW9WFOjLtcDNT3Y9XivxZiGcd
 9mFwPBMg3t+36mFxIAniHYTgSAt0HjPtpWmMp6KWQ9Mk7ZK+yOPlvXUAJYHH63FaEaY5
 nMjrU5br5N8MIll14UoqdU4Sc0kIOOUn7EGlpGugo3rTaApn6B9On2L4baykJaBhJyeB
 i8nTDMUKaNhJcVLT9hqvK9kb7Wa5AQ10BSjElV9KXOsBVtHvQfriGt7cZREiojab2are
 EkBH3+MEg4tcPDuitb6vQpmyRJREi4U0QzfDcAC/DTxlTYz7uPPz7bQICK07T/BV0MTW
 REGQ==
X-Gm-Message-State: AOJu0Yx17k6+zKeOWd3kgAVbSzhlDZTOYvqWSwvbCpogRd4cNUKp1OCY
 mYDMyVFEn4MCMM9vFyIfjQDcd78CKKQRVn76uCBm7z/KQjr9G3doU7J1GFBnsdfRdh4=
X-Gm-Gg: ASbGncuwQIaXaN/Zi+uWRo3oDOTaXgDyLgQKNgT4BllniKLI2fEjEXmOi93c1SZZCgU
 6SVHecRaovbdYFYHievJXlkRiSkREe4j6K3ehauzLwRCWpIAcKN4DD1yWWGI8HYuFEcnqUWVDB7
 bhfqGgnTc7BIx8GC8Fq1Lw3UzZSpnc4RPqMBmTu9HLM0Y4XFyEZ2wK2vL/B75SOWHoVWwrWpLSy
 YrtjNorkMVNnvM4rrH2Ue1OO8BF0PJlUR19gPrRRkK1yTruUQcDguozkXO9VvHvT1diqjxZvfJo
 CE8UM/9+EEOp4ft30LcpXGyDG85N/9p77plRfqNHsCi4uaPel4SDg80YMiZDUi3HXADaJJTnzPl
 dIiWAkwspQRmQ1DdBfFcG1KFxCbHYUIwnvN9D8WIqMpdyqYKHjF0iV37eb5dN+KVVd/yx6bNsB1
 TBg59qKCZ+dywp0caUDxSlaZfCT1a934P2Tm1egu3vmeEn4pV2saQAYxjJyA==
X-Google-Smtp-Source: AGHT+IF5ia8MUrk2acFHeC8LK1ngyqqP/cNGopn34gWan1YwSXBv/5w0UfYrqiL7T7Uo3kiF14zeDg==
X-Received: by 2002:a05:6000:41d1:b0:403:6f7d:ac5d with SMTP id
 ffacd0b85a97d-4266e7dfaf4mr19172767f8f.34.1760604208611; 
 Thu, 16 Oct 2025 01:43:28 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426f2f72e18sm12108312f8f.0.2025.10.16.01.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 01:43:28 -0700 (PDT)
Message-ID: <c82e0b7d-c22c-41b5-a9e8-757a590cf719@linaro.org>
Date: Thu, 16 Oct 2025 10:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/i386: Use X86ASIdx_MEM in kvm_init()
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20251014094216.164306-1-xiaoyao.li@intel.com>
 <20251014094216.164306-3-xiaoyao.li@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251014094216.164306-3-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 14/10/25 11:42, Xiaoyao Li wrote:
> When the patch introduces 'enum X86ADIdx'[0] got merged, it somehow
> missed the change to replace as id 0 with X86ASIdx_MEM in kvm_init().
> 
> Change the leftover in kvm_init() to make the usage consistent.
> 
> [0] https://lore.kernel.org/qemu-devel/20250730095253.1833411-3-xiaoyao.li@intel.com/
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   accel/kvm/kvm-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 58802f7c3cc1..3030c47d55b1 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2800,7 +2800,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
>       s->memory_listener.listener.coalesced_io_del = kvm_uncoalesce_mmio_region;
>   
>       kvm_memory_listener_register(s, &s->memory_listener,
> -                                 &address_space_memory, 0, "kvm-memory");
> +                                 &address_space_memory, X86ASIdx_MEM, "kvm-memory");

NAck: this is a generic code use by multiple architectures.

