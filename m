Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F0ECCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 20:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC2Oc-0005sr-8m; Thu, 23 Oct 2025 16:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vC2OZ-0005s8-96
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 16:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vC2OW-0001ia-GL
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 16:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761253125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MQ9P+eQiPdC75WqyOq6kLAjKoxkkpbDX+Fo4QLNhB30=;
 b=DdpLwQvm/+MurTvnbKdwIQt0IFQ6FdX5nfaeiZI4fhduRTeDkQScjItT1a4TzP/Sw1knk8
 fhl/nU17QAET63LLwzqN+X2i97Ov71l1XtTNdGH1Ms9rAayfsQobfVpWk4pQOq9WbPKYJn
 S4w6BuTktS4m1L0SHfChw9gA5QukgHg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-zrYc8cBjOQ-TZpvD6M8Mfw-1; Thu,
 23 Oct 2025 16:58:42 -0400
X-MC-Unique: zrYc8cBjOQ-TZpvD6M8Mfw-1
X-Mimecast-MFC-AGG-ID: zrYc8cBjOQ-TZpvD6M8Mfw_1761253121
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC4061954B1F; Thu, 23 Oct 2025 20:58:40 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.155])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9928530002DB; Thu, 23 Oct 2025 20:58:37 +0000 (UTC)
Date: Thu, 23 Oct 2025 15:58:34 -0500
From: Eric Blake <eblake@redhat.com>
To: Leonid Bloch <lb.workbox@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/4] hw/acpi: Introduce the QEMU Battery
Message-ID: <kvvvx772voowhqijo43sicz7h4dugeymw52zltvc43narmx3vu@ehi42tl44y7s>
References: <20250827220054.37268-1-lb.workbox@gmail.com>
 <20250827220054.37268-3-lb.workbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827220054.37268-3-lb.workbox@gmail.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 28, 2025 at 01:00:48AM +0300, Leonid Bloch wrote:
> The battery device communicates battery state to the guest via ACPI.
> It supports two modes of operation:
> 
> 1. QMP control mode (default): Battery state is controlled programmatically
>    via QMP commands, making the device deterministic and migration-safe.
> 
> 2. Host mirroring mode (optional): The device reflects the host's battery
>    state from sysfs. Probing occurs on guest ACPI requests and at timed
>    intervals (default 2 seconds, configurable via 'probe_interval' property
>    in milliseconds). State changes trigger ACPI notifications to the guest.
> 
> Properties:
> - 'use-qmp': Enable QMP control mode (default: true)
> - 'enable-sysfs': Enable host battery mirroring (default: false)
> - 'probe_interval': Probe interval in ms for sysfs mode (default: 2000)
> - 'sysfs_path': Override default sysfs path /sys/class/power_supply/
> 

> +++ b/hw/acpi/battery.c
> +
> +#define MAX_ALLOWED_STATE_LENGTH  32  /* For convinience when comparing */

convenience

> +++ b/include/hw/acpi/battery.h
> @@ -0,0 +1,33 @@
> +/*
> + * QEMU emulated battery device.
> + *
> + * Copyright (c) 2019 Janus Technologies, Inc. (http://janustech.com)

Is the copyright year accurate?

> +++ b/qapi/acpi.json
> @@ -142,3 +142,76 @@
>  ##
>  { 'event': 'ACPI_DEVICE_OST',
>       'data': { 'info': 'ACPIOSTInfo' } }
> +
> +##
> +# @BatteryInfo:
> +#
> +# Battery state information
> +#
> +# @present: whether the battery is present
> +#
> +# @charging: whether the battery is charging
> +#
> +# @discharging: whether the battery is discharging

The commit message mentioned that charging and discharging are
mutually exclusive; if so, should this be an enum to avoid the user
passing in an impossible scenario?  For that matter, can present be
folded into the enum, for four states total (absent, charging,
discharging, and present - where present is neither charging nor
discharging)?

> +#
> +# @charge-percent: battery charge percentage (0-100)
> +#
> +# @rate: charge/discharge rate in mW (optional)
> +#
> +# @remaining-capacity: remaining capacity in mWh (optional)
> +#
> +# @design-capacity: design capacity in mWh (optional)
> +#
> +# Since: 10.2
> +##
> +{ 'struct': 'BatteryInfo',
> +  'data': { 'present': 'bool',
> +            'charging': 'bool',
> +            'discharging': 'bool',
> +            'charge-percent': 'int',

Does having charge-percent mandatory when present is false make sense?
Or should this be a discriminated union, where the additional fields
like charge-percent, rate, and so on are only in the branches of the
union where the state implies present?

> +            '*rate': 'int',
> +            '*remaining-capacity': 'int',
> +            '*design-capacity': 'int' } }
> +
> +##
> +# @battery-set-state:
> +#
> +# Set the state of the emulated battery device
> +#
> +# @state: new battery state
> +#
> +
> +#

The blank line looks odd.

> +# Since: 10.2
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "battery-set-state",
> +#          "arguments": { "state": { "present": true,
> +#                                    "charging": true,
> +#                                    "discharging": false,
> +#                                    "charge-percent": 85 } } }
> +#     <- { "return": {} }
> +##
> +{ 'command': 'battery-set-state',
> +  'data': { 'state': 'BatteryInfo' } }
> +
> +##
> +# @query-battery:
> +#
> +# Query the current state of the emulated battery device
> +#
> +# Returns: current battery state
> +#
> +# Since: 10.2
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "query-battery" }
> +#     <- { "return": { "present": true,
> +#                      "charging": true,
> +#                      "discharging": false,
> +#                      "charge-percent": 85 } }
> +##
> +{ 'command': 'query-battery',
> +  'returns': 'BatteryInfo' }
> -- 
> 2.51.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


