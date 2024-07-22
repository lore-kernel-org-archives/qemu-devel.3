Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D198C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 20:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVzmM-0001XL-MY; Mon, 22 Jul 2024 16:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVzmI-0001Vw-EA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:37:03 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVzmG-0007tr-Ma
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:37:02 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5AF8021ADF;
 Mon, 22 Jul 2024 20:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721680619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9cWNBljteCgY86QxJvtWl+o1/4yo02yaHpBUu+O5E98=;
 b=dMVnUGYjl4Lp/jB6xChha2pooOdCg/HA8o0SCSOKJnMb5ei0HdmzOvq04Ke/rViVIIlHDM
 eevQ0Ob1lnr2xN0vUa8elCKd8eNLeW0Q59ywgS1yRESxXncBgI5/6o0X1kTsUnBAgCf1mW
 k/6CY3/FqqOadMvMC9c0SoKGtgPfK44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721680619;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9cWNBljteCgY86QxJvtWl+o1/4yo02yaHpBUu+O5E98=;
 b=604VxvjhCJx+DDjCiDI73p+TOfV6+XyOlVZz5oi6oWFdZG0M961QL2a4F0ydSOuSTv0MFB
 HEJN1eaQcPeMJkDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dMVnUGYj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=604Vxvjh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721680619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9cWNBljteCgY86QxJvtWl+o1/4yo02yaHpBUu+O5E98=;
 b=dMVnUGYjl4Lp/jB6xChha2pooOdCg/HA8o0SCSOKJnMb5ei0HdmzOvq04Ke/rViVIIlHDM
 eevQ0Ob1lnr2xN0vUa8elCKd8eNLeW0Q59ywgS1yRESxXncBgI5/6o0X1kTsUnBAgCf1mW
 k/6CY3/FqqOadMvMC9c0SoKGtgPfK44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721680619;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9cWNBljteCgY86QxJvtWl+o1/4yo02yaHpBUu+O5E98=;
 b=604VxvjhCJx+DDjCiDI73p+TOfV6+XyOlVZz5oi6oWFdZG0M961QL2a4F0ydSOuSTv0MFB
 HEJN1eaQcPeMJkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D320C136A9;
 Mon, 22 Jul 2024 20:36:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3hZ0JerCnmbrMAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jul 2024 20:36:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 4/9] migration/multifd: Make
 MultiFDPages_t:offset a flexible array member
In-Reply-To: <Zp6xCcenvrQfqDOn@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-5-farosas@suse.de> <Zp6xCcenvrQfqDOn@x1n>
Date: Mon, 22 Jul 2024 17:36:56 -0300
Message-ID: <87ed7lyxhz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5AF8021ADF
X-Spamd-Result: default: False [-5.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

> On Mon, Jul 22, 2024 at 02:59:09PM -0300, Fabiano Rosas wrote:
>> We're about to use MultiFDPages_t from inside the MultiFDSendData
>> payload union, which means we cannot have pointers to allocated data
>> inside the pages structure, otherwise we'd lose the reference to that
>> memory once another payload type touches the union. Move the offset
>> array into the end of the structure and turn it into a flexible array
>> member, so it is allocated along with the rest of MultiFDSendData in
>> the next patches.
>> 
>> Note that the ramblock pointer is still fine because the storage for
>> it is not owned by the migration code.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/multifd.c | 21 ++++++---------------
>>  migration/multifd.h |  4 ++--
>>  2 files changed, 8 insertions(+), 17 deletions(-)
>> 
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index 20a767157e..440319b361 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -389,22 +389,10 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
>>      return msg.id;
>>  }
>>  
>> -static MultiFDPages_t *multifd_pages_init(uint32_t n)
>> -{
>> -    MultiFDPages_t *pages = g_new0(MultiFDPages_t, 1);
>> -
>> -    pages->allocated = n;
>> -    pages->offset = g_new0(ram_addr_t, n);
>> -
>> -    return pages;
>> -}
>
> Considering this is the tricky object to allocate here, shall we keep the
> function just for readability (and already dedups below two callers)?  With
> it, someone else will notice g_new0() stops working for MultiFDPages_t.
> Some verbose comment would be nice too.
>
> Maybe we can also move multifd_ram_payload_size() from the next patch to
> here.

I guess so, I was trying to keep this diff small so it's easier to
grasp.

>
>> -
>>  static void multifd_pages_clear(MultiFDPages_t *pages)
>>  {
>>      multifd_pages_reset(pages);
>>      pages->allocated = 0;
>> -    g_free(pages->offset);
>> -    pages->offset = NULL;
>>      g_free(pages);
>>  }
>>  
>> @@ -1169,7 +1157,9 @@ bool multifd_send_setup(void)
>>      thread_count = migrate_multifd_channels();
>>      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>>      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
>> -    multifd_send_state->pages = multifd_pages_init(page_count);
>> +    multifd_send_state->pages = g_malloc0(sizeof(MultiFDPages_t) +
>> +                                          page_count * sizeof(ram_addr_t));
>> +    multifd_send_state->pages->allocated = page_count;
>>      qemu_sem_init(&multifd_send_state->channels_created, 0);
>>      qemu_sem_init(&multifd_send_state->channels_ready, 0);
>>      qatomic_set(&multifd_send_state->exiting, 0);
>> @@ -1181,8 +1171,9 @@ bool multifd_send_setup(void)
>>          qemu_sem_init(&p->sem, 0);
>>          qemu_sem_init(&p->sem_sync, 0);
>>          p->id = i;
>> -        p->pages = multifd_pages_init(page_count);
>> -
>> +        p->pages = g_malloc0(sizeof(MultiFDPages_t) +
>> +                             page_count * sizeof(ram_addr_t));
>> +        p->pages->allocated = page_count;
>>          if (use_packets) {
>>              p->packet_len = sizeof(MultiFDPacket_t)
>>                            + sizeof(uint64_t) * page_count;
>> diff --git a/migration/multifd.h b/migration/multifd.h
>> index c7b1ebe099..12d4247e23 100644
>> --- a/migration/multifd.h
>> +++ b/migration/multifd.h
>> @@ -78,9 +78,9 @@ typedef struct {
>>      uint32_t normal_num;
>>      /* number of allocated pages */
>>      uint32_t allocated;
>> +    RAMBlock *block;
>>      /* offset of each page */
>> -    ram_addr_t *offset;
>> -    RAMBlock *block;
>> +    ram_addr_t offset[];
>>  } MultiFDPages_t;
>>  
>>  struct MultiFDRecvData {
>> -- 
>> 2.35.3
>> 

