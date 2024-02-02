Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0176EC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 19:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVz6G-0007CY-JZ; Fri, 02 Feb 2024 14:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVz6F-0007Bx-7e
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:21:19 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVz6D-0006uf-97
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:21:18 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7ACF21F78C;
 Fri,  2 Feb 2024 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706901675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ID9BqHT7EguY50EL68PYvz9N3Yh63osxYiMsZe2FJ80=;
 b=BS/doIEEC6uoPcX7xYa2h2LRWh19sIjM4gJktA/uUeT6r2XQ50xj+Gy9Gco4ivhFufU52Q
 DQQqLI6G2KwD+iiac/fCd1Qgz0HMfIX3QD/OTovZZt6lEtLr4O+ggciKMfXRyr4iBhbria
 3nrl0lOIyqlFW99jBkkfEWtTha7ybRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706901675;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ID9BqHT7EguY50EL68PYvz9N3Yh63osxYiMsZe2FJ80=;
 b=yJRhz7WR//r01d15fWWsUHyXZbGYiRDyQ8KRYS/xTtjWOVkZwHb+ViOIMMXnNwxyxIJZcP
 h441nN1G+IGEZbBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706901675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ID9BqHT7EguY50EL68PYvz9N3Yh63osxYiMsZe2FJ80=;
 b=BS/doIEEC6uoPcX7xYa2h2LRWh19sIjM4gJktA/uUeT6r2XQ50xj+Gy9Gco4ivhFufU52Q
 DQQqLI6G2KwD+iiac/fCd1Qgz0HMfIX3QD/OTovZZt6lEtLr4O+ggciKMfXRyr4iBhbria
 3nrl0lOIyqlFW99jBkkfEWtTha7ybRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706901675;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ID9BqHT7EguY50EL68PYvz9N3Yh63osxYiMsZe2FJ80=;
 b=yJRhz7WR//r01d15fWWsUHyXZbGYiRDyQ8KRYS/xTtjWOVkZwHb+ViOIMMXnNwxyxIJZcP
 h441nN1G+IGEZbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06130139AB;
 Fri,  2 Feb 2024 19:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9mvDL6pAvWWjZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 19:21:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>, Bryan Zhang
 <bryan.zhang@bytedance.com>, peterx@redhat.com, Avihai Horon
 <avihaih@nvidia.com>, Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH v2 06/23] migration/multifd: Separate SYNC request with
 normal jobs
In-Reply-To: <20240202102857.110210-7-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-7-peterx@redhat.com>
Date: Fri, 02 Feb 2024 16:21:11 -0300
Message-ID: <87ttmqhdug.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="BS/doIEE";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yJRhz7WR
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-3.00)[100.00%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7ACF21F78C
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
> Always use atomic ops to access both flags to make sure no cache effect.
> When at it, drop the initial setting of "pending_job = 0" because it's
> always allocated using g_new0().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

