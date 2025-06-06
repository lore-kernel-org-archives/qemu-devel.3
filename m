Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6DCC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNXWV-0004Vm-Ph; Fri, 06 Jun 2025 09:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNXWT-0004VF-1V
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNXWM-0006d3-Ec
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749218045;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hcQn31tRM4bZxgiO8Fg1CU1z1Neo2FU6ONcj4JrBxd4=;
 b=Y6XpvTQ/TiPFm/kjxrpfwruawOzWJ5cleVkengadJi//c7xJpilwY83KlbvdruoWprCZFU
 bfsNrZudebApAHJ3tNfY5vtHJwWhyQC+QWPpGtOK+94h3lxY3Pv1W0/mcgdUvd0Qxy+kQe
 GC+R9FN09F8aNG5+hXsqGr12PFPn88I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-7d-bDAISPWqs__5_2giQrw-1; Fri,
 06 Jun 2025 09:54:04 -0400
X-MC-Unique: 7d-bDAISPWqs__5_2giQrw-1
X-Mimecast-MFC-AGG-ID: 7d-bDAISPWqs__5_2giQrw_1749218043
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 564AA18002B9; Fri,  6 Jun 2025 13:54:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23E491956087; Fri,  6 Jun 2025 13:53:59 +0000 (UTC)
Date: Fri, 6 Jun 2025 14:53:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, steven.sistare@oracle.com,
 peterx@redhat.com, farosas@suse.de
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
Message-ID: <aELy8_1ssb1jTSTa@redhat.com>
References: <20250605230808.1278840-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250605230808.1278840-1-jhkim@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 05, 2025 at 06:08:08PM -0500, Jaehoon Kim wrote:
> When the source VM attempts to connect to the destination VM's Unix
> domain socket(cpr.sock) during CPR transfer, the socket file might not
> yet be exist if the destination side hasn't completed the bind
> operation. This can lead to connection failures when running tests with
> the qtest framework.

This sounds like a flawed test impl to me - whatever is initiating
the cpr operation on the source has done so prematurely - it should
ensure the dest is ready before starting the operation.

> To address this, add cpr_validate_socket_path(), which wait for the
> socket file to appear. This avoids intermittent qtest failures caused by
> early connection attempts.

IMHO it is dubious to special case cpr in this way.

> 
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  include/migration/cpr.h  |  1 +
>  migration/cpr-transfer.c | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index 7561fc75ad..cc9384b4f9 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -23,6 +23,7 @@ MigMode cpr_get_incoming_mode(void);
>  void cpr_set_incoming_mode(MigMode mode);
>  bool cpr_is_incoming(void);
>  
> +bool cpr_validate_socket_path(const char *path, Error **errp);
>  int cpr_state_save(MigrationChannel *channel, Error **errp);
>  int cpr_state_load(MigrationChannel *channel, Error **errp);
>  void cpr_state_close(void);
> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
> index e1f140359c..3088ed323f 100644
> --- a/migration/cpr-transfer.c
> +++ b/migration/cpr-transfer.c
> @@ -17,6 +17,33 @@
>  #include "migration/vmstate.h"
>  #include "trace.h"
>  
> +#define CPR_MAX_RETRIES     50     /* Retry for up to 5 seconds */
> +#define CPR_RETRY_DELAY_US  100000 /* 100 ms per retry */
> +
> +bool cpr_validate_socket_path(const char *path, Error **errp)
> +{
> +    struct stat st;
> +    int retries = CPR_MAX_RETRIES;
> +
> +    do {
> +        if (!stat(path, &st) && S_ISSOCK(st.st_mode)) {
> +            return true;
> +        }
> +
> +        if (errno == ENOENT) {
> +            usleep(CPR_RETRY_DELAY_US);
> +        } else {
> +            error_setg_errno(errp, errno,
> +                "Unable to check status of socket path '%s'", path);
> +            return false;
> +        }
> +    } while (--retries > 0);
> +
> +    error_setg(errp, "Socket path '%s' not found after %d retries",
> +                                            path, CPR_MAX_RETRIES);
> +    return false;
> +}
> +
>  QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
>  {
>      MigrationAddress *addr = channel->addr;
> @@ -28,6 +55,14 @@ QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
>          QIOChannel *ioc = QIO_CHANNEL(sioc);
>          SocketAddress *saddr = &addr->u.socket;
>  
> +        /*
> +         * Verify that the cpr.sock Unix domain socket file exists and is ready
> +         * before proceeding with the connection.
> +         */
> +        if (!cpr_validate_socket_path(addr->u.socket.u.q_unix.path, errp)) {
> +            return NULL;
> +        }
> +
>          if (qio_channel_socket_connect_sync(sioc, saddr, errp) < 0) {
>              return NULL;
>          }
> -- 
> 2.49.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


