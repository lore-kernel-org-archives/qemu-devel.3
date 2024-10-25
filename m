Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06466D0C608
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 12:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4JmS-0004Yi-D1; Fri, 25 Oct 2024 08:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4JmO-0004V4-Sc
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 08:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4JmN-0004Am-0c
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 08:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729860657;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/bVN2UQyWqDGHqozCkV/ZSWXO9IwY72GVYmvJ2+KqS4=;
 b=XfnAqMBiBmnVIyVeHby3tJBKhHNe4wrHepyKtmsPzDfgcQCs55UaXI5Q3FwfMz6lpqaWhc
 gD3a634KyQT17irY5Ec8BX3bMs21mwZZhe/1sJNF30CagxOB1tTIkPUd3bIxyqIbeNnY2f
 B9FIqd6GWL34mauFqjVewyXic7GieHI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-vWZSyWWBNQWI-ZSP4irUdw-1; Fri,
 25 Oct 2024 08:50:50 -0400
X-MC-Unique: vWZSyWWBNQWI-ZSP4irUdw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5B1519560BA; Fri, 25 Oct 2024 12:50:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C1C3196BB7D; Fri, 25 Oct 2024 12:50:46 +0000 (UTC)
Date: Fri, 25 Oct 2024 13:50:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH v4 5/5] qemu-ga:  Replace g_new0() with g_autoptr()
Message-ID: <ZxuUI15RQxuEZHbx@redhat.com>
References: <20241022142948.531325-1-demeng@redhat.com>
 <20241022142948.531325-6-demeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022142948.531325-6-demeng@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Oct 22, 2024 at 10:29:48PM +0800, Dehan Meng wrote:
> Replace g_new0() with g_autoptr() to simplify the code
> 
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>  qga/commands-linux.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index 9fb31956b4..ee4f345938 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -2158,15 +2158,13 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
>                      continue;
>                  }
>  
> -                GuestNetworkRoute *route = g_new0(GuestNetworkRoute, 1);
> +                g_autoptr(GuestNetworkRoute) route = g_new0(GuestNetworkRoute, 1);
>  
>                  route->destination = hex_to_ip_address(destination, 1);
> -                if (route->destination == NULL) {
> -                    g_free(route);
> +                route->iface = g_strdup(iface);
> +                if (route->destination == NULL  || route->iface == NULL) {

Checking "iface" for NULL is not required, since  g_strdup will never
fail to allocate memory.

Also, these changes to use g_autoptr need to be part of the first patch,
as each step in the patch series needs to be correct.

>                      continue;
>                  }
> -                route->iface = g_strdup(iface);
> -                route->destination = hex_to_ip_address(destination, 1);
>                  route->source = hex_to_ip_address(source, 1);
>                  route->nexthop = hex_to_ip_address(next_hop, 1);
>                  route->desprefixlen = g_strdup_printf("%d", des_prefixlen);
> @@ -2188,15 +2186,13 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
>                      continue;
>                  }
>  
> -                GuestNetworkRoute *route = g_new0(GuestNetworkRoute, 1);
> +                g_autoptr(GuestNetworkRoute) route = g_new0(GuestNetworkRoute, 1);
>  
>                  route->destination = hex_to_ip_address(destination, 1);
> -                if (route->destination == NULL) {
> -                    g_free(route);
> +                route->iface = g_strdup(iface);
> +                if (route->destination == NULL  || route->iface == NULL) {
>                      continue;
>                  }
> -                route->iface = g_strdup(iface);
> -                route->destination = hex_to_ip_address(&destination, 0);
>                  route->gateway = hex_to_ip_address(&gateway, 0);
>                  route->mask = hex_to_ip_address(&mask, 0);
>                  route->metric = metric;
> -- 
> 2.40.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


