Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DCBD1951A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 21:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUHK-0005QD-OI; Mon, 26 Jan 2026 16:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkUHG-0005Ap-Bi
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:37:43 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkUHB-0003U9-7c
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:37:39 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D95715BCC9;
 Mon, 26 Jan 2026 21:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769463455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FnV9Cuu6+IepDP8/QWi/OAPS4OQ41ugxvwlYKsN3RMY=;
 b=lNcYnHO9UHtQglOEV7bnBHZOAUcTxkk5BI/lXz/dEm23HECvHA8yVOHX6AXjlt1dVyG+N+
 AwSnEZPnBmQJTgsEzDayYPj0WoxLgqoWfigm4pREVPmvUv5iWDiVWbp+4VRbtgL2DPUiSy
 qwkOcJ6mD4q9wETbPsaMHraz67lJP6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769463455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FnV9Cuu6+IepDP8/QWi/OAPS4OQ41ugxvwlYKsN3RMY=;
 b=15LasLE8uy2ayZrpsAomOPkaFEBJhpl5RJGDC5xfPn0QeosSNkZQM36WDvUObqXZy+erUi
 6c8/suHkkPFAVEAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769463454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FnV9Cuu6+IepDP8/QWi/OAPS4OQ41ugxvwlYKsN3RMY=;
 b=fVanC7g3649Raloxk7q+D/+GGX+6EwqQOvQp6rvtHYz6JfI2W6Aob0Bx9Rw6Iqh1s8oxdw
 XmOPEaz+BV4R6phMk9YMQHgVuQ+xmUTM9NJFX1Ciqdd/GnRny4GS2G24qzUbHo3aeZS4Bm
 Asi5vDJq7cO83NYB1zdFotOfDjDUbRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769463454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FnV9Cuu6+IepDP8/QWi/OAPS4OQ41ugxvwlYKsN3RMY=;
 b=QJdW1uSh4Mr1bXw2t7u7h0nwsTqoAb0u9btAYheKFVi2ldT4TSk8ilMS9YDzpd7XwKX47k
 /OoNhLLl89iiz3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D4CA139E9;
 Mon, 26 Jan 2026 21:37:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3YYzAJ7ed2mBRwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Jan 2026 21:37:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>, Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH v3 04/10] multifd: Add COLO support
In-Reply-To: <20260126203358.0f8dc224@penguin>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-4-ae926ccd8eae@web.de>
 <87ms20h2ae.fsf@suse.de> <20260126203358.0f8dc224@penguin>
Date: Mon, 26 Jan 2026 18:37:31 -0300
Message-ID: <878qdkgin8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_CC(0.00)[nongnu.org,redhat.com,gmail.com,xfusion.com,fujitsu.com,treblig.org,trasno.org];
 FREEMAIL_TO(0.00)[web.de]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

Lukas Straub <lukasstraub2@web.de> writes:

