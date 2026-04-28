Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65910FF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 05:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbMl-0001Ml-4F; Tue, 28 Apr 2026 01:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbLv-0001Fr-Lg
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 01:51:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbLt-0001kz-Gx
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 01:51:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488ad135063so99518425e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 22:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777355478; x=1777960278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=82s8Xbcsqcdnu5LtP6oP0E5gOk9U8l5QLkdyKKiLOkg=;
 b=VhVmlA1D7OHbiHCor7JO6zgROWADtFgk28MYQiT5k0TDdwfG8tiKyae42ZvYSKq9t2
 kWVBGsgnPeyaD9ZYiRYN7BaXsiXNQvt2S5z2NjIzFqmm+ZHYE3l0bWXy8dcYVzRW7Qgg
 DquxmA2DDjJTYlHW37dBXqmZNir1nc3nBUuwDh5/nals9a7c+7ZFz6HBJf3VQhGtbzix
 rYRw10x4jeJ1kOg+intBxrFMPC2o6g3LNAeqRlyOAbvdyzwm30JVnbLX+FuZwBkwcsCx
 7evmu2zADdjifs0830XMwsVp2S2WRMvZJsMnzW+hyQrybgy3jxh3XCWqgBRyUkI//JDa
 empQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777355478; x=1777960278;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=82s8Xbcsqcdnu5LtP6oP0E5gOk9U8l5QLkdyKKiLOkg=;
 b=QLdB4yC24P4tGySRTJE1ZC9le7/KXq7jN/45xUjfUlTN7pe4YIgnFQdr1OtsDuOfwY
 rZCFxmk1iQz/9TshGVeCbz7vxiTNccW8GbDtVcYgq9pTTsP1T4o0s5TLLJPOZswT27rG
 uD6Wgc4VlMVeLqa7hzQrZQCtha/mykH3H/6iQYi4z/LpaqSEdeeFZJTBvK+s2vc6FQgO
 27uVARpYSARg0dNQjjlOksw5bvTSY/BJxBhYZGGiArPcifbuL/849ItOT1T2kFLKFr7j
 b+tlqfNPaJ6UDbRNaBw2bCeE7siJIYzWschVJUnG54qDxukcgHGg36FPByNZbQoEHHGc
 9Zvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cDanWhEV5be6FDoplir9lgJpghx7eNnBVjuL2SLQ6Se/cUqoNOG4gs634VpwpMXApy59TdvSsF04Z@nongnu.org
X-Gm-Message-State: AOJu0YwnS0ihLDI0/YAv0NIwMvvLvsZ8/THyNYwz56fz/Wz6VZG8nUIq
 jLaTA6otaLLuwuihK7BQhp24WuBLShhzbUtThiOHCOc0NsaWdeInq0qW1ukm87UXBBo=
X-Gm-Gg: AeBDiet7VfA1w/2d9GjEma02Dxig2CI5ILHZdgZDXFclHI824WEA8rQovafZk9G25F8
 z9Gcve/YkDbW90foZlaqcv+adGNLv1OlJDese3PW6XJviBxOlIJ5Zojsa7H3y8xvrXTm20LJTul
 jNe7dYQpMvrwAjfzeREAlLrUNYoN+wTvB21cK1qtJpcA2h1dzdOw9SBmJHQvj8qMguX8Gk23Kim
 viiWphgs9hnWMs2iDR/bJP1Qg4f5aUoTxGRJJD+iPlkDtPIfAsQU8Sfrl7z7ixzgER9IJXsf+Kg
 vSi1SQXyRydGbvJl13hE2e2X0Jl8lIBZNWevRt8GHJxucY2TPud7lBtdMqE1lZJf8u7x2QLlmoj
 xfMYc5ce0tnX01VPF4hXzPlnTXL87frk2ifvlAvxvwcDTItnn2jt7M3Sap+5sfpFtaSk3w8s4xf
 dty1qJUVO3yhqHXJ9TJKuwAb9hkzPjQm0FijGX/rTjxTkAmZ8uoWXqJQ1i/OgcsbJw9HBWKgYbC
 98BTMoEOPvfI54=
X-Received: by 2002:a05:600c:4ece:b0:487:2671:fb8f with SMTP id
 5b1f17b1804b1-48a77aeb20dmr25601885e9.8.1777355478069; 
 Mon, 27 Apr 2026 22:51:18 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a775fd14csm11048005e9.31.2026.04.27.22.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 22:51:17 -0700 (PDT)
Message-ID: <5e123304-628a-4da9-81ca-585498c809b6@linaro.org>
Date: Tue, 28 Apr 2026 07:51:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm/hvf: Stop pre-allocating cpreg_vmstate
 arrays
To: "Scott J. Goldman" <scottjgo@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
References: <20260427232116.50586-1-scottjgo@gmail.com>
 <20260427232116.50586-3-scottjgo@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260427232116.50586-3-scottjgo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 28/4/26 01:21, Scott J. Goldman wrote:
> Commit ab2ddc7b66 ("target/arm/machine: Use VMSTATE_VARRAY_INT32_ALLOC
> for cpreg arrays") moved cpreg_vmstate_indexes / cpreg_vmstate_values
> to be allocated by VMSTATE_VARRAY_INT32_ALLOC and added an assertion
> in cpu_pre_load() that they are NULL on entry. The same commit dropped
> the redundant g_renew()/array_len assignments from the kvm, whpx and
> helper.c cpu init paths, but the hvf cpu init path still pre-allocates
> them.
> 
> The result is that loading a snapshot or migration stream into an HVF
> guest immediately aborts:
> 
>      ERROR:target/arm/machine.c:1043:cpu_pre_load:
>          assertion failed: (!cpu->cpreg_vmstate_indexes)

Ah! Thanks :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Drop the leftover cpreg_vmstate_indexes / cpreg_vmstate_values
> allocations and the cpreg_vmstate_array_len assignment from
> hvf_arch_init_vcpu(), matching what was already done for the other
> arm accelerators.
> 
> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
> ---
>   target/arm/hvf/hvf.c | 7 -------
>   1 file changed, 7 deletions(-)

