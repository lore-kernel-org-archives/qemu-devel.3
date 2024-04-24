Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB46FC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 19:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzidX-0006CR-SI; Wed, 24 Apr 2024 15:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rzidR-0006C9-Es
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 15:50:31 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rzidM-0003le-GT
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 15:50:28 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:220a:0:640:7faf:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2147060B23;
 Wed, 24 Apr 2024 22:50:16 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8811::1:29] (unknown
 [2a02:6b8:b081:8811::1:29])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EoR3RF2GcW20-Y0IPEppb; Wed, 24 Apr 2024 22:50:15 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1713988215;
 bh=JW5o+0Tuz+C1SM+TUi+3/kX0Wi83UScvpa1oJLcF3k8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EYQh7akL41biDPXB2qFQr1uM4a27lY20L+G+y3z5zcJw6uUV8OY5wP1AhdCZIGEWg
 z0jAPKFH/zUlNlYRE7NiyM+mhBjJktUsED8eUHKbh/U/HKMZnVTVH0Ka76+QFu9ssr
 ndKDfGAZwFezmXm0YTm3MNzLs1cTVGltTDPu50gI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0230a7ce-af4f-4767-984d-ac069b0a9d19@yandex-team.ru>
Date: Wed, 24 Apr 2024 22:50:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] migration: rework migrate_set_error() to
 migrate_report_err()
To: Peter Xu <peterx@redhat.com>
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20240424174245.1237942-1-vsementsov@yandex-team.ru>
 <20240424174245.1237942-2-vsementsov@yandex-team.ru> <ZilgISOGWfODZvMC@x1n>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ZilgISOGWfODZvMC@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 24.04.24 22:40, Peter Xu wrote:
> On Wed, Apr 24, 2024 at 08:42:44PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> 1. Most of callers want to free the error after call. Let's help them.
>>
>> 2. Some callers log the error, some not. We also have places where we
>>     log the stored error. Let's instead simply log every migration
>>     error.
>>
>> 3. Some callers have to retrieve current migration state only to pass
>>     it to migrate_set_error(). In the new helper let's get the state
>>     automatically.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   migration/migration.c    | 48 ++++++++++++----------------------------
>>   migration/migration.h    |  2 +-
>>   migration/multifd.c      | 18 ++++++---------
>>   migration/postcopy-ram.c |  3 +--
>>   migration/savevm.c       | 16 +++++---------
>>   5 files changed, 28 insertions(+), 59 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 696762bc64..806b7b080b 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -285,7 +285,7 @@ void migration_bh_schedule(QEMUBHFunc *cb, void *opaque)
>>   void migration_cancel(const Error *error)
>>   {
>>       if (error) {
>> -        migrate_set_error(current_migration, error);
>> +        migrate_report_err(error_copy(error));
>>       }
>>       if (migrate_dirty_limit()) {
>>           qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
>> @@ -779,13 +779,6 @@ process_incoming_migration_co(void *opaque)
>>       }
>>   
>>       if (ret < 0) {
>> -        MigrationState *s = migrate_get_current();
>> -
>> -        if (migrate_has_error(s)) {
>> -            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>> -                error_report_err(s->error);
>> -            }
>> -        }
>>           error_report("load of migration failed: %s", strerror(-ret));
>>           goto fail;
>>       }
>> @@ -1402,10 +1395,6 @@ static void migrate_fd_cleanup(MigrationState *s)
>>                             MIGRATION_STATUS_CANCELLED);
>>       }
>>   
>> -    if (s->error) {
>> -        /* It is used on info migrate.  We can't free it */
>> -        error_report_err(error_copy(s->error));
>> -    }
>>       type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
>>                                        MIG_EVENT_PRECOPY_DONE;
>>       migration_call_notifiers(s, type, NULL);
>> @@ -1418,12 +1407,14 @@ static void migrate_fd_cleanup_bh(void *opaque)
>>       migrate_fd_cleanup(opaque);
>>   }
>>   
>> -void migrate_set_error(MigrationState *s, const Error *error)
>> +void migrate_report_err(Error *error)
>>   {
>> +    MigrationState *s = migrate_get_current();
> 
> Avoid passing in *s looks ok.
> 
>>       QEMU_LOCK_GUARD(&s->error_mutex);
>>       if (!s->error) {
>>           s->error = error_copy(error);
> 
> I think I get your point, but then looks like this error_copy() should be
> removed but forgotten?
> 
> I remember I had an attempt to do similarly (but only transfer the
> ownership):
> 
> https://lore.kernel.org/qemu-devel/20230829214235.69309-3-peterx@redhat.com/
> 
> However I gave up later and I forgot why.  One reason could be that I hit a
> use-after-free, then found that well indeed leaking an Error is much better
> than debugging a UAF.

Hmm, yes I saw a leaked Error somewhere, and this patch should fix it. But may be I missed introducing this use-after-free again)

> 
> So maybe we simply keep it like before?  If you like such change, let's
> just be extremely caucious.
> 
>>       }
>> +    error_report_err(error);
> 
> The ideal case to me is we don't trigger an error_report() all over the
> place.  We're slightly going backward from that regard, IMHO..
> 
> Ideally I think we shouldn't dump anything to stderr, but user should
> always query from qmp.
> 

Sounds reasonable to me. I'm just unsure, if keep it like before, how should I correctly update logging to stderr in process_incoming_migration_co(). Could we just drop error reporting to stderr? Or should it be kept as is for the case when exit_on_error is true?

-- 
Best regards,
Vladimir


