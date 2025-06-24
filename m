Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA4FC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 08:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTypf-0001iI-8h; Tue, 24 Jun 2025 04:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uTypd-0001i3-7c
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 04:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uTypa-0002yq-Tj
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 04:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750752990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M0A7+yCK6uY+S6/V5CDAJfG5nVUmeGh+sOU8O7ZrTJk=;
 b=jA3Vai3M6Q4KaekAwMB91Ne8oEsEXIk+8RSgs8vHmEIlDz7Gs4BtyPBIJC/4684ZgmIowm
 evHzWopIf7gFWZCyt3uz8AAnBGm2QcEMeSo4CYGhC6X+oV+1vdz4CKiVtwfZRctMtBHFTM
 XvTQH+BhaOVUC7h0U2Vy0djU3nXbIiU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-0WCikd0TMPennbXxh2FHug-1; Tue,
 24 Jun 2025 04:16:14 -0400
X-MC-Unique: 0WCikd0TMPennbXxh2FHug-1
X-Mimecast-MFC-AGG-ID: 0WCikd0TMPennbXxh2FHug_1750752968
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F60C18089B6; Tue, 24 Jun 2025 08:16:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8326F30001A1; Tue, 24 Jun 2025 08:16:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1CF2021E6A27; Tue, 24 Jun 2025 10:16:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Stefan Weil <sw@weilnetz.de>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Jason Wang <jasowang@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 09/10] net: Add passt network backend
In-Reply-To: <20250618155718.550968-10-lvivier@redhat.com> (Laurent Vivier's
 message of "Wed, 18 Jun 2025 17:57:17 +0200")
References: <20250618155718.550968-1-lvivier@redhat.com>
 <20250618155718.550968-10-lvivier@redhat.com>
Date: Tue, 24 Jun 2025 10:16:02 +0200
Message-ID: <87pletlflp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Laurent Vivier <lvivier@redhat.com> writes:

> This commit introduces support for passt as a new network backend.
> passt is an unprivileged, user-mode networking solution that provides
> connectivity for virtual machines by launching an external helper process.
>
> The implementation reuses the generic stream data handling logic. It
> launches the passt binary using GSubprocess, passing it a file
> descriptor from a socketpair() for communication. QEMU connects to
> the other end of the socket pair to establish the network data stream.
>
> The PID of the passt daemon is tracked via a temporary file to
> ensure it is terminated when QEMU exits.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

[...]

> diff --git a/qapi/net.json b/qapi/net.json
> index 97ea1839813b..76d7654414f7 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -112,6 +112,125 @@
>    'data': {
>      'str': 'str' } }
>  
> +##
> +# @NetDevPasstOptions:
> +#
> +# Unprivileged user-mode network connectivity using passt
> +#
> +# @path: path to passt binary

I'd prefer a more descriptive name.

Elsewhere in this file, we refer to programs like this:

   # @script: script to initialize the interface
   #
   # @downscript: script to shut down the interface

passt isn't a script, of course.

I don't know, perhaps

   # @passt-filename: the passt program to run.

or even

   # @passt: Filename of the passt program to run.

> +#
> +# @quiet: don't print informational messages

What does the printing?  A peek at the code I snipped suggests this flag
is passed to the passt binary as --quiet.  Correct?

> +#
> +# @debug: be verbose
> +#
> +# @trace: extra verbose

Likewise for these two.

> +#
> +# @vhost-user: enable vhost-user
> +#
> +# @pcap-file: log traffic to pcap file
> +#
> +# @mtu: assign MTU via DHCP/NDP
> +#
> +# @address: IPv4 or IPv6 address
> +#
> +# @netmask: IPv4 mask
> +#
> +# @mac: source MAC address
> +#
> +# @gateway: IPv4 or IPv6 address as gateway
> +#
> +# @interface: interface for addresses and routes
> +#
> +# @outbound: bind to address as outbound source
> +#
> +# @outbound-if4: bind to outbound interface for IPv4
> +#
> +# @outbound-if6: bind to outbound interface for IPv6
> +#
> +# @dns: IPv4 or IPv6 address as DNS
> +#
> +# @search: search domains
> +#
> +# @fqdn: FQDN to configure client with
> +#
> +# @dhcp-dns: enable/disable DNS list in DHCP/DHCPv6/NDP
> +#
> +# @dhcp-search: enable/disable list in DHCP/DHCPv6/NDP
> +#
> +# @map-host-loopback: addresse to refer to host
> +#
> +# @map-guest-addr: addr to translate to guest's address
> +#
> +# @dns-forward: forward DNS queries sent to
> +#
> +# @dns-host: host nameserver to direct queries to
> +#
> +# @tcp: enable/disable TCP
> +#
> +# @udp: enable/disable UDP
> +#
> +# @icmp: enable/disable ICMP
> +#
> +# @dhcp: enable/disable DHCP
> +#
> +# @ndp: enable/disable NDP
> +#
> +# @dhcpv6: enable/disable DHCPv6
> +#
> +# @ra: enable/disable route advertisements
> +#
> +# @freebind: bind to any address for forwarding
> +#
> +# @ipv4: enable/disable IPv4
> +#
> +# @ipv6: enable/disable IPv6
> +#
> +# @tcp-ports: TCP ports to forward
> +#
> +# @udp-ports: UDP ports to forward

