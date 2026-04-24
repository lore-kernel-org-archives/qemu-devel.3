Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B76FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGM2g-0000GD-E8; Fri, 24 Apr 2026 15:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGM2e-0000FT-26
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:18:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGM2c-0006ku-GN
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:18:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso112185565e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777058297; x=1777663097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XrhWP5d/h7UThmqeUx8H3y6hoHc/cyemxhSIuGymrGc=;
 b=HeQe2yElvx7EfQ9684JgiL5vARO/KXjtls5ioetw/kC7N7aJmqS8by5ByS1eaN22Ft
 2JILoD8uYXjbj+s6keaL40JSrv2ou+X2Q4bcwB4d668fe2ZvVLDyBj6Q1/dIdJesuOuY
 dqlgVcE/JmfRfMcpWtFXGdH1rKIdAVeUoVy5Iq2bwmdXS4rJmQ6EWV7vAlKk2XLtLNXD
 s3T3cnPYAw8NI6EM83TKNr0PcxSnAw2VFNi8vYVEBKI+jptDgixX6aW5s/1v9741edXI
 NH7q90E+a59Uh0AojPSMF3YyXgW+U9d83R/U+oWV45BFWxw5ZsimoWPRrRjGo5gbu+so
 qoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058297; x=1777663097;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XrhWP5d/h7UThmqeUx8H3y6hoHc/cyemxhSIuGymrGc=;
 b=IVS96fEVPFCE2CmXJ/nNAFeXpy1k+RbP/kNVVH/5+cLIQCm+UHlwFuAeDf3/WojgYt
 HXNjQoXotYq3bmOHfnw/EaErHWVxHDtK19hB6t3AlnWgPCgknuM+a3GhdCo5VH3oLTz1
 dg3MHg2O8He/YDcP5GuUO0LNCPbzA6Mwom7od5SdxDQra1qL4LC7rZcV9dQpXJ+2LbwT
 PUB0zUZpvj0Xa/YdKutZ7C3+l/X5b6lISClzC92UPSNzd5tCt+ZR5Ze0F29VxRg7bbqV
 d2/QJmXAC76ybkIS4TDCIByDxNbnCt1mHuFf3hv8F1B63x8SpaME33/q4uB7pzLdaehI
 1PVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ989hHzonA4r+Ys/9D87eBoiswiD+Hj711fB6sPaA29Wd3aUMjJJ1j0ikSj6+Rr3yPZgW5RsUl/i+84@nongnu.org
X-Gm-Message-State: AOJu0YwUFU/f4pfVZ5EZImagePz1Ke3gDjm6nikzAkGBaaT5/XkzUr4r
 CfUdk6gre1WBNRVBKDi3/TlGgxKtGBDYucLfiOCbKFfwGx+82WNL3/cJmye3Ubwlcgw=
X-Gm-Gg: AeBDiev1yiF+JoC8RcixKcm3AyzRWCO11fLP9tKlNivlNVCFRP7qLmx8hHGoXwQ65Ts
 3BwDDbSQeusbPB7SMKTTuGHYzNzIOR2oAxzVqQsIYDwdRxxbksQtBrv0TYcd73pPhUWqw1lhf/d
 Nk8jSKS6SnA0NE1FfqZqW07cJ4+wYCwOuMJ7D+aB68fKtd2qhVot9czMyN6z9hnvVDA+TPLEB2A
 zrwx2uciVF2o0q1Wx0B5KzcB1XldQTnNs7HKGBAu0/ca0MEbEHNbZZhT7TqtK9GnAwz/QPMOqzi
 jKWJeZfHAdEE4XhTiPXE5UVClum+FyZz9JSlWX+l1GjAuySvfF+5EguCSolo0H0KJgwZl7RHug8
 KBa8TNTyYQg/Kk+kE19Hx1ftwt119UR3M7FnEWeGvkLKYGTibRlL1wr0VGYUvYa4JcOkowV5E3e
 9NsOTYLs3Dh4suist/iG5qR2tCns288yZw67qb9B0nKYFeushumyxiGT8h1Sma7ujsvnwVliEK1
 Owo
X-Received: by 2002:a05:600c:4fc7:b0:485:40fd:8390 with SMTP id
 5b1f17b1804b1-488fb78894bmr434250925e9.26.1777058296668; 
 Fri, 24 Apr 2026 12:18:16 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489201cde98sm364139775e9.7.2026.04.24.12.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 12:18:15 -0700 (PDT)
Message-ID: <85948999-6dcb-4f36-8450-ab74ebb35e3d@linaro.org>
Date: Fri, 24 Apr 2026 21:18:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1] hw: add compat machines for 11.1
To: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260331140347.653404-1-cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260331140347.653404-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Connie,

On 31/3/26 16:03, Cornelia Huck wrote:
> Add 11.1 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/arm/virt.c              |  9 ++++++++-
>   hw/core/machine.c          |  3 +++
>   hw/i386/pc.c               |  3 +++
>   hw/i386/pc_piix.c          | 13 +++++++++++--
>   hw/i386/pc_q35.c           | 13 +++++++++++--
>   hw/m68k/virt.c             |  9 ++++++++-
>   hw/ppc/spapr.c             | 15 +++++++++++++--
>   hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>   include/hw/core/boards.h   |  3 +++
>   include/hw/i386/pc.h       |  3 +++
>   10 files changed, 76 insertions(+), 9 deletions(-)

I'll take this patch in my next PR to avoid another conflict
with your tree.

Regards,

Phil.

