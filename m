Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6114CA0FED
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 13:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk1HB-0007DH-S7; Fri, 30 Aug 2024 09:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sk1H7-0007Cg-9W
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:02:51 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sk1H5-0001WC-6t
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:02:48 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DAB711F7D0;
 Fri, 30 Aug 2024 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725022964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+LXnu2H1gXwIJ5kld/mDO9JQ0LC09eXN5+F9KjAGpXA=;
 b=15o4Ry5/8Y6XX0J8V/pqVyHOvDQ38H0j3v9rRnjtoUMidhKm8+wvHxrOfGQXy3m5FFqOgJ
 RvJYwdLY06ZyMUtcIpwI39nMCjiWLFCfuYg/7h/9VamcRD7WK7uhD8KCOZ7uXiyMEBgVrf
 ZDYzNZcd1Gm71jwu9x0ucb5jzKhd0U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725022964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+LXnu2H1gXwIJ5kld/mDO9JQ0LC09eXN5+F9KjAGpXA=;
 b=G1swtPOC1Zri0VQ9GublbXJKjEKiIfj2Q7206l0FU9Omf0wFLETf6xuqYPdX0VCK2GzDol
 e0PMBpLk155etECw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725022963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+LXnu2H1gXwIJ5kld/mDO9JQ0LC09eXN5+F9KjAGpXA=;
 b=08vtsDkOG+NMjUqw3AXbty65N/1v2kRqquty0qA3uXwB3aBxY01jcxGGE2+ARu6sHT4aF7
 VDXfHNWao8TBml7uFka4WkCp/Pz07//k6xHXW4ghr8lxI+VX7glQCZmotRNE9jPJX/VlXR
 /tHS5na+EY0labMCHfZxXXiCyKT2XAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725022963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+LXnu2H1gXwIJ5kld/mDO9JQ0LC09eXN5+F9KjAGpXA=;
 b=93wajRv7eTnqi0/VFUlqvcGnb9wseLqohVaqsjqxJ9TBUyHUbv63JeyhFsNJK/XoSnUPqJ
 YBE9hG7j0e+fBGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63F3313A3D;
 Fri, 30 Aug 2024 13:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uhqmCvPC0WZJTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 30 Aug 2024 13:02:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Dan?=
 =?utf-8?Q?iel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Joao
 Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/17] migration/multifd: Device state transfer
 support - send side
In-Reply-To: <bbdac26f-4a38-4cee-a9aa-cfae61b16dea@maciej.szmigiero.name>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <fdcfd68dfcf3b20278a4495eb639905b2a8e8ff3.1724701542.git.maciej.szmigiero@oracle.com>
 <87h6b4nosy.fsf@suse.de>
 <bbdac26f-4a38-4cee-a9aa-cfae61b16dea@maciej.szmigiero.name>
Date: Fri, 30 Aug 2024 10:02:40 -0300
Message-ID: <87bk1anoy7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> On 29.08.2024 02:41, Fabiano Rosas wrote:
>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>> 
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> A new function multifd_queue_device_state() is provided for device to queue
>>> its state for transmission via a multifd channel.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   include/migration/misc.h         |  4 ++
>>>   migration/meson.build            |  1 +
>>>   migration/multifd-device-state.c | 99 ++++++++++++++++++++++++++++++++
>>>   migration/multifd-nocomp.c       |  6 +-
>>>   migration/multifd-qpl.c          |  2 +-
>>>   migration/multifd-uadk.c         |  2 +-
>>>   migration/multifd-zlib.c         |  2 +-
>>>   migration/multifd-zstd.c         |  2 +-
>>>   migration/multifd.c              | 65 +++++++++++++++------
>>>   migration/multifd.h              | 29 +++++++++-
>>>   10 files changed, 184 insertions(+), 28 deletions(-)
>>>   create mode 100644 migration/multifd-device-state.c
>>>
>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>> index bfadc5613bac..7266b1b77d1f 100644
>>> --- a/include/migration/misc.h
>>> +++ b/include/migration/misc.h
>>> @@ -111,4 +111,8 @@ bool migration_in_bg_snapshot(void);
>>>   /* migration/block-dirty-bitmap.c */
>>>   void dirty_bitmap_mig_init(void);
>>>   
>>> +/* migration/multifd-device-state.c */
>>> +bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
>>> +                                char *data, size_t len);
>>> +
>>>   #endif
>>> diff --git a/migration/meson.build b/migration/meson.build
>>> index 77f3abf08eb1..00853595894f 100644
>>> --- a/migration/meson.build
>>> +++ b/migration/meson.build
>>> @@ -21,6 +21,7 @@ system_ss.add(files(
>>>     'migration-hmp-cmds.c',
>>>     'migration.c',
>>>     'multifd.c',
>>> +  'multifd-device-state.c',
>>>     'multifd-nocomp.c',
>>>     'multifd-zlib.c',
>>>     'multifd-zero-page.c',
>>> diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
>>> new file mode 100644
>>> index 000000000000..c9b44f0b5ab9
>>> --- /dev/null
>>> +++ b/migration/multifd-device-state.c
>>> @@ -0,0 +1,99 @@
>>> +/*
>>> + * Multifd device state migration
>>> + *
>>> + * Copyright (C) 2024 Oracle and/or its affiliates.
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>>> + * See the COPYING file in the top-level directory.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/lockable.h"
>>> +#include "migration/misc.h"
>>> +#include "multifd.h"
>>> +
>>> +static QemuMutex queue_job_mutex;
>>> +
>>> +static MultiFDSendData *device_state_send;
>>> +
>>> +size_t multifd_device_state_payload_size(void)
>>> +{
>>> +    return sizeof(MultiFDDeviceState_t);
>>> +}
>> 
>> This will not be necessary because the payload size is the same as the
>> data type. We only need it for the special case where the MultiFDPages_t
>> is smaller than the total ram payload size.
>
> I know - I just wanted to make the API consistent with the one RAM
> handler provides since these multifd_send_data_alloc() calls are done
> just once per migration - it isn't any kind of a hot path.
>

I think the array at the end of MultiFDPages_t should be considered
enough of a hack that we might want to keep anything related to it
outside of the interface. Other clients shouldn't have to think about
that at all.

>>> @@ -397,20 +404,16 @@ bool multifd_send(MultiFDSendData **send_data)
>>>   
>>>           p = &multifd_send_state->params[i];
>>>           /*
>>> -         * Lockless read to p->pending_job is safe, because only multifd
>>> -         * sender thread can clear it.
>>> +         * Lockless RMW on p->pending_job_preparing is safe, because only multifd
>>> +         * sender thread can clear it after it had seen p->pending_job being set.
>>> +         *
>>> +         * Pairs with qatomic_store_release() in multifd_send_thread().
>>>            */
>>> -        if (qatomic_read(&p->pending_job) == false) {
>>> +        if (qatomic_cmpxchg(&p->pending_job_preparing, false, true) == false) {
>> 
>> What's the motivation for this change? It would be better to have it in
>> a separate patch with a proper justification.
>
> The original RFC patch set used dedicated device state multifd channels.
>
> Peter and other people wanted this functionality removed, however this caused
> a performance (downtime) regression.
>
> One of the things that seemed to help mitigate this regression was making
> the multifd channel selection more fair via this change.
>
> But I can split out it to a separate commit in the next patch set version and
> then see what performance improvement it currently brings.

Yes, better to have it separate if anything for documentation of the
rationale.


