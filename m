Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1CBC8303F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWetk-0004bv-Rg; Tue, 01 Jul 2025 13:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWetc-0004Ka-HP
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:35:52 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWetV-0000A3-Eu
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:35:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CAEA321174;
 Tue,  1 Jul 2025 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751391343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAogss75G+8WOyNzABCTp4Q7N33UdWP3rfHYyFQRI/g=;
 b=Gso4f0vraooNdJRifSKlZFzadcUeSI5gqpfWiwq1LcZzQ8FkMb/iEZOT0IaqRzD19EOXNu
 Q9Fhl00xCFLsNbUigUPZiWfTZ48XBzATsQ94CK2+y3Y+TytD1In569fdRBCSTyadwaB3Ec
 Hy+zhta/Zd5D1Mcx3VgAr2hjZtuXPbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751391343;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAogss75G+8WOyNzABCTp4Q7N33UdWP3rfHYyFQRI/g=;
 b=pzTeFyXKSldjyhIztXqzSqJhmvLJ1WnhuTGGMsf+d+w3HcRigjVOwuryobWsFIwongp7+N
 IKpvwQ34lrQOH0BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751391341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAogss75G+8WOyNzABCTp4Q7N33UdWP3rfHYyFQRI/g=;
 b=cVSfn+M97Rhbe2ChsEhVnwVszAbypCRvpV2CHdnFdP0AJHYFmYERKoBi1z9BHP5GbkADBV
 Y/0/QL87NC8e9WADytkrINpboJCw6mzNZNpOxB1k8bU3Lp7K+C50lZYqXFvDMB1D8uS05C
 RWCWu8OE+79o/vA3DwJVniRkZXOUQ5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751391341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAogss75G+8WOyNzABCTp4Q7N33UdWP3rfHYyFQRI/g=;
 b=Y5oBMmeAt57WxQYO5j5AYYPJkFhTh58qnNJuv68ogRIvVvXPefZwE597Omj9fCj1NNaK5i
 KPZuBkX5mJwngvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41A8B13890;
 Tue,  1 Jul 2025 17:35:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r7lrAG0cZGhHSQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 01 Jul 2025 17:35:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com, "Dr . David Alan
 Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2 10/11] migration: Rewrite the migration complete
 detect logic
In-Reply-To: <20250609161855.6603-11-peterx@redhat.com>
References: <20250609161855.6603-1-peterx@redhat.com>
 <20250609161855.6603-11-peterx@redhat.com>
Date: Tue, 01 Jul 2025 14:35:38 -0300
Message-ID: <87a55n6cgl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> There're a few things off here in that logic, rewrite it.  When at it, add
> rich comment to explain each of the decisions.
>
> Since this is very sensitive path for migration, below are the list of
> things changed with their reasonings.
>
>   (1) Exact pending size is only needed for precopy not postcopy
>
>       Fundamentally it's because "exact" version only does one more deep
>       sync to fetch the pending results, while in postcopy's case it's
>       never going to sync anything more than estimate as the VM on source
>       is stopped.
>
>   (2) Do _not_ rely on threshold_size anymore to decide whether postcopy
>       should complete
>
>       threshold_size was calculated from the expected downtime and
>       bandwidth only during precopy as an efficient way to decide when to
>       switchover.  It's not sensible to rely on threshold_size in postcopy.
>
>       For precopy, if switchover is decided, the migration will complete
>       soon.  It's not true for postcopy.  Logically speaking, postcopy
>       should only complete the migration if all pending data is flushed.
>
>       Here it used to work because save_complete() used to implicitly
>       contain save_live_iterate() when there's pending size.
>
>       Even if that looks benign, having RAMs to be migrated in postcopy's
>       save_complete() has other bad side effects:
>
>       (a) Since save_complete() needs to be run once at a time, it means
>       when moving RAM there's no way moving other things (rather than
>       round-robin iterating the vmstate handlers like what we do with
>       ITERABLE phase).  Not an immediate concern, but it may stop working
>       in the future when there're more than one iterables (e.g. vfio
>       postcopy).
>
>       (b) postcopy recovery, unfortunately, only works during ITERABLE
>       phase. IOW, if src QEMU moves RAM during postcopy's save_complete()
>       and network failed, then it'll crash both QEMUs... OTOH if it failed
>       during iteration it'll still be recoverable.  IOW, this change should
>       further reduce the window QEMU split brain and crash in extreme cases.
>
>       If we enable the ram_save_complete() tracepoints, we'll see this
>       before this patch:
>
>       1267959@1748381938.294066:ram_save_complete dirty=9627, done=0
>       1267959@1748381938.308884:ram_save_complete dirty=0, done=1
>
>       It means in this migration there're 9627 pages migrated at complete()
>       of postcopy phase.
>
>       After this change, all the postcopy RAM should be migrated in iterable
>       phase, rather than save_complete():
>
>       1267959@1748381938.294066:ram_save_complete dirty=0, done=0
>       1267959@1748381938.308884:ram_save_complete dirty=0, done=1
>
>   (3) Adjust when to decide to switch to postcopy
>
>       This shouldn't be super important, the movement makes sure there's
>       only one in_postcopy check, then we are clear on what we do with the
>       two completely differnt use cases (precopy v.s. postcopy).
>
>   (4) Trivial touch up on threshold_size comparision
>
>       Which changes:
>
>       "(!pending_size || pending_size < s->threshold_size)"
>
>       into:
>
>       "(pending_size <= s->threshold_size)"
>
> Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

