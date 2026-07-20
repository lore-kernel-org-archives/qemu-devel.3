Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EFCC44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wltcB-00064o-M1; Mon, 20 Jul 2026 15:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wltc5-00061v-PE
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wltc3-0000Sc-NM
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784575513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JhY0/mudAdMbBHB1coTzE3FhoqTGZTuNBpQmaQiDhRs=;
 b=MbnZgvTzejmw78Br2ngHbdfQPaXWNKXUrFSB7q1XUSiBoIBYZZOsqFu2qJiO3xAPi/jcqm
 CXaZA5dhy+vmHGxP2w4GWipfvya2rLbnkM59P+M7iMsW8WYXp1WZPCL1nnbksDQgqrImnY
 HkOoMzllHLJ6DXarv+0PG9fYIvQEr4Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-r63diIddM5SZfdg2r3XNvg-1; Mon, 20 Jul 2026 15:25:12 -0400
X-MC-Unique: r63diIddM5SZfdg2r3XNvg-1
X-Mimecast-MFC-AGG-ID: r63diIddM5SZfdg2r3XNvg_1784575512
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-904dac0f77fso196248696d6.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784575512; x=1785180312; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JhY0/mudAdMbBHB1coTzE3FhoqTGZTuNBpQmaQiDhRs=;
 b=VemyBVJ72n1bxaTsfdh1M1jWWHLGiAnjE0x4rTLHHOkeAuXr9jMAIwQ1xi6Hto/JOd
 LEdw0cZDBQJXtX8RkERb9wJ5M9avA7sZ0Y2UNUaZeHRY7i1ZDbbHhIva6eCrxhyNu9Oi
 hkWmUay8DEKmEILBRvhIMJ5MCaVELaRyETyXs8UhjnNrS4H85kPgVj+DO5SHYLPg/nbV
 Xz/dutEdgRUYoM0jTv7WD8yBOf8QW9Jkm+OopA7IdkZaavL8bqYxv+YLLWWRIrHSIjD/
 kLU+A6OQ1kZTAiRvkHL0InH+VOCoLGW+zMx5bboQbEy2mWRiLsKeIjhOJwG1N8m53X1g
 +b1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784575512; x=1785180312;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JhY0/mudAdMbBHB1coTzE3FhoqTGZTuNBpQmaQiDhRs=;
 b=DTpwSEstC1fuiEMKoYFHhNss6VQxWFEKHQGsQZQQU+CbvWzzukeuzsRqlIRGf8o0+c
 2ZWm9Uso89UYAWKDqm+PNo6pt9YYldt8EpQx6JlypkqSwKwzCv5c4tee/b/8NKrzrcH+
 NJvrW9fiS9bikbzzkhChBJLgSClv4Pbi8aeJeqz/8UI4JewcI5VdJO5uH/fQY4Z+xkze
 SxswUmUtF2tUmY/D/SVAN0xfG48iuQw57ynGVhxBLebMFXl8yzJ418QIwfXpsrfeOYJ5
 TCQZ/TI2if7gUEf9/K58hjCYCFFVkANjczM4j0eAYstrPDSYES78Qboorq44GKnn1lKW
 yZ6A==
X-Gm-Message-State: AOJu0YzqH9gUkaxvM03A/rqJcNDWrZD84Yz851slFxIbJt8DTiHetzZw
 BLD4M/JZvCR1LHJtDvlHHZ/3cYAAHwjbgVbdVeArZgG5oiK7U8+8xD5VTTGV8nSfyZWX6NWAlX/
 kARg6OJCMqKJEtcg5OsAJYZiZcwAaMVM4RrrP5aXwcKqTKS75UeUp5gn7
X-Gm-Gg: AR+sD11ZAChnRozDWr9DFvQNViTnlXjMC+i9TjAIWp40mElYxMUYyV4SMLXLkzwBZqR
 dPjWCkMlADhE6JQ/aJz3oKjHMJZjPFTszBpANzLwe6Qf8pqCYIdSkZcWor/R+OiUlwxekCsZz6m
 hqlIbJRgsL1IPvi7dFCLANmuqLdKtWM2gyv7hi5JZMpsuqOooqeSmGhqkcaFeHsVozcbvAWxROV
 nmBSpa9MizA4AujfrBCHphDQ7vWPpr91I21ucQg89MH1yh1Ihrc4N1GJteJbR6/6kiuFzJTOCu+
 tfphUIfCZVOLJqtzZC3QzNhmZTWCz1e+NjSpSj0MoH8Kyi5Z1aQ0gPQvUa9JXFRSQVx8
X-Received: by 2002:a05:6214:3207:b0:8cc:ea95:2261 with SMTP id
 6a1803df08f44-9077850c1f7mr175398486d6.36.1784575511485; 
 Mon, 20 Jul 2026 12:25:11 -0700 (PDT)
X-Received: by 2002:a05:6214:3207:b0:8cc:ea95:2261 with SMTP id
 6a1803df08f44-9077850c1f7mr175397756d6.36.1784575510787; 
 Mon, 20 Jul 2026 12:25:10 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907786acb67sm98290406d6.32.2026.07.20.12.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 12:25:10 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:24:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v3 00/11] migration: fast snapshot load
