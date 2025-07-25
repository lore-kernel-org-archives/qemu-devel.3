Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CCAC83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 07:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufClL-0005tc-Uo; Fri, 25 Jul 2025 03:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ufClB-0005nz-HJ
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:22:33 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ufCl8-0006cx-10
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:22:29 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso1099126f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 00:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753428143; x=1754032943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r22EFJ74HxynTaDmnGweCoJcGF7P8MUsVDsDrxBpLFw=;
 b=Rb/fNaRlqsCJU2FMm2cb8Dg5t1QNsD30LbdyEi+/fryQCwGPqNC+wRpTK++eDEoF5m
 bIQfLX4QrJaeYEuuB++BEvALIdaj6todT0zK3Ozw07w0Osbm32kpfPezkR1zsOidS2Jp
 1cwao9JwJFPZvxCzquZSU+x4s6rsmcpGh5oJlNgJn5WOpwQB316qidToiJr5RB+e8AM+
 FQ9p0ekxVBskc+5iJWSBe+NgxwmVUi4hcgwqyono1A5/QCOsr4pspy00K8fg4SL+NDVl
 vI6RFVB0jmNPJ5C5VAg2hmRUDLS7LIutawfaBDb/xU1thrg6PviF5JG2SB33fcqF+ieU
 4a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753428143; x=1754032943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r22EFJ74HxynTaDmnGweCoJcGF7P8MUsVDsDrxBpLFw=;
 b=AYHxb0szSnREm7oYC8LhKf2UqT0tzxwPVucJDx/6e8tVZzYA7nze4m0h21dC6St+Vj
 rqBvCu6xql6sD/1hgqHl8nhnuC8S+ug7xj6JtSToSyyb5Jx99ma3Ou9hv9+6FxW+CJTi
 4cnpImwdSSnP22cXRo9Awiat84zOv138bGfIsyaVsaukfahBkdTSzEuJyU0NCl03vUyp
 18k9UQMrGkMRnHnIgenhPJw/6yLSXK6uJnbtIiVDyE7Jv25/CQkjz2YYQ3JThjdkmvaw
 ZPvp8NSswEWpZv+w9eH4DNgLDfDgOmmep7KpX9WwTAErwunORWg6RF4an0EI7PiUbyu+
 zf0g==
X-Gm-Message-State: AOJu0YydiJAZj5GLOHytrWgfjbvc8tuKBmElfrTD5Mxtbb8/0BaHO6lS
 ibi1dtFodkBX65tU8ZpmrrPltb16foFuWIhqE83q4KQClGm+aq34sj4OeM6y8nqYrbA=
X-Gm-Gg: ASbGncsZoEpAn77rp2ToPc/LdvnZQZB7d3Xw0l6pIiOWXC6UvYS2SaNcCPYfWj55YSu
 n7djSauOYcn0jM/Mtdfk8ezIAJ9AJc09Rbx5/noMiRTqPQb5Ca0nZt1CDF+u/eKXQ83hB4q+N2/
 0cQvQIFyG4OMk0ARSCTr62Dgtbmj+XL8dhZdXXUeLsXuWTQACY0Q1a0Pc7MmU7Nh7MSJ17fExfc
 fC67D2S0ZvEYDwkB3iJyj5vKCLbFbgZD8fKqdbaNeHQ0/fWLDXGSwC1Les4a5tVrlcHs8JvE3b3
 vhqBecS6tDBqRLCa7Igc9l+aYizlaZkWiGjQoLBl+Xo7uF64RsoLaYQJK+YXHxZl9zHnRAWCkci
 Jc+yzIwdSD27SKC00lYjzb3SNeRRua3WW5Xw+gVnH2b4V4t4Cv0U+7gd/a++KhanA7Q==
X-Google-Smtp-Source: AGHT+IEve8a9+a74TBdge2Cysfinz6qo485KhGCASFlqAZs9K5ZH9Pd+LMowwG6URvcmQbKgt0Yhlw==
X-Received: by 2002:a05:6000:1a87:b0:3a0:b84d:60cc with SMTP id
 ffacd0b85a97d-3b7765e691fmr728776f8f.2.1753428142982; 
 Fri, 25 Jul 2025 00:22:22 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870554457sm46064195e9.18.2025.07.25.00.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 00:22:22 -0700 (PDT)
Message-ID: <7820abd3-4f11-438a-8047-bc036380cc4c@linaro.org>
Date: Fri, 25 Jul 2025 09:22:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/intc/loongarch_ipi: use logical CPU ID for
 kvm_ipi_access_regs
To: Song Gao <gaosong@loongson.cn>, maobibo@loongson.cn, lixianglai@loongson.cn
Cc: qemu-devel@nongnu.org, jiaxun.yang@flygoat.com
References: <20250725012528.2582498-1-gaosong@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250725012528.2582498-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 25/7/25 03:25, Song Gao wrote:
> QEMU reboot after inserting no-configuous cpus may start failed
> becaue the vcpu context may not have created on KVM, On QEMU side use logical CPU ID
> for kvm_ipi_access_regs and do some check. On KVM use kvm_get_vcpu_by_id() get vcpu.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/intc/loongarch_ipi_kvm.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/loongarch_ipi_kvm.c b/hw/intc/loongarch_ipi_kvm.c
> index 4cb3acc921..d0a2f2343f 100644
> --- a/hw/intc/loongarch_ipi_kvm.c
> +++ b/hw/intc/loongarch_ipi_kvm.c
> @@ -23,14 +23,19 @@ static void kvm_ipi_access_regs(void *opaque, bool write)
>       LoongarchIPIState *lis = LOONGARCH_IPI(opaque);
>       IPICore *core;
>       uint64_t attr;
> -    int cpu, fd = lis->dev_fd;
> +    int i, cpu, fd = lis->dev_fd;

While here, we could rename s/cpu/cpu_index/,>
>       if (fd == 0) {
>           return;
>       }
>   
> -    for (cpu = 0; cpu < ipi->num_cpu; cpu++) {

and declare @i here: for (int i = 0; ...).

> -        core = &ipi->cpu[cpu];
> +    for (i = 0; i < ipi->num_cpu; i++) {
> +        core = &ipi->cpu[i];
> +        if (core == NULL || core->cpu == NULL) {
> +            continue;
> +        }
> +        cpu = core->cpu->cpu_index;
> +
>           attr = (cpu << 16) | CORE_STATUS_OFF;
>           kvm_ipi_access_reg(fd, attr, &core->status, write);
>   


