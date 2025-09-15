Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1BACAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 20:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyFfi-00067f-CW; Mon, 15 Sep 2025 16:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyFff-00067R-OV
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 16:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyFfX-0007mG-Ac
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 16:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757967553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n7tsDjWQ0n987o4+G1dM0OPRTePR88Kh4sj/Rgwdaac=;
 b=FlQUTvVSrIJU7kGUu1ATYSew2B1+FlJS+/IGfQtQBR2aCr8mBT1GCq+n/UM3W7lCDxYdQx
 tD+7a15dCN0X2t7eeZfJ5T2nKavwILBvLzAg9nSZKsvScgpwkh/yZxsulyl3HAgUyVcZ1Z
 FvFWBDaLVxmDnwDBtJ8o4HC8tOia0Ko=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-mswr1xNsOoOc1Tqi_CczZA-1; Mon, 15 Sep 2025 16:19:12 -0400
X-MC-Unique: mswr1xNsOoOc1Tqi_CczZA-1
X-Mimecast-MFC-AGG-ID: mswr1xNsOoOc1Tqi_CczZA_1757967552
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-829080582b4so357304285a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 13:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757967552; x=1758572352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7tsDjWQ0n987o4+G1dM0OPRTePR88Kh4sj/Rgwdaac=;
 b=lp0LQbIVMh56jMNHVL8uaOrMgSqEK30ebYuCMQaFwQTDq7bVD5OryX7ybpQIdlWDX7
 kAdrAx/WlFPNsMtWfiSC0RCWC8rS+oe6m/LGwyP4anZJT6BJ2TQe8q9jmBeukIijjJF7
 37aHA98/pJZmKQjYoucgKrMQGeYog4RCVhxaeEGSVchVH+1C7VAsc87KU8kUIkFm2HHn
 TT+SUkjjfscs1f29iEaN984NGigOGHsiFZEkSI3jw0T8lu4kOqlcL1RR1LohPPVW3yE0
 YBaZCHizWd3kDOvJUNo7fmQkDFdW1NMegFmyi2WetDjDV3xdiMfcrMPIP3fcaEIFWPMg
 B6Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqDGk9kycp3CZNysu1/0dGkSc+cUtQLk2RaGuEhJKb+lPlUQw6iZ3C09yh9LoWYggS4XUsRb1XmrJc@nongnu.org
X-Gm-Message-State: AOJu0YzG/IrGWS2jwGJ9hw6TFtTCKqy5d6ZsqqMzAFZhwoe2N00I6x3J
 rXTiB1S61gUPJ5ENK1yMv3AMUZcXo8yvdww0Fs8bmeyLLMj53/1qNTm+EdQHl+u5MPXi+AhpGn0
 LxYuSZPbd4nb6m2Kw7BTJJ8GK81iCqE861QwXTG3wN4MYe+qeg4sRf2KEoXEmUj9O
X-Gm-Gg: ASbGnctFD8/df+BX8D0YtXGAQ4Gawh5HrlB90cEbcBUat9Fvso9zn6BS/Y5gEG5C2tG
 aZY5/xqoVY2xU8Nvdw/0EeB9k0cHzMkqGHWe50oSGOSQ0Zt772dkqtMmNCNWWkmf9qv18WBBoJH
 w1wkHbpnPU6rgjvnMX3gOidrJw0r8bcxhfvGJ4N3ErB2Dh0rgAba3nokhbXd0gGesJeCVDS6Isx
 OcRsQ7v7LpWuWWTkjrylLvY2V09pKb5GCJoakwwx4HYghnzI90mP/XHsSaVctzFUTrN2GEgxV+q
 nKo0Sf20BucQYzvoO0hj3pECw96vz8er
X-Received: by 2002:a05:620a:1729:b0:824:63df:561f with SMTP id
 af79cd13be357-82463df567bmr1602357085a.28.1757967551527; 
 Mon, 15 Sep 2025 13:19:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAvTD5H0exj7/YWOVmXNZrgxJjAIW3WM0rPuEgjGnAYV1iDTN/6VLfpG7wcmDPI0rvtcFIJg==
X-Received: by 2002:a05:620a:1729:b0:824:63df:561f with SMTP id
 af79cd13be357-82463df567bmr1602352385a.28.1757967550890; 
 Mon, 15 Sep 2025 13:19:10 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820c974cf21sm861031785a.22.2025.09.15.13.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 13:19:10 -0700 (PDT)
Date: Mon, 15 Sep 2025 16:18:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v4 05/12] migration: qemu_file_set_blocking(): add errp
 parameter
Message-ID: <aMh0sjXkQ9IYo_SB@x1.local>
References: <20250915193105.230085-1-vsementsov@yandex-team.ru>
 <20250915193105.230085-6-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915193105.230085-6-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

On Mon, Sep 15, 2025 at 10:30:57PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> qemu_file_set_blocking() is a wrapper on qio_channel_set_blocking(),
> so let's passthrough the errp.

This looks all reasonable in general.

