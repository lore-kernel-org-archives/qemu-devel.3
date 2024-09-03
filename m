Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC44CD343E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUkM-0004qD-Ci; Tue, 03 Sep 2024 10:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slUkK-0004fm-9q
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:43:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slUkI-0004ly-3r
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:43:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2584121A53;
 Tue,  3 Sep 2024 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725374580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vf0RZMsmoHHRG6JtjPuzWKSfO1RT6uJZRa5qVzis0HE=;
 b=KoAgZj8RlmN/BnUpB3nnSayWtZQcyEoUe2KB6N7eyDzJGmBX/ni3DZHGEFCZ2hQ1hO1ugq
 9xYRtHPwu0gs1xfOQTKi/eqjgBFmIAYt9FtGoEmDVLbJmqy/IkaRov8HNjIJVdFZ0yMiVB
 Ohf9CHZNab69swMQ8DOGZGe/s5Uso8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725374580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vf0RZMsmoHHRG6JtjPuzWKSfO1RT6uJZRa5qVzis0HE=;
 b=q6KifJ/59CzErgtF1TWSoOXMNr07Jr7YS80wLyT9TeRNPWqd06By5D/ah8hmYieUIX9+JV
 ZSlpFCuO1oikLVDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KoAgZj8R;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="q6KifJ/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725374580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vf0RZMsmoHHRG6JtjPuzWKSfO1RT6uJZRa5qVzis0HE=;
 b=KoAgZj8RlmN/BnUpB3nnSayWtZQcyEoUe2KB6N7eyDzJGmBX/ni3DZHGEFCZ2hQ1hO1ugq
 9xYRtHPwu0gs1xfOQTKi/eqjgBFmIAYt9FtGoEmDVLbJmqy/IkaRov8HNjIJVdFZ0yMiVB
 Ohf9CHZNab69swMQ8DOGZGe/s5Uso8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725374580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vf0RZMsmoHHRG6JtjPuzWKSfO1RT6uJZRa5qVzis0HE=;
 b=q6KifJ/59CzErgtF1TWSoOXMNr07Jr7YS80wLyT9TeRNPWqd06By5D/ah8hmYieUIX9+JV
 ZSlpFCuO1oikLVDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A328C13A80;
 Tue,  3 Sep 2024 14:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sOsOGnMg12b/XwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Sep 2024 14:42:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 09/17] migration/multifd: Device state transfer
 support - receive side
In-Reply-To: <00eeacd5-ad27-4899-8526-0941b30e759d@maciej.szmigiero.name>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <84141182083a8417c25b4d82a9c4b6228b22ac67.1724701542.git.maciej.szmigiero@oracle.com>
 <87ttf1n4lm.fsf@suse.de>
 <00eeacd5-ad27-4899-8526-0941b30e759d@maciej.szmigiero.name>