Is there anything in this struct that configures qemu-system-FOO itself,
i.e. isn't just passed to passt?

> +#
> +# Since: 10.1
> +##
> +{ 'struct': 'NetDevPasstOptions',
> +  'data': {
> +    '*path':               'str',
> +    '*quiet':              'bool',
> +    '*debug':              'bool',
> +    '*trace':              'bool',
> +    '*vhost-user':         'bool',
> +    '*pcap-file':          'str',
> +    '*mtu':                'int',
> +    '*address':            'str',
> +    '*netmask':            'str',
> +    '*mac':                'str',
> +    '*gateway':            'str',
> +    '*interface':          'str',
> +    '*outbound':           'str',
> +    '*outbound-if4':       'str',
> +    '*outbound-if6':       'str',
> +    '*dns':                'str',
> +    '*search':             ['String'],
> +    '*fqdn':               'str',
> +    '*dhcp-dns':           'bool',
> +    '*dhcp-search':        'bool',
> +    '*map-host-loopback':  'str',
> +    '*map-guest-addr':     'str',
> +    '*dns-forward':        'str',
> +    '*dns-host':           'str',
> +    '*tcp':                'bool',
> +    '*udp':                'bool',
> +    '*icmp':               'bool',
> +    '*dhcp':               'bool',
> +    '*ndp':                'bool',
> +    '*dhcpv6':             'bool',
> +    '*ra':                 'bool',
> +    '*freebind':           'bool',
> +    '*ipv4':               'bool',
> +    '*ipv6':               'bool',
> +    '*tcp-ports':          ['String'],
> +    '*udp-ports':          ['String'] },
> +    'if': 'CONFIG_PASST' }
> +
>  ##
>  # @NetdevUserOptions:
>  #
> @@ -729,12 +848,15 @@
>  #
>  # @af-xdp: since 8.2
>  #
> +# @passt: since 10.1
> +#
>  # Since: 2.7
>  ##
>  { 'enum': 'NetClientDriver',
>    'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'stream',
>              'dgram', 'vde', 'bridge', 'hubport', 'netmap', 'vhost-user',
>              'vhost-vdpa',
> +            { 'name': 'passt', 'if': 'CONFIG_PASST' },
>              { 'name': 'af-xdp', 'if': 'CONFIG_AF_XDP' },
>              { 'name': 'vmnet-host', 'if': 'CONFIG_VMNET' },
>              { 'name': 'vmnet-shared', 'if': 'CONFIG_VMNET' },
> @@ -756,6 +878,8 @@
>    'discriminator': 'type',
>    'data': {
>      'nic':      'NetLegacyNicOptions',
> +    'passt':    { 'type': 'NetDevPasstOptions',
> +                  'if': 'CONFIG_PASST' },
>      'user':     'NetdevUserOptions',
>      'tap':      'NetdevTapOptions',
>      'l2tpv3':   'NetdevL2TPv3Options',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 1f862b19a676..4787f9309c69 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2796,6 +2796,18 @@ DEFHEADING()
>  DEFHEADING(Network options:)
>  
>  DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
> +#ifdef CONFIG_PASST
> +    "-netdev passt,id=str[,path=file][,quiet=on|off][,debug=on|off][,trace=on|off]\n"
> +    "          [,vhost-user=on|off][,pcap-file=file][,mtu=mtu]\n"
> +    "          [,address=addr][,netmask=mask][,mac=addr][,gateway=addr]\n"
> +    "          [,interface=name][,outbound=address][,outbound-if4=name]\n"
> +    "          [,outbound-if6=name][,dns=addr][,search=list][,fqdn=name]\n"
> +    "          [,dhcp-dns=on|off][,dhcp-search=on|off][,map-host-loopback=addr]\n"
> +    "          [,map-guest-addr=addr][,dns-forward=addr][,dns-host=addr]\n"
> +    "          [,tcp=on|off][,udp=on|off][,icmp=on|off][,dhcp=on|off]\n"
> +    "          [,ndp=on|off][,dhcpv6=on|off][,ra=on|off][,freebind=on|off]\n"
> +    "          [,ipv4=on|off][,ipv6=on|off][,tcp-ports=spec][,udp-ports=spec]\n"

No help here?

> +#endif
>  #ifdef CONFIG_SLIRP
>      "-netdev user,id=str[,ipv4=on|off][,net=addr[/mask]][,host=addr]\n"
>      "         [,ipv6=on|off][,ipv6-net=addr[/int]][,ipv6-host=addr]\n"
> @@ -2952,6 +2964,9 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>      "                configure a hub port on the hub with ID 'n'\n", QEMU_ARCH_ALL)
>  DEF("nic", HAS_ARG, QEMU_OPTION_nic,
>      "-nic [tap|bridge|"
> +#ifdef CONFIG_PASST
> +    "passt|"
> +#endif
>  #ifdef CONFIG_SLIRP
>      "user|"
>  #endif
> @@ -2984,6 +2999,9 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
>      "                configure or create an on-board (or machine default) NIC and\n"
>      "                connect it to hub 0 (please use -nic unless you need a hub)\n"
>      "-net ["
> +#ifdef CONFIG_PASST
> +    "passt|"
> +#endif
>  #ifdef CONFIG_SLIRP
>      "user|"
>  #endif


