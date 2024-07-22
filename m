Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7ADC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 20:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVzkH-0004rr-6A; Mon, 22 Jul 2024 16:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVzkF-0004q3-8N
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:34:55 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVzk9-00074q-SJ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:34:52 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 943451FE00;
 Mon, 22 Jul 2024 20:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721680487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VsLFzNMxureS2lK4Mm4CaQ6IKIAsFXu4e7BFexAlVyY=;
 b=XnyXhOKquYpYoJgMDyTTGYnRDs2h3j6YtZe9+G38zDX71YMOZbTe3b2hhIdPF7q6KshuWr
 +O8FGq0Ues6EmFyvQedQWpBXZlBnDrj5epqweh5DBsPW0D7YTlHf5Jo10MIWRZpP6D9q49
 37PuHDK8sTGNHuzv+DWmXUY0m20vdsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721680488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VsLFzNMxureS2lK4Mm4CaQ6IKIAsFXu4e7BFexAlVyY=;
 b=tL/lage1B7mHFNUbT4H0/yDUWJoq4e3ktIot8BY99nZRhU0YyM8uRo+0xtelhTgIVeLqnx
 5AIkMkOPc6EZHtCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721680487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VsLFzNMxureS2lK4Mm4CaQ6IKIAsFXu4e7BFexAlVyY=;
 b=XnyXhOKquYpYoJgMDyTTGYnRDs2h3j6YtZe9+G38zDX71YMOZbTe3b2hhIdPF7q6KshuWr
 +O8FGq0Ues6EmFyvQedQWpBXZlBnDrj5epqweh5DBsPW0D7YTlHf5Jo10MIWRZpP6D9q49
 37PuHDK8sTGNHuzv+DWmXUY0m20vdsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721680487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VsLFzNMxureS2lK4Mm4CaQ6IKIAsFXu4e7BFexAlVyY=;
 b=8x1OLuBYdJc3ubTdLn63VFF48L/s4WUUw2oFljILqoTUvMzOW1Lj9TFS8yEPatnA4AEt8B
 bYNu3mkEe97ZkwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F1F1136A9;
 Mon, 22 Jul 2024 20:34:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tPFJNGbCnmZNMAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jul 2024 20:34:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 7/9] migration/multifd: Isolate ram pages packet
 data
