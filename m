Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36D4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 11:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2UTF-00066f-Io; Thu, 02 May 2024 07:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2UTD-00065v-Vl
 for qemu-devel@nongnu.org; Thu, 02 May 2024 07:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2UTC-00071u-2P
 for qemu-devel@nongnu.org; Thu, 02 May 2024 07:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714648760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GNDPXXs2b1bJgW1MgN+6irZSxTx776ArqiSDXxs07Co=;
 b=D/zHz8hFYJ2tPj+0fscPgcl0vmrnl8Ml37Xsd2FeiJpoOcZo44Msd7W2PWp0/ruft3V92K
 gcgGv9m6lSGPUn3pSoBvfKVIWggvXSRVC0Mf4Rgkrs5SV2bXcSEVkRm7pqhNgFzewgbR+F
 Y+CSexeOiFYPmyn2B3+j98ADmeWXj0g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-x09_vv0eNzuGm8qhrPc9uQ-1; Thu, 02 May 2024 07:19:17 -0400
X-MC-Unique: x09_vv0eNzuGm8qhrPc9uQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1AFB80D0F3;
 Thu,  2 May 2024 11:19:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C5B0AC6D;
 Thu,  2 May 2024 11:19:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 90A9221E6680; Thu,  2 May 2024 13:19:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: <qemu-devel@nongnu.org>,  Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Joao Martins <joao.m.martins@oracle.com>,  Maor
 Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 1/3] qapi/vfio: Add VFIO device migration state change
 QAPI event
In-Reply-To: <20240430051621.19597-2-avihaih@nvidia.com> (Avihai Horon's
 message of "Tue, 30 Apr 2024 08:16:19 +0300")
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-2-avihaih@nvidia.com>
Date: Thu, 02 May 2024 13:19:15 +0200
Message-ID: <87msp88nrg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Avihai Horon <avihaih@nvidia.com> writes:

> Add a new QAPI event for VFIO device migration state change. This event
> will be emitted when a VFIO device changes its migration state, for
> example, during migration or when stopping/starting the guest.
>
> This event can be used by management applications to get updates on the
> current state of the VFIO device for their own purposes.
>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Can you explain briefly why this event makes sense only for VFIO devices?

> ---
>  MAINTAINERS           |  1 +
>  qapi/qapi-schema.json |  1 +
>  qapi/vfio.json        | 61 +++++++++++++++++++++++++++++++++++++++++++
>  qapi/meson.build      |  1 +
>  4 files changed, 64 insertions(+)
>  create mode 100644 qapi/vfio.json
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 302b6fd00c..ef58a39d36 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2159,6 +2159,7 @@ F: hw/vfio/*
>  F: include/hw/vfio/
>  F: docs/igd-assign.txt
>  F: docs/devel/migration/vfio.rst
> +F: qapi/vfio.json
>  
>  vfio-ccw
>  M: Eric Farman <farman@linux.ibm.com>
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 5e33da7228..b1581988e4 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -78,5 +78,6 @@
>  { 'include': 'pci.json' }
>  { 'include': 'stats.json' }
>  { 'include': 'virtio.json' }
> +{ 'include': 'vfio.json' }
>  { 'include': 'cryptodev.json' }
>  { 'include': 'cxl.json' }
> diff --git a/qapi/vfio.json b/qapi/vfio.json
> new file mode 100644
> index 0000000000..a38f26bccd
> --- /dev/null
> +++ b/qapi/vfio.json
> @@ -0,0 +1,61 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +#
> +
> +##
> +# = VFIO devices
> +##
> +
> +##
> +# @VFIODeviceMigState:
> +#
> +# An enumeration of the VFIO device migration states.
> +#
> +# @stop: The device is stopped.
> +#
> +# @running: The device is running.
> +#
> +# @stop-copy: The device is stopped and its internal state is available
> +#     for reading.
> +#
> +# @resuming: The device is stopped and its internal state is available
> +#     for writing.
> +#
> +# @running-p2p: The device is running in the P2P quiescent state.
> +#
> +# @pre-copy: The device is running, tracking its internal state and its
> +#     internal state is available for reading.
> +#
> +# @pre-copy-p2p: The device is running in the P2P quiescent state,
> +#     tracking its internal state and its internal state is available
> +#     for reading.
> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'VFIODeviceMigState',
> +  'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
> +            'pre-copy', 'pre-copy-p2p' ],
> +  'prefix': 'QAPI_VFIO_DEVICE_MIG_STATE' }
> +
> +##
> +# @VFIO_DEVICE_MIG_STATE_CHANGED:
> +#
> +# This event is emitted when a VFIO device migration state is changed.
> +#
> +# @device-id: The id of the VFIO device (final component of QOM path).

Provide the full QOM path, please.  Feel free to additionally provide
its qdev ID.

Precedence: events MEMORY_DEVICE_SIZE_CHANGE, DEVICE_DELETED,
DEVICE_UNPLUG_GUEST_ERROR, ...

> +#
> +# @device-state: The new changed device migration state.
> +#
> +# Since: 9.1
> +#
> +# Example:
> +#
> +#     <- {"timestamp": {"seconds": 1713771323, "microseconds": 212268},
> +#         "event": "VFIO_DEVICE_MIG_STATE_CHANGED",
> +#         "data": {"device-id": "vfio_dev1", "device-state": "stop"} }
> +##
> +{ 'event': 'VFIO_DEVICE_MIG_STATE_CHANGED',
> +  'data': {
> +      'device-id': 'str',
> +      'device-state': 'VFIODeviceMigState'
> +  } }
> diff --git a/qapi/meson.build b/qapi/meson.build
> index c92af6e063..e7bc54e5d0 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -52,6 +52,7 @@ qapi_all_modules = [
>    'stats',
>    'trace',
>    'transaction',
> +  'vfio',
>    'virtio',
>    'yank',
>  ]


