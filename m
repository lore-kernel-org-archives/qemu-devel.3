Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F58C021BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 07:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnBf9-0003gH-IO; Wed, 26 Feb 2025 02:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnBf8-0003fu-LE
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:16:58 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnBf6-0000pC-IZ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:16:58 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so42603655e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740554214; x=1741159014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0v5417qqXYQZlRddsBMaunFNfgBxqTSBb07yyd8Ic+8=;
 b=s7m3MXzIqsL3q8n6b4tu5KdagiUXkWHlhzCvflzGf8cotQb3PgmrOvBoBZaDEGs0/z
 rrfamk2Tav1IEGkDNOdgpJdGYRwwOPLY12c0G8OKEGrwQwSHYIVaCO5C9fyxf7zN/Oeo
 4Nzl2q/HjLDvJmdRgnkjJd6MVT5fRQv8zJ2VvJNpmBRgmWFF0UxigLmxZF0SlDPqvbCE
 zpYcpYpOKPToY8YTK0G8/jlxgiVcyEkE/Ci4y9gjpYHuVjxA3aLA4XOnEMfqznxwa9wY
 Ckckziz4gYRqfbyaG9tuITSmwjuHNQNvphloWBl8I8EWVzAESJ778XRnbE1akIG5Shw4
 n+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740554214; x=1741159014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0v5417qqXYQZlRddsBMaunFNfgBxqTSBb07yyd8Ic+8=;
 b=MqCqBsWa/2juJ9XCAqQF5exJIJCnx+RD74n1Ovsfb51+nGLHIUU+ainAXtRMzYV+oT
 qe645kCrBgkNxYbpJuuhyhGt/C2pFhPS1Y3KfoanH9MXqExHX2nCHJ88spHcMG07g+GJ
 Mv2kIXrMZ+6ohaFi7p+h5fdkUFgGnhR+FK2QSBsVUfaRL0iYP1p+q+KvEudEwb5IW+d1
 3HVVcnQBZHO8sde2r7gmG6taA82QiER80GhnTyFQp3UYgAcLT1VCPbF4x0/NEeUXf/S2
 y5omF1ragEnjkKW4tYSQt9UErcbVoHfJtJbSGir6rEAcCYB/81taq30GO07qc8UKkk06
 dsnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuwv9NRr92fqjAHCU/wV0xNqtx1ue7ixlpZPGNrM84ayX9apZCjVqL2L7MAQfdgVSWLIfQr5Se5VUb@nongnu.org
X-Gm-Message-State: AOJu0Yy1VL1G9kbpz2Z6KT+KR3zRo/JRTPLYI4aG4TkXlCTnD5KowFVY
 8VMIPmyC9Qm7oJmD6q3yqGNlzTabnjUbulxGbMpVUqfafw7Iup17opOQvKyuevk=
X-Gm-Gg: ASbGncu8eza8eA/CFUd5cqELtXBO2Tj8Rdy7uLKQ1+vnO5ZGujyxAhlzhXk+TlPjKkm
 SM9NiAph8G3G/85tIn4IHkx3GuGApMxi9RZgTrOwYUvD+0+nLaNu5MyuHEvmFHQlw+IJv2gDq45
 XAJiE+lDHww+KXqNR4/nqpH6+ihwvxiej0dj1/0LFc8rJmZBsOhTGCOUNTHXxQryQo96U0VhKj9
 YERGlUzLZffAiX8nu4ek1AdGoybne+a6Rk+tvgzlpZD0SNxujnVq3StU5ZLpk2fn1bNRr9Lr3Eo
 avZkZPRIOZo3jUv9eKM/qhqH7gokiDOxOgnRs2hN7cMZR09MU+Vk+QrVW/bbvuxxy67XfiVHpK0
 =
X-Google-Smtp-Source: AGHT+IFzffk8lnhjkz4mJADqheoG/w7EfXCrcHy9rRIiT61XfDVZNiIqZUJRzlUcRHGDA7YNRAZuCA==
X-Received: by 2002:a05:600c:4fcf:b0:439:5a37:8157 with SMTP id
 5b1f17b1804b1-439aebf3613mr200525205e9.30.1740554214437; 
 Tue, 25 Feb 2025 23:16:54 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b591sm11178795e9.6.2025.02.25.23.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 23:16:53 -0800 (PST)
