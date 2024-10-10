Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C68CF07B3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 06:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1symye-0007RR-Hi; Thu, 10 Oct 2024 02:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1symya-0007QZ-Ud; Thu, 10 Oct 2024 02:48:45 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1symyX-0003RK-BT; Thu, 10 Oct 2024 02:48:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:248d:0:640:e1bc:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id C42E560B97;
 Thu, 10 Oct 2024 09:48:32 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6417::1:1f] (unknown
 [2a02:6b8:b081:6417::1:1f])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id UmcHhK0IbiE0-Omc8zvRS; Thu, 10 Oct 2024 09:48:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1728542911;
 bh=rRIsvBzrejYiXoKlKAQVr6gRbwZiW3RbUJG2b1uFA54=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=kS0YEj5/+ZkLxhzL167m8j7u11MzWh4p8QzEYmu1kUR6b6B4qacSUostYkwTx7P2u
 bI2wiAY8W1W8j1+K/wLdkWRv5YdbvTFyFeydKHV3v8fKLy3p872wIOsodpI6rfbV/Y
 t/v87SKYcPCio8+RASNKKbbBzy+mb50a53S8bJI4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <17d7959e-d643-4fd2-9e57-81de2728fa3e@yandex-team.ru>
Date: Thu, 10 Oct 2024 09:48:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report][RFC PATCH 1/1] block: fix failing assert on paused
 VM migration
To: Fabiano Rosas <farosas@suse.de>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eesposit@redhat.com, den@virtuozzo.com, Peter Xu <peterx@redhat.com>
References: <20240924125611.664315-1-andrey.drobyshev@virtuozzo.com>
 <20240924125611.664315-2-andrey.drobyshev@virtuozzo.com>
 <6fb3340a-f685-422f-acaf-ad968e854847@yandex-team.ru>
 <0faf2b77-0cda-4823-8c3f-986be7d6964c@virtuozzo.com>
 <29cd78e2-be26-41a4-92c4-a327efe76177@yandex-team.ru>
 <87set5roao.fsf@suse.de>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87set5roao.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 09.10.24 23:53, Fabiano Rosas wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 30.09.24 17:07, Andrey Drobyshev wrote:
