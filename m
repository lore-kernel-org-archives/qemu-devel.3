Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B18CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEc5-0005DK-Q0; Thu, 01 Oct 2026 07:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xCEbl-0005BE-Ux
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:05:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xCEbh-0004hG-4S
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790852740; bh=mv9nVaZL/XcJQGB+PLdb9m3rmNyVm0E+71o0SrI2qAE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ZLDHs0lnjXHM92bx0JV/Kg7/cdziqhSJR2xqxdddFcp3GgoWCcIM1G5R6aanlMHMe
 8UaM2DVSoH601J/PFiJ+yStZz4arjE+FRH6t81IFfdoOcifp4LHFoA/EgVg3aDEnL6
 24V8zK//sQgM2P0kEH2wAix8pzm4/0umV2QvA9CjknbdWre65sIID+DXzm1dj5lqcL
 3MixcM3NK/uJziH3wy/G41zvX0vvAReTk1q6A2N038oxoBDMpmy0Zyrl2QpTv8TV+Z
 fuEANJw1/9/3HZJLOUbq5NXIsilwj4NlMjnIXPJEiulVgIIxMX/NxD/6t0n99MHvB5
 BLlbn1surKMEA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F3BD11DA243;
 Thu, 01 Oct 2026 14:05:40 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 631F4438200;
 Thu, 01 Oct 2026 14:05:40 +0300 (MSK)
Message-ID: <f4a13c82-927b-465c-8ae9-9e7bb0f2e7b1@tls.msk.ru>
Date: Thu, 1 Oct 2026 14:05:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu"
 is configured
To: Sandipan Das <sandipan.das@amd.com>,
 Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 babu.moger@amd.com, likexu@tencent.com, like.xu.linux@gmail.com,
 groug@kaod.org, khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
References: <20251230074354.88958-1-dongli.zhang@oracle.com>
 <20251230074354.88958-2-dongli.zhang@oracle.com>
 <81a1f791-37ef-4d26-bcf7-024eab4cd810@tls.msk.ru>
 <fa8b40df-a35c-4ae3-8eaa-b4b65c546a91@amd.com>
 <18ff5158-a515-4659-8388-5bcc074afb94@tls.msk.ru>
 <6ee6f858-37f6-4acb-8253-acd3cec584ad@amd.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <6ee6f858-37f6-4acb-8253-acd3cec584ad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 10/1/26 13:43, Sandipan Das wrote:
> On 01-10-2026 15:30, Michael Tokarev wrote:
>> On 10/1/26 11:54, Sandipan Das wrote:
>>> On 01-10-2026 14:02, Michael Tokarev wrote:
>> ...
>>
>>>> When booting windows11 VM with -cpu EPYC-Rome-v4 -enable-kvm, the
>>>> guest enters tight CPU loop while displaying a boot screen, before
>>>> it starts showing up the rotating circle (which shows boot progress).
>>
>>
>>> What happens if you use "-cpu EPYC-Rome-v4,+pmu"?
>>
>> With that, it boots fine, just like before this patch.
>> I checked current master too - same, +pmu fixes it.
>>
> A guest OS cannot expect a functioning PMU if the hypervisor has disabled
> it. Linux runs a basic sanity test to determine this. See:
> https://github.com/torvalds/linux/blob/master/arch/x86/events/core.c#L268

So.. what do we do with all this?  :)

I kinda see the intention of the original change, but it results in
non-bootable systems (linux too, as I think you demonstrate above).

hmm.. :)

Thanks,

/mjt

