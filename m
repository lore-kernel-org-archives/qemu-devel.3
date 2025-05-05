Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B63C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 21:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC3jM-000643-9U; Mon, 05 May 2025 17:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uC3jL-00063r-0m
 for qemu-devel@nongnu.org; Mon, 05 May 2025 17:52:07 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uC3jJ-0001Ya-01
 for qemu-devel@nongnu.org; Mon, 05 May 2025 17:52:06 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E1101F387;
 Mon,  5 May 2025 21:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746481922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0OXFqyS56wcZYqGFOsYAH45KX2G69kp5oak3JkI6DIc=;
 b=pji6YwXORaNkYyvDE6H5Vpu6tujLSz/G0ZpDph/GiNjcfyTqFuZhrSeqoy6c73gTCFdPVs
 EdkrUnZCB1DR4GJc7TrzJvUHnzXxKMzzLOuiXUd6+HggC5YOXJs/yrvZWkO/qByDCB3hVK
 BuUMrh7IJNwSHUrLCSzEXGaV/1eJNd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746481922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0OXFqyS56wcZYqGFOsYAH45KX2G69kp5oak3JkI6DIc=;
 b=6pTyXYGDrdZnE460XD2NXCylu1J0dwTFT3zDzLsnY4AqZJ+sBloffMxs+9Xhnqlg/JveTq
 CZuzluOprQo87CBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pji6YwXO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6pTyXYGD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746481922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0OXFqyS56wcZYqGFOsYAH45KX2G69kp5oak3JkI6DIc=;
 b=pji6YwXORaNkYyvDE6H5Vpu6tujLSz/G0ZpDph/GiNjcfyTqFuZhrSeqoy6c73gTCFdPVs
 EdkrUnZCB1DR4GJc7TrzJvUHnzXxKMzzLOuiXUd6+HggC5YOXJs/yrvZWkO/qByDCB3hVK
 BuUMrh7IJNwSHUrLCSzEXGaV/1eJNd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746481922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0OXFqyS56wcZYqGFOsYAH45KX2G69kp5oak3JkI6DIc=;
 b=6pTyXYGDrdZnE460XD2NXCylu1J0dwTFT3zDzLsnY4AqZJ+sBloffMxs+9Xhnqlg/JveTq
 CZuzluOprQo87CBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9142013883;
 Mon,  5 May 2025 21:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hBvmFAEzGWiuQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 May 2025 21:52:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] migration/multifd: Fix received packets tracepoint
In-Reply-To: <aBknIwPX0IXdcAkL@x1.local>
References: <20250416134356.29879-1-farosas@suse.de>
 <20250416134356.29879-2-farosas@suse.de> <aBknIwPX0IXdcAkL@x1.local>
Date: Mon, 05 May 2025 18:51:58 -0300
Message-ID: <87selig1z5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 1E1101F387
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Apr 16, 2025 at 10:43:55AM -0300, Fabiano Rosas wrote:
>> When qatomic_fetch_inc() started being used to count the number of
>> packets sent, the printing of the number of packets received stopped
>> matching the number of packets sent.
>> 
>> Fix by moving the increment of the number of packets on the recv side
>> to multifd_recv_unfill_packet().
>> 
>> Also change the tracepoint text because "packet num" is ambiguous for
>> the sync since the packet number of the actual sync packet will be one
>> less than the total number of packets seen so far.
>
> Would this be a hint that the recv side may not really need a global
> packet_num counter, at all?
>
> On source, it needs to be there if we want to have an unified unique ID for
> each multifd packet, so that when allcating a packet we need them to be
> assigned properly.
>
> On dest, it almost only receives packets, it's still unclear to me how the
> recv packet_num global var could help us considering we have the per-packet
> trace in trace_multifd_recv_unfill() dumping the unique ID for each..
>
> So.. would it be of any use?  Would it be better if we remove it instead?
>

It's good for debugging. The p->packet_num on the recv side will at some
point contain the total number of packets sent, but it's hard to answer
how many packets have arrived at any given moment just by looking at
trace_multifd_recv_unfill(). Packets could arrive out of order.

I'm inclined to say that p->packet_num is the one that's useless. After
this patch, it's only there to hold an endianness swap. We can reach the
BE value via p->packet->packet_num already.

>> 
>> Fixes: 98ea497d8b ("migration/multifd: Fix MultiFDSendParams.packet_num race")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/multifd.c    | 6 +-----
>>  migration/trace-events | 4 ++--
>>  2 files changed, 3 insertions(+), 7 deletions(-)
>> 
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index dfb5189f0e..1a16155864 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -310,6 +310,7 @@ static int multifd_recv_unfill_packet_ram(MultiFDRecvParams *p, Error **errp)
>>  
>>  static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>  {
>> +    qatomic_inc(&multifd_recv_state->packet_num);
>>      p->packets_recved++;
>>  
>>      if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
>> @@ -1222,11 +1223,6 @@ void multifd_recv_sync_main(void)
>>      for (i = 0; i < thread_count; i++) {
>>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>>  
>> -        WITH_QEMU_LOCK_GUARD(&p->mutex) {
>> -            if (multifd_recv_state->packet_num < p->packet_num) {
>> -                multifd_recv_state->packet_num = p->packet_num;
>> -            }
>> -        }
>>          trace_multifd_recv_sync_main_signal(p->id);
>>          qemu_sem_post(&p->sem_sync);
>>      }
>> diff --git a/migration/trace-events b/migration/trace-events
>> index c506e11a2e..48acb126f5 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -133,7 +133,7 @@ multifd_new_send_channel_async(uint8_t id) "channel %u"
>>  multifd_new_send_channel_async_error(uint8_t id, void *err) "channel=%u err=%p"
>>  multifd_recv_unfill(uint8_t id, uint64_t packet_num, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " flags 0x%x next packet size %u"
>>  multifd_recv_new_channel(uint8_t id) "channel %u"
>> -multifd_recv_sync_main(long packet_num) "packet num %ld"
>> +multifd_recv_sync_main(long packet_num) "packets before sync %ld"
>>  multifd_recv_sync_main_signal(uint8_t id) "channel %u"
>>  multifd_recv_sync_main_wait(uint8_t id) "iter %u"
>>  multifd_recv_terminate_threads(bool error) "error %d"
>> @@ -142,7 +142,7 @@ multifd_recv_thread_start(uint8_t id) "%u"
>>  multifd_send_fill(uint8_t id, uint64_t packet_num, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " flags 0x%x next packet size %u"
>>  multifd_send_ram_fill(uint8_t id, uint32_t normal, uint32_t zero) "channel %u normal pages %u zero pages %u"
>>  multifd_send_error(uint8_t id) "channel %u"
>> -multifd_send_sync_main(long packet_num) "packet num %ld"
>> +multifd_send_sync_main(long packet_num) "packets before sync %ld"
>>  multifd_send_sync_main_signal(uint8_t id) "channel %u"
>>  multifd_send_sync_main_wait(uint8_t id) "channel %u"
>>  multifd_send_terminate_threads(void) ""
>> -- 
>> 2.35.3
>> 

