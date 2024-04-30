Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED4EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hfS-0000JY-Tq; Tue, 30 Apr 2024 03:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1hfB-0000If-AI
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:12:30 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1hf1-00088I-N9
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:12:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c10a:0:640:882f:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 32D0760BBD;
 Tue, 30 Apr 2024 10:12:13 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8829::1:3c] (unknown
 [2a02:6b8:b081:8829::1:3c])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BCL91t1Ig4Y0-2vgDUCj1; Tue, 30 Apr 2024 10:12:12 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714461132;
 bh=2CxjzaLC2mkFFLI/VUKEuHKIQy56+jUCYi7/VYSgJ4s=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wEqCGTmU1ubpoQtf7KgHiJcVSYHSH6UuXIqf3LT9S+I8K2VT03WYseAyHHutnvAMo
 u8FSxpYhyFj5FnO2aUXZhfaF/DwlBsZ/I/rxBLd78WdJqpwMTtfT1W9O8YNQrND2CC
 iyTD6a9viDrpT/DVxSi3qSc9pIUfpllEqv2ixf5g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <219e42b7-8c1b-4a75-9235-f5f0f39fc185@yandex-team.ru>
Date: Tue, 30 Apr 2024 10:12:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] migration: process_incoming_migration_co(): rework
 error reporting
To: Peter Xu <peterx@redhat.com>
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20240429191426.2327225-1-vsementsov@yandex-team.ru>
 <20240429191426.2327225-5-vsementsov@yandex-team.ru> <Zi_3iEr3imN4C80_@x1n>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <Zi_3iEr3imN4C80_@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 29.04.24 22:39, Peter Xu wrote:
> On Mon, Apr 29, 2024 at 10:14:25PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Unify error reporting in the function. This simplifies the following
>> commit, which will not-exit-on-error behavior variant to the function.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   migration/migration.c | 17 ++++++++++-------
>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 58fd5819bc..5489ff96df 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -748,11 +748,12 @@ process_incoming_migration_co(void *opaque)
>>       MigrationIncomingState *mis = migration_incoming_get_current();
>>       PostcopyState ps;
>>       int ret;
>> +    Error *local_err = NULL;
>>   
>>       assert(mis->from_src_file);
>>   
>>       if (compress_threads_load_setup(mis->from_src_file)) {
>> -        error_report("Failed to setup decompress threads");
>> +        error_setg(&local_err, "Failed to setup decompress threads");
>>           goto fail;
>>       }
>>   
>> @@ -789,16 +790,12 @@ process_incoming_migration_co(void *opaque)
>>       }
>>   
>>       if (ret < 0) {
>> -        if (migrate_has_error(s)) {
>> -            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>> -                error_report_err(error_copy(s->error));
>> -            }
>> -        }
>> -        error_report("load of migration failed: %s", strerror(-ret));
>> +        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
>>           goto fail;
>>       }
>>   
>>       if (colo_incoming_co() < 0) {
>> +        error_setg(&local_err, "colo incoming failed");
>>           goto fail;
>>       }
>>   
>> @@ -809,6 +806,12 @@ fail:
>>                         MIGRATION_STATUS_FAILED);
>>       migration_incoming_state_destroy();
>>   
>> +    if (migrate_has_error(s)) {
>> +        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>> +            error_report_err(error_copy(s->error));
>> +        }
>> +    }
>> +    error_report_err(local_err);
> 
> Here migrate_has_error() will always return true?  If so we can drop it.
> 
> Meanwhile, IMHO it's easier we simply always keep the earliest error we see
> and report that only, local_err is just one of the errors and whoever
> reaches first will be reported.  Something like:
> 
>    migrate_set_error(local_err);
>    WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>        error_report_err(error_copy(s->error));
>    }
>    exit(EXIT_FAILURE);
> 
> Then when with the exit-on-error thing:
> 
>    migrate_set_error(local_err);
>    if (exit_on_error) {
>      WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>        error_report_err(error_copy(s->error));
>      }
>      exit(EXIT_FAILURE);
>    }
> 
> Would this looks slightly cleaner?
> 

Yes, looks better, will do so

-- 
Best regards,
Vladimir


