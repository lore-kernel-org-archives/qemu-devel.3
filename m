Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD2ACAC58E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 17:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqbbF-0007am-5B; Tue, 17 Sep 2024 13:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqbbD-0007YO-3T
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 13:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqbbA-0002jV-3K
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 13:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726592562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DqPp0RmMR/qMqG8/YCcg5Uy0HxznPLSeRzz2jFd5aDY=;
 b=dJLxyw93DktjE0l85NUXMXjA7c3S0A+EL4qiFwsgibkC3GSyaLhkmV7f5UkUWw9uJQB92o
 xRqsORVdthXIz0iOPIlw7P8Y710f5/cbGTEqIm/wtZAUyuu0fzn68WHG7yRpj7mOZ1dVKp
 vcbh1NfzNyWTEz/9KOVc90p5VnOVs+w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-3bDk1mJ3ObmryrhKQoP-mg-1; Tue, 17 Sep 2024 13:02:40 -0400
X-MC-Unique: 3bDk1mJ3ObmryrhKQoP-mg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6c353a05885so7690436d6.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 10:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726592560; x=1727197360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqPp0RmMR/qMqG8/YCcg5Uy0HxznPLSeRzz2jFd5aDY=;
 b=mFSBptRxtNil6M/VoCDe23ONOqbSDWQ2YLWlD9185pTGLhuREJE2kBuU0UAr55KtKH
 rUB0CsbNxKoKlzEDnHAYSABfCc31xVKkr/XB8kyPi/V6f2VqogBjmGYkJHkc2Y7V1pj5
 y64+itPANcNboT80RUpn05oMDyCmos/4yAcphMCCT9tHtio8ZYA6NKARxedz1ES6hWyH
 +AHnZere5gX1YJqxhF+/d4u61T8gZ4zPlHID93/sFVxx1QNS0lReeOaAETU/cMXrPKIK
 qSlhVSBWKaLnGeATl4WKF+ok2rHWPIpWjLhPs3m+4ejFMvGN/dEzpXDfMpm+Tr5nUxOd
 qDoQ==
X-Gm-Message-State: AOJu0YyjxMf0ilBylt5H86HTyYAnNnR3ZImqFz6H3iUxksgAgB3Gp+8s
 WIxeks81pSEJsI/BRbx6wTxC8cLUU2sX6LAXvTPpD1AXhzPCv6ESHUsdjtY3Ytoz/2I+gr91fvf
 in2yQFppmRGFXuc/+uE9bSpEB1T/aPBZzGH9H37LhTT/7Z88J9Suw
X-Received: by 2002:a05:6214:33c5:b0:6c5:acf0:400 with SMTP id
 6a1803df08f44-6c5acf00550mr39989186d6.52.1726592559864; 
 Tue, 17 Sep 2024 10:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpJIRTptFSsWbScX2QG2DhbtptyIRpJufqBghqHizc2gsFx18nLj2o7z6ILAXhxraZ1C4RBw==
X-Received: by 2002:a05:6214:33c5:b0:6c5:acf0:400 with SMTP id
 6a1803df08f44-6c5acf00550mr39988726d6.52.1726592559217; 
 Tue, 17 Sep 2024 10:02:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5acf18081sm9215386d6.134.2024.09.17.10.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 10:02:38 -0700 (PDT)
Date: Tue, 17 Sep 2024 13:02:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 2/2] migration/multifd: Fix rb->receivedmap cleanup race
Message-ID: <Zum2LOpaIRVDDEo9@x1n>
References: <20240913220542.18305-1-farosas@suse.de>
 <20240913220542.18305-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913220542.18305-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 13, 2024 at 07:05:42PM -0300, Fabiano Rosas wrote:
