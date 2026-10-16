Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97106CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 17:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHlPe-00036Q-I8; Fri, 16 Oct 2026 13:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xHlPc-00035Q-2V
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 13:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xHlPZ-0006ke-Tf
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 13:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792170483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eAY7lz9xwcF97H+1b+oUYdgvr3JQTdyDwPDO7+bkGh0=;
 b=MOqGbGtd3VOnNNM3ztHQrj9mRYFJd7XvMfKrz15SoopNkeaG3+EhUaeG0+lRPdcnS0Zpkg
 IGsaWt/1lGDT532cPtURMHB3wbzt7xPhy9VSYlhhQ7XPqsXkcSspjl989DefS0tcK2Ank3
 0GIX9XaLOAedc7iUt4ikrL4UKSDea3c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-cOYTXnwqNgCpWmGMSq_GjA-1; Fri,
 16 Oct 2026 17:07:59 +0000
X-MC-Unique: cOYTXnwqNgCpWmGMSq_GjA-1
X-Mimecast-MFC-AGG-ID: cOYTXnwqNgCpWmGMSq_GjA_1792170478
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D715180058F; Fri, 16 Oct 2026 17:07:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0C5730001A2; Fri, 16 Oct 2026 17:07:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 480F221E6A04; Fri, 16 Oct 2026 19:07:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Kostiantyn
 Kostiuk <kkostiuk@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qga: implement 'guest-network-get-route' for FreeBSD
In-Reply-To: <20261016163345.15303-1-bogorodskiy@gmail.com> (Roman
 Bogorodskiy's message of "Fri, 16 Oct 2026 18:33:45 +0200")
References: <20261016163345.15303-1-bogorodskiy@gmail.com>
Date: Fri, 16 Oct 2026 19:07:55 +0200
Message-ID: <87cxt960b8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Roman Bogorodskiy <bogorodskiy@gmail.com> writes:

> Implement 'guest-network-get-route' for FreeBSD. This
> implementation uses the sysctl(3) interface to get
> the routing table.
>
> Limitations:
>
>  - This implementation does not populate irtt, refcnt, use,
>    window, source, and srcprefixlen fields.
>  - The implementation uses the default FIB (routing table) 0.
>    Selecting QGA's active FIB is left for the follow-up patch.
>
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>

[...]

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 05fe4ea484..2f9d9f13a0 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1823,8 +1823,8 @@
>  
>  ##
>  # @GuestNetworkRoute:
> -#     Route information.  Supported on Linux (since 9.1) and Windows
> -#     (since 11.0).
> +#     Route information.  Supported on Linux (since 9.1), Windows
> +#     (since 11.0), and FreeBSD (since 11.2).
>  #
>  # @iface: The destination network or host's egress network interface
>  #     in the routing table
> @@ -1838,30 +1838,31 @@
>  #
>  # @mask: Subnet Mask (IPv4 only)
>  #
> -# @irtt: Initial round-trip delay (not for windows, IPv4 only)
> +# @irtt: Initial round-trip delay (not for windows and freebsd,
> +#     IPv4 only)

FreeBSD, please, and use the opportunity to spell Windows correctly.
More of the same below.

>  #
>  # @flags: Route flags (not for windows)
>  #
> -# @refcnt: The route's reference count (not for windows)
> +# @refcnt: The route's reference count (not for windows and freebsd)
>  #
> -# @use: Route usage count (not for windows)
> +# @use: Route usage count (not for windows and freebsd)
>  #
> -# @window: TCP window size, used for flow control (not for windows,
> -#     IPv4 only)
> +# @window: TCP window size, used for flow control (not for windows
> +#     and freebsd, IPv4 only)
>  #
>  # @mtu: Data link layer maximum packet size (not for windows)
>  #
>  # @desprefixlen: Destination prefix length (for IPv6)
>  #
> -# @source: Source IP address (for IPv6)
> +# @source: Source IP address (not for freebsd, IPv6 only)
>  #
> -# @srcprefixlen: Source prefix length (for IPv6)
> +# @srcprefixlen: Source prefix length (not for freebsd, IPv6 only)
>  #
>  # @nexthop: Next hop IP address (for IPv6)
>  #
>  # @version: IP version (4 or 6)
>  #
> -# Since: 9.1 (Linux only); 11.0 (Windows)
> +# Since: 9.1 (Linux only); 11.0 (Windows); 11.2 (FreeBSD)
>  ##
>  { 'struct': 'GuestNetworkRoute',
>    'data': {'iface': 'str',
> @@ -1881,7 +1882,7 @@
>             '*nexthop': 'str',
>             'version': 'int'
>             },
> -  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
> +  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_FREEBSD'] } }
>  
>  ##
>  # @guest-network-get-route:
> @@ -1889,9 +1890,9 @@
>  #
>  # Returns: List of route info of guest.
>  #
> -# Since: 9.1 (Linux only); 11.0 (Windows)
> +# Since: 9.1 (Linux only); 11.0 (Windows); 11.2 (FreeBSD)
>  ##
>  { 'command': 'guest-network-get-route',
>    'returns': ['GuestNetworkRoute'],
> -  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
> +  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_FREEBSD'] }
>  }

Acked-by: Markus Armbruster <armbru@redhat.com>


