Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5488CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 15:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzzH-0001kW-01; Tue, 09 Sep 2025 11:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvzyp-0001eH-RL
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvzyc-0001k4-Vj
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757430582;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=pNTA39Ma22m3I4kpLDlrwUh4Zam9d90sIEaKtBgFvS4=;
 b=EVcO8WZ9GxZdVUrUswMLWV1ZW3XUTPVE6DwU1HfA7/GSBbkALe+qP1FkHirZLd41PKhU1Q
 wL0kEldcMUrjql/jvUx2IW+pOvhH/7PFMUyic1byT2gnByk7gijlKD3k8rxA3Qvvvjc1zP
 W16YMvzzboY9EVCcM9/87t1Y93C2/oQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-vX12W0mLNXCS3431OOeaAQ-1; Tue,
 09 Sep 2025 11:09:38 -0400
X-MC-Unique: vX12W0mLNXCS3431OOeaAQ-1
X-Mimecast-MFC-AGG-ID: vX12W0mLNXCS3431OOeaAQ_1757430576
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBA6F19560AD; Tue,  9 Sep 2025 15:09:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FA6D180035C; Tue,  9 Sep 2025 15:09:28 +0000 (UTC)
Date: Tue, 9 Sep 2025 16:09:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <aMBDIwKDxTVrBJBQ@redhat.com>
References: <20250909150127.1494626-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909150127.1494626-1-jmarcin@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 09, 2025 at 05:01:24PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> Usual system defaults for TCP keep-alive options are too long for
> migration workload. On Linux, a TCP connection waits idle for 2 hours
> before it starts checking if the connection is not broken.
> 
> Now when InetSocketAddress supports keep-alive options [1], this patch
> applies migration specific defaults if they are not supplied by the user
> or the management software. With these defaults, a migration TCP stream
> waits idle for 1 minute and then sends 5 TCP keep-alive packets in 30
> second interval before considering the connection as broken.
> 
> System defaults can be still used by explicitly setting these parameters
> to 0.

IMHO this is not a good idea. This is a very short default, which
may be fine for the scenario where your network conn is permanently
dead, but it is going to cause undesirable failures when the network
conn is only temporarily dead.

Optimizing defaults for temporary outages is much more preferrable
as that maximises reliability of migration. In the case of permanent
outages, it is already possible to tear down the connection without
waiting for a keep-alive timeout, and liveliness checks can also be
perform by the mgmt app at a higher level too. The TCP keepalives
are just an eventual failsafe, and having those work on a long
timeframe is OK.

> 
> [1]: 1bd4237cb1 "util/qemu-sockets: Introduce inet socket options
>      controlling TCP keep-alive"
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/migration.c | 39 +++++++++++++++++++++++++++++++++++++++
>  qapi/migration.json   |  6 ++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25d..a1f1223946 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -74,6 +74,11 @@
>  
>  #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
>  
> +#define INET_SOCKET_DEFAULT_KEEP_ALIVE true
> +#define INET_SOCKET_DEFAULT_KEEP_ALIVE_COUNT 5
> +#define INET_SOCKET_DEFAULT_KEEP_ALIVE_IDLE 60
> +#define INET_SOCKET_DEFAULT_KEEP_ALIVE_INTERVAL 30
> +
>  static NotifierWithReturnList migration_state_notifiers[] = {
>      NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
>      NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
> @@ -718,6 +723,36 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>      return true;
>  }
>  
> +static void migration_address_apply_defaults(MigrationAddress *addr)
> +{
> +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
> +        addr->u.socket.type == SOCKET_ADDRESS_TYPE_INET) {
> +        InetSocketAddress *inet = &addr->u.socket.u.inet;
> +        if (!inet->has_keep_alive) {
> +            inet->has_keep_alive = true;
> +            inet->keep_alive = INET_SOCKET_DEFAULT_KEEP_ALIVE;
> +        }
> +#ifdef HAVE_TCP_KEEPCNT
> +        if (!inet->has_keep_alive_count) {
> +            inet->has_keep_alive_count = true;
> +            inet->keep_alive_count = INET_SOCKET_DEFAULT_KEEP_ALIVE_COUNT;
> +        }
> +#endif
> +#ifdef HAVE_TCP_KEEPIDLE
> +        if (!inet->has_keep_alive_idle) {
> +            inet->has_keep_alive_idle = true;
> +            inet->keep_alive_idle = INET_SOCKET_DEFAULT_KEEP_ALIVE_IDLE;
> +        }
> +#endif
> +#ifdef HAVE_TCP_KEEPINTVL
> +        if (!inet->has_keep_alive_interval) {
> +            inet->has_keep_alive_interval = true;
> +            inet->keep_alive_interval = INET_SOCKET_DEFAULT_KEEP_ALIVE_INTERVAL;
> +        }
> +#endif
> +    }
> +}
> +
>  static bool
>  migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
>  {
> @@ -775,6 +810,8 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>          addr = channel->addr;
>      }
>  
> +    migration_address_apply_defaults(addr);
> +
>      /* transport mechanism not suitable for migration? */
>      if (!migration_transport_compatible(addr, errp)) {
>          return;
> @@ -2232,6 +2269,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>          addr = channel->addr;
>      }
>  
> +    migration_address_apply_defaults(addr);
> +
>      /* transport mechanism not suitable for migration? */
>      if (!migration_transport_compatible(addr, errp)) {
>          return;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 2387c21e9c..68d4acb5db 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1639,6 +1639,12 @@
>  #
>  # Migration endpoint configuration.
>  #
> +# If transport is socket of type inet, it has the following defaults:
> +# keep-alive: true, keep-alive-count: 5, keep-alive-idle: 60 seconds,
> +# keep-alive-interval: 30 seconds.  System defaults can be used by
> +# explicitly setting these parameters to 0.  See `InetSocketAddress` for
> +# more details.
> +#
>  # @transport: The migration stream transport mechanism
>  #
>  # Since: 8.2
> -- 
> 2.51.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


