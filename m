Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585A0F8A15F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL4W-0005JP-R9; Thu, 16 Apr 2026 07:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDL4H-000584-1q
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDL4D-0003Co-PU
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a29e6110so83041535e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776339567; x=1776944367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qk8Z1h5dKpOHv3yTgvCrCejDOzT/M8/9C50jIFLDzfw=;
 b=h+SLHIZm2AzexU/FnzsF+hucKArrVHdlm4fN2J6+CUWf9/TIiLhZiIIyVRqTeAKnNn
 FwDmz2SozyCng6CRLl9NpRyAURudko+Iv9Lc3wSqfJcvItam1XnbTnzptrzDtmWVCxfG
 51JdxkERcMFMOHxCiE5gYti3PbiBcY0/BTg+WbjE83X2iLg5vpIlyFhz7uKki2dPrCl+
 JmhfsXvpzMYvtMcAqg7Kyh3GYxZMmEYNZ/eXVYYxy+Nr+7au8H9L0OaZqE5zXUwvob6a
 jpsSAGHrJLgGGkVh+KJjTSjbGer2GoAlNJjYysVOuIiv6F/N7/hHLjD0rG3gXmri4XFW
 VHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339567; x=1776944367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qk8Z1h5dKpOHv3yTgvCrCejDOzT/M8/9C50jIFLDzfw=;
 b=ll3uomXA+bwOPqtxW0Tb1dUQGmpqICHZzv4DjcM48dvXPqgeoGAT8mlT1O0LRlGekS
 GCjdbZ0XZmLI+0gSMcnxETuzD+IMQ5N4Ge11H8X1psd8ndS1FqceoG2O6OR2BMCeou1N
 fGZwh9EYC5Z0DT/4MGx4kmTbfdMGyAuAuxiOi9xf5AXZNz1+eLfJy+TkVNtYuiv8K0xr
 YX5vgxrZrh6hwD7+Q2WmP3aZD/7j9jTXW8zoX+4y/i57MicJh1G72bn2/U5u7xx5L0lH
 T12d+kb+EtrUhSif6+pvzqWisTQWIm6D4fVClkaEWtDob89h1fhk80KGlxEu2Oz57flo
 uIhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EMivUj6gHgWU9uipb6EdYADkcXttKnPhO5sqpYjC9A9LVGQImjfb7gI4yvPGbiIbaHGUNp5lv7bTV@nongnu.org
X-Gm-Message-State: AOJu0YzID6IXU8nQcZqSR6iHJDnyRhQPlqxfTMNabM+ZqoVxA8cqzQPU
 tI6llRQ/jMUBIGB8DM2cNw9VfiXMJM62nzy4vk5xT4x8898IRBsKf7o7LR2PsPWG+20=
X-Gm-Gg: AeBDietixBcaJ6l8Via2YIlctLlqym+qdWwtxBF/IMtN9T+ZQHwnXJWbBs4sXlJj6Q+
 M+mTNrWzdXmr/YMFLxSQNWdYPWEyuIN3+iN+yGiIr9tfwQhkDw5GhEbie0ZfY3V5CCBgk3zCmW/
 F9AujyXrDFkZQ/hLr8NgeC1dWm25wyi1Jy5c34Zn5fG3X70Vvk9T946ZjMafBl493/14NejCW/k
 yigVxfYTwtsJtaP4s6UCvseQOcb+wv6yIzcrcGYGEupthxsxlE/O63U7Ag5HiO8CrDK5hYVUWxM
 s0s5gZzQNTHcDKmMSOTBsCRa3QqYbC0gad8OKqCYg+j4JUKrJhBciPOw+6D7qhg9WdIMik6yOrf
 tp8FAegZN0zzIQxwxq+wAi+SCWXU6RDbM+bhlVAmxSGc0oylYVIrnYuzsz0/FBcjNtAeQGUZkKo
 q1061+yrq5YGqhd/+qnmW80zddCCGkWy9lmuFlP4uRoCADTNYUu9ag4TueSvZRgJVuEyy+OvpEu
 4eT
X-Received: by 2002:a05:600c:19cf:b0:485:4453:401d with SMTP id
 5b1f17b1804b1-488d67ebc79mr329309555e9.2.1776339566798; 
 Thu, 16 Apr 2026 04:39:26 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f08b960esm72380245e9.0.2026.04.16.04.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 04:39:26 -0700 (PDT)
Message-ID: <5bf8fe62-a8e8-4327-b887-e203d9066ce6@linaro.org>
Date: Thu, 16 Apr 2026 13:39:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/s390x: Forbid to use legacy ldst_phys() API
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>
References: <20260319185203.11799-1-philmd@linaro.org>
 <f0965bf8-b736-4e53-b809-374945f0f48e@linux.ibm.com>
 <63ddd321-067b-4c44-99e1-9c6c0ac60003@linaro.org>
 <640ddcc2-f373-4738-8e66-50effe56de4e@linaro.org> <87tstdbwu4.fsf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87tstdbwu4.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 14/4/26 13:33, Cornelia Huck wrote:
> On Tue, Apr 14 2026, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> On 21/3/26 16:26, Philippe Mathieu-Daudé wrote:
>>> On 20/3/26 20:28, Matthew Rosato wrote:
>>>> On 3/19/26 2:51 PM, Philippe Mathieu-Daudé wrote:
>>>>> Replace legacy ld/st_phys() by address_space_ld/st()
>>>>> then lock the target again further legacy API uses.
>>>>>
>>>>> Philippe Mathieu-Daudé (5):
>>>>>     target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (cpu)
>>>>>     target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (mmu)
>>>>>     target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (tcg)
>>>>>     target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (kvm)
>>>>>     configs/targets: Restrict the legacy ldst_phys() API on s390x target
>>>>
>>>> For the series:
>>>>
>>>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>>>
>>>> For good measure I also ran some s390x kvm regression tests, took a
>>>> less comprehensive spin with a tcg s390x guest (on s390 host), and
>>>> forced a few of these codepaths as a sanity check.
>>
>> Does that mean we can also add:
>>
>>     Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>
>> ?
> 
> I was planning to pick this via s390-next, I can add T-b if desired.

Thank you Conny :)

