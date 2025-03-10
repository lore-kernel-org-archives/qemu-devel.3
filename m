Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E720DC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 14:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treHf-0002pc-I4; Mon, 10 Mar 2025 10:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1treHX-0002pJ-O5
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:39:03 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1treHU-0001jx-8x
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:39:03 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A40691F387;
 Mon, 10 Mar 2025 14:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741617535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yOYvJTSOLjHjh+mIn6KuztMYRAMzzhtNxHr2breor90=;
 b=CIlBh0Sf8XqZzBYwHdp0TTaPZD+RcVFnbzbvg1ppyRI1m56Vg5oUR19phZNI1NdeZKSiSE
 eNXIOB95lQnC5AabaDG2jKy4S24icvRx8yqRo9Si5gW5dxmrnVxVNbQ7U4CFjL+eBlha/f
 NYy9m6a4nacfcPj4piR/KCDWteIkpvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741617535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yOYvJTSOLjHjh+mIn6KuztMYRAMzzhtNxHr2breor90=;
 b=+oT3E3SBosQMqdgP+PZSW8NUFPv1s/kGXXaDBkRcLQod2syH26NwyfZU4LaUVVbGgSk7Kc
 AsCG5WY5CmI9uXDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CIlBh0Sf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+oT3E3SB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741617535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yOYvJTSOLjHjh+mIn6KuztMYRAMzzhtNxHr2breor90=;
 b=CIlBh0Sf8XqZzBYwHdp0TTaPZD+RcVFnbzbvg1ppyRI1m56Vg5oUR19phZNI1NdeZKSiSE
 eNXIOB95lQnC5AabaDG2jKy4S24icvRx8yqRo9Si5gW5dxmrnVxVNbQ7U4CFjL+eBlha/f
 NYy9m6a4nacfcPj4piR/KCDWteIkpvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741617535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yOYvJTSOLjHjh+mIn6KuztMYRAMzzhtNxHr2breor90=;
 b=+oT3E3SBosQMqdgP+PZSW8NUFPv1s/kGXXaDBkRcLQod2syH26NwyfZU4LaUVVbGgSk7Kc
 AsCG5WY5CmI9uXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18D6A139E7;
 Mon, 10 Mar 2025 14:38:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n9N+MX75zmeaOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 10 Mar 2025 14:38:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
In-Reply-To: <Z8t4YoPEnwJO0sFP@x1.local>
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com> <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
 <Z8XBowkG72G-l3L4@x1.local>
 <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
 <Z8cPnxqOvp1hFpx8@x1.local>
 <CAE8KmOw1CCQUt0wyELVhy5j-CfwVuA2XNsecW=y6rwJv7dempw@mail.gmail.com>
 <Z8hJeneeuKqD1i8Q@x1.local>
 <CAE8KmOyKiEt9t0vUwVyqD7tx01vkm+NHA1p1tmQnJ9mKY0Za7w@mail.gmail.com>
 <Z8t4YoPEnwJO0sFP@x1.local>
Date: Mon, 10 Mar 2025 11:38:52 -0300
Message-ID: <87ldtdt0g3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: A40691F387
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Fri, Mar 07, 2025 at 05:15:03PM +0530, Prasad Pandit wrote:
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 65fc4f5eed..da2c49c303 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -3401,9 +3401,10 @@ static MigIterateState
>> migration_iteration_run(MigrationState *s)
>>      if (!in_postcopy && must_precopy <= s->threshold_size
>>          && can_switchover && qatomic_read(&s->start_postcopy)) {
>>          if (migrate_multifd()) {
>> -            multifd_send_flush();
>> -            multifd_send_sync_main(MULTIFD_SYNC_LOCAL);
>> -            qemu_savevm_send_multifd_recv_sync(s->to_dst_file);
>> +/*          multifd_send_flush();
>> + *          multifd_send_sync_main(MULTIFD_SYNC_ALL);
>> + *          qemu_savevm_send_multifd_recv_sync(s->to_dst_file);
>> + */
>> +            qemu_savevm_state_complete_multifd(s->to_dst_file);
>>              multifd_send_shutdown();
>
> Forgot to mention one thing:
>
> If you do flush and sync, IMHO we can keep the threads there and remove
> this shutdown, as long as we are sure it'll be properly shutdown when
> cleanup.
>
> With the assertion in dest threads, I think it should be OK.

Good point. Shutdown at random places makes it difficult to protect
against cleanup races.

