Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B2ECAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3FpJ-0003oj-LV; Mon, 29 Sep 2025 11:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v3FpB-0003mx-Ab; Mon, 29 Sep 2025 11:30:01 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v3Fp5-0001dF-DK; Mon, 29 Sep 2025 11:30:00 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAXG5fmpdpoVk8AAA--.1S2;
 Mon, 29 Sep 2025 23:29:42 +0800 (CST)
Received: from [192.168.31.222] (unknown [113.246.232.83])
 by mail (Coremail) with SMTP id AQAAfwD3WujmpdpoGGkvAA--.28840S2;
 Mon, 29 Sep 2025 23:29:42 +0800 (CST)
Message-ID: <a66ec5e4-d4ca-4c68-9459-3253c01096c4@phytium.com.cn>
Date: Mon, 29 Sep 2025 23:29:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] hw/arm/smmuv3: Add secure TLB entry management
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250925162618.191242-10-tangtao1634@phytium.com.cn>
 <78cf7d16-2e15-4610-9150-065ee816e586@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <78cf7d16-2e15-4610-9150-065ee816e586@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwD3WujmpdpoGGkvAA--.28840S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAIBWjZjscNDwAEsy
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zry5Xw4DCw1kCw47ZrW3trb_yoW8AFy3pr
 WrWw4qyrZ7KFyIvw1xWw48W3W09ws5J3yUJws5Kwn8Z3W5tr1FqFyS93909FZxWFs3Z3W2
 qa12qa93J34jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2025/9/29 22:57, Eric Auger wrote:
> Hi Tao,
>
> On 9/25/25 6:26 PM, Tao Tang wrote:
>> To prevent aliasing between secure and non-secure translations for the
>> same address space, the IOTLB lookup key must incorporate the security
>> state of the transaction. A secure parameter has been added to
>> smmu_get_iotlb_key, ensuring that secure and non-secure TLB entries are
>> treated as distinct entities within the cache.
> In the same spirit as my previous comments I would encourage to split
> this into 2 patches:
> 1) add the sec_sid in the key. This should cause no regression with the
> NS current code base.
> 2) introduce a separate patch for the new smmuv3_invalidate_all_caches
> and A_S_INIT_ALIAS support.
> Those can be easily separated and you can refocus the associated commit
> messages.
>
> I also see you adapted some range invalidations for STAGE2 with sec_idx.
> Since secure path is not implemented for S2 yet you may abort if this is
> attempted at some point
>
> Thanks
>
> Eric


Hi Eric,

Thank you for the review and for the excellent suggestion on how to 
split this patch.

Following the same spirit as your previous reviews, this makes perfect 
sense. Separating the IOTLB key modification from the new S_INIT 
functionality will indeed make the changes much cleaner and easier to 
verify. I will restructure this for the v3 series into the two patches 
you proposed.

You also made a very important point about the unimplemented Secure 
Stage 2 path. Silently letting it fall through is a risk. Furthermore, I 
will take this opportunity to proactively audit the code and check if 
there are any other areas where the yet-to-be-implemented Secure Stage 2 
logic might be incorrectly invoked, and I will add similar assertions 
there as well.

Thanks,
Tao


