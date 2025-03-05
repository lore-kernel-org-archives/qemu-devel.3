Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD76FC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 12:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpnxp-0003TN-Vp; Wed, 05 Mar 2025 07:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tpnxo-0003Qx-Cq
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 07:35:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tpnxm-0002gi-37
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 07:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741178099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6zmbtmnNny1eyCgFf9grbkPW8zcX6E6Ye3o/fj89/0w=;
 b=g3NBtK9DzhMzgNuwzmMF1Z8A6OHjQj3t7dhlfaeO4tRDdep8Ll9Oo5UFUeJhobfLk1xVE3
 xpP0kNpqyy5s4jJ7H/0XuzlRoucgvCpKbbrtNYoPjCv7R/ako8VKSoFnT3rCy33Z9Sswbr
 dYjy/PFiavoejldjyoSw/6DIf9UCAyU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-uviF_ShrPEmJG1UN9qHFIw-1; Wed, 05 Mar 2025 07:34:43 -0500
X-MC-Unique: uviF_ShrPEmJG1UN9qHFIw-1
X-Mimecast-MFC-AGG-ID: uviF_ShrPEmJG1UN9qHFIw_1741178082
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e8a18cfbe9so92463786d6.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 04:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741178082; x=1741782882;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6zmbtmnNny1eyCgFf9grbkPW8zcX6E6Ye3o/fj89/0w=;
 b=MCU8T+nyuqw6IesHLu5Avx9piqZClkwNEH3aj+aJb84JXGxsnyB3vAhAwUTnpPTTgk
 AwXoGqe2CBHVNYyuRHnsY8QNiw7bGvwEP6rT2Pse1Nh8gM8KwkgIp/ub0ttvfGi9OrEJ
 ClgcTrTiTre6ViCB76LOfXHTcRXM2qJ9MK/ZGmQdqsuDx57CV2EHADtrpFWiGkPNGpjL
 tXm5xghta4WNlPTjAWgXmfSo00gaA3E1E+Oo8mw4Vnrc6GiwT45oRj7zSwFzph8oUzD5
 43MnOzbpaY439+xkJgidMnloW5psXPqcUMTakxvsf1pTJVzRQKuWseQ7d9J26udRaWzX
 BQtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI4/sH3fB4Axxe98SZesRo/662Km3DwqjMZrwZy5m9S5fJeX7dAU4KK/CaM2ddnZpwsVb+VVHb5ts4@nongnu.org
X-Gm-Message-State: AOJu0YxlgJ/qWZ1k2CY4+pLLOEnM8+XI41hOaUtH5jkvwgW+dwcH9AvD
 yOUhREpiiB7RpKmhPL7hjV5ANRGjRw6n1KkYILzrNk3u2fkVb1CCrMMIxrgrBMMrvWsEbG36bUM
 H4L5wLvr9LEP3ogWTu7jbFmS2XrHbKNlMfdg4kWRGbvqXGK6ClV10
X-Gm-Gg: ASbGncs+o3YmZALhq7x2ECoSCSYvII87WTRc+m0nSHQSZ659LV9wgxklD31xKlE9BJc
 ei6SFqGk8SwqoatnAtYvb2kokF0iCjRbBIdOsdw8T/VBTqxL/pmltYx0Tj+gTZLCiqjMsyJKT/m
 bA5ICVH+3eUtxYK8DKhKzNqp7eZaSEqL06PpuihmNXUjQTrwnZWP0N+olJrGF1SftAhyy8q8oCj
 H49ul1LOYbfm2a8rnn0hTp2vUShUy0E0Hx6XXdV41PJC0O4QGyWAcSpdheQS2ALajDSCHB/Yobw
 nIZszfE=
X-Received: by 2002:a05:6214:258b:b0:6e4:4331:aae0 with SMTP id
 6a1803df08f44-6e8e6cffdb6mr36271906d6.1.1741178082610; 
 Wed, 05 Mar 2025 04:34:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoSiYfYKbdsj0R6F1+OvqtEgw9iwz6HDHnfxGwv3+yqFZ9n/45V5fahJT8LdgPC9fSQTTwAQ==
X-Received: by 2002:a05:6214:258b:b0:6e4:4331:aae0 with SMTP id
 6a1803df08f44-6e8e6cffdb6mr36271226d6.1.1741178081744; 
 Wed, 05 Mar 2025 04:34:41 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976d9fe1sm78870896d6.102.2025.03.05.04.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 04:34:41 -0800 (PST)
Date: Wed, 5 Mar 2025 07:34:38 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 07/36] migration: postcopy_ram_listen_thread() should
 take BQL for some calls