In-Reply-To: <Zp6089I1ozCg1Eaq@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-8-farosas@suse.de> <Zp6089I1ozCg1Eaq@x1n>
Date: Mon, 22 Jul 2024 17:34:44 -0300
Message-ID: <87h6chyxln.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.10 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Mon, Jul 22, 2024 at 02:59:12PM -0300, Fabiano Rosas wrote:
>> While we cannot yet disentangle the multifd packet from page data, we
>> can make the code a bit cleaner by setting the page-related fields in
>> a separate function.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/multifd.c | 97 ++++++++++++++++++++++++++++-----------------
>>  1 file changed, 61 insertions(+), 36 deletions(-)
>> 
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index fcdb12e04f..d25b8658b2 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -409,65 +409,62 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
>>      return msg.id;
>>  }
>>  
>> -void multifd_send_fill_packet(MultiFDSendParams *p)
>> +static void multifd_ram_fill_packet(MultiFDSendParams *p)
>>  {
>>      MultiFDPacket_t *packet = p->packet;
>>      MultiFDPages_t *pages = &p->data->u.ram;
>> -    uint64_t packet_num;
>>      uint32_t zero_num = pages->num - pages->normal_num;
>> -    int i;
>>  
>> -    packet->flags = cpu_to_be32(p->flags);
>>      packet->pages_alloc = cpu_to_be32(pages->allocated);
>>      packet->normal_pages = cpu_to_be32(pages->normal_num);
>>      packet->zero_pages = cpu_to_be32(zero_num);
>> -    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
>
> Definitely good intention, but I had a feeling that this will need to be
> reorganized again when Maciej reworks on top, due to the fact that
> next_packet_size will be ram-private field, simply because it's defined
> after pages_alloc and normal_pages...
>
> E.g., see:
>
> https://lore.kernel.org/r/41dedaf2c9abebb5e45f88c052daa26320715a92.1718717584.git.maciej.szmigiero@oracle.com
>
> Where the new MultiFDPacketHdr_t cannot include next_packet_size (even if
> VFIO will need that too..).

Isn't it just a matter of setting next_packet_size in the other path as
well?

@Maciej, can you comment?

>
> typedef struct {
>     uint32_t magic;
>     uint32_t version;
>     uint32_t flags;
> } __attribute__((packed)) MultiFDPacketHdr_t;
>
> So _maybe_ it's easier we drop this patch and leave that part to Maciej to
> identify which is common and which is arm/vfio specific.  No strong
> opinions here.
>

I could drop it if that's preferrable. However, patch 8/9 is absolutely
necessary so we can remove this madness of having to clear
MultiFDPages_t fields at the multifd_send_thread() top level. It took me
a whole day to figure that one out and that bug has been manifesting
ever since I started working on multifd.

I'm not sure how we'll do that without this patch. Maybe it's better I
fix in this one whatever you guys think needs fixing.

>> -
>> -    packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
>> -    packet->packet_num = cpu_to_be64(packet_num);
>>  
>>      if (pages->block) {
>>          strncpy(packet->ramblock, pages->block->idstr, 256);
>>      }
>>  
>> -    for (i = 0; i < pages->num; i++) {
>> +    for (int i = 0; i < pages->num; i++) {
>>          /* there are architectures where ram_addr_t is 32 bit */
>>          uint64_t temp = pages->offset[i];
>>  
>>          packet->offset[i] = cpu_to_be64(temp);
>>      }
>>  
>> -    p->packets_sent++;
>>      p->total_normal_pages += pages->normal_num;
>>      p->total_zero_pages += zero_num;
>> +}
>>  
>> -    trace_multifd_send(p->id, packet_num, pages->normal_num, zero_num,
>> +void multifd_send_fill_packet(MultiFDSendParams *p)
>> +{
>> +    MultiFDPacket_t *packet = p->packet;
>> +    uint64_t packet_num;
>> +
>> +    memset(packet, 0, p->packet_len);
>> +
>> +    packet->magic = cpu_to_be32(MULTIFD_MAGIC);
>> +    packet->version = cpu_to_be32(MULTIFD_VERSION);
>> +
>> +    packet->flags = cpu_to_be32(p->flags);
>> +    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
>> +
>> +    packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
>> +    packet->packet_num = cpu_to_be64(packet_num);
>> +
>> +    p->packets_sent++;
>> +
>> +    multifd_ram_fill_packet(p);
>> +
>> +    trace_multifd_send(p->id, packet_num,
>> +                       be32_to_cpu(packet->normal_pages),
>> +                       be32_to_cpu(packet->zero_pages),
>>                         p->flags, p->next_packet_size);
>>  }
>>  
>> -static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>> +static int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>  {
>>      MultiFDPacket_t *packet = p->packet;
>>      int i;
>>  
>> -    packet->magic = be32_to_cpu(packet->magic);
>> -    if (packet->magic != MULTIFD_MAGIC) {
>> -        error_setg(errp, "multifd: received packet "
>> -                   "magic %x and expected magic %x",
>> -                   packet->magic, MULTIFD_MAGIC);
>> -        return -1;
>> -    }
>> -
>> -    packet->version = be32_to_cpu(packet->version);
>> -    if (packet->version != MULTIFD_VERSION) {
>> -        error_setg(errp, "multifd: received packet "
>> -                   "version %u and expected version %u",
>> -                   packet->version, MULTIFD_VERSION);
>> -        return -1;
>> -    }
>> -
>> -    p->flags = be32_to_cpu(packet->flags);
>> -
>>      packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
>>      /*
>>       * If we received a packet that is 100 times bigger than expected
>> @@ -496,15 +493,9 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>          return -1;
>>      }
>>  
>> -    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
>> -    p->packet_num = be64_to_cpu(packet->packet_num);
>> -    p->packets_recved++;
>>      p->total_normal_pages += p->normal_num;
>>      p->total_zero_pages += p->zero_num;
>>  
>> -    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
>> -                       p->flags, p->next_packet_size);
>> -
>>      if (p->normal_num == 0 && p->zero_num == 0) {
>>          return 0;
>>      }
>> @@ -546,6 +537,40 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>      return 0;
>>  }
>>  
>> +static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>> +{
>> +    MultiFDPacket_t *packet = p->packet;
>> +    int ret = 0;
>> +
>> +    packet->magic = be32_to_cpu(packet->magic);
>> +    if (packet->magic != MULTIFD_MAGIC) {
>> +        error_setg(errp, "multifd: received packet "
>> +                   "magic %x and expected magic %x",
>> +                   packet->magic, MULTIFD_MAGIC);
>> +        return -1;
>> +    }
>> +
>> +    packet->version = be32_to_cpu(packet->version);
>> +    if (packet->version != MULTIFD_VERSION) {
>> +        error_setg(errp, "multifd: received packet "
>> +                   "version %u and expected version %u",
>> +                   packet->version, MULTIFD_VERSION);
>> +        return -1;
>> +    }
>> +
>> +    p->flags = be32_to_cpu(packet->flags);
>> +    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
>> +    p->packet_num = be64_to_cpu(packet->packet_num);
>> +    p->packets_recved++;
>> +
>> +    ret = multifd_ram_unfill_packet(p, errp);
>> +
>> +    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
>> +                       p->flags, p->next_packet_size);
>> +
>> +    return ret;
>> +}
>> +
>>  static bool multifd_send_should_exit(void)
>>  {
>>      return qatomic_read(&multifd_send_state->exiting);
>> -- 
>> 2.35.3
>> 

