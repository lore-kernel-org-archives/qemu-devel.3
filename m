Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ED0C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 15:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg564-0006dZ-FM; Fri, 01 Mar 2024 10:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg561-0006cX-PY; Fri, 01 Mar 2024 10:46:49 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg55y-0005dh-Dq; Fri, 01 Mar 2024 10:46:49 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:486:0:640:cf34:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1549F60A70;
 Fri,  1 Mar 2024 18:46:41 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a531::1:29] (unknown
 [2a02:6b8:b081:a531::1:29])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dkdaIH2OgW20-wGcVSoas; Fri, 01 Mar 2024 18:46:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709308000;
 bh=zLadRMccf4HhFtVxZ7GZJLFqFmeGcewmu0G9arMMujw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=nqvS5OOlW2tINRce0K2qFrYqKSNDO6atflHjzujerfKopkFkUzVuVlEjPHx1aU8mL
 Biwq/jKfBxm3DxOBciOm9VWE+Zwe+PhvESXjYkONQ4RSGWwdzzXG/6kN4wGdFkqalv
 uB53Kg7cQyYw7rRmAkOgnt533x6uCgm0iJwIZukg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <351ce054-66f5-4af9-afc7-66803aa43b2e@yandex-team.ru>
Date: Fri, 1 Mar 2024 18:46:39 +0300
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
 <f7683a44-5dbc-4c36-bd61-c3930a087ef9@yandex-team.ru>
 <7e626ca6-6363-4caa-ad78-292e0bbbee98@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <7e626ca6-6363-4caa-ad78-292e0bbbee98@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 01.03.24 18:14, Fiona Ebner wrote:
> Am 01.03.24 um 16:02 schrieb Vladimir Sementsov-Ogievskiy:
>> On 01.03.24 17:52, Fiona Ebner wrote:
>>> Am 01.03.24 um 15:14 schrieb Vladimir Sementsov-Ogievskiy:
>>>>
>>>> As we already understood, (block-)job-api needs some spring-cleaning.
>>>> Unfortunately I don't have much time on it, but still I decided to start
>>>> from finally depreacting block-job-* API and moving to job-*.. Probably
>>>> bitmap/bitmap-mode/sync APIs also need some optimization, keeping in
>>>> mind new block-dirty-bitmap-merge api.
>>>>
>>>> So, what I could advice in this situation for newc interfaces:
>>>>
>>>> 1. be minimalistic
>>>> 2. add `x-` prefix when unsure
>>>>
>>>> So, following these two rules, what about x-bitmap field, which may be
>>>> combined only with 'full' mode, and do what you need?
>>>>
>>>
>>> AFAIU, it should rather be marked as @unstable in QAPI [0]? Then it
>>> doesn't need to be renamed if it becomes stable later.
>>
>> Right, unstable feature is needed, using "x-" is optional.
>>
>> Recent discussion about it was in my "vhost-user-blk: live resize
>> additional APIs" series:
>>
>> https://patchew.org/QEMU/20231006202045.1161543-1-vsementsov@yandex-team.ru/20231006202045.1161543-5-vsementsov@yandex-team.ru/
>>
>> Following it, I think it's OK to not care anymore with "x-" prefixes,
>> and rely on unstable feature.
>>
> 
> Thanks for the confirmation! I'll go without the prefix in the name then.
> 
>>>
>>>> About documentation: actually, I never liked that we use for backup job
>>>> "MirrorSyncMode". Now it looks more like "BackupSyncMode", having two
>>>> values supported only by backup.
>>>>
>>>> I'm also unsure how mode=full&bitmap=some_bitmap differs from
>>>> mode=bitmap&bitmap=some_bitmap..
>>>>
>>>
>>> With the current patches, it was an error to specify @bitmap for other
>>> modes than 'incremental' and 'bitmap'.
>>
>> Current documentation says:
>>    # @bitmap: The name of a dirty bitmap to use.  Must be present if sync
>>    #     is "bitmap" or "incremental". Can be present if sync is "full"
>>    #     or "top".  Must not be present otherwise.
>>    #     (Since 2.4 (drive-backup), 3.1 (blockdev-backup))
>>
>>
> 
> This is for backup. The documentation (and behavior) for @bitmap added
> by these patches for mirror is different ;)

I meant backup in "I'm also unsure", just as one more point not consider backup-bitmap-API as a prototype for mirror-bitmap-API.

> 
> Best Regards,
> Fiona
> 

-- 
Best regards,
Vladimir


