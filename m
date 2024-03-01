Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAFCC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 14:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg3f7-0000Yx-JQ; Fri, 01 Mar 2024 09:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg3f5-0000YN-W7; Fri, 01 Mar 2024 09:14:56 -0500
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg3f2-00041u-9O; Fri, 01 Mar 2024 09:14:55 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9328:0:640:5832:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 741FC60D96;
 Fri,  1 Mar 2024 17:14:43 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a531::1:29] (unknown
 [2a02:6b8:b081:a531::1:29])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id fEcc1P3i80U0-78yF2eDU; Fri, 01 Mar 2024 17:14:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709302482;
 bh=udmNoJ4xv4qkXef9b5S4Yl+s3zzhpVjnq/3gq/uPFqE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=hqpDZ6QDh0GJ17l/brv/+I+acfYrJG0tqQ7JhMn664v13xXFCWBh3Li/DvC7WerWg
 ZbW1ERPPuJAihS334RRVyNeDGxhmEnsvQ0ybhTIMj4ITZ+5V13R7oA+TZ28vDe32it
 2TX+MotUybVt0r78uqceciLiSDFFxvOLjzJXRdzQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9f27c816-510f-4482-85c1-f3d1be44b758@yandex-team.ru>
Date: Fri, 1 Mar 2024 17:14:41 +0300
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
 <3fbf2b67-3213-4416-86e4-f6e4deb0a97b@yandex-team.ru>
 <b3d0ee7a-e633-4719-bc52-2796b18acb32@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <b3d0ee7a-e633-4719-bc52-2796b18acb32@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 29.02.24 17:50, Fiona Ebner wrote:
> Am 29.02.24 um 13:00 schrieb Vladimir Sementsov-Ogievskiy:
>>
>> But anyway, this all could be simply achieved with
>> bitmap-copying/merging API, if we allow to pass user-given bitmap to the
>> mirror as working bitmap.
>>
>>>
>>> I see, I'll drop the 'bitmap-mode' in the next version if nobody
>>> complains :)
>>>
>>
>> Good. It's a golden rule: never make public interfaces which you don't
>> actually need for production. I myself sometimes violate it and spend
>> extra time on developing features, which we later have to just drop as
>> "not needed downstream, no sense in upstreaming".
>>
> 
> Just wondering which new mode I should allow for the @MirrorSyncMode
> then? The documentation states:
> 
>> # @incremental: only copy data described by the dirty bitmap.
>> #     (since: 2.4)
>> #
>> # @bitmap: only copy data described by the dirty bitmap.  (since: 4.2)
>> #     Behavior on completion is determined by the BitmapSyncMode.
> 
> For backup, do_backup_common() just maps @incremental to @bitmap +
> @bitmap-mode == @on-success.
> 
> Using @bitmap for mirror would lead to being at odds with the
> documentation, because it mentions the BitmapSyncMode, which mirror
> won't have.
> 
> Using @incremental for mirror would be consistent with the
> documentation, but behave a bit differently from backup.
> 
> Opinions?
> 

Good question.

As we already understood, (block-)job-api needs some spring-cleaning. Unfortunately I don't have much time on it, but still I decided to start from finally depreacting block-job-* API and moving to job-*.. Probably bitmap/bitmap-mode/sync APIs also need some optimization, keeping in mind new block-dirty-bitmap-merge api.

So, what I could advice in this situation for newc interfaces:

1. be minimalistic
2. add `x-` prefix when unsure

So, following these two rules, what about x-bitmap field, which may be combined only with 'full' mode, and do what you need?

About documentation: actually, I never liked that we use for backup job "MirrorSyncMode". Now it looks more like "BackupSyncMode", having two values supported only by backup.

I'm also unsure how mode=full&bitmap=some_bitmap differs from mode=bitmap&bitmap=some_bitmap..

So, I'd suggest simply rename MirrorSyncMode to BackupSyncMode, and add separate MirrorSyncMode with only "full", "top" and "none" values.

-- 
Best regards,
Vladimir