Date: Tue, 03 Sep 2024 11:42:57 -0300
Message-ID: <87frqgn6ha.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 2584121A53
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> On 30.08.2024 22:22, Fabiano Rosas wrote:
>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>> 
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Add a basic support for receiving device state via multifd channels -
>>> channels that are shared with RAM transfers.
>>>
>>> To differentiate between a device state and a RAM packet the packet
>>> header is read first.
>>>
>>> Depending whether MULTIFD_FLAG_DEVICE_STATE flag is present or not in the
>>> packet header either device state (MultiFDPacketDeviceState_t) or RAM
>>> data (existing MultiFDPacket_t) is then read.
>>>
>>> The received device state data is provided to
>>> qemu_loadvm_load_state_buffer() function for processing in the
>>> device's load_state_buffer handler.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   migration/multifd.c | 127 +++++++++++++++++++++++++++++++++++++-------
>>>   migration/multifd.h |  31 ++++++++++-
>>>   2 files changed, 138 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/migration/multifd.c b/migration/multifd.c
>>> index b06a9fab500e..d5a8e5a9c9b5 100644
>>> --- a/migration/multifd.c
>>> +++ b/migration/multifd.c
> (..)
>>>       g_free(p->zero);
>>> @@ -1126,8 +1159,13 @@ static void *multifd_recv_thread(void *opaque)
>>>       rcu_register_thread();
>>>   
>>>       while (true) {
>>> +        MultiFDPacketHdr_t hdr;
>>>           uint32_t flags = 0;
>>> +        bool is_device_state = false;
>>>           bool has_data = false;
>>> +        uint8_t *pkt_buf;
>>> +        size_t pkt_len;
>>> +
>>>           p->normal_num = 0;
>>>   
>>>           if (use_packets) {
>>> @@ -1135,8 +1173,28 @@ static void *multifd_recv_thread(void *opaque)
>>>                   break;
>>>               }
>>>   
>>> -            ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
>>> -                                           p->packet_len, &local_err);
>>> +            ret = qio_channel_read_all_eof(p->c, (void *)&hdr,
>>> +                                           sizeof(hdr), &local_err);
>>> +            if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
>>> +                break;
>>> +            }
>>> +
>>> +            ret = multifd_recv_unfill_packet_header(p, &hdr, &local_err);
>>> +            if (ret) {
>>> +                break;
>>> +            }
>>> +
>>> +            is_device_state = p->flags & MULTIFD_FLAG_DEVICE_STATE;
>>> +            if (is_device_state) {
>>> +                pkt_buf = (uint8_t *)p->packet_dev_state + sizeof(hdr);
>>> +                pkt_len = sizeof(*p->packet_dev_state) - sizeof(hdr);
>>> +            } else {
>>> +                pkt_buf = (uint8_t *)p->packet + sizeof(hdr);
>>> +                pkt_len = p->packet_len - sizeof(hdr);
>>> +            }
>> 
>> Should we have made the packet an union as well? Would simplify these
>> sorts of operations. Not sure I want to start messing with that at this
>> point to be honest. But OTOH, look at this...
>
> RAM packet length is not constant (at least from the viewpoint of the
> migration code) so the union allocation would need some kind of a
> "multifd_ram_packet_size()" runtime size determination.
>
> Also, since RAM and device state packet body size is different then
> for the extra complexity introduced by that union we'll just get rid of
> that single pkt_buf assignment.
>
>>> +
>>> +            ret = qio_channel_read_all_eof(p->c, (char *)pkt_buf, pkt_len,
>>> +                                           &local_err);
>>>               if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
>>>                   break;
>>>               }
>>> @@ -1181,8 +1239,33 @@ static void *multifd_recv_thread(void *opaque)
>>>               has_data = !!p->data->size;
>>>           }
>>>   
>>> -        if (has_data) {
>>> -            ret = multifd_recv_state->ops->recv(p, &local_err);
>>> +        if (!is_device_state) {
>>> +            if (has_data) {
>>> +                ret = multifd_recv_state->ops->recv(p, &local_err);
>>> +                if (ret != 0) {
>>> +                    break;
>>> +                }
>>> +            }
>>> +        } else {
>>> +            g_autofree char *idstr = NULL;
>>> +            g_autofree char *dev_state_buf = NULL;
>>> +
>>> +            assert(use_packets);
>>> +
>>> +            if (p->next_packet_size > 0) {
>>> +                dev_state_buf = g_malloc(p->next_packet_size);
>>> +
>>> +                ret = qio_channel_read_all(p->c, dev_state_buf, p->next_packet_size, &local_err);
>>> +                if (ret != 0) {
>>> +                    break;
>>> +                }
>>> +            }
>> 
>> What's the use case for !next_packet_size and still call
>> load_state_buffer below? I can't see it.
>
> Currently, next_packet_size == 0 has not usage indeed - it is
> a leftover from an early version of the patch set (not public)
> that had device state packet (chunk) indexing done by
> the common migration code, rather than by the VFIO consumer.
>
> And then an empty packet could be used to mark the stream
> boundary - like the max chunk number to expect.
>
>> ...because I would suggest to set has_data up there with
>> p->next_packet_size:
>> 
>> if (use_packets) {
>>     ...
>>     has_data = p->next_packet_size || p->zero_num;
>> } else {
>>     ...
>>     has_data = !!p->data_size;
>> }
>> 
>> and this whole block would be:
>> 
>> if (has_data) {
>>     if (is_device_state) {
>>         multifd_device_state_recv(p, &local_err);
>>     } else {
>>         ret = multifd_recv_state->ops->recv(p, &local_err);
>>     }
>> }
>
> The above block makes sense to me with two caveats:

I have suggestions below, but this is no big deal, so feel free to go
with what you think works best.

> 1) If empty device state packets (next_packet_size == 0) were
> to be unsupported they need to be rejected cleanly rather
> than silently skipped,

Should this be rejected on the send side? That's the most likely source
of the problem if it happens. Don't need to send something we know will
cause an error when loading.

And for the case of stream corruption of some sort we could hoist the
check from load_buffer into here:

 else if (is_device_state) {
    error_setg(errp, "empty device state packet);
    break;
}

> 2) has_data has to have its value computed depending on whether
> this is a RAM or a device state packet since looking at
> p->normal_num and p->zero_num makes no sense for a device state
> packet while I am not sure that looking at p->next_packet_size
> for a RAM packet won't introduce some subtle regression.

It should be ok to use next_packet_size for RAM, it must always be in
sync with normal_num.

>
>>> +
>>> +            idstr = g_strndup(p->packet_dev_state->idstr, sizeof(p->packet_dev_state->idstr));
>>> +            ret = qemu_loadvm_load_state_buffer(idstr,
>>> +                                                p->packet_dev_state->instance_id,
>>> +                                                dev_state_buf, p->next_packet_size,
>>> +                                                &local_err);
>>>               if (ret != 0) {
>>>                   break;
>>>               }
>>> @@ -1190,6 +1273,11 @@ static void *multifd_recv_thread(void *opaque)
>>>   
>>>           if (use_packets) {
>>>               if (flags & MULTIFD_FLAG_SYNC) {
>>> +                if (is_device_state) {
>>> +                    error_setg(&local_err, "multifd: received SYNC device state packet");
>>> +                    break;
>>> +                }
>> 
>> assert(!is_device_state) enough?
>
> It's not bug in the receiver code but rather an issue with the
> remote QEMU sending us wrong data if we get a SYNC device state
> packet.
>
> So I think returning an error is more appropriate than triggering
> an assert() failure for that.

ok

>>> +
>>>                   qemu_sem_post(&multifd_recv_state->sem_sync);
>>>                   qemu_sem_wait(&p->sem_sync);
>>>               }
>>> @@ -1258,6 +1346,7 @@ int multifd_recv_setup(Error **errp)
>>>               p->packet_len = sizeof(MultiFDPacket_t)
>>>                   + sizeof(uint64_t) * page_count;
>>>               p->packet = g_malloc0(p->packet_len);
>>> +            p->packet_dev_state = g_malloc0(sizeof(*p->packet_dev_state));
>>>           }
>>>           p->name = g_strdup_printf("mig/dst/recv_%d", i);
>>>           p->normal = g_new0(ram_addr_t, page_count);
>>> diff --git a/migration/multifd.h b/migration/multifd.h
>>> index a3e35196d179..a8f3e4838c01 100644
>>> --- a/migration/multifd.h
>>> +++ b/migration/multifd.h
>>> @@ -45,6 +45,12 @@ MultiFDRecvData *multifd_get_recv_data(void);
>>>   #define MULTIFD_FLAG_QPL (4 << 1)
>>>   #define MULTIFD_FLAG_UADK (8 << 1)
>>>   
>>> +/*
>>> + * If set it means that this packet contains device state
>>> + * (MultiFDPacketDeviceState_t), not RAM data (MultiFDPacket_t).
>>> + */
>>> +#define MULTIFD_FLAG_DEVICE_STATE (1 << 4)
>> 
>> Overlaps with UADK. I assume on purpose because device_state doesn't
>> support compression? Might be worth a comment.
>> 
>
> Yes, the device state transfer bit stream does not support compression
> so it is not a problem since these "compression type" flags will never
> be set in such bit stream anyway.
>
> Will add a relevant comment here.
>
> Thanks,
> Maciej

