Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650A7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 17:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shBTw-0007yY-45; Thu, 22 Aug 2024 13:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shBTn-0007xx-Ge
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:20:11 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shBTk-0007ep-T7
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:20:10 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 156E52246A;
 Thu, 22 Aug 2024 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724347206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dQXm1YQOgyv0ukmt3znAIr40rK8eJAnz9sCtW9dbgPc=;
 b=JDTR8D3ZfFV54QkQ3pfY03VrFn3XT0sG8Z9Z1l7Pyz6EHOxrqWgxxuUT0qTlrf4OIpLV87
 uGWME0XtqUFxwRiCUFWLTp5HuCQHgmhV/F8p+SXp9ewxWi03fwgYJFnpoLFnLROByDOo5f
 blgTXa/DnzXyNOpU4bXp1t7iJ4k4M+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724347206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dQXm1YQOgyv0ukmt3znAIr40rK8eJAnz9sCtW9dbgPc=;
 b=RPk2uUobYqZ6b7CQb3gcq+EOmjXaz7fwEl0/OUkp3Gb6QR5/eV4BpCAfhOjD411G/tExQ8
 DPh2neykq5k0rrAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JDTR8D3Z;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RPk2uUob
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724347206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dQXm1YQOgyv0ukmt3znAIr40rK8eJAnz9sCtW9dbgPc=;
 b=JDTR8D3ZfFV54QkQ3pfY03VrFn3XT0sG8Z9Z1l7Pyz6EHOxrqWgxxuUT0qTlrf4OIpLV87
 uGWME0XtqUFxwRiCUFWLTp5HuCQHgmhV/F8p+SXp9ewxWi03fwgYJFnpoLFnLROByDOo5f
 blgTXa/DnzXyNOpU4bXp1t7iJ4k4M+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724347206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dQXm1YQOgyv0ukmt3znAIr40rK8eJAnz9sCtW9dbgPc=;
 b=RPk2uUobYqZ6b7CQb3gcq+EOmjXaz7fwEl0/OUkp3Gb6QR5/eV4BpCAfhOjD411G/tExQ8
 DPh2neykq5k0rrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9517713297;
 Thu, 22 Aug 2024 17:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IKwKF0Vzx2aEFgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Aug 2024 17:20:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 13/14] migration/multifd: Register nocomp ops
 dynamically
In-Reply-To: <Zsdl_ADh-VTKV-wT@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-14-farosas@suse.de> <Zsdl_ADh-VTKV-wT@x1n>
Date: Thu, 22 Aug 2024 14:20:03 -0300
Message-ID: <87r0agxynw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 156E52246A
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Thu, Aug 01, 2024 at 09:35:15AM -0300, Fabiano Rosas wrote:
>> Prior to moving the ram code into multifd-ram.c, change the code to
>> register the nocomp ops dynamically so we don't need to have the ops
>> structure defined in multifd.c.
>> 
>> While here, rename s/nocomp/ram/ and remove the docstrings which are
>> mostly useless (if anything, it's the function pointers in multifd.h
>> that should be documented like that).
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/multifd.c | 101 ++++++++++++--------------------------------
>>  1 file changed, 28 insertions(+), 73 deletions(-)
>> 
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index c25ab4924c..d5be784b6f 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -167,15 +167,7 @@ static void multifd_set_file_bitmap(MultiFDSendParams *p)
>>      }
>>  }
>>  
>> -/* Multifd without compression */
>> -
>> -/**
>> - * nocomp_send_setup: setup send side
>> - *
>> - * @p: Params for the channel that we are using
>> - * @errp: pointer to an error
>> - */
>> -static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
>> +static int ram_send_setup(MultiFDSendParams *p, Error **errp)
>
> "ram" as a prefix sounds inaccurate to me.  Personally I even preferred the
> old name "nocomp" because it says there's no compression.
>
> Here "ram_send_setup" is at the same level against e.g. "zlib_send_setup".
> It sounds like zlib isn't for ram, but it is..
>
> Do you perhaps dislike the "nocomp" term?  How about:

I don't mind. I almost left nocomp intact, but thought it would be
better to match the new file name (multifd-ram.c).

>
>   multifd_plain_send_setup()
>
> Just to do s/nocomp/plain/?  Or "raw"?
>
> We do have two flavours here at least:
>
> *** migration/multifd-qpl.c:
> <global>[755]                  .send_setup = multifd_qpl_send_setup,
>
> *** migration/multifd-ram.c:
> <global>[387]                  .send_setup = ram_send_setup,
>
> *** migration/multifd-uadk.c:
> <global>[364]                  .send_setup = multifd_uadk_send_setup,
>
> *** migration/multifd-zlib.c:
> <global>[338]                  .send_setup = zlib_send_setup,
>
> *** migration/multifd-zstd.c:
> <global>[326]                  .send_setup = zstd_send_setup,
>
> It might makes sense to all prefix them with "multifd_", just to follow
> gpl/uadk?

Yep.

