Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6588BCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rme-0003Ly-7p; Tue, 30 Sep 2025 00:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RmD-0002s8-Ir
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:15:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rm6-0001Ut-Bx
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:15:42 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so4220514f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205734; x=1759810534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+gM01wdk2UseDL4pB4Fgwz3uSs5dQf4zrjZtOq7eYBI=;
 b=qwa11OXwtI4/XZaAOMwDvUvP6fjdF7g3b04ROue4jkpX9aGvQJ66S5mh8crTRc0ZdI
 dlOg86QlEMk2EeZUCE9k27P1mrauYezusdn/HaojE4toqFsgmE3z4ut/eJIXiLferjTA
 w8o7UNdGmiuPif5g+7uwoCU6DTlsr8s02XX3PotHzj5pR5LRZjHVUV65r7YC9nxRdb0Q
 PoxN4Six9SC5wA2tAmeZaAcUFmHfb3cbrF0I+ISXXl4UfE9Ii1hWnEptnlj8kxiZrasv
 4tTGiilu0gqYTIMXnPvhAIFmQmlbmt3c878zb7kFXAzBxKfFZUPU88UajNW3CfuQMm/U
 ZKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205734; x=1759810534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+gM01wdk2UseDL4pB4Fgwz3uSs5dQf4zrjZtOq7eYBI=;
 b=PVJA/SK9d0fvMdONIswlY/TeHcmch/gxAW5tK0pl2ytcYybuiekNIGv8fOxh2Cv77z
 ECzQzIW8A0m37dbk+usqLSF9N629w86cTyN4jq9PeVvnmkdi2kJ7DDPFT9jwUOsU7hH0
 cHN/yEY+bFYp0LPP9SH/CMtAscckhougnlO8fp9Cvp0YyZdBf1WXX+F2y224FoWparny
 RkckueGzIWsTT84z9aP9IsrUr6dwTC/EvJaPfHCjER2YpnyzWCyxmGcw3zjpf3UOW//e
 iG7T0s6strflVxDSuMTiXAUHxYadxCptgqfEeb7Zx+Bb5v9qK9+uvropzOsDD0I96VkF
 tUYQ==
X-Gm-Message-State: AOJu0Yz0TNoa+q/on1C08Z0IcEqD7uy8PCQ9BkYtqvAHn7R67e++28If
 iikFJKdIgg3IpmHOliLMcnbaza3lYSeDBVrvSmgmk1AtNM/QUvExyeRK4jrd5PcBgu+ZYUd/CIW
 QrtnNpLoEUA==
X-Gm-Gg: ASbGnct3k5lh2jNNTvWYJZyMnjuJIKbQQXAfJAIMcn1Fp85wNbr0u1hMVtrH+M8r9bq
 Ftss4DJIjdYXGBTyW+hk+2CM8Ht8xjswvpsVKMRx2Jou6TMp8ZFXtQLndymTnhLVWDXZrzzHBIl
 kjPVbjPTCZGB30i1VraRlAtBAXU1qmPOFqIt3XkqROcXaLq7oowjb5f3Wz6EMDra2sKi/Vl0rdB
 fsrUajmoOqCaATgGX4aa6ZT+brEFcLjuk4ha9cxOdiZM/6KIeUbnpZklim0CRBUjJZJQZcHcn7m
 JaUx41BfvXo/bARBcHnc9gxPnMLOTWIFmvrCiYPsQzhHpAM+ENQ3KnDiU5hImG+0aCylam8qNNc
 Ql28JL8bQrOYr98yBYeKBMX618SXZmx6pncr+trRT3v6R07yC6gatcBqIsu6OjRzG/JKPwmCQ3k
 c7rqO+7fgJKUdnluyfvrhh17PS
X-Google-Smtp-Source: AGHT+IG3+NO8caXmgDpmIXUT4U2a38OsXEUMyu+A/7GxYYPazyV8IqumGfAwZ8JxEPW+ODAlASvvgw==
X-Received: by 2002:a5d:5888:0:b0:3ec:dd16:fc16 with SMTP id
 ffacd0b85a97d-40e4bd186aamr16627860f8f.43.1759205734391; 
 Mon, 29 Sep 2025 21:15:34 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb89fb2fcsm22030581f8f.22.2025.09.29.21.15.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 21:15:33 -0700 (PDT)
Message-ID: <95145136-7d86-4fb0-a93e-f23af9622ea6@linaro.org>
Date: Tue, 30 Sep 2025 06:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/17] system/physmem: Pass address space argument to
 cpu_flush_icache_range()
Content-Language: en-US
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
References: <20250930041326.6448-1-philmd@linaro.org>
 <20250930041326.6448-8-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250930041326.6448-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 30/9/25 06:13, Philippe Mathieu-Daudé wrote:
> Rename cpu_flush_icache_range() as address_space_flush_icache_range(),
> passing an address space by argument. The single caller, rom_reset(),
> already operates on an address space. Use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> ---
>   include/exec/cpu-common.h | 2 --
>   include/system/memory.h   | 2 ++
>   hw/core/loader.c          | 2 +-
>   system/physmem.c          | 5 ++---
>   4 files changed, 5 insertions(+), 6 deletions(-)


