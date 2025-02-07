Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E94C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 18:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgTHO-0004na-DO; Fri, 07 Feb 2025 13:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgTHM-0004nA-C9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:40:40 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgTHJ-0006eQ-MK
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:40:40 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7FACC1F449;
 Fri,  7 Feb 2025 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738953635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=in9pwDVpjD22lKDZzZgOA+gMpbZJZsM87ha1kMhjLdI=;
 b=HDNCGStUpztS40cSOFECm4hpUZ5PW4KeIc2Z77vX9PNkWdv1pOC3SOJbJWjylWI7Nhs6uQ
 JDAiQgJ2wt0OeWCS/pZfv1b3rjCNc4ItEBrvX5FiAtKqapcb9BAAnZUnflVrq1vcOWO1x6
 1gL/VElIuT4aNeKZZwb45iPBXJNyMLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738953635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=in9pwDVpjD22lKDZzZgOA+gMpbZJZsM87ha1kMhjLdI=;
 b=ksptm3gFRziFh4wZpujdkIvh2TBSxZlbENMSZn/yrFvEYCY5OP58SpNsFS65TSbqRuoh1p
 jJnhr+8ClCy8TmBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738953634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=in9pwDVpjD22lKDZzZgOA+gMpbZJZsM87ha1kMhjLdI=;
 b=chxpv65+4K4NWc6iTCbZLYlI6Lq/GhYPbZRggWJDLb3t3prGuuAzUGIRNg9EgcAukn9vhG
 grnVrH2ZAZ8V7/xjJPCBH6lxYaBVQhdtvcwOGoJnpDrWcRqFlER/yXv7kKS8yC78m6OQpc
 AK4IT4K370NtBGmlSSTguHuLunRUT1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738953634;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=in9pwDVpjD22lKDZzZgOA+gMpbZJZsM87ha1kMhjLdI=;
 b=79dwKcGG5DdK8qPemrlF1rXFrEwewLbYqgAYETVNHIAgOBtVGeMyR/xyFSu95sbZCMYjIi
 +hhtKw8RGVWkPqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8960139CB;
 Fri,  7 Feb 2025 18:40:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nqTQKKFTpmf8BQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 18:40:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [RFC PATCH v2 8/8] migration/multifd: Add a compat property for
 TLS termination
In-Reply-To: <Z6ZLyp32-t9aURgR@x1.local>
References: <20250207142758.6936-1-farosas@suse.de>
 <20250207142758.6936-9-farosas@suse.de> <Z6ZLyp32-t9aURgR@x1.local>
Date: Fri, 07 Feb 2025 15:40:31 -0300
Message-ID: <87y0yhlhsw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Feb 07, 2025 at 11:27:58AM -0300, Fabiano Rosas wrote:
>> We're currently changing the way the source multifd migration handles
>> the shutdown of the multifd channels when TLS is in use to perform a
>> clean termination by calling gnutls_bye().
>> 
>> Older src QEMUs will always close the channel without terminating the
>> TLS session. New dst QEMUs treat an unclean termination as an
>> error. Due to synchronization conditions, src QEMUs 9.1 and 9.2 are an
>> exception and can put the destination in a condition where it ignores
>> the unclean termination. For src QEMUs older than 9.1, we'll need a
>> compat property on the destination to inform that the src does not
>> terminate the TLS session.
>> 
>> Add multifd_clean_tls_termination (default true) that can be switched
>> on the destination whenever a src QEMU <9.1 is in use.
>
> Patch looks good.  Though did you forget to add the compat entry?
>

Indeed.

> I suggest we add it for all pre-9.2, in case whoever backports the recent
> changes so it re-exposes again in any distro stables.
>
> IMHO it doesn't hurt us much to be always cautious on 9.1 and 9.2 too by
> loosing the termination a bit.
>

Ok, I'll put it in hw_compat_9_2.

