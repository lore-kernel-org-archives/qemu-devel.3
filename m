Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618E0C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 07:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFTpm-0008Dv-2j; Fri, 07 Jun 2024 03:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sFTpk-0008DN-7k
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 03:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sFTph-0000oj-TF
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 03:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717744576;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vaXYUnY61zb0AJ3NBZdtXr+ckRjsDsILjoYZENjx+E4=;
 b=JMrpvXLckmVhGI9RHl9QexetX7Zbl3EiQFGIGCv7mBxNlj+Fiju76eh5OJjsODbxkizfY3
 pKgD9iDZFZlQ8qh+CG4Zt1Myt30mkIbdNDTmg+eHgNmAuQRya11tZbc2p8A/JMco2m1ZH+
 30YLyW09L5BpQgI2fmJgJJz8ms3vy9Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-6Bg05v9cNT-ZLu2sIssuHA-1; Fri, 07 Jun 2024 03:16:11 -0400
X-MC-Unique: 6Bg05v9cNT-ZLu2sIssuHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8B6A101A520;
 Fri,  7 Jun 2024 07:16:10 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39753C04321;
 Fri,  7 Jun 2024 07:16:09 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:16:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Don Porter <porter@cs.unc.edu>
Cc: qemu-devel@nongnu.org, dave@treblig.org, peter.maydell@linaro.org,
 nadav.amit@gmail.com, richard.henderson@linaro.org, philmd@linaro.org
Subject: Re: [PATCH v3 1/6] Add an "info pg" command that prints the current
 page tables
Message-ID: <ZmKzqB6k2p4OUwpN@redhat.com>
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-2-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240606140253.2277760-2-porter@cs.unc.edu>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jun 06, 2024 at 10:02:48AM -0400, Don Porter wrote:
> The new "info pg" monitor command prints the current page table,
> including virtual address ranges, flag bits, and snippets of physical
> page numbers.  Completely filled regions of the page table with
> compatible flags are "folded", with the result that the complete
> output for a freshly booted x86-64 Linux VM can fit in a single
> terminal window.  The output looks like this:
> 
> VPN range             Entry         Flags            Physical page
> [7f0000000-7f0000000] PML4[0fe]     ---DA--UWP
>   [7f28c0000-7f28fffff]  PDP[0a3]     ---DA--UWP
>     [7f28c4600-7f28c47ff]  PDE[023]     ---DA--UWP
>       [7f28c4655-7f28c4656]  PTE[055-056] X--D---U-P 0000007f14-0000007f15
>       [7f28c465b-7f28c465b]  PTE[05b]     ----A--U-P 0000001cfc
> ...
> [ff8000000-ff8000000] PML4[1ff]     ---DA--UWP
>   [ffff80000-ffffbffff]  PDP[1fe]     ---DA---WP
>     [ffff81000-ffff81dff]  PDE[008-00e] -GSDA---WP 0000001000-0000001dff
>   [ffffc0000-fffffffff]  PDP[1ff]     ---DA--UWP
>     [ffffff400-ffffff5ff]  PDE[1fa]     ---DA--UWP
>       [ffffff5fb-ffffff5fc]  PTE[1fb-1fc] XG-DACT-WP 00000fec00 00000fee00
>     [ffffff600-ffffff7ff]  PDE[1fb]     ---DA--UWP
>       [ffffff600-ffffff600]  PTE[000]     -G-DA--U-P 0000001467
> 
> This draws heavy inspiration from Austin Clements' original patch.
> 
> This also adds a generic page table walker, which other monitor
> and execution commands will be migrated to in subsequent patches.
> 
> Signed-off-by: Don Porter <porter@cs.unc.edu>
> ---
>  hmp-commands-info.hx              |  13 ++
>  hw/core/cpu-sysemu.c              | 140 ++++++++++++
>  include/hw/core/cpu.h             |  34 ++-
>  include/hw/core/sysemu-cpu-ops.h  | 156 +++++++++++++
>  include/monitor/hmp-target.h      |   1 +
>  monitor/hmp-cmds-target.c         | 198 +++++++++++++++++
>  target/i386/arch_memory_mapping.c | 351 +++++++++++++++++++++++++++++-
>  target/i386/cpu.c                 |  11 +
>  target/i386/cpu.h                 |  15 ++
>  target/i386/monitor.c             | 165 ++++++++++++++
>  10 files changed, 1082 insertions(+), 2 deletions(-)
> +
> +void hmp_info_pg(Monitor *mon, const QDict *qdict)
> +{
> +    struct mem_print_state state;
> +
> +    CPUState *cs = mon_get_cpu(mon);
> +    if (!cs) {
> +        monitor_printf(mon, "Unable to get CPUState.  Internal error\n");
> +        return;
> +    }
> +
> +    CPUClass *cc = CPU_GET_CLASS(cs);
> +
> +    if ((!cc->sysemu_ops->pte_child)
> +        || (!cc->sysemu_ops->pte_leaf)
> +        || (!cc->sysemu_ops->pte_leaf_page_size)
> +        || (!cc->sysemu_ops->page_table_entries_per_node)
> +        || (!cc->sysemu_ops->pte_flags)
> +        || (!cc->sysemu_ops->mon_init_page_table_iterator)
> +        || (!cc->sysemu_ops->mon_info_pg_print_header)
> +        || (!cc->sysemu_ops->mon_flush_page_print_state)) {
> +        monitor_printf(mon, "Info pg unsupported on this ISA\n");
> +        return;
> +    }
> +
> +    if (!cc->sysemu_ops->mon_init_page_table_iterator(mon, &state)) {
> +        monitor_printf(mon, "Unable to initialize page table iterator\n");
> +        return;
> +    }
> +
> +    state.flush_interior = true;
> +    state.require_physical_contiguity = true;
> +    state.flusher = cc->sysemu_ops->mon_flush_page_print_state;
> +
> +    cc->sysemu_ops->mon_info_pg_print_header(mon, &state);
> +
> +    /*
> +     * We must visit interior entries to get the hierarchy, but
> +     * can skip not present mappings
> +     */
> +    for_each_pte(cs, &compressing_iterator, &state, true, false);
> +
> +    /* Print last entry, if one present */
> +    cc->sysemu_ops->mon_flush_page_print_state(cs, &state);
> +}

Please don't add new HMP commands that don't have a QMP
equivalent.

This should be adding an 'x-query-pg' QMP command, which
returns HumanReadableText, and then call that from the HMP

There is guidance on this here:

  https://www.qemu.org/docs/master/devel/writing-monitor-commands.html#writing-a-debugging-aid-returning-unstructured-text

If you need more real examples, look at the various
'x-query-XXXX' commands in qapi/machine.json  and
their impl.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


