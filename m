Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE317C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 12:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rff5n-0002Zv-KC; Thu, 29 Feb 2024 07:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rff5f-0002RK-AM; Thu, 29 Feb 2024 07:00:45 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rff5b-00085V-Cr; Thu, 29 Feb 2024 07:00:43 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 7BEE960CA8;
 Thu, 29 Feb 2024 15:00:31 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a531::1:29] (unknown
 [2a02:6b8:b081:a531::1:29])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id T0ZkvE3Ika60-RDICCzOA; Thu, 29 Feb 2024 15:00:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709208030;
 bh=upX9uioWztrRDfjwhtpeqb2Hj5KkpA1P//kngVLjmPo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=aa7zasROFjbzaZ1i1jNKWgE0GxJHPZa/Wi5QtXzocT4RCfZIE4739pk9zalp4Ybn0
 L5Qf/EaS706yRT8Z8X6UxbvVubY8dMtjnSPBP0efSC96b/cMcxBHm18Q0oIc7bu0ZT
 OQ4nCrSfxaA4IQPftGd7P/2r2GNuSFtwLqt9OgiU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3fbf2b67-3213-4416-86e4-f6e4deb0a97b@yandex-team.ru>
Date: Thu, 29 Feb 2024 15:00:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] mirror: implement incremental and bitmap modes
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com
References: <20240216105513.309901-1-f.ebner@proxmox.com>
 <217803cb-fced-4dce-87f3-9892b2f97dce@yandex-team.ru>
 <195fe8a5-02c2-4cc4-bc41-095f6477b676@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <195fe8a5-02c2-4cc4-bc41-095f6477b676@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29.02.24 13:41, Fiona Ebner wrote:
> Am 28.02.24 um 17:24 schrieb Vladimir Sementsov-Ogievskiy:
>> On 16.02.24 13:55, Fiona Ebner wrote:
>>> Previous discussion from when this was sent upstream [0] (it's been a
>>> while). I rebased the patches and re-ordered and squashed like
>>> suggested back then [1].
>>>
>>> This implements two new mirror modes:
>>>
>>> - bitmap mirror mode with always/on-success/never bitmap sync mode
>>> - incremental mirror mode as sugar for bitmap + on-success
>>>
>>> Use cases:
>>> * Possibility to resume a failed mirror later.
>>> * Possibility to only mirror deltas to a previously mirrored volume.
>>> * Possibility to (efficiently) mirror an drive that was previously
>>>     mirrored via some external mechanism (e.g. ZFS replication).
>>>
>>> We are using the last one in production without any issues since about
>>> 4 years now. In particular, like mentioned in [2]:
>>>
>>>> - create bitmap(s)
>>>> - (incrementally) replicate storage volume(s) out of band (using ZFS)
>>>> - incrementally drive mirror as part of a live migration of VM
>>>> - drop bitmap(s)
>>
>> Actually which mode you use, "never", "always" or "conditional"? Or in
>> downstream you have different approach?
>>
> 
> We are using "conditional", but I think we don't really require any
> specific mode, because we drop the bitmaps after mirroring (even in
> failure case). Fabian, please correct me if I'm wrong.
> 
>> Why am I asking:
>>
>> These modes (for backup) were developed prior to
>> block-dirty-bitmap-merge command, which allowed to copy bitmaps as you
>> want. With that API, we actually don't need all these modes, instead
>> it's enough to pass a bitmap, which would be _actually_ used by mirror.
>>
>> So, if you need "never" mode, you just copy your bitmap by
>> block-dirty-bitmap-add + block-dirty-bitmap-merge, and pass a copy to
>> mirror job.
>>
>> Or, you pass your bitmap to mirror-job, and have a "always" mode.
>>
>> And I don't see, why we need a "conditional" mode, which actually just
>> drops away the progress we actually made. (OK, we failed, but why to
>> drop the progress of successfully copied clusters?)
>>
> 
> I'm not sure actually. Maybe John remembers?

Ah, I understand. Conditional just make sense if you don't support "partial success", and you want to delete target image in case of failure. And create a new one, to restart incremental job.

But anyway, this all could be simply achieved with bitmap-copying/merging API, if we allow to pass user-given bitmap to the mirror as working bitmap.

> 
> I see, I'll drop the 'bitmap-mode' in the next version if nobody
> complains :)
> 

Good. It's a golden rule: never make public interfaces which you don't actually need for production. I myself sometimes violate it and spend extra time on developing features, which we later have to just drop as "not needed downstream, no sense in upstreaming".

>>
>> Using user-given bitmap in the mirror job has also an additional
>> advantage of live progress: up to visualization of disk copying by
>> visualization of the dirty bitmap contents.
>>
> 
> Best Regards,
> Fiona
> 

-- 
Best regards,
Vladimir


