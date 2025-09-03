Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B693CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 17:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utqwN-0000Jl-7o; Wed, 03 Sep 2025 13:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utqwL-0000HW-Ae
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 13:06:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utqwJ-0004Xe-E8
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 13:06:33 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b9853e630so1605775e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756919189; x=1757523989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q1I+bCuVrGyC4y/n7gXvkFUCYM2As0mkoEBnGFiqQfU=;
 b=cIVpCOVsSjpcacOlHVaHWi3AiM4LGAdoOb9EqnqnAR47AJ2QMPQRboAmNH6bDSx1jO
 JH+sMbw305SBf8+jjfQxLdHpvYaWV1IX/RjcWkSx0ia4h3Q3Kq2/xDAfWr6elKvVMZNJ
 XDoFQ8V7+d6RFDD+dm+fd0iGRCnQI5GI3NEhwON5H/GqYOqP+6Q8jLJf919Zq3KXjW03
 mja9McOWqpa6skcvytwOUguHXEEl0ZqK1CqZh9GL5xdl+xCmdwm7mx6QCj9hAooexZ2E
 /T8VPCfqlQ0Gnf/uLl+/0yL5+205qZwgyc9xvDmq19L0ayaMdK3K7k9cl130EbEv6C+T
 jYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756919189; x=1757523989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q1I+bCuVrGyC4y/n7gXvkFUCYM2As0mkoEBnGFiqQfU=;
 b=UmTut0JFE/HYjj/j3OoBCggcpv2JXNcrrNtArPH8NCyTUm18k06icE5hkyneDH4xEI
 FWshBZ2g9BNueBajBsIfRUFsH0WPg2I4dFAOqCnCntK6k6eaz9a6/Oa/eOmIP1Qg12zX
 MLwSG/UTC9mZGbhHflvL/h+f62fKJSq/L+qZaYej8OozIXozAGCtCjws3Wx90s1D0/2p
 80GiaUMsceyEoqjJI3Hq48fYntBQbGTieAYNV3oGm17Y3XuNVm8bT4sm1E/kjGfWJLST
 T+nMAA2vkh0u29x+kJbt+DrVbedk5eKNeSGb2QMvkC2dXZWdRpzlK3jbVKM8rtCRqVOJ
 GwNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYLqovpy6j3U6ktqFeKlKlKAZR1AAKhoEJewFeJzu2gMlCokpUUfm68G71a+dRvY0Lf53pmxZRds67@nongnu.org
X-Gm-Message-State: AOJu0YzGtAKODdlX8cCyIOOBRLSC89Ga5Ce8/EaDVnloovz22cn4Wh0+
 xUbClRRglOB1oWYMFE3Oavj9EyRjOvxhju/BimxeNDzA2Cy+EhKJNh2RUoTCBHiyCVA=
X-Gm-Gg: ASbGnct9DZmmq1Ds8NovhYqHs7hv5uM7CfAi9tgwLtS4g2Sgf77kDhQIaiG7e35yZsJ
 JOFSqLZnj5mwUtEQpRklvBMXkV548akjgmpD6iumt8PjceyJy1BtG/HX8UcypjbC5WD/aae0vCT
 zs6rnixRIzbIyYfZ6sb5/LHiJYDSc5rWRExzNJUMWjYjwayZkqLiaEoz8aGCWEJlHE5K7VMhVst
 kOZNW13RPLMVygZ+xG3gwuj2urvAk1y+iQxIc8aCXhkTd+6y+8gizMvQanqU5Xcad7UQVAsNwK4
 maHsGd0ws36AxYRcRc+4X4ArEXD/wN5JU/EnZBGd9A7fqztJrUZqPDxuM3Uda+4jMnPxAZYpyu9
 JAMkzfjOsGOrKG2SIxpqQfNKp0b03+tEMZ0tydnSExMYF4gKUnjMttAVZeuMPkXPxyg==
X-Google-Smtp-Source: AGHT+IHxcLj/Pv4cCcml67q2cfTwoaY1LdPQgC2/w9IPRTZrX3vUeIwX71VJWe9RQ0t0NGT2Erg+aQ==
X-Received: by 2002:a05:600c:1986:b0:45c:b5f7:c6e7 with SMTP id
 5b1f17b1804b1-45cb5f7c99fmr27831265e9.0.1756919189460; 
 Wed, 03 Sep 2025 10:06:29 -0700 (PDT)
Received: from [192.168.1.138] (93-34-129-33.ip49.fastwebnet.it.
 [93.34.129.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8879cesm247367415e9.12.2025.09.03.10.06.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 10:06:28 -0700 (PDT)
Message-ID: <d8f97432-69cf-41bc-ae5a-a8b31a859299@linaro.org>
Date: Wed, 3 Sep 2025 19:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memory: Fix addr/len for flatview_access_allowed()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903142932.1038765-1-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250903142932.1038765-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 3/9/25 16:29, Peter Xu wrote:
> flatview_access_allowed() should pass in the address offset of the memory
> region, rather than the global address space. Shouldn't be a major issue
> yet, since the addr is only used in an error log.
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Fixes: 3ab6fdc91b ("softmmu/physmem: Introduce MemTxAttrs::memory field and MEMTX_ACCESS_ERROR")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - Fix len as well [Phil]
> ---
>   system/physmem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


