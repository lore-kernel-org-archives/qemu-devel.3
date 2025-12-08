Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1E5D3B7EA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 15:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSdRE-0000EC-FN; Mon, 08 Dec 2025 10:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vSdR8-0000Cc-MH
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:46:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vSdR6-0008DU-Vp
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765208762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ycrOq9JNLOO+GHwy4SYFvK251KE/WknlElsshoJIO3A=;
 b=Kp+OyVfKDrS/hkTOs465Q8yGJ/P+4N9YXR5i45oRxZ9UW/XzW4+WlZQaqbPGclW8aYMS2W
 c0T4IlFzAuLzKrDg6eg/wACURbq4NyDvUtX17pVYCBvVqteF3rmo/nQpzw5/e4traSq2CP
 nFhtSF1LgUIXR6tC4hEVqRZV39ng06g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-bOu-fHbIPB6vqRTT97Y9uQ-1; Mon, 08 Dec 2025 10:46:01 -0500
X-MC-Unique: bOu-fHbIPB6vqRTT97Y9uQ-1
X-Mimecast-MFC-AGG-ID: bOu-fHbIPB6vqRTT97Y9uQ_1765208761
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8805c2acd64so106078426d6.3
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 07:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765208761; x=1765813561; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ycrOq9JNLOO+GHwy4SYFvK251KE/WknlElsshoJIO3A=;
 b=JpryEmtQGZeTeItDLMIYbbQjw0eUz4myo6djXzwXgtsQx9az23a22k+ZzNwUruCWyb
 eDsDO+0jHbKQndVKx/Ucx+/R8ts8s55XEyoPkf4snM/mRQyqqnljF/ehF1wP/CJwNngX
 t1V3Bgxf1dlVwOpmZgNOR89oIl8yAbgtE3btw+NNm+xp7ddoeu518+C5ejLI8JibFS7G
 jmOfXKFu8qqvh3VSWuaPYPXIxRXGCpqWQ8I/Ech2DgOvfLruUkrNeSZ5cA1cZwp4/ybX
 Rszm3pg+V/y5wm/0x5072DYdcjuPQhPKXgUhiLKroSYLUE90V+W4Bjcpsiu2zsDfpppd
 V+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765208761; x=1765813561;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ycrOq9JNLOO+GHwy4SYFvK251KE/WknlElsshoJIO3A=;
 b=Z7Jcl7E5b3X3UlViZ2ysMB74gS4Nxx0kzjlQrTSTRIFuVB+YCqnHNmw4OPlNGtm7FA
 Ek+OBmWMltnvW1vFI6KMAPu2Am7yJjCjln0dp9pk6I553bPYIcxznIOEtSGNEgb1Prxj
 s6GU6iVRbn9AcsvXDxxnM6bVCnSq1FD5tfSMcetfQ0DnqjhnU0Pf03lR3ybPi1BqJS2Z
 UCvRZedhmJiEQ7oBKc/7sgicDm61PzQs3ro+gJsfATzxksX1i+29HUwUztFlvbRh0TJd
 qIVuHC8700S+trgjErZenvNt28zqnRk17QQNLbs1OWxA27mJorPxsXAtqUJTUOXVXUgZ
 t9Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX++3YU1J0aPpMXZS10YwsPN5AIaKuKh51C9zrgrqv0seS/tKzDY0g5D4MpoPZ6CLSWVgwwuXnR32le@nongnu.org
X-Gm-Message-State: AOJu0YwdqeT5CiBVDuEf6+xh4sLGnDnlojqyuVyjdop4JgECXmsVW7uV
 wAGz/4qg1f+2MPBZqjyUMuivas0fwLK1Fc1YDeKe9YfPhDqqasiy7MBEaAY1Pgu4zIBX4LL3Chn
 5fzCbd4fFzucwY01S/Ih7ItJMlGu22OW7SSyTPJki7+g1qDW9dZ+GHoG9
X-Gm-Gg: ASbGncszDM0XgGGWCoHdb/0VfXRJjk0w9Ja6897bfJFNfXnKJLDXriC8t3leQJM97Nn
 N5rMm+eNyvnLv29zfChy0jiSZ+hiA2KjpVzYxq4wTJL9q5MSJdH2XrGOKWPym/WXcziaTOzMGhX
 3sWfebi+gxn9NcwU4u14oiWJWm4txl/dl8oLX5Etk8RLHqZ23JjE+l/CS07oEAsH+VemxNb5Xz1
 wmRtDW/aptI6K2G1mkpBz2WmNMyTxQLFnPaD2fVHSTLRhUGgQHxNS2Ix66tZ4VqRivZQsKcr3XJ
 wQ7Iox5qyjdXACO+LTpj43CkKhsGD1XLE59y1BMk+lUV6NLimkD6KqgIqJRZh9hHpHYC9D3R524
 KZD0=
