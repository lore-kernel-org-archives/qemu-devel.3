Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5864E92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ3D-0002Jf-2m; Mon, 29 Dec 2025 14:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaJ2t-0001zS-Vj
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:36:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaJ2n-0008Ps-Vj
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767037000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UcjaE1We6/D6i3bWdqH0Bn2loG4hR3iqGdbVqVDOZu8=;
 b=UvTLU3fWEMlKYvDIUEi6xeQsFrxA8TIzHblH0fvJDGfmjDUNJBOmVoUJTYC5F/e6/vgaGA
 YC7e0LTefX4SSaIFtS7CgBRlEtuVkKSR7btiwoeYRNjaFxpNyjExdO7IcUytSBzX0BnIcq
 JhI3M8koKJrvPTmmyjo67v109jiwq94=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-6DF2boGsNyWLME0prV0etw-1; Mon, 29 Dec 2025 14:36:38 -0500
X-MC-Unique: 6DF2boGsNyWLME0prV0etw-1
X-Mimecast-MFC-AGG-ID: 6DF2boGsNyWLME0prV0etw_1767036998
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88a39993e5fso241113766d6.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767036998; x=1767641798; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UcjaE1We6/D6i3bWdqH0Bn2loG4hR3iqGdbVqVDOZu8=;
 b=su5NAwaZSfUDUBc5DjOc6ZElD31RclVElzyEPDvu8bJgk3kwOEKjqe7hZHFwwgeEr9
 qqKk5VmMQOcz5s5jkVGdXMz+AAu9Q/v/14qHWssCQMtzAfszbaAE/A3tq72NTwFcLIBg
 BFBJXuoSNI5RJCoe1pYI9w2zUGfsiR7DSfGWkwJ2b0rdzUm8jEdHgCQkBcaeYeMaUaA/
 iKbRHEGpHS7avQRKq2XUqH6P3rzufcdm3eZxTL4HeC+OyrHj1qhyti/O+jaExbvSm/V3
 s+dvVECJEVYA8DJBaQ4IP03mw9KR43ivL8qJt+dz+AwG+v/pE/jNdeDXloZb2nhfexga
 KswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767036998; x=1767641798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UcjaE1We6/D6i3bWdqH0Bn2loG4hR3iqGdbVqVDOZu8=;
 b=sjSyBr/HRgciIuYRGEGmicOapxkbBRvptGT24P0W3IxAXhHn+ZWWHU6LceUFPpi0hZ
 fMxjMi0vg9CkdexvA+6PdWwDd8iWfmB32bDolK5HHfCchLy2jo4iLjSyiQZoAWFWnnN5
 noyi4EDCCyG8FX0Kx6Q876IU5WUJJt/4cwtDTH4Fad2xU4hIZXp2WY02sPgjnmazoOoD
 /3XiS8ecTgC+nmL8W0nSxIjDbDIxR05SPxyulz0dSWBgnZGxLkWKxUneqGy4CrG0svTx
 kYS+G+xEftKAtYCccJ7wfCdt9Z/i2+zn2qUGeRI5kpOWMYMiqa6q/cBfzfKvXmHDCblr
 iD1Q==
X-Gm-Message-State: AOJu0YxiTvPC8ey1TTGmhoqIdP0kEqOkg+QYONdegF28bSqePPRcqovI
 g4mcI+w8oOe8YXbb+EJVQq7NNngPJ1//25qyhiH4O+zmb1slGwrv/CU1rpropNwU+jhXLfLvJcT
 VbuO5wZfI//R011zcc3B++1xfv+gA/217MS72nxr3rypNbasDy7seQFBiJdDOl6/u
X-Gm-Gg: AY/fxX4l492POWHzVFHRMORGFtvSm73Wn6BHxZqyzXGuCaTPxhZ0UdFt2UMmxExWKcQ
 UoWVGhvs9jXh7DJf6GNCo6yVX2k5eDyB/yYy4P0Q+uqvcctPjqum7CXWULy8f+hIx9ZjikZ7kaf
 xqBNVFlCk89501BegKowoTqVbHMli00TZ+MLvunSJsiaTWQKp1J/gaz6N2e1RndMp21wa9dL8d8
 18tM2oUSqqNZBGXHYO5e40WZsEmXFddAjnuK2jH3sZAxHAPECtrB0E4U6TZDqkyVTRttlP27E5l
 HVqAXYP5u3CIT818WcfiCmKof09pjECWVnM6MaGd6iLhs1xD0z62fhBkzNlsqoG8rDcNjhKMuA3
 OFv0=