>
>>  {
>>      uint32_t page_count = multifd_ram_page_count();
>>  
>> @@ -193,15 +185,7 @@ static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
>>      return 0;
>>  }
>>  
>> -/**
>> - * nocomp_send_cleanup: cleanup send side
>> - *
>> - * For no compression this function does nothing.
>> - *
>> - * @p: Params for the channel that we are using
>> - * @errp: pointer to an error
>> - */
>> -static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
>> +static void ram_send_cleanup(MultiFDSendParams *p, Error **errp)
>>  {
>>      g_free(p->iov);
>>      p->iov = NULL;
>> @@ -222,18 +206,7 @@ static void multifd_send_prepare_iovs(MultiFDSendParams *p)
>>      p->next_packet_size = pages->normal_num * page_size;
>>  }
>>  
>> -/**
>> - * nocomp_send_prepare: prepare date to be able to send
>> - *
>> - * For no compression we just have to calculate the size of the
>> - * packet.
>> - *
>> - * Returns 0 for success or -1 for error
>> - *
>> - * @p: Params for the channel that we are using
>> - * @errp: pointer to an error
>> - */
>> -static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
>> +static int ram_send_prepare(MultiFDSendParams *p, Error **errp)
>>  {
>>      bool use_zero_copy_send = migrate_zero_copy_send();
>>      int ret;
>> @@ -272,46 +245,19 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
>>      return 0;
>>  }
>>  
>> -/**
>> - * nocomp_recv_setup: setup receive side
>> - *
>> - * For no compression this function does nothing.
>> - *
>> - * Returns 0 for success or -1 for error
>> - *
>> - * @p: Params for the channel that we are using
>> - * @errp: pointer to an error
>> - */
>> -static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
>> +static int ram_recv_setup(MultiFDRecvParams *p, Error **errp)
>>  {
>>      p->iov = g_new0(struct iovec, multifd_ram_page_count());
>>      return 0;
>>  }
>>  
>> -/**
>> - * nocomp_recv_cleanup: setup receive side
>> - *
>> - * For no compression this function does nothing.
>> - *
>> - * @p: Params for the channel that we are using
>> - */
>> -static void nocomp_recv_cleanup(MultiFDRecvParams *p)
>> +static void ram_recv_cleanup(MultiFDRecvParams *p)
>>  {
>>      g_free(p->iov);
>>      p->iov = NULL;
>>  }
>>  
>> -/**
>> - * nocomp_recv: read the data from the channel
>> - *
>> - * For no compression we just need to read things into the correct place.
>> - *
>> - * Returns 0 for success or -1 for error
>> - *
>> - * @p: Params for the channel that we are using
>> - * @errp: pointer to an error
>> - */
>> -static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
>> +static int ram_recv(MultiFDRecvParams *p, Error **errp)
>>  {
>>      uint32_t flags;
>>  
>> @@ -341,22 +287,15 @@ static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
>>      return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
>>  }
>>  
>> -static MultiFDMethods multifd_nocomp_ops = {
>> -    .send_setup = nocomp_send_setup,
>> -    .send_cleanup = nocomp_send_cleanup,
>> -    .send_prepare = nocomp_send_prepare,
>> -    .recv_setup = nocomp_recv_setup,
>> -    .recv_cleanup = nocomp_recv_cleanup,
>> -    .recv = nocomp_recv
>> -};
>> -
>> -static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {
>> -    [MULTIFD_COMPRESSION_NONE] = &multifd_nocomp_ops,
>> -};
>> +static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {};
>>  
>>  void multifd_register_ops(int method, MultiFDMethods *ops)
>>  {
>> -    assert(0 < method && method < MULTIFD_COMPRESSION__MAX);
>> +    if (method == MULTIFD_COMPRESSION_NONE) {
>> +        assert(!multifd_ops[method]);
>> +    } else {
>> +        assert(0 < method && method < MULTIFD_COMPRESSION__MAX);
>> +    }
>>      multifd_ops[method] = ops;
>>  }
>
> The new assertion is a bit paranoid to me.. while checking duplicated
> assignment should at least apply to all if to add.  So.. how about:
>
>   assert(method < MULTIFD_COMPRESSION__MAX);
>   assert(!multifd_ops[method]);
>   multifd_ops[method] = ops;
>
> ?

ok

>
>>  
>> @@ -1755,3 +1694,19 @@ bool multifd_send_prepare_common(MultiFDSendParams *p)
>>  
>>      return true;
>>  }
>> +
>> +static MultiFDMethods multifd_ram_ops = {
>> +    .send_setup = ram_send_setup,
>> +    .send_cleanup = ram_send_cleanup,
>> +    .send_prepare = ram_send_prepare,
>> +    .recv_setup = ram_recv_setup,
>> +    .recv_cleanup = ram_recv_cleanup,
>> +    .recv = ram_recv
>> +};
>> +
>> +static void multifd_ram_register(void)
>> +{
>> +    multifd_register_ops(MULTIFD_COMPRESSION_NONE, &multifd_ram_ops);
>> +}
>> +
>> +migration_init(multifd_ram_register);
>> -- 
>> 2.35.3
>> 

