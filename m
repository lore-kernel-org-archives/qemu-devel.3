Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45014CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 18:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMrtw-0001lj-Rt; Tue, 12 May 2026 14:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMrtT-0001Xh-Q8
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:31:49 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMrtR-0001SE-Vk
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:31:47 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5FA4A5BF68;
 Tue, 12 May 2026 18:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778610701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j5ZcDNm06oM/Tc2xH+cSkAh0CKCaVWblXZo1juqp5EI=;
 b=yXlsxj8hrZ9fyuyqKmuqAyFIX4ACEfeJ1gY34fz7Ea9rATIP4W5As0tTCOLTzplkf3goKm
 ahK3k1t8wCgby6yPnjKq+0Izr3MdyfHMOQK7S2iRBPsRwHkM59twxxPPwTY8hiTEYl16KV
 IFEN6efEtdryxo3cQ6Fm49Ueo+GhCn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778610701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j5ZcDNm06oM/Tc2xH+cSkAh0CKCaVWblXZo1juqp5EI=;
 b=kVbe+HBgpxTKG6xhGGD2Ohpfi9S2oA2DXTN/j5BOD8lMMW1sgQMEE05lJNb3vTnyNIzOxx
 Fn8kkbeR+2EFwQBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778610701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j5ZcDNm06oM/Tc2xH+cSkAh0CKCaVWblXZo1juqp5EI=;
 b=yXlsxj8hrZ9fyuyqKmuqAyFIX4ACEfeJ1gY34fz7Ea9rATIP4W5As0tTCOLTzplkf3goKm
 ahK3k1t8wCgby6yPnjKq+0Izr3MdyfHMOQK7S2iRBPsRwHkM59twxxPPwTY8hiTEYl16KV
 IFEN6efEtdryxo3cQ6Fm49Ueo+GhCn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778610701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j5ZcDNm06oM/Tc2xH+cSkAh0CKCaVWblXZo1juqp5EI=;
 b=kVbe+HBgpxTKG6xhGGD2Ohpfi9S2oA2DXTN/j5BOD8lMMW1sgQMEE05lJNb3vTnyNIzOxx
 Fn8kkbeR+2EFwQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2D61593A9;
 Tue, 12 May 2026 18:31:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZhIhMAxyA2qABQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 12 May 2026 18:31:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com, Juraj
 Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v3] migration: Fix possible division by zero on calc
 expected downtime
In-Reply-To: <20260511182432.1333467-1-peterx@redhat.com>
References: <20260511182432.1333467-1-peterx@redhat.com>
Date: Tue, 12 May 2026 15:31:34 -0300
Message-ID: <8733zwxywp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,linaro.org:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:helo,
 suse.de:email, suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> Commit dd4fe8844b changed the reporting of expected downtime behavior, so
> that the value will be calculated on-demand.  One side effect on the change
> is QEMU will allow the calculation to happen anytime even if there's no
> transfer happening for a short while.
>
> PeterM reported an ubsan report from clang when running migration-test with
> aarch64 binary on x86_64 hosts.  I can also reproduce if I run the test
> concurrently so some of the src QEMU may not get chance to push any data,
> causing mbps to be 0:
>
> ../migration/migration.c:1051:12: runtime error: -nan is outside the range of representable values of type 'long'
>
> Fix it by properly handle both Inf and Nan to return INT64_MAX.
>
> Add a rich comment, per PeterM's suggestion.
>
> Link: https://lore.kernel.org/r/CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: dd4fe8844b ("migration: Calculate expected downtime on demand")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index b6f78eb3ac..05f10e4576 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -63,6 +63,7 @@
>  #include "system/dirtylimit.h"
>  #include "qemu/sockets.h"
>  #include "system/kvm.h"
> +#include "math.h"
>  
>  #define NOTIFIER_ELEM_INIT(array, elem)    \
>      [elem] = NOTIFIER_WITH_RETURN_LIST_INITIALIZER((array)[elem])
> @@ -1044,12 +1045,29 @@ static bool migrate_show_downtime(MigrationState *s)
>  /* Return expected downtime (unit: milliseconds) */
>  int64_t migration_downtime_calc_expected(MigrationState *s)
>  {
> +    double expected_ms;
> +
>      if (mig_stats.dirty_sync_count <= 1) {
>          return migrate_downtime_limit();
>      }
>  
> -    return mig_stats.dirty_bytes_last_sync /
> +    expected_ms = mig_stats.dirty_bytes_last_sync /
>          migration_get_switchover_bw(s) * 1000;
> +
> +    /*
> +     * If we haven't been able to transfer any data, the result here could
> +     * be NaN (for 0 / 0) or infinity (something else / 0).
> +     *
> +     * Return INT64_MAX as our best approximation to "this will take
> +     * forever to complete". If the problem is transient (e.g. we just
> +     * haven't started to transfer yet) we'll recalculate to a more
> +     * accurate figure later.
> +     */
> +    if (isnan(expected_ms) || expected_ms >= (double)INT64_MAX) {
> +        return INT64_MAX;
> +    }
> +
> +    return (int64_t) expected_ms;
>  }
>  
>  static void populate_time_info(MigrationInfo *info, MigrationState *s)

Reviewed-by: Fabiano Rosas <farosas@suse.de>