Message-ID: <al52Cyl6CMdxTJW3@x1.local>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714141547.1268000-1-aadeshveer07@gmail.com>
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 14, 2026 at 07:45:36PM +0530, Aadeshveer Singh wrote:
> This series implements a "fast snapshot load" mechanism to
> significantly reduce the perceived resume time of a VM from a snapshot
> file.
> 
> Currently, resuming a VM from a snapshot file requires loading all RAM
> pages into the QEMU instance before execution begins. This extension
> allows the user to run the VM nearly instantly by loading only the
> required device states up front and loading RAM pages lazily, by
> trapping access to pages that have not yet been loaded.
> 
> Using the Linux userfaultfd syscall, a fault thread catches all page
> faults caused by the guest and loads in the pages required to keep
> the VM running. Concurrently, an eager background thread iteratively
> loads all remaining pages into RAM so the guest does not have to
> depend on the fault thread indefinitely.
> 
> Much of code is reused from postcopy for fault handling and precopy
> for reading mapped ram file. Implementation revolves around two
> threads named the fault thread and eager load thread. Fault thread as
> name suggests catches page faults by the guest and serves them using
> userfaultfd. Postcopy fault thread is reused but instead of requesting
> source for a page it loads the page directly by reading from file. In
> order to remove the dependency of guest on fault thread indefinitely
> the eager load thread loads in the entire RAM sequentially, and after
> iterating through the entire RAM signals fault thread to exit and
> calls cleanup.
> 
> In order to prevent the case of a page being loaded twice(in the
> case when eager load thread is loading it and fault thread also
> tries to serve fault on same page) a bitmap called pending_bmap is
> used to track pages which are pending and not being loaded by any
> thread. Atomic operations on this bitmap allows coordination between
> threads to prevent any unwanted behaviours
> 
> Future direction:
> - Add support for multifd
> - Add support for vhost-user

Please always still at least have a section for testing.  It's an important
piece of information on what you have tested (and what you have not, which
can also be included when it may matter).

For example, I know you should have tested at least normal and some huge
page setup, you can list them there.  You can also mention if you only
tested x86_64, or if you have played with anything else; logically this
should also work elsewhere whenever all facilities are available.  It's
fine to only test on x86_64, though.

Thanks,

> 
> ---
> v1 -> v2
> 
> - Structure Change: Expanded from 7 to 11 patches
> - Move test removal patch from first to post implementation as
>   suggested by Peter
> - Patch 1 to 5 are meant to be non functional changes meant to
>   modernize parts of code and prepare for feature Implementation
> - Patch 10 performs a smoke test for implemented feature
> - Patch 11 adds a documentation page for fast snapshot load
> - Added explicit fails for features not supported/incompatible with
>   fast snapshot load in compatibility check in options.c as suggested
>   by Peter
> - Passed errp object to qemu_get_buffer_at() to improve on error
>   reporting as suggested by Peter
> - Size of pending_bmap is updated to have a bit for every guest page
>   according to guest page size and not host page size as pointed
>   by Peter
> - New function(ramblock_file_bitmap_page_is_nonzero()) has been
>   introduced to test for zero pages while loading essentially enableing
>   support for hugepages
> - Updated the documentation comment over postcopy_mapped_ram_load_page()
>   to add errp as pointed by Peter
> - Added a new function try_mark_postcopy_blocktime_begin() to call
>   mark_postcopy_blocktime_begin() taking care of assumptions like
>   skipping if page is already received to improve on the readability
>   as pointed by Peter
> - Fixed bug, that sent non page alined addresses to
>   mark_postcopy_blocktime_begin() as pointed by Peter
> - Separate the postcopy_listen_thread_bh() rename patch as suggested
>   by Peter
> - Add comment explaining changes in process_incoming_migration_co()
>   as suggested by Peter
> - Make qemu_loadvm_run_fast_snapshot_load() and
>   postcopy_ram_eager_load_setup() return void as these functions
>   never fail as pointed by Peter
> 
> Aadeshveer Singh (11):
>   migration: Propagate error in postcopy setup functions
>   migration: Extract blocktime marking helper
>   migration: Rename postcopy_listen_thread_bh
>   migration: Use file_bmap for RAMBlock during incoming file load
>   migration: Make qemu_get_buffer_at() thread-safe
>   migration: add RAMBlock field and helper for fast snapshot load
>   migration: add support for fault thread to load pages from disk
>   migration: add eager load thread and setup for fast snapshot load
>   migration/tests: remove capability conflict test
>     postcopy-ram+mapped-ram
>   migration/tests: Add test for fast snapshot load
>   docs/migration: Add documentation for fast snapshot load feature
> 
>  docs/devel/migration/fast-snapshot-load.rst |  81 ++++++
>  docs/devel/migration/features.rst           |   1 +
>  include/system/ramblock.h                   |   6 +
>  migration/migration.c                       |  60 +++--
>  migration/migration.h                       |   5 +
>  migration/options.c                         |  14 +-
>  migration/postcopy-ram.c                    | 266 ++++++++++++++++----
>  migration/postcopy-ram.h                    |   7 +-
>  migration/qemu-file.c                       |   9 +-
>  migration/qemu-file.h                       |   4 +-
>  migration/ram.c                             | 103 +++++++-
>  migration/ram.h                             |   2 +
>  migration/savevm.c                          |  16 ++
>  migration/savevm.h                          |   2 +
>  migration/trace-events                      |   2 +
>  tests/qtest/migration/file-tests.c          |  24 ++
>  tests/qtest/migration/misc-tests.c          |  52 ----
>  17 files changed, 511 insertions(+), 143 deletions(-)
>  create mode 100644 docs/devel/migration/fast-snapshot-load.rst
> 
> -- 
> 2.55.0
> 

-- 
Peter Xu


