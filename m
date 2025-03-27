Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF5AC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txo7J-0001PY-8u; Thu, 27 Mar 2025 10:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txo7I-0001PI-5O
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:21:56 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txo7F-0003ap-Gu
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:21:55 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B7DB21F792;
 Thu, 27 Mar 2025 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743085311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tF4iam6m+tlwvWiL+PJw0PpBX+OvYpTlqBN6fj+QCkg=;
 b=etnGlkkeF/73djvEO4Q+bDd9cfCafw89bkceQfyHvxCuHsWV/zBufttjLfp8NzpKfX4/dn
 9lqfBK7DGA02DaFpnceQZ45Zt4pYgHkn9utM+a/V5SuDU7ondaw/IdRUOJ3xQQZHotsmgC
 wmKTXXDUglZ4+8xIF2j52uCC0UQoCyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743085311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tF4iam6m+tlwvWiL+PJw0PpBX+OvYpTlqBN6fj+QCkg=;
 b=oYTYNE+E10PP5Y21umLlh4dUzO5CK+2ukDcGmjPZA9LHaYu0ufWt8yAwuragIc5AUhlWFO
 nKEqBaUk6pkiZOAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743085309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tF4iam6m+tlwvWiL+PJw0PpBX+OvYpTlqBN6fj+QCkg=;
 b=vnje8MG2Nz8hFqaSXYnVzcIw2PHH6z7NKeHLoKWcSABXM2Kio5cl/f2FHEma9QLeoIEyAu
 BHgolNP5z2kDroxb7A92zauOpHYoc8rcR9FyMEE0A2mgRJt0fyueXqZslMWEU+ers5Gryg
 oO1wcnudFSc7GcWOP8ZjctToAQx4pew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743085309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tF4iam6m+tlwvWiL+PJw0PpBX+OvYpTlqBN6fj+QCkg=;
 b=H90vf3vuMhLAESjn8bzW6d/jIqrhM8s/nITUe8EcD5MWLPcZb6EAi4DHwz2FIGxREFXV9y
 Su28EyQqbhYPVcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1C9C139D4;
 Thu, 27 Mar 2025 14:21:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4a1xIPxe5WdgYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 27 Mar 2025 14:21:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1] migration: cpr breaks SNP guest
In-Reply-To: <1743082598-428927-1-git-send-email-steven.sistare@oracle.com>
References: <1743082598-428927-1-git-send-email-steven.sistare@oracle.com>
Date: Thu, 27 Mar 2025 11:21:44 -0300
Message-ID: <87iknua70n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-2.71)[98.73%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, amd.com:email,
 suse.de:mid, oracle.com:email]
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

Steve Sistare <steven.sistare@oracle.com> writes:

> With aux-ram-share=off, booting an SNP guest fails with:
>
>   ../util/error.c:68: error_setv: Assertion `*errp == NULL' failed.
>
> This is because a CPR blocker for the guest_memfd ramblock is added
> twice, once in ram_block_add_cpr_blocker because aux-ram-share=off so
> rb->fd < 0, and once in ram_block_add for a specific guest_memfd blocker.
>
> To fix, add the guest_memfd blocker iff a generic one would not be
> added by ram_block_add_cpr_blocker.
>
> Fixes: 094a3dbc55df ("migration: ram block cpr blockers")
> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reported-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  system/physmem.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/system/physmem.c b/system/physmem.c
> index e97de3e..cfafb06 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1908,13 +1908,18 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>              goto out_free;
>          }
>  
> -        error_setg(&new_block->cpr_blocker,
> -                   "Memory region %s uses guest_memfd, "
> -                   "which is not supported with CPR.",
> -                   memory_region_name(new_block->mr));
> -        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
> -                                  MIG_MODE_CPR_TRANSFER,
> -                                  -1);
> +        /*
> +         * Add a specific guest_memfd blocker if a generic one would not be
> +         * added by ram_block_add_cpr_blocker.
> +         */
> +        if (new_block->fd >= 0 && qemu_ram_is_shared(new_block)) {

Can we avoid having two instances of the same condition that will need
to be kept in sync? What about:

/*
 * Preserving guest_memfd may be sufficient for CPR, but it has not
 * been tested yet.
 */
if (ram_is_cpr_compatible(new_block)) {
...

> +            error_setg(&new_block->cpr_blocker,
> +                       "Memory region %s uses guest_memfd, "
> +                       "which is not supported with CPR.",
> +                       memory_region_name(new_block->mr));
> +            migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
> +                                      MIG_MODE_CPR_TRANSFER, -1);
> +        }
>      }
>  
>      ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;

