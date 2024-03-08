Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0572C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridDD-0000VE-TA; Fri, 08 Mar 2024 11:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ridDB-0000TM-FA
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:36:45 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ridD9-0004V9-Fw
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:36:45 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d41f33eb05so10497581fa.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709915801; x=1710520601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9kxjdR3vDvQpz/Ip9aq8t0PMrvrtVnYJozoO1Wh7/Qc=;
 b=Y450VLFVwAEq0479n4RQfIeRxGVvKqms3yN6AjlEp9EIhf4v6Gg8ZX0Hz3c5sjLX8t
 eWUN4XWWlr+WXCerwIBMgZPvyskp8efgGnqd/C35J0HTVfbrLk9bFKfEWh447UaqfC6s
 j+X9DhuysPfM5GCUKBu1ld/YUSne66e5s6C7xq49b2QtFGFgtCG7rY81MOhARTVU4BkN
 D0735DK73qliDFNalQ6VQw6xZAVqSNpz1p8dbhXBU7Jo0a3MN8KuPd25EXR/bIyadUgQ
 v1IfqaE6KYWwDvIPPrB36Ji1v2z17vo2Uyo7LHlINk14WGVuwYBVEYWH1Q7FTlV4knJQ
 BToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709915801; x=1710520601;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9kxjdR3vDvQpz/Ip9aq8t0PMrvrtVnYJozoO1Wh7/Qc=;
 b=mlkjXQMNw0klseMIfTOr6pzPAUoio0ld4r7kAgKXzoh7/I7kKkMYGQ8s4QfCxDM49E
 3WNKLWSwPJeqs+t5tlphiaohxxFHQVYM4aYkVBxthyoSn97lO82Ksj5GKq3qkFbEHLvb
 dj6dIvtaGCGRTEBIs6UeKZbFXe/95BGnwO/3w5E5qRngjejrW0zzP3Empx5MquXm7k3T
 +noooQ371OZeHQlEUJYM/+Hfzb/1Ke2mSQDqQ/LDzdqRJnDc7YKYgYWxJJkKZ14YCWJz
 MM5MtBOKeRl54bJijM910pi3jbgGe9oqhkZKbuMprg6R6yXalrbFwuuOiXm2Y9bHNdC6
 RCkQ==
X-Gm-Message-State: AOJu0Yx049RJgUErlOLQIBAglxfi/OfupkVOeUApDg+y6Jrdfb6LXP0M
 OPTzi75R9j0uF3As8bqT6dyg3C+7eXAjjzxKguc8fQL9ty6CagOE9SCkLH5l03M=
X-Google-Smtp-Source: AGHT+IEnDDdRzw+0WCAVFDAwMmQG+okbkjKuymonjjKaw1bTTp+uHBxxsuWDU3q+JUa4jsjl+CpT6w==
X-Received: by 2002:a2e:3e15:0:b0:2d2:73d1:d259 with SMTP id
 l21-20020a2e3e15000000b002d273d1d259mr3176513lja.23.1709915801587; 
 Fri, 08 Mar 2024 08:36:41 -0800 (PST)
Received: from [192.168.69.100] (cvl92-h01-176-184-49-62.dsl.sta.abo.bbox.fr.
 [176.184.49.62]) by smtp.gmail.com with ESMTPSA id
 r19-20020a05600c35d300b0041316e91c99sm3000008wmq.1.2024.03.08.08.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 08:36:40 -0800 (PST)
Message-ID: <17444096-9602-43e1-9042-2a7ce02b5e79@linaro.org>
Date: Fri, 8 Mar 2024 17:36:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/21] Introduce smp.modules for x86 in QEMU
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

On 27/2/24 11:32, Zhao Liu wrote:

> ---
> Zhao Liu (20):
>    hw/core/machine: Introduce the module as a CPU topology level
>    hw/core/machine: Support modules in -smp
>    hw/core: Introduce module-id as the topology subindex
>    hw/core: Support module-id in numa configuration

Patches 1-4 queued, thanks!

