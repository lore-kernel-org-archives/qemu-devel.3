Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A81DC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 14:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqYWb-0005C3-NX; Fri, 07 Mar 2025 09:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqYWP-00052o-VV
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:17:56 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqYWN-00083e-Rz
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:17:53 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F2CDA1F38E;
 Fri,  7 Mar 2025 14:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741357070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ffmums1pXOLAkeNr7mlKJBxhO/9i3whv9vrgUM0R8LM=;
 b=AN/Vhb6zRn8YFDWKJ9s72Ghlq7SejXpKfoYPF5jG3epRo2SrRVJl0J6KJORhJourDqJDxA
 vHdDrgyPeF0bR8Z/lwudC2GguIB1ozlIC+2cEP9N9+PiGZmYsQa63KX8unkUhHZXglqNWs
 7pdz6gqnBJJ0pQ0o8SL1OM1wcDIlZD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741357070;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ffmums1pXOLAkeNr7mlKJBxhO/9i3whv9vrgUM0R8LM=;
 b=4BXOEdelFjMG/8A0Z3t9Tg5TlwtxSYdObP1Bt6PI8IE8BRMQ/1xyKKXs0fIO2dT/rSOSJH
 zWR0MtPLuJKBQuDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="AN/Vhb6z";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4BXOEdel
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741357070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ffmums1pXOLAkeNr7mlKJBxhO/9i3whv9vrgUM0R8LM=;
 b=AN/Vhb6zRn8YFDWKJ9s72Ghlq7SejXpKfoYPF5jG3epRo2SrRVJl0J6KJORhJourDqJDxA
 vHdDrgyPeF0bR8Z/lwudC2GguIB1ozlIC+2cEP9N9+PiGZmYsQa63KX8unkUhHZXglqNWs
 7pdz6gqnBJJ0pQ0o8SL1OM1wcDIlZD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741357070;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ffmums1pXOLAkeNr7mlKJBxhO/9i3whv9vrgUM0R8LM=;
 b=4BXOEdelFjMG/8A0Z3t9Tg5TlwtxSYdObP1Bt6PI8IE8BRMQ/1xyKKXs0fIO2dT/rSOSJH
 zWR0MtPLuJKBQuDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2867C13A22;
 Fri,  7 Mar 2025 14:17:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y2vNNQwAy2erKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Mar 2025 14:17:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V5] migration: ram block cpr blockers
