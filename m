Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4005C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 20:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk7gS-0003h4-7Q; Thu, 07 Aug 2025 16:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uk7gO-0003fG-5o
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 16:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uk7gL-0000G4-3A
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 16:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754600266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6wY/uN21BfqGXgtMNs/MtrPvLQ1Jq5VoJ5ej7BTwk7U=;
 b=gDqyoZ27JRgtyLjCLpGV6bVEWCjabVOVKHd2e2DtX3H5HpkBDCQnqbt2IdKSg7AFji+Bo+
 TveI2d9jCqEGEVdu/V8cUQWfKsNEYQoUFPNFCQsJp4r1w3L4/h+bQj/QNqFFRXFEp2Cm3E
 Yuzt7BISj0e61khG3uza88YP+o03aF8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-MBI4QCsXPXKf7irwT5oN_Q-1; Thu, 07 Aug 2025 16:57:45 -0400
X-MC-Unique: MBI4QCsXPXKf7irwT5oN_Q-1
X-Mimecast-MFC-AGG-ID: MBI4QCsXPXKf7irwT5oN_Q_1754600265
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b096d8fc3bso32785231cf.2
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 13:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754600265; x=1755205065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wY/uN21BfqGXgtMNs/MtrPvLQ1Jq5VoJ5ej7BTwk7U=;
 b=pbQfKUgKdF7NUpZ7QP4QFs62a+9f+A5eCJR0VasJmU+N317JAfivnV5clWanu09ClN
 kZUQJyjGYeAA2sATdDyj8O+cUGCxZfmK2sYMljHbcLoLhwHe9bSnE5xzH1BPUQuevzCf
 IKFEC1ThB3ETRJLr5fLaVAIJLPUDJo8AQg8CZpQvSItNaaDV/HrIc+7T/3KkXFRl1vqg
 JOVU/Y4cHGdl2didRkSN4x7zljrUCskBMkQA/u7/FnrXU2qPhyUxQSEBnsBwi9f7dgzu
 jLQ8nmeBNABqfna2relgw0Y3XOYgcdhXeYOGASKN28BSqn7vytTcgegVXGvpB/5iX++y
 97NQ==
X-Gm-Message-State: AOJu0YzVDwFTcXWqI11Y8IDNc5Et2IMiiB9utYtYH6jRaoqlKh/mUIur
 GiaESyCyP6FXyGaG/pythFgmCX7SW7N4ehKvGKw6u06QiBKt6IjXrDTicH87A+S4fErhVl8m5//
 9bI3gqhDl7WvLB+mmWK/BZ0EBqz2YhglR7fl6dYl7qfK8jigzlQvmorXG
X-Gm-Gg: ASbGncvCIRxeqNOsABGf+V2QYhIUk8E7uuc10HXIJss5GID6vQTxrDzZoiHByta082e
 PLQ7jx6SuMwniTj4TObc/Uc1lm1lFLBP7mAk8HVuiZfZadhvT0gFMht/6F+X8HaZHeX24qmMk9i
 yXdqx3cPfl4HYwEnyfC7TNBxUYo2wW1U8x0cWLBr09S+9FC8ojcHLWm6zEpBQ5RVZxdKpDbXA9C
 UjP9gzDUMMFYSVZRsx5YQHQIuoaDyzIhyl0PKAeuhrN7/8kbFa9f5QFC/59pTG6cjTPqDE9vLi9
 aKd9SwdMCz8p3FZflWVp37mUV61xrRAn
X-Received: by 2002:ac8:584d:0:b0:4ab:5c58:bb33 with SMTP id
 d75a77b69052e-4b0aee227f7mr12395861cf.49.1754600264858; 
 Thu, 07 Aug 2025 13:57:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXaoSlJ1dLSH2HswqAhol7Ci75ufOTXQydkaxn4Qar+zOWzY9OmDQhHJiO4ccaphvjHAjUXw==
X-Received: by 2002:ac8:584d:0:b0:4ab:5c58:bb33 with SMTP id
 d75a77b69052e-4b0aee227f7mr12395421cf.49.1754600264316; 
 Thu, 07 Aug 2025 13:57:44 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b0a41a2ab2sm12719351cf.18.2025.08.07.13.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 13:57:43 -0700 (PDT)
Date: Thu, 7 Aug 2025 16:57:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 3/4] migration: Make listen thread joinable
Message-ID: <aJUTO0n9NyIWaFNj@x1.local>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <20250807114922.1013286-4-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807114922.1013286-4-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 07, 2025 at 01:49:11PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> This patch allows joining the migration listen thread. This is done in
> preparation for the introduction of "postcopy-setup" state at the
> beginning of a postcopy migration, when destination can fail gracefully
> and source side then resume to a running state.
> 
> In case of such failure, to gracefully perform all cleanup in the main
> migration thread, we need to wait for the listen thread to exit, which
> can be done by joining it.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/migration.c | 1 +
>  migration/savevm.c    | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index e5ce2940d5..8174e811eb 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -901,6 +901,7 @@ process_incoming_migration_co(void *opaque)
>               * Postcopy was started, cleanup should happen at the end of the
>               * postcopy thread.
>               */
> +            qemu_thread_detach(&mis->listen_thread);
>              trace_process_incoming_migration_co_postcopy_end_main();
>              goto out;
>          }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index fabbeb296a..d2360be53c 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2217,7 +2217,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
>      mis->have_listen_thread = true;
>      postcopy_thread_create(mis, &mis->listen_thread,
>                             MIGRATION_THREAD_DST_LISTEN,
> -                           postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
> +                           postcopy_ram_listen_thread, QEMU_THREAD_JOINABLE);

This is good; I actually forgot it used to be detached..

Instead of proactively detach it above, could we always properly join it
(and hopefully every migration thread)?  Then we could drop patch 1 too.

>      trace_loadvm_postcopy_handle_listen("return");
>  
>      return 0;
> -- 
> 2.50.1
> 

-- 
Peter Xu