Message-ID: <96b40129-072e-46c3-87c5-dd6a51dca1d6@linaro.org>
Date: Wed, 26 Feb 2025 08:16:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] cpus: expose only realized vCPUs to global
 &cpus_queue
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250207162048.1890669-1-imammedo@redhat.com>
 <20250207162048.1890669-9-imammedo@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250207162048.1890669-9-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 7/2/25 17:20, Igor Mammedov wrote:
> cpu_list_add() was doing 2 distinct things:
> - assign some index to vCPU
> - add unrealized (thus in inconsistent state) vCPU to &cpus_queue
> 
> Code using CPU_FOREACH() macro would iterate over possibly
> unrealized vCPUs, often dealt with special casing.
> 
> Instead of working around of vCPU existence in cpus_queue,
> split out cpu_index assignment from cpu_list_add(),

Better split 2 distinct changes in 2 patches for clarity.

> and move the later to the end of realize stage,
> right before vCPU is let run.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Yanan Wang <wangyanan55@huawei.com>
> CC: Zhao Liu <zhao1.liu@intel.com>
> ---
>   include/hw/core/cpu.h |  6 ++++++
>   cpu-common.c          | 23 ++++++++++++++---------
>   cpu-target.c          |  2 +-
>   hw/core/cpu-common.c  |  2 ++
>   4 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index fb397cdfc5..c338fd31bd 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -750,6 +750,12 @@ bool cpu_virtio_is_big_endian(CPUState *cpu);
>   
>   #endif /* CONFIG_USER_ONLY */
>   
> +/**
> + * cpu_auto_assign_cpu_index:
> + * @cpu: The CPU to be assigned a cpu_index
> + */
> +void cpu_auto_assign_cpu_index(CPUState *cpu);
> +
>   /**
>    * cpu_list_add:
>    * @cpu: The CPU to be added to the list of CPUs.
> diff --git a/cpu-common.c b/cpu-common.c
> index 4248b2d727..92f3d00e56 100644
> --- a/cpu-common.c
> +++ b/cpu-common.c
> @@ -71,15 +71,7 @@ int cpu_get_free_index(void)
>       return max_cpu_index;
>   }
>   
> -CPUTailQ cpus_queue = QTAILQ_HEAD_INITIALIZER(cpus_queue);
> -static unsigned int cpu_list_generation_id;
> -
> -unsigned int cpu_list_generation_id_get(void)
> -{
> -    return cpu_list_generation_id;
> -}
> -
> -void cpu_list_add(CPUState *cpu)
> +void cpu_auto_assign_cpu_index(CPUState *cpu)
>   {
>       static bool cpu_index_auto_assigned;
>   
> @@ -91,6 +83,19 @@ void cpu_list_add(CPUState *cpu)
>       } else {
>           assert(!cpu_index_auto_assigned);
>       }
> +}
> +
> +CPUTailQ cpus_queue = QTAILQ_HEAD_INITIALIZER(cpus_queue);
> +static unsigned int cpu_list_generation_id;
> +
> +unsigned int cpu_list_generation_id_get(void)
> +{
> +    return cpu_list_generation_id;
> +}
> +
> +void cpu_list_add(CPUState *cpu)
> +{
> +    QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
>       QTAILQ_INSERT_TAIL_RCU(&cpus_queue, cpu, node);
>       cpu_list_generation_id++;
>   }
> diff --git a/cpu-target.c b/cpu-target.c
> index 667688332c..0c86c18a50 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -142,7 +142,7 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
>       }
>   
>       /* Wait until cpu initialization complete before exposing cpu. */
> -    cpu_list_add(cpu);
> +    cpu_auto_assign_cpu_index(cpu);
>   
>   #ifdef CONFIG_USER_ONLY
>       assert(qdev_get_vmsd(DEVICE(cpu)) == NULL ||
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index cb79566cc5..c29737e5e3 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -211,6 +211,8 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
>           }
>       }
>   
> +    cpu_list_add(cpu);
> +
>       if (dev->hotplugged) {
>           cpu_synchronize_post_init(cpu);
>           cpu_resume(cpu);


