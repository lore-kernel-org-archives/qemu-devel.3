Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07AFC02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 13:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tab8E-0000aG-64; Wed, 22 Jan 2025 08:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tab8C-0000a4-Cf
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 08:50:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tab89-00013Z-HF
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 08:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737553852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sN68ytzOJ93ZMYaQFdqBzQDOZRpQuxu+ISWNSGQZwV0=;
 b=jKW9H/tjyCSSxqVtF65VigavXrTYzfZIdsIWW33ElwWsM/OGZtnbA0nzzhumnln1C93PGq
 OUfJNFGbgzJsfi19aCxt9WdQPDFhFL2vchQ6hFniko9LXfO20aUR7L7qS1WcDsBSawHYZI
 79kl7L2yhfKroUisG269UMWU5wxqdrM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58--GjRMh9AOKOPTNgP0JY9BQ-1; Wed,
 22 Jan 2025 08:50:49 -0500
X-MC-Unique: -GjRMh9AOKOPTNgP0JY9BQ-1
X-Mimecast-MFC-AGG-ID: -GjRMh9AOKOPTNgP0JY9BQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3141D19560B8; Wed, 22 Jan 2025 13:50:48 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.195])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B39EC19560AA; Wed, 22 Jan 2025 13:50:45 +0000 (UTC)
Date: Wed, 22 Jan 2025 14:50:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, s_sourceforge@nedprod.com,
 Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 0/3] scripts/qemu-gdb: Make coroutine dumps to work
 with coredumps
Message-ID: <Z5D3s1WwzV0MKi6Q@redhat.com>
References: <20241212204801.1420528-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212204801.1420528-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 12.12.2024 um 21:47 hat Peter Xu geschrieben:
> v1: https://lore.kernel.org/r/20241211201739.1380222-1-peterx@redhat.com
> 
> Changelog: in previous v1, I got a wrong cut-off accident in commit
> message, which is now fixed (along with some small touchup elsewhere).
> When at it, I also tried to make it look even better to be as close as gdb
> bt, so it looks like this now:
> 
>   Coroutine at 0x7f9f4c57c748:
>   #0  0x55ae6c0dc9a8 in qemu_coroutine_switch<+120> () at ../util/coroutine-ucontext.c:321
>   #1  0x55ae6c0da2f8 in qemu_aio_coroutine_enter<+356> () at ../util/qemu-coroutine.c:293
>   #2  0x55ae6c0da3f1 in qemu_coroutine_enter<+34> () at ../util/qemu-coroutine.c:316
>   #3  0x55ae6baf775e in migration_incoming_process<+43> () at ../migration/migration.c:876
>   #4  0x55ae6baf7ab4 in migration_ioc_process_incoming<+490> () at ../migration/migration.c:1008
>   #5  0x55ae6bae9ae7 in migration_channel_process_incoming<+145> () at ../migration/channel.c:45
>   #6  0x55ae6bb18e35 in socket_accept_incoming_migration<+118> () at ../migration/socket.c:132
>   #7  0x55ae6be939ef in qio_net_listener_channel_func<+131> () at ../io/net-listener.c:54
>   #8  0x55ae6be8ce1a in qio_channel_fd_source_dispatch<+78> () at ../io/channel-watch.c:84
>   #9  0x7f9f5b26728c in g_main_context_dispatch_unlocked.lto_priv<+315> ()
>   #10  0x7f9f5b267555 in g_main_context_dispatch<+36> ()
>   #11  0x55ae6c0d91a7 in glib_pollfds_poll<+90> () at ../util/main-loop.c:287
>   #12  0x55ae6c0d9235 in os_host_main_loop_wait<+128> () at ../util/main-loop.c:310
>   #13  0x55ae6c0d9364 in main_loop_wait<+203> () at ../util/main-loop.c:589
>   #14  0x55ae6bac212a in qemu_main_loop<+41> () at ../system/runstate.c:835
>   #15  0x55ae6bfdf522 in qemu_default_main<+19> () at ../system/main.c:37
>   #16  0x55ae6bfdf55f in main<+40> () at ../system/main.c:48
>   #17  0x7f9f59d42248 in __libc_start_call_main<+119> ()
>   #18  0x7f9f59d4230b in __libc_start_main_impl<+138> ()
> 
> Coroutines are used in many cases in block layers. It's also used in live
> migration when on destination side, and it'll be handy to diagnose crashes
> within a coroutine when we want to also know what other coroutines are
> doing.
> 
> This series adds initial support for that, not pretty but it should start
> working.  Since we can't use the trick to modify registers on the fly in
> non-live gdb sessions, we do manual unwinds.
> 
> One thing to mention is there's a similar but more generic solution
> mentioned on the list from Niall:
> 
> https://lore.kernel.org/r/f0ebccca-7a17-4da8-ac4a-71cf6d69abc3@mtasv.net
> 
> That adds more dependency on both gdb and qemu in the future, however more
> generic.  So this series is an intermediate quick solution as for now,
> which should work for most older qemu/gdb binaries too.
> 
> Thanks,
> 
> Peter Xu (3):
>   scripts/qemu-gdb: Always do full stack dump for python errors
>   scripts/qemu-gdb: Simplify fs_base fetching for coroutines
>   scripts/qemu-gdb: Support coroutine dumps in coredumps

Thanks, applied to the block branch.

Kevin


