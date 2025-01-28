Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB4DC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcsfN-0005Z9-Pr; Tue, 28 Jan 2025 15:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcsfJ-0005Ub-15
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:58:33 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcsfE-0001nO-2H
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:58:32 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2f78a4ca5deso8324484a91.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738097907; x=1738702707; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8h5iWUGhVBBC/lkigmFD/STUslnMP70f4HvPeKAd450=;
 b=SpRu+miWASQjh9LeyTdhTAlKjj5GL4noF4R72aZFVY+2kfRaOGTPqskFmaAd8hL7NS
 MKF+KiOe2mFxYTRJMa1OUxgh6g/l9lqIusSq+rzUCPhPvM8yYOTTh0gNzNMexF8dA7Ah
 mCt1bwfFyVz+b+pxLT5iANtR/VRwITgnLAtg8uiJBuixcuBsppUMhEuJ6a+7rJqTTh83
 79MUbOzXcRkg6R2ILwV/9Yt4zQn5EgGdC9LlQN4GIr2QxJMuicpwOW26oAiHM5yH9E/G
 +3mL3skIcV8LgAcLW1q9fnIBETFz9PS4jCzIDMzl1+AtatfGfHa2D9kNMpSbsxRoLyAz
 7YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738097907; x=1738702707;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8h5iWUGhVBBC/lkigmFD/STUslnMP70f4HvPeKAd450=;
 b=XxHTLqjygKkS8xRDrFgJAwx1M8Y2LsC58XjXB515G5xSsi1yL2svZQMYLRk8QTeIRU
 jNUGSobLuQhXV9ASHBzdfnT7XEAuNOH+LxkhCByuOfU9IVXov4QpTp28cF/IZdckx5RB
 IQnpif9sE9BUGgRSlDzEJ8ARovu4TygyurzhlxRm2tRMCqc1cGiHR8mGSkBqDoTAFhQM
 7Gg7LOsbmHzCrQ5PayUIq/lUxMErXzEhGBGb8rKZDYfAOum7e7JN83QXee02MxenUL6Y
 rFzAPiVvfhG+K6x+aYudm6fqpHDf0HoNynBWCtc1eMEkQqAhw5eP0diDgGhr8oba1QSc
 wFrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfgqQtt4Kt9DJK3p9yQlBJxfdAiFyq6gEqygCuOZYJQ0u7CmumQPFmERYZtw+jqNlRBuRrx2Ky8bYJ@nongnu.org
X-Gm-Message-State: AOJu0YzB8yLUtKoPn9eDLvr741VVc12tLJDj4acEGdbt0fhhetFQPHIr
 IiwBYKBdeNRgZBY2QfXJVInl/ixwPpFSTxoCPYBhSh3GmqEcgNBceiwica7r3ew=
X-Gm-Gg: ASbGnctXv5wAf4LSpRV+t/R51u4XUHlHfwmNJBWtE7lYhPpsPY5tirYi5aFG1KlInSW
 rzejjHzAq2r2qnSwVZWUbLfKT3IjqTYVh6ONbVw4/TSY0ygByRipW/YryhoBPcfvXTfknz1z3Bi
 u9W9+vJC5Fo5fZV+qV8Wan6bWCGqqLkJQOLmuK9AWgCKSuRR5h/aQKqd/AtrKFRR6qQsc4OIe6l
 l3c+ifi58vd/AyyH02hh5qTW8W7yU91+Jk3oSjTsLhoe9zgpYnKm67qgMhrsN/7OdFxJvWAgLqO
 Zv4d7wafjvYXEHUDqIJ6BlshCT2cPqNPbKJOoFfGoyxzgFt+C8rE0BP2+Q==
X-Google-Smtp-Source: AGHT+IE9sMcT2h+DOoOPi7bOSe3nzGIbc4vcCjybrIenk7Rc2O+QQp6BUUSuE+Uu0HIw08zA2OmGlw==
X-Received: by 2002:a05:6a00:35c5:b0:728:e745:23cd with SMTP id
 d2e1a72fcca58-72fd0bce22bmr1064373b3a.3.1738097906741; 
 Tue, 28 Jan 2025 12:58:26 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6d2cb1sm9841865b3a.84.2025.01.28.12.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 12:58:26 -0800 (PST)
Message-ID: <7ac5eedf-8bad-4f0a-b78e-325543ade29d@linaro.org>
Date: Tue, 28 Jan 2025 12:58:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] accel/kvm: Remove unreachable assertion in
 kvm_dirty_ring_reap*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250128142152.9889-1-philmd@linaro.org>
 <20250128142152.9889-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128142152.9889-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/28/25 06:21, Philippe Mathieu-Daudé wrote:
> Previous commit passed all our CI tests, this assertion being
> never triggered. Remove it as dead code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/kvm/kvm-all.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index cb56d120a91..814b1a53eb8 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -830,13 +830,6 @@ static uint32_t kvm_dirty_ring_reap_one(KVMState *s, CPUState *cpu)
>       uint32_t ring_size = s->kvm_dirty_ring_size;
>       uint32_t count = 0, fetch = cpu->kvm_fetch_index;
>   
> -    /*
> -     * It's not possible that we race with vcpu creation code where the vcpu is
> -     * put onto the vcpus list but not yet initialized the dirty ring
> -     * structures.
> -     */
> -    assert(cpu->created);
> -
>       assert(dirty_gfns && ring_size);
>       trace_kvm_dirty_ring_reap_vcpu(cpu->cpu_index);
>   

I'd be ok squashing this, but also ok with retaining the patch separate for the CI comment.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

