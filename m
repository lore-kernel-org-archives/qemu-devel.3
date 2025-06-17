Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA2EC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYeU-0000zH-6D; Tue, 17 Jun 2025 11:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uRYL8-0004Bk-9j
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:35:11 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uRVx5-00052P-O4
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 09:02:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so4705552b3a.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 06:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750165328; x=1750770128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iDry9tfFvZbE7BA/ZG2VctmEiKG5/hgVcCbfAt73fD0=;
 b=rob8aiv24CKMtxBCVT/SVIHvcCybqsKFcuj48Drq19jtvqfY8MCEJVKwjJWsnjaPTi
 kr5CgEmTmMX0TwyaFLr79Tnoji6TODhE0NGzM0le5aOYNVu0sgUCs/k1dyWmS60jp2db
 tHqIKfudoqNv6uX42Va/brVyLOY99bY/8jJos3JDawynAtdTgifq+BR47Bp1peA9DLz1
 8sQV8QiTNS2mKuRxHLHauaSQSyW++EnWqAv8aAECZr9FK3wPAxaQ9n4vUnRvKkM3oR65
 fI9wIM8ze3K0OJ8cqF1HBhMgIz57quM8uygvgko+YWjkVGADyu7KEq4KYXbMy+OfZh5N
 iCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750165328; x=1750770128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iDry9tfFvZbE7BA/ZG2VctmEiKG5/hgVcCbfAt73fD0=;
 b=PLooHrhiiCmC15kkBo5Gba8a99eY/wbk5fLupn+YtuTI6xwN03JMjWq7q5nFYB6CtB
 5h1fnfhwAsd2zZiHkwarj6jWIgO6dx0RTMsj5Tvlk5JPVGi4BgLug1dGZSUjPQoDLppo
 HzEa4cJB4oSaD/Kd4e7OrYjq7qCcXcQgBbCpSIQtldb4O6IqTBbj13wd3tzfAJPMbTPL
 A0Y0pk+tcC8pH6CQkjIfUNat8/gZ4KckbQIV7R8wGxPWmEVpIjc+61KbbRNPr2LDKUlW
 KzWaSquAwZ+GfMZ4R64jkceLd69O7jsGbl+D/pQuobNTDjY3Ty5MBR8Ueobk9CXPVNOV
 EMCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeirEGiX9seB1ts6nFZqNvl//i5yjKArO1Be3LJBomU/8iMLcpsbtXz61aZvHv+re8PAYLItpduMcR@nongnu.org
X-Gm-Message-State: AOJu0YykpK1/0mEtL0ibP6Kyc6RjQwe+GKEFcGll6DmOPLQaLGX0SYQ7
 nhfl6I+Hhm9E9d7DXkBVGzOVCBN4f59FvPo0P9Tb3+1E/MiEWGiFzDrC3qvdLu35UTM=
X-Gm-Gg: ASbGncsWrZVBbYNLRCEz6kaGJ3b3E+LVsYMqKs1Jymn0vXzHbRBpKxLHeFWwn2hUgkq
 VcxRNPQq3P+BBbzrt0+eSjV9iDpYMIibtCqMQQ6mZ3jCrbWRw7M6GaoezC6gNSnuN9czPgKwvMd
 fg/dGDW0pZKoDPMy3zzX8GJ3RVXa49IZH5a5w72EhuemcdOcXD9pSj5NQGkPLNyLU0HKEj3K3sQ
 KPYBSHTMRUVwc1jsE1p2Nk0YcI27qBm3C4YNxYj9MzxJKTcwShoVpIR60eI1W3BHzhH8BHpfYHD
 S1uUwZKyMVgafBKUnSypcgjnKkI1OKhRIPeehaVzOaamL3NHmyuFTKiN2HbIF95D+ZR6alZpM1C
 cMs/VxyDg
X-Google-Smtp-Source: AGHT+IEECWLcg4ihqU92Kn6lt/pjagA8DA6HvuiYyIMlm3A6pg+NKAIywgS+4TjCW0KifbgQH4L/BA==
X-Received: by 2002:a05:6a00:1255:b0:748:33f3:8da3 with SMTP id
 d2e1a72fcca58-7489d0335f6mr17300209b3a.19.1750165327753; 
 Tue, 17 Jun 2025 06:02:07 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.60.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-748ded10691sm499372b3a.60.2025.06.17.06.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 06:02:07 -0700 (PDT)
Message-ID: <36ac7f90-d946-439f-ab20-123f542291b6@linaro.org>
Date: Tue, 17 Jun 2025 10:01:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v4 0/8] hw/arm: GIC 'its=off' ACPI table fixes
To: eric.auger@redhat.com, qemu-devel@nongnu.org, philmd@linaro.org,
 mst@redhat.com,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
 <5b0f2250-e521-4172-870c-0384c5ef2382@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <5b0f2250-e521-4172-870c-0384c5ef2382@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Eric,

Thanks a lot for doing a first pass on this series!

On 6/17/25 06:35, Eric Auger wrote:
> Hi Gustavo,
> 
> On 6/16/25 3:18 PM, Gustavo Romero wrote:
>> Since v2:
>> - Fixed no_tcg_its inverted logic (rth)
>>
>> Since v3:
>> - Fixed remappings in the IORT table when ITS is no present
>> - Rebased on master and resoled conflics, like no more "no_its"
>>    flag in VirtMachineClass
>> - Dropped patch 1/9 because we actually want the instance flags,
>>    not only the class flags, and the instance flags are the ones
>>    to be used often when deciding about the presence/absence of a
>>    machine feature, instead of the negated class flags ("no_*")
>> - Adapted the other patches that depended on 1/9
>> - Dropped patch 4/9 in favor of using the instance flag for
>>    checking if ITS is on or off
>> - Simplified VM options for the new "its=off" test
>>
>> v1: https://lists.gnu.org/archive/html/qemu-devel/2025-03/msg07080.html
>> v2: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00495.html (Patches 6/14 -> 14/14 in the series)
>> v3: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00567.html
>>
>> Fix ACPI tables for '-M its=off' CLI option and resolve the issue:
>>
>> https://gitlab.com/qemu-project/qemu/-/issues/2886
> 
> One first comment is that this series will collide with Shameer's SMMU
> multi instance series which has been lunder review for quite some time
> (adding him in TO):
> 
> I think it may be more future proof if you could rebase on it - I know
> it is a pain ;-( -. Or if sbdy objects for Shameer's series please raise
> your voice now.
> 
> [PATCH v4 0/7] hw/arm/virt: Add support for user creatable SMMUv3 device <https://lore.kernel.org/all/20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com/#r>
> 
> https://lore.kernel.org/all/20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com/

ayayay, life is never that easy! :)

Thanks for point that out. Sure, I can rebase it on Shameer's series, but also
I'd like to have this ITS fix for 10.1, so I think it's a matter of understanding
if Shameer's series will make the 10.1 release (thanks for asking the reviewers if they
have any current objection so we have an idea if it's close to get accepted
or not)?

Meanwhile, I'm pretty keen on if I'm correctly generating the IORT table pruned from ITS
(patch 7/8 in this series), like, are the remappings for the RC and SMMU nodes correct? That
would make me more comfortable to start working on a rebase.


> Also I understood Shameer intended to write some new bios-tables-test.

I see.


Cheers,
Gustavo

