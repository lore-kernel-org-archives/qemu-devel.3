Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389F5C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x91jL-0004Gk-0l; Tue, 22 Sep 2026 10:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x91jJ-0004GT-5a
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 10:44:21 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x91jH-0006R0-49
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 10:44:20 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5018C1FAC1;
 Tue, 22 Sep 2026 14:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790088250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pw8USIEt+QV7D5f0FohX0x87jI3XIAyNpk30JBzou8c=;
 b=l+5XsRdvMzZPDZ9jqp+wHNqCeLyYF0hfifhzwo3ESyBEGkL9Om8jcaKCidoflLz3i7uCf+
 JTWH4M9EMb0r8UpVsNH5l9yazN5bdChdvt+6u3rfRymNF7CcvcCl8Zr+Q7KMj6qe2IPvoO
 PNdUq9LcXvM/tU4G6NWvCunmC60mEcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790088250;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pw8USIEt+QV7D5f0FohX0x87jI3XIAyNpk30JBzou8c=;
 b=kc9pmmThfbeN8Xay0BJLKpNjWRaOGHfNgE1ZOR4bsyEXkAJ6LXpxpz9k0GZuBZrI0hhAMJ
 09KLlUrXGTBakXBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790088246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pw8USIEt+QV7D5f0FohX0x87jI3XIAyNpk30JBzou8c=;
 b=an4mUc0E5VmUBEMGREyZooptKptr1XZRaf3SlUIOIq04rDS9yJcaqCgqX//wSL7/cuLo1i
 uefzxCkD16nbU/qWsl1MBT+a93MGsJ2PwBgevHGI6LBVhkBwWb56a5Hfe7EEgfHvXRHjd2
 3RKNQoodZiPXgVSGJmGkZpIKskVjOV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790088246;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pw8USIEt+QV7D5f0FohX0x87jI3XIAyNpk30JBzou8c=;
 b=GMxYbDU3KNsL9d/81MGu5CzwZXpY5894q0zygdNvxWn2p5WQGnjQIRGSKIvWzusK6PB6B/
 D5hEkGFtJ9gziuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7A59136D9;
 Tue, 22 Sep 2026 14:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cvvTGjWUsmqzSQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 22 Sep 2026 14:44:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH 1/2] docs/migration: document that postcopy can be used
 with multifd
In-Reply-To: <20260915063719.89031-2-guobin@linux.alibaba.com>
References: <20260915063719.89031-1-guobin@linux.alibaba.com>
 <20260915063719.89031-2-guobin@linux.alibaba.com>
Date: Tue, 22 Sep 2026 11:44:03 -0300
Message-ID: <87se319wi4.fsf@suse.de>
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
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Bin Guo <guobin@linux.alibaba.com> writes:

> Since commit e27418861288 ("migration: enable multifd and postcopy
> together") in the 10.1 release, the multifd and postcopy-ram capabilities
> are no longer mutually exclusive, but the postcopy documentation does not
> mention multifd at all, leaving users unaware that the two features can be
> combined.
>
> Add a short section describing how they interact: multifd carries the
> pages of the precopy phase, the channels are flushed and synced before the
> switchover (because loading a page in a multifd receive thread is not
> atomic with regard to a running vCPU), and the postcopy phase itself does
> not use the multifd channels.
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  docs/devel/migration/postcopy.rst | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/docs/devel/migration/postcopy.rst b/docs/devel/migration/postcopy.rst
> index e319388d8f..570a3a1ce6 100644
> --- a/docs/devel/migration/postcopy.rst
> +++ b/docs/devel/migration/postcopy.rst
> @@ -294,6 +294,32 @@ the background migration channel.  Anyone who cares about latencies of page
>  faults during a postcopy migration should enable this feature.  By default,
>  it's not enabled.
>  
> +Postcopy with multifd
> +---------------------
> +
> +The ``multifd`` capability can be enabled together with ``postcopy-ram``
> +since the 10.1 QEMU release.  The two features apply to different phases of
> +the migration:
> +
> +  - During the precopy phase, guest pages are sent over the multifd channels
> +    as usual, so the initial RAM transfer can use all of them.
> +
> +  - Just before switching to postcopy, the source flushes and syncs the
> +    multifd channels.  This guarantees that all the pages already queued on
> +    those channels are loaded on the destination *before* the destination
> +    CPUs are started, which is required because loading a page in a multifd
> +    receive thread is not atomic with regard to a running vCPU.
> +
> +  - During the postcopy phase the multifd channels are no longer used for
> +    guest pages.  Both the background stream and the pages requested by the
> +    destination go through the background migration channel instead, or
> +    through the preempt channel for the requested pages when postcopy
> +    preemption is enabled.
> +
> +Consequently, multifd only speeds up the precopy phase of a postcopy
> +migration.  The bandwidth available once postcopy has started is the same as
> +without multifd.
> +
>  Postcopy blocktime statistics
>  -----------------------------

Looks good to me, I'll wait a bit to allow Peter to comment.

Acked-by: Fabiano Rosas <farosas@suse.de>

