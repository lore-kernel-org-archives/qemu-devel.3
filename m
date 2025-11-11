Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0941CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 13:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIoaP-0000Az-Po; Tue, 11 Nov 2025 08:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>)
 id 1vIoZ5-00085m-Oi; Tue, 11 Nov 2025 08:37:47 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>)
 id 1vIoZ3-0004sq-CL; Tue, 11 Nov 2025 08:37:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2A1B160208;
 Tue, 11 Nov 2025 13:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7CFC113D0;
 Tue, 11 Nov 2025 13:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762868257;
 bh=SfJYK5TUYrczh7qCeBxGMjdc5jrvj/R9HTpvBSLhnOM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=P64ubrgTc1MQ5zrDyXwmU7+LFNxgbOiBp9JbbxRAL37ShL+RyPeVuVZ7mxUUVTAnO
 Y+LdhGT7sKe3dik/dICUVT2yvY0j0Pg10EsJa+eSENOzprNZOcmK4RzHygQ3gRnMAi
 SvtV3ZZvjlRlZwAHMdVwS8Bb4EI55DLej0hRVHBlkGpPaKfhq6RT5/O7G/QiyT8bOW
 aSj/ah/sJ5DPQxRTx1zsuBc0a28FYyFbVmYmX2l4oPuepk5Y06qtCT7ODAQLEncCB/
 kxMjhK/GXqzc8E9yN45nvDrbdzp8czO5q/DQu9xHToGT2tZYoIVxNb3e+ouCG7TtjE
 T+AVxHIv5FrSg==
Message-ID: <a80fc77e-e565-42ce-9d31-3e09d694c7f2@kernel.org>
Date: Tue, 11 Nov 2025 14:37:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Clear RAM on diag308 subcode 3 reset
To: Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Miehlbradt <nicholas@linux.ibm.com>, richard.henderson@linaro.org,
 iii@linux.ibm.com, pasic@linux.ibm.com, farman@linux.ibm.com,
 qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250429052021.10789-1-nicholas@linux.ibm.com>
 <2347cd4a-dc40-410a-89f0-9c7b261cff29@linux.ibm.com>
 <d5990a22-76dc-4c20-ba38-6179899a3f42@redhat.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <d5990a22-76dc-4c20-ba38-6179899a3f42@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=david@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

>>>        /*
>>>         * Temporarily drop the record/replay mutex to let rr_cpu_thread_fn()
>>> @@ -479,6 +480,7 @@ static void s390_machine_reset(MachineState *machine,
>>> ResetType type)
>>>        switch (reset_type) {
>>>        case S390_RESET_EXTERNAL:
>>>        case S390_RESET_REIPL:
>>> +    case S390_RESET_REIPL_CLEAR:
>>>            /*
>>>             * Reset the subsystem which includes a AP reset. If a PV
>>>             * guest had APQNs attached the AP reset is a prerequisite to
>>> @@ -489,6 +491,10 @@ static void s390_machine_reset(MachineState *machine,
>>> ResetType type)
>>>                s390_machine_unprotect(ms);
>>>            }
>>> +        if (reset_type == S390_RESET_REIPL_CLEAR) {
>>> +            ram_block_discard_range(rb, 0 , qemu_ram_get_used_length(rb));
>>> +        }
>>> +

...

>>
>>
>>
>> Do I see that right that this patch never made it into qemu master? IIRC
>> Matt has clarified all concerns?
> 
> I was hoping to see a reply from David that he's fine with the patch now...
> David?

Staring at this again, one more point regarding userfaultfd: doing the 
discard on the destination while postcopy is active might be problematic.

I don't remember all details, but I think that if we have the following:

1) Migrate page X to dst
2) Discard page X on dst
3) Access page X on dst

that postcopy_request_page()->migrate_send_rp_req_pages() would assume 
that the page was already transferred (marked received in the receive 
bitmap during 1) ) and essentially never place a fresh zeropage during 
3) to be stuck forever.

-- 
Cheers

David

