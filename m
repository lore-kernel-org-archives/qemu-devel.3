Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F26C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd3Q-0008Ke-UJ; Fri, 07 Mar 2025 14:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqd3P-0008KJ-E1
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:08:15 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqd3N-0005S1-Oe
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:08:15 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2239aa5da08so37290735ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374492; x=1741979292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XRrvS/2zr3PjOd3Kq2XEoODr+QbZpUxQ0Qb9ax40Uxc=;
 b=D6x7PNtTXNEvAB5AX99NWvel1PrPDqPu8OA0EBvHSPNdztRPERRakFlMXXUErkCGei
 q1YxCnenfH1+bFgY9+2RDtH8gJpWZhCgT09w24jdIsYzqWGammylEGZctP8tdl1jjPAV
 CfX9P+DUzOVWgN9JjgSjJbh3uGAU71pGk31jgLkoz8vO+WELLHPgv+T0WXKkNHYlfZe0
 cJ/lQo1ZIGUBJnBt9Pha657hX+WcABoNV9EfHv2Jj9Op3yocnqFqcpGbk2JctLXLZKTU
 5tZbyx7o35GOciyEnZd0naZnMSGWsQpBfTXrnF+Q8RT5I5JHlqZqCIGN6xB/ap1sF5YL
 BAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374492; x=1741979292;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XRrvS/2zr3PjOd3Kq2XEoODr+QbZpUxQ0Qb9ax40Uxc=;
 b=bbdvThVGUrD57YhpWpqqpV6aABQxzqKQo8mpcj/7r3y6Vt+Gu53GC0JXtZvL1PJX/Q
 Mtwh5JvL3hAp4tKcS7roxk+I2mZG+gLt3BZTROfecK9/iAc0Rz/IKa143a9piHyCCeN+
 rTuCk+HrDpk5I6Z6nYzACf7zcM1tMcgnNGX3AT2rPTdvVN7xf6vT7JKEddmQ+xTRoUhV
 DI77gdTsGIWcO+2twBsr6UVcdE5EScmhFMgf+lP01bcbsWrSOjaNRHxn/d+tp++w2gIY
 YxM4Jf4Oj9A16vFeNKfOYYlscro9Kn5UJo5aieVnBxM6XOXgZBcW54Wd5EyEtgjCtXQj
 zfnw==
X-Gm-Message-State: AOJu0YzVTl5tt/GsyR5ozmopQpPVoEtw3mzJCRplc1xwNXqgiUunYQLP
 JF7oMfgNRNwIICB/8ROmYSua4/KukRzvPQtY3lHQMTMBLdjri59EsQc3a6L995s=
X-Gm-Gg: ASbGncvpcCMAmZxxBaBuot1NyWUztnoMrKnUs0/QwmMop+PJl5sCSJ2xq7t6QLfDV50
 UAKz1eHWFa8sxmNn1VUtMxt7axTbh+kO0Kz+zHL5xfuzAhrozpYpW7R+Xygyp6T2ZE5B4o4qRcN
 /a9JrNHg1qmAJCo6/OcMipg/4m5bApkRLCIM3uIcCr9VSyFWGKTPkaNeltjs10b750cIdHOXpE9
 KkUnux4tr99y4cp9lzSxslrB8eJXoAMGFQTM23Eoey05K94xpgYZT6WR3u//XK01ysUgf/aedTQ
 9xhUdWea3HKPSo7oGm3u033kKlglHb0LDUAtYRxuf/PIUl0S8OxueVmb2Ju+TeeJarm3dXmZ/t+
 00RHdx3Lt
X-Google-Smtp-Source: AGHT+IGIj8qfN6K3PhErC/LCDQDjq4OElHDeL074RaPMcFUo5xm9SntLp21Uj7gpyZ+l8zzDt4nmcg==
X-Received: by 2002:a17:903:1b63:b0:21f:85d0:828 with SMTP id
 d9443c01a7336-22428be5cd1mr77802595ad.41.1741374491799; 
 Fri, 07 Mar 2025 11:08:11 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f95fsm33730835ad.154.2025.03.07.11.08.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:08:11 -0800 (PST)
Message-ID: <ed122c7e-4032-456b-b3c2-a251e73f0b77@linaro.org>
Date: Fri, 7 Mar 2025 11:08:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_USABLE_EXTENT to runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250307151543.8156-1-philmd@linaro.org>
 <20250307151543.8156-6-philmd@linaro.org> <877c503ie6.fsf@draig.linaro.org>
 <a7126584-00fa-42ed-8e5c-d27d9933ac2f@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a7126584-00fa-42ed-8e5c-d27d9933ac2f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/7/25 08:49, Philippe Mathieu-Daudé wrote:
>>> @@ -170,13 +171,16 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
>>>    * necessary (as the section size can change). But it's more likely that the
>>>    * section size will rather get smaller and not bigger over time.
>>>    */
>>> -#if defined(TARGET_X86_64) || defined(TARGET_I386) || defined(TARGET_S390X)
>>> -#define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
>>> -#elif defined(TARGET_ARM)
>>> -#define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))
>>> -#else
>>> -#error VIRTIO_MEM_USABLE_EXTENT not defined
>>> -#endif
>>> +static uint64_t virtio_mem_usable_extent_size(void)
>>> +{
>>> +    if (qemu_arch_available(QEMU_ARCH_I386 | QEMU_ARCH_S390X)) {
>>> +        return 2 * 128 * MiB;
>>> +    } else if (qemu_arch_available(QEMU_ARCH_ARM)) {
>>> +        return 2 * 512 * MiB;
>>> +    } else {
>>> +        g_assert_not_reached();
>>> +    }
>>> +}
>>
>> What happens if/when we have multiple arches available? Won't we want to
>> know which CPU the virtio-mem device is attached to or do we take the
>> minimal value over the whole system?
> 
> "per attached vcpu" is how I was previously considering this problem,
> but IIUC from the discussions with Pierrick, we should consider single
> binary as a first step before heterogeneous emulation.
> 
> If you think the minimal value is good enough, then that'd be my
> preferred choice, as the simplest to implement.

Indeed, you have already done so; see above.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

