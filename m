Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA73C5B555
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 17:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM9Eq-0004sf-Bn; Mon, 02 Jun 2025 13:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uM9En-0004sT-2E
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 13:46:17 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uM9El-0008CX-F7
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 13:46:16 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB3141F799;
 Mon,  2 Jun 2025 17:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748886372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KSvTDujfeglymYOPkJd3S3NxqODZvji6hSP7JEhFHsE=;
 b=CRkWmNYhhhp8pgSGRN47s3PZRrKHgH14q3zLFmN8Pp3EfgLGqqFdMno/3uKfWVCNEt7ht3
 kHi+IoHxPRDYPceb9Fhrs1uyFlvSjUFCoyRMzvWCyshvAIiRad5AJo22ooHt3DgNJKN75L
 1fwEOCPkclN1r5WMqwRY1iqJVdao/RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748886372;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KSvTDujfeglymYOPkJd3S3NxqODZvji6hSP7JEhFHsE=;
 b=+4+RFLBegUINr25L8Ed6EQvoGlz+hSsvpaf565uwFYpb2CHsloHanvpr9q3OgqhScSzK5K
 3Tuhdr4li45rawDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748886372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KSvTDujfeglymYOPkJd3S3NxqODZvji6hSP7JEhFHsE=;
 b=CRkWmNYhhhp8pgSGRN47s3PZRrKHgH14q3zLFmN8Pp3EfgLGqqFdMno/3uKfWVCNEt7ht3
 kHi+IoHxPRDYPceb9Fhrs1uyFlvSjUFCoyRMzvWCyshvAIiRad5AJo22ooHt3DgNJKN75L
 1fwEOCPkclN1r5WMqwRY1iqJVdao/RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748886372;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KSvTDujfeglymYOPkJd3S3NxqODZvji6hSP7JEhFHsE=;
 b=+4+RFLBegUINr25L8Ed6EQvoGlz+hSsvpaf565uwFYpb2CHsloHanvpr9q3OgqhScSzK5K
 3Tuhdr4li45rawDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C16E13A63;
 Mon,  2 Jun 2025 17:46:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mFvAM2PjPWjCKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Jun 2025 17:46:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com, Alexey
 Perevalov <a.perevalov@samsung.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 02/13] migration/postcopy: Push blocktime start/end into
 page req mutex
In-Reply-To: <20250527231248.1279174-3-peterx@redhat.com>
References: <20250527231248.1279174-1-peterx@redhat.com>
 <20250527231248.1279174-3-peterx@redhat.com>
Date: Mon, 02 Jun 2025 14:46:09 -0300
Message-ID: <87seki3ula.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> The postcopy blocktime feature was tricky that it used quite some atomic
> operations over quite a few arrays and vars, without explaining how that
> would be thread safe.  The thread safety here is about concurrency between
> the fault thread and the fault resolution threads, possible to access the
> same chunk of data.  All these atomic ops can be expensive too before
> knowing clearly how it works.
>
> OTOH, postcopy has one page_request_mutex used to serialize the received
> bitmap updates.  So far it's ok - we don't yet have a lot of threads
> contending the lock.  It might change after multifd will be supported, but
> that's a separate story.  What is important is, with that mutex, it's
> pretty lightweight to move all the blocktime maintenance into the mutex
> critical section.  It's because the blocktime layer is lightweighted:
> almost "remember which vcpu faulted on which address", and "ok we get some
> fault resolved, calculate how long it takes".  It's also an optional
> feature for now (but I have thought of changing that, maybe in the future).
>
> Let's push the blocktime layer into the mutex, so that it's always
> thread-safe even without any atomic ops.
>
> To achieve that, I'll need to add a tid parameter on fault path so that
> it'll start to pass the faulted thread ID into deeper the stack, but not
> too deep.  When at it, add a comment for the shared fault handler (for
> example, vhost-user devices running with postcopy), to mention a TODO.  One
> reason it might not be trivial is that vhost-user's userfaultfds should be
> opened by vhost-user process, so it's pretty hard to control making sure
> the TID feature will be around.  It wasn't supported before, so keep it
> like that for now.
>
> Now we should be as ease when everything is protected by a mutex that we
> always take anyway.
>
> One side effect: we can finally remove one ramblock_recv_bitmap_test() in
> mark_postcopy_blocktime_begin(), which was pretty weird and which also
> includes a weird (but maybe necessary.. but maybe not?) operation to inject
> a blocktime entry then quickly erase it..  When we're with the mutex, and
> when we make sure it's invoked after checking the receive bitmap, it's not
> needed anymore.  Instead, we assert.
>
> As another side effect, this paves way for removing all atomic ops in all
> the mem accesses in blocktime layer.
>
> Note that we need a stub for mark_postcopy_blocktime_begin() for Windows
> builds.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

