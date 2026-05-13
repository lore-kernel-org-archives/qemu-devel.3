Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDEACD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 20:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNGMn-00087u-9f; Wed, 13 May 2026 16:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNGMl-00087a-4x
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNGMi-00020q-7i
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778704775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KMkD/EIZdjtKBpU+nyYIZj3ebl6zEZidg0QrBEr2nNY=;
 b=cWssfPFJj3nLxI73n0xRFTOaHH5Hd4xSv1/W8Iyg8USWoTdZAKbItgw961WMhK0bwnVlDx
 d9M4DOdcBss9eHrgxJ9tiVDGahGjoyUQUQAsDjVaReSoUMWas1D4Vjd7TK2DGtwuuY2YEc
 ivTMAqj6l05PoNJjVahzei7Ur2KIhEI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-2oQDcn3pOba4g2M0-avQGg-1; Wed, 13 May 2026 16:39:33 -0400
X-MC-Unique: 2oQDcn3pOba4g2M0-avQGg-1
X-Mimecast-MFC-AGG-ID: 2oQDcn3pOba4g2M0-avQGg_1778704773
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fb3c7b989so112398991cf.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 13:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778704773; x=1779309573; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KMkD/EIZdjtKBpU+nyYIZj3ebl6zEZidg0QrBEr2nNY=;
 b=PtsY9nXN56378TEUkReVoRXWQDXtYs9c1EwA498GKmIyYEBP0+7m1vD5nTKf1w3rb9
 cBjQApC+i/BeAOLfD3s7K/WtJfUHD+NB85R6s/z0opTWE4cPgaTfA1DxfaxdWLaFGO/H
 wcYc8WGR+IxVXZNHEkskZIJaYdLW+wVznPjGCN6NFzBnT/kTUuzMcCwLdfz4fyEG0zNq
 sllBjkuuBT7NEXfftLBVHtvsP/M+Zi8a8jWhs1o5xsXDPYjJYkNFAR4FFnYOuoRsWXUY
 QfPgwG8yQJiGo3xJBEwQvwK+C+Jxwy3m189Xh+K2ll2hMG+E9yNPuKk2zviQNGELkxGc
 y90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778704773; x=1779309573;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KMkD/EIZdjtKBpU+nyYIZj3ebl6zEZidg0QrBEr2nNY=;
 b=jZZ1WfsPyGhEhtPokqlVjCuuyOK3cak0Of4+SDJ3t/NffH3s0tE3F9W4rLK01aStkB
 OfsFvIG8pggvMBBlhTUFD4nTsWmKH548cjUpTBk/4ffKq65c/gQ+ycWFd8RIu2gAAqO1
 LTwmoI9FzoJ+n2it8Vc13nMrLw5OtG4ZgIFYb4pQ8/xj0jNfV8Q7tJrO64yjuLigrYI+
 xEr6YPnKc13W9v9UvtqJn6gKCYTjURxVUeEq4aE8DrBnUNpJO+sxeYkn7+438vMBVvH+
 jKSfEhZ/00GITt/wun8k/DZJZ+tufbDYfwyIp0ygk1MzJ29xwLq0e0qUEHTayAHHSKOi
 FQmg==
X-Gm-Message-State: AOJu0YwxOFphIwZojWGUYAX6eTQFupMvuQkXBkH+wff8YLHR+yAFOs7M
 GaP411iHQ3EZpNRhiaB1dFIR3XmJYaQQBoRTfYo4IcWm5jhtUkH+xCSwaQHeubMDRDQyK58TiH8
 LiA57++oQ/3BZUxyxwFU0W/sJyz4lp+0u62VHCizxpDoWyY+DNTFpZAXl
X-Gm-Gg: Acq92OFwnACatIC9NWCJzZvOwFvDXSVMAhN5JGmSbn9et+p+FlEb5XGst3HdKSb+Aed
 jR8gzptAU3lNdWjCeIe9mrtToGF1WwPmLn2EO8xYbM1fW9VV/XEN5TUcT5deIMFjnH0MpbDIXDI
 b8FaUXNRFELEePFSooBx2YYGv4x0DDOa9cUvZT+lwkML9t9KVeSYA9+sQkC4MnBJ4OTOeaJHKGn
 t6+l1FmTfuFgKZ+lsCSWviJXb+mdubE7LVOxiFmimHes3qtBwxhH8pw9qQE1hjof5cIgYj9Cp6U
 2RxNXoYgckHjaLfA+m7yZZ+KM+jNIqt38pqKqlEfY0z6+x6/QSxH3w0RzkQ6+Glc2P9xmoq7ons
 JY8nqGjjhNdPRiyMwNbHr/mCK6LktULKy4r5GRvmcknj9QQc=
