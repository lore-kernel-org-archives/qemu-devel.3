Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F032BD25B4E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 12:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl4h0-0006mz-8g; Wed, 28 Jan 2026 07:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl4gq-0006fc-VS
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 07:30:35 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl4go-0000ho-6B
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 07:30:32 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 799CF5BCDF;
 Wed, 28 Jan 2026 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769603428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5dRIIzdoYDhE79yK2Q200JV014cItghI2CZyAA4CN3E=;
 b=r/309pLBB3Co9EUPz6RFxpyIrb3V/wWgia0RBAVKXlAV6LSiCHqsmilVp8tyl1Q8rpDk02
 opTeLdL7i5R9gMwmosuy+so2kr7pSMhkQq8T1+oezBEAhkn6CHaje6u2ZUayP5xizHCxdK
 ulYYo4C7PjPhQQ7ChMNpnIw9jWQ2LBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769603428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5dRIIzdoYDhE79yK2Q200JV014cItghI2CZyAA4CN3E=;
 b=QKMaJSjdjFu2xabElnGTABxfgzUnQNfjWUftNlZ3lDQUmcaaEgu+kW/Zv6GPZGvOdhHOzg
 smBgcd7Gg5Z/ftAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769603427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5dRIIzdoYDhE79yK2Q200JV014cItghI2CZyAA4CN3E=;
 b=pq5g7dMjHYIYHCrF9ZI4g/1WTB529mi7w+dfhvbSKkDD8ltegL6Pfl8UcKCXRgsbTjMVJ+
 Lt0rseU6VW1dlJrh0S9Qbv4P6KUCBZab7LcQgZaqQJTGMsdDoh/e+dblza2759XFU5VJb9
 fSwxUjex90KRJ+VdeFaWv3jmt0jLlH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769603427;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5dRIIzdoYDhE79yK2Q200JV014cItghI2CZyAA4CN3E=;
 b=OCYDp5bX1ASKjf+RJtqZ93vsWvaGCKaKpDuAXhHeisx52FdWWqamtzAA3YG8ju4bsGUh/9
 ZGzHMb8iSlgDpCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB19B3EA61;
 Wed, 28 Jan 2026 12:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2hzIJmIBemkdCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Jan 2026 12:30:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang
 Chen <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Juan Quintela
 <quintela@trasno.org>
Subject: Re: [PATCH v3 04/10] multifd: Add COLO support
In-Reply-To: <aXkh0Sy9WUqi_3Rr@x1.local>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-4-ae926ccd8eae@web.de>
 <87ms20h2ae.fsf@suse.de> <20260126203358.0f8dc224@penguin>
 <878qdkgin8.fsf@suse.de> <aXkh0Sy9WUqi_3Rr@x1.local>
