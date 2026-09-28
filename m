Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AE6CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBAik-00018w-2X; Mon, 28 Sep 2026 08:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBAig-00018c-FT
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBAie-00027B-2M
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790599470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0OgzuqfPwIyicbkfEvXHrbloe3jrX5uGmTmtCm9+G84=;
 b=HApGkbWCm5myOzmmV4lBwrz/AtGMiEzXaTiGrd617lZJEqYSlnYU3pl2eS2/U0P4/IrJAK
 I9YKzLI9eplsw5Oa/6y9hwhyVltfem1Z22BoJr6SfFs1ntSvVqBoAHpOnj6IgZfapiTAGC
 P2umy540bIERoONuXfeYUVDs3afvU9g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-Vug6NgYNOhCwEqGGVlOVFg-1; Mon,
 28 Sep 2026 08:44:29 -0400
X-MC-Unique: Vug6NgYNOhCwEqGGVlOVFg-1
X-Mimecast-MFC-AGG-ID: Vug6NgYNOhCwEqGGVlOVFg_1790599468
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF8AD195DB8E; Mon, 28 Sep 2026 12:44:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 855141956095; Mon, 28 Sep 2026 12:44:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 342A721E6A04; Mon, 28 Sep 2026 14:44:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Tim Pambor <timpambor@gmail.com>
Cc: qemu-devel@nongnu.org,  Jason Wang <jasowangio@gmail.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH] net/vmnet: Add host address options for vmnet-host
In-Reply-To: <20260927-vmnet-host-address-v1-1-6feb74f727c5@gmail.com> (Tim
 Pambor's message of "Sun, 27 Sep 2026 13:04:44 +0200")
References: <20260927-vmnet-host-address-v1-1-6feb74f727c5@gmail.com>
Date: Mon, 28 Sep 2026 14:44:25 +0200
Message-ID: <87a4p15yvq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Tim Pambor <timpambor@gmail.com> writes:

> When a vmnet-host interface is added to an isolated network via
> 'net-uuid', vmnet does not provide DHCP and the host side of the

Comma after DHCP?

> bridge gets no address, so the host cannot talk to guests on that
> network without manually assigning an IP address to the bridge
> interface after QEMU has started.
>
> vmnet provides the vmnet_host_ip_address_key,
> vmnet_host_subnet_mask_key and vmnet_host_ipv6_address_key
> properties to assign addresses to the host interface in this case.
> Expose them as the 'host-ip-address', 'host-subnet-mask' and
> 'host-ipv6-address' options of the vmnet-host backend.
>
> Signed-off-by: Tim Pambor <timpambor@gmail.com>

[...]

> diff --git a/qapi/net.json b/qapi/net.json
> index b46af1fdc9..38b43d20ed 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -795,6 +795,16 @@
>  #     is allowed only with other interfaces added to this network
>  #     identified by the UUID.  Requires at least macOS Big Sur 11.0.
>  #
> +# @host-ip-address: The IPv4 address to set on the host side of the
> +#     interface.  Only applicable when @net-uuid is also specified.
> +#     Must be specified along with @host-subnet-mask.
> +#
> +# @host-subnet-mask: The IPv4 subnet mask to set on the host side of
> +#     the interface.  Must be specified along with @host-ip-address.
> +#
> +# @host-ipv6-address: The IPv6 address to set on the host side of the
> +#     interface.  Only applicable when @net-uuid is also specified.
> +#
>  # Since: 7.1
>  ##
>  { 'struct': 'NetdevVmnetHostOptions',
> @@ -803,7 +813,10 @@
>      '*end-address':   'str',
>      '*subnet-mask':   'str',
>      '*isolated':      'bool',
> -    '*net-uuid':      'str' },
> +    '*net-uuid':      'str',
> +    '*host-ip-address': 'str',
> +    '*host-subnet-mask': 'str',
> +    '*host-ipv6-address': 'str' },
>    'if': 'CONFIG_VMNET' }
>  
>  ##

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


