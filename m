Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64F4D6555B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG31D-0006oZ-E6; Tue, 26 Nov 2024 16:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tG31A-0006dT-UN
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:22:44 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tG318-000331-RK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:22:44 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tG315-00000002pn4-0nLq; Tue, 26 Nov 2024 22:22:39 +0100
Message-ID: <9f0ea9c4-2ca1-4340-a156-e9378910a87f@maciej.szmigiero.name>
Date: Tue, 26 Nov 2024 22:22:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/24] migration/multifd: Device state transfer support
 - send side
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <dbff60e022ada2f072300559bd24d9e0939be21a.1731773021.git.maciej.szmigiero@oracle.com>
 <87serdn4vz.fsf@suse.de>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <87serdn4vz.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 26.11.2024 20:58, Fabiano Rosas wrote:
> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
> 
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> A new function multifd_queue_device_state() is provided for device to queue
>> its state for transmission via a multifd channel.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   include/migration/misc.h         |   4 ++
>>   migration/meson.build            |   1 +
>>   migration/multifd-device-state.c | 106 +++++++++++++++++++++++++++++++
>>   migration/multifd-nocomp.c       |  11 +++-
>>   migration/multifd.c              |  43 +++++++++++--
>>   migration/multifd.h              |  24 ++++---
>>   6 files changed, 173 insertions(+), 16 deletions(-)
>>   create mode 100644 migration/multifd-device-state.c
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index c92ca018ab3b..118e205bbcc6 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -109,4 +109,8 @@ bool migration_incoming_postcopy_advised(void);
>>   /* True if background snapshot is active */
>>   bool migration_in_bg_snapshot(void);
>>   
>> +/* migration/multifd-device-state.c */
>> +bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
>> +                                char *data, size_t len);
>> +
>>   #endif
>> diff --git a/migration/meson.build b/migration/meson.build
>> index d53cf3417ab8..9788c47bb56e 100644
>> --- a/migration/meson.build
>> +++ b/migration/meson.build
>> @@ -22,6 +22,7 @@ system_ss.add(files(
>>     'migration-hmp-cmds.c',
>>     'migration.c',
>>     'multifd.c',
>> +  'multifd-device-state.c',
>>     'multifd-nocomp.c',
>>     'multifd-zlib.c',
>>     'multifd-zero-page.c',
>> diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
>> new file mode 100644
>> index 000000000000..7741a64fbd4d
>> --- /dev/null
>> +++ b/migration/multifd-device-state.c
>> @@ -0,0 +1,106 @@
>> +/*
>> + * Multifd device state migration
>> + *
>> + * Copyright (C) 2024 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/lockable.h"
>> +#include "migration/misc.h"
>> +#include "multifd.h"
>> +
>> +static QemuMutex queue_job_mutex;
>> +
>> +static MultiFDSendData *device_state_send;
>> +
>> +size_t multifd_device_state_payload_size(void)
>> +{
>> +    return sizeof(MultiFDDeviceState_t);
>> +}
>> +
>> +void multifd_device_state_send_setup(void)
>> +{
>> +    qemu_mutex_init(&queue_job_mutex);
>> +
>> +    device_state_send = multifd_send_data_alloc();
>> +}
>> +
>> +void multifd_device_state_clear(MultiFDDeviceState_t *device_state)
>> +{
>> +    g_clear_pointer(&device_state->idstr, g_free);
>> +    g_clear_pointer(&device_state->buf, g_free);
>> +}
>> +
>> +void multifd_device_state_send_cleanup(void)
>> +{
>> +    g_clear_pointer(&device_state_send, multifd_send_data_free);
>> +
>> +    qemu_mutex_destroy(&queue_job_mutex);
>> +}
>> +
>> +static void multifd_device_state_fill_packet(MultiFDSendParams *p)
>> +{
>> +    MultiFDDeviceState_t *device_state = &p->data->u.device_state;
>> +    MultiFDPacketDeviceState_t *packet = p->packet_device_state;
>> +
>> +    packet->hdr.flags = cpu_to_be32(p->flags);
>> +    strncpy(packet->idstr, device_state->idstr, sizeof(packet->idstr));
>> +    packet->instance_id = cpu_to_be32(device_state->instance_id);
>> +    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
>> +}
>> +
>> +static void multifd_prepare_header_device_state(MultiFDSendParams *p)
>> +{
>> +    p->iov[0].iov_len = sizeof(*p->packet_device_state);
>> +    p->iov[0].iov_base = p->packet_device_state;
>> +    p->iovs_num++;
>> +}
>> +
>> +void multifd_device_state_send_prepare(MultiFDSendParams *p)
>> +{
>> +    MultiFDDeviceState_t *device_state = &p->data->u.device_state;
>> +
>> +    assert(multifd_payload_device_state(p->data));
>> +
>> +    multifd_prepare_header_device_state(p);
>> +
>> +    assert(!(p->flags & MULTIFD_FLAG_SYNC));
>> +
>> +    p->next_packet_size = device_state->buf_len;
>> +    if (p->next_packet_size > 0) {
>> +        p->iov[p->iovs_num].iov_base = device_state->buf;
>> +        p->iov[p->iovs_num].iov_len = p->next_packet_size;
>> +        p->iovs_num++;
>> +    }
>> +
>> +    p->flags |= MULTIFD_FLAG_NOCOMP | MULTIFD_FLAG_DEVICE_STATE;
>> +
>> +    multifd_device_state_fill_packet(p);
>> +}
>> +
>> +bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
>> +                                char *data, size_t len)
>> +{
>> +    /* Device state submissions can come from multiple threads */
>> +    QEMU_LOCK_GUARD(&queue_job_mutex);
>> +    MultiFDDeviceState_t *device_state;
>> +
>> +    assert(multifd_payload_empty(device_state_send));
>> +
>> +    multifd_set_payload_type(device_state_send, MULTIFD_PAYLOAD_DEVICE_STATE);
>> +    device_state = &device_state_send->u.device_state;
>> +    device_state->idstr = g_strdup(idstr);
>> +    device_state->instance_id = instance_id;
>> +    device_state->buf = g_memdup2(data, len);
>> +    device_state->buf_len = len;
>> +
>> +    if (!multifd_send(&device_state_send)) {
>> +        multifd_send_data_clear(device_state_send);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
>> index fa0fd0289eca..23564ce9aea9 100644
>> --- a/migration/multifd-nocomp.c
>> +++ b/migration/multifd-nocomp.c
>> @@ -84,6 +84,13 @@ static void multifd_nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
>>       return;
>>   }
>>   
>> +static void multifd_ram_prepare_header(MultiFDSendParams *p)
>> +{
>> +    p->iov[0].iov_len = p->packet_len;
>> +    p->iov[0].iov_base = p->packet;
>> +    p->iovs_num++;
>> +}
>> +
>>   static void multifd_send_prepare_iovs(MultiFDSendParams *p)
>>   {
>>       MultiFDPages_t *pages = &p->data->u.ram;
>> @@ -117,7 +124,7 @@ static int multifd_nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
>>            * Only !zerocopy needs the header in IOV; zerocopy will
>>            * send it separately.
>>            */
>> -        multifd_send_prepare_header(p);
>> +        multifd_ram_prepare_header(p);
>>       }
>>   
>>       multifd_send_prepare_iovs(p);
>> @@ -368,7 +375,7 @@ bool multifd_send_prepare_common(MultiFDSendParams *p)
>>           return false;
>>       }
>>   
>> -    multifd_send_prepare_header(p);
>> +    multifd_ram_prepare_header(p);
>>   
>>       return true;
>>   }
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index 730acf55cfad..56419af417cc 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -12,6 +12,7 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qemu/cutils.h"
>> +#include "qemu/iov.h"
>>   #include "qemu/rcu.h"
>>   #include "exec/target_page.h"
>>   #include "sysemu/sysemu.h"
>> @@ -19,6 +20,7 @@
>>   #include "qemu/error-report.h"
>>   #include "qapi/error.h"
>>   #include "file.h"
>> +#include "migration/misc.h"
>>   #include "migration.h"
>>   #include "migration-stats.h"
>>   #include "savevm.h"
>> @@ -111,7 +113,9 @@ MultiFDSendData *multifd_send_data_alloc(void)
>>        * added to the union in the future are larger than
>>        * (MultiFDPages_t + flex array).
>>        */
>> -    max_payload_size = MAX(multifd_ram_payload_size(), sizeof(MultiFDPayload));
>> +    max_payload_size = MAX(multifd_ram_payload_size(),
>> +                           multifd_device_state_payload_size());
>> +    max_payload_size = MAX(max_payload_size, sizeof(MultiFDPayload));
>>   
>>       /*
>>        * Account for any holes the compiler might insert. We can't pack
>> @@ -130,6 +134,9 @@ void multifd_send_data_clear(MultiFDSendData *data)
>>       }
>>   
>>       switch (data->type) {
>> +    case MULTIFD_PAYLOAD_DEVICE_STATE:
>> +        multifd_device_state_clear(&data->u.device_state);
>> +        break;
>>       default:
>>           /* Nothing to do */
>>           break;
>> @@ -232,6 +239,7 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
>>       return msg.id;
>>   }
>>   
>> +/* Fills a RAM multifd packet */
>>   void multifd_send_fill_packet(MultiFDSendParams *p)
>>   {
>>       MultiFDPacket_t *packet = p->packet;
>> @@ -524,6 +532,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>>       p->name = NULL;
>>       g_clear_pointer(&p->data, multifd_send_data_free);
>>       p->packet_len = 0;
>> +    g_clear_pointer(&p->packet_device_state, g_free);
>>       g_free(p->packet);
>>       p->packet = NULL;
>>       multifd_send_state->ops->send_cleanup(p, errp);
>> @@ -536,6 +545,7 @@ static void multifd_send_cleanup_state(void)
>>   {
>>       file_cleanup_outgoing_migration();
>>       socket_cleanup_outgoing_migration();
>> +    multifd_device_state_send_cleanup();
>>       qemu_sem_destroy(&multifd_send_state->channels_created);
>>       qemu_sem_destroy(&multifd_send_state->channels_ready);
>>       qemu_mutex_destroy(&multifd_send_state->multifd_send_mutex);
>> @@ -662,16 +672,33 @@ static void *multifd_send_thread(void *opaque)
>>            * qatomic_store_release() in multifd_send().
>>            */
>>           if (qatomic_load_acquire(&p->pending_job)) {
>> +            bool is_device_state = multifd_payload_device_state(p->data);
>> +            size_t total_size;
>> +
>>               p->flags = 0;
>>               p->iovs_num = 0;
>>               assert(!multifd_payload_empty(p->data));
>>   
>> -            ret = multifd_send_state->ops->send_prepare(p, &local_err);
>> -            if (ret != 0) {
>> -                break;
>> +            if (is_device_state) {
>> +                multifd_device_state_send_prepare(p);
>> +
>> +                total_size = iov_size(p->iov, p->iovs_num);
> 
> This is such a good idea, because it allows us to kill
> next_packet_size. Let's make it work.
> 
> What if you add packet_len to mig_stats under use_zero_copy at
> multifd_nocomp_send_prepare? It's only fair since that's when the data
> is actually sent. Then this total_size gets consolidated between the
> paths.
> 

Adding the header to multifd_bytes where it is actually sent
(in multifd_nocomp_send_prepare() in this case) makes sense to me -
will change it so.

Thanks,
Maciej