X-Received: by 2002:a05:622a:110c:b0:4ed:8fa:6fc4 with SMTP id
 d75a77b69052e-4f03ff2c08dmr126252811cf.78.1765208760895; 
 Mon, 08 Dec 2025 07:46:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/TN4W7GFAs6e3kH1uCjDBW+8teqlSN64n0mugNeVFPiZMvgNTAgRStA850r9SRrM+wT0ybQ==
X-Received: by 2002:a05:622a:110c:b0:4ed:8fa:6fc4 with SMTP id
 d75a77b69052e-4f03ff2c08dmr126252241cf.78.1765208760371; 
 Mon, 08 Dec 2025 07:46:00 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-888287d6c1fsm106916656d6.44.2025.12.08.07.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 07:45:59 -0800 (PST)
Date: Mon, 8 Dec 2025 10:45:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] migration: Fix a possible crash when halting a guest
 during migration
Message-ID: <aTbytkuplCB8jpXX@x1.local>
References: <20251208135101.271417-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251208135101.271417-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Dec 08, 2025 at 02:51:01PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> When shutting down a guest that is currently in progress of being
> migrated, there is a chance that QEMU might crash during bdrv_delete().
> The backtrace looks like this:
> 
>  Thread 74 "mig/src/main" received signal SIGSEGV, Segmentation fault.
> 
>  [Switching to Thread 0x3f7de7fc8c0 (LWP 2161436)]
>  0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
>  5560	        QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
>  (gdb) bt
>  #0  0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
>  #1  bdrv_unref (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:7170
>  Backtrace stopped: Cannot access memory at address 0x3f7de7f83e0
> 
> The problem is apparently that the migration thread is still active
> (migration_shutdown() only asks it to stop the current migration, but
> does not wait for it to finish), while the main thread continues to
> bdrv_close_all() that will destroy all block drivers. So the two threads
> are racing here for the destruction of the migration-related block drivers.
> 
> I was able to bisect the problem and the race has apparently been introduced
> by commit c2a189976e211c9ff782 ("migration/block-active: Remove global active
> flag"), so reverting it might be an option as well, but waiting for the
> migration thread to finish before continuing with the further clean-ups
> during shutdown seems less intrusive.
> 
> Note: I used the Claude AI assistant for analyzing the crash, and it
> came up with the idea of waiting for the migration thread to finish
> in migration_shutdown() before proceeding with the further clean-up,
> but the patch itself has been 100% written by myself.
> 
> Fixes: c2a189976e ("migration/block-active: Remove global active flag")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  migration/migration.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index b316ee01ab2..6f4bb6d8438 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -380,6 +380,16 @@ void migration_bh_schedule(QEMUBHFunc *cb, void *opaque)
>      qemu_bh_schedule(bh);
>  }
>  
> +static void migration_thread_join(MigrationState *s)
> +{
> +    if (s && s->migration_thread_running) {
> +        bql_unlock();
> +        qemu_thread_join(&s->thread);
> +        s->migration_thread_running = false;
> +        bql_lock();
> +    }
> +}
> +
>  void migration_shutdown(void)
>  {
>      /*
> @@ -393,6 +403,13 @@ void migration_shutdown(void)
>       * stop the migration using this structure
>       */
>      migration_cancel();
> +    /*
> +     * Wait for migration thread to finish to prevent a possible race where
> +     * the migration thread is still running and accessing host block drivers
> +     * while the main cleanup proceeds to remove them in bdrv_close_all()
> +     * later.
> +     */
> +    migration_thread_join(migrate_get_current());

Not join() the thread was intentional, per commit 892ae715b6bc81, and then
I found I asked a question before; Dave answers here:

https://lore.kernel.org/all/20190228114019.GB4970@work-vm/

I wonder if we can still investigate what Stefan mentioned as the other
approach, as join() here may introduce other hang risks before we can
justify it's safe..

Thanks,

>      object_unref(OBJECT(current_migration));
>  
>      /*
> @@ -1499,12 +1516,7 @@ static void migration_cleanup(MigrationState *s)
>  
>      close_return_path_on_source(s);
>  
> -    if (s->migration_thread_running) {
> -        bql_unlock();
> -        qemu_thread_join(&s->thread);
> -        s->migration_thread_running = false;
> -        bql_lock();
> -    }
> +    migration_thread_join(s);
>  
>      WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
>          /*
> -- 
> 2.52.0
> 

-- 
Peter Xu


