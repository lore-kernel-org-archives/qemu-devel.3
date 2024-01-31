Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40CFC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 18:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVFae-00083m-8h; Wed, 31 Jan 2024 13:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVFab-00083U-Nf
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 13:45:38 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVFaa-0006Oy-02
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 13:45:37 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 019CE22020;
 Wed, 31 Jan 2024 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706726734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gb46ZMhhD2FwTd7h3CM7tms4fW5Y8ABiI5vMTwKrzoQ=;
 b=fW1VX+CSAjcD12nOAdLbWqorIPhx3W2RQK7gLhjn2kFHrH0N5Btn+0Ud7f5nmAgs4I4Z0O
 P9OwvxaV9spettFfHQ+nhTtWJVeazkumvHRP8Sqrz6ZaTk/2nAYlQK5Me2GN9uZzwOVf4X
 6rm5oguBqgD50ZGVG+P51H28d/1o/ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706726734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gb46ZMhhD2FwTd7h3CM7tms4fW5Y8ABiI5vMTwKrzoQ=;
 b=6fbmBXQeqsmYUz8KzfPGKtSfZcuE46U2FABiwgfIPlwgRjgukYmSHp7/I7v/G+Ua/P7eMJ
 M//sBXvMDnCfXcCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706726734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gb46ZMhhD2FwTd7h3CM7tms4fW5Y8ABiI5vMTwKrzoQ=;
 b=fW1VX+CSAjcD12nOAdLbWqorIPhx3W2RQK7gLhjn2kFHrH0N5Btn+0Ud7f5nmAgs4I4Z0O
 P9OwvxaV9spettFfHQ+nhTtWJVeazkumvHRP8Sqrz6ZaTk/2nAYlQK5Me2GN9uZzwOVf4X
 6rm5oguBqgD50ZGVG+P51H28d/1o/ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706726734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gb46ZMhhD2FwTd7h3CM7tms4fW5Y8ABiI5vMTwKrzoQ=;
 b=6fbmBXQeqsmYUz8KzfPGKtSfZcuE46U2FABiwgfIPlwgRjgukYmSHp7/I7v/G+Ua/P7eMJ
 M//sBXvMDnCfXcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F8D4139B1;
 Wed, 31 Jan 2024 18:45:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZCLcEU2VumWHTQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 31 Jan 2024 18:45:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Bryan Zhang <bryan.zhang@bytedance.com>, Prasad Pandit
 <ppandit@redhat.com>, peterx@redhat.com, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 06/14] migration/multifd: Separate SYNC request with
 normal jobs
In-Reply-To: <20240131103111.306523-7-peterx@redhat.com>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-7-peterx@redhat.com>
Date: Wed, 31 Jan 2024 15:45:31 -0300
Message-ID: <87r0hxjq9g.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> Multifd provide a threaded model for processing jobs.  On sender side,
> there can be two kinds of job: (1) a list of pages to send, or (2) a sync
> request.
>
> The sync request is a very special kind of job.  It never contains a page
> array, but only a multifd packet telling the dest side to synchronize with
> sent pages.
>
> Before this patch, both requests use the pending_job field, no matter what
> the request is, it will boost pending_job, while multifd sender thread will
> decrement it after it finishes one job.
>
> However this should be racy, because SYNC is special in that it needs to
> set p->flags with MULTIFD_FLAG_SYNC, showing that this is a sync request.
> Consider a sequence of operations where:
>
>   - migration thread enqueue a job to send some pages, pending_job++ (0->1)
>
>   - [...before the selected multifd sender thread wakes up...]
>
>   - migration thread enqueue another job to sync, pending_job++ (1->2),
>     setup p->flags=MULTIFD_FLAG_SYNC
>
>   - multifd sender thread wakes up, found pending_job==2
>     - send the 1st packet with MULTIFD_FLAG_SYNC and list of pages
>     - send the 2nd packet with flags==0 and no pages
>
> This is not expected, because MULTIFD_FLAG_SYNC should hopefully be done
> after all the pages are received.  Meanwhile, the 2nd packet will be
> completely useless, which contains zero information.
>
> I didn't verify above, but I think this issue is still benign in that at
> least on the recv side we always receive pages before handling
> MULTIFD_FLAG_SYNC.  However that's not always guaranteed and just tricky.
>
> One other reason I want to separate it is using p->flags to communicate
> between the two threads is also not clearly defined, it's very hard to read
> and understand why accessing p->flags is always safe; see the current impl
> of multifd_send_thread() where we tried to cache only p->flags.  It doesn't
> need to be that complicated.
>
> This patch introduces pending_sync, a separate flag just to show that the
> requester needs a sync.  Alongside, we remove the tricky caching of
> p->flags now because after this patch p->flags should only be used by
> multifd sender thread now, which will be crystal clear.  So it is always
> thread safe to access p->flags.
>
> With that, we can also safely convert the pending_job into a boolean,
> because we don't support >1 pending jobs anyway.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>


