Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE77AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 13:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seaqq-0005zP-CI; Thu, 15 Aug 2024 09:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seaqo-0005ym-Jn
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:49:14 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seaqm-0006oS-Ok
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:49:14 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5314c6dbaa5so1253079e87.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 06:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723729750; x=1724334550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LI//osMZqC0eYbh6hJFEo91a+k43wyEfgs5uXZLeaWE=;
 b=M8Nl9pbXqkVpnHf6vyqSNIwd1YK4/p3h8TUdVhRPR+j9pU++hTuqqEEQ1o6SMve5Dt
 GMzSB1vx1dNgpr0WZop6nViizMNPr4znsEG3bd2ZsJIh2vfDL3OD9aOqg6dYGM5JSq3J
 phiNu1mkwMWrKYVOtyATFGn2M+uozCPCUHt8+tzpJqpnJtKp67BhxCGVANhSUCPKFzzL
 NeTiEx+oMCGUN8wzkBJmo6YTKYXsDyAJ4pOsUlo129u5m737OtkfjOUKvtudSkAOINWw
 8MmCH54hIEG/LKp0gV2Er5DxLKmYw1AzTflyePvFrN5/grbmgiXI84LPVx0h12Dux+eD
 VrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723729750; x=1724334550;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LI//osMZqC0eYbh6hJFEo91a+k43wyEfgs5uXZLeaWE=;
 b=hSv3OUikKmBZxNm4oV64mBN/k92Y4L4pVKDrOnnNQ1xy3QTG+tMrbj0imOJ77APRjB
 QxLysNqqtblMhSk96LjaBawh5Wn9ltlNWCmF+S2Vu00Lc/dnU9D9IobEL2kQjtiNNVSo
 kNJAuk0HgwDZsSc57oAfyJbobNqPyQevA3cF3izNAIHo6PnpJ7yOLzl/7UEFEcOAgDQZ
 Qthd6vilRlBIcX3dHRhmwY/6ZZwo+wmCLf2PmH65Ks5200ZeJ+lHQGHbi/c1nze3f9ZT
 CvHDMZmAjh2spvXCQJaRwWh9fxwA7K80bkBvd9vUMKGk58K5s2MBupQ8IP98n+zVZ628
 1hFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7Hb+9A1eq0Mwrw17HEmLzYdisw57iEUxbqDXc6dPa2OZi05pzLmO3H/u7qtXaXzCI+UsCqTIWCr1w6s95G1B8dM26LlI=
X-Gm-Message-State: AOJu0YywqyrIZVtMksSBjQVBnGsoSLHCSBdmr+Ux9kZAo97M9sLZdoBM
 N6byUX41fXPpvZDbjnblZEeXvYRdTmccA/bu22dOaiHfrVMAGctmVb1wbucZ8LI=
X-Google-Smtp-Source: AGHT+IGxDh5SNhNTVytsCPYFawGpaTCpK1lMyssFQ8bV7jKg+P7reitFfr3/UbXyw9FfJooc60GzHw==
X-Received: by 2002:a05:6512:3049:b0:52d:215b:9028 with SMTP id
 2adb3069b0e04-532edc19a2fmr3355100e87.60.1723729749373; 
 Thu, 15 Aug 2024 06:49:09 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cfa02sm105143266b.81.2024.08.15.06.49.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 06:49:08 -0700 (PDT)
Message-ID: <7ab4bda7-4962-4f06-ab51-e79cfaebdf99@linaro.org>
Date: Thu, 15 Aug 2024 15:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 1/2] kvm: Make 'mmap_size' be 'int' in
 kvm_init_vcpu(), do_kvm_destroy_vcpu()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240815131206.3231819-1-peter.maydell@linaro.org>
 <20240815131206.3231819-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240815131206.3231819-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/8/24 15:12, Peter Maydell wrote:
> In kvm_init_vcpu()and do_kvm_destroy_vcpu(), the return value from
>    kvm_ioctl(..., KVM_GET_VCPU_MMAP_SIZE, ...)
> is an 'int', but we put it into a 'long' logal variable mmap_size.

Typo "local".

> Coverity then complains that there might be a truncation when we copy
> that value into the 'int ret' which we use for returning a value in
> an error-exit codepath. This can't ever actually overflow because
> the value was in an 'int' to start with, but it makes more sense
> to use 'int' for mmap_size so we don't do the widen-then-narrow
> sequence in the first place.
> 
> Resolves: Coverity CID 1547515
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Borderline whether this was worth changing, but I came down on
> the side of "yes".
> ---
>   accel/kvm/kvm-all.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


