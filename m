Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF98C5B555
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 20:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMBzq-0001lp-Kk; Mon, 02 Jun 2025 16:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMBzo-0001lb-Ee
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 16:43:01 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMBzm-0001X9-R1
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 16:43:00 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E57A211A1;
 Mon,  2 Jun 2025 20:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748896976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CeMZ4q3dS470/5gtdawA2Wl5kNnvhDp3yyNdenq2Lxs=;
 b=w5INRhg++3fCxfhAJJ8I3RfrcpwsHOzfBodM9t6Uejh5svc8/iBRjBlYkhg7OnXRJEsitA
 mdcl4cUNDbQ0UvuI781VoSTqJ52hKLsORke7DyHhr2+kqp4T6WckGNX2wU0wQqrfAqfgEk
 LJ832pxrTaBVIarql+kcy5y60+yqXUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748896976;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CeMZ4q3dS470/5gtdawA2Wl5kNnvhDp3yyNdenq2Lxs=;
 b=l2yYvnM6ofceLdT6KRCGlqDsj/sMyazF0wM30Mx+XPXKD1pZLnwLL+iwB8EoBGMApktNFL
 X7xua5raxM+1hbCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748896976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CeMZ4q3dS470/5gtdawA2Wl5kNnvhDp3yyNdenq2Lxs=;
 b=w5INRhg++3fCxfhAJJ8I3RfrcpwsHOzfBodM9t6Uejh5svc8/iBRjBlYkhg7OnXRJEsitA
 mdcl4cUNDbQ0UvuI781VoSTqJ52hKLsORke7DyHhr2+kqp4T6WckGNX2wU0wQqrfAqfgEk
 LJ832pxrTaBVIarql+kcy5y60+yqXUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748896976;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CeMZ4q3dS470/5gtdawA2Wl5kNnvhDp3yyNdenq2Lxs=;
 b=l2yYvnM6ofceLdT6KRCGlqDsj/sMyazF0wM30Mx+XPXKD1pZLnwLL+iwB8EoBGMApktNFL
 X7xua5raxM+1hbCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC8FC136C7;
 Mon,  2 Jun 2025 20:42:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fBrLKs8MPmhvXgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Jun 2025 20:42:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com, Alexey
 Perevalov <a.perevalov@samsung.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 04/13] migration/postcopy: Make all blocktime vars 64bits
In-Reply-To: <20250527231248.1279174-5-peterx@redhat.com>
References: <20250527231248.1279174-1-peterx@redhat.com>
 <20250527231248.1279174-5-peterx@redhat.com>
Date: Mon, 02 Jun 2025 17:42:52 -0300
Message-ID: <87msap50z7.fsf@suse.de>
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
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
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

> I am guessing it was used to be 32bits because of the atomic ops.  Now all
> the atomic ops are gone and we're protected by a mutex instead, it's ok we
> can switch to 64 bits.
>
> Reasons to move over:
>
>   - Allow further patches to change the unit from ms to us: with postcopy
>   preempt mode, we're really into hundreds of microseconds level on
>   blocktime.  We'd better be able to trap those.
>
>   - This also paves way for some other tricks that the original version
>   used to avoid overflows, e.g., start_time was almost only useful before
>   to make sure the sampled timestamp won't overflow a 32-bit field.
>
>   - This prepares further reports on top of existing data collected,
>   e.g. average page fault latencies.  When average operation is taken into
>   account, milliseconds are simply too coarse grained.
>
> When at it:
>
>   - Rename page_fault_vcpu_time to vcpu_blocktime_start.
>
>   - Rename vcpu_blocktime to vcpu_blocktime_total.
>
>   - Touch up the trace-events to not dump blocktime ctx pointer
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