>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/migration.h | 33 +++++++++++++++++++++++++++++++++
>>  migration/multifd.c   |  8 +++++++-
>>  migration/multifd.h   |  2 ++
>>  migration/options.c   |  2 ++
>>  4 files changed, 44 insertions(+), 1 deletion(-)
>> 
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 4c1fafc2b5..77def0b437 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -443,6 +443,39 @@ struct MigrationState {
>>       * Default value is false. (since 8.1)
>>       */
>>      bool multifd_flush_after_each_section;
>> +
>> +    /*
>> +     * This variable only makes sense when set on the machine that is
>> +     * the destination of a multifd migration with TLS enabled. It
>> +     * affects the behavior of the last send->recv iteration with
>> +     * regards to termination of the TLS session.
>> +     *
>> +     * When set:
>> +     *
>> +     * - the destination QEMU instance can expect to never get a
>> +     *   GNUTLS_E_PREMATURE_TERMINATION error. Manifested as the error
>> +     *   message: "The TLS connection was non-properly terminated".
>> +     *
>> +     * When clear:
>> +     *
>> +     * - the destination QEMU instance can expect to see a
>> +     *   GNUTLS_E_PREMATURE_TERMINATION error in any multifd channel
>> +     *   whenever the last recv() call of that channel happens after
>> +     *   the source QEMU instance has already issued shutdown() on the
>> +     *   channel.
>> +     *
>> +     *   Commit 637280aeb2 (since 9.1) introduced a side effect that
>> +     *   causes the destination instance to not be affected by the
>> +     *   premature termination, while commit 1d457daf86 (since 10.0)
>> +     *   causes the premature termination condition to be once again
>> +     *   reachable.
>> +     *
>> +     * NOTE: Regardless of the state of this option, a premature
>> +     * termination of the TLS connection might happen due to error at
>> +     * any moment prior to the last send->recv iteration.
>> +     */
>> +    bool multifd_clean_tls_termination;
>> +
>>      /*
>>       * This decides the size of guest memory chunk that will be used
>>       * to track dirty bitmap clearing.  The size of memory chunk will
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index b4f82b0893..4342399818 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -1147,6 +1147,7 @@ void multifd_recv_sync_main(void)
>>  
>>  static void *multifd_recv_thread(void *opaque)
>>  {
>> +    MigrationState *s = migrate_get_current();
>>      MultiFDRecvParams *p = opaque;
>>      Error *local_err = NULL;
>>      bool use_packets = multifd_use_packets();
>> @@ -1155,6 +1156,10 @@ static void *multifd_recv_thread(void *opaque)
>>      trace_multifd_recv_thread_start(p->id);
>>      rcu_register_thread();
>>  
>> +    if (!s->multifd_clean_tls_termination) {
>> +        p->read_flags = QIO_CHANNEL_READ_FLAG_RELAXED_EOF;
>> +    }
>> +
>>      while (true) {
>>          uint32_t flags = 0;
>>          bool has_data = false;
>> @@ -1166,7 +1171,8 @@ static void *multifd_recv_thread(void *opaque)
>>              }
>>  
>>              ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
>> -                                           p->packet_len, 0, &local_err);
>> +                                           p->packet_len, p->read_flags,
>> +                                           &local_err);
>>              if (!ret) {
>>                  /* EOF */
>>                  assert(!local_err);
>> diff --git a/migration/multifd.h b/migration/multifd.h
>> index bd785b9873..cf408ff721 100644
>> --- a/migration/multifd.h
>> +++ b/migration/multifd.h
>> @@ -244,6 +244,8 @@ typedef struct {
>>      uint32_t zero_num;
>>      /* used for de-compression methods */
>>      void *compress_data;
>> +    /* Flags for the QIOChannel */
>> +    int read_flags;
>>  } MultiFDRecvParams;
>>  
>>  typedef struct {
>> diff --git a/migration/options.c b/migration/options.c
>> index 1ad950e397..feda354935 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -99,6 +99,8 @@ const Property migration_properties[] = {
>>                        clear_bitmap_shift, CLEAR_BITMAP_SHIFT_DEFAULT),
>>      DEFINE_PROP_BOOL("x-preempt-pre-7-2", MigrationState,
>>                       preempt_pre_7_2, false),
>> +    DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
>> +                     multifd_clean_tls_termination, true),
>>  
>>      /* Migration parameters */
>>      DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
>> -- 
>> 2.35.3
>> 

