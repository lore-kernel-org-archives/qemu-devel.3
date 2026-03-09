Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4611DF41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdmu-0006xZ-4U; Mon, 09 Mar 2026 12:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzdmn-0006wL-3x
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzdmk-0001LP-F3
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773074928;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=u/5sTxNkLipveInyYDbP47kBAefJAVNkj2HQkHR3O5s=;
 b=YXO/8ddHfqX9xOrMpS3dKeHYR5evPK5I2AHAOCh75pfcnHO/tluwOByZQTYEIATbimfZJs
 3AgBhDYkOW5xX0c8I2T9dpjVfXraq9xvhsYGtvm0FelCATsCHc0Jyk7BU/kJgv5gmD36WH
 tlV3NxKfROtHA7YNi/+p4eRU9EfbAbQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-aPYZ9XQAMXG1AhWfBQm2HQ-1; Mon,
 09 Mar 2026 12:48:45 -0400
X-MC-Unique: aPYZ9XQAMXG1AhWfBQm2HQ-1
X-Mimecast-MFC-AGG-ID: aPYZ9XQAMXG1AhWfBQm2HQ_1773074924
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1E5F1800345; Mon,  9 Mar 2026 16:48:43 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.95])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44F961800351; Mon,  9 Mar 2026 16:48:40 +0000 (UTC)
Date: Mon, 9 Mar 2026 16:48:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/1] io: make zerocopy fallback accounting more accurate
Message-ID: <aa755Yc6t_bBzM_u@redhat.com>
References: <20260309090907.956330-1-tejus.gk@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260309090907.956330-1-tejus.gk@nutanix.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Mon, Mar 09, 2026 at 09:09:01AM +0000, Tejus GK wrote:
> Currently, the dirty-sync-missed-zero-copy stat is incremented only when
> an entire batch of IO operations fails to use zerocopy and falls back to
> a normal copy. As long as at least one IO in the batch is successfully
> zero-copied, the whole batch is treated as a success. This hides
> individual IO fallbacks and makes the migration stat less accurate than
> it could be.
> 
> Make the stat more accurate by reporting at a finer granularity, i.e, by
> incrementing for every individual IO fallback that occurs.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
> ---
>  include/io/channel-socket.h |  6 +-----
>  include/io/channel.h        |  5 ++---
>  io/channel-socket.c         | 13 ++++---------
>  migration/multifd.c         |  8 +++++---
>  qapi/migration.json         |  3 +--
>  5 files changed, 13 insertions(+), 22 deletions(-)
> 
> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> index a1ef3136ea..5c5714668e 100644
> --- a/include/io/channel-socket.h
> +++ b/include/io/channel-socket.h
> @@ -50,11 +50,7 @@ struct QIOChannelSocket {
>      ssize_t zero_copy_queued;
>      ssize_t zero_copy_sent;
>      bool blocking;
> -    /**
> -     * This flag indicates whether any new data was successfully sent with
> -     * zerocopy since the last qio_channel_socket_flush() call.
> -     */
> -    bool new_zero_copy_sent_success;
> +    ssize_t zero_copy_fallback;
>  };
>  
>  
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 1b02350437..70f701ae16 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -1013,9 +1013,8 @@ int coroutine_mixed_fn qio_channel_writev_full_all(QIOChannel *ioc,
>   *
>   * If not implemented, acts as a no-op, and returns 0.
>   *
> - * Returns -1 if any error is found,
> - *          1 if every send failed to use zero copy.
> - *          0 otherwise.
> + * Returns -1 if any error is found, otherwise returns a non-negative number
> + * indicating the number of IO requests that fell back to copy.

IIUC that is *not* what the code is actually counting though.....

>   */
>  
>  int qio_channel_flush(QIOChannel *ioc,
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 3053b35ad8..08b9862074 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -72,7 +72,7 @@ qio_channel_socket_new(void)
>      sioc->zero_copy_queued = 0;
>      sioc->zero_copy_sent = 0;
>      sioc->blocking = false;
> -    sioc->new_zero_copy_sent_success = false;
> +    sioc->zero_copy_fallback = 0;
>  
>      ioc = QIO_CHANNEL(sioc);
>      qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
> @@ -881,8 +881,8 @@ static int qio_channel_socket_flush_internal(QIOChannel *ioc,
>          sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
>  
>          /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
> -        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> -            sioc->new_zero_copy_sent_success = true;
> +        if (serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED) {
> +            sioc->zero_copy_fallback++;

...this is counting the number of MSG_ERRQUEUE items, which is not
the same as the number of IO requests. That's why we only used it
as a boolean marker originally, rather than making it a counter.

>          }
>      }
>  
> @@ -900,12 +900,7 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>          return ret;
>      }
>  
> -    if (sioc->new_zero_copy_sent_success) {
> -        sioc->new_zero_copy_sent_success = false;
> -        return 0;
> -    }
> -
> -    return 1;
> +    return sioc->zero_copy_fallback;
>  }
>  
>  #endif /* QEMU_MSG_ZEROCOPY */
> diff --git a/migration/multifd.c b/migration/multifd.c
> index ad6261688f..726e40903d 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -593,7 +593,7 @@ void multifd_send_shutdown(void)
>  
>  static int multifd_zero_copy_flush(QIOChannel *c)
>  {
> -    int ret;
> +    ssize_t ret;
>      Error *err = NULL;
>  
>      ret = qio_channel_flush(c, &err);
> @@ -601,8 +601,10 @@ static int multifd_zero_copy_flush(QIOChannel *c)
>          error_report_err(err);
>          return -1;
>      }
> -    if (ret == 1) {
> -        qatomic_add(&mig_stats.dirty_sync_missed_zero_copy, 1);
> +
> +    if (qatomic_read(&mig_stats.dirty_sync_missed_zero_copy) != (uint64_t)ret) {
> +        /* Update statistics if more fallback detected */
> +        qatomic_set(&mig_stats.dirty_sync_missed_zero_copy, (uint64_t)ret);
>      }
>  
>      return ret;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index f925e5541b..94977b8810 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -58,8 +58,7 @@
>  #     (since 7.0).
>  #
>  # @dirty-sync-missed-zero-copy: Number of times dirty RAM
> -#     synchronization could not avoid copying dirty pages.  This is
> -#     between 0 and @dirty-sync-count * @multifd-channels.
> +#     synchronization could not avoid copying dirty pages.
>  #     (since 7.1)
>  #
>  # Since: 0.14
> -- 
> 2.43.7
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


