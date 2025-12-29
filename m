Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54012E9271B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaItS-0006EK-HS; Mon, 29 Dec 2025 14:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vaItP-0006E3-Kj
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:26:59 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vaItN-0005uI-So
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:26:59 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4C9D3336BA;
 Mon, 29 Dec 2025 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767036415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ckehpuBB+5kN5+Vrp9lAj4hTb2uGW+ovExeI0jXMo8o=;
 b=yhejH3bfexVEfcrlPVhm4F2I0No1sf+3HuZAmkNaVL7DpbPaFliw683XSqplqUpkXK2KpL
 YIKqLYeGLjFHlgXqytRTtitDi9O/2lGEolfGXWr7bftWGG5bTwwhSo/tGmw1lw5+jNj/Dd
 bpOX+M1ujjqfEGAW4jvJhtgvumPxwEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767036415;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ckehpuBB+5kN5+Vrp9lAj4hTb2uGW+ovExeI0jXMo8o=;
 b=2dEtZ46lOEgeWIPYRWrVy1cQq20CHK/gVIQ0lhosKYcO0P2epjW6Rr5XFSGfcoSVxcCvOD
 IuYv6k+WeLZ9fPDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wUGjr5JK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=maVTMm05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767036414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ckehpuBB+5kN5+Vrp9lAj4hTb2uGW+ovExeI0jXMo8o=;
 b=wUGjr5JKCjbBXngi5/RKtVRa1yKbvM/4PA8RNeW/ITjF9zOoE9NliiiZiK5O+CY/6MmUIJ
 Z3pwJozOWopO6iiuOptGe4TNJfsSRDaAWOiWxXgpM6bLipb3gN5A07z914Z9g80rWzWbJv
 xeqpSKoCN5rJBR8g9SHiFcfLSChRqY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767036414;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ckehpuBB+5kN5+Vrp9lAj4hTb2uGW+ovExeI0jXMo8o=;
 b=maVTMm057icGSg6TPbo2cj/ChB+yeEgnSBBuHFn+IdUlLc8CC4V8w5GRWmf/wSiAiJNNtq
 d2eyeTV2n7gWdZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB742137C3;
 Mon, 29 Dec 2025 19:26:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r7ZgHv3VUmkZVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Dec 2025 19:26:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 12/25] migration: Fold migration_cleanup() into
 migration_connect_error_propagate()
