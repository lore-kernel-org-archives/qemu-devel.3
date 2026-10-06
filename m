Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B568CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENEY-0007I4-RD; Wed, 07 Oct 2026 04:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEIuJ-0000Tf-3z
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:05:40 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEIu8-0004ny-D7
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:05:23 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 696BuaAS063316
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 6 Oct 2026 20:56:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=OiJJ71YC+01dM4Km4OPD63Prx80aXG0VCxnbCGbfn6U=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791287797; v=1;
 b=tIdRIIraeh73cJGt5SoishlGGZCNSHDZZOew0r6kXLyNAoVWUtchzKw3fzm4pgZ1
 Hspv1ixhi8AooHb5wJmX0FQLpyxqOudRSZiLuXvXfnV8OCzt1CG6ul1pjc+dmDQ1
 PAjfBz2COl+mJAQJhbVtB/ilJm5UXx64Q/N0VEAfHdN9HEFwR2LjEO9QXY7Bfw2i
 NUORlRH3bfSmVosDg5zxTYgvt25Z2boXQ4ONdLf8pu7xl5tRitzlFUJXXHp+Wv+2
 OGPbzFBGHLi7HrFN9R/Iz/34M75ZGzJw7KO6BL0VuBKR/nN+v1BD8f0JjrrX56Dh
 8hRCLnudeNuqF03zlD8RgA==
Message-ID: <1f3bffbc-ca46-4f66-b23d-d40d5033666c@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 6 Oct 2026 20:56:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 16/21] migration: add incoming migration failure
 notifiers
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, mark.kanda@oracle.com,
 bchaney@akamai.com, mst@redhat.com, sgarzare@redhat.com,
 peterx@redhat.com, philmd@oss.qualcomm.com,
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org,
 dwmw2@infradead.org, farosas@suse.de
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
 <20261005-up-vsock-vhost-v5-v12-16-40162390c68a@virtuozzo.com>
 <c9e3523e-a2ca-4187-8274-225f2c667c53@rsg.ci.i.u-tokyo.ac.jp>
 <d4bed047-06c6-4b7b-a886-80dfd3223022@virtuozzo.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <d4bed047-06c6-4b7b-a886-80dfd3223022@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/10/06 19:28, Andrey Drobyshev wrote:
> On 10/6/26 1:03 PM, Akihiko Odaki wrote:
>> On 2026/10/06 0:00, Andrey Drobyshev wrote:
>>> A device may take over a resource from the source in post_load(), e.g.
>>> vhost-vsock acquires the device ownership on a CPR target.  If the
>>> incoming migration fails afterwards, there's currently no way for the
>>> device to give that resource back before the source is told about the
>>> failure over the return path and resumes, or before the target exits.
>>>
>>> Add a notifier list for that, called from the failure path of
>>> process_incoming_migration_co() before migration_incoming_state_destroy().
>>>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>>    include/migration/misc.h |  7 +++++++
>>>    migration/migration.c    | 23 +++++++++++++++++++++++
>>>    2 files changed, 30 insertions(+)
>>>
>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>> index 019717f4cda..08d110750fc 100644
>>> --- a/include/migration/misc.h
>>> +++ b/include/migration/misc.h
>>> @@ -112,6 +112,13 @@ void migration_add_notifier_modes(NotifierWithReturn *notify,
>>>     */
>>>    void migration_remove_notifier(NotifierWithReturn *notify);
>>>    
>>> +/*
>>> + * Incoming side: @notify is called when an incoming migration fails,
>>> + * before the target dies or before the source is told about the failure.
>>> + */
>>> +void migration_incoming_add_failure_notifier(Notifier *notify);
>>> +void migration_incoming_remove_failure_notifier(Notifier *notify);
>>> +
>>>    void migration_file_set_error(int ret, Error *err);
>>>    
>>>    /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index fab7949fe11..55ea1e019fa 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -71,6 +71,8 @@
>>>    #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
>>>    
>>>    static GSList *migration_state_notifiers[MIG_MODE__MAX];
>>> +static NotifierList incoming_failure_notifiers =
>>> +    NOTIFIER_LIST_INITIALIZER(incoming_failure_notifiers);
>>>    
>>>    /* Messages sent on the return path from destination to source */
>>>    enum mig_rp_message_type {
>>> @@ -818,6 +820,17 @@ fail:
>>>        migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>>>                          MIGRATION_STATUS_FAILED);
>>>        migrate_error_propagate(s, local_err);
>>> +
>>> +    /*
>>> +     * Allow the devices which have registered their callbacks for
>>> +     * migration target failure to undo the changes they may have
>>> +     * done in post_load().
>>> +     *
>>> +     * Do that before migration_incoming_state_destroy() reports the
>>> +     * failure over the return path (if present) and before the exit()
>>> +     * below.
>>> +     */
>>> +    notifier_list_notify(&incoming_failure_notifiers, NULL);
>>
>> This invokes the callbacks after migrate_set_state(...FAILED) emits the
>> target’s QMP event. Without return-path enabled, the source can already
>> be POSTMIGRATE, so a management application may react to that event can
>> resume it before ownership is released, causing VHOST_SET_OWNER to fail
>> with EBUSY. The callbacks may be invoked before publishing FAILED.
>>
>> Regards,
>> Akihiko Odaki
> Hmm, looks like you're right again.  Also looks that this gap can be
> easily closed by just moving this notifier_list_notify(...) line right
> before the migrate_set_state(FAILED) above.  Do you think it's going to
> be sufficient?

Yes, I think so.

By the way, I found another scenario that may result in stranded ownership:

1. Start the target with -S.
2. Perform the migration successfully. The target acquires ownership.
(The failure notifier never runs since the migration succeeds).
3. Quit the target normally.
(Note that devices won't be unrealized when QEMU quits).
4. Resume the source.

As I noted previously, there are a number of ways the QEMU process can 
exit (via exit() calls and signals), and I'm not saying this particular 
case needs to be specifically covered. I just wanted to bring it to your 
attention.

Regards,
Akihiko Odaki

