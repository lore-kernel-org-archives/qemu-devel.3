Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67B5C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 14:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3zTo-000868-7a; Mon, 06 May 2024 10:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s3zTm-00085w-3J
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:38:10 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s3zTj-0005aI-4u
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:38:09 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 55318384B0;
 Mon,  6 May 2024 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715006283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQioLuGgn1JZYmWvJxUNyCvjboJjLxh1W+bOV1LfEHg=;
 b=uknvM/IQn7UnPmhJ0eptiLX7fPerT2Cg6tN0TJ/fgHGGvSGeoOFDV9bBhcbqsiLDCdNQ9c
 acQkMCsTiA9mpIIMgBPmqMsmhrqAIO4kR3G+kT0iDdksbzl71tjXGRIUXC21X58SOXiq/6
 E4WNjnjaC9VUvXrfrMwuDy77BCHnOxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715006283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQioLuGgn1JZYmWvJxUNyCvjboJjLxh1W+bOV1LfEHg=;
 b=foTQoC4MvR9ktxKSF+4KtsB+th3TImlAxg6LN/8WRKJEIV3KPrnrasrGlcR8OWIVoNyWcq
 hAf82AgqsQS6ItCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715006283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQioLuGgn1JZYmWvJxUNyCvjboJjLxh1W+bOV1LfEHg=;
 b=uknvM/IQn7UnPmhJ0eptiLX7fPerT2Cg6tN0TJ/fgHGGvSGeoOFDV9bBhcbqsiLDCdNQ9c
 acQkMCsTiA9mpIIMgBPmqMsmhrqAIO4kR3G+kT0iDdksbzl71tjXGRIUXC21X58SOXiq/6
 E4WNjnjaC9VUvXrfrMwuDy77BCHnOxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715006283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQioLuGgn1JZYmWvJxUNyCvjboJjLxh1W+bOV1LfEHg=;
 b=foTQoC4MvR9ktxKSF+4KtsB+th3TImlAxg6LN/8WRKJEIV3KPrnrasrGlcR8OWIVoNyWcq
 hAf82AgqsQS6ItCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2E451386E;
 Mon,  6 May 2024 14:38:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N6AdJkrrOGb2cgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 06 May 2024 14:38:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Michael
 Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>, Peter Xu
 <peterx@redhat.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] vfio/migration: Emit VFIO device migration state
 change QAPI event
In-Reply-To: <87pltzsfl3.fsf@pond.sub.org>
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-3-avihaih@nvidia.com>
 <08936db7-46bf-42ba-ac14-49cb14f34646@oracle.com>
 <0d368ac4-fbba-4829-b25d-d49957b7c9da@nvidia.com>
 <5e9c1edd-4e99-4fb7-8b9a-159b1a6503c5@oracle.com>
 <600825d2-a314-4120-ad2a-0b1f3c5bb8d9@nvidia.com>
 <87pltzsfl3.fsf@pond.sub.org>
