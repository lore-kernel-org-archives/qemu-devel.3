Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9202C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 14:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s006D-0002YK-Fj; Thu, 25 Apr 2024 10:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s0069-0002Xj-EY
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 10:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s0063-00074O-7K
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 10:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714055349;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=x+WV8sZDyNChXVySxfCBNHBL9rUb2duOrWyO26cxGR4=;
 b=DK8dxjdUx4QV86m9Dfof0Xr4mbY3iG8NlsGOky5GWkMBimuhVWUwMSsGi3syRoS74TWbkA
 8yvJ7JxTTnnoWX1QUflihRVmNHKmX6JpG6no6ViMsjtHF/CSi2dQf+a7nVeUL6ONmU7CRH
 6HW2pdNHvGx/MEWU6PmYIZN1Ow2W9Lo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-SEwdvfLzNlif3l_fJcWDBw-1; Thu,
 25 Apr 2024 10:29:07 -0400
X-MC-Unique: SEwdvfLzNlif3l_fJcWDBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 776DF28EC106;
 Thu, 25 Apr 2024 14:29:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03B6A40C6CC1;
 Thu, 25 Apr 2024 14:29:05 +0000 (UTC)
Date: Thu, 25 Apr 2024 15:29:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hao Xiang <hao.xiang@linux.dev>
Cc: marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 armbru@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 10/14] migration/multifd: Enable DSA offloading in
 multifd sender path.
Message-ID: <ZiposIaLQTJUiEFk@redhat.com>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
 <20240425022117.4035031-11-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240425022117.4035031-11-hao.xiang@linux.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 25, 2024 at 02:21:13AM +0000, Hao Xiang wrote:
> Multifd sender path gets an array of pages queued by the migration
> thread. It performs zero page checking on every page in the array.
> The pages are classfied as either a zero page or a normal page. This
> change uses Intel DSA to offload the zero page checking from CPU to
> the DSA accelerator. The sender thread submits a batch of pages to DSA
> hardware and waits for the DSA completion thread to signal for work
> completion.
> 
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> ---
>  migration/multifd-zero-page.c | 99 +++++++++++++++++++++++++++++++++--
>  migration/multifd.c           | 27 +++++++++-
>  migration/multifd.h           |  1 +
>  3 files changed, 120 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
> index e1b8370f88..4f426289e4 100644
> --- a/migration/multifd-zero-page.c
> +++ b/migration/multifd-zero-page.c

> diff --git a/migration/multifd.c b/migration/multifd.c
> index cfd3a92f6c..7316643d0a 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -818,6 +818,8 @@ void multifd_send_shutdown(void)
>  
>      multifd_send_terminate_threads();
>  
> +    dsa_cleanup();
> +
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>          Error *local_err = NULL;
> @@ -1155,11 +1157,20 @@ bool multifd_send_setup(void)
>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>      bool use_packets = multifd_use_packets();
>      uint8_t i;
> +    const char *dsa_parameter = migrate_multifd_dsa_accel();
>  
>      if (!migrate_multifd()) {
>          return true;
>      }
>  
> +    if (dsa_init(dsa_parameter)) {
> +        error_setg(&local_err, "multifd: Sender failed to initialize DSA.");
> +        error_report_err(local_err);
> +        return false;
> +    }

This is an example of why all the dsa functions need to report
a via an "Error **err" parameter. The error reported
here is useless as it lacks any meaningful information of what
went wrong.

The multifd_send_setup method itself needs a "Error **errp"
param so it can pass it back up to be reoprted too.

> +
> +    dsa_start();
> +
>      thread_count = migrate_multifd_channels();
>      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
> @@ -1393,6 +1404,7 @@ void multifd_recv_cleanup(void)
>              qemu_thread_join(&p->thread);
>          }
>      }
> +    dsa_cleanup();
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
>      }
> @@ -1568,6 +1580,9 @@ int multifd_recv_setup(Error **errp)
>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>      bool use_packets = multifd_use_packets();
>      uint8_t i;
> +    const char *dsa_parameter = migrate_multifd_dsa_accel();
> +    int ret;
> +    Error *local_err = NULL;
>  
>      /*
>       * Return successfully if multiFD recv state is already initialised
> @@ -1577,6 +1592,15 @@ int multifd_recv_setup(Error **errp)
>          return 0;
>      }
>  
> +    ret = dsa_init(dsa_parameter);
> +    if (ret != 0) {
> +        error_setg(&local_err, "multifd: Receiver failed to initialize DSA.");
> +        error_propagate(errp, local_err);
> +        return ret;
> +    }
> +
> +    dsa_start();
> +
>      thread_count = migrate_multifd_channels();
>      multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
>      multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
> @@ -1616,13 +1640,12 @@ int multifd_recv_setup(Error **errp)
>  
>      for (i = 0; i < thread_count; i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
> -        int ret;
> -
>          ret = multifd_recv_state->ops->recv_setup(p, errp);
>          if (ret) {
>              return ret;
>          }
>      }
> +
>      return 0;
>  }
>  
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 16e27db5e9..b3717fae24 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -14,6 +14,7 @@
>  #define QEMU_MIGRATION_MULTIFD_H
>  
>  #include "ram.h"
> +#include "qemu/dsa.h"
>  
>  typedef struct MultiFDRecvData MultiFDRecvData;
>  
> -- 
> 2.30.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