Message-ID: <Z8hE3ujEKkwsBiJO@x1.local>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <24a7412cc151f8b48d74cd170a3bdc1ce8e6c879.1741124640.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24a7412cc151f8b48d74cd170a3bdc1ce8e6c879.1741124640.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Mar 04, 2025 at 11:03:34PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> All callers to migration_incoming_state_destroy() other than
> postcopy_ram_listen_thread() do this call with BQL held.
> 
> Since migration_incoming_state_destroy() ultimately calls "load_cleanup"
> SaveVMHandlers and it will soon call BQL-sensitive code it makes sense
> to always call that function under BQL rather than to have it deal with
> both cases (with BQL and without BQL).
> Add the necessary bql_lock() and bql_unlock() to
> postcopy_ram_listen_thread().
> 
> qemu_loadvm_state_main() in postcopy_ram_listen_thread() could call
> "load_state" SaveVMHandlers that are expecting BQL to be held.
> 
> In principle, the only devices that should be arriving on migration
> channel serviced by postcopy_ram_listen_thread() are those that are
> postcopiable and whose load handlers are safe to be called without BQL
> being held.
> 
> But nothing currently prevents the source from sending data for "unsafe"
> devices which would cause trouble there.
> Add a TODO comment there so it's clear that it would be good to improve
> handling of such (erroneous) case in the future.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  migration/migration.c | 16 ++++++++++++++++
>  migration/savevm.c    |  4 ++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 9e9db26667f1..6b2a8af4231d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -402,10 +402,26 @@ void migration_incoming_state_destroy(void)
>      struct MigrationIncomingState *mis = migration_incoming_get_current();
>  
>      multifd_recv_cleanup();
> +
>      /*
>       * RAM state cleanup needs to happen after multifd cleanup, because
>       * multifd threads can use some of its states (receivedmap).
> +     *
> +     * This call also needs BQL held since it calls all registered
> +     * load_cleanup SaveVMHandlers and at least the VFIO implementation is
> +     * BQL-sensitive.
> +     *
> +     * In addition to the above, it also performs cleanup of load threads
> +     * thread pool.
> +     * This cleanup operation is BQL-sensitive as it requires unlocking BQL
> +     * so a thread possibly waiting for it could get unblocked and finally
> +     * exit.
> +     * The reason why a load thread may need to hold BQL in the first place
> +     * is because address space modification operations require it.

Hold on...

This almost says exactly why load_cleanup() should _not_ take BQL... rather
than should..

So I had a closer look at the latest code, it's about this:

static void vfio_load_cleanup_load_bufs_thread(VFIOMultifd *multifd)
{
    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
    bql_unlock();
    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
        while (multifd->load_bufs_thread_running) {
            multifd->load_bufs_thread_want_exit = true;

            qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
            qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
            qemu_cond_wait(&multifd->load_bufs_thread_finished_cond,
                           &multifd->load_bufs_mutex);
        }
    }
    bql_lock();
}

It doesn't make much sense to me to take it only because we want to drop it
unconditionally. Can we guarantee the function not taking BQL instead?  I
had a quick look on pmem's pmem_persist() (from libpmem, qemu_ram_msync <-
qemu_ram_block_writeback <- ram_load_cleanup), it looks ok.

So the question is, is it safe to unlock BQL in whatever context (in
coroutines, or in a bottom half)?

If the answer is yes, we could make migration_incoming_state_destroy()
always not taking BQL (and assert(!bql_locked()) instead).

If the answer is no, then vfio_load_cleanup_load_bufs_thread()'s current
version may not work either..

> +     *
> +     * Check proper BQL state here rather than risk possible deadlock later.
>       */
> +    assert(bql_locked());
>      qemu_loadvm_state_cleanup();
>  
>      if (mis->to_src_file) {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 7c1aa8ad7b9d..3e86b572cfa8 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1986,6 +1986,8 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       * in qemu_file, and thus we must be blocking now.
>       */
>      qemu_file_set_blocking(f, true);
> +
> +    /* TODO: sanity check that only postcopiable data will be loaded here */
>      load_res = qemu_loadvm_state_main(f, mis);
>  
>      /*
> @@ -2046,7 +2048,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       * (If something broke then qemu will have to exit anyway since it's
>       * got a bad migration state).
>       */
> +    bql_lock();
>      migration_incoming_state_destroy();
> +    bql_unlock();
>  
>      rcu_unregister_thread();
>      mis->have_listen_thread = false;
> 

-- 
Peter Xu