>> > +void multifd_colo_prepare_recv(MultiFDRecvParams *p)
>> > +{
>> > +    /*
>> > +     * While we're still in precopy state (not yet in colo state), we copy
>> > +     * received pages to both guest and cache. No need to set dirty bits,
>> > +     * since guest and cache memory are in sync.
>> > +     */
>> > +    if (migration_incoming_in_colo_state()) {  
>> 
>> What's the relationship between migration_incoming_in_colo_state() and
>> migration_incoming_colo_enabled()? ram_load_precopy() checks both. Would
>> migration_incoming_colo_enabled affect multifd as well?
>
> So first off migration_incoming_colo_enabled() and migrate_colo()
> are equivalent in practice since
> 121ccedc2b migration: block incoming colo when capability is disabled
>
> (I have some cleanup patches lying around, but that will be for later)
>

Ok, I think those are important because when having multifd and
non-multifd code for the same feature, it's useful to be able to compare
the two. So some degree of uniformity would be nice.

> For colo, we do normal precopy migration and at the end we go into colo
> state and then
> migration_incoming_in_colo_state() will be true.
>
> Here we check migrate_colo() outside of these functions as Peter
> requested that in a previous version.
>
>> 
>> The multifd recv threads will be running until after
>> process_incoming_migration_bh(), which is when
>> migration_incoming_disable_colo() runs.
>
> That is not an issue as we use migrate_colo() here.
>
>> 
>> Also, is the colo_cache guaranteed to be around until multifd threads
>> exit?
>
> This is an issue. I will fix it in the next version.
>
>>
>> > +        colo_record_bitmap(p->block, p->normal, p->normal_num);
>> > +        colo_record_bitmap(p->block, p->zero, p->zero_num);
>> > +    }
>> > +}
>> > +
>> > +void multifd_colo_process_recv(MultiFDRecvParams *p)
>> > +{
>> > +    if (!migration_incoming_in_colo_state()) {
>> > +        for (int i = 0; i < p->normal_num; i++) {
>> > +            void *guest = p->block->host + p->normal[i];
>> > +            void *cache = p->host + p->normal[i];
>> > +            memcpy(guest, cache, multifd_ram_page_size());
>> > +        }  
>> 
>> I see some differences between what ram.c does and what multifd will do
>> after this patch regarding which flags are checked and order of copies
>> (code below):
>> 
>> ram.c:
>> 
>>   - migration_incoming_colo_enabled && migration_incoming_in_colo_state:
>>   Reads from stream into colo_cache.
>>   
>>   - migration_incoming_colo_enabled && !migration_incoming_in_colo_state:
>>   Reads from stream into guest and then memcpy into colo_cache.
>> 
>>   - !migration_incoming_colo_enabled
>>   Reads from stream into guest.
>> 
>> multifd.c:
>> 
>>   - migrate_colo:
>>   Reads from stream into colo_cache.
>>   
>>   - !migration_incoming_in_colo_state:
>>   memcpy from colo_cache into guest.
>> 
>>   - !migration_incoming_colo_enabled
>>   ???
>> 
>> The resulting state should be the same, but I wonder if we want to i) use
>> the same checks in multifd
>
> migration_incoming_colo_enabled() shouldn't even exist anymore, so I'm
> not using it here. migrate_colo() is much easier to reason about.
>
>> and ii) when not in colo state, copy first
>> into guest (using readv) and later memcpy into the colo_cache.
>
> I think it is easier the way it is now.
>
>> 
>> ---
>> ram.c:
>> 
>> host = host_from_ram_block_offset(block, addr);
>> if (migration_incoming_colo_enabled()) {
>>     if (migration_incoming_in_colo_state()) {
>>         host = colo_cache_from_block_offset(block, addr, true);
>>     } else {
>>         host_bak = colo_cache_from_block_offset(block, addr, false);
>>     }
>> }
>> qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
>> if (host_bak) {
>>     memcpy(host_bak, host, TARGET_PAGE_SIZE);
>> }
>> 
>> multifd:
>> 
>> if (migrate_colo()) {
>>     p->host = p->block->colo_cache;
>> }
>> 
>> for (int i = 0; i < p->normal_num; i++) {
>>     p->iov[i].iov_base = p->host + p->normal[i];
>> }
>> return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
>> 
>> if (!migration_incoming_in_colo_state()) {
>>     for (int i = 0; i < p->normal_num; i++) {
>>         void *guest = p->block->host + p->normal[i];
>>         void *cache = p->host + p->normal[i];
>>         memcpy(guest, cache, multifd_ram_page_size());
>>     }
>> }
>> ---
>> 
>> > +        for (int i = 0; i < p->zero_num; i++) {
>> > +            void *guest = p->block->host + p->zero[i];
>> > +            memset(guest, 0, multifd_ram_page_size());
>> > +        }  
>> 
>> At multifd_nocomp_recv, there will be a call to
>> multifd_recv_zero_page_process(), which by that point will have p->host
>> == p->block->colo_cache, so it looks like that function will do some
>> zero page processing in the colo_cache, setting the rb->receivedmap for
>> pages in the colo_cache and potentially also doing a memcpy. Is this
>> intended?
>
> rb->receivedmap is only for postcopy, right? So it doesn't apply with
> colo.
>

