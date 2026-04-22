Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A2CFA1FD7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 17:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFb1s-0004Ii-8I; Wed, 22 Apr 2026 13:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFb1m-0004GQ-TP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 13:06:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFb1l-0004MC-1y
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 13:06:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so71108375e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776877575; x=1777482375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7DPnRZ82HSJmoMCxXWYUViYlcPAFH9IoLJRnJFoDWmI=;
 b=pbz9If11iHjDXaOgOeP875FLjHByaAopGHenl62cav/JV1L6VQBFO/W7IIiFNBSV9c
 dgJizDgGER4P1EeShDDoOuTNYrPxwLtXWbOXM84P4nBRX3SErHq9+OZxrL3Gc2oc5d/o
 MurgoTOhzVAyULVVm+7dpqtsDi9Q0b3yT7CiHNyDE+HnRVrjtlSKsO3jzT0MWRTW0gZ9
 OTWsvbW/IS57D5w8Iw9ytnoKzQGHPEhOIDd+E7UYwnAZcPWu5m2DAaGonJwc2+7xYaXg
 PIdvas3VSG0t+bs8OraZXGmvdp7uL2JbnWkEfo+tW/1o5aRfWBdHC7z9BoOIktP643ct
 72rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776877575; x=1777482375;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7DPnRZ82HSJmoMCxXWYUViYlcPAFH9IoLJRnJFoDWmI=;
 b=F3cEgCidYBEoNGAeR45n3L4gQJON6yMUTJj6MYwCeek6MX6c2rycD5FdGJpdzYklHd
 8sGBs0MS5m8Xf3MoW3CHnpwL5d3M9g3i7S2htSMgUa7dzd3ZzII6esM86/gdmj7CsGTx
 RzG8HXVdNEkRBdLEa1u4ZcSTgDCFZBQ8kiH0b+zAJ6lj2TNWmJyiVPzH0yHp4iPh7Hoq
 r8i/uMgpXjdR07u3DTTMevEcNOrMrzhzf7wEAa2c1Fa248EBw2RKGndewq02Jm1rD+7J
 AB1ZIaxC3aXQOIUKo/6+gEuEfFoQ2pgprgA67ju5ulN47jcu2BVRjxdWeP39cuVzRa7Z
 AbrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BkkBtX7fpzLnaIfxN4R/Ol4amV0oksqqfoLaaGlz/Bqj66lye+Gb4UTz08bjQHuIHdU248pFjBM9Y@nongnu.org
X-Gm-Message-State: AOJu0YzOrUgN5UYiydiXoqT4zWMK32Xi49Ll0+GhQpr7vZEHpv0JXhw1
 Cf3OEGahK1+XgSctwgCRJfbAMeUF9lp03970B6tBgZIV+Z3cx2UXjXVaYsNZ6hKFt2M=
X-Gm-Gg: AeBDiescbgtHr965JxDa+GMF/TixLjAVmjYXyv3Us3xDMEfu6NG39IxsKPRyxqd9O/I
 YRiy1lcl5lSz2UseQ541vSJA56D8tlkAMN+OScciZ5JEhvPwM1JtLy/3KjxBE2LWf7kqwWzJHJH
 qQdp5WyhAMwPlsEfnHSNWbwalrRBMOjt9bhGz8YaGEWMfRs2gBa0y5IytDSZPvogciQPd9ZI+zG
 frUgEy7ikQmbwPelt0WkQy4mj6j6OPqA8+e7ciT8KFCTmR6ybXwDkmqcnjkAmG6r+m4gI+JpGX0
 Erq29VzEVUM3hcTm1M8LjScVOzpVCumYAO0QmYdR+5Ms2fHD/3MMJGA+fTj/hx7CFgXVgS1rY0b
 yZfbnib6xKo1LENDK5JLA7pervtSetMgCunInFMJJK13k0xQlwPTqnAp5cWyIgGU0yN+vcFuT/N
 tas5hNLrTSJk9fZxHvR3+NFNayYHxTm88+peVUXvspi1ipieqHKy8fqh0xRpX0Ja+d9wQVMyBTL
 XPz
X-Received: by 2002:a05:600c:899:b0:489:1a63:509c with SMTP id
 5b1f17b1804b1-4891a635125mr135475065e9.0.1776877575205; 
 Wed, 22 Apr 2026 10:06:15 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm331350025e9.3.2026.04.22.10.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 10:06:14 -0700 (PDT)
Message-ID: <30fb9fcc-7c34-47d0-a4b7-2e206eee714b@linaro.org>
Date: Wed, 22 Apr 2026 19:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/hvf: fix double hv_vcpu_destroy() causing
 teardown error on ARM
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: agraf@csgraf.de, slp@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, mads@ynddal.dk, brian.cain@oss.qualcomm.com,
 mburton@qti.qualcomm.com, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <ee6f642af1dab29aaf99f86ac9254ddd25765bf8.1776172276.git.matheus.bernardino@oss.qualcomm.com>
 <7be383bc-40f1-4da2-96c7-241946e6e52d@linaro.org>
Content-Language: en-US
In-Reply-To: <7be383bc-40f1-4da2-96c7-241946e6e52d@linaro.org>
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

On 14/4/26 15:23, Philippe Mathieu-Daudé wrote:
> On 14/4/26 15:11, Matheus Tavares Bernardino wrote:
>> The following callstack causes hv_vcpu_destroy() to be called twice,
>> producing HV_BAD_ARGUMENT on the already-destroyed handler:
>>
>> hvf_vcpu_destroy
>>   |
>>   |_ hv_vcpu_destroy
>>   |
>>   |_ hvf_arch_vcpu_destroy
>>       |
>>       |_ hv_vcpu_destroy
>>
>> The first hv_vcpu_destroy call covers both x86 and arm. Let's remove the
>> second one, as it is redundant.
>>
>> Signed-off-by: Matheus Tavares Bernardino 
>> <matheus.bernardino@oss.qualcomm.com>
>> ---
>> v1: https://lore.kernel.org/qemu- 
>> devel/70cca2a5cdde3e6531e5c8f1e399e0b584d51ad6.1776096073.git.matheus.bernardino@oss.qualcomm.com/
>>
>> Changed in v2: removed second call instead of first one to avoid
>> breaking x86 (thanks Philippe!)
>>
>>   target/arm/hvf/hvf.c | 4 ----
>>   1 file changed, 4 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


