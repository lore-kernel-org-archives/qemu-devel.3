Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066B6C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMRy-0005Jr-NV; Wed, 28 Feb 2024 11:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfMRo-0005Ge-3z; Wed, 28 Feb 2024 11:06:20 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfMRk-00007R-Ft; Wed, 28 Feb 2024 11:06:18 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:621c:0:640:f00b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 87F5060A9A;
 Wed, 28 Feb 2024 19:06:11 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a519::1:3a] (unknown
 [2a02:6b8:b081:a519::1:3a])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 96ckOV1IkKo0-jnsmkfye; Wed, 28 Feb 2024 19:06:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709136370;
 bh=LlDRoX6rHJd2lv4jTsVzCN6kUvnCZH6z/8QgdnK0dUU=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=zAYltYffiwU7kL18iWxaUJB0wPo6bYRsuF5Aw/bWzgqR8cmNbK0r55twv2Y5Xmoha
 /E8QpS7JzAoB0Lqrg+qhEkbPbQRBjS86qMyBtCVF35FqP4HZzVJdIq09hNxl7ICPF4
 H/qjLzqgdcAim64Bn+LwXMo5WEuqD260+AjlMHf0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8a84f7f2-6765-49f6-9469-908bcfdc7437@yandex-team.ru>
Date: Wed, 28 Feb 2024 19:06:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] mirror: implement incremental and bitmap modes
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com
References: <20240216105513.309901-1-f.ebner@proxmox.com>
 <cf086f76-1f47-4f45-aba5-fc021ad090da@yandex-team.ru>
In-Reply-To: <cf086f76-1f47-4f45-aba5-fc021ad090da@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28.02.24 19:00, Vladimir Sementsov-Ogievskiy wrote:
> On 16.02.24 13:55, Fiona Ebner wrote:
>> Previous discussion from when this was sent upstream [0] (it's been a
>> while). I rebased the patches and re-ordered and squashed like
>> suggested back then [1].
>>
>> This implements two new mirror modes:
>>
>> - bitmap mirror mode with always/on-success/never bitmap sync mode
>> - incremental mirror mode as sugar for bitmap + on-success
>>
>> Use cases:
>> * Possibility to resume a failed mirror later.
>> * Possibility to only mirror deltas to a previously mirrored volume.
>> * Possibility to (efficiently) mirror an drive that was previously
>>    mirrored via some external mechanism (e.g. ZFS replication).
>>
>> We are using the last one in production without any issues since about
>> 4 years now. In particular, like mentioned in [2]:
>>
>>> - create bitmap(s)
>>> - (incrementally) replicate storage volume(s) out of band (using ZFS)
>>> - incrementally drive mirror as part of a live migration of VM
>>> - drop bitmap(s)
>>
>>
>> Now, the IO test added in patch 4/4 actually contains yet another use
>> case, namely doing incremental mirrors to stand-alone qcow2 "diff"
>> images, that only contain the delta and can be rebased later. I had to
>> adapt the IO test, because its output expected the mirror bitmap to
>> still be dirty, but nowadays the mirror is apparently already done
>> when the bitmaps are queried. So I thought, I'll just use
>> 'write-blocking' mode to avoid any potential timing issues.
>>
>> But this exposed an issue with the diff image approach. If a write is
>> not aligned to the granularity of the mirror target, then rebasing the
>> diff image onto a backing image will not yield the desired result,
>> because the full cluster is considered to be allocated and will "hide"
>> some part of the base/backing image. The failure can be seen by either
>> using 'write-blocking' mode in the IO test or setting the (bitmap)
>> granularity to 32 KiB rather than the current 64 KiB.
>>
>> The question is how to deal with these edge cases? Some possibilities
>> that would make sense to me:
>>
>> For 'background' mode:
>> * prohibit if target's cluster size is larger than the bitmap
>>    granularity
>> * document the limitation
>>
>> For 'write-blocking' mode:
>> * disallow in combination with bitmap mode (would not be happy about
>>    it, because I'd like to use this without diff images)
> 
> why not just require the same: bitmap granularity must be >= target granularity
> 
>> * for writes that are not aligned to the target's cluster size, read
>>    the relevant/missing parts from the source image to be able to write
>>    whole target clusters (seems rather complex)
> 
> There is another approach: consider and unaligned part of the request, fit in one cluster (we can always split any request to "aligned" middle part, and at most two small "unligned" parts, each fit into one cluster).
> 
> We have two possibilities:
> 
> 1. the cluster is dirty (marked dirty in the bitmap used by background process)
> 
> We can simply ignore this part and rely on background process. This will not affect the convergence of the mirror job.
> 
> 2. the cluster is clear (i.e. background process, or some previous write already copied it)
> 
> In this case, we are safe to do unaligned write, as target cluster must be allocated.
> 
> (for bitmap-mode, I don't consider here clusters that are clear from the start, which we shouldn't copy in any case)
> 

Hmm, right, and that's exactly the logic we already have in do_sync_target_write(). So that's enough just to require that bitmap_granularity >= target_granularity

-- 
Best regards,
Vladimir


