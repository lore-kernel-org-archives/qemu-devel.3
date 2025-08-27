Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED061CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKfT-0005lv-Rz; Wed, 27 Aug 2025 14:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urKfQ-0005kN-MK
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urKfM-0003K9-ID
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756318470;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tn9DBNo8i3Db/v3WYlDOutG3keQInGDYgiTWwdXJzjE=;
 b=UFUZ/PvYhN8U0R5JxcAC7u34vosIHb2w+we6JAcojWgW1eDmKXuY1nPdt9n0zyMCyf4jIn
 k+FMkHn0rIXKht1sHKJU/UY/NOeYInRNGU49+XcT2Xt6vkhxnOB8MToFfutssCz9HS+SBv
 B0yyat6zQ2PzVfINodEzjD7tPJThLxY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-GzelnyaBO4KrKdBe_vU6Kw-1; Wed,
 27 Aug 2025 14:14:28 -0400
X-MC-Unique: GzelnyaBO4KrKdBe_vU6Kw-1
X-Mimecast-MFC-AGG-ID: GzelnyaBO4KrKdBe_vU6Kw_1756318467
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C03B4195609E; Wed, 27 Aug 2025 18:14:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4513195419F; Wed, 27 Aug 2025 18:14:24 +0000 (UTC)
Date: Wed, 27 Aug 2025 19:14:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>
Subject: Re: [PATCH] dump: enhance win_dump_available to report properly
Message-ID: <aK9K_SIcVBf_70gj@redhat.com>
References: <20250827-enhance-win-dump-avalaible-v2-v1-1-a6f359e9ff8e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250827-enhance-win-dump-avalaible-v2-v1-1-a6f359e9ff8e@virtuozzo.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Aug 27, 2025 at 04:15:27PM +0300, Nikolai Barybin wrote:
> QMP query-dump-guest-memory-capability reports win dump as available for
> any x86 VM, which is false.
> 
> This patch implements proper query of vmcoreinfo and calculation of
> guest note size. Based on that we can surely report whether win dump
> available or not.
> 
> To perform this I suggest to split dump_init() into dump_preinit() and
> dump_init_complete() to avoid exausting copypaste in
> win_dump_available().
> 
> For further reference one may review this libvirt discussion:
> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB
> [PATCH 0/4] Allow xml-configured coredump format on VM crash
> 
> Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
> ---
> During first series discussion Den mentions that that code will not work
> on 32bit guest with more than 4Gb RAM on i386.
> 
> This issue required even more code duplication between dump_init() and
> win_dump_available() which we'd like to avoid as mentioned by Daniel.
> 
> Hence I present 2nd version of this fix:
>  - split dump_init() into dump_preinit() and dump_init_complete()
>  - pass pre-inited dump structure with calculated guest note size to
>    win_dump_available()
>  - call header check and guest note size check inside
>    win_dump_available()
> ---
>  dump/dump.c     | 129 ++++++++++++++++++++++++++++++++------------------------
>  dump/win_dump.c |  23 ++++++++--
>  dump/win_dump.h |   2 +-
>  3 files changed, 95 insertions(+), 59 deletions(-)
> 
> diff --git a/dump/dump.c b/dump/dump.c
> index 15bbcc0c6192822cf920fcb7d60eb7d2cfad0952..19341fa42feef4d1c50dbb3a892ded59a3468d20 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -1777,10 +1777,7 @@ static void vmcoreinfo_update_phys_base(DumpState *s)
>      g_strfreev(lines);
>  }
>  
> -static void dump_init(DumpState *s, int fd, bool has_format,
> -                      DumpGuestMemoryFormat format, bool paging, bool has_filter,
> -                      int64_t begin, int64_t length, bool kdump_raw,
> -                      Error **errp)
> +static void dump_preinit(DumpState *s, Error **errp)
>  {
>      ERRP_GUARD();
>      VMCoreInfoState *vmci = vmcoreinfo_find();
> @@ -1788,16 +1785,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
>      int nr_cpus;
>      int ret;
>  
> -    s->has_format = has_format;
> -    s->format = format;
> -    s->written_size = 0;
> -    s->kdump_raw = kdump_raw;
> -
> -    /* kdump-compressed is conflict with paging and filter */
> -    if (has_format && format != DUMP_GUEST_MEMORY_FORMAT_ELF) {
> -        assert(!paging && !has_filter);
> -    }
> -
>      if (runstate_is_running()) {
>          vm_stop(RUN_STATE_SAVE_VM);
>          s->resume = true;
> @@ -1814,41 +1801,10 @@ static void dump_init(DumpState *s, int fd, bool has_format,
>          nr_cpus++;
>      }
>  
> -    s->fd = fd;
> -    if (has_filter && !length) {
> -        error_setg(errp, "parameter 'length' expects a non-zero size");
> -        goto cleanup;
> -    }
> -    s->filter_area_begin = begin;
> -    s->filter_area_length = length;
> -
> -    /* First index is 0, it's the special null name */
> -    s->string_table_buf = g_array_new(FALSE, TRUE, 1);
> -    /*
> -     * Allocate the null name, due to the clearing option set to true
> -     * it will be 0.
> -     */
> -    g_array_set_size(s->string_table_buf, 1);
> -
>      memory_mapping_list_init(&s->list);
> -
>      guest_phys_blocks_init(&s->guest_phys_blocks);
>      guest_phys_blocks_append(&s->guest_phys_blocks);
> -    s->total_size = dump_calculate_size(s);
> -#ifdef DEBUG_DUMP_GUEST_MEMORY
> -    fprintf(stderr, "DUMP: total memory to dump: %lu\n", s->total_size);
> -#endif
>  
> -    /* it does not make sense to dump non-existent memory */
> -    if (!s->total_size) {
> -        error_setg(errp, "dump: no guest memory to dump");
> -        goto cleanup;
> -    }
> -
> -    /* get dump info: endian, class and architecture.
> -     * If the target architecture is not supported, cpu_get_dump_info() will
> -     * return -1.
> -     */
>      ret = cpu_get_dump_info(&s->dump_info, &s->guest_phys_blocks);
>      if (ret < 0) {
>          error_setg(errp,
> @@ -1906,6 +1862,56 @@ static void dump_init(DumpState *s, int fd, bool has_format,
>          }
>      }
>  
> +    s->nr_cpus = nr_cpus;
> +    return;
> +cleanup:
> +    dump_cleanup(s);
> +}

The 'dump_cleanup' call is unsafe.

In qmp_query_dump_guest_memory_capability we initialize 's' using
'dump_state_prepare' which just zero's the struct, aside from
the 'status' field.

Meanwhile 'dump_cleanup' will unconditionally do:

    close(s->fd);

and 'fd' will be 0, as in stdin, so we break any usage of stdin
that QEMU has. Then some other unlucky part of QEMU will open a
FD and get given FD == 0, making things potentially even worse.

We need 'dump_state_prepare' to set 's->fd = -1', and in
dump_cleanup we should check for s->fd != -1, and after
closing it, must set it back to '-1'.

In fact, I think even the existing dump code is broken in
this respect, and so this should likely be a separate fix
we can send to stable.

I think the 'migrate_del_blocker' call in dump_cleanup
is potentially unsafe too, as it might try to delete a
blocker that is not registered.


> @@ -2215,6 +2224,14 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_memory_capability(Error **errp)
>                                    g_new0(DumpGuestMemoryCapability, 1);
>      DumpGuestMemoryFormatList **tail = &cap->formats;
>  
> +    DumpState *s = &dump_state_global;
> +    dump_state_prepare(s);

This is unsafe.

Consider we have 2 distinct monitor clients. One client is
in the middle of a dump operation, when another client calls
query-dump-guest-memory-capability - the latter will scribble
over state used by the former. We must use a local stack
allocated DumpState in this query command, instead of
dump_state_global.

> +    dump_preinit(s, errp);
> +    if (*errp) {
> +        qatomic_set(&s->status, DUMP_STATUS_FAILED);
> +        return cap;
> +    }
> +
>      /* elf is always available */
>      QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_ELF);
>  
> @@ -2234,9 +2251,11 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_memory_capability(Error **errp)
>      QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_SNAPPY);
>  #endif
>  
> -    if (win_dump_available(NULL)) {
> +    if (win_dump_available(s, NULL)) {
>          QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_WIN_DMP);
>      }
>  
> +    dump_cleanup(s);
> +    qatomic_set(&s->status, DUMP_STATUS_NONE);
>      return cap;
>  }

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