Said that, using error_abort in migration code normally are not suggested
because it's too strong.

I did check all of below should be on the incoming side which is not as
severe (because killing dest qemu before switchover is normally
benign). Still, can we switch all below users to error_warn (including the
one below that may want to error_report_err(), IMHO a warn report is fine
even for such error)?

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/colo.c         | 5 ++++-
>  migration/migration.c    | 8 +++++---
>  migration/postcopy-ram.c | 2 +-
>  migration/qemu-file.c    | 4 ++--
>  migration/qemu-file.h    | 2 +-
>  migration/savevm.c       | 4 ++--
>  6 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index e0f713c837..cf4d71d9ed 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -859,7 +859,10 @@ static void *colo_process_incoming_thread(void *opaque)
>       * coroutine, and here we are in the COLO incoming thread, so it is ok to
>       * set the fd back to blocked.
>       */
> -    qemu_file_set_blocking(mis->from_src_file, true);
> +    if (!qemu_file_set_blocking(mis->from_src_file, true, &local_err)) {
> +        error_report_err(local_err);
> +        goto out;
> +    }
>  
>      colo_incoming_start_dirty_log();
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25d..e1ac4d73c2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -951,7 +951,7 @@ static void migration_incoming_setup(QEMUFile *f)
>  
>      assert(!mis->from_src_file);
>      mis->from_src_file = f;
> -    qemu_file_set_blocking(f, false);
> +    qemu_file_set_blocking(f, false, &error_abort);
>  }
>  
>  void migration_incoming_process(void)
> @@ -971,7 +971,7 @@ static bool postcopy_try_recover(void)
>          /* This should be set already in migration_incoming_setup() */
>          assert(mis->from_src_file);
>          /* Postcopy has standalone thread to do vm load */
> -        qemu_file_set_blocking(mis->from_src_file, true);
> +        qemu_file_set_blocking(mis->from_src_file, true, &error_abort);
>  
>          /* Re-configure the return path */
>          mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
> @@ -4002,7 +4002,9 @@ void migration_connect(MigrationState *s, Error *error_in)
>      }
>  
>      migration_rate_set(rate_limit);
> -    qemu_file_set_blocking(s->to_dst_file, true);
> +    if (!qemu_file_set_blocking(s->to_dst_file, true, &local_err)) {
> +        goto fail;
> +    }
>  
>      /*
>       * Open the return path. For postcopy, it is used exclusively. For
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 45af9a361e..0172172343 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1909,7 +1909,7 @@ void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file)
>       * The new loading channel has its own threads, so it needs to be
>       * blocked too.  It's by default true, just be explicit.
>       */
> -    qemu_file_set_blocking(file, true);
> +    qemu_file_set_blocking(file, true, &error_abort);
>      mis->postcopy_qemufile_dst = file;
>      qemu_sem_post(&mis->postcopy_qemufile_dst_done);
>      trace_postcopy_preempt_new_channel();
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index d5c6e7ec61..0f4280df21 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -888,9 +888,9 @@ void qemu_put_counted_string(QEMUFile *f, const char *str)
>   *       both directions, and thus changing the blocking on the main
>   *       QEMUFile can also affect the return path.
>   */
> -void qemu_file_set_blocking(QEMUFile *f, bool block)
> +bool qemu_file_set_blocking(QEMUFile *f, bool block, Error **errp)
>  {
> -    qio_channel_set_blocking(f->ioc, block, NULL);
> +    return qio_channel_set_blocking(f->ioc, block, errp);
>  }
>  
>  /*
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index f5b9f430e0..c13c967167 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -71,7 +71,7 @@ void qemu_file_set_error(QEMUFile *f, int ret);
>  int qemu_file_shutdown(QEMUFile *f);
>  QEMUFile *qemu_file_get_return_path(QEMUFile *f);
>  int qemu_fflush(QEMUFile *f);
> -void qemu_file_set_blocking(QEMUFile *f, bool block);
> +bool qemu_file_set_blocking(QEMUFile *f, bool block, Error **errp);
>  int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
>  void qemu_set_offset(QEMUFile *f, off_t off, int whence);
>  off_t qemu_get_offset(QEMUFile *f);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index fabbeb296a..abe0547f9b 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2095,7 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       * Because we're a thread and not a coroutine we can't yield
>       * in qemu_file, and thus we must be blocking now.
>       */
> -    qemu_file_set_blocking(f, true);
> +    qemu_file_set_blocking(f, true, &error_fatal);
>  
>      /* TODO: sanity check that only postcopiable data will be loaded here */
>      load_res = qemu_loadvm_state_main(f, mis);
> @@ -2108,7 +2108,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
>      f = mis->from_src_file;
>  
>      /* And non-blocking again so we don't block in any cleanup */
> -    qemu_file_set_blocking(f, false);
> +    qemu_file_set_blocking(f, false, &error_fatal);
>  
>      trace_postcopy_ram_listen_thread_exit();
>      if (load_res < 0) {
> -- 
> 2.48.1
> 

-- 
Peter Xu


