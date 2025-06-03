Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8949C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTwi-0000Q6-29; Tue, 03 Jun 2025 11:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMTwf-0000Pd-Vg
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:52:58 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMTwb-0002UB-UR
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:52:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 92C1521244;
 Tue,  3 Jun 2025 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748965971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2WLkQFKHHgWU0g3oo21/XmHyBtdTDqLKHTmf6qMC9k=;
 b=gOTdp4tPMKteLV3hdvILMltG0NwcrU1ee7xTtTMGPdmQPPkhx39lgcOhXQX1iCeVl5AB5F
 QZdBrcvOLiE0G+uE6cGuJ4aiMcpY/mpFIk1JwmVipJ1ZiVM1Kyyh6tG+gqkH+L7kIz6feX
 XNQola42QM0q9fv4jrR8qG591fRn19w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748965971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2WLkQFKHHgWU0g3oo21/XmHyBtdTDqLKHTmf6qMC9k=;
 b=nxCXdp/cNWAfMGxy0Pu49RfQ3A2Xggm0UbpshYJwN9p/oTzjwKfakVg7+qmaG0I4gt/zE6
 PZ3SV0n+88e77GBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748965971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2WLkQFKHHgWU0g3oo21/XmHyBtdTDqLKHTmf6qMC9k=;
 b=gOTdp4tPMKteLV3hdvILMltG0NwcrU1ee7xTtTMGPdmQPPkhx39lgcOhXQX1iCeVl5AB5F
 QZdBrcvOLiE0G+uE6cGuJ4aiMcpY/mpFIk1JwmVipJ1ZiVM1Kyyh6tG+gqkH+L7kIz6feX
 XNQola42QM0q9fv4jrR8qG591fRn19w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748965971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2WLkQFKHHgWU0g3oo21/XmHyBtdTDqLKHTmf6qMC9k=;
 b=nxCXdp/cNWAfMGxy0Pu49RfQ3A2Xggm0UbpshYJwN9p/oTzjwKfakVg7+qmaG0I4gt/zE6
 PZ3SV0n+88e77GBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1319413A92;
 Tue,  3 Jun 2025 15:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tQiAMVIaP2g1PwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 15:52:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com, Alexey
 Perevalov <a.perevalov@samsung.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 05/13] migration/postcopy: Drop
 PostcopyBlocktimeContext.start_time
In-Reply-To: <20250527231248.1279174-6-peterx@redhat.com>
References: <20250527231248.1279174-1-peterx@redhat.com>
 <20250527231248.1279174-6-peterx@redhat.com>
Date: Tue, 03 Jun 2025 12:52:48 -0300
Message-ID: <87h60w4yb3.fsf@suse.de>
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
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
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

> Now with 64bits, the offseting using start_time is not needed anymore,
> because the array can always remember the whole timestamp.
>
> Then drop the unused parameter in get_low_time_offset() altogether.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/postcopy-ram.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 72f9075e69..c6ae4b650c 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -123,7 +123,6 @@ typedef struct PostcopyBlocktimeContext {
>      uint64_t last_begin;
>      /* number of vCPU are suspended */
>      int smp_cpus_down;
> -    uint64_t start_time;
>  
>      /*
>       * Handler for exit event, necessary for
> @@ -157,7 +156,6 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
>      ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
>      ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
>      ctx->exit_notifier.notify = migration_exit_cb;
> -    ctx->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      qemu_add_exit_notifier(&ctx->exit_notifier);
>  
>      return ctx;
> @@ -818,9 +816,9 @@ static int get_mem_fault_cpu_index(uint32_t pid)
>      return -1;
>  }
>  
> -static uint64_t get_low_time_offset(PostcopyBlocktimeContext *dc)
> +static uint64_t get_low_time_offset(void)
>  {
> -    return (uint64_t)qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - dc->start_time;
> +    return (uint64_t)qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>  }

Looking at this and the previous patch, this not "low" anymore, i.e.,
not the lower 32 bits of a 64 bit value. This function and related
variables should be renamed.

>  
>  /*
> @@ -847,7 +845,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
>          return;
>      }
>  
> -    low_time_offset = get_low_time_offset(dc);
> +    low_time_offset = get_low_time_offset();
>      if (dc->vcpu_addr[cpu] == 0) {
>          dc->smp_cpus_down++;
>      }
> @@ -907,7 +905,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
>          return;
>      }
>  
> -    low_time_offset = get_low_time_offset(dc);
> +    low_time_offset = get_low_time_offset();
>      /* lookup cpu, to clear it,
>       * that algorithm looks straightforward, but it's not
>       * optimal, more optimal algorithm is keeping tree or hash

