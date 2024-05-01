Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825ABC19F53
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 07:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s24FK-0003gI-Vy; Wed, 01 May 2024 03:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s24FJ-0003ft-3z
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:19:17 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s24FF-00083o-Ci
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:19:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c10a:0:640:882f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 59BA860913;
 Wed,  1 May 2024 10:19:05 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8829::1:3c] (unknown
 [2a02:6b8:b081:8829::1:3c])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3JMJnL2IcCg0-zpu2fnMm; Wed, 01 May 2024 10:19:04 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714547944;
 bh=7HlKSkGfM0l+IMv2cI33pr5SqA88FgEh+n1LIJvK0+I=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=aXiQEW4qpKtY0MoJ0NUXd9IhVndR0QQtxK53X3iC293f05kV9KBohXzblpSWXtayw
 mNHnbyD7nUosf6xAuE/6ORoI5TkJ47ba/yrAwuMy+5Xrpm0LRddPmi/TNtjUKddRdY
 WBPj0p0ry2u7QhR143Ut2mphqdyJqEi9CNcxF+3I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c1fe136a-92f8-4f57-b2c7-934bab6ac6a8@yandex-team.ru>
Date: Wed, 1 May 2024 10:19:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] migration: process_incoming_migration_co(): rework
 error reporting
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 peterx@redhat.com, farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20240430085646.2359711-1-vsementsov@yandex-team.ru>
 <20240430085646.2359711-5-vsementsov@yandex-team.ru>
 <e318d8dd-64de-4d22-a11f-76e8c2678c88@linaro.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <e318d8dd-64de-4d22-a11f-76e8c2678c88@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 30.04.24 12:16, Philippe Mathieu-Daudé wrote:
> On 30/4/24 10:56, Vladimir Sementsov-Ogievskiy wrote:
>> Unify error reporting in the function. This simplifies the following
>> commit, which will not-exit-on-error behavior variant to the function.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   migration/migration.c | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index b307a4bc59..a9599838e6 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -735,14 +735,16 @@ static void process_incoming_migration_bh(void *opaque)
>>   static void coroutine_fn
>>   process_incoming_migration_co(void *opaque)
>>   {
>> +    MigrationState *s = migrate_get_current();
> 
> (see below)
> 
>>       MigrationIncomingState *mis = migration_incoming_get_current();
>>       PostcopyState ps;
>>       int ret;
>> +    Error *local_err = NULL;
>>       assert(mis->from_src_file);
>>       if (compress_threads_load_setup(mis->from_src_file)) {
>> -        error_report("Failed to setup decompress threads");
>> +        error_setg(&local_err, "Failed to setup decompress threads");
>>           goto fail;
>>       }
>> @@ -779,19 +781,12 @@ process_incoming_migration_co(void *opaque)
>>       }
>>       if (ret < 0) {
>> -        MigrationState *s = migrate_get_current();
>> -
>> -        if (migrate_has_error(s)) {
>> -            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>> -                error_report_err(s->error);
>> -                s->error = NULL;
>> -            }
>> -        }
>> -        error_report("load of migration failed: %s", strerror(-ret));
>> +        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
>>           goto fail;
>>       }
>>       if (colo_incoming_co() < 0) {
>> +        error_setg(&local_err, "colo incoming failed");
>>           goto fail;
>>       }
>> @@ -800,8 +795,16 @@ process_incoming_migration_co(void *opaque)
>>   fail:
> 
> Maybe just assign @s in error path here?
> 
>         s = migrate_get_current();

I'd keep as is. If continue improving the function, I'd better split the logic to seperate function with classic "Error **errp" argument. And keep reporting error in caller.

> 
>>       migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>>                         MIGRATION_STATUS_FAILED);
>> +    migrate_set_error(s, local_err);
>> +    error_free(local_err);
>> +
>>       migration_incoming_state_destroy();
>> +    WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>> +        error_report_err(s->error);
>> +        s->error = NULL;
>> +    }
>> +
>>       exit(EXIT_FAILURE);
>>   }
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

-- 
Best regards,
Vladimir


