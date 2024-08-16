Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641EBC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf1CT-0007wj-6T; Fri, 16 Aug 2024 13:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sf1CR-0007wE-Ok
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:57:19 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sf1CD-0005Eu-Ce
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:57:19 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BA6C22878;
 Fri, 16 Aug 2024 17:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723831023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pR/UoN9/E44L4n2whK4d6Mp0ooouYsXb8OSb0/YOZM4=;
 b=X+DfrzqZVl4d72Mx7e00jt8n0xRIgP1YuT3CrsaNIMuAyhir96inEMaQitabmGpa8OiJGN
 cK7VBWZu0lcYDbxEj9yPRVsCtbQCkvu8arCPzSLHuvYGzRPoDFdVfC4tDhW9EyohEwromF
 mOQbcfMlbcTQEKrySl0Pavq8Yes3jLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723831023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pR/UoN9/E44L4n2whK4d6Mp0ooouYsXb8OSb0/YOZM4=;
 b=4+51J7WPjjqy1QEFC2VrVp88tVv8BoYojjwvGB8SsjN8TxS5N6ToZ45fNBcLrQ//ftKK94
 n30VOjgNTAWTllDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X+DfrzqZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4+51J7WP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723831023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pR/UoN9/E44L4n2whK4d6Mp0ooouYsXb8OSb0/YOZM4=;
 b=X+DfrzqZVl4d72Mx7e00jt8n0xRIgP1YuT3CrsaNIMuAyhir96inEMaQitabmGpa8OiJGN
 cK7VBWZu0lcYDbxEj9yPRVsCtbQCkvu8arCPzSLHuvYGzRPoDFdVfC4tDhW9EyohEwromF
 mOQbcfMlbcTQEKrySl0Pavq8Yes3jLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723831023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pR/UoN9/E44L4n2whK4d6Mp0ooouYsXb8OSb0/YOZM4=;
 b=4+51J7WPjjqy1QEFC2VrVp88tVv8BoYojjwvGB8SsjN8TxS5N6ToZ45fNBcLrQ//ftKK94
 n30VOjgNTAWTllDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC58F1397F;
 Fri, 16 Aug 2024 17:57:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id la0/LO6Sv2ZIQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 16 Aug 2024 17:57:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe
 Mathieu-Daude <philmd@linaro.org>, David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [RFC V1 10/12] migration/ram: old host address
In-Reply-To: <1721502937-87102-11-git-send-email-steven.sistare@oracle.com>
References: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
 <1721502937-87102-11-git-send-email-steven.sistare@oracle.com>
Date: Fri, 16 Aug 2024 14:57:00 -0300
Message-ID: <87ikw05p1v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7BA6C22878
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.47 / 50.00]; BAYES_HAM(-2.96)[99.82%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[12]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:dkim]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Remember the RAMBlock host address as host_old during migration, for use
> by CPR.  The iommufd interface to update the virtual address of DMA
> mappings requires it.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  hw/core/machine.c       | 6 ++++++
>  include/exec/ramblock.h | 1 +
>  migration/migration.h   | 2 ++
>  migration/options.c     | 2 ++
>  migration/ram.c         | 7 +++++++
>  5 files changed, 18 insertions(+)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 9676953..0ac16b8 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -35,6 +35,12 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "audio/audio.h"
>  
> +/* TBD: register hw_compat_9_1 with machines */
> +GlobalProperty hw_compat_9_1[] = {
> +    { "migration", "send-host-old", "off"},
> +};
> +const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
> +
>  GlobalProperty hw_compat_9_0[] = {
>      {"arm-cpu", "backcompat-cntfrq", "true" },
>      {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> index 64484cd..8f1c535 100644
> --- a/include/exec/ramblock.h
> +++ b/include/exec/ramblock.h
> @@ -28,6 +28,7 @@ struct RAMBlock {
>      struct rcu_head rcu;
>      struct MemoryRegion *mr;
>      uint8_t *host;
> +    uint64_t host_old;
>      uint8_t *colo_cache; /* For colo, VM's ram cache */
>      ram_addr_t offset;
>      ram_addr_t used_length;
> diff --git a/migration/migration.h b/migration/migration.h
> index 38aa140..b5e3151 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -442,6 +442,8 @@ struct MigrationState {
>       */
>      uint8_t clear_bitmap_shift;
>  
> +    bool send_host_old;
> +
>      /*
>       * This save hostname when out-going migration starts
>       */
> diff --git a/migration/options.c b/migration/options.c
> index 7526f9f..197cb86 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -92,6 +92,8 @@ Property migration_properties[] = {
>                        clear_bitmap_shift, CLEAR_BITMAP_SHIFT_DEFAULT),
>      DEFINE_PROP_BOOL("x-preempt-pre-7-2", MigrationState,
>                       preempt_pre_7_2, false),
> +    DEFINE_PROP_BOOL("send-host-old", MigrationState,
> +                     send_host_old, true),
>  
>      /* Migration parameters */
>      DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
> diff --git a/migration/ram.c b/migration/ram.c
> index 1e1e05e..8644917 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3030,6 +3030,9 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>              qemu_put_byte(f, strlen(block->idstr));
>              qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
>              qemu_put_be64(f, block->used_length);
> +            if (migrate_get_current()->send_host_old) {
> +                qemu_put_be64(f, (uint64_t)block->host);
> +            }

This requires an update of scripts/analyze-migration.py. Could be done
on the side.

>              if (migrate_postcopy_ram() &&
>                  block->page_size != max_hg_page_size) {
>                  qemu_put_be64(f, block->page_size);
> @@ -4021,6 +4024,10 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>  
>      assert(block);
>  
> +    if (migrate_get_current()->send_host_old) {
> +        block->host_old = qemu_get_be64(f);
> +    }
> +
>      if (migrate_mapped_ram()) {
>          parse_ramblock_mapped_ram(f, block, length, &local_err);
>          if (local_err) {

