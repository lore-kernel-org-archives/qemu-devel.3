Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD92D3C908
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 01:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2KMj-0005nC-TL; Sat, 19 Oct 2024 21:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1t2KMg-0005mc-Si; Sat, 19 Oct 2024 21:04:14 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1t2KMe-0002ay-TD; Sat, 19 Oct 2024 21:04:14 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3FED55C10DF;
 Sun, 20 Oct 2024 01:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569EDC4CEC5;
 Sun, 20 Oct 2024 01:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729386241;
 bh=XnWLhgCmxkJWKI4HbZ0VFaTagtFKA9nagmBkSiwvehw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QNAJ1zfSWijke5oauKxlvi59iYVySEFNaWKOTjWCHDYxpvEF3M0UN9KabF4fTkSQh
 RUcUD2KwiS2uzMoeRrdPK8N5P7jJ84wS+TgDngDqcf8Juxf90H11dkxYwqah6IhDuv
 qSkEzaJT7nI8N+5JuPWo2LOaaX4oO7cZ86RjMmAJnATTLu1O94VhN2Ty52J5dVRiA6
 0FeKX7H431GJ1hYuCsls25ZsQCddy8PBst7NS0nZ0BWDMFNyUiBuKE93NedUgB76tk
 SMQIi2sYkJPMyA0eZisykA4BjWnAY7+k2wneYMEhP9Oq88ruNg+kkbeaNDo7TB3GwJ
 f9wcm3PbZcivg==
Message-ID: <94067926-de2b-41d4-b401-540eb91d887c@kernel.org>
Date: Sun, 20 Oct 2024 10:03:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/file-posix: optimize append write
To: Kevin Wolf <kwolf@redhat.com>, Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org
References: <20241004104123.236457-1-faithilikerun@gmail.com>
 <ZxJynt-0ySt3DG7W@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZxJynt-0ySt3DG7W@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=dlemoal@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 10/18/24 23:37, Kevin Wolf wrote:
> Am 04.10.2024 um 12:41 hat Sam Li geschrieben:
>> When the file-posix driver emulates append write, it holds the lock
>> whenever accessing wp, which limits the IO queue depth to one.
>>
>> The write IO flow can be optimized to allow concurrent writes. The lock
>> is held in two cases:
>> 1. Assumed that the write IO succeeds, update the wp before issuing the
>> write.
>> 2. If the write IO fails, report that zone and use the reported value
>> as the current wp.
> 
> What happens with the concurrent writes that started later and may not
> have completed yet? Can we really just reset to the reported value
> before all other requests have completed, too?

Yes, because if one write fails, we know that the following writes will fail too
as they will not be aligned to the write pointer. These subsequent failed writes
will again trigger the report zones and update, but that is fine. All of them
have failed and the report will give the same wp again.

This is a typical pattern with zoned block device: if one write fails in a zone,
the user has to expect failures for all other writes issued to the same zone, do
a report zone to get the wp and restart writing from there.

-- 
Damien Le Moal
Western Digital Research

