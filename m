Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9BFC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 13:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to0dt-0003zx-EA; Fri, 28 Feb 2025 08:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1to0dr-0003zV-K3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:43:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1to0do-0004YR-If
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740750177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TyWgtBhqLFp9/pJ/Z2iQgW2W6aUjY3/y0JDAqtmLU7g=;
 b=ZUaX94+0SE7us/ifosGM++qslkpOhSYEajH3JcOIxnxelOuBmnx76MOph2a/MhARXaa83N
 Dovj83X5v8A4LFXZvRz6TGhUO7RiBGgZ0rybd3qzCzW/CoQiWCvccyDBhI/nM0AU2TwA0T
 IUmjpUEUZsYvmcyFwQWzqWvQ29jGCUg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-zXmraiM8O72P_RAWlMbb8Q-1; Fri, 28 Feb 2025 08:42:55 -0500
X-MC-Unique: zXmraiM8O72P_RAWlMbb8Q-1
X-Mimecast-MFC-AGG-ID: zXmraiM8O72P_RAWlMbb8Q_1740750175
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-47206d76457so48842651cf.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 05:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740750175; x=1741354975;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TyWgtBhqLFp9/pJ/Z2iQgW2W6aUjY3/y0JDAqtmLU7g=;
 b=XzJvk4ZYKsUcY158vYlM0lDvw7Dno+LtxCExPFsr0dQ3Hh6BgWdVTqg7OwTajg5tm9
 7MlvjP+Jcts2JBGBLbDJDP131DGwmGHsFpmC3X5CIg5KUtG4qlNUnavfTGDxsFjnGsNb
 YjXrLyQ5bgMX2ZwL84CK2NV76ibrFgEJFjP4H3p2cJ72NjNxo4Tazlxhd/X1yanGMkF/
 IoWpIUReQMEhxfTH1qKhMB4PLxgBQOKZrTcByWimDE9xUgSugI5fjs9zCYwWiXtvROjS
 /G0eOkgh6zSkZRzuc4/dHpm6r6TBA5gvEhPrt0E+hlxKe+wF0rO+A6rELug6xR4R2WxR
 5GYQ==
X-Gm-Message-State: AOJu0YycCWM/fOz4WnIsQdWbxQkd9WK+HzcwQ6cwZrYQeerS1t8xO2oa
 bajOSfGJi3IDgcgkf+1eaDqdQ/iwdmh11Im3FlE9AjCqU6ag5O/oPZ/VqJVXHh5Kzjpi4PLToXb
 8oM5l8wNK4i7QW0ogf3TcutMLOF36FIg25sV1LLzgumNjhYOSu+cv
X-Gm-Gg: ASbGnctn2EyggX/MhGyoNwbV2yG/D9IlYPhrc0GBqwG6XxcegRGwI9JBfxKtiHB3s/a
 1ZnqjWHM+EqVKRvYaFZAwfwyHci67ibRsxfjOGz7h8UUdAttzNTjSkf99rNRa0hrvPQSJD8kr+F
 HKPZw3WwDh42JdwC5Mop8nN+7SUgZ4bOOFbJDIKvphfWaCN7HG+GeJtb8C2ynAwX9KdnEWbCloS
 Yc3DehwJAYu2qGFheLB2dqbLdaYfJHXNT+nT+3kTRLI6lFxdZUGNgx8FC80yX9kEfnfVJCn3MfA
 MXwKI/Y=
X-Received: by 2002:ac8:5913:0:b0:471:ffbc:9d6 with SMTP id
 d75a77b69052e-474bc115370mr37743331cf.48.1740750175149; 
 Fri, 28 Feb 2025 05:42:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjNZRnQXG7a2ktaXiG1tP4UQiZBsUXcs4vJheNIeKcJksGI4W5xQBRGLQvWwmYqpq4cCinpQ==
X-Received: by 2002:ac8:5913:0:b0:471:ffbc:9d6 with SMTP id
 d75a77b69052e-474bc115370mr37742931cf.48.1740750174710; 
 Fri, 28 Feb 2025 05:42:54 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-474691a1f0fsm24884431cf.2.2025.02.28.05.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 05:42:53 -0800 (PST)
