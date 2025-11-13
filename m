Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A0DCD5BCE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 11:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJVwW-00039d-Ci; Thu, 13 Nov 2025 06:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vJVwV-00036Z-61
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:56:47 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vJVwT-0007E2-KL
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:56:46 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E1DC41B17;
 Thu, 13 Nov 2025 11:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E9AC4CEF8;
 Thu, 13 Nov 2025 11:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763035002;
 bh=3XhTU374TFMtj+D9jwBjfE+9wE/TCv42zGEI+2Tzxwo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hz2S9MbMHNr+0ecckp144n+KK8qfq6jpCp2Y8VQRW5KomzTezM/W/FMG7Xq7w+61m
 aK3cvUZbR0i34k5P1IZtrwkqk+lODHHufI63Tdoe0bHvP21kpC8psB6ORoLLzajoFT
 IcS2Bv0v3NHv43JFSCtb14RMAXOqswIdlDlO3Vpp0eccyXHlgr087BH2ioeGAt9EZ/
 NaDmBKVFNVBPgiUVqhIXzoFuXzbktHKHMZhUbGS0L1yFi2TUjsq4vQ8zttOfSzDC0U
 04KMqQSvWYhG98dTqBWbUbJTthN7o0ZdUci9+C02VNlyo7T/Yq1Kz1kGzcCzFXI895
 a4kztUGKq+Q3Q==
Message-ID: <66a5228e-1e21-4c59-8538-3475ea3ca768@kernel.org>
Date: Thu, 13 Nov 2025 12:56:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio/vhost: don't consider non-MAP_SHARED regions public
To: Stefano Garzarella <sgarzare@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20251113085842.323745-1-d-tatianin@yandex-team.ru>
 <yhrdm2lo5gvbpdn6emn3iwjxu4oa42aol26hoo3j5vnvycvnbx@uwgeim6b257q>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <yhrdm2lo5gvbpdn6emn3iwjxu4oa42aol26hoo3j5vnvycvnbx@uwgeim6b257q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=david@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 13.11.25 10:40, Stefano Garzarella wrote:
> CCing David

Thanks

> 
> On Thu, Nov 13, 2025 at 11:58:42AM +0300, Daniil Tatianin wrote:
>> Just having a file descriptor is not enough to consider a memory region
>> public. If QEMU didn't map it as MAP_SHARED (in case of share=off), guest
>> writes to this region won't be visible to the vhost-user backend, thus
>> causing it to read all zeroes or garbage. Make sure we don't pass such
>> regions and include that to our definition of what a private region is.
>>
> 
> Should we add a Fixes tag? Not really as bug fix, but more to make it
> clear that this is a followup.
> 
> Fixes: 552b25229c ("vhost: Rework memslot filtering and fix "used_memslot" tracking")

I am missing a description of what this problem is fixing.

The thing is that having real MAP_PRIVATE memory in such VM 
configurations is usually a strong indication that it is a 
VM-misconfiguration.

E.g., a vhost-user device cannot possibly read/write that memory.

So before we call something a fix (that was spelled out as a TODO), I 
want to learn more about the valid sue case we have in mind here.

-- 
Cheers

David

