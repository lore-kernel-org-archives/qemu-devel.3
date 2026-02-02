Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CC8E7DEEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvWC-000568-0B; Mon, 02 Feb 2026 10:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmvWA-00055d-EF
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:07:10 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmvW8-0006LK-Hh
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:07:10 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3F09A3E744;
 Mon,  2 Feb 2026 15:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770044826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bquts6XAnlp1XSljPGcWWWyDcm+PIUOgt6n3nCep+pg=;
 b=i3TOrSBIOADHXHlauhm9wzuLUFkx5hjYxgGqZVGo15zhSvfhUa/tjKFdHuWx36ffRmFJHA
 ER19vylid1D+BRqHYi9r9j5EWswM+omCGNVg0Q/dnBOBMt+rFaODGEejcNEvju6oNgcGlD
 f7qIPFQr86aCIbtT8pY5eRRxo/ghtzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770044826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bquts6XAnlp1XSljPGcWWWyDcm+PIUOgt6n3nCep+pg=;
 b=U20Wzx4F+WLtaARsiJUN7RCnh+Ga2AjaAljyjJ3G1PWotYm5XQKnciw5lSeZqeImv46wgj
 TnLvm4RwMi8A4xCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770044826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bquts6XAnlp1XSljPGcWWWyDcm+PIUOgt6n3nCep+pg=;
 b=i3TOrSBIOADHXHlauhm9wzuLUFkx5hjYxgGqZVGo15zhSvfhUa/tjKFdHuWx36ffRmFJHA
 ER19vylid1D+BRqHYi9r9j5EWswM+omCGNVg0Q/dnBOBMt+rFaODGEejcNEvju6oNgcGlD
 f7qIPFQr86aCIbtT8pY5eRRxo/ghtzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770044826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bquts6XAnlp1XSljPGcWWWyDcm+PIUOgt6n3nCep+pg=;
 b=U20Wzx4F+WLtaARsiJUN7RCnh+Ga2AjaAljyjJ3G1PWotYm5XQKnciw5lSeZqeImv46wgj
 TnLvm4RwMi8A4xCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAB993EA62;
 Mon,  2 Feb 2026 15:07:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bYD2Gpm9gGmmSAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 15:07:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 20/24] migration: Introduce qemu_savevm_state_active()
In-Reply-To: <20260127185254.3954634-21-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
 <20260127185254.3954634-21-peterx@redhat.com>
