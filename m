Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7031BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 18:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1W2a-00065m-F1; Mon, 29 Apr 2024 14:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1W2T-0005xU-LP
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:47:50 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1W2R-0000Li-U1
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:47:45 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 356E433A22;
 Mon, 29 Apr 2024 18:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714416462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6QVWdAILr0Y4hV5RI0vcJpGAoRbDZ3D1pqMfejytSo=;
 b=mU5qimqSKGpD9i+wGSzlZgimZnL6+anER1Tx03kLoCfDCGJxo8HvaxdOyKcaDxH4Ws1nnJ
 SqGXAR81fGVq11SyMnZmPyOlEIYRqySIx3xEJDdZXHzZhvGHbfO+BJ3pANMCmgQifHatBH
 8rBtpwYK8gPDJjpT6UwCbXsO39+4izo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714416462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6QVWdAILr0Y4hV5RI0vcJpGAoRbDZ3D1pqMfejytSo=;
 b=cDwj+I5HZ6rvm8T404Wui6/2w5CXw8+xaqsqKZB4SJOWAUw39T4lQOMLfkUzPbujlFL6dQ
 +cfXzk9kug2N2yAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714416462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6QVWdAILr0Y4hV5RI0vcJpGAoRbDZ3D1pqMfejytSo=;
 b=mU5qimqSKGpD9i+wGSzlZgimZnL6+anER1Tx03kLoCfDCGJxo8HvaxdOyKcaDxH4Ws1nnJ
 SqGXAR81fGVq11SyMnZmPyOlEIYRqySIx3xEJDdZXHzZhvGHbfO+BJ3pANMCmgQifHatBH
 8rBtpwYK8gPDJjpT6UwCbXsO39+4izo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714416462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6QVWdAILr0Y4hV5RI0vcJpGAoRbDZ3D1pqMfejytSo=;
 b=cDwj+I5HZ6rvm8T404Wui6/2w5CXw8+xaqsqKZB4SJOWAUw39T4lQOMLfkUzPbujlFL6dQ
 +cfXzk9kug2N2yAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2413138A7;
 Mon, 29 Apr 2024 18:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FKsXHk3rL2YUXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Apr 2024 18:47:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 6/6] migration: Deprecate fd: for file migration
In-Reply-To: <Zi_puGn7Y1ArcLCL@x1n>
References: <20240426131408.25410-1-farosas@suse.de>
 <20240426131408.25410-7-farosas@suse.de> <Zi_puGn7Y1ArcLCL@x1n>
Date: Mon, 29 Apr 2024 15:47:39 -0300
Message-ID: <87zftcdn04.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[4]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Fri, Apr 26, 2024 at 10:14:08AM -0300, Fabiano Rosas wrote:
>> The fd: URI can currently trigger two different types of migration, a
>> TCP migration using sockets and a file migration using a plain
>> file. This is in conflict with the recently introduced (8.2) QMP
>> migrate API that takes structured data as JSON-like format. We cannot
>> keep the same backend for both types of migration because with the new
>> API the code is more tightly coupled to the type of transport. This
>> means a TCP migration must use the 'socket' transport and a file
>> migration must use the 'file' transport.
>> 
>> If we keep allowing fd: when using a file, this creates an issue when
>> the user converts the old-style (fd:) to the new style ("transport":
>> "socket") invocation because the file descriptor in question has
>> previously been allowed to be either a plain file or a socket.
>> 
>> To avoid creating too much confusion, we can simply deprecate the fd:
>> + file usage, which is thought to be rarely used currently and instead
>> establish a 1:1 correspondence between fd: URI and socket transport,
>> and file: URI and file transport.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  docs/about/deprecated.rst | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>> 
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 0fb5c82640..813f7996fe 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -464,3 +464,17 @@ both, older and future versions of QEMU.
>>  The ``blacklist`` config file option has been renamed to ``block-rpcs``
>>  (to be in sync with the renaming of the corresponding command line
>>  option).
>> +
>> +Migration
>> +---------
>> +
>> +``fd:`` URI when used for file migration (since 9.1)
>> +''''''''''''''''''''''''''''''''''''''''''''''''''''
>> +
>> +The ``fd:`` URI can currently provide a file descriptor that
>> +references either a socket or a plain file. These are two different
>> +types of migration. In order to reduce ambiguity, the ``fd:`` URI
>> +usage of providing a file descriptor to a plain file has been
>> +deprecated in favor of explicitly using the ``file:`` URI with the
>> +file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
>> +command documentation for details on the ``fdset`` usage.
>
> Wanna do some warn_report() when detected non-socket fds alongside?  Looks
> like we previously do this for all deprecations.

Yes, good point.

>
> What's the plan when it's support removed?  I'm imaginging that we sanity
> check fstat() + S_ISSOCK on the fd and fail otherwise?  In that case we can
> have the code there, dump warn_report(), then switch to failing qmp migrate
> (and incoming side) later on?

Something along those lines. We currently use fd_is_socket():

bool fd_is_socket(int fd)
{
    int optval;
    socklen_t optlen = sizeof(optval);
    return !getsockopt(fd, SOL_SOCKET, SO_TYPE, &optval, &optlen);
}

I'm thinking of this in fd_start_outgoing_migation():

    if (!fd_is_socket(fd)) {
        warn_report("fd: migration to a file is deprecated."
                    " Use file: instead.");
    }

