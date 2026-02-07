Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F193EE6B74
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 03:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voYxU-0006tG-OU; Fri, 06 Feb 2026 22:26:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1voYxR-0006t6-Lq
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 22:26:06 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1voYxN-0002MB-N4
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 22:26:05 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6173OSag070414
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 7 Feb 2026 12:25:50 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=2bQsrotEBoNfXQyvrIgUEGLWfkG1di1K0/4cbtNegaw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1770434751; v=1;
 b=vUj6NJd/uR3gWoW+i0RNWWBK4GtMFqZ4j9B5BNq837RVmsImqk9hTMq/FIA36fR4
 U4m2PJ8zkJoX75RtG/lKwGN+9UE9gY6x2KbpSURPPsxqGDgBQFBPMlWRx5h/rbZx
 9aL/zAWqIecoqsNwrbqUFQv3YcN43c1nORxIX9wWoykB/bIqfBPGfgQSIfCUddrX
 CXAtoBwfJE442s5opxBm+hd3kZ516K2K98iGwfwBP4MayuSj00BHcZtSOQtt+nzh
 ynL25cZdlVxj//b2PPWMyy3Ex1QRPi/YRgvIuFGi/qjCNFxW3OxvkgGaJ+9pRJOV
 i705nPtnDcxZN+Skok90TQ==
Message-ID: <9cb0ad2d-07c3-4acc-8b67-83c8c34821c1@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 7 Feb 2026 12:24:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci/shpc: Do not unparent in instance_finalize()
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20251027-shpc-v1-1-00e9b20a355d@rsg.ci.i.u-tokyo.ac.jp>
 <d0135462-3b9f-47c7-bbbe-b5bbbc2cc08e@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <d0135462-3b9f-47c7-bbbe-b5bbbc2cc08e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/02/06 6:25, Michael Tokarev wrote:
> On 10/27/25 04:24, Akihiko Odaki wrote:
>> Children are automatically unparented so manually unparenting is
>> unnecessary.
>>
>> Worse, automatic unparenting happens before the instance_finalize()
>> callback of the parent gets called, so object_unparent() calls in
>> the callback will refer to objects that are already unparented, which
>> is semantically incorrect.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> Is this a qemu-stable material?

I don't think so. It's semantically incorrect but I don't see a 
possibility that it causes a real problem. Cherry-picking it shouldn't 
cause a harm though. Having this patch or not shouldn't make any 
behavioral change.

Regards,
Akihiko Odaki

> 
> Please let me know if it is -- I'm *not* queuing it up for now.
> 
> Thanks,
> 
> /mjt
> 
>> ---
>> See also:
>> https://lore.kernel.org/qemu-devel/20250924-use- 
>> v4-0-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp
>> ---
>>   hw/pci/shpc.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
>> index aac6f2d03459..938602866d77 100644
>> --- a/hw/pci/shpc.c
>> +++ b/hw/pci/shpc.c
>> @@ -735,7 +735,6 @@ void shpc_free(PCIDevice *d)
>>       if (!shpc) {
>>           return;
>>       }
>> -    object_unparent(OBJECT(&shpc->mmio));
>>       g_free(shpc->config);
>>       g_free(shpc->cmask);
>>       g_free(shpc->wmask);
>>
>> ---
>> base-commit: c85ba2d7a4056595166689890285105579db446a
>> change-id: 20251027-shpc-d71bb72d67af
>>
>> Best regards,
>> -- 
>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>
>>
>>
> 


