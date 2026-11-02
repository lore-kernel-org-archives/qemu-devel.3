Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989AF606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VzoaBzvk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNmmH-0004e8-OH; Mon, 02 Nov 2026 02:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNmm7-0004dg-0T
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 02:48:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNmm4-0000Wn-Tc
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 02:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793605691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Od4yOULaASASeCY/CsPeaXQEZ9RA3P4jwdVEqFXBsaQ=;
 b=VzoaBzvktxuC7fMTqzpUA+TRUD7Pip80iqmP0ejm9JIpLVMwjrxdhT8jXtfo1bTFgqGvg9
 fSO0jhPQE34tkef7Svwv/fzEPOCrWUfqOEk1RNCbjzB6RJjlBw+2uGOaCkS17OmqMV+WqK
 EJpnlliHoskPOYZTtKAyeI8uqoFuIOQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-CMVmmy6DPUyeH8wVYgVn0A-1; Mon,
 02 Nov 2026 02:48:06 -0500
X-MC-Unique: CMVmmy6DPUyeH8wVYgVn0A-1
X-Mimecast-MFC-AGG-ID: CMVmmy6DPUyeH8wVYgVn0A_1793605685
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C40DC19560B2; Mon,  2 Nov 2026 07:48:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62838433; Mon,  2 Nov 2026 07:48:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 218FF21E6A04; Mon, 02 Nov 2026 08:48:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Brad Smith <brad@comstyle.com>
Cc: Michael Roth <michael.roth@amd.com>,  Kostiantyn Kostiuk
 <kkostiuk@redhat.com>,  Roman Bogorodskiy <bogorodskiy@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] qga: implement 'guest-network-get-route' for NetBSD and
 OpenBSD
In-Reply-To: <auVz7XxhHqAn3QEW@humpty.home.comstyle.com> (Brad Smith's message
 of "Sat, 31 Oct 2026 00:51:57 -0400")
References: <auVz7XxhHqAn3QEW@humpty.home.comstyle.com>
Date: Mon, 02 Nov 2026 08:48:03 +0100
Message-ID: <87qzh3u11o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

You forgot to cc: me.  scripts/get_maintainer.pl is your friend.

Brad Smith <brad@comstyle.com> writes:

> qga: implement 'guest-network-get-route' for NetBSD and OpenBSD
>
> Extend the FreeBSD routing table implementation to NetBSD and
> OpenBSD. All three dump the table with the NET_RT_DUMP sysctl and
> walk rt_msghdr messages, but differ in a few details:
>
> - Locating the sockaddrs: OpenBSD places them after rtm_hdrlen
>   bytes and pads each to sizeof(long). NetBSD uses RT_ROUNDUP() and
>   FreeBSD SA_SIZE(). Add RT_FIRST_SA() and RT_SA_SIZE() macros to
>   cover these.
>
> - The sysctl MIB: NetBSD rejects the trailing routing table ID with
>   EINVAL, so use the 6 element form there. FreeBSD and OpenBSD keep
>   the 7 element form and dump table 0.
>
> - ARP/NDP entries: OpenBSD and NetBSD return neighbour entries in
>   the routing table dump. Skip them via RTF_LLINFO (OpenBSD) or
>   RTF_LLDATA (NetBSD, which renamed the flag).
>
> - IPv6 scope: NetBSD and OpenBSD return link-local and scoped
>   multicast addresses with the KAME embedded scope ID in bytes 2-3
>   of the address. Move it into sin6_scope_id before calling
>   getnameinfo(), so these print as fe80::...%iface as on FreeBSD.
>   This is a no-op on FreeBSD, where the kernel already does this.
>
> Also use ARRAY_SIZE() instead of nitems(), which NetBSD lacks.
>
> Tested on FreeBSD, NetBSD and OpenBSD, comparing the output
> against netstat -rn.
>
> Signed-off-by: Brad Smith <brad@comstyle.com>

[...]

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 7b937713e6..1b8959d658 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1824,7 +1824,7 @@
>  ##
>  # @GuestNetworkRoute:
>  #     Route information.  Supported on Linux (since 9.1), Windows
> -#     (since 11.0), and FreeBSD (since 11.2).
> +#     (since 11.0), and BSD (since 11.2).

"Supported on ..." is redundant with the formal "Since: " below.  Please
use the opportunity to delete it.

>  #
>  # @iface: The destination network or host's egress network interface
>  #     in the routing table
> @@ -1838,31 +1838,31 @@
>  #
>  # @mask: Subnet Mask (IPv4 only)
>  #
> -# @irtt: Initial round-trip delay (not for Windows and FreeBSD,
> +# @irtt: Initial round-trip delay (not for Windows and BSD,
>  #     IPv4 only)
>  #
>  # @flags: Route flags (not for Windows)
>  #
> -# @refcnt: The route's reference count (not for Windows and FreeBSD)
> +# @refcnt: The route's reference count (not for Windows and BSD)
>  #
> -# @use: Route usage count (not for Windows and FreeBSD)
> +# @use: Route usage count (not for Windows and BSD)
>  #
>  # @window: TCP window size, used for flow control (not for Windows
> -#     and FreeBSD, IPv4 only)
> +#     and BSD, IPv4 only)
>  #
>  # @mtu: Data link layer maximum packet size (not for Windows)
>  #
>  # @desprefixlen: Destination prefix length (for IPv6)
>  #
> -# @source: Source IP address (not for FreeBSD, IPv6 only)
> +# @source: Source IP address (not for BSD, IPv6 only)
>  #
> -# @srcprefixlen: Source prefix length (not for FreeBSD, IPv6 only)
> +# @srcprefixlen: Source prefix length (not for BSD, IPv6 only)
>  #
>  # @nexthop: Next hop IP address (for IPv6)
>  #
>  # @version: IP version (4 or 6)
>  #
> -# Since: 9.1 (Linux only); 11.0 (Windows); 11.2 (FreeBSD)
> +# Since: 9.1 (Linux only); 11.0 (Windows); 11.2 (BSD)
>  ##
>  { 'struct': 'GuestNetworkRoute',
>    'data': {'iface': 'str',
> @@ -1882,7 +1882,7 @@
>             '*nexthop': 'str',
>             'version': 'int'
>             },
> -  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_FREEBSD'] } }
> +  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_BSD'] } }
>  
>  ##
>  # @guest-network-get-route:
> @@ -1890,9 +1890,9 @@
>  #
>  # Returns: List of route info of guest.
>  #
> -# Since: 9.1 (Linux only); 11.0 (Windows); 11.2 (FreeBSD)
> +# Since: 9.1 (Linux only); 11.0 (Windows); 11.2 (BSD)
>  ##
>  { 'command': 'guest-network-get-route',
>    'returns': ['GuestNetworkRoute'],
> -  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_FREEBSD'] }
> +  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_BSD'] }
>  }

Acked-by: Markus Armbruster <armbru@redhat.com>


