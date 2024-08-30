Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B296CA0ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 02:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjr67-0004eA-17; Thu, 29 Aug 2024 22:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjr64-0004cl-SZ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 22:10:44 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjr60-0003G8-1J
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 22:10:44 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-26ff21d82e4so769054fac.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 19:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724983838; x=1725588638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=86rrgtTasmcAG9isTT9JLQYWKDm2+3/+UxwghN5qvxw=;
 b=L7dXOJnkCq85LUC/UZYmRJEMgKEKaorl4vyNLMIvEaU3vU8zODM5e84C9SGIRFQX8u
 45P1GKSRLqXZ2Z5RXnca4B+qs6kQZtcCzo9BeoZimHS4GhNMqxmOhHUiLsYtt/uHke5b
 ZeCzyOGeFeHhjAQLlSD9KdSJ6/jqOD+TmUCe5lClgv5xvYlgQc5czr/vERMohLyQeV+O
 bC7yriVjLc/JkA2b88GQ5T4HabjXj9QluB3VmKZd4AiQ+Xd5BHI9J718QPIuvVG/N1N6
 shzMAIWZ4PsX3vL2gHm632y8iKzTklVt1iJwnkhq3/HcdpXUHwIYe6XN+yGyaXc/Nqbk
 MklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724983838; x=1725588638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=86rrgtTasmcAG9isTT9JLQYWKDm2+3/+UxwghN5qvxw=;
 b=n17CMjefuDjPGLleME5Wufxwp3ub976jSDrb1/JXX9jt3Z8yOd4qBH1rV+JMM8nxlw
 Rg9UphIA7UXr+R9ZsR3fF3osoZfTbojmsPJrV/+YrXVYbnWsjpRJcgxf7XXQbeF/BAB+
 m5VAlDfisAiOxXpDyaxGdV6vOjlAGCUQIv3xAe+b1uod1UjnCF6inMIZ8CbRMRiKGOlH
 k3/MpXG3MnVnKYdHplTtIiohYXvxqhSgyTvRl8UbOhO79HYAdiuLg7IZWXtChF4/JWSK
 0ZisOC0My2KyiMt6UiBI3ppRsOcTnj0UGrqeUUHfC2GNUSL99PK+SDM1N3MTtKbcEusY
 vv9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIaJmqXtyLP2ymYqSzEcV64507WmGVjoru+uqKLrvYnofADX+ggX4aMv65n5u5oRWrTeNILtX7udxE@nongnu.org
X-Gm-Message-State: AOJu0YyAlCl8SRlfdqrN3epqKg3Wo97Dvqcx7uTsGgfxo45Uly0DTSRt
 byLXd580iugOhJ5gC9pjYDAtyaKoY9THwUM4He46hJMVRJzPBslfMpuFro0b/z8=
X-Google-Smtp-Source: AGHT+IG4FF7GsrFkvqI2efwWRrgcrUHnfmEgZbRwP9b6aEMHUqo5Ei0KLKRJWnHOQ9RQPZuZha6pdg==
X-Received: by 2002:a05:6870:d10c:b0:265:b32b:c45f with SMTP id
 586e51a60fabf-2778fd683d3mr5270024fac.0.1724983838059; 
 Thu, 29 Aug 2024 19:10:38 -0700 (PDT)
Received: from ?IPV6:2001:8004:5100:1c02:35b7:18d3:3fc5:9f02?
 ([2001:8004:5100:1c02:35b7:18d3:3fc5:9f02])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e569edc9sm1778987b3a.138.2024.08.29.19.10.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 19:10:37 -0700 (PDT)
Message-ID: <7e4ee645-41ba-4a6b-a004-df396faff65b@linaro.org>
Date: Fri, 30 Aug 2024 12:10:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/20] target/riscv: expose *envcfg csr and priv to
 qemu-user as well
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240829233425.1005029-1-debug@rivosinc.com>
 <20240829233425.1005029-2-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240829233425.1005029-2-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 8/30/24 09:34, Deepak Gupta wrote:
> Execution environment config CSR controlling user env and current
> privilege state shouldn't be limited to qemu-system only. *envcfg
> CSRs control enabling of features in next lesser mode. In some cases
> bits *envcfg CSR can be lit up by kernel as part of kernel policy or
> software (user app) can choose to opt-in by issuing a system call
> (e.g. prctl). In case of qemu-user, it should be no different because
> qemu is providing underlying execution environment facility and thus
> either should provide some default value in *envcfg CSRs or react to
> system calls (prctls) initiated from application. priv is set to PRV_U
> and menvcfg/senvcfg set to 0 for qemu-user on reest.
> 
> `henvcfg` has been left for qemu-system only because it is not expected
> that someone will use qemu-user where application is expected to have
> hypervisor underneath which is controlling its execution environment. If
> such a need arises then `henvcfg` could be exposed as well.
> 
> Relevant discussion:
> https://lore.kernel.org/all/ 
> CAKmqyKOTVWPFep2msTQVdUmJErkH+bqCcKEQ4hAnyDFPdWKe0Q@mail.gmail.com/
> 
> Signed-off-by: Deepak Gupta<debug@rivosinc.com>
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis<alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.c | 5 +++++
>   target/riscv/cpu.h | 9 +++++----
>   2 files changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

