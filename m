Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5347CC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 21:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s30Jg-0006Ym-2M; Fri, 03 May 2024 17:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s30Jd-0006YR-TE
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:19:37 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s30Jb-0005ON-W3
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:19:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE4D4207BF;
 Fri,  3 May 2024 21:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714771174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzFH/vPntYwCVn9U0ooCcYy26BK3rd4hvuLEpKxmtz8=;
 b=ak57QjvP2Lw53YHnw/8rasmpQVS6d2QF481D7u9dObLG9PULFy9Ak4Qpbpaf9/gV5trvv6
 eL0QwC7aRbxlSdZgNC+JOSzO++kQOJo+1T0juyDoa2UaWeUdJxUZhgdWWbmM7xOs7rMvXG
 BQV4CLhcDktEGHfR1dDr7JkANiHeUlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714771174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzFH/vPntYwCVn9U0ooCcYy26BK3rd4hvuLEpKxmtz8=;
 b=EB39dalmYoESHY1sBCA2dgsrIHL6DoWeipiBysGIoDVM0O3ShPj6fNsJ47nWZVwXBDBEAl
 Uo7theFpN+rjiSBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E8lCqG3O;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xJ6bH3MB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714771173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzFH/vPntYwCVn9U0ooCcYy26BK3rd4hvuLEpKxmtz8=;
 b=E8lCqG3Oq7nenzKcrNfCDpxddojnUu2k8t6jZi+RR6zeXVEZFgfCK08W2KcWUW0bv+QgeK
 WukBCRW4Du4rvFcissMm9c5kqhTYwS3VEaIdnKt4itU+ytG0HpO4bYNkHX1xgrXXcxIqD7
 zKrsKNt8077yc7R0hL7B4fCji39CjZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714771173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzFH/vPntYwCVn9U0ooCcYy26BK3rd4hvuLEpKxmtz8=;
 b=xJ6bH3MBV09PUA5XxAB4/mN8BxyhOqC1viXBEKfHnRjYMNlzVbnTEqHGKG3ouHmQeLYEO9
 l0hvxYUcNTBLGkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56A2713991;
 Fri,  3 May 2024 21:19:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ffPkB+VUNWbREAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 03 May 2024 21:19:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 7/9] monitor: fdset: Match against O_DIRECT
In-Reply-To: <ZjUyta-q8GuTDDjJ@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-8-farosas@suse.de> <ZjUyta-q8GuTDDjJ@x1n>
Date: Fri, 03 May 2024 18:19:30 -0300
Message-ID: <87seyymw4d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CE4D4207BF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
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

> On Fri, Apr 26, 2024 at 11:20:40AM -0300, Fabiano Rosas wrote:
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
>> Extend the fdset matching to behave the same with the O_DIRECT flag.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  monitor/fds.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/monitor/fds.c b/monitor/fds.c
>> index 4ec3b7eea9..62e324fcec 100644
>> --- a/monitor/fds.c
>> +++ b/monitor/fds.c
>> @@ -420,6 +420,11 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
>>          int fd = -1;
>>          int dup_fd;
>>          int mon_fd_flags;
>> +        int mask = O_ACCMODE;
>> +
>> +#ifdef O_DIRECT
>> +        mask |= O_DIRECT;
>> +#endif
>>  
>>          if (mon_fdset->id != fdset_id) {
>>              continue;
>> @@ -431,7 +436,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
>>                  return -1;
>>              }
>>  
>> -            if ((flags & O_ACCMODE) == (mon_fd_flags & O_ACCMODE)) {
>> +            if ((flags & mask) == (mon_fd_flags & mask)) {
>>                  fd = mon_fdset_fd->fd;
>>                  break;
>>              }
>
> I think I see what you wanted to do, picking out the right fd out of two
> when qemu_open_old(), which makes sense.
>
> However what happens if the mgmt app only passes in 1 fd to the fdset?  The
> issue is we have a "fallback dup()" plan right after this chunk of code:
>

I'm validating the fdset at file_parse_fdset() beforehand. If there's
anything else than 2 fds then we'll error out:

    if (nfds != 2) {
        error_setg(errp, "Outgoing migration needs two fds in the fdset, "
                   "got %d", nfds);
        qmp_remove_fd(*id, false, -1, NULL);
        *id = -1;
        return false;
    }

>         dup_fd = qemu_dup_flags(fd, flags);
>         if (dup_fd == -1) {
>             return -1;
>         }
>
>         mon_fdset_fd_dup = g_malloc0(sizeof(*mon_fdset_fd_dup));
>         mon_fdset_fd_dup->fd = dup_fd;
>         QLIST_INSERT_HEAD(&mon_fdset->dup_fds, mon_fdset_fd_dup, next);
>
> I think it means even if the mgmt app only passes in 1 fd (rather than 2,
> one with O_DIRECT, one without), QEMU can always successfully call
> qemu_open_old() twice for each case, even though silently the two FDs will
> actually impact on each other.  This doesn't look ideal if it's true.
>
> But I also must confess I don't really understand this code at all: we
> dup(), then we try F_SETFL on all the possible flags got passed in.
> However AFAICT due to the fact that dup()ed FDs will share "struct file" it
> means mostly all flags will be shared, except close-on-exec.  I don't ever
> see anything protecting that F_SETFL to only touch close-on-exec, I think
> it means it'll silently change file status flags for the other fd which we
> dup()ed from.  Does it mean that we have issue already with such dup() usage?

I think you're right, but I also think there's a requirement even from
this code that the fds in the fdset cannot be dup()ed. I don't see it
enforced anywhere, but maybe that's a consequence of the larger use-case
for which this feature was introduced.

For our scenario, the open() man page says one can use kcmp() to compare
the fds and determine if they are a result of dup(). Maybe we should do
that extra check? We're defining a pretty rigid interface between QEMU
and the management layer, so not likely to break once it's written. I'm
also not sure how bad would it be to call syscall() directly from QEMU
(kcmp has no libc wrapper).

>
> Thanks,