In-Reply-To: <aVLLeZQm376POJ0t@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-13-farosas@suse.de> <aVLLeZQm376POJ0t@x1.local>
Date: Mon, 29 Dec 2025 16:26:50 -0300
Message-ID: <87ikdp84xx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4C9D3336BA
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> On Fri, Dec 26, 2025 at 06:19:14PM -0300, Fabiano Rosas wrote:
>> Whenever an error occurs between migrate_init() and the start of
>> migration_thread, do cleanup immediately after.
>> 
>> This allows the special casing for resume to be removed from
>> migration_connect(), that check is now done at
>> migration_connect_error_propagate() which already had a case for
>> resume.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Didn't spot anything wrong,
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> One nitpick below,
>
>> ---
>>  migration/migration.c | 42 +++++++++++++++++++++++++++---------------
>>  1 file changed, 27 insertions(+), 15 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 0f1644b276..a66b2d7aaf 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1576,15 +1576,21 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
>>  {
>>      MigrationStatus current = s->state;
>>      MigrationStatus next = MIGRATION_STATUS_NONE;
>> +    bool resume = false;
>>  
>>      switch (current) {
>>      case MIGRATION_STATUS_SETUP:
>>          next = MIGRATION_STATUS_FAILED;
>>          break;
>>  
>> +    case MIGRATION_STATUS_POSTCOPY_PAUSED:
>> +        resume = true;
>> +        break;
>> +
>>      case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>>          /* Never fail a postcopy migration; switch back to PAUSED instead */
>>          next = MIGRATION_STATUS_POSTCOPY_PAUSED;
>> +        resume = true;
>>          break;
>>  
>>      case MIGRATION_STATUS_CANCELLING:
>> @@ -1609,6 +1615,10 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
>>      }
>>  
>>      migrate_error_propagate(s, error);
>> +
>> +    if (!resume) {
>> +        migration_cleanup(s);
>> +    }
>>  }
>>  
>>  void migration_cancel(void)
>> @@ -2209,12 +2219,19 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
>>                                        GIOCondition cond,
>>                                        void *opaque)
>>  {
>> +    MigrationState *s = migrate_get_current();
>>      MigrationAddress *addr = opaque;
>> +    Error *local_err = NULL;
>> +
>> +    qmp_migrate_finish(addr, &local_err);
>> +
>> +    if (local_err) {
>> +        migration_connect_error_propagate(s, local_err);
>> +    }
>>  
>> -    qmp_migrate_finish(addr, NULL);
>>  
>>      cpr_state_close();
>> -    migrate_hup_delete(migrate_get_current());
>> +    migrate_hup_delete(s);
>
> IMHO we should drop these two lines.  For error cases, now they'll be done
> in migration_cleanup() above.  Actually for success, it's the same, but in
> the cleanup BH.
>

Hmm that would be good, I'll look into it.

> Maybe there're other cases where we can clean the code a bit on cpr;
> there're codes that always does "if (xxx)" and calling them all over the
> places, so it's easy to write such code when drafting a feature, but hard
> to maintain, because it'll be obscure when it'll really trigger, like this
> one.  We can leave the rest for later if there're applicable similar
> cleanups.
>
>>      qapi_free_MigrationAddress(addr);
>>      return G_SOURCE_REMOVE;
>>  }
>> @@ -2223,7 +2240,6 @@ void qmp_migrate(const char *uri, bool has_channels,
>>                   MigrationChannelList *channels, bool has_detach, bool detach,
>>                   bool has_resume, bool resume, Error **errp)
>>  {
>> -    Error *local_err = NULL;
>>      MigrationState *s = migrate_get_current();
>>      g_autoptr(MigrationChannel) channel = NULL;
>>      MigrationAddress *addr = NULL;
>> @@ -2280,6 +2296,13 @@ void qmp_migrate(const char *uri, bool has_channels,
>>          return;
>>      }
>>  
>> +    /*
>> +     * The migrate_prepare() above calls migrate_init(). From this
>> +     * point on, until the end of migration, make sure any failures
>> +     * eventually result in a call to migration_cleanup().
>> +     */
>> +    Error *local_err = NULL;
>> +
>>      if (!cpr_state_save(cpr_channel, &local_err)) {
>>          goto out;
>>      }
>> @@ -2299,12 +2322,11 @@ void qmp_migrate(const char *uri, bool has_channels,
>>                          QAPI_CLONE(MigrationAddress, addr));
>>  
>>      } else {
>> -        qmp_migrate_finish(addr, errp);
>> +        qmp_migrate_finish(addr, &local_err);
>>      }
>>  
>>  out:
>>      if (local_err) {
>> -        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>>          migration_connect_error_propagate(s, error_copy(local_err));
>>          error_propagate(errp, local_err);
>>      }
>> @@ -2335,12 +2357,6 @@ static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
>>      } else {
>>          error_setg(&local_err, "uri is not a valid migration protocol");
>>      }
>> -
>> -    if (local_err) {
>> -        migration_connect_error_propagate(s, error_copy(local_err));
>> -        error_propagate(errp, local_err);
>> -        return;
>> -    }
>>  }
>>  
>>  void qmp_migrate_cancel(Error **errp)
>> @@ -4027,9 +4043,6 @@ void migration_connect(MigrationState *s, Error *error_in)
>>      s->expected_downtime = migrate_downtime_limit();
>>      if (error_in) {
>>          migration_connect_error_propagate(s, error_in);
>> -        if (!resume) {
>> -            migration_cleanup(s);
>> -        }
>>          if (s->error) {
>>              error_report_err(error_copy(s->error));
>>          }
>> @@ -4108,7 +4121,6 @@ void migration_connect(MigrationState *s, Error *error_in)
>>  
>>  fail:
>>      migration_connect_error_propagate(s, local_err);
>> -    migration_cleanup(s);
>>      if (s->error) {
>>          error_report_err(error_copy(s->error));
>>      }
>> -- 
>> 2.51.0
>> 

