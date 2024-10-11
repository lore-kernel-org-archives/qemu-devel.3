Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0684ED0EE19
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJSB-0008Kh-9F; Fri, 11 Oct 2024 13:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1szJRv-00089T-Ig
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:29:14 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1szJRu-0006FB-16
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:29:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 514B521A9A;
 Fri, 11 Oct 2024 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728667748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=97rDNKO5Hkg7bspbSWVuqyDTVHtATm436zImSqKJ8WI=;
 b=PK3HJlHQrBEtqG/Y1z3hb8yPKiWeVDCssHwnJeNCSSEEg/pCQHk1dKp5UrNnX6IANeM0WF
 fZy5PSc99C7GJF2NbiaTKb46DAfObMbBfc/sRA1aoC3pz1sqReD5t6CWUK2h5Gm4NxcqCm
 xit0nhdHSwENgfibMTE8S5P9x0lNSkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728667748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=97rDNKO5Hkg7bspbSWVuqyDTVHtATm436zImSqKJ8WI=;
 b=9GNvMTXXbyaj05YzkL6FX+sEsV0IYDNiXLkz45glfihoLIiGJ9oUdr2QtbbOUl43Q2luBT
 a6kZm4KKfV0nCUCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728667747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=97rDNKO5Hkg7bspbSWVuqyDTVHtATm436zImSqKJ8WI=;
 b=Dd+c8bstOTnf7uRIYoHeDYPRnBEMDfzGR2MEW/AuH94W7jQRlra4W/zJGo3+nk7Ib24MaQ
 SpuIw1IARWtpcgami42lZKGNKk+i1aZZzcY5f0m9p9yo5aiE8ATq55fe0WLO4QkKXyALcr
 7sr9bmdfFaF0lgUn3OFsk/TpdCKaTuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728667747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=97rDNKO5Hkg7bspbSWVuqyDTVHtATm436zImSqKJ8WI=;
 b=MqdIOCIn7xHNGxWl0xdDuemQFjggG2hN/R9VqRTX5ngWqh9D6FJRZOZ3Xv86fGRXNOgO7J
 h9WLEo6BjOCV6aBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBAEB1370C;
 Fri, 11 Oct 2024 17:29:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3mOhJGJgCWfPSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Oct 2024 17:29:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Yong Huang <yong.huang@smartx.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>
Subject: Re: [PATCH] migration: Put thread names together with macros
In-Reply-To: <20241011153652.517440-1-peterx@redhat.com>
References: <20241011153652.517440-1-peterx@redhat.com>
Date: Fri, 11 Oct 2024 14:29:04 -0300
Message-ID: <87v7xyr1jz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-2.99)[99.97%];
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

Peter Xu <peterx@redhat.com> writes:

> Keep migration thread names together, so it's easier to see a list of all
> possible migration threads.
>
> Still two functional changes below besides the macro defintions:
>
>   - There's one dirty rate thread that we overlooked before, now we add
>   that too and name it as "mig/dirtyrate" following the old rules.
>
>   - The old name "mig/src/rp-thr" has "-thr" but it may not be useful if
>   it's a thread name anyway, while "rp" can be slightly hard to read.
>   Taking this chance to rename it to "mig/src/return", hopefully a better
>   name.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

