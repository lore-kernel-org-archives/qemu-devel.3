Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753AEC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 12:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnHbG-0007JP-HB; Thu, 21 Mar 2024 08:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rnHbF-0007JD-Cx
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 08:32:49 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rnHbD-0002Uy-Kb
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 08:32:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A17345CE2A;
 Thu, 21 Mar 2024 12:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711024364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUZu4t2HMv48gNjndZa3eeiKbo2Pmi4qcgTSr1XxWLk=;
 b=InpWAVDNR5r5KxJLD0vHf/h5hI8AU/h5x8UsIVQKB2uZ5YmNtXP6UdMso8+1Kof4+O6MMa
 IUmfzwfCdHuvzqqyxmE10ub1WjVF7D14uwzfOy/SX9foHXK3eP4t+ZpUyiURZEbYOnXtnq
 +IuSx0uvDSUspsHDujaj0ZLoOaX47TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711024364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUZu4t2HMv48gNjndZa3eeiKbo2Pmi4qcgTSr1XxWLk=;
 b=STv9g+D95ytCpcQBfJIBn9WE3NOsg/a+YWT0KIr1be/wY31Wsw1jDEG5dHiM1ipJLhc2QY
 MW2bOzkXv2vXaNBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711024364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUZu4t2HMv48gNjndZa3eeiKbo2Pmi4qcgTSr1XxWLk=;
 b=InpWAVDNR5r5KxJLD0vHf/h5hI8AU/h5x8UsIVQKB2uZ5YmNtXP6UdMso8+1Kof4+O6MMa
 IUmfzwfCdHuvzqqyxmE10ub1WjVF7D14uwzfOy/SX9foHXK3eP4t+ZpUyiURZEbYOnXtnq
 +IuSx0uvDSUspsHDujaj0ZLoOaX47TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711024364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUZu4t2HMv48gNjndZa3eeiKbo2Pmi4qcgTSr1XxWLk=;
 b=STv9g+D95ytCpcQBfJIBn9WE3NOsg/a+YWT0KIr1be/wY31Wsw1jDEG5dHiM1ipJLhc2QY
 MW2bOzkXv2vXaNBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22F4113976;
 Thu, 21 Mar 2024 12:32:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3VDRNuso/GU0SAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 21 Mar 2024 12:32:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH] migration/postcopy: Fix high frequency sync
In-Reply-To: <20240320214453.584374-1-peterx@redhat.com>
References: <20240320214453.584374-1-peterx@redhat.com>
Date: Thu, 21 Mar 2024 09:32:41 -0300
Message-ID: <878r2bn4t2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> On current code base I can observe extremely high sync count during
> precopy, as long as one enables postcopy-ram=on before switchover to
> postcopy.
>
> To provide some context of when we decide to do a full sync: we check
> must_precopy (which implies "data must be sent during precopy phase"), and
> as long as it is lower than the threshold size we calculated (out of
> bandwidth and expected downtime) we will kick off the slow sync.
>
> However, when postcopy is enabled (even if still during precopy phase), RAM
> only reports all pages as can_postcopy, and report must_precopy==0.  Then
> "must_precopy <= threshold_size" mostly always triggers and enforces a slow
> sync for every call to migration_iteration_run() when postcopy is enabled
> even if not used.  That is insane.
>
> It turns out it was a regress bug introduced in the previous refactoring in
> QEMU 8.0 in late 2022. Fix this by checking the whole RAM size rather than
> must_precopy, like before.  Not copy stable yet as many things changed, and
> even if this should be a major performance regression, no functional change
> has observed (and that's also probably why nobody found it).  I only notice
> this when looking for another bug reported by Nina.
>
> When at it, cleanup a little bit on the lines around.
>
> Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Fixes: c8df4a7aef ("migration: Split save_live_pending() into state_pending_*")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> ---
>
> Nina: I copied you only because this might still be relevant, as this issue
> also misteriously points back to c8df4a7aef..  However I don't think it
> should be a fix of your problem, at most it can change the possibility of
> reproducability.
>
> This is not a regression for this release, but I still want to have it for
> 9.0.  Fabiano, any opinions / objections?

Go for it.

> ---
>  migration/migration.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 047b6b49cf..9fe8fd2afd 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3199,17 +3199,16 @@ typedef enum {
>   */
>  static MigIterateState migration_iteration_run(MigrationState *s)
>  {
> -    uint64_t must_precopy, can_postcopy;
> +    uint64_t must_precopy, can_postcopy, pending_size;
>      Error *local_err = NULL;
>      bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
>      bool can_switchover = migration_can_switchover(s);
>  
>      qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
> -    uint64_t pending_size = must_precopy + can_postcopy;
> -
> +    pending_size = must_precopy + can_postcopy;
>      trace_migrate_pending_estimate(pending_size, must_precopy, can_postcopy);
>  
> -    if (must_precopy <= s->threshold_size) {
> +    if (pending_size < s->threshold_size) {
>          qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
>          pending_size = must_precopy + can_postcopy;
>          trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);

