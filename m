Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5BCC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 20:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehzP-00033B-6n; Mon, 26 Feb 2024 15:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rehzN-000333-RO
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:54:17 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rehzM-0005No-3E
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:54:17 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 001951FB69;
 Mon, 26 Feb 2024 20:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708980854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MIKChZRfLfdftf53J8SO5i5uLGrZ1/K/GlMGgTGNg1g=;
 b=iQrCRPTzbuf5D/+Ldm1VeaS+PY5dgX3sZ4TwaHrYsl4IqzOroK8mdfBSP/rEl2wUGhd8L7
 7d0TdG9S7qQw+3FnYKcouk5J+71Nc37ShGqDo3O88uMbB0x+FiKd9Gt4p3JRDonpSNAfev
 5dMW7XyPyo5wP/GoDStW4G3h0Rzz0BM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708980854;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MIKChZRfLfdftf53J8SO5i5uLGrZ1/K/GlMGgTGNg1g=;
 b=wRohaj7y298wRKXSBn36HvPIqRd6fuc1+Rwarioo6Rc/aW9gzvYAjUWmF7cI0ohbjYkk4o
 UpFPFr8YgiKc8MDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708980854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MIKChZRfLfdftf53J8SO5i5uLGrZ1/K/GlMGgTGNg1g=;
 b=iQrCRPTzbuf5D/+Ldm1VeaS+PY5dgX3sZ4TwaHrYsl4IqzOroK8mdfBSP/rEl2wUGhd8L7
 7d0TdG9S7qQw+3FnYKcouk5J+71Nc37ShGqDo3O88uMbB0x+FiKd9Gt4p3JRDonpSNAfev
 5dMW7XyPyo5wP/GoDStW4G3h0Rzz0BM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708980854;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MIKChZRfLfdftf53J8SO5i5uLGrZ1/K/GlMGgTGNg1g=;
 b=wRohaj7y298wRKXSBn36HvPIqRd6fuc1+Rwarioo6Rc/aW9gzvYAjUWmF7cI0ohbjYkk4o
 UpFPFr8YgiKc8MDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E81513A58;
 Mon, 26 Feb 2024 20:54:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Qk9zEXX63GWPTwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Feb 2024 20:54:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 19/34] migration/multifd: Allow receiving pages
 without packets
In-Reply-To: <875xybav9b.fsf@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-20-farosas@suse.de> <Zdw2qilH4DVdmmjB@x1n>
 <875xybav9b.fsf@suse.de>
Date: Mon, 26 Feb 2024 17:54:11 -0300
Message-ID: <871q8zaqvg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iQrCRPTz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wRohaj7y
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.86 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.05)[-0.234]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 001951FB69
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> On Tue, Feb 20, 2024 at 07:41:23PM -0300, Fabiano Rosas wrote:
>>> Currently multifd does not need to have knowledge of pages on the
>>> receiving side because all the information needed is within the
>>> packets that come in the stream.
>>> 
>>> We're about to add support to fixed-ram migration, which cannot use
>>> packets because it expects the ramblock section in the migration file
>>> to contain only the guest pages data.
>>> 
>>> Add a data structure to transfer pages between the ram migration code
>>> and the multifd receiving threads.
>>> 
>>> We don't want to reuse MultiFDPages_t for two reasons:
>>> 
>>> a) multifd threads don't really need to know about the data they're
>>>    receiving.
>>> 
>>> b) the receiving side has to be stopped to load the pages, which means
>>>    we can experiment with larger granularities than page size when
>>>    transferring data.
>>> 
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>> @Peter: a 'quit' flag cannot be used instead of pending_job. The
>>> receiving thread needs know there's no more data coming. If the
>>> migration thread sets a 'quit' flag, the multifd thread would see the
>>> flag right away and exit.
>>
>> Hmm.. isn't this exactly what we want?  I'll comment for this inline below.
>>
>>> The only way is to clear pending_job on the
>>> thread and spin once more.
>>> ---
>>>  migration/file.c    |   1 +
>>>  migration/multifd.c | 122 +++++++++++++++++++++++++++++++++++++++++---
>>>  migration/multifd.h |  15 ++++++
>>>  3 files changed, 131 insertions(+), 7 deletions(-)
>>> 
>>> diff --git a/migration/file.c b/migration/file.c
>>> index 5d4975f43e..22d052a71f 100644
>>> --- a/migration/file.c
>>> +++ b/migration/file.c
>>> @@ -6,6 +6,7 @@
>>>   */
>>>  
>>>  #include "qemu/osdep.h"
>>> +#include "exec/ramblock.h"
>>>  #include "qemu/cutils.h"
>>>  #include "qapi/error.h"
>>>  #include "channel.h"
>>> diff --git a/migration/multifd.c b/migration/multifd.c
>>> index 0a5279314d..45a0c7aaa8 100644
>>> --- a/migration/multifd.c
>>> +++ b/migration/multifd.c
>>> @@ -81,9 +81,15 @@ struct {
>>>  
>>>  struct {
>>>      MultiFDRecvParams *params;
>>> +    MultiFDRecvData *data;
>>>      /* number of created threads */
>>>      int count;
>>> -    /* syncs main thread and channels */
>>> +    /*
>>> +     * For sockets: this is posted once for each MULTIFD_FLAG_SYNC flag.
>>> +     *
>>> +     * For files: this is only posted at the end of the file load to mark
>>> +     *            completion of the load process.
>>> +     */
>>>      QemuSemaphore sem_sync;
>>>      /* global number of generated multifd packets */
>>>      uint64_t packet_num;
>>> @@ -1110,6 +1116,53 @@ bool multifd_send_setup(void)
>>>      return true;
>>>  }
>>>  
>>> +bool multifd_recv(void)
>>> +{
>>> +    int i;
>>> +    static int next_recv_channel;
>>> +    MultiFDRecvParams *p = NULL;
>>> +    MultiFDRecvData *data = multifd_recv_state->data;
>>
>> [1]
>>
>>> +
>>> +    /*
>>> +     * next_channel can remain from a previous migration that was
>>> +     * using more channels, so ensure it doesn't overflow if the
>>> +     * limit is lower now.
>>> +     */
>>> +    next_recv_channel %= migrate_multifd_channels();
>>> +    for (i = next_recv_channel;; i = (i + 1) % migrate_multifd_channels()) {
>>> +        if (multifd_recv_should_exit()) {
>>> +            return false;
>>> +        }
>>> +
>>> +        p = &multifd_recv_state->params[i];
>>> +
>>> +        /*
>>> +         * Safe to read atomically without a lock because the flag is
>>> +         * only set by this function below. Reading an old value of
>>> +         * true is not an issue because it would only send us looking
>>> +         * for the next idle channel.
>>> +         */
>>> +        if (qatomic_read(&p->pending_job) == false) {
>>> +            next_recv_channel = (i + 1) % migrate_multifd_channels();
>>> +            break;
>>> +        }
>>> +    }
>>
>> IIUC you'll need an smp_mb_acquire() here.  The ordering of "reading
>> pending_job" and below must be guaranteed, similar to the sender side.
>>
>
> I've been thinking about this even on the sending side.
>
> We shouldn't need the barrier here because there's a control flow
> dependency on breaking the loop. I think pending_job *must* be read
> prior to here, otherwise the program is just wrong. Does that make
> sense?

Hm, nevermind actually. We need to order this against data->size update
on the other thread anyway.


