Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A008AC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLmg-0002Py-Kd; Thu, 02 Jul 2026 14:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLmZ-0002Nh-SX
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:05:03 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLmY-0001en-1x
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:05:03 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2c9878bbe88so6443615ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783015500; x=1783620300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ty6sPRZKsfLeIQxEZn4vR/djGbORUYzyvw3zsIK1C6k=;
 b=vIQYQAiZVswWDEcK9qjaHIbMghYagjOjeSsEcF7clfweM4djZCvBAy1hreXWhnG14d
 kmvSy1rpOUvauS7PSGWyLTlhBAkuHUgLmPJrMIWJh/bhcAYqwInL5MCsrvVcivG5Iesq
 NPEB3k95UJk68N7caQ9djh18LKv0yhc8W+qUE96Jz67qYq5QxH4VxY+r4lGGzecLdRYm
 hv87GRqioLhJdX176x9i60rqTzuA+i6fevK3/4WH5uH4HDzuqLxREulIT1873MdbLOY4
 dmmtf7jd8jd/5LT/8B8meR0mVew7AhxH21/gEGt2VI0cnLpiDu+KlUZqmkNzjxeVoNLM
 M76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783015500; x=1783620300;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ty6sPRZKsfLeIQxEZn4vR/djGbORUYzyvw3zsIK1C6k=;
 b=qsU7t6+fRDq95lMQB48KHePpFUWYY3i12X0PJ0F3Tb75p3kYbE5ng6hR1jeAuX8DRM
 GSAErAba6t4LT9LTePEYdgx+3Rj7piVGlTBZ33EzXYW28ZFmB/+/Q57qVJ4HoDr5mqw5
 bZD6kB77ugbaLb2Xz0qCtulPOs/EUc+U6f4SBUgn9KhZWQO9neN+JeTyOYnOVg007M9x
 qIB/fnS21OeFpw8Sm9XvZ3kNDcHrcEJZ4AP2/kIjELjgCmCyCBX8dCx2T6+ai3sFHO1k
 IuLki1i18pqIhyNWTJHVbLuK205sBqlx9ymNNI6W8uHgbrwlqipc1XS8g4hduEV+Gg9f
 wRZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RquH7r579DhQmMiH+s9A5lNLYgg3YG3heMHaccNM+U/ixbHZOKwsjuMgsSKijj+BlT+aGotH/wScmkw@nongnu.org
X-Gm-Message-State: AOJu0Yw7yFNEYpKJdJ7N4uIZfv2lb3JX7Kw7GK6eJHRzPmc0ObtbHdHd
 CUHJRWFKuKhhBE+K9FcvqMH+QgjCVc+1JXxUWA+smx03LYSzJ2Qf7Uhv1TBeEHrBfPM=
X-Gm-Gg: AfdE7cnpcHYq6YaCkYJGdeSMSWoF7gtzJbmXgr29Ai4lRBvBAEWhO6LGLlmN3iHgMsN
 AKeB9K8fHzSt0ZItNGjcMJLEwyurSfVjNVu7eZ7eaugzUrHbm+3K8Rf88Q9US2IFx6uSLzwcw9c
 U/qey6p3bv+z9hKRvI/LrSK4L2dKSTyAZgFLN60LL2IfDqtDtWhCtICc8dhDxjWMmCxooCymRZW
 Tw5qS7gVsQraDP/n6MLMnqBQPjyIHEffOaTzm9IccjUXMCBIjp4aermc77Qaj6pPL631dhwPwQX
 IQ2c1wHxQQ3Lej13H07Gtin43qHkFNIkyagZ8M52cNa02V2Kg9vWdB1eh4mfCXGckH63l9YfREm
 lTqPYpwfzJXBisPz2IJQXTgoov5GdPmkCRkuDITd7loDvX+N4e1FWfSdd8vnEErPyvApsWypKIU
 RWwKn9EuwWzDpxc1iDsk9ait6qtjdyo1F7CWLplVaN3RUM3XfTKPBMI87kA/5SNfeGqFCo
X-Received: by 2002:a17:903:3c6b:b0:2c9:d56d:afa3 with SMTP id
 d9443c01a7336-2cacb070082mr8507145ad.15.1783015499543; 
 Thu, 02 Jul 2026 11:04:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9a911fcesm17279325ad.28.2026.07.02.11.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 11:04:59 -0700 (PDT)
Message-ID: <d7a48ff2-ae15-4366-8399-9738a06298f3@linaro.org>
Date: Thu, 2 Jul 2026 11:04:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/33] accel/tcg: Improve docstrings around
 TCGCPUOps::*watchpoint* handlers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-29-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-29-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Commit d5ee641cfc5 ("target/ppc: Implement watchpoint debug facility
> for v2.07S") also implemented TCGCPUOps::debug_check_watchpoint for
> PPC: make the comment generic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-ops.h | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
> index f64d94b2b50..568d82cdd32 100644
> --- a/include/accel/tcg/cpu-ops.h
> +++ b/include/accel/tcg/cpu-ops.h
> @@ -250,14 +250,13 @@ struct TCGCPUOps {
>                                              int mmu_idx, uintptr_t retaddr);
>   
>       /**
> -     * @adjust_watchpoint_address: hack for cpu_check_watchpoint used by ARM
> +     * @adjust_watchpoint_address: hack for cpu_check_watchpoint (used by ARM)
>        */
>       vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
>   
>       /**
>        * @debug_check_watchpoint: return true if the architectural
> -     * watchpoint whose address has matched should really fire, used by ARM
> -     * and RISC-V
> +     * watchpoint whose address has matched should really fire.
>        */
>       bool (*debug_check_watchpoint)(CPUState *cpu, CPUWatchpoint *wp);
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

