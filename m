Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF67C53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 17:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp8TD-0007pB-DE; Wed, 29 Jul 2026 13:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp8TB-0007og-4D
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 13:53:29 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp8T8-0007VR-KD
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 13:53:28 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 9ED2C80774;
 Wed, 29 Jul 2026 20:53:20 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:484::1:24] (unknown
 [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id JriBRXJXwSw0-I0UHsDQB; Wed, 29 Jul 2026 20:53:20 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785347600;
 bh=APAUFTy7QKnRX0XpJ5HdG1xLoPlj/0G+fW3XtojcCoU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=FaY6xa31u9EtotHaRZ29xIsde11ZlZpHPbY6TvpFCyeaaR+Tyl4dgLbXzGh6++t8A
 NEMohfM/KLBNyAgczeqLAeKva3L0zb8OmGiMvEHdYsQ7jUEFRIMc2RueP6EeTljKOY
 ra8Jd1WH5Q5y1vu+Gw3P1pSxfAhFahgIsRin7pGs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fe8912a6-6650-4c81-8c28-56aa040863c2@yandex-team.ru>
Date: Wed, 29 Jul 2026 20:53:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 10/15] migration/channel: check that transfer is UNIX
 socket when "local" set
To: Peter Xu <peterx@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com
References: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
 <20260729091334.1863155-11-vsementsov@yandex-team.ru>
 <amoJoAyhymPgvyTR@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <amoJoAyhymPgvyTR@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 29.07.26 17:09, Peter Xu wrote:
> On Wed, Jul 29, 2026 at 12:12:48PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> As documented, for "local", the migration channel must be direct
>> UNIX socket connection from source to target. We can't check for
>> it being "direct", but let's at least check that we deal with
>> UNIX socket (fd-passing supported).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   migration/channel.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/migration/channel.c b/migration/channel.c
>> index 1e2935f926b..537673c29e9 100644
>> --- a/migration/channel.c
>> +++ b/migration/channel.c
>> @@ -214,6 +214,13 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>>       trace_migration_set_incoming_channel(
>>           ioc, object_get_typename(OBJECT(ioc)));
>>   
>> +    if (migrate_local() && migrate_mode() != MIG_MODE_CPR_EXEC &&
>> +        !qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
>> +        error_setg(&local_err,
>> +                   "local migration requires a UNIX domain socket channel");
>> +        goto out;
>> +    }
>> +
>>       if (migrate_channel_requires_tls_upgrade(ioc)) {
>>           migration_tls_channel_process_incoming(ioc, &local_err);
>>       } else {
>> @@ -241,6 +248,16 @@ void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
>>   {
>>       trace_migration_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
>>   
>> +    if (migrate_local() && migrate_mode() != MIG_MODE_CPR_EXEC &&
>> +        !qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
>> +        Error *local_err = NULL;
>> +
>> +        error_setg(&local_err,
>> +                   "local migration requires a UNIX domain socket channel");
>> +        migration_connect_error_propagate(s, local_err);
>> +        return;
>> +    }
>> +
> 
> We only need to touch migration_capabilities_and_transport_compatible()?
> It should work for both, and fail QMP commands directly might also be
> slightly better.

Hm. Don't remember why I didn't go this way. Will try.

> 
>>       if (migrate_channel_requires_tls_upgrade(ioc)) {
>>           Error *local_err = NULL;
>>   
>> -- 
>> 2.43.0
>>
> 


-- 
Best regards,
Vladimir

