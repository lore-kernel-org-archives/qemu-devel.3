Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27851C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 18:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdaED-0002cl-6F; Mon, 12 Aug 2024 14:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sdaEA-0002bY-Vz
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:57:11 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sdaE8-0002Jw-EA
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:57:10 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 608E41FB9C;
 Mon, 12 Aug 2024 18:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723489023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bq9fDkFV3A62pYLn1ThkJh0886bFE2n4HE9TogpVi6c=;
 b=nZUTVy+LgygNtnlQj0IXdAXFpgxWX98YXzKT2l1LYuEoQhYZClHXYLkLFtTB2eD7WPdfgm
 X5G3ctwtAttsnLepF4SkmCtch3c4mN2uIPZNaXA8dzSLTgcJrYsfJEJI3jrGdUlop2/spj
 znl871Va8pure5A0R9BzTLClPXGXLto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723489023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bq9fDkFV3A62pYLn1ThkJh0886bFE2n4HE9TogpVi6c=;
 b=sqRtwP3ph+3o6i2SFmaFKnZ9VwAcuA71PvNZQLehuCgyHTEHWItFoYV8lu6wQZmcmalHt/
 Zlq3B+Qk6t5mwRCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723489023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bq9fDkFV3A62pYLn1ThkJh0886bFE2n4HE9TogpVi6c=;
 b=nZUTVy+LgygNtnlQj0IXdAXFpgxWX98YXzKT2l1LYuEoQhYZClHXYLkLFtTB2eD7WPdfgm
 X5G3ctwtAttsnLepF4SkmCtch3c4mN2uIPZNaXA8dzSLTgcJrYsfJEJI3jrGdUlop2/spj
 znl871Va8pure5A0R9BzTLClPXGXLto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723489023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bq9fDkFV3A62pYLn1ThkJh0886bFE2n4HE9TogpVi6c=;
 b=sqRtwP3ph+3o6i2SFmaFKnZ9VwAcuA71PvNZQLehuCgyHTEHWItFoYV8lu6wQZmcmalHt/
 Zlq3B+Qk6t5mwRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDAD113983;
 Mon, 12 Aug 2024 18:57:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GlimKP5aumZDYgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 12 Aug 2024 18:57:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, Eugenio Perez Martin
 <eperezma@redhat.com>, Peter Xu <peterx@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [RFC V1 2/7] migration: skip dirty memory tracking for cpr
In-Reply-To: <1720792931-456433-3-git-send-email-steven.sistare@oracle.com>
References: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
 <1720792931-456433-3-git-send-email-steven.sistare@oracle.com>
Date: Mon, 12 Aug 2024 15:57:00 -0300
Message-ID: <87mslhfu2r.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> CPR preserves memory in place, so there is no need to track dirty memory.
> By skipping it, CPR can support devices that do not support tracking.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  system/memory.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/system/memory.c b/system/memory.c
> index b7548bf112..aef584e638 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -27,6 +27,7 @@
>  
>  #include "exec/memory-internal.h"
>  #include "exec/ram_addr.h"
> +#include "migration/misc.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/tcg.h"
> @@ -2947,6 +2948,11 @@ bool memory_global_dirty_log_start(unsigned int flags, Error **errp)
>  
>      assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
>  
> +    /* CPR preserves memory in place, so no need to track dirty memory */
> +    if (migrate_mode() != MIG_MODE_NORMAL) {
> +        return true;
> +    }

How this interacts with DIRTY_RATE and DIRTY_LIMIT? The former at least
seems to never overlap with CPR, right? I'm wondering whether this check
would be more appropriate up in ram.c along with the similar
migrate_background_snapshot() check.

(I wish we had made the global_dirty_log_change() function a bit more
flexible. It would have been a nice place to put this and the snapshot
check. Not worth the risk of changing it now...)

Also, not tracking dirty memory implies also not doing the bitmap sync?
We skip it for bg_snapshot, but not for CPR.

> +
>      if (vmstate_change) {
>          /* If there is postponed stop(), operate on it first */
>          postponed_stop_flags &= ~flags;
> @@ -3021,6 +3027,11 @@ static void memory_vm_change_state_handler(void *opaque, bool running,
>  
>  void memory_global_dirty_log_stop(unsigned int flags)
>  {
> +    /* CPR preserves memory in place, so no need to track dirty memory */
> +    if (migrate_mode() != MIG_MODE_NORMAL) {
> +        return;
> +    }
> +
>      if (!runstate_is_running()) {
>          /* Postpone the dirty log stop, e.g., to when VM starts again */
>          if (vmstate_change) {

