Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E156C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 16:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMUks-0008Mt-32; Tue, 03 Jun 2025 12:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMUkr-0008Mg-8z
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 12:44:49 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMUkp-0008R2-22
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 12:44:48 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F10B41F7B5;
 Tue,  3 Jun 2025 16:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748969084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DmWKErpKOD00PaTQco1qrV6p45G6mv+Rc9RNVcxyxIY=;
 b=G4oHusRe/9CxVnPP4PT703KmCgzU5R2u26bt+Wxhv5YR+/xOOATSZw46Ex9rwBE2wwz+pp
 Qwzyj9aUaah0MfAWr8+1kufc0+oI9h3nt4fVe7c7h9RtmVDB4WPNO6yI0eHiyBcojkhiVs
 VxMgMK2o2IVTQNw2eedq2SXuGPtNJwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748969084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DmWKErpKOD00PaTQco1qrV6p45G6mv+Rc9RNVcxyxIY=;
 b=8PKcK9EdiLBt5NQyihb7vp0WXxS0qF/6exqk7wRH13aKM1k8IzD1GVng50SQnbCR6RHoMw
 nueoeYwTOk39BEDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XrptCpJ+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=umtZfTpX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748969083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DmWKErpKOD00PaTQco1qrV6p45G6mv+Rc9RNVcxyxIY=;
 b=XrptCpJ+77aavBcZl8Ano4cPYCTv8uBTznltagTBGKt2Cmep4ugw7fwYpczqnF6FgjOqoV
 UuUNKiJiUj3TjqXTv86CMcGGHegVeBnmuZcWMUIyK2gF72rMc3VagkbDK157WdmDXUsvsf
 K+aHjYESUk1oP89ju7SWh0+4TNqzsCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748969083;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DmWKErpKOD00PaTQco1qrV6p45G6mv+Rc9RNVcxyxIY=;
 b=umtZfTpXGdFhQtvvTUmSLgIJv5yX7yfX/p1X3ejtkj6qq/0C+1gLBx+Nlt+8FptEILcPMi
 8FQu5s7Jp5qiHPCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C33513A1D;
 Tue,  3 Jun 2025 16:44:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i85+C3smP2hmTwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 16:44:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com, Alexey
 Perevalov <a.perevalov@samsung.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 12/13] migration/postcopy: Optimize blocktime fault
 tracking with hashtable
In-Reply-To: <20250527231248.1279174-13-peterx@redhat.com>
References: <20250527231248.1279174-1-peterx@redhat.com>
 <20250527231248.1279174-13-peterx@redhat.com>
Date: Tue, 03 Jun 2025 13:44:40 -0300
Message-ID: <87tt4w3hc7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: F10B41F7B5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

> Currently, the postcopy blocktime feature maintains vCPU fault information
> using an array (vcpu_addr[]).  It has two issues.
>
> Issue 1: Performance Concern
> ============================
>
> The old algorithm was almost OK and fast on inserts, except that the lookup
> is slow and won't scale if there are a lot of vCPUs: when a page is copied
> during postcopy, mark_postcopy_blocktime_end() will walk the whole array
> trying to find which vCPUs are blocked by the address.  So it needs
> constant O(N) walk for each page resolution.
>
> Alexey (the author of postcopy blocktime) mentioned the perf issue and how
> to optimize it in a piece of comment in the page resolution path.  The
> comment was (interestingly..) not complete, but it's relatively clear what
> he wanted to say about this perf issue.
>
> Issue 2: Wrong Accounting on re-entrancies
> ==========================================
>
> People might think that each vCPU should only and always get one fault at a
> time, so that when the blocktime layer captured one fault on one vCPU, we
> should never see another fault message on this vCPU.
>
> It's almost correct, except in some extreme rare cases.
>
> Case 1: it's possible the fault thread processes the userfaultfd messages
> too fast so it can see >1 messages on one vCPU before the previous one was
> resolved.
>
> Case 2: it's theoretically also possible one vCPU can get even more than
> one message on the same fault address if a fault is retried by the
> kernel (e.g., handle_userfault() got interrupted before page resolution).
>
> As this info might be important, instead of using commit message, I put
> more details into the code as comment, when introducing an array
> maintaining concurrent faults on one vCPU.  Please refer to the comments
> for details on both cases, especially case 1 which can be tricky.
>
> Case 1 sounds rare, but it can be easily reproduced locally for me when we
> run blocktime together with the migration-test on the vanilla postcopy.
>
> New Design
> ==========
>
> This patch should do almost what Alexey mentioned, but slightly
> differently: instead of having an array to maintain vCPU fault addresses,
> for each of the fault message we push a message into a hash, indexed by the
> fault address.
>
> With the hash, it can replace the old two structs: both the vcpu_addr[]
> array, and also the array to store the start time of the fault.  However
> due to above we need one more counter array to account concurrent faults on
> the same vCPU - that should even be needed in the old code, it's just that
> the old code was buggy and it will blindly overwrite an existing
> entry.. now we'll start to really track everything.
>
> The hash structure might be more efficient than tree to maintain such
> addr->(cpu, fault_time) information, so that the insert() and lookup()
> paths should ideally both be ~O(1).  After all, we do not need to sort.
>
> Here we need to do one remove() though after the lookup().  It could be
> slow but only if many vCPUs faulted exactly on the same address (so when
> the list of cpu entries is long), which should be unlikely. Even with that,
> it's still a worst case O(N) (consider 400 vCPUs faulted on the same
> address and how likely is it..) rather than a constant O(N) complexity.
>
> When at it, touch up the tracepoints to make them slightly more useful.
> One tracepoint is added when walking all the fault entries.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

