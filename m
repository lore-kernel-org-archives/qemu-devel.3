Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD98C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 18:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6aYl-0002E4-R6; Mon, 13 May 2024 14:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s6aYa-0002DR-UD
 for qemu-devel@nongnu.org; Mon, 13 May 2024 14:37:54 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s6aYL-0005IJ-83
 for qemu-devel@nongnu.org; Mon, 13 May 2024 14:37:52 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B9133726A;
 Mon, 13 May 2024 18:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715625453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X4EWxJhBnBCATLk11RKl7cFAu8fJwYyDZtK7576l8Bc=;
 b=eO6YiJ8NzayNnBcOMzts4P7u1Yxwp+iBIWTcsuu9+UcaX+TQejJUl9qp0LdW+f1aFwy6vI
 5lVWbjNn+M3f2cf1O04xJ8Wr7SCUpquRC7jpg2pNvPabYqjVeMrz8ejJLjDmlbpNJsVBA5
 OdQLChtOIL3jfHUkjFV3JAt3px/093k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715625453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X4EWxJhBnBCATLk11RKl7cFAu8fJwYyDZtK7576l8Bc=;
 b=fIE4R6ftFEZ73sKTdSrXe4gLR0DibAgsHHqWYJMVMmEHpNobVj3/LecSAR9PpS3JBzOoBn
 MVmwMBFzrh4XdpDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715625453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X4EWxJhBnBCATLk11RKl7cFAu8fJwYyDZtK7576l8Bc=;
 b=eO6YiJ8NzayNnBcOMzts4P7u1Yxwp+iBIWTcsuu9+UcaX+TQejJUl9qp0LdW+f1aFwy6vI
 5lVWbjNn+M3f2cf1O04xJ8Wr7SCUpquRC7jpg2pNvPabYqjVeMrz8ejJLjDmlbpNJsVBA5
 OdQLChtOIL3jfHUkjFV3JAt3px/093k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715625453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X4EWxJhBnBCATLk11RKl7cFAu8fJwYyDZtK7576l8Bc=;
 b=fIE4R6ftFEZ73sKTdSrXe4gLR0DibAgsHHqWYJMVMmEHpNobVj3/LecSAR9PpS3JBzOoBn
 MVmwMBFzrh4XdpDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F5F81372E;
 Mon, 13 May 2024 18:37:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YAWXFexdQmYtCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 13 May 2024 18:37:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 13/26] physmem: ram_block_create
In-Reply-To: <1714406135-451286-14-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-14-git-send-email-steven.sistare@oracle.com>
Date: Mon, 13 May 2024 15:37:30 -0300
Message-ID: <87a5ktfthx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,gmail.com,linaro.org,oracle.com];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TAGGED_RCPT(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> Create a common subroutine to allocate a RAMBlock, de-duping the code to
> populate its common fields.  Add a trace point for good measure.
> No functional change.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  system/physmem.c    | 47 ++++++++++++++++++++++++++---------------------
>  system/trace-events |  3 +++
>  2 files changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/system/physmem.c b/system/physmem.c
> index c3d04ca..6216b14 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -52,6 +52,7 @@
>  #include "sysemu/hw_accel.h"
>  #include "sysemu/xen-mapcache.h"
>  #include "trace/trace-root.h"
> +#include "trace.h"
>  
>  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>  #include <linux/falloc.h>
> @@ -1918,11 +1919,29 @@ out_free:
>      }
>  }
>  
> +static RAMBlock *ram_block_create(MemoryRegion *mr, ram_addr_t size,
> +                                  ram_addr_t max_size, uint32_t ram_flags)
> +{
> +    RAMBlock *rb = g_malloc0(sizeof(*rb));
> +
> +    rb->used_length = size;
> +    rb->max_length = max_size;
> +    rb->fd = -1;
> +    rb->flags = ram_flags;
> +    rb->page_size = qemu_real_host_page_size();
> +    rb->mr = mr;
> +    rb->guest_memfd = -1;
> +    trace_ram_block_create(rb->idstr, rb->flags, rb->fd, rb->used_length,

There's no idstr at this point, is there? I think this needs to be
memory_region_name(mr).

> +                           rb->max_length, mr->align);
> +    return rb;
> +}
> +
>  #ifdef CONFIG_POSIX
>  RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>                                   uint32_t ram_flags, int fd, off_t offset,
>                                   Error **errp)
>  {
> +    void *host;
>      RAMBlock *new_block;
>      Error *local_err = NULL;
>      int64_t file_size, file_align;
> @@ -1962,19 +1981,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>          return NULL;
>      }
>  
> -    new_block = g_malloc0(sizeof(*new_block));
> -    new_block->mr = mr;
> -    new_block->used_length = size;
> -    new_block->max_length = size;
> -    new_block->flags = ram_flags;
> -    new_block->guest_memfd = -1;
> -    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
> -                                     errp);
> -    if (!new_block->host) {
> +    new_block = ram_block_create(mr, size, size, ram_flags);
> +    host = file_ram_alloc(new_block, size, fd, !file_size, offset, errp);
> +    if (!host) {
>          g_free(new_block);
>          return NULL;
>      }
>  
> +    new_block->host = host;
>      ram_block_add(new_block, &local_err);
>      if (local_err) {
>          g_free(new_block);
> @@ -1982,7 +1996,6 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>          return NULL;
>      }
>      return new_block;
> -
>  }
>  
>  
> @@ -2054,18 +2067,10 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>      align = MAX(align, TARGET_PAGE_SIZE);
>      size = ROUND_UP(size, align);
>      max_size = ROUND_UP(max_size, align);
> -
> -    new_block = g_malloc0(sizeof(*new_block));
> -    new_block->mr = mr;
> -    new_block->resized = resized;
> -    new_block->used_length = size;
> -    new_block->max_length = max_size;
>      assert(max_size >= size);
> -    new_block->fd = -1;
> -    new_block->guest_memfd = -1;
> -    new_block->page_size = qemu_real_host_page_size();
> -    new_block->host = host;
> -    new_block->flags = ram_flags;
> +    new_block = ram_block_create(mr, size, max_size, ram_flags);
> +    new_block->resized = resized;
> +
>      ram_block_add(new_block, &local_err);
>      if (local_err) {
>          g_free(new_block);
> diff --git a/system/trace-events b/system/trace-events
> index 69c9044..f0a80ba 100644
> --- a/system/trace-events
> +++ b/system/trace-events
> @@ -38,3 +38,6 @@ dirtylimit_state_finalize(void)
>  dirtylimit_throttle_pct(int cpu_index, uint64_t pct, int64_t time_us) "CPU[%d] throttle percent: %" PRIu64 ", throttle adjust time %"PRIi64 " us"
>  dirtylimit_set_vcpu(int cpu_index, uint64_t quota) "CPU[%d] set dirty page rate limit %"PRIu64
>  dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"PRIi64 " us"
> +
> +# physmem.c
> +ram_block_create(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length, size_t align) "%s, flags %u, fd %d, len %lu, maxlen %lu, align %lu"

