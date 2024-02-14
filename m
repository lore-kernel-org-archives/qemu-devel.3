Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B10AC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 16:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raHgR-0001m8-Dy; Wed, 14 Feb 2024 11:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1raHgP-0001l5-ND
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:00:25 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1raHgM-0002Rp-Gq
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:00:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8528C1F810;
 Wed, 14 Feb 2024 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707926420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5UeP0KRWPP3TFugAL/CO0C28dDyDFJYvbRK1NCM+l8=;
 b=btqHFkb/uc6l7PyTLKVc0vLYLlEry9tk0+gbywARF7InOGt2rCDbIkdrvxrPsREb2EK3TN
 ZO5XUN4bwCpvdvzv9pXROYcIFymPs/vcPzsvDK9tLXERzIV4HOuDQjmqF6I8k8zuPSDN+b
 tzwpuPAPr3c/1IZp9f2VPoCO5VvgJXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707926420;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5UeP0KRWPP3TFugAL/CO0C28dDyDFJYvbRK1NCM+l8=;
 b=TRORliYwtl/JXBaA/TyFRFVA6bzJ3PqXC6lvS4Ufu/mMCHBiwbtDKJvkCi5RLx8P41KyUh
 IAyQPZldib7HjdCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707926420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5UeP0KRWPP3TFugAL/CO0C28dDyDFJYvbRK1NCM+l8=;
 b=btqHFkb/uc6l7PyTLKVc0vLYLlEry9tk0+gbywARF7InOGt2rCDbIkdrvxrPsREb2EK3TN
 ZO5XUN4bwCpvdvzv9pXROYcIFymPs/vcPzsvDK9tLXERzIV4HOuDQjmqF6I8k8zuPSDN+b
 tzwpuPAPr3c/1IZp9f2VPoCO5VvgJXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707926420;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5UeP0KRWPP3TFugAL/CO0C28dDyDFJYvbRK1NCM+l8=;
 b=TRORliYwtl/JXBaA/TyFRFVA6bzJ3PqXC6lvS4Ufu/mMCHBiwbtDKJvkCi5RLx8P41KyUh
 IAyQPZldib7HjdCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0979B13A6D;
 Wed, 14 Feb 2024 16:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2lZdMJPjzGUTMAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Feb 2024 16:00:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 13/14] migration: Use migrate_has_error() in
 close_return_path_on_source()
In-Reply-To: <4af61bb2-4b21-4560-a7c1-c3fb65f20ff3@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-14-clg@redhat.com> <87y1bvayu7.fsf@suse.de>
 <fbdb9fbc-c3de-4b0a-be1f-2bed405dfd86@redhat.com> <87sf23awjp.fsf@suse.de>
 <4af61bb2-4b21-4560-a7c1-c3fb65f20ff3@redhat.com>
Date: Wed, 14 Feb 2024 13:00:17 -0300
Message-ID: <87zfw3ox2m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="btqHFkb/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TRORliYw
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; BAYES_HAM(-3.00)[100.00%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 8528C1F810
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> On 2/8/24 14:57, Fabiano Rosas wrote:
>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>=20
>>> On 2/8/24 14:07, Fabiano Rosas wrote:
>>>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>>>
>>>>> close_return_path_on_source() retrieves the migration error from the
>>>>> the QEMUFile '->to_dst_file' to know if a shutdown is required. This
>>>>> shutdown is required to exit the return-path thread. However, in
>>>>> migrate_fd_cleanup(), '->to_dst_file' is cleaned up before calling
>>>>> close_return_path_on_source() and the shutdown is never performed,
>>>>> leaving the source and destination waiting for an event to occur.
>>>>>
>>>>> Avoid relying on '->to_dst_file' and use migrate_has_error() instead.
>>>>>
>>>>> Suggested-by: Peter Xu <peterx@redhat.com>
>>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>>>>> ---
>>>>>    migration/migration.c | 3 +--
>>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>> index d5f705ceef4c925589aa49335969672c0d761fa2..5f55af3d7624750ca416c=
4177781241b3e291e5d 100644
>>>>> --- a/migration/migration.c
>>>>> +++ b/migration/migration.c
>>>>> @@ -2372,8 +2372,7 @@ static bool close_return_path_on_source(Migrati=
onState *ms)
>>>>>         * cause it to unblock if it's stuck waiting for the destinati=
on.
>>>>>         */
>>>>>        WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
>>>>> -        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
>>>>> -            qemu_file_get_error(ms->to_dst_file)) {
>>>>> +        if (migrate_has_error(ms) && ms->rp_state.from_dst_file) {
>>>>>                qemu_file_shutdown(ms->rp_state.from_dst_file);
>>>>>            }
>>>>>        }
>>>>
>>>> Hm, maybe Peter can help defend this, but this assumes that every
>>>> function that takes an 'f' and sets the file error also sets
>>>> migrate_set_error(). I'm not sure we have determined that, have we?
>>>
>>> How could we check all the code path ? I agree it is difficult when
>>> looking at the code :/
>>=20
>> It would help if the thing wasn't called 'f' for the most part of the
>> code to begin with.
>>=20
>> Whenever there's a file error at to_dst_file there's the chance that the
>> rp_state.from_dst_file got stuck. So we cannot ignore the file error.
>>=20
>> Would it work if we checked it earlier during cleanup as you did
>> previously and then set the migration error?
>
> Do you mean doing something similar to what is done in
> source_return_path_thread() ?
>
>          if (qemu_file_get_error(s->to_dst_file)) {
>              qemu_file_get_error_obj(s->to_dst_file, &err);
>      	    if (err) {
>          	migrate_set_error(ms, err);
>          	error_free(err);
> 	...
>
> Yes. That would be safer I think.

Yes, something like that.

I wish we could make that return path cleanup more deterministic, but
currently it's just: "if something hangs, call shutdown()". We don't
have a way to detect a hang, we just look at the file error and hope it
works.

A crucial aspect here is that calling qemu_file_shutdown() itself sets
the file error. So there's not even a guarantee that an error is
actually an error.

>
>
> Nevertheless, I am struggling to understand how qemu_file_set_error()
> and migrate_set_error() fit together. I was expecting some kind of
> synchronization  routine but there isn't it seems. Are they completely
> orthogonal ? when should we use these routines and when not ?

We're trying to phase out the QEMUFile usage altogether. One thing that
is getting in the way is this dependency on the qemu_file_*_error
functions.

While we're not there yet, a good pattern is to find a
qemu_file_set|get_error() pair and replace it with
migrate_set|has_error(). Unfortunately the return path does not fit in
this, because we don't have a matching qemu_file_set_error, it could be
anywhere. As I said above, we're using that error as a heuristic for: "a
recvmsg() might be hanging".

>
> My initial goal was to modify some of the memory handlers (log_global*)
> and migration handlers to propagate errors at the QMP level and them
> report to the management layer. This is growing in something bigger
> and currently, I don't find a good approach to the problem.
>
> The last two patches of this series try to fix the return-path thread
> termination. Let's keep that for after.

I'll try to figure that out. I see you provided a reproducer.

>
> Thanks,
>
> C.

