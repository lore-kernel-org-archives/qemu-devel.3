Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3270C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 18:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj1LI-0004jB-H3; Tue, 27 Aug 2024 14:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sj1LG-0004d3-Sn
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 14:54:58 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sj1LE-0008CI-IM
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 14:54:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A3D3721B1E;
 Tue, 27 Aug 2024 18:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724784894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQw8N0sfu0wpOt9ly665yqSVRiWkPN4oxnJYWOz4iJk=;
 b=0XffD1gJ4EnWFuJntVmgPO86Znl3rNvvLo9voE6ClPA9/4CrgDUAauz/wGYQVTKLnXmJaZ
 u+zc9LJVFKcBuwF+Pp5QrVFPwm4v17YnaVcNtzorPtHZKR91slwqsZjFwtK+n7yjKdW7/q
 bwhscqiYzAzBh1vf9D/HQ2J4PEAE7G0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724784894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQw8N0sfu0wpOt9ly665yqSVRiWkPN4oxnJYWOz4iJk=;
 b=Rw1Q0PHSjg+Okiq9SjL2QvmCi3Rt1NcpkI3uvIjmZczkFOA7tsXHWX16ShZmsQCRd3x7qL
 Da+D6dpcjyIyFRAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724784894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQw8N0sfu0wpOt9ly665yqSVRiWkPN4oxnJYWOz4iJk=;
 b=0XffD1gJ4EnWFuJntVmgPO86Znl3rNvvLo9voE6ClPA9/4CrgDUAauz/wGYQVTKLnXmJaZ
 u+zc9LJVFKcBuwF+Pp5QrVFPwm4v17YnaVcNtzorPtHZKR91slwqsZjFwtK+n7yjKdW7/q
 bwhscqiYzAzBh1vf9D/HQ2J4PEAE7G0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724784894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQw8N0sfu0wpOt9ly665yqSVRiWkPN4oxnJYWOz4iJk=;
 b=Rw1Q0PHSjg+Okiq9SjL2QvmCi3Rt1NcpkI3uvIjmZczkFOA7tsXHWX16ShZmsQCRd3x7qL
 Da+D6dpcjyIyFRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28CA413724;
 Tue, 27 Aug 2024 18:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zPL/N/0gzmbWZAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 27 Aug 2024 18:54:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v6 19/19] migration/multifd: Add documentation for
 multifd methods
In-Reply-To: <Zs4bL_lRURD7cV_N@x1n>
References: <20240827174606.10352-1-farosas@suse.de>
 <20240827174606.10352-20-farosas@suse.de> <Zs4bL_lRURD7cV_N@x1n>
Date: Tue, 27 Aug 2024 15:54:51 -0300
Message-ID: <87mskxx0ck.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.985]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

