Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC84C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZZr-0002eM-2v; Tue, 19 Mar 2024 09:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmZZj-0002cm-DC
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmZZh-0001RE-93
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710855135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FbjzmZ1U0Mwt0hmu8IXDW+MwyY5qt9tbclQufJ6L3gA=;
 b=X18ml0SyJps0FzC43SvXZc40Jz3YaWSMxeX4ZBdiv2goTZgRRjc/DEYpsS4TBp4wFEYVDQ
 sSdjkzNAHTFmbWJvDWc0a5Obqcdx2ryMfXmrk4bw4glWwSLm5iPFWz1VEfA7GOiypouQEj
 SlWgZ+hKdiNwU1p9jSkBKdwCqeXGQVQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-dK0d34KnN5u2WuJeoQAihQ-1; Tue, 19 Mar 2024 09:32:13 -0400
X-MC-Unique: dK0d34KnN5u2WuJeoQAihQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 532D6800267
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 13:32:13 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 803C01C060A4;
 Tue, 19 Mar 2024 13:32:11 +0000 (UTC)
Date: Tue, 19 Mar 2024 14:32:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Sanjay Rao <srao@redhat.com>,
 Boaz Ben Shabat <bbenshab@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH] coroutine: cap per-thread local pool size
Message-ID: <ZfmT1s8hcW48KIn1@redhat.com>
References: <20240318183429.1039340-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318183429.1039340-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 18.03.2024 um 19:34 hat Stefan Hajnoczi geschrieben:
> The coroutine pool implementation can hit the Linux vm.max_map_count
> limit, causing QEMU to abort with "failed to allocate memory for stack"
> or "failed to set up stack guard page" during coroutine creation.
> 
> This happens because per-thread pools can grow to tens of thousands of
> coroutines. Each coroutine causes 2 virtual memory areas to be created.
> Eventually vm.max_map_count is reached and memory-related syscalls fail.
> The per-thread pool sizes are non-uniform and depend on past coroutine
> usage in each thread, so it's possible for one thread to have a large
> pool while another thread's pool is empty.
> 
> Switch to a new coroutine pool implementation with a global pool that
> grows to a maximum number of coroutines and per-thread local pools that
> are capped at hardcoded small number of coroutines.
> 
> This approach does not leave large numbers of coroutines pooled in a
> thread that may not use them again. In order to perform well it
> amortizes the cost of global pool accesses by working in batches of
> coroutines instead of individual coroutines.
> 
> The global pool is a list. Threads donate batches of coroutines to when
> they have too many and take batches from when they have too few:
> 
> .-----------------------------------.
> | Batch 1 | Batch 2 | Batch 3 | ... | global_pool
> `-----------------------------------'
> 
> Each thread has up to 2 batches of coroutines:
> 
> .-------------------.
> | Batch 1 | Batch 2 | per-thread local_pool (maximum 2 batches)
> `-------------------'
> 
> The goal of this change is to reduce the excessive number of pooled
> coroutines that cause QEMU to abort when vm.max_map_count is reached
> without losing the performance of an adequately sized coroutine pool.
> 
> Here are virtio-blk disk I/O benchmark results:
> 
>       RW BLKSIZE IODEPTH    OLD    NEW CHANGE
> randread      4k       1 113725 117451 +3.3%
> randread      4k       8 192968 198510 +2.9%
> randread      4k      16 207138 209429 +1.1%
> randread      4k      32 212399 215145 +1.3%
> randread      4k      64 218319 221277 +1.4%
> randread    128k       1  17587  17535 -0.3%
> randread    128k       8  17614  17616 +0.0%
> randread    128k      16  17608  17609 +0.0%
> randread    128k      32  17552  17553 +0.0%
> randread    128k      64  17484  17484 +0.0%
> 
> See files/{fio.sh,test.xml.j2} for the benchmark configuration:
> https://gitlab.com/stefanha/virt-playbooks/-/tree/coroutine-pool-fix-sizing
> 
> Buglink: https://issues.redhat.com/browse/RHEL-28947
> Reported-by: Sanjay Rao <srao@redhat.com>
> Reported-by: Boaz Ben Shabat <bbenshab@redhat.com>
> Reported-by: Joe Mario <jmario@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Though I do wonder if we can do something about the slight performance
degradation that Sanjay reported. We seem to stay well under the hard
limit, so the reduced global pool size shouldn't be the issue. Maybe
it's the locking?

Either way, even though it could be called a fix, I don't think this is
for 9.0, right?

Kevin


