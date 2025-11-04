Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D41CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJ2G-0006fn-MA; Tue, 04 Nov 2025 10:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGJ2F-0006fU-Eh
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:33:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGJ2D-0000MR-Kd
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762270404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ad14hvo+SJaqRHUupbQTrse567wztScwLFkzg5UVEIE=;
 b=iupZ3l1uduBnqLLs67neB4BlW7lxl1CjrojbJcnxdGj337lGNspes0JDFklmds8taaAbB7
 0kIqFbHMOs84FH3Kv4AenHI4D/xzjyC2EacIENz+gtA2aNeg3jJV+2epwp8s7gcFxapRhU
 +CgcCNi5PgCl2LgfJSptPX6yYnGk17U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-Bpy199oQMWmkqjv7WTqstg-1; Tue,
 04 Nov 2025 10:33:21 -0500
X-MC-Unique: Bpy199oQMWmkqjv7WTqstg-1
X-Mimecast-MFC-AGG-ID: Bpy199oQMWmkqjv7WTqstg_1762270400
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46CAA1935DC9; Tue,  4 Nov 2025 15:32:28 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.47])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B4711956056; Tue,  4 Nov 2025 15:32:25 +0000 (UTC)
Date: Tue, 4 Nov 2025 16:32:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Wesley Hershberger <wesley.hershberger@canonical.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2] block: Drop detach_subchain for bdrv_replace_node
Message-ID: <aQochxHPjtDr6Asz@redhat.com>
References: <20251029-third-fix-3149-v2-1-94932bb404f4@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-third-fix-3149-v2-1-94932bb404f4@canonical.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 29.10.2025 um 14:27 hat Wesley Hershberger geschrieben:
> Detaching filters using detach_subchain=true can cause segfaults as
> described in #3149.
> 
> More specifically, this was observed when executing concurrent
> block-stream and query-named-block-nodes. block-stream adds a
> copy-on-read filter as the main BDS for the blockjob; that filter was
> dropped with detach_subchain=true but not unref'd until the the blockjob
> was free'd. Because query-named-block-nodes assumes that a filter will
> always have exactly one child, it caused a segfault when it observed the
> detached filter. Stacktrace:
> 
> 0  bdrv_refresh_filename (bs=0x5efed72f8350)
>     at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:8082
> 1  0x00005efea73cf9dc in bdrv_block_device_info
>     (blk=0x0, bs=0x5efed72f8350, flat=true, errp=0x7ffeb829ebd8)
>     at block/qapi.c:62
> 2  0x00005efea7391ed3 in bdrv_named_nodes_list
>     (flat=<optimized out>, errp=0x7ffeb829ebd8)
>     at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:6275
> 3  0x00005efea7471993 in qmp_query_named_block_nodes
>     (has_flat=<optimized out>, flat=<optimized out>, errp=0x7ffeb829ebd8)
>     at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/blockdev.c:2834
> 4  qmp_marshal_query_named_block_nodes
>     (args=<optimized out>, ret=0x7f2b753beec0, errp=0x7f2b753beec8)
>     at qapi/qapi-commands-block-core.c:553
> 5  0x00005efea74f03a5 in do_qmp_dispatch_bh (opaque=0x7f2b753beed0)
>     at qapi/qmp-dispatch.c:128
> 6  0x00005efea75108e6 in aio_bh_poll (ctx=0x5efed6f3f430)
>     at util/async.c:219
> 7  0x00005efea74ffdb2 in aio_dispatch (ctx=0x5efed6f3f430)
>     at util/aio-posix.c:436
> 8  0x00005efea7512846 in aio_ctx_dispatch (source=<optimized out>,
>     callback=<optimized out>,user_data=<optimized out>)
>     at util/async.c:361
> 9  0x00007f2b77809bfb in ?? ()
>     from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> 10 0x00007f2b77809e70 in g_main_context_dispatch ()
>     from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> 11 0x00005efea7517228 in glib_pollfds_poll () at util/main-loop.c:287
> 12 os_host_main_loop_wait (timeout=0) at util/main-loop.c:310
> 13 main_loop_wait (nonblocking=<optimized out>) at util/main-loop.c:589
> 14 0x00005efea7140482 in qemu_main_loop () at system/runstate.c:905
> 15 0x00005efea744e4e8 in qemu_default_main (opaque=opaque@entry=0x0)
>     at system/main.c:50
> 16 0x00005efea6e76319 in main
>     (argc=<optimized out>, argv=<optimized out>)
>     at system/main.c:93
> 
> As discussed in 20251024-second-fix-3149-v1-1-d997fa3d5ce2@canonical.com,
> a filter should not exist without children in the first place; therefore,
> drop the parameter entirely as it is only used for filters.
> 
> This is a partial revert of 3108a15cf09865456d499b08fe14e3dbec4ccbb3.
> 
> After this change, a blockdev-backup job's copy-before-write filter will
> hold references to its children until the filter is unref'd. This causes
> an additional flush during bdrv_close, so also update iotest 257.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3149
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks, applied to the block branch.

Kevin


