Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF66CC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww1rt-0007Kc-Cj; Mon, 17 Aug 2026 14:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ww1rs-0007KS-DS
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:15:28 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ww1rp-0008Ly-U3
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:15:28 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 8A84B8089F;
 Mon, 17 Aug 2026 21:15:20 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d2f::1:33] (unknown
 [2a02:6bf:8080:d2f::1:33])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id HFZfKs7afOs0-Ta7s1msw; Mon, 17 Aug 2026 21:15:18 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1786990518;
 bh=6J+mlZY0RQhwna6Dvsu3eT1F6/N5oBXwKnwddKueUMY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=j7WOAqbeT9h6Op+/BxuBXcdriNYZmQ4wEqGPLY6ez3XX4771N/OGwWLmeHvSQZTu6
 y836vxD8/B1ttaJGCZCGzZ6u17W2NDFdIJckx1B0wxYhqCl9kLOMuyl6lEmuDYLLv/
 AlheAqxlcjqVakHko7MAKLnrMf/9zLN5lQ1r7OSc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b9957dda-c0ee-4081-8938-ecc5a50aae3c@yandex-team.ru>
Date: Mon, 17 Aug 2026 21:15:17 +0300
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
Received-SPF: pass client-ip=178.154.239.136;
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


Hm. Actually, migration_capabilities_and_transport_compatible() only sees
the parsed MigrationAddress, before any QIOChannel is created. At that
point we can't call qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS),
because there is no ioc yet..

So, at least, we can't check, is passed from user fd is a UNIX socket
for SOCKET_ADDRESS_TYPE_FD case.


-- 
Best regards,
Vladimir

