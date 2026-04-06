Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6699DE9D834
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 13:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9kK3-0006RX-EP; Mon, 06 Apr 2026 09:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w9kJy-0006Ov-8s
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 09:48:55 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w9kJu-0002Tc-T1
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 09:48:53 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8DF6B5BD83;
 Mon,  6 Apr 2026 13:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775483327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MGhV+DM8l4q24/4viM7mYSQZ0nRIQoI6WD5FWdpZ8Wo=;
 b=bBCLDhk0FiyCmftza1EG5GN/zJizSQixOZyrxiZbZh5C5t4HV5C94h43TsceWUz/Va0B/q
 NO5caSF4qI4sjsfGvq4Oo1oHDjWlI1jybyFpwlXODr2MMl5H6QwHXa05Xilwfdcnb4doNg
 Ac7APfn3IWXXDntONYTlXAAuyABWybQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775483327;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MGhV+DM8l4q24/4viM7mYSQZ0nRIQoI6WD5FWdpZ8Wo=;
 b=LWPlqLZ9QeI5+fetFcossm943po50DDaZQ+8f9hxjoCcQ6CkRcd7Y6JXC4ihPNDMDddkda
 7rw/YmrXpmzICyDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775483327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MGhV+DM8l4q24/4viM7mYSQZ0nRIQoI6WD5FWdpZ8Wo=;
 b=bBCLDhk0FiyCmftza1EG5GN/zJizSQixOZyrxiZbZh5C5t4HV5C94h43TsceWUz/Va0B/q
 NO5caSF4qI4sjsfGvq4Oo1oHDjWlI1jybyFpwlXODr2MMl5H6QwHXa05Xilwfdcnb4doNg
 Ac7APfn3IWXXDntONYTlXAAuyABWybQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775483327;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MGhV+DM8l4q24/4viM7mYSQZ0nRIQoI6WD5FWdpZ8Wo=;
 b=LWPlqLZ9QeI5+fetFcossm943po50DDaZQ+8f9hxjoCcQ6CkRcd7Y6JXC4ihPNDMDddkda
 7rw/YmrXpmzICyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D2BA4A0B0;
 Mon,  6 Apr 2026 13:48:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OvyfML6502mnTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 06 Apr 2026 13:48:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] runstate: allow inmigrate -> debug transition on
 snapshot restore
In-Reply-To: <20260402194314.20104-1-viking4@gmail.com>
References: <20260402194314.20104-1-viking4@gmail.com>
Date: Mon, 06 Apr 2026 10:48:44 -0300
Message-ID: <87ecks5hdv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,linaro.org];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email, gitlab.com:url,
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

Trieu Huynh <vikingtc4@gmail.com> writes:

> From: Trieu Huynh <vikingtc4@gmail.com>
>
> When a VM snapshot is taken while the guest is paused by a gdbstub
> (RUN_STATE_DEBUG), the saved runstate is 'debug', for instance:
>   (gdb) monitor info status
>   VM status: paused (debug)
>
> On restore, the destination starts in 'inmigrate' and transitions
> to the saved runstate, but the 'inmigrate -> debug' transition
> was missing from the table, causing an abort:
>
>   $ ./qemu-system-x86_64 -machine pc,accel=kvm:tcg  -m 128M
>   -display none -gdb tcp::1235 -incoming "exec:cat /tmp/snap.img"
>   > /tmp/qemu-restore.log 2>&1
>   Aborted (core dumped)
>   $ cat /tmp/qemu-restore.log
>   qemu-system-x86_64: invalid runstate transition: 'inmigrate'
>   -> 'debug'
>
> Fix it by adding the missing one (Point out by the author
> Dustin Spicuzza)
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1231

(note to self: stop giving time estimates)

>
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>

I think this is reasonable as a standalone change:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

As I mentioned in the Gitlab issue, it raises the question of whether
there's more to be done in terms of migrating the gdbstub
connection. Probably too niche of an use-case?

> ---
>  system/runstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/system/runstate.c b/system/runstate.c
> index 2d4e95a216..97a6a1c736 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -94,6 +94,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_INMIGRATE, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_INMIGRATE, RUN_STATE_POSTMIGRATE },
>      { RUN_STATE_INMIGRATE, RUN_STATE_COLO },
> +    { RUN_STATE_INMIGRATE, RUN_STATE_DEBUG },
>  
>      { RUN_STATE_INTERNAL_ERROR, RUN_STATE_PAUSED },
>      { RUN_STATE_INTERNAL_ERROR, RUN_STATE_FINISH_MIGRATE },

