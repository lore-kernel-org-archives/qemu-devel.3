Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BA1C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0WR-0000vF-JR; Mon, 22 Jul 2024 17:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sW0WH-0000Nd-4d
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:24:35 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sW0WE-0008RK-H4
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:24:32 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6404421A8A;
 Mon, 22 Jul 2024 21:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721683469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JicEtaI3u4S3r1yIXA6NgtBJPRK79QmzjuDe17NhSC8=;
 b=Gf6emSpQstW9YC8bsNudLUuRMRn0RBSs23g3LuoOzma6ILNBF/tKOYQy2Q1YrW5K9bBDYf
 7ZST50Pdzz6cX4r9XmL52rmVLIzZFcNehNzETwRqpXpbxeUVYo2DVTp1El4Gv9Vp2gvvBO
 OTcOvstBt8WW+dhSHE0/h0oWjAwSm40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721683469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JicEtaI3u4S3r1yIXA6NgtBJPRK79QmzjuDe17NhSC8=;
 b=fEsLHYhKE75wPREbl+rCsAfuY4HXIyLm3vyFOMXzYGZf7yNVZBu99EgRppUkA5Tfnt5BKh
 ZXf7ducvrlAbSoDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721683469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JicEtaI3u4S3r1yIXA6NgtBJPRK79QmzjuDe17NhSC8=;
 b=Gf6emSpQstW9YC8bsNudLUuRMRn0RBSs23g3LuoOzma6ILNBF/tKOYQy2Q1YrW5K9bBDYf
 7ZST50Pdzz6cX4r9XmL52rmVLIzZFcNehNzETwRqpXpbxeUVYo2DVTp1El4Gv9Vp2gvvBO
 OTcOvstBt8WW+dhSHE0/h0oWjAwSm40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721683469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JicEtaI3u4S3r1yIXA6NgtBJPRK79QmzjuDe17NhSC8=;
 b=fEsLHYhKE75wPREbl+rCsAfuY4HXIyLm3vyFOMXzYGZf7yNVZBu99EgRppUkA5Tfnt5BKh
 ZXf7ducvrlAbSoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFF51136A9;
 Mon, 22 Jul 2024 21:24:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SqVWKQzOnma8PAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jul 2024 21:24:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 8/9] migration/multifd: Don't send ram data
 during SYNC
In-Reply-To: <Zp7JBmVqMYw7rOT9@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-9-farosas@suse.de> <Zp7JBmVqMYw7rOT9@x1n>
Date: Mon, 22 Jul 2024 18:24:16 -0300
Message-ID: <877cddyvb3.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

> On Mon, Jul 22, 2024 at 02:59:13PM -0300, Fabiano Rosas wrote:
>> Skip saving and loading any ram data in the packet in the case of a
>> SYNC. This fixes a shortcoming of the current code which requires a
>> reset of the MultiFDPages_t fields right after the previous
>> pending_job finishes, otherwise the very next job might be a SYNC and
>> multifd_send_fill_packet() will put the stale values in the packet.
>> 
>> By not calling multifd_ram_fill_packet(), we can stop resetting
>> MultiFDPages_t in the multifd core and leave that to the client code.
>> 
>> Actually moving the reset function is not yet done because
>> pages->num==0 is used by the client code to determine whether the
>> MultiFDPages_t needs to be flushed. The subsequent patches will
>> replace that with a generic flag that is not dependent on
>> MultiFDPages_t.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/multifd.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>> 
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index d25b8658b2..4394ca6ade 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -438,6 +438,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>>  {
>>      MultiFDPacket_t *packet = p->packet;
>>      uint64_t packet_num;
>> +    bool sync_packet = p->flags & MULTIFD_FLAG_SYNC;
>>  
>>      memset(packet, 0, p->packet_len);
>>  
>> @@ -452,7 +453,9 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>>  
>>      p->packets_sent++;
>>  
>> -    multifd_ram_fill_packet(p);
>> +    if (!sync_packet) {
>> +        multifd_ram_fill_packet(p);
>> +    }
>>  
>>      trace_multifd_send(p->id, packet_num,
>>                         be32_to_cpu(packet->normal_pages),
>> @@ -563,7 +566,12 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>      p->packet_num = be64_to_cpu(packet->packet_num);
>>      p->packets_recved++;
>>  
>> -    ret = multifd_ram_unfill_packet(p, errp);
>> +    if (p->flags & MULTIFD_FLAG_SYNC) {
>> +        p->normal_num = 0;
>> +        p->zero_num = 0;
>
> Instead of this, I wonder whether we shouldn't touch those fields at all,
> but:
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 0a85951d58..55abd9a1ef 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1547,7 +1547,9 @@ static void *multifd_recv_thread(void *opaque)
>              flags = p->flags;
>              /* recv methods don't know how to handle the SYNC flag */
>              p->flags &= ~MULTIFD_FLAG_SYNC;
> -            has_data = p->normal_num || p->zero_num;
> +
> +            if (!(flags & MULTIFD_FLAG_SYNC))
> +                has_data = p->normal_num || p->zero_num;
>              qemu_mutex_unlock(&p->mutex);
>          } else {
>              /*

Good idea.

>
>> +    } else {
>> +        ret = multifd_ram_unfill_packet(p, errp);
>> +    }
>>  
>>      trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
>>                         p->flags, p->next_packet_size);
>> -- 
>> 2.35.3
>> 

