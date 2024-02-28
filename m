Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11A2C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 19:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfPsz-0005Xa-Gg; Wed, 28 Feb 2024 14:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfPsw-0005X8-U8
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 14:46:34 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfPsm-0001dp-5b
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 14:46:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A85C52270B;
 Wed, 28 Feb 2024 19:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709149580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLFAs6Np0eor8BWmwiyz8dg3wut/IEC0sVrm1PmsVAA=;
 b=Q/UB1XiS/cbsPVqBxuZhzYgZ2ptsJlHbnBbvaaJgsMy9Fq2OAfELzSiFKVxw9SDKR5KcFz
 Argspd2ixIxir49tm0TCyl8zHtL2Hun/Et6+iwwTyGS7xJCDJwldm7c7BOf/ozhZ1YYf3Q
 eBAqwXhhIM+IAj/hxKXiH0rslbKSX08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709149580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLFAs6Np0eor8BWmwiyz8dg3wut/IEC0sVrm1PmsVAA=;
 b=+DbD200hKr+lxk9EESmElFvuw5ge5ryuiMCQNGmJGlTI5H1SiXKvuRCidduy2IG7E06t1T
 pjtxLO29Lg1BozBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709149580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLFAs6Np0eor8BWmwiyz8dg3wut/IEC0sVrm1PmsVAA=;
 b=Q/UB1XiS/cbsPVqBxuZhzYgZ2ptsJlHbnBbvaaJgsMy9Fq2OAfELzSiFKVxw9SDKR5KcFz
 Argspd2ixIxir49tm0TCyl8zHtL2Hun/Et6+iwwTyGS7xJCDJwldm7c7BOf/ozhZ1YYf3Q
 eBAqwXhhIM+IAj/hxKXiH0rslbKSX08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709149580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLFAs6Np0eor8BWmwiyz8dg3wut/IEC0sVrm1PmsVAA=;
 b=+DbD200hKr+lxk9EESmElFvuw5ge5ryuiMCQNGmJGlTI5H1SiXKvuRCidduy2IG7E06t1T
 pjtxLO29Lg1BozBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 302C013A5D;
 Wed, 28 Feb 2024 19:46:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3aG4OYuN32XAPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Feb 2024 19:46:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v3 2/7] migration/multifd: Implement zero page
 transmission on the multifd thread.
In-Reply-To: <20240226195654.934709-3-hao.xiang@bytedance.com>
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
 <20240226195654.934709-3-hao.xiang@bytedance.com>
