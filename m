Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6486CCD1BD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 14:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqvs7-0002i6-Eh; Wed, 18 Sep 2024 10:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sqvs5-0002gt-G7
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:41:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sqvs3-00083G-Bf
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:41:33 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 142D1204FC;
 Wed, 18 Sep 2024 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726670489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWZCBZDfCSnodFC1xPkiz9DiBBgHuOjRLGL+aJBIIGw=;
 b=otXFSJaFfusdhW51EC2o83v7jacvwr6XU5OKKWPbH1JWEBLIjAAgLgUlcuzJ5lPZ/3S2U0
 myJHP5zoeeKlP8rDCXq1YI/yJv5yGi3ZQmdHZe0d/6BpcyMLPAK/ocwWzhb+PBON+ZpeSj
 FLQD8DrYBhs5Zpch2eDxGIVjbt6HENQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726670489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWZCBZDfCSnodFC1xPkiz9DiBBgHuOjRLGL+aJBIIGw=;
 b=ZHDgtefaESin4gYGtvswEnXCOyDjrj91YolpCNruW8ODilKx/dZas8Utrkr2EtP4W5ZwLs
 VMUPTU0UQZsmOgAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726670489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWZCBZDfCSnodFC1xPkiz9DiBBgHuOjRLGL+aJBIIGw=;
 b=otXFSJaFfusdhW51EC2o83v7jacvwr6XU5OKKWPbH1JWEBLIjAAgLgUlcuzJ5lPZ/3S2U0
 myJHP5zoeeKlP8rDCXq1YI/yJv5yGi3ZQmdHZe0d/6BpcyMLPAK/ocwWzhb+PBON+ZpeSj
 FLQD8DrYBhs5Zpch2eDxGIVjbt6HENQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726670489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWZCBZDfCSnodFC1xPkiz9DiBBgHuOjRLGL+aJBIIGw=;
 b=ZHDgtefaESin4gYGtvswEnXCOyDjrj91YolpCNruW8ODilKx/dZas8Utrkr2EtP4W5ZwLs
 VMUPTU0UQZsmOgAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F8E113A57;
 Wed, 18 Sep 2024 14:41:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iI7XFZjm6mZYTwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 18 Sep 2024 14:41:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, David
 Hildenbrand <david@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 3/7] qapi/migration: Introduce the iteration-count
In-Reply-To: <CAK9dgmYA-8uHQbXo3X5YKxY9-EgbgFc=OTrfjWW1KEuQ6L3iWQ@mail.gmail.com>
References: <cover.1726390098.git.yong.huang@smartx.com>
 <654bfad294e2cc3394f744bd8536e0448c0bf550.1726390099.git.yong.huang@smartx.com>
 <87v7yvz697.fsf@suse.de>
 <CAK9dgmYA-8uHQbXo3X5YKxY9-EgbgFc=OTrfjWW1KEuQ6L3iWQ@mail.gmail.com>
Date: Wed, 18 Sep 2024 11:39:12 -0300
Message-ID: <8734lxf2lr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Yong Huang <yong.huang@smartx.com> writes:

> On Tue, Sep 17, 2024 at 4:35=E2=80=AFAM Fabiano Rosas <farosas@suse.de> w=
rote:
>
>> Hyman Huang <yong.huang@smartx.com> writes:
>>
>> > The original migration information dirty-sync-count could
>> > no longer reflect iteration count due to the introduction
>> > of background synchronization in the next commit;
>> > add the iteration count to compensate.
>>
>> I agree with the overall idea, but I feel we're lacking some information
>> on what determines whether some of the lines below want to use the
>> iteration count vs. the dirty sync count. Since this patch increments
>> both variables at the same place, they can still be used interchangeably
>> unless we add some words to explain the distinction.
>>
>> So to clarify:
>>
>> What do we call an iteration? A call to save_live_iterate(),
>> migration_iteration_run() or something else?
>>
>> Why dirty-sync-count should ever have reflected "iteration count"? It
>> might have been this way by coincidence, but did we ever used it in that
>> sense (aside from info migrate maybe)?
>>
>
> Unfortunately, I found that Libvirt already regard the "dirty-sync-count"
> as the "iteration count", so if we substitute the "dirty-sync-count"
> with "iteration count" to represent its original meaning, this could
> break the backward compatibility.
>
> To avoid this side effect, we may keep the "dirty-sync-count" as its
> original meaning and introduce a new field like "dirty-sync-count-interna=
l"
> to represent the *real* "dirty-sync-count"?
>
> diff --git a/migration/migration.c b/migration/migration.c
> index f97f6352d2..663315d7e6 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1196,8 +1196,9 @@ static void populate_ram_info(MigrationInfo *info,
> MigrationState *s)
>      info->ram->normal_bytes =3D info->ram->normal * page_size;
>      info->ram->mbps =3D s->mbps;
>      info->ram->dirty_sync_count =3D
> +        stat64_get(&mig_stats.iteration_count);

ok

> +    info->ram->dirty_sync_count_internal =3D
>          stat64_get(&mig_stats.dirty_sync_count);

Does this need to be exposed at all? If it does then it'll need a name
that doesn't have "internal" in it.

