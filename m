Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4D9C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 04:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3qLs-0004zS-3Z; Mon, 06 May 2024 00:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3qLX-0004xs-Te
 for qemu-devel@nongnu.org; Mon, 06 May 2024 00:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3qLV-0007Z3-TB
 for qemu-devel@nongnu.org; Mon, 06 May 2024 00:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714971180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GMryBqVqB9094jjLWUBKK85eIDTEWLpeVqEoZCNRaSs=;
 b=H/V/pY4lIvFcmGVZqSzp7mITnmf9ZDSsBLTUSL2eUTjofGOaDFTwWZ8NXmze+cOU7XR/wk
 ptqsQdCtBhAJu07Ndol9GifJX6Y6zfaraHANG2fIKEocE17A1pwh4kuhGOyipEouzFBUZu
 zABrRgB42y2edUiSQhu65o+Zo/g8TUc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-8MybA0OiPZu9HXGkzP5eXg-1; Mon,
 06 May 2024 00:52:57 -0400
X-MC-Unique: 8MybA0OiPZu9HXGkzP5eXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD7E029AA395;
 Mon,  6 May 2024 04:52:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FE11A20;
 Mon,  6 May 2024 04:52:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 803E221E6806; Mon,  6 May 2024 06:52:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,  qemu-devel@nongnu.org,  Alex
 Williamson <alex.williamson@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Eric Blake <eblake@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Maor Gottlieb
 <maorg@nvidia.com>
Subject: Re: [PATCH 1/3] qapi/vfio: Add VFIO device migration state change
 QAPI event
In-Reply-To: <703aab34-1704-4ede-8398-17c0137f6e17@nvidia.com> (Avihai Horon's
 message of "Wed, 1 May 2024 15:08:16 +0300")
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-2-avihaih@nvidia.com>
 <fd972eee-068e-489e-ab45-e1985115a128@oracle.com>
 <703aab34-1704-4ede-8398-17c0137f6e17@nvidia.com>
Date: Mon, 06 May 2024 06:52:55 +0200
Message-ID: <87ttjbsfrs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

> On 01/05/2024 14:50, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 30/04/2024 06:16, Avihai Horon wrote:
>>> Add a new QAPI event for VFIO device migration state change. This event
>>> will be emitted when a VFIO device changes its migration state, for
>>> example, during migration or when stopping/starting the guest.
>>>
>>> This event can be used by management applications to get updates on the
>>> current state of the VFIO device for their own purposes.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> ---
>>>   MAINTAINERS           |  1 +
>>>   qapi/qapi-schema.json |  1 +
>>>   qapi/vfio.json        | 61 +++++++++++++++++++++++++++++++++++++++++++
>>>   qapi/meson.build      |  1 +
>>>   4 files changed, 64 insertions(+)
>>>   create mode 100644 qapi/vfio.json
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 302b6fd00c..ef58a39d36 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2159,6 +2159,7 @@ F: hw/vfio/*
>>>  F: include/hw/vfio/
>>>  F: docs/igd-assign.txt
>>>  F: docs/devel/migration/vfio.rst
>>> +F: qapi/vfio.json
>>>
>>>   vfio-ccw
>>>   M: Eric Farman <farman@linux.ibm.com>
>>> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
>>> index 5e33da7228..b1581988e4 100644
>>> --- a/qapi/qapi-schema.json
>>> +++ b/qapi/qapi-schema.json
>>> @@ -78,5 +78,6 @@
>>>  { 'include': 'pci.json' }
>>>  { 'include': 'stats.json' }
>>>  { 'include': 'virtio.json' }
>>> +{ 'include': 'vfio.json' }
>>>  { 'include': 'cryptodev.json' }
>>>  { 'include': 'cxl.json' }
>>> diff --git a/qapi/vfio.json b/qapi/vfio.json
>>> new file mode 100644
>>> index 0000000000..a38f26bccd
>>> --- /dev/null
>>> +++ b/qapi/vfio.json
>>> @@ -0,0 +1,61 @@
>>> +# -*- Mode: Python -*-
>>> +# vim: filetype=python
>>> +#
>>> +
>>> +##
>>> +# = VFIO devices
>>> +##
>>> +
>>> +##
>>> +# @VFIODeviceMigState:
>>> +#
>>> +# An enumeration of the VFIO device migration states.
>>> +#
>>> +# @stop: The device is stopped.
>>> +#
>>> +# @running: The device is running.
>>> +#
>>> +# @stop-copy: The device is stopped and its internal state is available
>>> +#     for reading.
>>> +#
>>> +# @resuming: The device is stopped and its internal state is available
>>> +#     for writing.
>>> +#
>>> +# @running-p2p: The device is running in the P2P quiescent state.
>>> +#
>>> +# @pre-copy: The device is running, tracking its internal state and its
>>> +#     internal state is available for reading.
>>> +#
>>> +# @pre-copy-p2p: The device is running in the P2P quiescent state,
>>> +#     tracking its internal state and its internal state is available
>>> +#     for reading.
>>> +#
>>> +# Since: 9.1
>>> +##
>>> +{ 'enum': 'VFIODeviceMigState',
>>> +  'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
>>> +            'pre-copy', 'pre-copy-p2p' ],
>>> +  'prefix': 'QAPI_VFIO_DEVICE_MIG_STATE' }

Without 'prefix', you get VFIO_DEVICE_MIG_STATE_STOP and so forth.  Why
do you need a QAPI_ prefix?

>>> +
>>
>> Considering MIG can also be interpreted as Multi Instance GPU elsewhere
>> unrelated to this shouldn't we be explicit here? i.e.
>>
>>          VFIO_DEVICE_MIGRATION_STATE
>>
>> ... to avoid ambiguiosity.
>
> I used mig to avoid long names, but I don't mind changing it to migration if that's clearer.
>
> Thanks.

We generally avoid abbreviations in QAPI/QMP.

The event that reports general migration state change is called
MIGRATION, and its data type MigrationStatus.

We could call this one VFIO_MIGRATION, and its data type
VfioMigrationStatus.

>>> +##
>>> +# @VFIO_DEVICE_MIG_STATE_CHANGED:
>>> +#
>>> +# This event is emitted when a VFIO device migration state is changed.
>>> +#
>>> +# @device-id: The id of the VFIO device (final component of QOM path).
>>> +#
>>> +# @device-state: The new changed device migration state.
>>> +#
>>> +# Since: 9.1
>>> +#
>>> +# Example:
>>> +#
>>> +#     <- {"timestamp": {"seconds": 1713771323, "microseconds": 212268},
>>> +#         "event": "VFIO_DEVICE_MIG_STATE_CHANGED",
>>> +#         "data": {"device-id": "vfio_dev1", "device-state": "stop"} }
>>> +##
>>> +{ 'event': 'VFIO_DEVICE_MIG_STATE_CHANGED',
>>> +  'data': {
>>> +      'device-id': 'str',
>>> +      'device-state': 'VFIODeviceMigState'
>>> +  } }
>>> diff --git a/qapi/meson.build b/qapi/meson.build
>>> index c92af6e063..e7bc54e5d0 100644
>>> --- a/qapi/meson.build
>>> +++ b/qapi/meson.build
>>> @@ -52,6 +52,7 @@ qapi_all_modules = [
>>>    'stats',
>>>    'trace',
>>>    'transaction',
>>> +  'vfio',
>>>    'virtio',
>>>    'yank',
>>>  ]

The new code is in the intersection of VFIO and migration.  Putting it
into new vfio.json instead of existing migration.json lets you add it to
MAINTAINERS section VFIO instead of Migration.  Up to the maintainers
involved.


