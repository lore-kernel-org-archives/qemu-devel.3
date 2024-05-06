Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8F5C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 10:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3vU6-0001RX-HQ; Mon, 06 May 2024 06:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3vU3-0001Pu-LX
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:22:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3vTy-0008Qb-Rh
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:22:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41c7ac73fddso18499335e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 03:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714990925; x=1715595725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ilbeC+ygufH5V3ZDcZlT+wqSJLkVPE09rEah8GFOVCk=;
 b=xZJTY2MwsYP3qLYinuVaUnnz3BBswyzkHskoxmlka5XVQTlagg336wV3eREZKWc1gs
 hmRUT2vFV8DQJuhynEmGWiaAh/du7BvfgkCNc5B5+T7h45jYaW8IMMp6ODj304SbtIKw
 lBNBclpdkqQZH4VRoDvEaNzLanM9ZFhb86uJE97PllqMEU1nZ1T8SgoPi4pL6drv6+6K
 VHPjo9w+y2hyCHf5/0t+ueIiyf237h25yxTnaGbc49BstWSDhAas+jIv58cAWi7OOXMN
 JCIQgoWS05J0hhWGsY766JZ550A+qJ1Kv15xjG5zgzshQATZOpR8lQvoOEi2c9TbYRwR
 6BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714990925; x=1715595725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ilbeC+ygufH5V3ZDcZlT+wqSJLkVPE09rEah8GFOVCk=;
 b=XlOIW90zrKNV7oM+Bqx9BmncMgQVANz02SL5moeoNm1TbxsUecOEvSUWXNe6Fsnalw
 OfrzBy8e1hgcjZftrc7bVYaG5W98atuNOg8srxk2Bm61+/wbFhw2vXq3yrSMe6Kq6TjK
 5y5sx2IU/MMbry7nkeuFcKMYZ59EnW+8jIv15kkbM/IPSwRIyo/L2OFSF9p2Sz90lnvC
 vE8prc7IsJtbdTS+Y+jF2lMiY9ZIsgY1z7gzMLcCNdvrJsqBJQOQ+MylPuAoo/z8cKMs
 h8mQZE73rtS03hoOnL2tmvgtaai/gA4a7GYv9eRsA0u3TV8pEKeeE3E8eurtTzzlIJso
 UI6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeUR0rYYq7Ql21fJuyxjfULLRahbK97a37E37STq9FiM3muzueVVtprTZapsI7FUHjI+a1iH42mZ0DBs3hZ3s02Llg+xg=
X-Gm-Message-State: AOJu0Yy0/OJZQx2Gzy2U4n3tbaOfmZBFpOke35iqG3P/bo/CRbwVNh84
 Dejy+53YpVA342E9HavpuyolAtGUFVoQzD1knfCnzBa8Rf0Nz5gyaiAqoZF3imk=
X-Google-Smtp-Source: AGHT+IEz3G/PqHe9VAmMjR3NKpgGTo5GDm13K4iOusz17D1sWq1x/nyWqplNUACy0Iv4lUzLKKVUdA==
X-Received: by 2002:a05:600c:1e09:b0:418:a706:3209 with SMTP id
 ay9-20020a05600c1e0900b00418a7063209mr10481700wmb.31.1714990924971; 
 Mon, 06 May 2024 03:22:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a05600c354e00b004169836bf9asm19292525wmq.23.2024.05.06.03.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 03:22:04 -0700 (PDT)
Message-ID: <c8194252-5048-4b7c-8890-0f275e61aee2@linaro.org>
Date: Mon, 6 May 2024 12:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/17] xen: mapcache: Break out
 xen_ram_addr_from_mapcache_single
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-7-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430164939.925307-7-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 30/4/24 18:49, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Break out xen_ram_addr_from_mapcache_single(), a multi-cache
> aware version of xen_ram_addr_from_mapcache.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>   hw/xen/xen-mapcache.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


