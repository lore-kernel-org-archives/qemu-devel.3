Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049A9C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoX0-0001GH-3n; Wed, 21 Feb 2024 10:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcoKm-0000wC-JM
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:33 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcmn7-000145-Vo
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:37:44 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C34122194;
 Wed, 21 Feb 2024 13:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708522660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9xnYPWPhqsQOkwdJ0QbnA+RyUTsNDuS9nqE1qxrBWRc=;
 b=Zb6i8Et1doRPKhHqeQv0mTN8Txbv0pm+GD9dx9g2s00cqPusAIgREqPQ84ivxz5igWHJZI
 PoFi/OmvHrm3o/ZU9srrbeHQtVMCGj+d9uvMULSXojAy7EXO+hXcWuUx3GdnuYxusRgXJn
 0HgO1o3VrdpbSonpx3YYtXPOhcoAkZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708522660;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9xnYPWPhqsQOkwdJ0QbnA+RyUTsNDuS9nqE1qxrBWRc=;
 b=V546OEb3gCkRVVh4j+ybaZTQ3X/lqRHA7Fadt/iomstqKZvxZSTCGfqR1ctfLvv+kcvQlV
 KZkDVTLSODYiUqBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708522660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9xnYPWPhqsQOkwdJ0QbnA+RyUTsNDuS9nqE1qxrBWRc=;
 b=Zb6i8Et1doRPKhHqeQv0mTN8Txbv0pm+GD9dx9g2s00cqPusAIgREqPQ84ivxz5igWHJZI
 PoFi/OmvHrm3o/ZU9srrbeHQtVMCGj+d9uvMULSXojAy7EXO+hXcWuUx3GdnuYxusRgXJn
 0HgO1o3VrdpbSonpx3YYtXPOhcoAkZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708522660;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9xnYPWPhqsQOkwdJ0QbnA+RyUTsNDuS9nqE1qxrBWRc=;
 b=V546OEb3gCkRVVh4j+ybaZTQ3X/lqRHA7Fadt/iomstqKZvxZSTCGfqR1ctfLvv+kcvQlV
 KZkDVTLSODYiUqBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0511A139D0;
 Wed, 21 Feb 2024 13:37:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8Jw4L6P81WX1dQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Feb 2024 13:37:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Peter Xu
 <peterx@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 32/34] monitor: fdset: Match against O_DIRECT
In-Reply-To: <878r3exj3f.fsf@pond.sub.org>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-33-farosas@suse.de> <878r3exj3f.fsf@pond.sub.org>
Date: Wed, 21 Feb 2024 10:37:37 -0300
Message-ID: <87plwqaqfy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zb6i8Et1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V546OEb3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.52 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-0.01)[46.90%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 7C34122194
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> We're about to enable the use of O_DIRECT in the migration code and
>> due to the alignment restrictions imposed by filesystems we need to
>> make sure the flag is only used when doing aligned IO.
>>
>> The migration will do parallel IO to different regions of a file, so
>> we need to use more than one file descriptor. Those cannot be obtained
>> by duplicating (dup()) since duplicated file descriptors share the
>> file status flags, including O_DIRECT. If one migration channel does
>> unaligned IO while another sets O_DIRECT to do aligned IO, the
>> filesystem would fail the unaligned operation.
>>
>> The add-fd QMP command along with the fdset code are specifically
>> designed to allow the user to pass a set of file descriptors with
>> different access flags into QEMU to be later fetched by code that
>> needs to alternate between those flags when doing IO.
>>
>> Extend the fdset matching function to behave the same with the
>> O_DIRECT flag.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  monitor/fds.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/monitor/fds.c b/monitor/fds.c
>> index 9a28e4b72b..42bf3eb982 100644
>> --- a/monitor/fds.c
>> +++ b/monitor/fds.c
>> @@ -413,6 +413,12 @@ static bool monitor_fdset_flags_match(int flags, int fd_flags)
>    static bool monitor_fdset_flags_match(int flags, int fd_flags)
>    {
>        bool match = false;
>    
>>      if ((flags & O_ACCMODE) == (fd_flags & O_ACCMODE)) {
>>          match = true;
>> +
>> +#ifdef O_DIRECT
>> +        if ((flags & O_DIRECT) != (fd_flags & O_DIRECT)) {
>> +            match = false;
>> +        }
>> +#endif
>>      }
>>  
>>      return match;
>    }
>
> I'd prefer something like
>
>    static bool monitor_fdset_flags_match(int flags, int fd_flags)
>    {
>    #ifdef O_DIRECT
>        if ((flags & O_DIRECT) != (fd_flags & O_DIRECT)) {
>            return false;
>        }
>    #endif
>
>        if ((flags & O_ACCMODE) != (fd_flags & O_ACCMODE)) {
>            return false;
>
>        }
>
>        return true;
>    }

This makes the O_DIRECT flag dictate the outcome when it's present. I
want O_DIRECT to be considered only when all other flags have matched.

Otherwise we regress the original use-case if the user happened to have
put O_DIRECT in the flags. A non-match due to different O_ACCMODE would
become a match due to (possibly) matching O_DIRECT.