Date: Mon, 02 Feb 2026 12:07:03 -0300
Message-ID: <874inzrxpk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[web.de]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> Introduce this helper to detect if a SaveStateEntry is active.
>
> Note that this helper can actually also be used in loadvm paths, but let's
> stick with this name for now because we still use SaveStateEntry for the
> shared structure that both savevm/loadvm uses, where this name still suites.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/savevm.c | 63 ++++++++++++++++++++--------------------------
>  1 file changed, 27 insertions(+), 36 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b04a21ffc9..c16951b532 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1071,6 +1071,16 @@ void qemu_savevm_state_end(QEMUFile *f)
>      qemu_put_byte(f, QEMU_VM_EOF);
>  }
>  
> +static inline bool qemu_savevm_state_active(SaveStateEntry *se)
> +{
> +    /* When no is_active() hook, always treat it as ACTIVE */
> +    if (!se->ops->is_active) {
> +        return true;
> +    }
> +
> +    return se->ops->is_active(se->opaque);
> +}
> +
>  /**
>   * qemu_savevm_command_send: Send a 'QEMU_VM_COMMAND' type element with the
>   *                           command and associated data.
> @@ -1352,12 +1362,9 @@ int qemu_savevm_state_prepare(Error **errp)
>          if (!se->ops || !se->ops->save_prepare) {
>              continue;
>          }
> -        if (se->ops->is_active) {
> -            if (!se->ops->is_active(se->opaque)) {
> -                continue;
> -            }
> +        if (!qemu_savevm_state_active(se)) {
> +            continue;
>          }
> -
>          ret = se->ops->save_prepare(se->opaque, errp);
>          if (ret < 0) {
>              return ret;
> @@ -1397,10 +1404,8 @@ static int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
>          if (!se->ops || !se->ops->save_setup) {
>              continue;
>          }
> -        if (se->ops->is_active) {
> -            if (!se->ops->is_active(se->opaque)) {
> -                continue;
> -            }
> +        if (!qemu_savevm_state_active(se)) {
> +            continue;
>          }
>          save_section_header(f, se, QEMU_VM_SECTION_START);
>          ret = se->ops->save_setup(f, se->opaque, errp);
> @@ -1450,10 +1455,8 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
>          if (!se->ops || !se->ops->resume_prepare) {
>              continue;
>          }
> -        if (se->ops->is_active) {
> -            if (!se->ops->is_active(se->opaque)) {
> -                continue;
> -            }
> +        if (!qemu_savevm_state_active(se)) {
> +            continue;
>          }
>          ret = se->ops->resume_prepare(s, se->opaque);
>          if (ret < 0) {
> @@ -1481,8 +1484,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
>          if (!se->ops || !se->ops->save_live_iterate) {
>              continue;
>          }
> -        if (se->ops->is_active &&
> -            !se->ops->is_active(se->opaque)) {
> +        if (!qemu_savevm_state_active(se)) {
>              continue;
>          }
>          if (se->ops->is_active_iterate &&
> @@ -1543,10 +1545,8 @@ static int qemu_savevm_complete(SaveStateEntry *se, QEMUFile *f)
>  {
>      int ret;
>  
> -    if (se->ops->is_active) {
> -        if (!se->ops->is_active(se->opaque)) {
> -            return 0;
> -        }
> +    if (!qemu_savevm_state_active(se)) {
> +        return 0;
>      }
>  
>      trace_savevm_section_start(se->idstr, se->section_id);
> @@ -1596,10 +1596,8 @@ bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp)
>              continue;
>          }
>  
> -        if (se->ops->is_active) {
> -            if (!se->ops->is_active(se->opaque)) {
> -                continue;
> -            }
> +        if (!qemu_savevm_state_active(se)) {
> +            continue;
>          }
>  
>          trace_savevm_section_start(se->idstr, se->section_id);
> @@ -1785,10 +1783,8 @@ void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
>          if (!se->ops || !se->ops->state_pending_estimate) {
>              continue;
>          }
> -        if (se->ops->is_active) {
> -            if (!se->ops->is_active(se->opaque)) {
> -                continue;
> -            }
> +        if (!qemu_savevm_state_active(se)) {
> +            continue;
>          }
>          se->ops->state_pending_estimate(se->opaque, must_precopy, can_postcopy);
>      }
> @@ -1806,10 +1802,8 @@ void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
>          if (!se->ops || !se->ops->state_pending_exact) {
>              continue;
>          }
> -        if (se->ops->is_active) {
> -            if (!se->ops->is_active(se->opaque)) {
> -                continue;
> -            }
> +        if (!qemu_savevm_state_active(se)) {
> +            continue;
>          }
>          se->ops->state_pending_exact(se->opaque, must_precopy, can_postcopy);
>      }
> @@ -2829,12 +2823,9 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
>          if (!se->ops || !se->ops->load_setup) {
>              continue;
>          }
> -        if (se->ops->is_active) {
> -            if (!se->ops->is_active(se->opaque)) {
> -                continue;
> -            }
> +        if (!qemu_savevm_state_active(se)) {
> +            continue;
>          }
> -
>          ret = se->ops->load_setup(f, se->opaque, errp);
>          if (ret < 0) {
>              error_prepend(errp, "Load state of device %s failed: ",

Reviewed-by: Fabiano Rosas <farosas@suse.de>

