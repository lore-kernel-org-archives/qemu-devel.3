Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AC3C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2TR-0000yw-Pc; Tue, 10 Jun 2025 13:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uP2TP-0000yS-Qy
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uP2TN-0005mH-Iw
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749575356;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QJ7wO+3yOGVnpnCn3mB53ROGNUHE+f/tQZm7nXCX5fM=;
 b=hesQDKeKZLElfLjgzyfRdqIgQvZ36Q/eN9XbiP4NSH4XdQfH3ehaTNtbH7bpw5ksNrLsXG
 TywfwT5pbJw5+jSIArA5WyWRb7g+7La72cYX1oknLw8QXDM3a1P527zQCusMFIrAJM/sLg
 Xx5Z0ciubZEytB7/4jKblxGCx0WiLCs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-hpKtuTELObq6vhi7Cd7v-Q-1; Tue,
 10 Jun 2025 13:09:12 -0400
X-MC-Unique: hpKtuTELObq6vhi7Cd7v-Q-1
X-Mimecast-MFC-AGG-ID: hpKtuTELObq6vhi7Cd7v-Q_1749575351
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 554E819560B6; Tue, 10 Jun 2025 17:09:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE52530001B1; Tue, 10 Jun 2025 17:09:07 +0000 (UTC)
Date: Tue, 10 Jun 2025 18:09:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, steven.sistare@oracle.com,
 peterx@redhat.com, farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v2] migration: Setup pre-listened cpr.sock to remove
 race-condition.
Message-ID: <aEhmsFsmsoFpwWSf@redhat.com>
References: <20250610150849.326194-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610150849.326194-1-jhkim@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jun 10, 2025 at 10:08:49AM -0500, Jaehoon Kim wrote:
> When the source VM attempts to connect to the destination VM's Unix
> domain socket (cpr.sock) during a cpr-transfer test, race conditions can
> occur if the socket file isn't ready. This can lead to connection
> failures when running tests.
> 
> This patch creates and listens on the socket in advance, and passes the
> pre-listened FD directly. This avoids timing issues and improves the
> reliability of CPR tests.
> 
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> 
> ---
> Changes since v1:
> - In v1, the patch added a wait loop to poll the existence of the socket
>   file (cpr_validate_socket_path()).
> 
> - This version instead creates the socket beforehand and passes its FD
>   to the destination QEMU, eliminating the race condition entirely.
> 
> - Commit title and message changed accordingly.
> ---
>  migration/cpr-transfer.c          |  3 +-
>  tests/qtest/migration/cpr-tests.c | 72 ++++++++++++++++++++++++++++++-
>  2 files changed, 72 insertions(+), 3 deletions(-)

> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> index 5536e14610..6f90160e21 100644
> --- a/tests/qtest/migration/cpr-tests.c
> +++ b/tests/qtest/migration/cpr-tests.c
> @@ -50,6 +50,51 @@ static void *test_mode_transfer_start(QTestState *from, QTestState *to)
>      return NULL;
>  }
>  
> +/*
> + * Create a pre-listened UNIX domain socket at the specified path.
> + *
> + * This is used to eliminate a race condition that can occur
> + * intermittently in qtest during CPR tests. By pre-creating and
> + * listening on the socket, we avoid timing-related issues.
> + */
> +static int setup_socket_listener(const char *path)
> +{
> +    struct sockaddr_un un;
> +    size_t pathlen;
> +    int sock_fd;
> +
> +    sock_fd = socket(PF_UNIX, SOCK_STREAM, 0);
> +    if (sock_fd < 0) {
> +        g_test_message("Failed to create Unix socket");
> +        return -1;
> +    }
> +
> +    pathlen = strlen(path);
> +    if (pathlen >= sizeof(un.sun_path)) {
> +        g_test_message("UNIX socket path '%s' is too long", path);
> +        close(sock_fd);
> +        return -1;
> +    }
> +
> +    memset(&un, 0, sizeof(un));
> +    un.sun_family = AF_UNIX;
> +    strncpy(un.sun_path, path, sizeof(un.sun_path) - 1);
> +
> +    if (bind(sock_fd, (struct sockaddr *)&un, sizeof(un)) < 0) {
> +        g_test_message("Failed to bind socket to %s", path);
> +        close(sock_fd);
> +        return -1;
> +    }
> +
> +    if (listen(sock_fd, 1) < 0) {
> +        g_test_message("Failed to listen on socket %s", path);
> +        close(sock_fd);
> +        return -1;
> +    }
> +
> +    return sock_fd;
> +}

This is effectively re-implementing 'unix_listen', so just use
that function.

> @@ -75,6 +120,29 @@ static void test_mode_transfer_common(bool incoming_defer)
>          "              'path': '%s' } } ]",
>          mig_path);
>  
> +    /*
> +     * Determine socket address type and value.
> +     * If socket creation fails, provide the socket path to the target,
> +     * so it can create the Unix domain socket itself.
> +     * Otherwise, use the pre-listened socket file descriptor directly.
> +     */
> +    int cpr_sockfd = setup_socket_listener(cpr_path);
> +
> +    if (cpr_sockfd < 0) {

A failure of this function (or in future 'unix_listen') shouldn't
trigger any fallback logic - we should report it and fail thue
test.

> +        addr_type = g_strdup("unix");
> +        addr_key = g_strdup("path");
> +        addr_value = g_strdup(cpr_path);
> +    } else {
> +        addr_type = g_strdup("fd");
> +        addr_key = g_strdup("str");
> +        addr_value = g_strdup_printf("%d", cpr_sockfd);
> +    }
> +
> +    opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
> +                                  "addr.type=%s,addr.%s=%s %s",
> +                                  addr_type, addr_key, addr_value, opts);
> +
> +
>      MigrateCommon args = {
>          .start.opts_source = opts,
>          .start.opts_target = opts_target,
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


