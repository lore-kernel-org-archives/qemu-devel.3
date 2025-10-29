Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F19ACCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1pB-0006gl-7a; Wed, 29 Oct 2025 04:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1p8-0006dQ-78
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:46:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1p1-0000ga-Sx
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:46:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso73536935e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761727579; x=1762332379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=USBRWpkd1yg8IN/MkiOz4iyxTucKIPXESR0FIDce2SA=;
 b=oEP6FWcoM6T3FEiI7OJloSsl+nrneJFuZnt+59sdVv83+2WU/oQcnNDCDsIzFK2e5T
 YVKVKy/7Y5iXyUMBGI8iV/AIxut55oZcj9nl27DU4PfkaXEijBIhPAFOiyGwbBRgRx1b
 XvStGufNsGt+yirkp8piscqVF0bS7Fzv/bBIDiUEkjsY5A66Od6EWaEtzw9Zpz+tw39p
 mLbpaFGRu4OubIWnBAFvUhrmqL4H4CcOC1l+wQjap18BYx+f498fZS93PKzIFEQzQO7E
 gEIz9/aK8zDG+9XdTK6eFDfHknBxsD8KoTZfk5Zq4Az4ATSpJicbnonx5+DUN26CPeFy
 XHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761727579; x=1762332379;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=USBRWpkd1yg8IN/MkiOz4iyxTucKIPXESR0FIDce2SA=;
 b=tYjdGC+TAP/xkVjcMPFyRSAtsP5X62OyvD+wqMjIJlW0KdgOX4SzXLWtF4IOIh/aJn
 3jK9gaPFtxPT0PHbP++fI8c063TOBRx+WLk54eucUX2pW46GvPjf7WiilNRxOu9M7aPL
 RwYmF+X0QvtpwwR3WM4ihiZA+E0rpoUboso7nAMhUytRZPXXEcnDtSaDPZ9Pkp6Jh6Gw
 6LwikKDMd/foDh18jIaEADLh+9VqgCZwou9C8+kty4VO6PEoo1gk88KUxICNp9BLyU69
 22ZY3OFUCp6rZLBoXz9uhOX1rN1ApjJUq4IdWwsdG/xudMWE1+OZNnnDDfwuoVeNpJZF
 P+ag==
X-Gm-Message-State: AOJu0YzvX6UIslGRBqd9m7G7ssmb//xccy7+G+XVerq2/TIexoFwp6nY
 iNrJN4BgkSACrXL4JLcEt8TIz8YtlDkCTG+AZQ9/kkmsddYnpMKpNqOrtnBjchjW9x57yiYL4W0
 kGFdQpZg=
X-Gm-Gg: ASbGncskESeKslBEGn+9XCYdr7eVDmuxfTx+LQJ+PCJOSn4rJ6E5t750djj4dPT3+dP
 zxW+wOs4lknSCm5X+NDNGCzHbnd7C2O9ZNoS1m3NZ8mX+UhBajWrpH9Y3DJBts/S7NMDnhMwwmg
 AtIPBL4R1A9slCa0NnNtdUoPjrsC297K7I1118aMHDC5hZQxk4bp3NXMdXYJP5uHJ4DP0vDpaK+
 lq7WKqq7AMF7NKOJ7kwrADVNFpwWseADc5fkbXIVn+eclUDNK7u1RA+vy9d2Zva3Q8L6bnorTSu
 PSQYVmjTKRUgx3qQ/rdqm4aKtdGPun6iB/bddDZQX78m1nnOuWHGA7f07MX+aMoBwqJo978LocY
 7tdEUkhAMW5yRzN5qizPUfMPbVUXQeDpDcchbgjShEH+DmaHsa/Q0XN58ltwyH/1WnpU5XOa0ez
 eiS6dTvjPDO8KRyg9q
X-Google-Smtp-Source: AGHT+IFDbt2tkYNeCMTKctFpbNEG+WNiwd1HV2NMq+1etT2wKVfqIpmcM7M5tVtD4VOYZ1Jqbeq4cw==
X-Received: by 2002:a05:600c:4e4c:b0:471:5bf:cd02 with SMTP id
 5b1f17b1804b1-4771e180b6emr17877445e9.11.1761727578554; 
 Wed, 29 Oct 2025 01:46:18 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e3aae1fsm35089625e9.12.2025.10.29.01.46.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:46:18 -0700 (PDT)
Message-ID: <52e1f943-05dd-40bb-99fa-f7540c369953@linaro.org>
Date: Wed, 29 Oct 2025 09:46:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/25] hw/timer/hpet: Use memory_region_get_address()
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-18-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> MemoryRegion::addr is private data of MemoryRegion, use
> memory_region_get_address() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/timer/hpet.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