Date: Wed, 28 Feb 2024 16:46:17 -0300
Message-ID: <878r34qsmu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Q/UB1XiS";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+DbD200h
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL9pwd6yriz4g6gm1w7u8hak7u)];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FREEMAIL_TO(0.00)[bytedance.com,redhat.com,habkost.net,gmail.com,linaro.org,huawei.com,nongnu.org];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[15];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 SUSPICIOUS_RECIPS(1.50)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: A85C52270B
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> 1. Add zero_pages field in MultiFDPacket_t.
> 2. Implements the zero page detection and handling on the multifd
> threads for non-compression, zlib and zstd compression backends.
> 3. Added a new value 'multifd' in ZeroPageDetection enumeration.
> 4. Handle migration QEMU9.0 -> QEMU8.2 compatibility.
> 5. Adds zero page counters and updates multifd send/receive tracing
> format to track the newly added counters.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  hw/core/machine.c                |  4 +-
>  hw/core/qdev-properties-system.c |  2 +-
>  migration/meson.build            |  1 +
>  migration/multifd-zero-page.c    | 78 ++++++++++++++++++++++++++++++
>  migration/multifd-zlib.c         | 21 ++++++--
>  migration/multifd-zstd.c         | 20 ++++++--
>  migration/multifd.c              | 83 +++++++++++++++++++++++++++-----
>  migration/multifd.h              | 24 ++++++++-
>  migration/ram.c                  |  1 -
>  migration/trace-events           |  8 +--
>  qapi/migration.json              |  5 +-
>  11 files changed, 214 insertions(+), 33 deletions(-)
>  create mode 100644 migration/multifd-zero-page.c
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index fb5afdcae4..746da219a4 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -32,7 +32,9 @@
>  #include "hw/virtio/virtio-net.h"
>  #include "audio/audio.h"
>  
> -GlobalProperty hw_compat_8_2[] = {};
> +GlobalProperty hw_compat_8_2[] = {
> +    { "migration", "zero-page-detection", "legacy"},
> +};
>  const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
>  
>  GlobalProperty hw_compat_8_1[] = {
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 228e685f52..6e6f68ae1b 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -682,7 +682,7 @@ const PropertyInfo qdev_prop_mig_mode = {
>  const PropertyInfo qdev_prop_zero_page_detection = {
>      .name = "ZeroPageDetection",
>      .description = "zero_page_detection values, "
> -                   "none,legacy",
> +                   "none,legacy,multifd",
>      .enum_table = &ZeroPageDetection_lookup,
>      .get = qdev_propinfo_get_enum,
>      .set = qdev_propinfo_set_enum,
> diff --git a/migration/meson.build b/migration/meson.build
> index 92b1cc4297..1eeb915ff6 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -22,6 +22,7 @@ system_ss.add(files(
>    'migration.c',
>    'multifd.c',
>    'multifd-zlib.c',
> +  'multifd-zero-page.c',
>    'ram-compress.c',
>    'options.c',
>    'postcopy-ram.c',
> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
> new file mode 100644
> index 0000000000..1650c41b26
> --- /dev/null
> +++ b/migration/multifd-zero-page.c
> @@ -0,0 +1,78 @@
> +/*
> + * Multifd zero page detection implementation.
> + *
> + * Copyright (c) 2024 Bytedance Inc
> + *
> + * Authors:
> + *  Hao Xiang <hao.xiang@bytedance.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> +#include "exec/ramblock.h"
> +#include "migration.h"
> +#include "multifd.h"
> +#include "options.h"
> +#include "ram.h"
> +
> +static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
> +{
> +    ram_addr_t temp;
> +
> +    if (a == b) {
> +        return;
> +    }
> +
> +    temp = pages_offset[a];
> +    pages_offset[a] = pages_offset[b];
> +    pages_offset[b] = temp;
> +}
> +
> +/**
> + * multifd_zero_page_check_send: Perform zero page detection on all pages.
> + *
> + * Sort the page offset array by moving all normal pages to
> + * the left and all zero pages to the right of the array.

Let's move this to the loop as a comment. Here it's better to just
inform about the side effects:

Sorts normal pages before zero pages in p->pages->offset and updates
p->pages->normal_num.

> + *
> + * @param p A pointer to the send params.
> + */
> +void multifd_zero_page_check_send(MultiFDSendParams *p)

Use multifd_send_zero_page_check for consistency with the rest of the code.

> +{
> +    /*
> +     * QEMU older than 9.0 don't understand zero page
> +     * on multifd channel. This switch is required to
> +     * maintain backward compatibility.
> +     */
> +    bool use_multifd_zero_page =
> +        (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_MULTIFD);

Could introduce a helper for this.

static bool multifd_zero_page(void)
{
    return migrate_zero_page_detection() == ZERO_PAGE_DETECTION_MULTIFD;
}

> +    MultiFDPages_t *pages = p->pages;
> +    RAMBlock *rb = pages->block;
> +    int index_normal = 0;
> +    int index_zero = pages->num - 1;

IMHO, i and j are more idiomatic, makes the code easier on the eyes.

> +
> +    while (index_normal <= index_zero) {
> +        uint64_t offset = pages->offset[index_normal];
> +        if (use_multifd_zero_page &&

You don't need to check this at every iteration. Could check at the top
and exit right away.

> +            buffer_is_zero(rb->host + offset, p->page_size)) {
> +            swap_page_offset(pages->offset, index_normal, index_zero);
> +            index_zero--;
> +            ram_release_page(rb->idstr, offset);
> +        } else {
> +            index_normal++;
> +            pages->normal_num++;

Not a fan of changing pages->normal_num like this. Let's make the loop
just sort and update normal_num at the end.

Putting all together:

void multifd_send_zero_page_check(MultiFDSendParams *p)
{
    MultiFDPages_t *pages = p->pages;
    RAMBlock *rb = pages->block;
    int i = 0;
    int j = pages->num - 1;

    if (!multifd_zero_page()) {
        pages->normal_num = pages->num;
        return;
    }

    /*
     * Sort the offsets array by moving all normal pages to the start
     * and all zero pages to the end of the array.
     */
    while (i <= j) {
        uint64_t offset = pages->offset[i];

        if (!buffer_is_zero(rb->host + offset, p->page_size)) {
            i++;
            continue;
        }

        swap_page_offset(pages->offset, i, j);
        ram_release_page(rb->idstr, offset);
        j--;
    }

    pages->normal_num = i;
}

> +        }
> +    }
> +}
> +
> +void multifd_zero_page_check_recv(MultiFDRecvParams *p)
> +{
> +    for (int i = 0; i < p->zero_num; i++) {
> +        void *page = p->host + p->zero[i];
> +        if (!buffer_is_zero(page, p->page_size)) {
> +            memset(page, 0, p->page_size);
> +        }
> +    }
> +}

