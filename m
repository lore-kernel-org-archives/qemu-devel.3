Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E658CF8844
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 12:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM3Lj-0007JR-E1; Thu, 20 Nov 2025 07:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM3Le-0007IC-N9
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:01:15 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM3Ld-0003xj-6S
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:01:14 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e84d56c4b8so460912fac.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 04:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763640072; x=1764244872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gaK6xjFEa7Rqoa5NHcx38vyaGD1+kzqQP35qMZPac2Y=;
 b=FNCWIvq/HS2DeyeAgOai4W4imei3YqfDoivtu0LVUoQTgGf9wNn+ZWhD1kVTMdwFZt
 WwOHXWCaVIgpg2MosCHkbCOza+4dNCsY9zwQhE4vsW7VNvY07GNAveWs7V4sGDsvkc0r
 AdJad35zTBR6ZibITmyOUfHk9YYu+vsTWEPrHCy2B07HH1ZWOyNAPJiqBeCjGw9PvVJO
 OG+fQ2eF5IsQ6mmaE2O++CEmGTXAYr62GqyvjcY4uiPU+YErgeF66/HlqOtGD1FCHzea
 4RoAnEumaHTj0OwGSnn0d5mgEaGbxqkOjg15Mv8y3qxtaYwkTR+0tIV7i5Q38+3WMrml
 aalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763640072; x=1764244872;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gaK6xjFEa7Rqoa5NHcx38vyaGD1+kzqQP35qMZPac2Y=;
 b=Iu9qHodT493JUF40u2+CESmHpus3jRWbu22r0rqIKxjgo0Fj29GCs+9Jw38qQ07jou
 twFMepewf23HULflEhU3jBspLm/+cz6ysIdidYCkYDnmlyvi/7FMuVWy8f41PY3AV12h
 xd8C34qLVzjyMxFZGM5/PJHwZYjgk1cYvp79KPJ7l/5ZQi8hiQIkwLfEdAIucSXSV996
 cGhv7o0kiWKZ3a/v+Gbv/NVIq9qJyows/Rvj+EGRxameyJ03IXT7nCudOUB/lmPUCD1Y
 xwYinL+5tAc8HlFW/Z428y95oYrw7xPb8t8ZivanI+tbRwi30R1U16vHvZ12U1W7Wqz5
 21Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv0gaG1mFsZsqDSY8RxHPewS0zystLq/TVstwwdWflZ2xnLIaWfQXqNMDonVM+cjDwxduueXkvTD55@nongnu.org
X-Gm-Message-State: AOJu0YzGhWS6Oe0YE753pS4s6x3NTTKcePYGnFxEVD7NJGt11Cf2ULPe
 hEsYehqrhvE9jcEljR/pgdcIFSvUoZ1oSDgh9Ha6IFWnFQaPePeheOhLqWZwOom5hzw=
X-Gm-Gg: ASbGnctWxXgLhjxs4V2hgOWaEKxazqhfc/KeAL0Z5TAw9Do1pCFQw5ydl1C9O1kT+XJ
 oS/T2ftNsOViIb7luW/BEK8XQZUpUxu6MKXacCwY+ocuta+VgzWxiBYlQD9DlGZ9xwmjHFqG+s9
 exHEmjfRnKEA3vKDrV3sILDhKHXpR8fFFB43nBnbYvBcQ45KWfWr+z2rjtmopVkYAE7STXM9vz6
 z76NOYYWfF8S9rf83v4/Sr+84P8p9TZkd+PSwAbzzlRbgL04EfSIFHP+sKcU/9wMXB7gZ8LX/si
 oY2NS+hZsWH/+zFJ7ki+vVf5NLJnVLechfVucXPfmbpEB/q8BcAtNvLFiVknY5RNOIzhUQkDuNG
 Y11EXZniC44tc7bUNk7DG4JtTBgQ72FC32sCZI772KtX5g1j7rmyDdhK+mzerTY7b3kYVguK32u
 Wf0JRkwZ9oNeJBjYZ8XaZTxsuStjg=
X-Google-Smtp-Source: AGHT+IEntktp2t6F3c2FtTfsZubi/joeyDbNxjQRO85Lw7W41uGRuibq+CDm/o15Yxf057JkT7PT/w==
X-Received: by 2002:a05:6870:6129:b0:3ec:3c47:b3e7 with SMTP id
 586e51a60fabf-3ec9a64f8fcmr1484701fac.47.1763640071814; 
 Thu, 20 Nov 2025 04:01:11 -0800 (PST)
Received: from [192.168.68.110] ([177.188.133.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9c347b2bsm1031566fac.9.2025.11.20.04.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 04:01:09 -0800 (PST)
Message-ID: <fe2648a7-7875-4aa8-a1f6-485490ddc7b3@ventanamicro.com>
Date: Thu, 20 Nov 2025 09:01:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] hw/riscv: meson: add CBQRI controllers to the build
To: Drew Fustini <fustini@kernel.org>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?=
 <mindal@semihalf.com>, Atish Kumar Patra <atishp@rivosinc.com>,
 Atish Patra <atish.patra@linux.dev>, Vasudevan Srinivasan
 <vasu@rivosinc.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@ventanamicro.com>, yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-6-3392fc760e48@kernel.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251119-riscv-ssqosid-cbqri-v1-6-3392fc760e48@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x30.google.com
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

Hi,

I think this patch and patch 5 should be squashed together. Both LGTM otherwise.


Thanks,

Daniel

On 11/19/25 9:42 PM, Drew Fustini wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Build the CBQRI controllers when RISC-V CBQRI is enabled by Kconfig.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>   hw/riscv/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 2a8d5b136cc4..79e15514b797 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -14,5 +14,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
>   	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
>   riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
>   riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_CBQRI', if_true: files('cbqri_capacity.c', 'cbqri_bandwidth.c'))
>   
>   hw_arch += {'riscv': riscv_ss}
> 


