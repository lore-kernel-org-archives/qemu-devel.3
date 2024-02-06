Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0852C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 14:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXMTT-0006CF-AE; Tue, 06 Feb 2024 09:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rXMTR-0006At-B4
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:30:57 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rXMTP-0004p2-IO
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:30:57 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F09752218F;
 Tue,  6 Feb 2024 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707229850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SVKlvtF+eVu3IdTk8egnG3BRVFvVOl9Hzaygy9sFlw=;
 b=GnNFNctH7Nyk0tjuXVteJjAil3Fk8XoDLBsLwX9tQSMcgLpOWisCLSJvYyoKRQ11qG8mUp
 WhyLVHnfkxlGPWAqh+p17fndMXo1SIBrcaZaV0fUf5Vw+K0k4R0g8rs6QrCxJ3kKMObH2G
 CtRNBmOSl7wU7A0FOVLgK52PJjECkao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707229850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SVKlvtF+eVu3IdTk8egnG3BRVFvVOl9Hzaygy9sFlw=;
 b=ckqzWLaxzF1JvExxrvyd0u9vORNPY8tsbTWfC4j/6c+MIgw4mJlVfJ83V8SbLJyQbwqZme
 4NFFRkA3xcRtByCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707229847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SVKlvtF+eVu3IdTk8egnG3BRVFvVOl9Hzaygy9sFlw=;
 b=fb6zC3pZ8XAk0dGp3PKiUH/7ndLO6xt5KhF6a5N3yczPS4e4wgHWYmujirGHcUbYai09Pz
 ceGs6rC+4S8cwbRO0vEv13FMtPDLGAmaxk8yOn6u3pJ2C7UBkbPiJVLBGftcaLEgXmtf43
 +Keb0wL3oVmhcVJsQWz4kKF3wodBrWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707229847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SVKlvtF+eVu3IdTk8egnG3BRVFvVOl9Hzaygy9sFlw=;
 b=V2V0JJzdgn8Qt0CaiCmoK+0Nfqx01wYFtVsCE7336w7UTYfiTlB/j48NyroZKagv9HSgwc
 p/V4vYRNFPIu8tDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D317139D8;
 Tue,  6 Feb 2024 14:30:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mbJ0EZdCwmXjUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 06 Feb 2024 14:30:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2 5/6] migration/multifd: Unify multifd and TLS
 connection paths
In-Reply-To: <e4f9337d-ed7d-4a11-84dd-76661009c3fc@nvidia.com>
References: <20240205194929.28963-1-farosas@suse.de>
 <20240205194929.28963-6-farosas@suse.de>
 <e4f9337d-ed7d-4a11-84dd-76661009c3fc@nvidia.com>
Date: Tue, 06 Feb 2024 11:30:44 -0300
Message-ID: <87fry57jhn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fb6zC3pZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V2V0JJzd
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,nvidia.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: F09752218F
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Avihai Horon <avihaih@nvidia.com> writes:

> On 05/02/2024 21:49, Fabiano Rosas wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> During multifd channel creation (multifd_send_new_channel_async) when
>> TLS is enabled, the multifd_channel_connect function is called twice,
>> once to create the TLS handshake thread and another time after the
>> asynchrounous TLS handshake has finished.
>>
>> This creates a slightly confusing call stack where
>> multifd_channel_connect() is called more times than the number of
>> channels. It also splits error handling between the two callers of
>> multifd_channel_connect() causing some code duplication. Lastly, it
>> gets in the way of having a single point to determine whether all
>> channel creation tasks have been initiated.
>>
>> Refactor the code to move the reentrancy one level up at the
>> multifd_new_send_channel_async() level, de-duplicating the error
>> handling and allowing for the next patch to introduce a
>> synchronization point common to all the multifd channel creation,
>> regardless of TLS.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   migration/multifd.c | 73 +++++++++++++++++++--------------------------
>>   1 file changed, 30 insertions(+), 43 deletions(-)
>>
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index cc10be2c3f..89d39fa67c 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -869,30 +869,7 @@ out:
>>       return NULL;
>>   }
>>
>> -static bool multifd_channel_connect(MultiFDSendParams *p,
>> -                                    QIOChannel *ioc,
>> -                                    Error **errp);
>> -
>> -static void multifd_tls_outgoing_handshake(QIOTask *task,
>> -                                           gpointer opaque)
>> -{
>> -    MultiFDSendParams *p = opaque;
>> -    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
>> -    Error *err = NULL;
>> -
>> -    if (!qio_task_propagate_error(task, &err)) {
>> -        trace_multifd_tls_outgoing_handshake_complete(ioc);
>> -        if (multifd_channel_connect(p, ioc, &err)) {
>> -            return;
>> -        }
>> -    }
>> -
>> -    trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
>> -
>> -    multifd_send_set_error(err);
>> -    multifd_send_kick_main(p);
>> -    error_free(err);
>> -}
>> +static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque);
>>
>>   static void *multifd_tls_handshake_thread(void *opaque)
>>   {
>> @@ -900,7 +877,7 @@ static void *multifd_tls_handshake_thread(void *opaque)
>>       QIOChannelTLS *tioc = QIO_CHANNEL_TLS(p->c);
>>
>>       qio_channel_tls_handshake(tioc,
>> -                              multifd_tls_outgoing_handshake,
>> +                              multifd_new_send_channel_async,
>>                                 p,
>>                                 NULL,
>>                                 NULL);
>> @@ -936,19 +913,6 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>>                                       QIOChannel *ioc,
>>                                       Error **errp)
>>   {
>> -    trace_multifd_set_outgoing_channel(
>> -        ioc, object_get_typename(OBJECT(ioc)),
>> -        migrate_get_current()->hostname);
>> -
>> -    if (migrate_channel_requires_tls_upgrade(ioc)) {
>> -        /*
>> -         * tls_channel_connect will call back to this
>> -         * function after the TLS handshake,
>> -         * so we mustn't call multifd_send_thread until then
>> -         */
>> -        return multifd_tls_channel_connect(p, ioc, errp);
>> -    }
>> -
>>       migration_ioc_register_yank(ioc);
>>       p->registered_yank = true;
>>       p->c = ioc;
>> @@ -959,20 +923,43 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>>       return true;
>>   }
>>
>> +/*
>> + * When TLS is enabled this function is called once to establish the
>> + * TLS connection and a second time after the TLS handshake to create
>> + * the multifd channel. Without TLS it goes straight into the channel
>> + * creation.
>> + */
>>   static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>>   {
>>       MultiFDSendParams *p = opaque;
>>       QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
>>       Error *local_err = NULL;
>>
>> +    bool ret;
>> +
>>       trace_multifd_new_send_channel_async(p->id);
>> -    if (!qio_task_propagate_error(task, &local_err)) {
>> -        qio_channel_set_delay(ioc, false);
>> -        if (multifd_channel_connect(p, ioc, &local_err)) {
>> -            return;
>> -        }
>> +
>> +    if (qio_task_propagate_error(task, &local_err)) {
>> +        ret = false;
>> +        goto out;
>> +    }
>
> I think this common error handling for both TLS/non-TLS is a bit 
> problematic if there is an error in TLS handshake:
> multifd_tls_channel_connect() sets p->c = QIO_CHANNEL(tioc).
> TLS handshake fails.
> multifd_new_send_channel_async() errors and calls 
> object_unref(OBJECT(ioc)) which will result in freeing the IOC.
> Then, multifd_send_terminate_threads() will try to access p->ioc because 
> it's not NULL, causing a segfault.

Good catch.

I'm not sure the current reference counting is even correct. AFAICS, the
refcount is 2 at new_send_channel_async due to the qio_task taking a
reference and that will be decremented after we return from the
completion callback, which is multifd_new_send_channel_async itself. The
last reference should be dropped when we cleanup the channel.

So I don't really understand the need for that unref there. But there's
no asserts being reached due to an extra decrement, so there might be
some extra increment hiding somewhere.

Anyway, I'll figure this out and update this patch. Thanks

>> +
>> +    qio_channel_set_delay(ioc, false);
>
> Maybe qio_channel_set_delay() should be moved inside 
> multifd_channel_connect()? It's called two times when TLS is used.
>

It looks like it could, I'll do that.

>> +
>> +    trace_multifd_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)),
>> +                                       migrate_get_current()->hostname);
>> +
>> +    if (migrate_channel_requires_tls_upgrade(ioc)) {
>> +        ret = multifd_tls_channel_connect(p, ioc, &local_err);
>> +    } else {
>> +        ret = multifd_channel_connect(p, ioc, &local_err);
>> +    }
>> +
>> +    if (ret) {
>> +        return;
>>       }
>>
>> +out:
>>       trace_multifd_new_send_channel_async_error(p->id, local_err);
>>       multifd_send_set_error(local_err);
>>       multifd_send_kick_main(p);
>> --
>> 2.35.3
>>

