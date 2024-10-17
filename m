Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48773D3C530
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 20:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1XDe-0001yG-5U; Thu, 17 Oct 2024 16:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1XDd-0001y7-2j
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 16:35:37 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1XDb-0007aP-6A
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 16:35:36 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EAEC21F451;
 Thu, 17 Oct 2024 20:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729197333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGvje779wjcgbzJ/GjFcUN5JHM3JUUrMWiS7F4f1FGM=;
 b=GWnU2nTHfZZ7gANAcxhOhp3dfXNT65pooypgb3vE8HkKx4MM37g+L+OuGkXzGz6BeaDMeQ
 K2+Ls/+L/YWXaeWT4/M1C7u400SwwjGCGv7kU5TEeQhl3lwDAB44FVZ6wRHKaoblcpZTpZ
 idZDrQvE61u9RLVfeSedCfeqG8XUDk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729197333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGvje779wjcgbzJ/GjFcUN5JHM3JUUrMWiS7F4f1FGM=;
 b=8epxWMxyk7x2EgcRgGvP3bVDfDW0to7GlBmBv1U/fQOPlWEZ7trvxlhdXebzDxMzQhuQRt
 dVi1FU7lNkA2JxBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="I/xoArwd";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gLkRQ2Y6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729197332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGvje779wjcgbzJ/GjFcUN5JHM3JUUrMWiS7F4f1FGM=;
 b=I/xoArwd3STLMQb6vYC3QxPeLzYzSgfy4SQYBDgR4M7LC1k8m/c8BrBt0LrbH/YD6K4DQh
 o/MT+JV8qPDNrurnfAecQUPeQEiiJZoLSF2b8rS+TKqQEPm9xQMsPVn6AdclVg+fAC3MFE
 KkGrb5hp9CMcALVSm6i3FJ3SYpScihQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729197332;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGvje779wjcgbzJ/GjFcUN5JHM3JUUrMWiS7F4f1FGM=;
 b=gLkRQ2Y61I+tJZwJpOfSBDFDqma6PPCu40pdLbKWFseR7UgE/b6qMxUoAlsMAb/ZtqMNHZ
 GS/DvfIhtWx8fvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6973813A53;
 Thu, 17 Oct 2024 20:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qSwJDBR1EWecDAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Oct 2024 20:35:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 5/6] migration: Support periodic RAMBlock dirty
 bitmap sync
In-Reply-To: <ZxFmnZqgRlGaQax_@x1n>
References: <cover.1729146786.git.yong.huang@smartx.com>
 <f61f1b3653f2acf026901103e1c73d157d38b08f.1729146786.git.yong.huang@smartx.com>
 <ZxFmnZqgRlGaQax_@x1n>
Date: Thu, 17 Oct 2024 17:35:29 -0300
Message-ID: <874j5a31ta.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: EAEC21F451
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Thu, Oct 17, 2024 at 02:42:54PM +0800, yong.huang@smartx.com wrote:
>> +void cpu_throttle_dirty_sync_timer_tick(void *opaque)
>> +{
>> +    static uint64_t prev_sync_cnt;
>
> We may need to reset this in case migration got cancelled and invoked
> again, to make sure it keeps working in the 2nd run.
>
>> +    uint64_t sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
>> +
>> +    /*
>> +     * The first iteration copies all memory anyhow and has no
>> +     * effect on guest performance, therefore omit it to avoid
>> +     * paying extra for the sync penalty.
>> +     */
>> +    if (sync_cnt <= 1) {
>> +        goto end;
>> +    }
>> +
>> +    if (sync_cnt == prev_sync_cnt) {
>> +        trace_cpu_throttle_dirty_sync();
>> +        WITH_RCU_READ_LOCK_GUARD() {
>> +            migration_bitmap_sync_precopy(false);
>> +        }
>> +    }
>> +
>> +end:
>> +    prev_sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
>> +
>> +    timer_mod(throttle_dirty_sync_timer,
>> +        qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
>> +            CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS);
>> +}
>
> Please both of you have a look on whether you agree I squash below into
> this patch when merge:
>
> ===8<===
> From 84a2544eab73e35dbd35fed3b1440169915f9aa4 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Thu, 17 Oct 2024 15:27:19 -0400
> Subject: [PATCH] fixup! migration: Support periodic RAMBlock dirty bitmap sync
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/cpu-throttle.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> index 342681cdd4..3df287d8d3 100644
> --- a/migration/cpu-throttle.c
> +++ b/migration/cpu-throttle.c
> @@ -36,6 +36,7 @@
>  static QEMUTimer *throttle_timer, *throttle_dirty_sync_timer;
>  static unsigned int throttle_percentage;
>  static bool throttle_dirty_sync_timer_active;
> +static uint64_t throttle_dirty_sync_count_prev;
>  
>  #define CPU_THROTTLE_PCT_MIN 1
>  #define CPU_THROTTLE_PCT_MAX 99
> @@ -133,7 +134,6 @@ int cpu_throttle_get_percentage(void)
>  
>  void cpu_throttle_dirty_sync_timer_tick(void *opaque)
>  {
> -    static uint64_t prev_sync_cnt;
>      uint64_t sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
>  
>      /*
> @@ -145,7 +145,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
>          goto end;
>      }
>  
> -    if (sync_cnt == prev_sync_cnt) {
> +    if (sync_cnt == throttle_dirty_sync_count_prev) {
>          trace_cpu_throttle_dirty_sync();
>          WITH_RCU_READ_LOCK_GUARD() {
>              migration_bitmap_sync_precopy(false);
> @@ -153,7 +153,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
>      }
>  
>  end:
> -    prev_sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
> +    throttle_dirty_sync_count_prev = stat64_get(&mig_stats.dirty_sync_count);
>  
>      timer_mod(throttle_dirty_sync_timer,
>          qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
> @@ -171,6 +171,11 @@ void cpu_throttle_dirty_sync_timer(bool enable)
>  
>      if (enable) {
>          if (!cpu_throttle_dirty_sync_active()) {
> +            /*
> +             * Always reset the dirty sync count cache, in case migration
> +             * was cancelled once.
> +             */
> +            throttle_dirty_sync_count_prev = 0;
>              timer_mod(throttle_dirty_sync_timer,
>                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
>                      CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS);
> -- 
> 2.45.0

LGTM

