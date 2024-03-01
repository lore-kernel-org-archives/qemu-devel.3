Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF03C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 15:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg4PT-0004zn-Bt; Fri, 01 Mar 2024 10:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg4PJ-0004ye-HR; Fri, 01 Mar 2024 10:02:44 -0500
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg4PF-0005Bh-8W; Fri, 01 Mar 2024 10:02:40 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9328:0:640:5832:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 47D6E60AEF;
 Fri,  1 Mar 2024 18:02:31 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a531::1:29] (unknown
 [2a02:6b8:b081:a531::1:29])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id T2dwkP3i4Ko0-xOQ5S1s3; Fri, 01 Mar 2024 18:02:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709305350;
 bh=LE7Zt29rPlhi+sJypktORpgPrT+nNlEOfiQlZc1BfAE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=dFtLuLsWikuToH6bU9WWjh5VQqTBN4Uq8TPrRQ4hT4yNjZDwqWtAlqZkDSbuZx5qY
 OZI9xAhUKn1ooMWhDgsXdqKXoMJU2DYKzrEMP+E0XYbeoe1jU5wie5/VxOarVSPtOm
 dyrZh6ttlMr1pyN7I2sAdJx7+GexGyqcrJGmHTMY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f7683a44-5dbc-4c36-bd61-c3930a087ef9@yandex-team.ru>
Date: Fri, 1 Mar 2024 18:02:29 +0300
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
 <9f27c816-510f-4482-85c1-f3d1be44b758@yandex-team.ru>
 <9bcdcdb7-162f-431a-8895-8717ffe39413@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <9bcdcdb7-162f-431a-8895-8717ffe39413@proxmox.com>
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

On 01.03.24 17:52, Fiona Ebner wrote:
> Am 01.03.24 um 15:14 schrieb Vladimir Sementsov-Ogievskiy:
>>
>> As we already understood, (block-)job-api needs some spring-cleaning.
>> Unfortunately I don't have much time on it, but still I decided to start
>> from finally depreacting block-job-* API and moving to job-*.. Probably
>> bitmap/bitmap-mode/sync APIs also need some optimization, keeping in
>> mind new block-dirty-bitmap-merge api.
>>
>> So, what I could advice in this situation for newc interfaces:
>>
>> 1. be minimalistic
>> 2. add `x-` prefix when unsure
>>
>> So, following these two rules, what about x-bitmap field, which may be
>> combined only with 'full' mode, and do what you need?
>>
> 
> AFAIU, it should rather be marked as @unstable in QAPI [0]? Then it
> doesn't need to be renamed if it becomes stable later.

Right, unstable feature is needed, using "x-" is optional.

Recent discussion about it was in my "vhost-user-blk: live resize additional APIs" series:

https://patchew.org/QEMU/20231006202045.1161543-1-vsementsov@yandex-team.ru/20231006202045.1161543-5-vsementsov@yandex-team.ru/

Following it, I think it's OK to not care anymore with "x-" prefixes, and rely on unstable feature.

> 
>> About documentation: actually, I never liked that we use for backup job
>> "MirrorSyncMode". Now it looks more like "BackupSyncMode", having two
>> values supported only by backup.
>>
>> I'm also unsure how mode=full&bitmap=some_bitmap differs from
>> mode=bitmap&bitmap=some_bitmap..
>>
> 
> With the current patches, it was an error to specify @bitmap for other
> modes than 'incremental' and 'bitmap'.

Current documentation says:
   # @bitmap: The name of a dirty bitmap to use.  Must be present if sync
   #     is "bitmap" or "incremental". Can be present if sync is "full"
   #     or "top".  Must not be present otherwise.
   #     (Since 2.4 (drive-backup), 3.1 (blockdev-backup))


> 
>> So, I'd suggest simply rename MirrorSyncMode to BackupSyncMode, and add
>> separate MirrorSyncMode with only "full", "top" and "none" values.
>>
> 
> Sounds good to me!
> 
> [0]:
> https://gitlab.com/qemu-project/qemu/-/commit/a3c45b3e62962f99338716b1347cfb0d427cea44
> 
> Best Regards,
> Fiona
> 

-- 
Best regards,
Vladimir