Date: Mon, 06 May 2024 11:38:00 -0300
Message-ID: <87ikzrm2ev.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Peter, Fabiano, I'd like to hear your opinion on the issue discussed
> below.
>
> Avihai Horon <avihaih@nvidia.com> writes:
>
>> On 02/05/2024 13:22, Joao Martins wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 01/05/2024 13:28, Avihai Horon wrote:
>>>> On 01/05/2024 14:50, Joao Martins wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On 30/04/2024 06:16, Avihai Horon wrote:
>>>>>> Emit VFIO device migration state change QAPI event when a VFIO device
>>>>>> changes its migration state. This can be used by management applicat=
ions
>>>>>> to get updates on the current state of the VFIO device for their own
>>>>>> purposes.
>>>>>>
>>>>>> A new per VFIO device capability, "migration-events", is added so ev=
ents
>>>>>> can be enabled only for the required devices. It is disabled by defa=
ult.
>>>>>>
>>>>>> Signed-off-by: Avihai Horon<avihaih@nvidia.com>
>>>>>> ---
>>>>>>    include/hw/vfio/vfio-common.h |=C2=A0 1 +
>>>>>>    hw/vfio/migration.c           | 44 ++++++++++++++++++++++++++++++=
+++++
>>>>>>    hw/vfio/pci.c                 |=C2=A0 2 ++
>>>>>>    3 files changed, 47 insertions(+)
>>>>>>
>>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-co=
mmon.h
>>>>>> index b9da6c08ef..3ec5f2425e 100644
>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>> @@ -115,6 +115,7 @@ typedef struct VFIODevice {
>>>>>>        bool no_mmap;
>>>>>>        bool ram_block_discard_allowed;
>>>>>>        OnOffAuto enable_migration;
>>>>>> +    bool migration_events;
>>>>>>        VFIODeviceOps *ops;
>>>>>>        unsigned int num_irqs;
>>>>>>        unsigned int num_regions;
>>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>>> index 06ae40969b..6bbccf6545 100644
>>>>>> --- a/hw/vfio/migration.c
>>>>>> +++ b/hw/vfio/migration.c
>>>>>> @@ -24,6 +24,7 @@
>>>>>>    #include "migration/register.h"
>>>>>>    #include "migration/blocker.h"
>>>>>>    #include "qapi/error.h"
>>>>>> +#include "qapi/qapi-events-vfio.h"
>>>>>>    #include "exec/ramlist.h"
>>>>>>    #include "exec/ram_addr.h"
>>>>>>    #include "pci.h"
>>>>>> @@ -80,6 +81,46 @@ static const char *mig_state_to_str(enum
>>>>>> vfio_device_mig_state state)
>>>>>>        }
>>>>>>    }
>>>>>>
>>>>>> +static VFIODeviceMigState
>>>>>> +mig_state_to_qapi_state(enum vfio_device_mig_state state)
>>>>>> +{
>>>>>> +    switch (state) {
>>>>>> +    case VFIO_DEVICE_STATE_STOP:
>>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP;
>>>>>> +    case VFIO_DEVICE_STATE_RUNNING:
>>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING;
>>>>>> +    case VFIO_DEVICE_STATE_STOP_COPY:
>>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP_COPY;
>>>>>> +    case VFIO_DEVICE_STATE_RESUMING:
>>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RESUMING;
>>>>>> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
>>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING_P2P;
>>>>>> +    case VFIO_DEVICE_STATE_PRE_COPY:
>>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY;
>>>>>> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
>>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY_P2P;
>>>>>> +    default:
>>>>>> +        g_assert_not_reached();
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>> +static void vfio_migration_send_state_change_event(VFIODevice *vbas=
edev)
>>>>>> +{
>>>>>> +    VFIOMigration *migration =3D vbasedev->migration;
>>>>>> +    const char *id;
>>>>>> +    Object *obj;
>>>>>> +
>>>>>> +    if (!vbasedev->migration_events) {
>>>>>> +        return;
>>>>>> +    }
>>>>>> +
>>>>> Shouldn't this leap frog migrate_events() capability instead of intro=
ducing its
>>>>> vfio equivalent i.e.
>>>>>
>>>>>           if (!migrate_events()) {
>>>>>               return;
>>>>>           }
>>>>>
>>>>> ?
>>>>
>>>> I used a per VFIO device cap so the events can be fine tuned for each =
device
>>>> (maybe one device should send events while the other not).
>>>> This gives the most flexibility and I don't think it complicates the
>>>> configuration (one downside, though, is that it can't be enabled/disab=
led
>>>> dynamically during runtime).
>>>>
>>> Right.
>>>
>>>> I don't think events add much overhead, so if you prefer a global cap,=
 I can
>>>> change it.
>>>> However, I'm not sure overloading the existing migrate_events() is val=
id?
>>>>
>>> migration 'events' capability just means we will have some migration ev=
ents
>>> emited via QAPI monitor for: 1) general global status and 2) for each m=
igration
>>> pass (both with different event names=3D.
>>
>> Yes, it's already overloaded.
>>
>> In migration QAPI it says: "@events: generate events for each migration =
state change (since 2.4)".
>> This only refers to the MIGRATION event AFAIU.
>>
>> Later on (in QEMU 2.6), MIGRATION_PASS event was added and the events ca=
p was overloaded for the first time (without changing=C2=A0@events descript=
ion).
>>
>> Now we want to add yet another use for events capability, the VFIO migra=
tion state change events.
>>
>> I think what bothers me is the @events description, which is not accurat=
e.
>> Maybe it should be changed to "@events: generate migration related event=
s (since 2.4)"? However, I'm not sure if it's OK to do this.
>>
>>>   So the suggestion was just what feels a
>>> natural extension of that (...)
>>>
>>>>> Applications that don't understand the event string (migration relate=
d or not)
>>>>> will just discard it (AIUI)
>>>
>>> (...) specially because of this as all these events have a different na=
me.
>>>
>>> But overloading might not make sense for others IDK ... it was just a s=
uggestion
>>> :) not a strong preference
>>
>> Yes, I get your rationale.
>> I don't have a strong opinion either, so maybe let's see what other peop=
le think.

I don't see the need to tie this to the migration events
capability. Although there's overlap in the terms used, this seems more
like exposing a device feature via QEMU, then a migration event
per-se. The state changes also happen during moments unrelated to
migration (cover letter mentions start/stopping guest), so I assume we'd
like to keep those even if the management layer doesn't want to see
migration events.