Date: Wed, 28 Jan 2026 09:30:24 -0300
Message-ID: <87v7glgbrz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[web.de,nongnu.org,redhat.com,gmail.com,xfusion.com,fujitsu.com,treblig.org,trasno.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Jan 26, 2026 at 06:37:31PM -0300, Fabiano Rosas wrote:
>> Lukas Straub <lukasstraub2@web.de> writes:
>> 
>> >> > +void multifd_colo_prepare_recv(MultiFDRecvParams *p)
>> >> > +{
>> >> > +    /*
>> >> > +     * While we're still in precopy state (not yet in colo state), we copy
>> >> > +     * received pages to both guest and cache. No need to set dirty bits,
>> >> > +     * since guest and cache memory are in sync.
>> >> > +     */
>> >> > +    if (migration_incoming_in_colo_state()) {  
>> >> 
>> >> What's the relationship between migration_incoming_in_colo_state() and
>> >> migration_incoming_colo_enabled()? ram_load_precopy() checks both. Would
>> >> migration_incoming_colo_enabled affect multifd as well?
>> >
>> > So first off migration_incoming_colo_enabled() and migrate_colo()
>> > are equivalent in practice since
>> > 121ccedc2b migration: block incoming colo when capability is disabled
>> >
>> > (I have some cleanup patches lying around, but that will be for later)
>> >
>> 
>> Ok, I think those are important because when having multifd and
>> non-multifd code for the same feature, it's useful to be able to compare
>> the two. So some degree of uniformity would be nice.
>
> I second.  We can drop those in this series before adding multifd support,
> likely together with MIG_CMD_ENABLE_COLO as well; I don't think COLO needs
> to worry about old binaries.  It should always use the same QEMU binary on
> both sides.
>
> The patch needs to rename MIG_CMD_ENABLE_COLO to MIG_CMD_DEPRECATED_0 or
> something, to make the rest MIG_CMD compatible to old binaries, though.
>
>> 
>> > For colo, we do normal precopy migration and at the end we go into colo
>> > state and then
>> > migration_incoming_in_colo_state() will be true.
>> >
>> > Here we check migrate_colo() outside of these functions as Peter
>> > requested that in a previous version.
>> >
>> >> 
>> >> The multifd recv threads will be running until after
>> >> process_incoming_migration_bh(), which is when
>> >> migration_incoming_disable_colo() runs.
>> >
>> > That is not an issue as we use migrate_colo() here.
>> >
>> >> 
>> >> Also, is the colo_cache guaranteed to be around until multifd threads
>> >> exit?
>> >
>> > This is an issue. I will fix it in the next version.
>> >
>> >>
>> >> > +        colo_record_bitmap(p->block, p->normal, p->normal_num);
>> >> > +        colo_record_bitmap(p->block, p->zero, p->zero_num);
>> >> > +    }
>> >> > +}
>> >> > +
>> >> > +void multifd_colo_process_recv(MultiFDRecvParams *p)
>> >> > +{
>> >> > +    if (!migration_incoming_in_colo_state()) {
>> >> > +        for (int i = 0; i < p->normal_num; i++) {
>> >> > +            void *guest = p->block->host + p->normal[i];
>> >> > +            void *cache = p->host + p->normal[i];
>> >> > +            memcpy(guest, cache, multifd_ram_page_size());
>> >> > +        }  
>> >> 
>> >> I see some differences between what ram.c does and what multifd will do
>> >> after this patch regarding which flags are checked and order of copies
>> >> (code below):
>> >> 
>> >> ram.c:
>> >> 
>> >>   - migration_incoming_colo_enabled && migration_incoming_in_colo_state:
>> >>   Reads from stream into colo_cache.
>> >>   
>> >>   - migration_incoming_colo_enabled && !migration_incoming_in_colo_state:
>> >>   Reads from stream into guest and then memcpy into colo_cache.
>> >> 
>> >>   - !migration_incoming_colo_enabled
>> >>   Reads from stream into guest.
>> >> 
>> >> multifd.c:
>> >> 
>> >>   - migrate_colo:
>> >>   Reads from stream into colo_cache.
>> >>   
>> >>   - !migration_incoming_in_colo_state:
>> >>   memcpy from colo_cache into guest.
>> >> 
>> >>   - !migration_incoming_colo_enabled
>> >>   ???
>> >> 
>> >> The resulting state should be the same, but I wonder if we want to i) use
>> >> the same checks in multifd
>> >
>> > migration_incoming_colo_enabled() shouldn't even exist anymore, so I'm
>> > not using it here. migrate_colo() is much easier to reason about.
>> >
>> >> and ii) when not in colo state, copy first
>> >> into guest (using readv) and later memcpy into the colo_cache.
>> >
>> > I think it is easier the way it is now.
>> >
>> >> 
>> >> ---
>> >> ram.c:
>> >> 
>> >> host = host_from_ram_block_offset(block, addr);
>> >> if (migration_incoming_colo_enabled()) {
>> >>     if (migration_incoming_in_colo_state()) {
>> >>         host = colo_cache_from_block_offset(block, addr, true);
>> >>     } else {
>> >>         host_bak = colo_cache_from_block_offset(block, addr, false);
>> >>     }
>> >> }
>> >> qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
>> >> if (host_bak) {
>> >>     memcpy(host_bak, host, TARGET_PAGE_SIZE);
>> >> }
>> >> 
>> >> multifd:
>> >> 
>> >> if (migrate_colo()) {
>> >>     p->host = p->block->colo_cache;
>> >> }
>> >> 
>> >> for (int i = 0; i < p->normal_num; i++) {
>> >>     p->iov[i].iov_base = p->host + p->normal[i];
>> >> }
>> >> return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
>> >> 
>> >> if (!migration_incoming_in_colo_state()) {
>> >>     for (int i = 0; i < p->normal_num; i++) {
>> >>         void *guest = p->block->host + p->normal[i];
>> >>         void *cache = p->host + p->normal[i];
>> >>         memcpy(guest, cache, multifd_ram_page_size());
>> >>     }
>> >> }
>> >> ---
>> >> 
>> >> > +        for (int i = 0; i < p->zero_num; i++) {
>> >> > +            void *guest = p->block->host + p->zero[i];
>> >> > +            memset(guest, 0, multifd_ram_page_size());
>> >> > +        }  
>> >> 
>> >> At multifd_nocomp_recv, there will be a call to
>> >> multifd_recv_zero_page_process(), which by that point will have p->host
>> >> == p->block->colo_cache, so it looks like that function will do some
>> >> zero page processing in the colo_cache, setting the rb->receivedmap for
>> >> pages in the colo_cache and potentially also doing a memcpy. Is this
>> >> intended?
>> >
>> > rb->receivedmap is only for postcopy, right? So it doesn't apply with
>> > colo.
>> >
>> 
>> It's not anymore since commit 5ef7e26bdb ("migration/multifd: solve zero
>> page causing multiple page faults"). So it seems we might be doing extra
>> work on top of the colo_cache.
>
> IIUC not extra, but exactly what will be needed.
>
> The logic was about "in a vanilla precopy, if we see one page arriving the
> 1st time we don't need to zero the buffer because the buffer should be zero
> allocated".
>
> In COLO's case, COLO always puts RAM data into colo_cache, hence it should
> apply to colo_cache too, avoiding unnecessary memset() for colo_cache
> instead.
>
> E.g. colo_cache is allocated from qemu_anon_ram_alloc(), it's also
> guaranteed to be zeros when never touched.
>
>> 
>> >> 
>> >> I'm thinking that maybe it would overall be better to hook colo directly
>> >> in to multifd_nocomp_recv:
>> >
>> > But then it will only work for nocomp, right? It feels like the wrong
>> > level of abstraction to me.
>> >
>> 
>> Ah, nocomp != ram indeed.
>> 
>> >> 
>> >> static int multifd_nocomp_recv(MultiFDRecvParams *p, Error **errp)
>> >> {
>> >>     uint32_t flags;
>> >> 
>> >>     if (migrate_mapped_ram()) {
>> >>         return multifd_file_recv_data(p, errp);
>> >>     }
>> >> 
>> >>     flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
>> >> 
>> >>     if (flags != MULTIFD_FLAG_NOCOMP) {
>> >>         error_setg(errp, "multifd %u: flags received %x flags expected %x",
>> >>                    p->id, flags, MULTIFD_FLAG_NOCOMP);
>> >>         return -1;
>> >>     }
>> >> 
>> >> +    if (migration_incoming_colo_enabled() && migration_incoming_in_colo_state()) {
>> >> +        p->host = p->block->colo_cache;
>> >> +    } // or else{}, depending on how deal with zero pages in the cache
>> >> 
>> >>     multifd_recv_zero_page_process(p);
>> >> 
>> >>     if (!p->normal_num) {
>> >>         return 0;
>> >>     }
>> >> 
>> >>     for (int i = 0; i < p->normal_num; i++) {
>> >>         p->iov[i].iov_base = p->host + p->normal[i];
>> >>         p->iov[i].iov_len = multifd_ram_page_size();
>> >>         ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
>> >>     }
>> >> +    ret = qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
>> >> +    if (ret != 0) {
>> >> +        return ret;
>> >> +    }
>> >> +
>> >> +    if (migration_incoming_colo_enabled()) {
>> >> +        multifd_colo_process_recv();
>> >> +    }
>> >> 
>> >>     return ret;
>> >> }
>> >> 
>> >> 
>> >> > +    }
>> >> > +}
>> >> > diff --git a/migration/multifd-colo.h b/migration/multifd-colo.h
>> >> > new file mode 100644
>> >> > index 0000000000000000000000000000000000000000..82eaf3f48c47de2f090f9de52f9d57a337d4754a
>> >> > --- /dev/null
>> >> > +++ b/migration/multifd-colo.h
>> >> > @@ -0,0 +1,26 @@
>> >> > +/*
>> >> > + * SPDX-License-Identifier: GPL-2.0-or-later
>> >> > + *
>> >> > + * multifd colo header
>> >> > + *
>> >> > + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
>> >> > + *
>> >> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> >> > + * See the COPYING file in the top-level directory.
>> >> > + */
>> >> > +
>> >> > +#ifndef QEMU_MIGRATION_MULTIFD_COLO_H
>> >> > +#define QEMU_MIGRATION_MULTIFD_COLO_H
>> >> > +
>> >> > +#ifdef CONFIG_REPLICATION
>> >> > +
>> >> > +void multifd_colo_prepare_recv(MultiFDRecvParams *p);
>> >> > +void multifd_colo_process_recv(MultiFDRecvParams *p);
>> >> > +
>> >> > +#else
>> >> > +
>> >> > +static inline void multifd_colo_prepare_recv(MultiFDRecvParams *p) {}
>> >> > +static inline void multifd_colo_process_recv(MultiFDRecvParams *p) {}
>> >> > +
>> >> > +#endif
>> >> > +#endif
>> >> > diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
>> >> > index 9be79b3b8e00371ebff9e112766c225bec260bf7..9f7a792fa761b3bc30b971b35f464103a61787f0 100644
>> >> > --- a/migration/multifd-nocomp.c
>> >> > +++ b/migration/multifd-nocomp.c
>> >> > @@ -16,6 +16,7 @@
>> >> >  #include "file.h"
>> >> >  #include "migration-stats.h"
>> >> >  #include "multifd.h"
>> >> > +#include "multifd-colo.h"
>> >> >  #include "options.h"
>> >> >  #include "migration.h"
>> >> >  #include "qapi/error.h"
>> >> > @@ -269,7 +270,6 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>> >> >          return -1;
>> >> >      }
>> >> >  
>> >> > -    p->host = p->block->host;
>> >> >      for (i = 0; i < p->normal_num; i++) {
>> >> >          uint64_t offset = be64_to_cpu(packet->offset[i]);
>> >> >  
>> >> > @@ -294,6 +294,14 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>> >> >          p->zero[i] = offset;
>> >> >      }
>> >> >  
>> >> > +    if (migrate_colo()) {
>> >> > +        multifd_colo_prepare_recv(p);
>> >> > +        assert(p->block->colo_cache);
>> >> > +        p->host = p->block->colo_cache;  
>> >> 
>> >> Can't you just use p->block->colo_cache later? I don't see why p->host
>> >> needs to be set beforehand even in the non-colo case.
>> >
>> > We should not touch the guest ram directly while in colo state, since
>> > the incoming guest is running and we either want to receive and apply a
>> > whole checkpoint with all ram into colo cache and all device state,
>> > or if anything goes wrong during checkpointing, keep the currently
>> > running guest on the incoming side in pristine state.
>> >
>> 
>> I was asking about setting p->host at this specific point. I don't think
>> any of this fits the unfill function. However, I see those were
>> suggested by Peter so let's not go back and forth.
>
> Actually I don't know why p->host existed before this work; IIUC we could
> have always used p->block->host.  Maybe when Juan was developing this Juan
> kept COLO in mind; or maybe Juan wanted to avoid frequent p->block pointer
> reference.
>

Maybe p->block was being reset at some point and p->host was passed
being the point where the (whatever) lock was release. I checked and
today there's no such thing. The p->mutex seems to be there just to
protect against this in multifd_recv_sync_main:

WITH_QEMU_LOCK_GUARD(&p->mutex) {
    if (multifd_recv_state->packet_num < p->packet_num) {
        multifd_recv_state->packet_num = p->packet_num;
    }
}

> IIUC, we could remove p->host, but when we need to access "the buffer of
> the ramblock" we'll need to call a helper to fetch that (either ramblock's
> buffer, or colo_cache, per migrate_colo()).  And it might be slightly
> slower than p->host indeed.
>

