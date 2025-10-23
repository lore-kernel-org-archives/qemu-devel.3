Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE88CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 21:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC2V5-0007hK-CW; Thu, 23 Oct 2025 17:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vC2V3-0007gv-N2
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 17:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vC2V0-000477-2j
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 17:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761253528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UgNldyxdOuhhU2ac40xxI3sx0IHf6Bd+ucs3wGWK14g=;
 b=eRxjrweDJEBnyxEUrUQL57zbyDUDjy6X5OJiI884aItfUaOH1wug822wrU3DMWNDbj7KOJ
 mn9O3AaAdLgUA/GPQtRU8M9FxE5x0m8LOmhW4IzrodkaD/OghNU+Xs5y3fhDTfDvB6muNt
 niYdScjyusyx1ut2cWEFGQyp72j3STs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-lum7IXSBO0Kq2WQbacyFGQ-1; Thu,
 23 Oct 2025 17:05:19 -0400
X-MC-Unique: lum7IXSBO0Kq2WQbacyFGQ-1
X-Mimecast-MFC-AGG-ID: lum7IXSBO0Kq2WQbacyFGQ_1761253516
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B526B1954224; Thu, 23 Oct 2025 21:05:16 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.155])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22C9C30002DB; Thu, 23 Oct 2025 21:05:12 +0000 (UTC)
Date: Thu, 23 Oct 2025 16:05:10 -0500
From: Eric Blake <eblake@redhat.com>
To: Leonid Bloch <lb.workbox@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/4] hw/acpi: Introduce the QEMU AC adapter
Message-ID: <ysrf4llll3b36ay23ftyylvqqkhhgamtx4ftgnpfmwf2akxv4q@chxuswy5zybr>
References: <20250827220054.37268-1-lb.workbox@gmail.com>
 <20250827220054.37268-4-lb.workbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827220054.37268-4-lb.workbox@gmail.com>
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

On Thu, Aug 28, 2025 at 01:00:49AM +0300, Leonid Bloch wrote:
> The AC adapter device communicates AC power state to the guest via ACPI.
> It supports two modes of operation:
> 
> 1. QMP control mode (default): AC adapter state is controlled
>    programmatically via QMP commands, ensuring deterministic behavior.
> 
> 2. Host mirroring mode (optional): The device reflects the host's AC
>    adapter state from sysfs. Probing occurs on guest ACPI requests and
>    at timed intervals. State changes trigger ACPI notifications.
> 
> Properties:
> - 'use-qmp': Enable QMP control mode (default: true)
> - 'enable-sysfs': Enable host AC adapter mirroring (default: false)
> - 'probe_interval': Probe interval in ms for sysfs mode (default: 2000)
> - 'sysfs_path': Override default sysfs path /sys/class/power_supply/

Any reason half the properties use - and the other use _ between words?

> +++ b/qapi/acpi.json
> @@ -215,3 +215,52 @@
>  ##
>  { 'command': 'query-battery',
>    'returns': 'BatteryInfo' }
> +
> +##
> +# @ac-adapter-set-state:
> +#
> +# Set the state of the emulated AC adapter device
> +#
> +# @connected: whether the AC adapter is connected
> +#
> +
> +#

Another odd blank line.

> +# Since: 10.2
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "ac-adapter-set-state",
> +#          "arguments": { "connected": true } }
> +#     <- { "return": {} }
> +##
> +{ 'command': 'ac-adapter-set-state',
> +  'data': { 'connected': 'bool' } }
> +

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


