Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872D8C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 14:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdWEx-0004EQ-A1; Fri, 23 Feb 2024 09:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rdWBb-0003Ft-OY
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:06:00 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rdWBM-0002QG-EU
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:05:59 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96D5B1FC0C;
 Fri, 23 Feb 2024 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708697137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WRFO619Q0T38SNvvhNye80eHoeQUTPoPTzkSIqzloYw=;
 b=A8YOdioV/QfAoACce8t7IJdxB97MdCqkqFKxVputIKOYYyAOXGy37GC/+ar1lZHsi7w9II
 5pcc55jbprPSOJfKdfnA88vGKzpkWnuMj1R/hgpKxPT1wZ8RfFzTnllHs4h1KGoPMlH803
 Opda0T74vu52HhSQMxtqLlkDLZbphTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708697137;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WRFO619Q0T38SNvvhNye80eHoeQUTPoPTzkSIqzloYw=;
 b=ZiM1EqUmaNrd3bSRJ2ZnVJcB3/p4AxJq8KJIQWIJPVdmqaeXeyUElRHpnw8Qy/+YQaB9Gm
 CneQsTw3TwaP2fAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708697137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WRFO619Q0T38SNvvhNye80eHoeQUTPoPTzkSIqzloYw=;
 b=A8YOdioV/QfAoACce8t7IJdxB97MdCqkqFKxVputIKOYYyAOXGy37GC/+ar1lZHsi7w9II
 5pcc55jbprPSOJfKdfnA88vGKzpkWnuMj1R/hgpKxPT1wZ8RfFzTnllHs4h1KGoPMlH803
 Opda0T74vu52HhSQMxtqLlkDLZbphTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708697137;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WRFO619Q0T38SNvvhNye80eHoeQUTPoPTzkSIqzloYw=;
 b=ZiM1EqUmaNrd3bSRJ2ZnVJcB3/p4AxJq8KJIQWIJPVdmqaeXeyUElRHpnw8Qy/+YQaB9Gm
 CneQsTw3TwaP2fAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F7EB132C7;
 Fri, 23 Feb 2024 14:05:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wEXkNTCm2GU4DgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Feb 2024 14:05:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 14/14] migration: Fix return-path thread exit
In-Reply-To: <ZdgfnWJNYeiNYeGN@x1n>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-15-clg@redhat.com> <87v86zaxtv.fsf@suse.de>
 <50ca9637-bc18-4002-abc3-52c1bb834038@redhat.com> <87mss2pywv.fsf@suse.de>
 <2b7d3773-3cc0-41b1-8dc8-0aff90107771@redhat.com> <87sf1s8g81.fsf@suse.de>
 <ZdgfnWJNYeiNYeGN@x1n>
Date: Fri, 23 Feb 2024 11:05:34 -0300
Message-ID: <87cysn9sy9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On Fri, Feb 16, 2024 at 02:35:26PM -0300, Fabiano Rosas wrote:
>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>=20
>> > Hello Fabiano
>> >
>> > On 2/14/24 21:35, Fabiano Rosas wrote:
>> >> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>> >>=20
>> >>> Hello Fabiano
>> >>>
>> >>> On 2/8/24 14:29, Fabiano Rosas wrote:
>> >>>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>> >>>>
>> >>>>> In case of error, close_return_path_on_source() can perform a shut=
down
>> >>>>> to exit the return-path thread.  However, in migrate_fd_cleanup(),
>> >>>>> 'to_dst_file' is closed before calling close_return_path_on_source=
()
>> >>>>> and the shutdown fails, leaving the source and destination waiting=
 for
>> >>>>> an event to occur.
>> >>>>
>> >>>> Hi, C=C3=A9dric
>> >>>>
>> >>>> Are you sure this is not caused by patch 13?
>> >>>
>> >>> It happens with upstream QEMU without any patch.
>> >>=20
>> >> I might have taken that "shutdown fails" in the commit message too
>> >> literaly. Anyway, I have a proposed solution:
>> >>=20
>> >> -->8--
>> >>  From 729aa7b5b7f130f756d41649fdd0862bd2e90430 Mon Sep 17 00:00:00 20=
01
>> >> From: Fabiano Rosas <farosas@suse.de>
>> >> Date: Wed, 14 Feb 2024 16:45:43 -0300
>> >> Subject: [PATCH] migration: Join the return path thread before releas=
ing
>> >>   to_dst_file
>> >> MIME-Version: 1.0
>> >> Content-Type: text/plain; charset=3DUTF-8
>> >> Content-Transfer-Encoding: 8bit
>> >>=20
>> >> The return path thread might hang at a blocking system call. Before
>> >> joining the thread we might need to issue a shutdown() on the socket
>> >> file descriptor to release it. To determine whether the shutdown() is
>> >> necessary we look at the QEMUFile error.
>> >>=20
>> >> Make sure we only clean up the QEMUFile after the return path has been
>> >> waited for.
>> >
>> > Yes. That's the important part.
>> >
>> >> This fixes a hang when qemu_savevm_state_setup() produced an error
>> >> that was detected by migration_detect_error(). That skips
>> >> migration_completion() so close_return_path_on_source() would get
>> >> stuck waiting for the RP thread to terminate.
>> >>=20
>> >> At migrate_fd_cleanup() I'm keeping the relative order of joining the
>> >> migration thread and the return path just in case.
>> >
>> > That doesn't look necessary.
>>=20
>> Indeed. But I don't trust the migration code, it's full of undocumented
>> dependencies like that.
>>=20
>> > What was the reason to join the migration thread only when
>> > s->to_dst_file is valid ?
>>=20
>> I didn't find any explicit reason looking through the history. It seems
>> we used to rely on to_dst_file before migration_thread_running was
>> introduced.
>>=20
>> I wouldn't mind keeping that 'if' there.
>>=20
>> Let's see what Peter thinks about it.
>
> Frankly I don't have a strong opinion on current patch 14 or the new
> proposal, but it seems we reached a consensus.
>
> Fabiano, would you repost with a formal patch, with the proper tags?

Yes, I'll post it soon.

>
> One thing I am still not sure is whether we should still have patch 13
> altogether? Please see my other reply on whether it's possible to have
> migrate_get_error() =3D=3D true but qemu_file_get_error() =3D=3D false.

I'll include it then.

> In
> postcopy_pause(), currently we constantly shutdown() so the join() should
> always work:
>
>         qemu_file_shutdown(file);
>         qemu_fclose(file);
>
>         /*
>          * We're already pausing, so ignore any errors on the return
>          * path and just wait for the thread to finish. It will be
>          * re-created when we resume.
>          */
>         close_return_path_on_source(s);
>
> If move close_return_path_on_source() upper, qemu_file_shutdown() may not
> be needed? And I think we need to make sure close_return_path_on_source()
> will always properly kick the other thread.


