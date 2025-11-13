Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51933CD8C94
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 15:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJZE4-0000nL-Qr; Thu, 13 Nov 2025 10:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vJZE3-0000hu-6d
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:27:07 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vJZE1-0000iA-Jh
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:27:06 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9036260103;
 Thu, 13 Nov 2025 15:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F377C4CEF1;
 Thu, 13 Nov 2025 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763047623;
 bh=bquN21/2fRF23ZCGdVkD2K+TITyC6frQKGpHWyz/5Gs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qiZcRkAd0IBa8RTQZ4sDfv6oHQEvQexzXtp7JKl+FfgyioWqRFGItRnavRsI8b64I
 zxmmn1jwE5KG4qJM5KfPRoowGzHaSYbbwvSF8XAm7dyMtfcEZpwHs0F4p0+msrYl84
 lUIKh7tlXySv4GvLQKetjfQ5HcewvDYkhK3HYgbF6mmSe63fVxDlT2YxWgb6lALtVJ
 Zqd1ox7W/VhBNUEid6askcy8iGjjGZ4pylorUlh1PzksPYCHFA9KLyDdhud7KX5gXt
 BH8pxGXYnOcmezrz1ZaiH8xtEvnjrN2XszmylrRXClod5+gJUzbXhXKZE4Iw3Nj+l1
 1uTCFnj+wU60w==
Message-ID: <290cc3c5-15d8-40ad-855f-0f9c7c7d405f@kernel.org>
Date: Thu, 13 Nov 2025 16:27:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio/vhost: don't consider non-MAP_SHARED regions public
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20251113085842.323745-1-d-tatianin@yandex-team.ru>
 <yhrdm2lo5gvbpdn6emn3iwjxu4oa42aol26hoo3j5vnvycvnbx@uwgeim6b257q>
 <66a5228e-1e21-4c59-8538-3475ea3ca768@kernel.org>
 <6wyzsqwlnw2tkkhgfcm62tlen2g56noqaxbau3cn734jsasngo@d5pqtkftefvm>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <6wyzsqwlnw2tkkhgfcm62tlen2g56noqaxbau3cn734jsasngo@d5pqtkftefvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 13.11.25 13:38, Stefano Garzarella wrote:
> On Thu, Nov 13, 2025 at 12:56:39PM +0100, David Hildenbrand (Red Hat) wrote:
>> On 13.11.25 10:40, Stefano Garzarella wrote:
>>> CCing David
>>
>> Thanks
>>
>>>
>>> On Thu, Nov 13, 2025 at 11:58:42AM +0300, Daniil Tatianin wrote:
>>>> Just having a file descriptor is not enough to consider a memory region
>>>> public. If QEMU didn't map it as MAP_SHARED (in case of share=off), guest
>>>> writes to this region won't be visible to the vhost-user backend, thus
>>>> causing it to read all zeroes or garbage. Make sure we don't pass such
>>>> regions and include that to our definition of what a private region is.
>>>>
>>>
>>> Should we add a Fixes tag? Not really as bug fix, but more to make it
>>> clear that this is a followup.
>>>
>>> Fixes: 552b25229c ("vhost: Rework memslot filtering and fix "used_memslot" tracking")
>>
>> I am missing a description of what this problem is fixing.
>>
>> The thing is that having real MAP_PRIVATE memory in such VM
>> configurations is usually a strong indication that it is a
>> VM-misconfiguration.
>>
>> E.g., a vhost-user device cannot possibly read/write that memory.
>>
>> So before we call something a fix (that was spelled out as a TODO), I
>> want to learn more about the valid sue case we have in mind here.
> 
> I specified in my comment: "Not really as bug fix, but more to make it
> clear that this is a followup.", so I agree it is not a fix. But, IMO
> it's nice to link a follow-up patch to the previous patch that
> introduced the TODO. That said, yeah, maybe the Fixes tag is not the
> right one, but at least I think we should mention that commit.

Right, the thing is that we already did before the code something wrong
if you take a look at the old vhost_user_mem_section_filter().

Passing MAP_PRIVATE memory to a vhost-user device and having it work on 
the shared memory cannot possibly work correctly.

So IIUC, commit 552b25229cf didn't change the behavior, it only 
highlighted the existing problem.

So I agree, resolving this TODO is great -- back then I wasn't quite 
sure if there are other things we have to consider so I left it alone.

-- 
Cheers

David

