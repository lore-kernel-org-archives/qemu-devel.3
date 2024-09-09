Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF143ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 15:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snftB-0002QB-5m; Mon, 09 Sep 2024 11:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1snftA-0002MY-4e
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:01:12 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1snft8-0007wS-EC
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:01:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D01F1F7C4;
 Mon,  9 Sep 2024 15:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725894065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJHXYhTTKkd1YrOR3Rivyx+fjr+ep6jv9VIVL4ZxNo8=;
 b=Zv2P/UNQalLCciEC0eCsxq6tKVZt/aoXGOQQeWQtTUvBcsWjRCaGXGAq5F3ZyqIoE+gx++
 225E4CVKdZtHYywD0u7oX6M8Ndb7t/5wjTy97DqZabqgp/cYPTzBzuqYTvD33wQKtGr94T
 ZcDKbBZSWkr72P8Z9ZI6Bl0e8h0OCCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725894065;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJHXYhTTKkd1YrOR3Rivyx+fjr+ep6jv9VIVL4ZxNo8=;
 b=yAr//1LtqTVax+xWaQV9QSUmMXXe55pO/k3YUeATkPxn3FD92VGIdNdaopiBpzGFoIhDBJ
 Ipeh3hYyfdcJNbBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NN+CuCPq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5okRIek5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725894064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJHXYhTTKkd1YrOR3Rivyx+fjr+ep6jv9VIVL4ZxNo8=;
 b=NN+CuCPqtgzFM1Rx5ueakhZuNdYkY+empX5dAvU/VaiYtOFvqeV5W1pMctK5y/8ZDmN0uB
 2rOnys3cHj+/BA3TFfLVCiA2Kxz8P6KX7k8biO6RNJFR4WvG+MTYB7qIt5ZestkEYNCCp7
 k+CNAaeGmQjpwJpA1RhFLsCkYeTGi+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725894064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJHXYhTTKkd1YrOR3Rivyx+fjr+ep6jv9VIVL4ZxNo8=;
 b=5okRIek54h+VGWR6wU3GGIBQjHrxfbByz+WvKax463YZ6tD3K8+CWtCBG8thvwqSLOy0TN
 xl6xl8FeYTweoeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27A2713A3A;
 Mon,  9 Sep 2024 15:01:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id krh4N68N32Z4DgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Sep 2024 15:01:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PULL 27/34] migration/multifd: Move nocomp code into
 multifd-nocomp.c
In-Reply-To: <CAFEAcA_F2qrSAacY=V5Hez1qFGuNW0-XqL2LQ=Y_UKYuHEJWhw@mail.gmail.com>
References: <20240904124417.14565-1-farosas@suse.de>
 <20240904124417.14565-28-farosas@suse.de>
 <CAFEAcA_F2qrSAacY=V5Hez1qFGuNW0-XqL2LQ=Y_UKYuHEJWhw@mail.gmail.com>
Date: Mon, 09 Sep 2024 12:01:01 -0300
Message-ID: <87ikv4lvma.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 9D01F1F7C4
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linaro.org:email,suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 4 Sept 2024 at 13:48, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> In preparation for adding new payload types to multifd, move most of
>> the no-compression code into multifd-nocomp.c. Let's try to keep a
>> semblance of layering by not mixing general multifd control flow with
>> the details of transmitting pages of ram.
>>
>> There are still some pieces leftover, namely the p->normal, p->zero,
>> etc variables that we use for zero page tracking and the packet
>> allocation which is heavily dependent on the ram code.
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> I know Coverity has only flagged this up because the
> code has moved, but it seems like a good place to ask
> the question:
>
>> +void multifd_ram_fill_packet(MultiFDSendParams *p)
>> +{
>> +    MultiFDPacket_t *packet = p->packet;
>> +    MultiFDPages_t *pages = &p->data->u.ram;
>> +    uint32_t zero_num = pages->num - pages->normal_num;
>> +
>> +    packet->pages_alloc = cpu_to_be32(multifd_ram_page_count());
>> +    packet->normal_pages = cpu_to_be32(pages->normal_num);
>> +    packet->zero_pages = cpu_to_be32(zero_num);
>> +
>> +    if (pages->block) {
>> +        strncpy(packet->ramblock, pages->block->idstr, 256);
>
> Coverity points out that when we fill in the RAMBlock::idstr
> here, if packet->ramblock is not NUL terminated then we won't
> NUL-terminate idstr either (CID 1560071).
>
> Is this really what is intended?

This is probably an oversight, although the migration destination
truncates it before reading:

    /* make sure that ramblock is 0 terminated */
    packet->ramblock[255] = 0;
    p->block = qemu_ram_block_by_name(packet->ramblock);

If we ever start reading packet->ramblock on the source side in the
future, then there might be a problem.

>
> Perhaps
>          pstrncpy(packet->ramblock, sizeof(packet->ramblock),
>                   pages->block->idstr);
>
> would be better?

Yep, thanks. I'll send a patch.

>
> (pstrncpy will always NUL-terminate, and won't pointlessly
> zero-fill the space after the string in the destination.)
>
>> +    }
>> +
>> +    for (int i = 0; i < pages->num; i++) {
>> +        /* there are architectures where ram_addr_t is 32 bit */
>> +        uint64_t temp = pages->offset[i];
>> +
>> +        packet->offset[i] = cpu_to_be64(temp);
>> +    }
>> +
>> +    trace_multifd_send_ram_fill(p->id, pages->normal_num,
>> +                                zero_num);
>> +}
>
> thanks
> -- PMM

