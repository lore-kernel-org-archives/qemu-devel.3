Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B3DD2F02C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkk0p-0004xj-VE; Tue, 27 Jan 2026 09:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vkk0k-0004uH-3E
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:25:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vkk0g-0003ES-6c
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769523933;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=H1GezABOOGXZv9b0RVpdOQPwD+G7E1Pv7u8uwZXBZqc=;
 b=HcRPmq0a1jYqbWMuJp/qUaWepvsGadJlu6TN96esYMKvEcVanGnH/ZEBw6LcGVCGq9vGBL
 vbXV52xzHxaoSLe4fc9uzhf82OEsur9tU5Obz9EtNdYn4pBIey3AMgC60iILtglNkWjU2w
 1v2PdEzjRQsCjWffal8ax1hIx7KmHv8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-UrpW5_bINKSgSbyER1OJCA-1; Tue,
 27 Jan 2026 09:25:31 -0500
X-MC-Unique: UrpW5_bINKSgSbyER1OJCA-1
X-Mimecast-MFC-AGG-ID: UrpW5_bINKSgSbyER1OJCA_1769523930
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B64918005B2; Tue, 27 Jan 2026 14:25:30 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.228])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B8251800285; Tue, 27 Jan 2026 14:25:26 +0000 (UTC)
Date: Tue, 27 Jan 2026 14:25:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 4/4] migration: Pass network packets received during
 switchover to dest VM
Message-ID: <aXjK01KuENw23xtV@redhat.com>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127140316.4187221-5-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127140316.4187221-5-jmarcin@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 27, 2026 at 03:03:10PM +0100, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> During migration switchover both the source and the destination machines
> are paused (compute downtime). During this period network still routes
> network packets to the source machine, as this is the last place where
> the recipient MAC address has been seen. Once the destination side
> starts and sends network announcement, all subsequent frames are routed
> correctly. However, frames delivered to the source machine are never
> processed and lost. This causes also a network downtime with roughly the
> same duration as compute downtime.
> 
> This can cause problems not only for protocols that cannot handle packet
> loss, but can also introduce delays in protocols that can handle them.
> 
> To resolve this, this feature instantiates a network filter for each
> network backend present during migration setup on both migration sides.
> On the source side, this filter caches all packets received from the
> backend during switchover. Once the destination machine starts, all
> cached packets are sent through the migration channel and the respective
> filter object on the destination side injects them to the NIC attached
> to the backend.

If the dest QEMU has started, I presume this means that the ARP
announcement has been sent ?   IOW, the packets being forwarded
over the migration stream are guaranteed to be delivered "out
of order" wrt the sender.  Should be safe for TCP, but may have
an impact on other protocols. Though apps should be aware of
that risk in general, they may not frequently encounter it, and
it could still cause service disruption

> diff --git a/qapi/migration.json b/qapi/migration.json
> index f925e5541b..d637b22c80 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -520,6 +520,11 @@
>  #     each RAM page.  Requires a migration URI that supports seeking,
>  #     such as a file.  (since 9.0)
>  #
> +# @netpass: Collect packets received by network backedns after source
> +#     VM is paused and send them to the destination once it resumes.
> +#     This (almost) completely eliminates packet loss caused by
> +#     switchover.  (since 11.0)

Should mention they will be deliver "out of order" 

> +#
>  # Features:
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> @@ -536,7 +541,7 @@
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> -           'dirty-limit', 'mapped-ram'] }
> +           'dirty-limit', 'mapped-ram', 'netpass'] }
>  
>  ##
>  # @MigrationCapabilityStatus:
> -- 
> 2.52.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


