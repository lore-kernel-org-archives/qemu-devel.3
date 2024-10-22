Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA31D1714E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 01:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t348N-0000po-PH; Mon, 21 Oct 2024 21:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1t348I-0000ow-QF; Mon, 21 Oct 2024 21:56:27 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1t348G-0008Cp-V6; Mon, 21 Oct 2024 21:56:26 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D65C6A42017;
 Tue, 22 Oct 2024 01:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986A2C4CEC3;
 Tue, 22 Oct 2024 01:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729562182;
 bh=x6JdZFkmGrGv1UPaxqSaHVKheJJCGK5zgcSe1eqcq5c=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=dtc8d/+7WNp4ueWZ+il/mCrMMtaW4DG0xRa9mrPrCRXofGZetOnGdM/Mei/ow8m7E
 jPwHfgbEbZgpZA/J57ffmwF7kUzfLbxeKNJ5EaZ7x82Q10G1VJEVge81gsgBRPD7fP
 UpDc1Q45AOpLqCQaFh5choX49chYoRkPw4t6iO/vCs92Wbjnfm12l0s5VaibBTyzHh
 iOb7LmW32W/bomb2MvFCzEkz5mF/nacG/TaneU/DDvcAcTwx6NPVNPOLL7KsLx3qPS
 i8t8UPwEQIrwBN7nyaO/0Lmdew70jTVgb1WgHHUhu+74DFJ0ESP5vxwC/rqMrZyQdK
 7zqFffBpr3MEA==
Message-ID: <2980c9de-af94-4dbe-abd6-8036e4b2c95c@kernel.org>
Date: Tue, 22 Oct 2024 10:56:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] block/file-posix: optimize append write
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org
References: <20241004104123.236457-1-faithilikerun@gmail.com>
 <ZxJynt-0ySt3DG7W@redhat.com>
 <94067926-de2b-41d4-b401-540eb91d887c@kernel.org>
 <ZxY2JBaJW1FO9tsl@redhat.com>
 <c9e227e2-8cbe-4504-8271-6934f60be4e3@kernel.org>
 <20241021181342.GA293227@fedora.redhat.com>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241021181342.GA293227@fedora.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=dlemoal@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
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

On 10/22/24 03:13, Stefan Hajnoczi wrote:
> On Mon, Oct 21, 2024 at 09:32:50PM +0900, Damien Le Moal wrote:
>> On 10/21/24 20:08, Kevin Wolf wrote:
>>> Am 20.10.2024 um 03:03 hat Damien Le Moal geschrieben:
>>>> On 10/18/24 23:37, Kevin Wolf wrote:
>>>>> Am 04.10.2024 um 12:41 hat Sam Li geschrieben:
>>>>>> When the file-posix driver emulates append write, it holds the lock
>>>>>> whenever accessing wp, which limits the IO queue depth to one.
>>>>>>
>>>>>> The write IO flow can be optimized to allow concurrent writes. The lock
>>>>>> is held in two cases:
>>>>>> 1. Assumed that the write IO succeeds, update the wp before issuing the
>>>>>> write.
>>>>>> 2. If the write IO fails, report that zone and use the reported value
>>>>>> as the current wp.
>>>>>
>>>>> What happens with the concurrent writes that started later and may not
>>>>> have completed yet? Can we really just reset to the reported value
>>>>> before all other requests have completed, too?
>>>>
>>>> Yes, because if one write fails, we know that the following writes
>>>> will fail too as they will not be aligned to the write pointer. These
>>>> subsequent failed writes will again trigger the report zones and
>>>> update, but that is fine. All of them have failed and the report will
>>>> give the same wp again.
>>>>
>>>> This is a typical pattern with zoned block device: if one write fails
>>>> in a zone, the user has to expect failures for all other writes issued
>>>> to the same zone, do a report zone to get the wp and restart writing
>>>> from there.
>>>
>>> Ok, that makes sense. Can we be sure that requests are handled in the
>>> order they were submitted, though? That is, if the failed request is
>>> resubmitted, could the already pending next one still succeed if it's
>>> overtaken by the resubmitted request? Not sure if this would even cause
>>> a probem, but is it a case we have to consider?
>>
>> A zoned device will always handle writes in the order they were submitted (per
>> zone) and that is true for emulated devices as well as real ones.
> 
> Is there serialization code in the kernel so that zoned devices behind
> multi-path keep requests ordered?

Yes: the kernel only issues at most one write per zone at any time, to preserve
ordering. So there should be no issues at all.

> Normally I don't assume any ordering between concurrent requests to a
> block device, so I'm surprised that it's safe to submit multiple writes.

Correct, the normal case does not provide any guarantees. But writes to zoned
block devices are a special case. More on this here:

https://zonedstorage.io/docs/linux/sched


-- 
Damien Le Moal
Western Digital Research