It's not anymore since commit 5ef7e26bdb ("migration/multifd: solve zero
page causing multiple page faults"). So it seems we might be doing extra
work on top of the colo_cache.

>> 
>> I'm thinking that maybe it would overall be better to hook colo directly
>> in to multifd_nocomp_recv:
>
> But then it will only work for nocomp, right? It feels like the wrong
> level of abstraction to me.
>

Ah, nocomp != ram indeed.

>> 
>> static int multifd_nocomp_recv(MultiFDRecvParams *p, Error **errp)
>> {
>>     uint32_t flags;
>> 
>>     if (migrate_mapped_ram()) {
>>         return multifd_file_recv_data(p, errp);
>>     }
>> 
>>     flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
>> 
>>     if (flags != MULTIFD_FLAG_NOCOMP) {
>>         error_setg(errp, "multifd %u: flags received %x flags expected %x",
>>                    p->id, flags, MULTIFD_FLAG_NOCOMP);
>>         return -1;
>>     }
>> 
>> +    if (migration_incoming_colo_enabled() && migration_incoming_in_colo_state()) {
>> +        p->host = p->block->colo_cache;
>> +    } // or else{}, depending on how deal with zero pages in the cache
>> 
>>     multifd_recv_zero_page_process(p);
>> 
>>     if (!p->normal_num) {
>>         return 0;
>>     }
>> 
>>     for (int i = 0; i < p->normal_num; i++) {
>>         p->iov[i].iov_base = p->host + p->normal[i];
>>         p->iov[i].iov_len = multifd_ram_page_size();
>>         ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
>>     }
>> +    ret = qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
>> +    if (ret != 0) {
>> +        return ret;
>> +    }
>> +
>> +    if (migration_incoming_colo_enabled()) {
>> +        multifd_colo_process_recv();
>> +    }
>> 
>>     return ret;
>> }
>> 
>> 
>> > +    }
>> > +}
>> > diff --git a/migration/multifd-colo.h b/migration/multifd-colo.h
>> > new file mode 100644
>> > index 0000000000000000000000000000000000000000..82eaf3f48c47de2f090f9de52f9d57a337d4754a
>> > --- /dev/null
>> > +++ b/migration/multifd-colo.h
>> > @@ -0,0 +1,26 @@
>> > +/*
>> > + * SPDX-License-Identifier: GPL-2.0-or-later
>> > + *
>> > + * multifd colo header
>> > + *
>> > + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
>> > + *
>> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> > + * See the COPYING file in the top-level directory.
>> > + */
>> > +
>> > +#ifndef QEMU_MIGRATION_MULTIFD_COLO_H
>> > +#define QEMU_MIGRATION_MULTIFD_COLO_H
>> > +
>> > +#ifdef CONFIG_REPLICATION
>> > +
>> > +void multifd_colo_prepare_recv(MultiFDRecvParams *p);
>> > +void multifd_colo_process_recv(MultiFDRecvParams *p);
>> > +
>> > +#else
>> > +
>> > +static inline void multifd_colo_prepare_recv(MultiFDRecvParams *p) {}
>> > +static inline void multifd_colo_process_recv(MultiFDRecvParams *p) {}
>> > +
>> > +#endif
>> > +#endif
>> > diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
>> > index 9be79b3b8e00371ebff9e112766c225bec260bf7..9f7a792fa761b3bc30b971b35f464103a61787f0 100644
>> > --- a/migration/multifd-nocomp.c
>> > +++ b/migration/multifd-nocomp.c
>> > @@ -16,6 +16,7 @@
>> >  #include "file.h"
>> >  #include "migration-stats.h"
>> >  #include "multifd.h"
>> > +#include "multifd-colo.h"
>> >  #include "options.h"
>> >  #include "migration.h"
>> >  #include "qapi/error.h"
>> > @@ -269,7 +270,6 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>> >          return -1;
>> >      }
>> >  
>> > -    p->host = p->block->host;
>> >      for (i = 0; i < p->normal_num; i++) {
>> >          uint64_t offset = be64_to_cpu(packet->offset[i]);
>> >  
>> > @@ -294,6 +294,14 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>> >          p->zero[i] = offset;
>> >      }
>> >  
>> > +    if (migrate_colo()) {
>> > +        multifd_colo_prepare_recv(p);
>> > +        assert(p->block->colo_cache);
>> > +        p->host = p->block->colo_cache;  
>> 
>> Can't you just use p->block->colo_cache later? I don't see why p->host
>> needs to be set beforehand even in the non-colo case.
>
> We should not touch the guest ram directly while in colo state, since
> the incoming guest is running and we either want to receive and apply a
> whole checkpoint with all ram into colo cache and all device state,
> or if anything goes wrong during checkpointing, keep the currently
> running guest on the incoming side in pristine state.
>

I was asking about setting p->host at this specific point. I don't think
any of this fits the unfill function. However, I see those were
suggested by Peter so let's not go back and forth.

> I have written more about colo migration here:
>
> https://lore.kernel.org/qemu-devel/20260117204913.584e1829@penguin/
> https://lore.kernel.org/qemu-devel/aXE1i9xJ81EWokYz@x1.local/
>
>> 
>> > +    } else {
>> > +        p->host = p->block->host;
>> > +    }
>> > +
>> >      return 0;
>> >  }
>> >  
>> > diff --git a/migration/multifd.c b/migration/multifd.c
>> > index 332e6fc58053462419f3171f6c320ac37648ef7b..220ed8564960fdabc58e4baa069dd252c8ad293c 100644
>> > --- a/migration/multifd.c
>> > +++ b/migration/multifd.c
>> > @@ -29,6 +29,7 @@
>> >  #include "qemu-file.h"
>> >  #include "trace.h"
>> >  #include "multifd.h"
>> > +#include "multifd-colo.h"
>> >  #include "options.h"
>> >  #include "qemu/yank.h"
>> >  #include "io/channel-file.h"
>> > @@ -1258,6 +1259,13 @@ static int multifd_ram_state_recv(MultiFDRecvParams *p, Error **errp)
>> >      int ret;
>> >  
>> >      ret = multifd_recv_state->ops->recv(p, errp);
>> > +    if (ret != 0) {
>> > +        return ret;
>> > +    }
>> > +
>> > +    if (migrate_colo()) {
>> > +        multifd_colo_process_recv(p);
>> > +    }  
>> 
>> Either put all of colo hooks in multifd.c or multifd-nocomp.c. I think
>> the latter is more appropriate as we have mapped_ram already in
>> there. Let's drop patch 3 and put this in multifd_nocomp_recv().
>
> Again, it also should work with compression and multifd_nocomp_recv()
> is for nocomp only.
>
>> 
>> >  
>> >      return ret;
>> >  }
>> > diff --git a/migration/multifd.h b/migration/multifd.h
>> > index 89a395aef2b09a6762c45b5361e0ab63256feff6..fbc35702b062fdc3213ce92baed35994f5967c2b 100644
>> > --- a/migration/multifd.h
>> > +++ b/migration/multifd.h
>> > @@ -279,7 +279,10 @@ typedef struct {
>> >      uint64_t packets_recved;
>> >      /* ramblock */
>> >      RAMBlock *block;
>> > -    /* ramblock host address */
>> > +    /*
>> > +     * Normally, it points to ramblock's host address.  When COLO
>> > +     * is enabled, it points to the mirror cache for the ramblock.
>> > +     */
>> >      uint8_t *host;
>> >      /* buffers to recv */
>> >      struct iovec *iov;  

