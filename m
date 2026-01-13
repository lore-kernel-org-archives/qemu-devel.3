Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D4FD2D0FE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfeR9-0004fU-7k; Tue, 13 Jan 2026 08:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vfeR6-0004f4-DD
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:27:53 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vfeR4-00059J-W4
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:27:52 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 79D3B33681;
 Tue, 13 Jan 2026 13:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768310869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lKt8p6svqzYlUv4lxIHR5dpry3O7HbwMV/nu6kM87Eg=;
 b=gm0HxsQnGHcwbwpB8Dt04lkrdJ4QCMUBEJMXupj/m5e9OvBbTxwX7y6loMSOy83whEyak6
 S6d6FV3vcHT89QSW1F4nY3Thy0BmoTZ/CpgHxg6nSlBEL/Hs7e6vldBUVIgsXE1c7wLIMt
 O5BW2GKTGclx4rlT46YuN0fzG6qlnG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768310869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lKt8p6svqzYlUv4lxIHR5dpry3O7HbwMV/nu6kM87Eg=;
 b=tC3F2f2I4zF5Z9C4b0YUlDATj1YIzSiwu/ERYoD1fT/jEfmQV3fY1C7K445JTxHGv2/4nJ
 wBxQ0pBYfISlt3DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768310868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lKt8p6svqzYlUv4lxIHR5dpry3O7HbwMV/nu6kM87Eg=;
 b=c7IfzS3smo5/2xbpZd32cieVhpiaSNQgcH55qWNaVFEYH6UnGpbjckWn7eXcKLTzBdyuO0
 5YtJUwSYQvevYosvIu3YJEfTUUBQ2zS6pLwPYweBspZGP5wEV99aNKj70ckdeQqwv27SHz
 yXgYVr6Z9uiqwSdyGhO0o2Vkfl3OfN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768310868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lKt8p6svqzYlUv4lxIHR5dpry3O7HbwMV/nu6kM87Eg=;
 b=EgLcr7Y6gUBRUlRckW4tsWEirR+rxaA1Xg7Ot9UQDjEWSsq1uvAIKIm+Fdm7RVc4rcBZVq
 oBWiYyjJrySBRKCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC8513EA63;
 Tue, 13 Jan 2026 13:27:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cNLDKlNIZmlkEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 13 Jan 2026 13:27:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v3 02/25] migration: Fix state change at
 migration_channel_process_incoming
In-Reply-To: <CAE8KmOwD5u8q_bDVXLQuiiC267qr22A6=F7_B4zuxePGauBpuw@mail.gmail.com>
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-3-farosas@suse.de>
 <CAE8KmOwD5u8q_bDVXLQuiiC267qr22A6=F7_B4zuxePGauBpuw@mail.gmail.com>
Date: Tue, 13 Jan 2026 10:27:45 -0300
Message-ID: <87a4yhprqm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Fri, 9 Jan 2026 at 18:11, Fabiano Rosas <farosas@suse.de> wrote:
>> When the incoming migration fails during the channel connection phase,
>> the state transition to FAILED is currently being done in the
>> MigrationState->state, but the MigrationIncomingState->state is the
>> one that should be used.
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/channel.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/migration/channel.c b/migration/channel.c
>> index 92435fa7f7..4768c71455 100644
>> --- a/migration/channel.c
>> +++ b/migration/channel.c
>> @@ -48,7 +48,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>>
>>      if (local_err) {
>>          error_report_err(local_err);
>> -        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>> +        migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
>>          if (mis->exit_on_error) {
>>              exit(EXIT_FAILURE);
>>          }
>
> * Change looks okay. (/me makes a note to see if we could combine
> MigrationState and MigrationIncomingState, why couldn't we use the
> same struct/object on both source and destination sides?).
>

The entire structs are a bit big for them to be duplicated. We could
certainly combine individual fields where it makes sense, or extract
some fields into their own structures that only get used in local
contexts. Work to be done.

> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
>
> Thank you.
> ---
>   - Prasad