Date: Fri, 28 Feb 2025 08:42:50 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
Message-ID: <Z8G9Wj3DWSgdLkNQ@x1.local>
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250228121749.553184-6-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

On Fri, Feb 28, 2025 at 05:47:49PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> When Multifd and Postcopy migration is enabled together,
> before starting Postcopy phase, Multifd threads are shutdown.
> 
> But before this shutdown, we need to flush the Multifd channels
> on the source side and notify the destination migration thread
> to synchronise with the Multifd 'recv_x' threads, so that all
> the Multifd data is received and processed on the destination
> side, before Multifd threads are shutdown.
> 
> This synchronisation happens when the main migration thread
> waits for all the Multifd threads to receive their data.
> 
> Add 'MULTIFD_RECV_SYNC' migration command to notify the
> destination side to synchronise with Multifd threads.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>

Thanks for trying to grant me the credit, but.. I suggest not having a new
message at all.  We should be able to do multifd's flush and sync before VM
stopped in postcopy_start()..  So we can drop this line.

And whatever come up with, it needs to be with patch 2 because patch 2
currently is broken itself.

> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/migration.c      |  3 +++
>  migration/multifd-nocomp.c | 21 +++++++++++++++------
>  migration/multifd.c        |  1 +
>  migration/multifd.h        |  1 +
>  migration/savevm.c         | 13 +++++++++++++
>  migration/savevm.h         |  1 +
>  6 files changed, 34 insertions(+), 6 deletions(-)
> 
> v6: New patch, not from earlier versions.
> - https://lore.kernel.org/qemu-devel/20250215123119.814345-1-ppandit@redhat.com/T/#t
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 5db9e18272..65fc4f5eed 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3401,6 +3401,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>      if (!in_postcopy && must_precopy <= s->threshold_size
>          && can_switchover && qatomic_read(&s->start_postcopy)) {
>          if (migrate_multifd()) {
> +            multifd_send_flush();
> +            multifd_send_sync_main(MULTIFD_SYNC_LOCAL);
> +            qemu_savevm_send_multifd_recv_sync(s->to_dst_file);

And.. this is not what I meant..

So again, there're more than one way to make sure no multifd pages will
arrive during postcopy.

What I actually think the easiest is to do flush and sync once in
postcopy_start() as mentioned above.  I think that'll serialize with
postcopy messages later on the main channel, making sure all channels are
flushed before moving to postcopy work.

If you want to stick with shutdown channels, I'm OK.  But then we at least
need one message to say "the recv side finished joining all recv threads".
That needs to be an ACK sent from dest to src, not src to dest.

>              multifd_send_shutdown();
>          }
>          if (postcopy_start(s, &local_err)) {
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index d0edec7cd1..bbe07e4f7e 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -334,7 +334,7 @@ retry:
>       * After flush, always retry.
>       */
>      if (pages->block != block || multifd_queue_full(pages)) {
> -        if (!multifd_send(&multifd_ram_send)) {
> +        if (multifd_send_flush() < 0) {
>              return false;
>          }
>          goto retry;
> @@ -387,6 +387,18 @@ bool multifd_ram_sync_per_round(void)
>      return !migrate_multifd_flush_after_each_section();
>  }
>  
> +int multifd_send_flush(void)
> +{
> +    if (!multifd_payload_empty(multifd_ram_send)) {
> +        if (!multifd_send(&multifd_ram_send)) {
> +            error_report("%s: multifd_send fail", __func__);
> +            return -1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  int multifd_ram_flush_and_sync(QEMUFile *f)
>  {
>      MultiFDSyncReq req;
> @@ -396,11 +408,8 @@ int multifd_ram_flush_and_sync(QEMUFile *f)
>          return 0;
>      }
>  
> -    if (!multifd_payload_empty(multifd_ram_send)) {
> -        if (!multifd_send(&multifd_ram_send)) {
> -            error_report("%s: multifd_send fail", __func__);
> -            return -1;
> -        }
> +    if ((ret = multifd_send_flush()) < 0) {
> +        return ret;
>      }
>  
>      /* File migrations only need to sync with threads */
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 2bd8604ca1..8928ca2611 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1265,6 +1265,7 @@ static void *multifd_recv_thread(void *opaque)
>  
>      rcu_unregister_thread();
>      trace_multifd_recv_thread_end(p->id, p->packets_recved);
> +    qemu_sem_post(&multifd_recv_state->sem_sync);
>  
>      return NULL;
>  }
> diff --git a/migration/multifd.h b/migration/multifd.h
> index bff867ca6b..242b923633 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -361,6 +361,7 @@ static inline uint32_t multifd_ram_page_count(void)
>  
>  void multifd_ram_save_setup(void);
>  void multifd_ram_save_cleanup(void);
> +int multifd_send_flush(void);
>  int multifd_ram_flush_and_sync(QEMUFile *f);
>  bool multifd_ram_sync_per_round(void);
>  bool multifd_ram_sync_per_section(void);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 4046faf009..0b71e988ba 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -37,6 +37,7 @@
>  #include "migration/register.h"
>  #include "migration/global_state.h"
>  #include "migration/channel-block.h"
> +#include "multifd.h"
>  #include "ram.h"
>  #include "qemu-file.h"
>  #include "savevm.h"
> @@ -90,6 +91,7 @@ enum qemu_vm_cmd {
>      MIG_CMD_ENABLE_COLO,       /* Enable COLO */
>      MIG_CMD_POSTCOPY_RESUME,   /* resume postcopy on dest */
>      MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
> +    MIG_CMD_MULTIFD_RECV_SYNC, /* Sync multifd recv_x and main threads */
>      MIG_CMD_MAX
>  };
>  
> @@ -109,6 +111,7 @@ static struct mig_cmd_args {
>      [MIG_CMD_POSTCOPY_RESUME]  = { .len =  0, .name = "POSTCOPY_RESUME" },
>      [MIG_CMD_PACKAGED]         = { .len =  4, .name = "PACKAGED" },
>      [MIG_CMD_RECV_BITMAP]      = { .len = -1, .name = "RECV_BITMAP" },
> +    [MIG_CMD_MULTIFD_RECV_SYNC] = { .len = 0, .name = "MULTIFD_RECV_SYNC" },
>      [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
>  };
>  
> @@ -1201,6 +1204,12 @@ void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name)
>      qemu_savevm_command_send(f, MIG_CMD_RECV_BITMAP, len + 1, (uint8_t *)buf);
>  }
>  
> +void qemu_savevm_send_multifd_recv_sync(QEMUFile *f)
> +{
> +    /* TBD: trace_savevm_send_multifd_recv_sync(); */
> +    qemu_savevm_command_send(f, MIG_CMD_MULTIFD_RECV_SYNC, 0, NULL);
> +}
> +
>  bool qemu_savevm_state_blocked(Error **errp)
>  {
>      SaveStateEntry *se;
> @@ -2479,6 +2488,10 @@ static int loadvm_process_command(QEMUFile *f)
>      case MIG_CMD_RECV_BITMAP:
>          return loadvm_handle_recv_bitmap(mis, len);
>  
> +    case MIG_CMD_MULTIFD_RECV_SYNC:
> +        multifd_recv_sync_main();
> +        break;
> +
>      case MIG_CMD_ENABLE_COLO:
>          return loadvm_process_enable_colo(mis);
>      }
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 7957460062..91ae703925 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -53,6 +53,7 @@ void qemu_savevm_send_postcopy_listen(QEMUFile *f);
>  void qemu_savevm_send_postcopy_run(QEMUFile *f);
>  void qemu_savevm_send_postcopy_resume(QEMUFile *f);
>  void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name);
> +void qemu_savevm_send_multifd_recv_sync(QEMUFile *f);
>  
>  void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
>                                             uint16_t len,
> -- 
> 2.48.1
> 

-- 
Peter Xu