In-Reply-To: <1740667681-257312-1-git-send-email-steven.sistare@oracle.com>
References: <1740667681-257312-1-git-send-email-steven.sistare@oracle.com>
Date: Fri, 07 Mar 2025 11:16:42 -0300
Message-ID: <87zfhxsz79.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: F2CDA1F38E
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Unlike cpr-reboot mode, cpr-transfer mode cannot save volatile ram blocks
> in the migration stream file and recreate them later, because the physical
> memory for the blocks is pinned and registered for vfio.  Add a blocker
> for volatile ram blocks.
>
> Also add a blocker for RAM_GUEST_MEMFD.  Preserving guest_memfd may be
> sufficient for CPR, but it has not been tested yet.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  include/exec/memory.h   |  3 +++
>  include/exec/ramblock.h |  1 +
>  migration/savevm.c      |  2 ++
>  system/physmem.c        | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 72 insertions(+)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9f73b59..ea5d33a 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -3184,6 +3184,9 @@ bool ram_block_discard_is_disabled(void);
>   */
>  bool ram_block_discard_is_required(void);
>  
> +void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp);
> +void ram_block_del_cpr_blocker(RAMBlock *rb);
> +
>  #endif
>  
>  #endif
> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> index 0babd10..64484cd 100644
> --- a/include/exec/ramblock.h
> +++ b/include/exec/ramblock.h
> @@ -39,6 +39,7 @@ struct RAMBlock {
>      /* RCU-enabled, writes protected by the ramlist lock */
>      QLIST_ENTRY(RAMBlock) next;
>      QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
> +    Error *cpr_blocker;
>      int fd;
>      uint64_t fd_offset;
>      int guest_memfd;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index bc375db..85a3559 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3315,12 +3315,14 @@ void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
>      qemu_ram_set_idstr(mr->ram_block,
>                         memory_region_name(mr), dev);
>      qemu_ram_set_migratable(mr->ram_block);
> +    ram_block_add_cpr_blocker(mr->ram_block, &error_fatal);
>  }
>  
>  void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
>  {
>      qemu_ram_unset_idstr(mr->ram_block);
>      qemu_ram_unset_migratable(mr->ram_block);
> +    ram_block_del_cpr_blocker(mr->ram_block);
>  }
>  
>  void vmstate_register_ram_global(MemoryRegion *mr)
> diff --git a/system/physmem.c b/system/physmem.c
> index 67c9db9..0e84f14 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -70,7 +70,10 @@
>  
>  #include "qemu/pmem.h"
>  
> +#include "qapi/qapi-types-migration.h"
> +#include "migration/blocker.h"
>  #include "migration/cpr.h"
> +#include "migration/options.h"
>  #include "migration/vmstate.h"
>  
>  #include "qemu/range.h"
> @@ -1899,6 +1902,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>              qemu_mutex_unlock_ramlist();
>              goto out_free;
>          }
> +
> +        error_setg(&new_block->cpr_blocker,
> +                   "Memory region %s uses guest_memfd, "
> +                   "which is not supported with CPR.",
> +                   memory_region_name(new_block->mr));
> +        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
> +                                  MIG_MODE_CPR_TRANSFER,
> +                                  -1);
>      }
>  
>      ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
> @@ -4059,3 +4070,58 @@ bool ram_block_discard_is_required(void)
>      return qatomic_read(&ram_block_discard_required_cnt) ||
>             qatomic_read(&ram_block_coordinated_discard_required_cnt);
>  }
> +
> +/*
> + * Return true if ram is compatible with CPR.  Do not exclude rom,
> + * because the rom file could change in new QEMU.
> + */
> +static bool ram_is_cpr_compatible(RAMBlock *rb)
> +{
> +    MemoryRegion *mr = rb->mr;
> +
> +    if (!mr || !memory_region_is_ram(mr)) {
> +        return true;
> +    }
> +
> +    /* Ram device is remapped in new QEMU */
> +    if (memory_region_is_ram_device(mr)) {
> +        return true;
> +    }
> +
> +    /*
> +     * A file descriptor is passed to new QEMU and remapped, or its backing
> +     * file is reopened and mapped.  It must be shared to avoid COW.
> +     */
> +    if (rb->fd >= 0 && qemu_ram_is_shared(rb)) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +/*
> + * Add a blocker for each volatile ram block.  This function should only be
> + * called after we know that the block is migratable.  Non-migratable blocks
> + * are either re-created in new QEMU, or are handled specially, or are covered
> + * by a device-level CPR blocker.
> + */
> +void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp)
> +{
> +    assert(qemu_ram_is_migratable(rb));
> +
> +    if (ram_is_cpr_compatible(rb)) {
> +        return;
> +    }
> +
> +    error_setg(&rb->cpr_blocker,
> +               "Memory region %s is not compatible with CPR. share=on is "
> +               "required for memory-backend objects, and aux-ram-share=on is "
> +               "required.", memory_region_name(rb->mr));
> +    migrate_add_blocker_modes(&rb->cpr_blocker, errp, MIG_MODE_CPR_TRANSFER,
> +                              -1);
> +}
> +
> +void ram_block_del_cpr_blocker(RAMBlock *rb)
> +{
> +    migrate_del_blocker(&rb->cpr_blocker);
> +}

I assume this is good for merge. If anyone has further comments, please
speak up.

Thanks

