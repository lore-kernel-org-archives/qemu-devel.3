Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32805C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 20:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMBnS-0004o0-0n; Tue, 25 Jun 2024 15:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMBcw-0001iD-Tp
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 15:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMBcE-0001yy-Gp
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 15:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719342779;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MqOsTVhRh+qzeWtmdXP730OjU9q+aqZySrMRTkLfOdg=;
 b=Pv3v49O1lBbAupsq6YlOupgav89iB+UmyOrgazR99KdWfBT0PK/SGZ+YuC8JoSkTrm7fOm
 WEo4d4NWQnuJg8wARqPvl5h91vF3KceAk35alppOqa87HXKv/+v3tBrWTDNC4ICHjjRk1L
 1W1GmImmM+IG7y1sN08dQNFdg41GfR8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-paJhIBc0PxKJFbGQsXKb3g-1; Tue,
 25 Jun 2024 15:12:56 -0400
X-MC-Unique: paJhIBc0PxKJFbGQsXKb3g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0D5A19560B5; Tue, 25 Jun 2024 19:12:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.31])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50703300021A; Tue, 25 Jun 2024 19:12:49 +0000 (UTC)
Date: Tue, 25 Jun 2024 20:12:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, peterx@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com
Subject: Re: [PATCH RFC 2/2] migration: abort on destination if switchover
 limit exceeded
Message-ID: <ZnsWrm5CRj6cR3Zg@redhat.com>
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-3-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621143221.198784-3-elena.ufimtseva@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Jun 21, 2024 at 07:32:21AM -0700, Elena Ufimtseva wrote:
> During live migration, receive current downtime from source
> and start a downtime timer. When the destination dowtime
> and added source downtime exceeds downtime limit for more
> than switchover limit, abort live migration on destination.
> 
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  migration/migration.c  |  2 ++
>  migration/migration.h  | 15 ++++++++++
>  migration/savevm.c     | 68 ++++++++++++++++++++++++++++++++++++++++++
>  migration/savevm.h     |  2 ++
>  migration/trace-events |  3 ++
>  5 files changed, 90 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 5cc304d2db..64d7290997 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -240,6 +240,8 @@ void migration_object_init(void)
>      current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
>  
>      current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
> +    /* Downtime will start when source sends its current downtime. */
> +    current_incoming->downtime_start = 0;
>  
>      migration_object_check(current_migration, &error_fatal);
>  
> diff --git a/migration/migration.h b/migration/migration.h
> index aa56b70795..06f4ebe214 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -230,6 +230,21 @@ struct MigrationIncomingState {
>  
>      /* Do exit on incoming migration failure */
>      bool exit_on_error;
> +
> +    /* Initial downtime on destination set by MIG_CMD_SEND_SRC_DOWNTIME */
> +    uint64_t downtime_start;
> +    /*
> +     * Current donwtime on destination that initially set equal to source by
> +     * MIG_CMD_SEND_SRC_DOWNTIME, then updated by destination itself.
> +     */
> +    uint64_t downtime_now;
> +    /*
> +     * Abort live migration on destination when current destination downtime
> +     * exceeds the abort_limit. abort_limit is being set by
> +     * MIG_CMD_SEND_SRC_DOWNTIME sent from source.
> +     */
> +    uint64_t abort_limit;
> +    uint64_t src_downtime;
>  };
>  
>  MigrationIncomingState *migration_incoming_get_current(void);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 031ab03915..f3b5ea98bf 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -90,6 +90,7 @@ enum qemu_vm_cmd {
>      MIG_CMD_ENABLE_COLO,       /* Enable COLO */
>      MIG_CMD_POSTCOPY_RESUME,   /* resume postcopy on dest */
>      MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
> +    MIG_CMD_SEND_SRC_DOWNTIME,    /* Send current downtime to dst */
>      MIG_CMD_MAX
>  };
>  
> @@ -109,6 +110,7 @@ static struct mig_cmd_args {
>      [MIG_CMD_POSTCOPY_RESUME]  = { .len =  0, .name = "POSTCOPY_RESUME" },
>      [MIG_CMD_PACKAGED]         = { .len =  4, .name = "PACKAGED" },
>      [MIG_CMD_RECV_BITMAP]      = { .len = -1, .name = "RECV_BITMAP" },
> +    [MIG_CMD_SEND_SRC_DOWNTIME] = { .len = -1, .name = "SEND_SRC_DOWNTIME" },
>      [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
>  };
>  
> @@ -1218,6 +1220,18 @@ void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name)
>      qemu_savevm_command_send(f, MIG_CMD_RECV_BITMAP, len + 1, (uint8_t *)buf);
>  }
>  
> +void qemu_savevm_send_downtime(QEMUFile *f, int64_t abort_limit_ms,
> +                               int64_t source_downtime)
> +{
> +    uint64_t tmp[2];
> +    tmp[0] = cpu_to_be64(abort_limit_ms);
> +    tmp[1] = cpu_to_be64(source_downtime);
> +
> +    trace_qemu_savevm_send_downtime(abort_limit_ms, source_downtime);
> +    qemu_savevm_command_send(f, MIG_CMD_SEND_SRC_DOWNTIME,
> +                             16, (uint8_t *)tmp);
> +}

Is having both the src and dst responsible to tracking downtime limit
introducing extra failure points ?

We know the src QEMU is reliably operating, but we don't know that the
dst QEMU will do so. If we give the dst responsibility for checking its
own downtime then that perhaps isn't robust aganist the dst deadlocking
or live-locking itself.

Is it better have the src exclusively responsible for tracking the
downtime limit, and have it send an "abort" message to the dst when
the limit is exceeded ? This process would require an explicit ack
from the src before the dst is permited to start its CPUs too.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


