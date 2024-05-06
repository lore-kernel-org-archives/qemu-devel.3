Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14F9C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 04:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3qPb-0006t0-2c; Mon, 06 May 2024 00:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3qPS-0006rc-JO
 for qemu-devel@nongnu.org; Mon, 06 May 2024 00:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3qPQ-0002WP-It
 for qemu-devel@nongnu.org; Mon, 06 May 2024 00:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714971423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+N22pQXobkPtk5VAWMDLseqHJbfnXNMC7mGBjCdd9Wg=;
 b=OwrI8NbDUQYH+rmsG7oo4cH+zC/RrHWmtYKDuts1PUnl7G87ZKwGaylVp5kU1xJUcdAch2
 xMwYlkL0dhXnhreKyHIDTeQuPtmQuhIeub45RvjFof3bNMUtxs/gb2zJEsxinNnphtTlHU
 fieFAxKVuIp7EkOzrS3RLQzQM5WXIBk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-8hgEorZ0OTqa-FF3OjWssg-1; Mon,
 06 May 2024 00:56:58 -0400
X-MC-Unique: 8hgEorZ0OTqa-FF3OjWssg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22D0E3806737;
 Mon,  6 May 2024 04:56:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB0D1C271A9;
 Mon,  6 May 2024 04:56:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CBF7B21E6806; Mon,  6 May 2024 06:56:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,  Alex Williamson
 <alex.williamson@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  Eric Blake <eblake@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Maor Gottlieb
 <maorg@nvidia.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] vfio/migration: Emit VFIO device migration state
 change QAPI event
In-Reply-To: <600825d2-a314-4120-ad2a-0b1f3c5bb8d9@nvidia.com> (Avihai Horon's
 message of "Sun, 5 May 2024 10:28:33 +0300")
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-3-avihaih@nvidia.com>
 <08936db7-46bf-42ba-ac14-49cb14f34646@oracle.com>
 <0d368ac4-fbba-4829-b25d-d49957b7c9da@nvidia.com>
 <5e9c1edd-4e99-4fb7-8b9a-159b1a6503c5@oracle.com>
 <600825d2-a314-4120-ad2a-0b1f3c5bb8d9@nvidia.com>
Date: Mon, 06 May 2024 06:56:56 +0200
Message-ID: <87pltzsfl3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

Peter, Fabiano, I'd like to hear your opinion on the issue discussed
below.

Avihai Horon <avihaih@nvidia.com> writes:

> On 02/05/2024 13:22, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 01/05/2024 13:28, Avihai Horon wrote:
>>> On 01/05/2024 14:50, Joao Martins wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 30/04/2024 06:16, Avihai Horon wrote:
>>>>> Emit VFIO device migration state change QAPI event when a VFIO device
>>>>> changes its migration state. This can be used by management applicati=
ons
>>>>> to get updates on the current state of the VFIO device for their own
>>>>> purposes.
>>>>>
>>>>> A new per VFIO device capability, "migration-events", is added so eve=
nts
>>>>> can be enabled only for the required devices. It is disabled by defau=
lt.
>>>>>
>>>>> Signed-off-by: Avihai Horon<avihaih@nvidia.com>
>>>>> ---
>>>>>    include/hw/vfio/vfio-common.h |=C2=A0 1 +
>>>>>    hw/vfio/migration.c           | 44 +++++++++++++++++++++++++++++++=
++++
>>>>>    hw/vfio/pci.c                 |=C2=A0 2 ++
>>>>>    3 files changed, 47 insertions(+)
>>>>>
>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-com=
mon.h
>>>>> index b9da6c08ef..3ec5f2425e 100644
>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>> @@ -115,6 +115,7 @@ typedef struct VFIODevice {
>>>>>        bool no_mmap;
>>>>>        bool ram_block_discard_allowed;
>>>>>        OnOffAuto enable_migration;
>>>>> +    bool migration_events;
>>>>>        VFIODeviceOps *ops;
>>>>>        unsigned int num_irqs;
>>>>>        unsigned int num_regions;
>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>> index 06ae40969b..6bbccf6545 100644
>>>>> --- a/hw/vfio/migration.c
>>>>> +++ b/hw/vfio/migration.c
>>>>> @@ -24,6 +24,7 @@
>>>>>    #include "migration/register.h"
>>>>>    #include "migration/blocker.h"
>>>>>    #include "qapi/error.h"
>>>>> +#include "qapi/qapi-events-vfio.h"
>>>>>    #include "exec/ramlist.h"
>>>>>    #include "exec/ram_addr.h"
>>>>>    #include "pci.h"
>>>>> @@ -80,6 +81,46 @@ static const char *mig_state_to_str(enum
>>>>> vfio_device_mig_state state)
>>>>>        }
>>>>>    }
>>>>>
>>>>> +static VFIODeviceMigState
>>>>> +mig_state_to_qapi_state(enum vfio_device_mig_state state)
>>>>> +{
>>>>> +    switch (state) {
>>>>> +    case VFIO_DEVICE_STATE_STOP:
>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP;
>>>>> +    case VFIO_DEVICE_STATE_RUNNING:
>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING;
>>>>> +    case VFIO_DEVICE_STATE_STOP_COPY:
>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP_COPY;
>>>>> +    case VFIO_DEVICE_STATE_RESUMING:
>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RESUMING;
>>>>> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING_P2P;
>>>>> +    case VFIO_DEVICE_STATE_PRE_COPY:
>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY;
>>>>> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY_P2P;
>>>>> +    default:
>>>>> +        g_assert_not_reached();
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +static void vfio_migration_send_state_change_event(VFIODevice *vbase=
dev)
>>>>> +{
>>>>> +    VFIOMigration *migration =3D vbasedev->migration;
>>>>> +    const char *id;
>>>>> +    Object *obj;
>>>>> +
>>>>> +    if (!vbasedev->migration_events) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>> Shouldn't this leap frog migrate_events() capability instead of introd=
ucing its
>>>> vfio equivalent i.e.
>>>>
>>>>           if (!migrate_events()) {
>>>>               return;
>>>>           }
>>>>
>>>> ?
>>>
>>> I used a per VFIO device cap so the events can be fine tuned for each d=
evice
>>> (maybe one device should send events while the other not).
>>> This gives the most flexibility and I don't think it complicates the
>>> configuration (one downside, though, is that it can't be enabled/disabl=
ed
>>> dynamically during runtime).
>>>
>> Right.
>>
>>> I don't think events add much overhead, so if you prefer a global cap, =
I can
>>> change it.
>>> However, I'm not sure overloading the existing migrate_events() is vali=
d?
>>>
>> migration 'events' capability just means we will have some migration eve=
nts
>> emited via QAPI monitor for: 1) general global status and 2) for each mi=
gration
>> pass (both with different event names=3D.
>
> Yes, it's already overloaded.
>
> In migration QAPI it says: "@events: generate events for each migration s=
tate change (since 2.4)".
> This only refers to the MIGRATION event AFAIU.
>
> Later on (in QEMU 2.6), MIGRATION_PASS event was added and the events cap=
 was overloaded for the first time (without changing=C2=A0@events descripti=
on).
>
> Now we want to add yet another use for events capability, the VFIO migrat=
ion state change events.
>
> I think what bothers me is the @events description, which is not accurate.
> Maybe it should be changed to "@events: generate migration related events=
 (since 2.4)"? However, I'm not sure if it's OK to do this.
>
>>   So the suggestion was just what feels a
>> natural extension of that (...)
>>
>>>> Applications that don't understand the event string (migration related=
 or not)
>>>> will just discard it (AIUI)
>>
>> (...) specially because of this as all these events have a different nam=
e.
>>
>> But overloading might not make sense for others IDK ... it was just a su=
ggestion
>> :) not a strong preference
>
> Yes, I get your rationale.
> I don't have a strong opinion either, so maybe let's see what other peopl=
e think.
>
> Thanks.

[...]