> -    info->ram->iteration_count =3D stat64_get(&mig_stats.iteration_count=
);
>      info->ram->dirty_sync_missed_zero_copy =3D
>          stat64_get(&mig_stats.dirty_sync_missed_zero_copy);
>      info->ram->postcopy_requests =3D
>
>
>>
>> With the new counter, what kind of meaning can a user extract from that
>> number aside from "some undescribed thing happened N times" (this might
>> be included in the migration.json docs)?
>>
>> >
>> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>> > ---
>> >  migration/migration-stats.h  |  4 ++++
>> >  migration/migration.c        |  1 +
>> >  migration/ram.c              | 12 ++++++++----
>> >  qapi/migration.json          |  6 +++++-
>> >  tests/qtest/migration-test.c |  2 +-
>> >  5 files changed, 19 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/migration/migration-stats.h b/migration/migration-stats.h
>> > index 05290ade76..43ee0f4f05 100644
>> > --- a/migration/migration-stats.h
>> > +++ b/migration/migration-stats.h
>> > @@ -50,6 +50,10 @@ typedef struct {
>> >       * Number of times we have synchronized guest bitmaps.
>> >       */
>> >      Stat64 dirty_sync_count;
>> > +    /*
>> > +     * Number of migration iteration processed.
>> > +     */
>> > +    Stat64 iteration_count;
>> >      /*
>> >       * Number of times zero copy failed to send any page using zero
>> >       * copy.
>> > diff --git a/migration/migration.c b/migration/migration.c
>> > index 3dea06d577..055d527ff6 100644
>> > --- a/migration/migration.c
>> > +++ b/migration/migration.c
>> > @@ -1197,6 +1197,7 @@ static void populate_ram_info(MigrationInfo *inf=
o,
>> MigrationState *s)
>> >      info->ram->mbps =3D s->mbps;
>> >      info->ram->dirty_sync_count =3D
>> >          stat64_get(&mig_stats.dirty_sync_count);
>> > +    info->ram->iteration_count =3D stat64_get(&mig_stats.iteration_co=
unt);
>> >      info->ram->dirty_sync_missed_zero_copy =3D
>> >          stat64_get(&mig_stats.dirty_sync_missed_zero_copy);
>> >      info->ram->postcopy_requests =3D
>> > diff --git a/migration/ram.c b/migration/ram.c
>> > index e205806a5f..ca5a1b5f16 100644
>> > --- a/migration/ram.c
>> > +++ b/migration/ram.c
>> > @@ -594,7 +594,7 @@ static void xbzrle_cache_zero_page(ram_addr_t
>> current_addr)
>> >      /* We don't care if this fails to allocate a new cache page
>> >       * as long as it updated an old one */
>> >      cache_insert(XBZRLE.cache, current_addr, XBZRLE.zero_target_page,
>> > -                 stat64_get(&mig_stats.dirty_sync_count));
>> > +                 stat64_get(&mig_stats.iteration_count));
>> >  }
>> >
>> >  #define ENCODING_FLAG_XBZRLE 0x1
>> > @@ -620,7 +620,7 @@ static int save_xbzrle_page(RAMState *rs,
>> PageSearchStatus *pss,
>> >      int encoded_len =3D 0, bytes_xbzrle;
>> >      uint8_t *prev_cached_page;
>> >      QEMUFile *file =3D pss->pss_channel;
>> > -    uint64_t generation =3D stat64_get(&mig_stats.dirty_sync_count);
>> > +    uint64_t generation =3D stat64_get(&mig_stats.iteration_count);
>> >
>> >      if (!cache_is_cached(XBZRLE.cache, current_addr, generation)) {
>> >          xbzrle_counters.cache_miss++;
>> > @@ -1079,6 +1079,10 @@ static void migration_bitmap_sync(RAMState *rs,
>> >      RAMBlock *block;
>> >      int64_t end_time;
>> >
>> > +    if (!background) {
>> > +        stat64_add(&mig_stats.iteration_count, 1);
>> > +    }
>> > +
>> >      stat64_add(&mig_stats.dirty_sync_count, 1);
>> >
>> >      if (!rs->time_last_bitmap_sync) {
>> > @@ -1115,8 +1119,8 @@ static void migration_bitmap_sync(RAMState *rs,
>> >          rs->num_dirty_pages_period =3D 0;
>> >          rs->bytes_xfer_prev =3D migration_transferred_bytes();
>> >      }
>> > -    if (migrate_events()) {
>> > -        uint64_t generation =3D stat64_get(&mig_stats.dirty_sync_coun=
t);
>> > +    if (!background && migrate_events()) {
>> > +        uint64_t generation =3D stat64_get(&mig_stats.iteration_count=
);
>> >          qapi_event_send_migration_pass(generation);
>> >      }
>> >  }
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index b66cccf107..95b490706c 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -60,6 +60,9 @@
>> >  #     between 0 and @dirty-sync-count * @multifd-channels.  (since
>> >  #     7.1)
>> >  #
>> > +# @iteration-count: The number of iterations since migration started.
>> > +#     (since 9.2)
>> > +#
>> >  # Since: 0.14
>> >  ##
>> >  { 'struct': 'MigrationStats',
>> > @@ -72,7 +75,8 @@
>> >             'multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
>> >             'precopy-bytes': 'uint64', 'downtime-bytes': 'uint64',
>> >             'postcopy-bytes': 'uint64',
>> > -           'dirty-sync-missed-zero-copy': 'uint64' } }
>> > +           'dirty-sync-missed-zero-copy': 'uint64',
>> > +           'iteration-count' : 'int' } }
>> >
>> >  ##
>> >  # @XBZRLECacheStats:
>> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test=
.c
>> > index d6768d5d71..b796a90cad 100644
>> > --- a/tests/qtest/migration-test.c
>> > +++ b/tests/qtest/migration-test.c
>> > @@ -278,7 +278,7 @@ static int64_t read_migrate_property_int(QTestState
>> *who, const char *property)
>> >
>> >  static uint64_t get_migration_pass(QTestState *who)
>> >  {
>> > -    return read_ram_property_int(who, "dirty-sync-count");
>> > +    return read_ram_property_int(who, "iteration-count");
>> >  }
>> >
>> >  static void read_blocktime(QTestState *who)
>>