>>> On 9/30/24 12:25 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>> [add migration maintainers]
>>>>
>>>> On 24.09.24 15:56, Andrey Drobyshev wrote:
>>>>> [...]
>>>>
>>>> I doubt that this a correct way to go.
>>>>
>>>> As far as I understand, "inactive" actually means that "storage is not
>>>> belong to qemu, but to someone else (another qemu process for example),
>>>> and may be changed transparently". In turn this means that Qemu should
>>>> do nothing with inactive disks. So the problem is that nobody called
>>>> bdrv_activate_all on target, and we shouldn't ignore that.
>>>>
>>>> Hmm, I see in process_incoming_migration_bh() we do call
>>>> bdrv_activate_all(), but only in some scenarios. May be, the condition
>>>> should be less strict here.
>>>>
>>>> Why we need any condition here at all? Don't we want to activate
>>>> block-layer on target after migration anyway?
>>>>
>>>
>>> Hmm I'm not sure about the unconditional activation, since we at least
>>> have to honor LATE_BLOCK_ACTIVATE cap if it's set (and probably delay it
>>> in such a case).  In current libvirt upstream I see such code:
>>>
>>>> /* Migration capabilities which should always be enabled as long as they
>>>>    * are supported by QEMU. If the capability is supposed to be enabled on both
>>>>    * sides of migration, it won't be enabled unless both sides support it.
>>>>    */
>>>> static const qemuMigrationParamsAlwaysOnItem qemuMigrationParamsAlwaysOn[] = {
>>>>       {QEMU_MIGRATION_CAP_PAUSE_BEFORE_SWITCHOVER,
>>>>        QEMU_MIGRATION_SOURCE},
>>>>                                                                                   
>>>>       {QEMU_MIGRATION_CAP_LATE_BLOCK_ACTIVATE,
>>>>        QEMU_MIGRATION_DESTINATION},
>>>> };
>>>
>>> which means that libvirt always wants LATE_BLOCK_ACTIVATE to be set.
>>>
>>> The code from process_incoming_migration_bh() you're referring to:
>>>
>>>>       /* If capability late_block_activate is set:
>>>>        * Only fire up the block code now if we're going to restart the
>>>>        * VM, else 'cont' will do it.
>>>>        * This causes file locking to happen; so we don't want it to happen
>>>>        * unless we really are starting the VM.
>>>>        */
>>>>       if (!migrate_late_block_activate() ||
>>>>            (autostart && (!global_state_received() ||
>>>>               runstate_is_live(global_state_get_runstate())))) {
>>>>           /* Make sure all file formats throw away their mutable metadata.
>>>>            * If we get an error here, just don't restart the VM yet. */
>>>>           bdrv_activate_all(&local_err);
>>>>           if (local_err) {
>>>>               error_report_err(local_err);
>>>>               local_err = NULL;
>>>>               autostart = false;
>>>>           }
>>>>       }
>>>
>>> It states explicitly that we're either going to start VM right at this
>>> point if (autostart == true), or we wait till "cont" command happens.
>>> None of this is going to happen if we start another migration while
>>> still being in PAUSED state.  So I think it seems reasonable to take
>>> such case into account.  For instance, this patch does prevent the crash:
>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index ae2be31557..3222f6745b 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -733,7 +733,8 @@ static void process_incoming_migration_bh(void *opaque)
>>>>         */
>>>>        if (!migrate_late_block_activate() ||
>>>>             (autostart && (!global_state_received() ||
>>>> -            runstate_is_live(global_state_get_runstate())))) {
>>>> +            runstate_is_live(global_state_get_runstate()))) ||
>>>> +         (!autostart && global_state_get_runstate() == RUN_STATE_PAUSED)) {
>>>>            /* Make sure all file formats throw away their mutable metadata.
>>>>             * If we get an error here, just don't restart the VM yet. */
>>>>            bdrv_activate_all(&local_err);
>>>
>>> What are your thoughts on it?
>>>
> 
> This bug is the same as https://gitlab.com/qemu-project/qemu/-/issues/2395
> 
>>
>> Hmmm... Don't we violate "late-block-activate" contract by this?
>>
>> Me go and check:
>>
>> # @late-block-activate: If enabled, the destination will not activate
>> #     block devices (and thus take locks) immediately at the end of
>> #     migration.  (since 3.0)
>>
>> Yes, we'll violate it by this patch. So, for now the only exception is
>> when autostart is enabled, but libvirt correctly use
>> late-block-activate + !autostart.
>>
>> Interesting, when block layer is assumed to be activated.. Aha, only in qmp_cont().
>>
>>
>> So, what to do with this all:
>>
>> Either libvirt should not use late-block-activate for migration of
>> stopped vm. This way target would be automatically activated
>>
>> Or if libvirt still need postponed activation (I assume, for correctly
>> switching shared disks, etc), Libvirt should do some additional QMP
>> call. It can't be "cont", if we don't want to run the VM. So,
>> probably, we need additional "block-activate" QMP command for this.
> 
> A third option might be to unconditionally activate in qmp_migrate:

Yes. But is migration the only operation with vm which requires block layer be activated? I think actually a lot of operation require that.. Any block-layer releated qmp command actually. And do automatic activation in all of them I think is a wrong way.

Moreover, if we have explicit possibility to "postpone activation", we should provide a way to "activate by hand".

So I still think correct fix is reporting error from qmp_migrate when block-layer is inactive, and add some possibility to activate through QMP.

> 
> -- >8 --
>  From 1890c7989e951a2702735f933d1567e48fa464a5 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Wed, 9 Oct 2024 17:51:57 -0300
> Subject: [PATCH] tmp
> 
> ---
>   migration/migration.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 021faee2f3..6bf1f039d1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2068,6 +2068,16 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>           return false;
>       }
>   
> +    /*
> +     * The VM might have been target of a previous migration. If it
> +     * was in the paused state then nothing will have required the
> +     * block layer to be activated. Do it now to ensure this QEMU
> +     * instance owns the disk locks.
> +     */
> +    if (!resume && runstate_check(RUN_STATE_PAUSED)) {
> +        bdrv_activate_all(errp);
> +    }
> +
>       return true;
>   }
>   

-- 
Best regards,
Vladimir