> On Tue, Aug 27, 2024 at 02:46:06PM -0300, Fabiano Rosas wrote:
>> Add documentation clarifying the usage of the multifd methods. The
>> general idea is that the client code calls into multifd to trigger
>> send/recv of data and multifd then calls these hooks back from the
>> worker threads at opportune moments so the client can process a
>> portion of the data.
>> 
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> Note that the doc is not symmetrical among send/recv because the recv
>> side is still wonky. It doesn't give the packet to the hooks, which
>> forces the p->normal, p->zero, etc. to be processed at the top level
>> of the threads, where no client-specific information should be.
>> ---
>>  migration/multifd.h | 76 +++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 70 insertions(+), 6 deletions(-)
>> 
>> diff --git a/migration/multifd.h b/migration/multifd.h
>> index 13e7a88c01..ebb17bdbcf 100644
>> --- a/migration/multifd.h
>> +++ b/migration/multifd.h
>> @@ -229,17 +229,81 @@ typedef struct {
>>  } MultiFDRecvParams;
>>  
>>  typedef struct {
>> -    /* Setup for sending side */
>> +    /*
>> +     * The send_setup, send_cleanup, send_prepare are only called on
>> +     * the QEMU instance at the migration source.
>> +     */
>> +
>> +    /*
>> +     * Setup for sending side. Called once per channel during channel
>> +     * setup phase.
>> +     *
>> +     * Must allocate p->iov. If packets are in use (default), one
>
> Pure thoughts: wonder whether we can assert(p->iov) that after the hook
> returns in code to match this line.

Not worth the extra instructions in my opinion. It would crash
immediately once the thread touches p->iov anyway.

>
>> +     * extra iovec must be allocated for the packet header. Any memory
>> +     * allocated in this hook must be released at send_cleanup.
>> +     *
>> +     * p->write_flags may be used for passing flags to the QIOChannel.
>> +     *
>> +     * p->compression_data may be used by compression methods to store
>> +     * compression data.
>> +     */
>>      int (*send_setup)(MultiFDSendParams *p, Error **errp);
>> -    /* Cleanup for sending side */
>> +
>> +    /*
>> +     * Cleanup for sending side. Called once per channel during
>> +     * channel cleanup phase. May be empty.
>
> Hmm, if we require p->iov allocation per-ops, then they must free it here?
> I wonder whether we leaked it in most compressors.

Sorry, this one shouldn't have that text.

>
> With that, I wonder whether we should also assert(p->iov == NULL) after
> this one returns (squash in this same patch).
>
>> +     */
>>      void (*send_cleanup)(MultiFDSendParams *p, Error **errp);
>> -    /* Prepare the send packet */
>> +
>> +    /*
>> +     * Prepare the send packet. Called from multifd_send(), with p
>
> multifd_send_thread()?

No, I meant called as a result of multifd_send(), which is the function
the client uses to trigger a send on the thread.

>
>> +     * pointing to the MultiFDSendParams of a channel that is
>> +     * currently idle.
>> +     *
>> +     * Must populate p->iov with the data to be sent, increment
>> +     * p->iovs_num to match the amount of iovecs used and set
>> +     * p->next_packet_size with the amount of data currently present
>> +     * in p->iov.
>> +     *
>> +     * Must indicate whether this is a compression packet by setting
>> +     * p->flags.
>
> Sigh.. I wonder whether we could avoid mentioning this, and also we avoid
> adding new flags for new compressors, relying on libvirt guarding things.
> Then when we have the handshakes that's something we verify there.
>

I understand that part is not in the best shape, but we must document
the current state. There's no problem changing this later.

Besides, there's the whole "the migration stream should be considered
hostile" which might mean we should really be keeping these sanity check
flags around in case something really weird happens so we don't carry on
with a bad stream.

>> +     *
>> +     * As a last step, if packets are in use (default), must prepare
>> +     * the packet by calling multifd_send_fill_packet().
>> +     */
>>      int (*send_prepare)(MultiFDSendParams *p, Error **errp);
>> -    /* Setup for receiving side */
>> +
>> +    /*
>> +     * The recv_setup, recv_cleanup, recv are only called on the QEMU
>> +     * instance at the migration destination.
>> +     */
>> +
>> +    /*
>> +     * Setup for receiving side. Called once per channel during
>> +     * channel setup phase. May be empty.
>> +     *
>> +     * May allocate data structures for the receiving of data. May use
>> +     * p->iov. Compression methods may use p->compress_data.
>> +     */
>>      int (*recv_setup)(MultiFDRecvParams *p, Error **errp);
>> -    /* Cleanup for receiving side */
>> +
>> +    /*
>> +     * Cleanup for receiving side. Called once per channel during
>> +     * channel cleanup phase. May be empty.
>> +     */
>>      void (*recv_cleanup)(MultiFDRecvParams *p);
>> -    /* Read all data */
>> +
>> +    /*
>> +     * Data receive method. Called from multifd_recv(), with p
>
> multifd_recv_thread()?

Same as before. I'll reword this somehow.

>
>> +     * pointing to the MultiFDRecvParams of a channel that is
>> +     * currently idle. Only called if there is data available to
>> +     * receive.
>> +     *
>> +     * Must validate p->flags according to what was set at
>> +     * send_prepare.
>> +     *
>> +     * Must read the data from the QIOChannel p->c.
>> +     */
>>      int (*recv)(MultiFDRecvParams *p, Error **errp);
>>  } MultiFDMethods;
>>  
>> -- 
>> 2.35.3
>> 