Yeah, let's keep it, the compression code also uses it, there's no point
removing it now.

>> 
>> > I have written more about colo migration here:
>> >
>> > https://lore.kernel.org/qemu-devel/20260117204913.584e1829@penguin/
>> > https://lore.kernel.org/qemu-devel/aXE1i9xJ81EWokYz@x1.local/
>> >
>> >> 
>> >> > +    } else {
>> >> > +        p->host = p->block->host;
>> >> > +    }
>> >> > +
>> >> >      return 0;
>> >> >  }
>> >> >  
>> >> > diff --git a/migration/multifd.c b/migration/multifd.c
>> >> > index 332e6fc58053462419f3171f6c320ac37648ef7b..220ed8564960fdabc58e4baa069dd252c8ad293c 100644
>> >> > --- a/migration/multifd.c
>> >> > +++ b/migration/multifd.c
>> >> > @@ -29,6 +29,7 @@
>> >> >  #include "qemu-file.h"
>> >> >  #include "trace.h"
>> >> >  #include "multifd.h"
>> >> > +#include "multifd-colo.h"
>> >> >  #include "options.h"
>> >> >  #include "qemu/yank.h"
>> >> >  #include "io/channel-file.h"
>> >> > @@ -1258,6 +1259,13 @@ static int multifd_ram_state_recv(MultiFDRecvParams *p, Error **errp)
>> >> >      int ret;
>> >> >  
>> >> >      ret = multifd_recv_state->ops->recv(p, errp);
>> >> > +    if (ret != 0) {
>> >> > +        return ret;
>> >> > +    }
>> >> > +
>> >> > +    if (migrate_colo()) {
>> >> > +        multifd_colo_process_recv(p);
>> >> > +    }  
>> >> 
>> >> Either put all of colo hooks in multifd.c or multifd-nocomp.c. I think
>> >> the latter is more appropriate as we have mapped_ram already in
>> >> there. Let's drop patch 3 and put this in multifd_nocomp_recv().
>> >
>> > Again, it also should work with compression and multifd_nocomp_recv()
>> > is for nocomp only.
>> >
>> >> 
>> >> >  
>> >> >      return ret;
>> >> >  }
>> >> > diff --git a/migration/multifd.h b/migration/multifd.h
>> >> > index 89a395aef2b09a6762c45b5361e0ab63256feff6..fbc35702b062fdc3213ce92baed35994f5967c2b 100644
>> >> > --- a/migration/multifd.h
>> >> > +++ b/migration/multifd.h
>> >> > @@ -279,7 +279,10 @@ typedef struct {
>> >> >      uint64_t packets_recved;
>> >> >      /* ramblock */
>> >> >      RAMBlock *block;
>> >> > -    /* ramblock host address */
>> >> > +    /*
>> >> > +     * Normally, it points to ramblock's host address.  When COLO
>> >> > +     * is enabled, it points to the mirror cache for the ramblock.
>> >> > +     */
>> >> >      uint8_t *host;
>> >> >      /* buffers to recv */
>> >> >      struct iovec *iov;  
>> 