> Fix a segmentation fault in multifd when rb->receivedmap is cleared
> too early.
> 
> After commit 5ef7e26bdb ("migration/multifd: solve zero page causing
> multiple page faults"), multifd started using the rb->receivedmap
> bitmap, which belongs to ram.c and is initialized and *freed* from the
> ram SaveVMHandlers.
> 
> Multifd threads are live until migration_incoming_state_destroy(),
> which is called after qemu_loadvm_state_cleanup(), leading to a crash
> when accessing rb->receivedmap.
> 
> process_incoming_migration_co()        ...
>   qemu_loadvm_state()                  multifd_nocomp_recv()
>     qemu_loadvm_state_cleanup()          ramblock_recv_bitmap_set_offset()
>       rb->receivedmap = NULL               set_bit_atomic(..., rb->receivedmap)
>   ...
>   migration_incoming_state_destroy()
>     multifd_recv_cleanup()
>       multifd_recv_terminate_threads(NULL)
> 
> Move the loadvm cleanup into migration_incoming_state_destroy(), after
> multifd_recv_cleanup() to ensure multifd thread have already exited
> when rb->receivedmap is cleared.
> 
> The have_listen_thread logic can now be removed because its purpose
> was to delay cleanup until postcopy_ram_listen_thread() had finished.
> 
> CC: qemu-stable@nongnu.org
> Fixes: 5ef7e26bdb ("migration/multifd: solve zero page causing multiple page faults")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 1 +
>  migration/migration.h | 1 -
>  migration/savevm.c    | 9 ---------
>  3 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 3dea06d577..b190a574b1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -378,6 +378,7 @@ void migration_incoming_state_destroy(void)
>      struct MigrationIncomingState *mis = migration_incoming_get_current();
>  
>      multifd_recv_cleanup();
> +    qemu_loadvm_state_cleanup();
>  
>      if (mis->to_src_file) {
>          /* Tell source that we are done */
> diff --git a/migration/migration.h b/migration/migration.h
> index 38aa1402d5..20b0a5b66e 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -101,7 +101,6 @@ struct MigrationIncomingState {
>      /* Set this when we want the fault thread to quit */
>      bool           fault_thread_quit;
>  
> -    bool           have_listen_thread;
>      QemuThread     listen_thread;
>  
>      /* For the kernel to send us notifications */
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d0759694fd..532ee5e4b0 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2076,10 +2076,8 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       * got a bad migration state).
>       */
>      migration_incoming_state_destroy();
> -    qemu_loadvm_state_cleanup();
>  
>      rcu_unregister_thread();
> -    mis->have_listen_thread = false;
>      postcopy_state_set(POSTCOPY_INCOMING_END);
>  
>      object_unref(OBJECT(migr));
> @@ -2130,7 +2128,6 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
>          return -1;
>      }
>  
> -    mis->have_listen_thread = true;
>      postcopy_thread_create(mis, &mis->listen_thread, "mig/dst/listen",
>                             postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
>      trace_loadvm_postcopy_handle_listen("return");
> @@ -2978,11 +2975,6 @@ int qemu_loadvm_state(QEMUFile *f)
>  
>      trace_qemu_loadvm_state_post_main(ret);
>  
> -    if (mis->have_listen_thread) {
> -        /* Listen thread still going, can't clean up yet */
> -        return ret;
> -    }

Hmm, I wonder whether we would still need this.  IIUC it's not only about
cleanup, but also that when postcopy is involved, dst QEMU postpones doing
any of the rest in the qemu_loadvm_state_main() call.

E.g. cpu put, aka, cpu_synchronize_all_post_init(), is also done in
loadvm_postcopy_handle_run_bh() later.

IOW, I'd then expect when this patch applied we'll put cpu twice?

I think the should_send_vmdesc() part is fine, as it returns false for
postcopy anyway.  However not sure on the cpu post_init above.

> -
>      if (ret == 0) {
>          ret = qemu_file_get_error(f);
>      }
> @@ -3022,7 +3014,6 @@ int qemu_loadvm_state(QEMUFile *f)
>          }
>      }
>  
> -    qemu_loadvm_state_cleanup();
>      cpu_synchronize_all_post_init();
>  
>      return ret;
> -- 
> 2.35.3
> 

-- 
Peter Xu