X-Received: by 2002:ac8:594c:0:b0:514:d48c:f69f with SMTP id
 d75a77b69052e-5162f5eae22mr67346371cf.51.1778704773048; 
 Wed, 13 May 2026 13:39:33 -0700 (PDT)
X-Received: by 2002:ac8:594c:0:b0:514:d48c:f69f with SMTP id
 d75a77b69052e-5162f5eae22mr67345841cf.51.1778704772426; 
 Wed, 13 May 2026 13:39:32 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c908f0cdf0sm5848226d6.18.2026.05.13.13.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:39:31 -0700 (PDT)
Date: Wed, 13 May 2026 16:39:30 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v4 12/13] monitor: add 'info ramblock-attributes' command
Message-ID: <agThgiOYAYujkWul@x1.local>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-12-bdf61e57c1e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504-rdm5-v4-12-bdf61e57c1e1@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 04, 2026 at 04:30:18PM +0400, Marc-André Lureau wrote:
> Add a new 'info ramblock-attributes' HMP command and the corresponding
> 'x-query-ramblock-attributes' QMP command to display the shared/private
> memory attributes for ram blocks.
> 
> The QMP command returns structured data (RamBlockAttributesInfo list
> with per-range shared/populated attributes), while HMP formats it for
> human consumption.
> 
> This is useful for debugging confidential guests (TDX, SNP) to inspect
> which memory regions are shared vs private, and their population state
> when a RamDiscardManager is present (e.g. virtio-mem).
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Nobody is copied on this patch..  Let me add Markus and Dave at minimum..

Only one trivial question below:

