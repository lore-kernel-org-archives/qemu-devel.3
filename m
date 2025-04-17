Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A71C369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5U8P-00012P-K6; Thu, 17 Apr 2025 14:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5U8N-0000z8-Bv
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:38:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5U8L-0001pD-Cs
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:38:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so781174f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 11:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744915123; x=1745519923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y1Vtm1eGWUlQ8VPlrsYKv6NOdJ7O8Va4ID99yZARSWQ=;
 b=EqyqqTaobZBsUQqyRDc6436KP0vw2LDb8Vd5sAoVqjj8ytW8ZMzSKWbrEWTgqSY8Jr
 JXQpVwkgIERe3SR2lB39Wr3CIDbHrdXtD+GJJnDIya4LoMi45MfVFBqnx1uPHhNq8wBD
 8Z0wuRmJSUIyE9201B6iwAWtaOkUDLXKlwXCZIpTvcwbM8FUjrhZqOptxypDs4dsXLW2
 EbSFipctEDz1a9WL9MYiBQRpdCqHLrmKZ3WKv+zNSlSb3hatjPwRK+fD7KXxFDS1rF7r
 nvdnNP6KVNycZgALP6h5JZ8Qy28Y2PSGV6qKWC2kLh8EAhnvXeLxtsDUAZaFrsKiTUez
 +1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744915123; x=1745519923;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y1Vtm1eGWUlQ8VPlrsYKv6NOdJ7O8Va4ID99yZARSWQ=;
 b=dkx3wxU8rOtKZHa3ItByaoHBNZzT+9JpHmQU7DrjY3ynwzPQvFdmSDHi4TVioZVaDO
 m7sJy3iy2SwnAwmiN3HqeGQBVxZgLjjDdu5TvErimt4/j6wOaoYeBRiuNTbsy9WAFi+i
 m/hKxe2Neg60lo98R8Y48/tz+zN9vkoery0rJBTNGAkdvqBL4YvKAUoOmdKKXUMbUS0X
 qACKOmDBwVLsw1xPPZZXzzXMQKo8GqOSQXUKhVZHVsmgzKDdebldzs1BWxGhdbuVdXti
 iWXVfILv4fq2b1skzm9PMMchhXMpN2MrkxGQSfyCY5DmK287AZiEfV3Kdw4Ek5uTGuDj
 iU6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpxAJ4OCwdWP5NVTPVwMl/SpfEZbz6az3VBSBB8/lN13ODTKZKMXtsKAApgyMYNFoouaE2ja9peseF@nongnu.org
X-Gm-Message-State: AOJu0YwoC1myRuX2Dn6qqNzyZt3cGB4EaBRrNbVgc8qtO75kHS0i1ju5
 rHtHwwRWRWePJcOUCx6fXcN9aclybkQQIj7OFUeTifZ8RP7VFuCZUt0ctPhJqfk=
X-Gm-Gg: ASbGncvE4qyv75iZBwcE4qqTNGtemVd3/0hh/VVbYKQ8Ro8iC8nn8rNtoJdOQKuDYwT
 lOcVFwuoRO1ahEmPWhSz4MZJydKXtKnKBw5ZLIo5f+8fbcd9qfVAZOM9mntt9t6jI4E1N+wq8Po
 N6cIkS5/Y3GOMlPDu7ivG3cCoNQUC8CmKjKW4Emdr5kqGpcP4JMhNuCBU29czceYrUaHZeaGYvH
 nJL58Qd8JoXTvjJd79WB2xnwkLBCP5A5vsbz9MKhllyUPz/9rc9vHodgkZ+3e8cjqcjXK9GD8hi
 WWErzQU2JN/Akh0nBdKhvQo1wktKouB0xnbt0Kg53ixqOPRl8ZzsLpXkEifmU0b1dFhSr/m70D8
 pgqld9evg
X-Google-Smtp-Source: AGHT+IGIf1j1uubSyBAmtE8oen2i1mUNaa/bDzafEBBzJt/3P7c5Ivu41qHfcqRbzcCEklRwyzkI8Q==
X-Received: by 2002:a05:6000:290b:b0:391:4999:778b with SMTP id
 ffacd0b85a97d-39efba5b7a9mr28639f8f.28.1744915123476; 
 Thu, 17 Apr 2025 11:38:43 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4930f1sm391522f8f.61.2025.04.17.11.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 11:38:42 -0700 (PDT)
Message-ID: <fe5198f0-df6c-4b9b-9c68-9b18d8f01406@linaro.org>
Date: Thu, 17 Apr 2025 20:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] cpus: Replace CPU_RESOLVING_TYPE -> target_cpu_type()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250417165430.58213-1-philmd@linaro.org>
 <84eaddaa-ad02-4cf9-be3d-3d8da7a2d312@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <84eaddaa-ad02-4cf9-be3d-3d8da7a2d312@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 17/4/25 20:28, Pierrick Bouvier wrote:
> Maybe it would be preferable to focus on providing a minimal but 
> *complete* TargetInfo before upstreaming any of this, as it's really 
> blocking the rest of the work for single binary.

I suppose I misunderstood you asking to post these reviewed patches as
separate of the TargetInfo series which need more work:

"I just feel the last 3 commits, and this one, are a bit disconnected
from the series."

https://lore.kernel.org/qemu-devel/0b4376ee-504b-4096-a590-8a509ec7894d@linaro.org/

> 
> Minimal requirements to have a complete series would be:
> - Rename QMP TargetInfo struct to use that name
> - Be able to query target cpu type (what this series does)
> - Be able to query machine cpu type
> - Modify generic functions listing machines/cpus to take this into account
> - Tag labeled boards/cpu in hw/arm to prove this is working (without 
> doing any other cleanup to those files and *not* make them common)
> - No other additional target information for the v1, let's keep that for 
> later.
> 
> Note: target_cpu_type will not be TYPE_ARM_CPU, as it wrongly wraps 
> arm32 and aarch64 cpus, while it should correctly identify one or the 
> other. I suggested TYPE_TARGET_CPU_ARM, TYPE_TARGET_CPU_AARCH64, and 
> same for machines: TYPE_TARGET_MACHINE_ARM, TYPE_TARGET_MACHINE_AARCH64.
> So we can reuse this naming convention with any other target we'll reuse 
> in the future.

Got it.

> 
> Pierrick