X-Received: by 2002:a05:6214:e48:b0:88a:4391:59cc with SMTP id
 6a1803df08f44-88d868698f2mr498979546d6.50.1767036994100; 
 Mon, 29 Dec 2025 11:36:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyil408Lq+ZL8Z7DNlWY2vHGEiQROygBVecRabiNBy4/qyau/z0ipcTe8TaI5uR1961zrR+g==
X-Received: by 2002:a05:6214:e48:b0:88a:4391:59cc with SMTP id
 6a1803df08f44-88d868698f2mr498979246d6.50.1767036993548; 
 Mon, 29 Dec 2025 11:36:33 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d9a44fe52sm232667306d6.45.2025.12.29.11.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 11:36:33 -0800 (PST)
Date: Mon, 29 Dec 2025 14:36:32 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [RFC PATCH 14/25] migration: Remove QEMUFile from channel.c
Message-ID: <aVLYQGQo2gSRs7Xm@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Dec 26, 2025 at 06:19:16PM -0300, Fabiano Rosas wrote:
> Make channel.c deal only with QIOChannel objects. Move any handling of
> QEMUFile into migration.c. To achieve this in a clean way:
> 
> 1) Define a migration_outgoing_setup, analogous to
> migration_incoming_setup, responsible for creating the QEMUFile from
> the QIOChannel.
> 
> 2) Increase the scope of migration_incoming_setup to create not only
> the main channel, but all the others as well. That is currently being
> done at migration_ioc_process, so move the code.
> 
> 3) Adjust RDMA code to pass in the QIOChannel and remove some of the
> usage of QEMUFile.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.c   | 21 ++++++-----
>  migration/migration.c | 88 ++++++++++++++++++++++---------------------
>  migration/migration.h |  6 ++-
>  migration/multifd.c   |  7 ++--
>  migration/multifd.h   |  2 +-
>  migration/rdma.c      | 28 ++++----------
>  6 files changed, 73 insertions(+), 79 deletions(-)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index 7243b99108..af6c2cc76e 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -14,7 +14,6 @@
>  #include "channel.h"
>  #include "tls.h"
>  #include "migration.h"
> -#include "qemu-file.h"
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "io/channel-tls.h"
> @@ -34,6 +33,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      Error *local_err = NULL;
> +    uint8_t ch;
>  
>      trace_migration_set_incoming_channel(
>          ioc, object_get_typename(OBJECT(ioc)));
> @@ -42,9 +42,16 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>          migration_tls_channel_process_incoming(ioc, &local_err);
>      } else {
>          migration_ioc_register_yank(ioc);
> -        migration_ioc_process_incoming(ioc, &local_err);
> -    }
> +        ch = migration_ioc_process_incoming(ioc, &local_err);
> +        if (!ch) {
> +            goto out;
> +        }
>  
> +        if (migration_incoming_setup(ioc, ch, &local_err)) {
> +            migration_incoming_process();
> +        }
> +    }
> +out:
>      if (local_err) {
>          error_report_err(local_err);
>          migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
> @@ -75,14 +82,8 @@ void migration_channel_connect(MigrationState *s, QIOChannel *ioc)
>          return;
>      }
>  
> -    QEMUFile *f = qemu_file_new_output(ioc);
> -
>      migration_ioc_register_yank(ioc);
> -
> -    qemu_mutex_lock(&s->qemu_file_lock);
> -    s->to_dst_file = f;
> -    qemu_mutex_unlock(&s->qemu_file_lock);
> -
> +    migration_outgoing_setup(ioc);
>      migration_connect(s);
>  }
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 5c6c76f110..677581b5a5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -92,7 +92,7 @@ enum mig_rp_message_type {
>  };
>  
>  /* Migration channel types */
> -enum { CH_MAIN, CH_MULTIFD, CH_POSTCOPY };
> +enum { CH_NONE, CH_MAIN, CH_MULTIFD, CH_POSTCOPY };
>  
>  /* When we add fault tolerance, we could have several
>     migrations at once.  For now we don't need to add
> @@ -934,17 +934,48 @@ out:
>      migrate_incoming_unref_outgoing_state();
>  }
>  
> -/**
> - * migration_incoming_setup: Setup incoming migration
> - * @f: file for main migration channel
> - */
> -static void migration_incoming_setup(QEMUFile *f)
> +static bool migration_has_main_and_multifd_channels(void);
> +
> +bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> +    QEMUFile *f;
>  
> -    assert(!mis->from_src_file);
> -    mis->from_src_file = f;
> -    qemu_file_set_blocking(f, false, &error_abort);
> +    switch (channel) {
> +    case CH_MAIN:
> +        f = qemu_file_new_input(ioc);
> +        assert(!mis->from_src_file);
> +        mis->from_src_file = f;
> +        qemu_file_set_blocking(f, false, &error_abort);
> +        break;
> +
> +    case CH_MULTIFD:
> +        if (!multifd_recv_new_channel(ioc, errp)) {
> +            return false;
> +        }
> +        break;
> +
> +    case CH_POSTCOPY:
> +        assert(!mis->postcopy_qemufile_dst);
> +        f = qemu_file_new_input(ioc);
> +        postcopy_preempt_new_channel(mis, f);
> +        return false;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return migration_has_main_and_multifd_channels();
> +}
> +
> +void migration_outgoing_setup(QIOChannel *ioc)
> +{
> +    MigrationState *s = migrate_get_current();
> +    QEMUFile *f = qemu_file_new_output(ioc);
> +
> +    qemu_mutex_lock(&s->qemu_file_lock);
> +    s->to_dst_file = f;
> +    qemu_mutex_unlock(&s->qemu_file_lock);
>  }
>  
>  /* Returns true if recovered from a paused migration, otherwise false */
> @@ -990,12 +1021,6 @@ void migration_incoming_process(void)
>      qemu_coroutine_enter(co);
>  }
>  
> -void migration_fd_process_incoming(QEMUFile *f)
> -{
> -    migration_incoming_setup(f);
> -    migration_incoming_process();
> -}
> -
>  static bool migration_has_main_and_multifd_channels(void)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> @@ -1012,12 +1037,10 @@ static bool migration_has_main_and_multifd_channels(void)
>      return true;
>  }
>  
> -void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
> +uint8_t migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> -    Error *local_err = NULL;
> -    QEMUFile *f;
> -    uint8_t channel;
> +    uint8_t channel = CH_NONE;
>      uint32_t channel_magic = 0;
>      int ret = 0;
>  
> @@ -1036,7 +1059,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>              ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
>                                                sizeof(channel_magic), errp);
>              if (ret != 0) {
> -                return;
> +                goto out;
>              }
>  
>              channel_magic = be32_to_cpu(channel_magic);
> @@ -1051,7 +1074,6 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>                  channel = CH_MAIN;
>              } else {
>                  error_setg(errp, "unknown channel magic: %u", channel_magic);
> -                return;
>              }
>          } else if (mis->from_src_file && migrate_multifd()) {
>              /*
> @@ -1063,33 +1085,13 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>              channel = CH_MAIN;
>          } else {
>              error_setg(errp, "non-peekable channel used without multifd");
> -            return;
>          }
>      } else {
>          assert(migrate_postcopy_preempt());
>          channel = CH_POSTCOPY;
>      }
> -
> -    if (channel == CH_MAIN) {
> -        f = qemu_file_new_input(ioc);
> -        migration_incoming_setup(f);
> -    } else if (channel == CH_MULTIFD) {
> -        /* Multiple connections */
> -        multifd_recv_new_channel(ioc, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -    } else if (channel == CH_POSTCOPY) {
> -        assert(!mis->postcopy_qemufile_dst);
> -        f = qemu_file_new_input(ioc);
> -        postcopy_preempt_new_channel(mis, f);
> -        return;
> -    }
> -
> -    if (migration_has_main_and_multifd_channels()) {
> -        migration_incoming_process();
> -    }
> +out:
> +    return channel;
>  }
>  
>  /**
> diff --git a/migration/migration.h b/migration/migration.h
> index f340cd518d..d2b82cf54f 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -526,8 +526,10 @@ struct MigrationState {
>  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>                         MigrationStatus new_state);
>  
> -void migration_fd_process_incoming(QEMUFile *f);
> -void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
> +void migration_outgoing_setup(QIOChannel *ioc);
> +bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
> +
> +uint8_t migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>  void migration_incoming_process(void);
>  
>  bool  migration_has_all_channels(void);
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 3fb1a07ba9..c6639dbab5 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1521,7 +1521,7 @@ bool multifd_recv_all_channels_created(void)
>   * Try to receive all multifd channels to get ready for the migration.
>   * Sets @errp when failing to receive the current channel.
>   */
> -void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>  {
>      MultiFDRecvParams *p;
>      Error *local_err = NULL;
> @@ -1536,7 +1536,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>                                      "failed to receive packet"
>                                      " via multifd channel %d: ",
>                                      qatomic_read(&multifd_recv_state->count));
> -            return;
> +            return false;
>          }
>          trace_multifd_recv_new_channel(id);
>      } else {
> @@ -1549,7 +1549,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>                     id);
>          multifd_recv_terminate_threads(error_copy(local_err));
>          error_propagate(errp, local_err);
> -        return;
> +        return false;
>      }
>      p->c = ioc;
>      object_ref(OBJECT(ioc));
> @@ -1558,4 +1558,5 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>      qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
>                         QEMU_THREAD_JOINABLE);
>      qatomic_inc(&multifd_recv_state->count);
> +    return true;
>  }
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 9b6d81e7ed..89a395aef2 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -42,7 +42,7 @@ int multifd_recv_setup(Error **errp);
>  void multifd_recv_cleanup(void);
>  void multifd_recv_shutdown(void);
>  bool multifd_recv_all_channels_created(void);
> -void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>  void multifd_recv_sync_main(void);
>  int multifd_send_sync_main(MultiFDSyncReq req);
>  bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 596a1aba0b..7bee871e2b 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -384,7 +384,6 @@ struct QIOChannelRDMA {
>      QIOChannel parent;
>      RDMAContext *rdmain;
>      RDMAContext *rdmaout;
> -    QEMUFile *file;
>      bool blocking; /* XXX we don't actually honour this yet */
>  };
>  
> @@ -3836,32 +3835,20 @@ static void qio_channel_rdma_register_types(void)
>  
>  type_init(qio_channel_rdma_register_types);
>  
> -static QEMUFile *rdma_new_input(RDMAContext *rdma)
> +static QIOChannel *rdma_new_ioc(RDMAContext *rdma)
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
>  
> -    rioc->file = qemu_file_new_input(QIO_CHANNEL(rioc));
> -    rioc->rdmain = rdma;
> -    rioc->rdmaout = rdma->return_path;
> -
> -    return rioc->file;
> -}
> -
> -static QEMUFile *rdma_new_output(RDMAContext *rdma)
> -{
> -    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
> -
> -    rioc->file = qemu_file_new_output(QIO_CHANNEL(rioc));
>      rioc->rdmaout = rdma;
>      rioc->rdmain = rdma->return_path;

Likely it was overlooked rdmaout/rdmain was set in reverse order in these
two functions.  I gave it a quick run on rdma and it was indeed broken
starting from this patch.

The goal of the change looks reasonable in general otherwise, said that,
maybe there's way to split the patch somehow?

>  
> -    return rioc->file;
> +    return QIO_CHANNEL(rioc);
>  }
>  
>  static void rdma_accept_incoming_migration(void *opaque)
>  {
>      RDMAContext *rdma = opaque;
> -    QEMUFile *f;
> +    QIOChannel *ioc;
>  
>      trace_qemu_rdma_accept_incoming_migration();
>      if (qemu_rdma_accept(rdma) < 0) {
> @@ -3875,15 +3862,16 @@ static void rdma_accept_incoming_migration(void *opaque)
>          return;
>      }
>  
> -    f = rdma_new_input(rdma);
> -    if (f == NULL) {
> +    ioc = rdma_new_ioc(rdma);
> +    if (!ioc) {
>          error_report("RDMA ERROR: could not open RDMA for input");
>          qemu_rdma_cleanup(rdma);
>          return;
>      }
>  
>      rdma->migration_started_on_destination = 1;
> -    migration_fd_process_incoming(f);
> +    migration_incoming_setup(ioc, 0, NULL);
> +    migration_incoming_process();
>  }
>  
>  void rdma_start_incoming_migration(InetSocketAddress *host_port,
> @@ -3995,8 +3983,8 @@ void rdma_start_outgoing_migration(void *opaque,
>  
>      trace_rdma_start_outgoing_migration_after_rdma_connect();
>  
> -    s->to_dst_file = rdma_new_output(rdma);
>      s->rdma_migration = true;
> +    migration_outgoing_setup(rdma_new_ioc(rdma));
>      migration_connect(s);
>      return;
>  return_path_err:
> -- 
> 2.51.0
> 

-- 
Peter Xu