> ---
>  qapi/machine.json             | 55 +++++++++++++++++++++++++++++++++
>  include/monitor/hmp.h         |  1 +
>  hw/core/machine-hmp-cmds.c    | 32 +++++++++++++++++++
>  system/ram-block-attributes.c | 72 +++++++++++++++++++++++++++++++++++++++++++
>  hmp-commands-info.hx          | 13 ++++++++
>  5 files changed, 173 insertions(+)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 685e4e29b87..aac8a235cf6 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1738,6 +1738,61 @@
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ] }
>  
> +##
> +# @RamBlockAttributeRange:
> +#
> +# A contiguous range within a ram block with uniform attributes.
> +#
> +# @start: start offset in bytes within the ram block
> +#
> +# @length: length in bytes of the range
> +#
> +# @shared: true if the range is shared, false if private
> +#
> +# @populated: true if the range is populated (only present when a
> +#     RamDiscardManager is managing the block)
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'RamBlockAttributeRange',
> +  'data': { 'start': 'uint64',
> +            'length': 'uint64',
> +            'shared': 'bool',
> +            '*populated': 'bool' } }
> +
> +##
> +# @RamBlockAttributesInfo:
> +#
> +# Shared/private memory attributes for a ram block.
> +#
> +# @name: the ram block identifier
> +#
> +# @ranges: list of attribute ranges
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'RamBlockAttributesInfo',
> +  'data': { 'name': 'str',
> +            'ranges': [ 'RamBlockAttributeRange' ] } }
> +
> +##
> +# @x-query-ramblock-attributes:
> +#
> +# Query ram block shared/private attributes.  This is useful
> +# to debug confidential guests.
> +#
> +# Features:
> +#
> +# @unstable: This command is meant for debugging.
> +#
> +# Returns: list of ram block attributes
> +#
> +# Since: 11.1
> +##
> +{ 'command': 'x-query-ramblock-attributes',
> +  'returns': [ 'RamBlockAttributesInfo' ],
> +  'features': [ 'unstable' ] }
> +
>  ##
>  # @x-query-roms:
>  #
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index e222bea60cd..4493952b417 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -143,6 +143,7 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict);
>  void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
>  void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
> +void hmp_info_ramblock_attributes(Monitor *mon, const QDict *qdict);
>  void hmp_info_replay(Monitor *mon, const QDict *qdict);
>  void hmp_replay_break(Monitor *mon, const QDict *qdict);
>  void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index 46846f741a2..122e1a0f735 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -24,6 +24,7 @@
>  #include "qapi/string-output-visitor.h"
>  #include "qemu/error-report.h"
>  #include "system/numa.h"
> +#include "system/ramblock.h"
>  #include "hw/core/boards.h"
>  
>  void hmp_info_cpus(Monitor *mon, const QDict *qdict)
> @@ -388,3 +389,34 @@ void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
>      }
>      hmp_handle_error(mon, err);
>  }
> +
> +void hmp_info_ramblock_attributes(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +    g_autoptr(RamBlockAttributesInfoList) list = NULL;
> +    RamBlockAttributesInfoList *it;
> +
> +    list = qmp_x_query_ramblock_attributes(&err);
> +    if (hmp_handle_error(mon, err)) {
> +        return;
> +    }
> +
> +    for (it = list; it; it = it->next) {
> +        RamBlockAttributesInfo *rba = it->value;
> +        RamBlockAttributeRangeList *r;
> +
> +        monitor_printf(mon, "%s:\n", rba->name);
> +        for (r = rba->ranges; r; r = r->next) {
> +            RamBlockAttributeRange *range = r->value;
> +            const char *shared = range->shared ? "shared" : "private";
> +            const char *pop = range->has_populated ?
> +                (range->populated ? "+populated" : "-populated") : "";
> +
> +            monitor_printf(mon,
> +                           "  0x%016" PRIx64 "-0x%016" PRIx64 " %s%s\n",
> +                           range->start,
> +                           range->start + range->length - 1,
> +                           shared, pop);
> +        }
> +    }
> +}
> diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
> index 59ec7a28eb0..f9573801b60 100644
> --- a/system/ram-block-attributes.c
> +++ b/system/ram-block-attributes.c
> @@ -11,6 +11,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qapi/qapi-commands-machine.h"
>  #include "system/ramblock.h"
>  #include "trace.h"
>  
> @@ -221,3 +222,74 @@ static void ram_block_attributes_class_init(ObjectClass *klass,
>      rdsc->get_min_granularity = ram_block_attributes_rds_get_min_granularity;
>      rdsc->is_populated = ram_block_attributes_rds_is_populated;
>  }
> +
> +RamBlockAttributesInfoList *qmp_x_query_ramblock_attributes(Error **errp)
> +{
> +    RamBlockAttributesInfoList *head = NULL, **tail = &head;
> +    RAMBlock *block;
> +    size_t rba_block_size = ram_block_attributes_get_block_size();
> +
> +    RCU_READ_LOCK_GUARD();
> +
> +    RAMBLOCK_FOREACH(block) {
> +        RamBlockAttributesInfo *rba;
> +        RamBlockAttributeRangeList **range_tail;
> +        RamBlockAttributes *attr = block->attributes;
> +        RamDiscardManager *rdm;
> +        bool has_rdm;
> +        unsigned long pos;
> +
> +        if (!attr) {
> +            continue;
> +        }
> +
> +        rdm = memory_region_get_ram_discard_manager(block->mr);
> +        has_rdm = rdm != NULL;
> +
> +        rba = g_new0(RamBlockAttributesInfo, 1);
> +        rba->name = g_strdup(block->idstr);
> +        range_tail = &rba->ranges;
> +
> +        pos = 0;
> +        while (pos < attr->bitmap_size) {
> +            bool is_shared = test_bit(pos, attr->bitmap);
> +            unsigned long next;
> +            uint64_t start_offset, length;
> +            RamBlockAttributeRange *range;
> +
> +            if (is_shared) {
> +                next = find_next_zero_bit(attr->bitmap,
> +                                          attr->bitmap_size, pos);
> +            } else {
> +                next = find_next_bit(attr->bitmap,
> +                                     attr->bitmap_size, pos);
> +            }
> +
> +            start_offset = (uint64_t)pos * rba_block_size;
> +            length = (uint64_t)(next - pos) * rba_block_size;
> +
> +            range = g_new0(RamBlockAttributeRange, 1);
> +            range->start = start_offset;
> +            range->length = length;
> +            range->shared = is_shared;
> +
> +            if (has_rdm) {

Is this only for extra safety?  My understanding is when reaching here,
attr!=NULL, which means we have at least one disgard manager source, then
the manager must be there.  So I wonder if we could assert.  But not a big
deal. Maybe I overlooked that it is needed?

> +                MemoryRegionSection section = {
> +                    .mr = block->mr,
> +                    .offset_within_region = start_offset,
> +                    .size = int128_make64(length),
> +                };
> +                range->has_populated = true;
> +                range->populated =
> +                    ram_discard_manager_is_populated(rdm, &section);
> +            }
> +
> +            QAPI_LIST_APPEND(range_tail, range);
> +            pos = next;
> +        }
> +
> +        QAPI_LIST_APPEND(tail, rba);
> +    }
> +
> +    return head;
> +}
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 74c741f80e2..1168b4c20ca 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -774,6 +774,19 @@ SRST
>      Dump all the ramblocks of the system.
>  ERST
>  
> +    {
> +        .name       = "ramblock-attributes",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "Display ramblock shared/private attributes",
> +        .cmd        = hmp_info_ramblock_attributes,
> +    },
> +
> +SRST
> +  ``info ramblock-attributes``
> +    Display the shared/private memory attributes for ram blocks.
> +ERST
> +
>      {
>          .name       = "hotpluggable-cpus",
>          .args_type  = "",
> 
> -- 
> 2.54.0
> 
> 

-- 
Peter Xu


