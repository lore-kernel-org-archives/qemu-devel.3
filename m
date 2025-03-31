Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DC2C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 11:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDQl-0000qi-I4; Mon, 31 Mar 2025 07:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDQj-0000qY-N9
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:35:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDQi-0007EL-33
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:35:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso45076245e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743420946; x=1744025746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jYSiNgZPj8EswJTpWMMTe2XwUtYQivWy1VKRpDx+JI0=;
 b=pZ/028tTHzvvAAWck+30UFTVzeGI+msEh9L2EnSKuLwmPl5wOzXxoJjP0gTRVBP0Bk
 2Fk0dmXZlQkPLUnTyDZuXP0kdYvS64iRUdVKKiDfSFoDFO7YR83rcsqEl3vIy1TELLFi
 hPXEHewPA5k4CDkvdslg8RdmZw37GmDyuXF3BkB4PjjS0GJFJuu40q3GlqxeuXles1OQ
 qT33QQZR+8Hz9cZ/JHyskTnYxI1PgB6xfRPr9G+qSou9+ycRDvdNEprP3BrtbMdcOk/G
 fSfchl+B1rDwek7LzG/Opf5m3Ke4kqOc5DbJELXPu/tTPZ3DmrcGVKsWvhzWHdnDQGGb
 CXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743420946; x=1744025746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jYSiNgZPj8EswJTpWMMTe2XwUtYQivWy1VKRpDx+JI0=;
 b=uD/9wB3b7eHMYbHwfoQzB6eH27GjxhlT18e7hSgIpRwNPP/5bMnm7NQCou6Zx4ulVd
 HVtRkgelVrvoBho3lBpf3nDnhuKPLysCoVNzkvRicHozfSP1uFJGwKLhyyfEL13dYaJw
 h3YJrBC9vyReCFsQR77IulRE8ie8OMORpG57mmDZH/bwZvTvcuIkPDltSbMlpsue9cOG
 9nkla5fNc0vZyEaSxk9IZIxnTwTpnjl63LGsg7Ex0uRdk0gQQ1YYCQGFKWsmFwKXBSdK
 8x5Fp7sEkBhzxy5NRvAXYkxD8OZ6iBbuAiyXcksDATnWr5EV2KDieWWTknXBVJ5JkWsH
 BXYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaPV8hQIA5QLeSV5T04KkyBQqx/dNgjhxKDst2jqWRquNOL/UwHrJ3ccXw/qRU2/MmwkMKifdwqp/3@nongnu.org
X-Gm-Message-State: AOJu0Yyzaji6B9OBB9xtlmwLTstlR8oHtTyXuMgyLRLOo7HC2k8dwk30
 icvfn+q/loLNEupYV9ANwrmVhBnezv5SyxG5VZYxN4V49Hom6qwh5iYaGWdS1Wk=
X-Gm-Gg: ASbGncvSswlnYDoIw4SetsOYx9RgY1DsDjIfcCcqR/99US6bW7LfR13LB3ksGaF7f/N
 pBOhGaXYSK93rwwGnlyVIpeRJ5tTOsrpmbVaywhERfFEumJ1k2tPsTT1mwycmyGmySh8Ft8CqV+
 ZkIsCivE75yMyfMxKZ3XuyFdF+sSGrRyV5N32a6DyKabdyUr3oudFmtFDBZDO6g2Q8Vz0tsNboM
 44knQ8vDhOsfnlFWgkC5VkpyC+c5+ADuXSqSVRqrC4UN3o35MVDuKC+/IS2VKuDpVKh+Sk8GR+7
 IxxrZ7E8n+zoa87jB3lVMlzM7URbfZJf0PVTp8uQkJs64/Wqg9NvjrsCtHBNPjr70oJ1vFZNZna
 BYCH1bFgQIcKA
X-Google-Smtp-Source: AGHT+IFTH8Z2T1iIIp9+3+nFUeDUtfDyZSReqL/zyE11RLO+uprWXFSLD1q/CmIq7PEZV7vlJ8m97Q==
X-Received: by 2002:a05:600c:a49:b0:43c:fceb:91f with SMTP id
 5b1f17b1804b1-43e8e3d008dmr61692485e9.11.1743420946563; 
 Mon, 31 Mar 2025 04:35:46 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fba4c29sm123459495e9.5.2025.03.31.04.35.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 04:35:46 -0700 (PDT)
Message-ID: <e5076e1b-085c-4456-bd55-ef24460540be@linaro.org>
Date: Mon, 31 Mar 2025 13:35:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hw/pci-host: Remove unused pci_host_data_be_ops
To: Rakesh Jeyasingh <rakeshjb010@gmail.com>, qemu-devel@nongnu.org,
 thuth@redhat.com
Cc: pbonzini@redhat.com, balaton@eik.bme.hu, marcandre.lureau@redhat.com
References: <20250330210155.74295-1-rakeshjb010@gmail.com>
 <20250330210155.74295-3-rakeshjb010@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250330210155.74295-3-rakeshjb010@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 30/3/25 23:01, Rakesh Jeyasingh wrote:
> pci_host_data_be_ops became unused after endianness fixes
> 

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>

> Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   hw/pci/pci_host.c          | 6 ------
>   include/hw/pci-host/dino.h | 4 ----
>   include/hw/pci/pci_host.h  | 1 -
>   3 files changed, 11 deletions(-)


