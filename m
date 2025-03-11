Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71749C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 12:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tryyE-0004um-Ph; Tue, 11 Mar 2025 08:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tryyC-0004p1-8H
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 08:44:28 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tryy9-0005Q9-3U
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 08:44:27 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A3082115E;
 Tue, 11 Mar 2025 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741697061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZ7dlMjFCWJxa28g3U7PEZxJ/JqmTpxqfmGeTYUXVvY=;
 b=x/csXJgpkI1aj4Cher8LXcIb9gXcRPvLk+hYcU/JYP9RUnSGnjwGCDLDb2c2mzquN8Mo6j
 mMLTSIP3PFMgAxxODudA/B/HlT+qJ4HBgYkJpG1wVPWIW9WphOtUDAAA4ps+69EfKxwrrV
 bZzhT64bqxq3Uuvbdmb2p4bUwaHJqt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741697061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZ7dlMjFCWJxa28g3U7PEZxJ/JqmTpxqfmGeTYUXVvY=;
 b=Psz18MF+xaWDLN9xETsgl9B6p/I9C3GR+8MynITpH6XzatjLU7YXCRgxNojA72PQQ1djQ3
 NDLfr9EEBSDBPvBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="x/csXJgp";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Psz18MF+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741697061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZ7dlMjFCWJxa28g3U7PEZxJ/JqmTpxqfmGeTYUXVvY=;
 b=x/csXJgpkI1aj4Cher8LXcIb9gXcRPvLk+hYcU/JYP9RUnSGnjwGCDLDb2c2mzquN8Mo6j
 mMLTSIP3PFMgAxxODudA/B/HlT+qJ4HBgYkJpG1wVPWIW9WphOtUDAAA4ps+69EfKxwrrV
 bZzhT64bqxq3Uuvbdmb2p4bUwaHJqt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741697061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZ7dlMjFCWJxa28g3U7PEZxJ/JqmTpxqfmGeTYUXVvY=;
 b=Psz18MF+xaWDLN9xETsgl9B6p/I9C3GR+8MynITpH6XzatjLU7YXCRgxNojA72PQQ1djQ3
 NDLfr9EEBSDBPvBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83E75132CB;
 Tue, 11 Mar 2025 12:44:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qE5nECQw0GcNNwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 11 Mar 2025 12:44:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
In-Reply-To: <CAE8KmOxB-5xOtyz5-5g=3v7nF=z0bzhqVfax3Bd--zshQu8CjQ@mail.gmail.com>
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com> <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
 <Z8XBowkG72G-l3L4@x1.local>
 <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
 <Z8cPnxqOvp1hFpx8@x1.local>
 <CAE8KmOw1CCQUt0wyELVhy5j-CfwVuA2XNsecW=y6rwJv7dempw@mail.gmail.com>
 <Z8hJeneeuKqD1i8Q@x1.local>
 <CAE8KmOyKiEt9t0vUwVyqD7tx01vkm+NHA1p1tmQnJ9mKY0Za7w@mail.gmail.com>
 <Z8t4YoPEnwJO0sFP@x1.local> <87ldtdt0g3.fsf@suse.de>
 <CAE8KmOwrbJnxS7How7=dhk2hnUUUjKzgEmvT2iTh+BpUa7n1WA@mail.gmail.com>
 <87bju8ac9v.fsf@suse.de>
 <CAE8KmOxB-5xOtyz5-5g=3v7nF=z0bzhqVfax3Bd--zshQu8CjQ@mail.gmail.com>
Date: Tue, 11 Mar 2025 09:44:17 -0300
Message-ID: <875xkfag9q.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 1A3082115E
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:dkim, suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hi,
>
> On Tue, 11 Mar 2025 at 01:28, Fabiano Rosas <farosas@suse.de> wrote:
>> They occur when cleanup code is allowed to run when resources have not
>> yet been allocated or while the resources are still being accessed.
>>
>> Having the shutdown routine at a single point when it's clear everything
>> else is ready for shutdown helps not only to avoid those issues, but
>> also when investigating them. Otherwise you'll have the same code
>> running at (potentially) completely different points in time and one of
>> those times the system might be in an unexpected state.
>
> * I see. It's not clear when this would happen in a production deployment.
> ===
>      if (migrate_multifd()) {
>           multifd_send_shutdown();  <= [1]
>      }
>
>      postcopy_start(...)  <= [2]
> ===
>
> * There was another scenario regarding multifd shutdown as: the EOF or
> shutdown message sent via [1] on each multifd connection reaches the
> destination _later_ than the Postcopy phase start via [2]. And this
> may result in multifd_recv_threads on the destination overwriting
> memory pages written by postcopy thread, thus corrupting the guest
> state.

Isn't that the point? To add a sync for this which would allow the
shutdown to not be added?

>
> * Do we have any bugs/issues where these above things happened? To see
> the real circumstances under which it happened?
>

We do. They don't come with a description of the circumstances. You're
lucky if you get a coredump. You can peruse `git log migration/multifd`,
I'd say most of the work in the recent years has been solving
concurrency issues.

> * There seems to be some disconnect between the kind of scenarios we
> are considering and the minimal requirements for live migrations: a
> stable network with real good bandwidth.

There's no such requirement. Besides, the topic is not failed migrations
due to lack of resources. We're talking about correctness issues that
are hard to spot. Those should always be fixed when found, independently
of what the production environment is expected to be.

