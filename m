Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5DBEA794C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 01:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnns1-0001CD-3c; Wed, 04 Feb 2026 20:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnns0-0001By-Db
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:09:20 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnnry-0001zR-Un
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:09:20 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-352e3d18fa7so392284a91.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 17:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770253757; x=1770858557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eU+32z8D00HiGFOPoXubGw0gCnRiy84fGXANNSAZn3M=;
 b=tI9uRRnZSpzp1XP4Mc20F+zV+jTC3UIlY1856UPVlaBxqdJtakY+/4nuB44ezO6LGa
 CaGVzHGAaQLnCfdT4wvRtwngL3Ufk+xHp2G3857iCYr5MlhZmzdnOWWYsut3+VERrj6m
 Tbbca97z7NW2Q1jhFWZeUQi/o2TxQaLlYuAKVQ8YIHaXRg0LkU/u/p3vkFt1VIgUNhPx
 7TP91oYv2SdUhJgj7dVkCMrUEBjF4MIGvpC9K5L6uDFFxwoZBLzVo8pgW+0zrshFK6gK
 EYPh45Ul5cfByRBX08rpF4HjtuhGPDBNb4FIfiQ5yy+tGJs/XeK9TKeFOWbZu5idgd7O
 RT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770253757; x=1770858557;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eU+32z8D00HiGFOPoXubGw0gCnRiy84fGXANNSAZn3M=;
 b=U5eM4mtweAlhBXY0UCpG7oCcG08hOt/ks57pXX7vw5jorapchTJn6Q5GefOhh3VZpb
 p2/R2gMyVAy61aRVsNbXfJ7BPN3HvrndItSES2eQmqQwaMMFO7VxQi6oNlTaX6qYPejI
 ymbfw8/HNkFebU1/Z49a6JOXRyAgvbAHMx9d62v1mT4as1wRFrbStQPzW8sYSinejwB+
 B6XyjbxDpKSPJrmLZnrskIQvl1s6CafJRlzDjghfzPyuaYHJXjb3tW6uo/ROkQMWw0Yl
 zwYaCGN8E3MGAnCAq6uN1b5jtSMMLCg61gltcqZorGfj8gunV66vI3BhVIjm+ZaHmVcc
 ZpcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG07Xa57qeZqkcH6rT+6Cz1WSE1EOgGCv4802eH1zYdHAo85d8HUJ28antQOSubBbu4r71vTb/K3b1@nongnu.org
X-Gm-Message-State: AOJu0Ywn2U9e2QlqiT0UHG5QK4aMTtLLUe21nfpMh4vkU9OSjQmi63eZ
 swHZvWJiWok/eQIp14wxo+tBZ4XNLlIXTHpW1IGTieMlc9lqneeJDoyhOZbNYiya8vM=
X-Gm-Gg: AZuq6aJysZTpsqix5hKse1hAdSydARFfiAuIf0lwQYJaPM2ixp6JctTy3q3F3A38PeU
 QkaYw0lUZ8AjYPezkXLaSSbbQfGY+s03BYG8wZ0S3yrMk/6yTsA1oZ3QKHf/mDxOVvJdS5bzJJ6
 ugG85u3zsHq3qMs8PQjTQ8jNFxLJZZl0T6JKYHBW4By60v1prvP6fbBr3jAlWK/ZPJgzKnlT90H
 TBxox47eOUvv1sq2ZVVgiFdI3uuAzNxFiOfQJkGq08LBqDCsRmD+NTVFija5KIUe8LNk5Uo9y4k
 2edKmRE8zVl0F1ofLsj82bPhu7Fd2XLhzk68jKhY6jYJGBB5PpRRrcVQUsy3Ko+Q21yhcW2Tqds
 vAAZk2qjQpvRR+V2c2ah9f7l+c5AHBxBgDzTT1kqzJFD+bylq3nxZHRhQCXgtFuXukHS4NdOyxu
 ovhupUp+azSAN2h+mV330Ap0mwcyPewVhjIUrBNOUocyoGTihv8N8UyFVc4H4HvVEmwe+UdhBqH
 DieiRJ6WszkqWmc2l3YHkJG0nv6SEfkmlersQlICA==
X-Received: by 2002:a17:90b:2fc6:b0:352:cdda:7aa7 with SMTP id
 98e67ed59e1d1-354871af6edmr4272793a91.24.1770253757264; 
 Wed, 04 Feb 2026 17:09:17 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:7515:513c:b646:18b8?
 (bg30dhzygc4twf4fscxk.ip6.superloop.au.
 [2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3549c09adffsm550455a91.4.2026.02.04.17.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 17:09:16 -0800 (PST)
Message-ID: <afd299e7-7085-4299-a9f5-afe8c1127ec0@linaro.org>
Date: Thu, 5 Feb 2026 11:09:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/i386: Stop using the legacy ldst_phys() API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260204204103.46343-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260204204103.46343-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 2/5/26 06:40, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (4):
>    target/i386: Use explicit little-endian LD/ST API
>    hw/intc: Mark x86-specific [IO]APIC peripherals as little-endian
>    hw/intc/ioapic: Replace legacy st_phys() -> address_space_st()
>    configs/targets: Restrict the legacy ldst_phys() API on x86 targets

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

