Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD06EC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUBk-00080T-28; Mon, 26 May 2025 05:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUBg-000805-5x
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:32:05 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUBe-0004aG-EJ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:32:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so19629155e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748251920; x=1748856720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VQaUKMuqli2CeDV/2HOoV1p5VWj4I72PzrRaLmrsavk=;
 b=dBmGqgo7ER0Mh/7jLuEmMdqHOiK1nJgQ6V1xKqFgqS+IxllkibPBkfORtiq8vZwD8s
 K3SLBbH52CJvTsjNjgZ1RB6nNzqyC+u19J4cVvj8GeptpLP52aYtRHJ9sz1LSvk6wagR
 I7Wpl42nPeHjTpMsuotMNC+0A9pmMAkWDYaytg8+jUQyISTubv0rW28hbaWq7bX8Lur+
 Ig3c0Ezd+4ZveOj1ZO19RnJHuZ8zo55uv4QxyvFRxsogLMYe0WnmXSKLlQrhEGKfHNHD
 3Z4IP3gvYEuMzabHuUN8LD6m6uM837ivm+VQKDwoYZ7nFdnNm+N3cBGOA28n0rLrgOBs
 SVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748251920; x=1748856720;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VQaUKMuqli2CeDV/2HOoV1p5VWj4I72PzrRaLmrsavk=;
 b=Z2gOZLjp5Bq2adVmJTmiJYYhtn2s3VV3ybRwHWj+eL7pHKMM8Xfdvn6NEvsJ97PRGK
 kqK0kL/bwPmrxIx+4TQQNFBaO8fngp1XX+2Jaq6O/Bay24jBXZXcGvI5E3QB4jbDvhvA
 EYIR1iJdBj1cul+68Na8CQNK6+a4xzpf8KDigck/dIRmt2KcW4cUsd/gQLky7MFgVU5A
 F4h18D0dDeQ5zewRl8ChBHxvr0nUCkI5WSAI26pTB7/jYuYWDKiCtqF2mazbDgTMSCwF
 Rj0BFEgN0HZODvdHRx2VeBWdLPiRhQqAlHcGk+V97pm49Z0rhFHob6+QLj1ryhrdScex
 yiJQ==
X-Gm-Message-State: AOJu0Yzzgm8e9OvOIsveoK7A6v/COJdfDIXwCEjHNaDc8GVHOqGgVfKc
 1xqaZGfeY21io36MNfACfHgjj+iIinNlmagIEYzC8O+tURUpaArS7CLhNpI2aAiV8Pw=
X-Gm-Gg: ASbGncufi41Agk9zEE3e0IzRLriwLb/+wdSKrWqCuwq8hgv5mjXKE8SgmMOfQY7zwwe
 xocYUfBPtmiMy2/nGmCqYNqMtIbKs6y4f/5WAvl7JA/sLWegqST8yFAt/kE/NA33ymi2wt4vJfT
 JQJ8dqHjHB1G3/v2+Kro/vJ/o7ePd/VcJBotJj7v0PVF8yAGlMHKzgQq+j4Jnvxt063y8692sxF
 aZFazOqweQfVGL4I0CFwwhyicCQXDIHClNhuqJdQhth7y3zcZNkPWUPtUdc2TYSXwg5eUKzmHEf
 Wss/Bym5MD7D48GBXRYN55nMrcpNvST+tpeWEs1i/ZOT/7hyuiur9K+MvUSD/G5tOARWNy3jPaT
 +3swpQT4mROer5OIbNnOoqdXc
X-Google-Smtp-Source: AGHT+IFBLDAbHUmvBbM2FQiCwBMChHISQMitYm193ScCp7pHbwWljyeA1hODgEUF8f+q6XDc8rNu0Q==
X-Received: by 2002:a05:600c:384b:b0:442:c98f:d8cf with SMTP id
 5b1f17b1804b1-44c91fbb3b4mr91200545e9.16.1748251920468; 
 Mon, 26 May 2025 02:32:00 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d25b8sm237844105e9.17.2025.05.26.02.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:32:00 -0700 (PDT)
Message-ID: <1790986f-4793-483f-8756-2701e54db744@linaro.org>
Date: Mon, 26 May 2025 11:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] memory: Change NotifyRamDiscard() definition to
 return the result
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-9-chenyi.qiang@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250520102856.132417-9-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 20/5/25 12:28, Chenyi Qiang wrote:
> So that the caller can check the result of NotifyRamDiscard() handler if
> the operation fails.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
> Changes in v5:
>      - Revert to use of NotifyRamDiscard()
> 
> Changes in v4:
>      - Newly added.
> ---
>   hw/vfio/listener.c           | 6 ++++--
>   include/system/memory.h      | 4 ++--
>   system/ram-block-attribute.c | 3 +--
>   3 files changed, 7 insertions(+), 6 deletions(-)


> diff --git a/include/system/memory.h b/include/system/memory.h
> index 83b28551c4..e5155120d9 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -518,8 +518,8 @@ struct IOMMUMemoryRegionClass {
>   typedef struct RamDiscardListener RamDiscardListener;
>   typedef int (*NotifyRamPopulate)(RamDiscardListener *rdl,
>                                    MemoryRegionSection *section);
> -typedef void (*NotifyRamDiscard)(RamDiscardListener *rdl,
> -                                 MemoryRegionSection *section);
> +typedef int (*NotifyRamDiscard)(RamDiscardListener *rdl,
> +                                MemoryRegionSection *section);

Please document the return value.



