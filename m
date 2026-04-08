Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006CA10F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYRI-0008F2-K4; Wed, 08 Apr 2026 15:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1wAY2D-0005XM-Aj
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:53:53 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1wAVYD-0007NA-Ge
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:14:47 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD5194D1E0;
 Wed,  8 Apr 2026 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775664882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIHTCJXnymaasIPPiL/mNO9NS0cH3LfFXHfQLODgbKA=;
 b=Zh69E5YOdnL7vcmkDLK7zOXYEoV3rQYpn9GnQQljYt+Pmn1TnGETk4w9+PkwoOzelrt8+T
 wBMYu8mztsM912mjuKC2iZxvZlcuG9rcKvc5FJT/oYxrgrQF8nBzdJKfwxVa9aUqliwVip
 gfCznpizT5/4f/bl8KDgoCglXg3jQQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775664882;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIHTCJXnymaasIPPiL/mNO9NS0cH3LfFXHfQLODgbKA=;
 b=sL81G8fSnF5KZTwkyIGHiXSQxvGJqPug66b4ZT8KSxc6CcrbXK5Fjczy/KzHTg7uYznq+w
 EGDn2Y3BDTf+SZAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775664882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIHTCJXnymaasIPPiL/mNO9NS0cH3LfFXHfQLODgbKA=;
 b=Zh69E5YOdnL7vcmkDLK7zOXYEoV3rQYpn9GnQQljYt+Pmn1TnGETk4w9+PkwoOzelrt8+T
 wBMYu8mztsM912mjuKC2iZxvZlcuG9rcKvc5FJT/oYxrgrQF8nBzdJKfwxVa9aUqliwVip
 gfCznpizT5/4f/bl8KDgoCglXg3jQQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775664882;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIHTCJXnymaasIPPiL/mNO9NS0cH3LfFXHfQLODgbKA=;
 b=sL81G8fSnF5KZTwkyIGHiXSQxvGJqPug66b4ZT8KSxc6CcrbXK5Fjczy/KzHTg7uYznq+w
 EGDn2Y3BDTf+SZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 443B34A0B3;
 Wed,  8 Apr 2026 16:14:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gOymDfJ+1mkgUQAAD6G6ig
 (envelope-from <cfontana@suse.de>); Wed, 08 Apr 2026 16:14:42 +0000
Message-ID: <d1654771-8f7a-4331-969f-2d7bf038113b@suse.de>
Date: Wed, 8 Apr 2026 18:14:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 2/2] migration: expose RAM stats and timing on destination
 via query-migrate
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260405152612.93027-1-viking4@gmail.com>
 <20260405152612.93027-3-viking4@gmail.com>
Content-Language: en-US
In-Reply-To: <20260405152612.93027-3-viking4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
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

Hello Trieu,

makes sense to me in general, but maintainers can give you a more proper review on this,
I can only point out a few sources of confusion from my side, which likely stem from lack of knowledge from my side:

On 4/5/26 17:26, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
> 
> MigrationStats had all-required QAPI fields, so partially populating
> info->ram on the destination would force display of source-only metrics
> (dirty-sync-count, precopy-bytes, etc.) as misleading zeros.
> 
> Make those source-only fields optional with '*' in the QAPI schema.
> Update populate_ram_info() to set them via has_* setters so source
> output is unchanged.
> 
> As per schema's changes, fill_destination_migration_info() can now
> populate info->ram for the COMPLETED case with the fields that are
> meaningful on the receive side:
> 
>   * total, remaining, page-size         (RAM layout)

Does 'remaining' make sense if the migration is completed? Don't we just assume 0?
But maybe it makes sense to keep it for simplicity/consistency.

>   * transferred, normal, normal-bytes   (bytes/pages received)
>   * duplicate                           (zero pages received)

it is interesting that zero pages are called "duplicate".

>   * mbps                                (throughput: transferred*8
>                                          /time_ms/1000)
>   * pages-per-second                    (total pages / duration in
>                                          seconds)
> 
> Others optional fields (dirty-sync-count, precopy-bytes,
> downtime-bytes, postcopy-bytes, multifd-bytes, postcopy-requests,
> dirty-sync-missed-zero-copy, dirty-pages-rate) are left unset and
> are absent from the destination output.
> 
> On dst, {"execute":"query-migrate"}
> * As-is:
> {
>     "return": {
>         "status": "completed"
> }
> * To-be:
> {
>     "return": {
>         "status": "completed",
>         "total-time": 94,
>         "ram": {
>             "total": 554508288,
>             "pages-per-second": 1440234,
>             "page-size": 4096,
>             "remaining": 0,
>             "mbps": 97.955404255319152,
>             "transferred": 1150976,
>             "duplicate": 135101,
>             "normal-bytes": 1150976,
>             "normal": 281
>         }
>     }
> }
> 
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>  migration/migration.c | 35 +++++++++++++++++++++++++++++++++++
>  qapi/migration.json   | 14 +++++++-------
>  2 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 17c9a8b344..925d29890d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1063,17 +1063,24 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>      info->ram->normal = qatomic_read(&mig_stats.normal_pages);
>      info->ram->normal_bytes = info->ram->normal * page_size;
>      info->ram->mbps = s->mbps;
> +    info->ram->has_dirty_sync_count = true;
>      info->ram->dirty_sync_count =
>          qatomic_read(&mig_stats.dirty_sync_count);
> +    info->ram->has_dirty_sync_missed_zero_copy = true;
>      info->ram->dirty_sync_missed_zero_copy =
>          qatomic_read(&mig_stats.dirty_sync_missed_zero_copy);
> +    info->ram->has_postcopy_requests = true;
>      info->ram->postcopy_requests =
>          qatomic_read(&mig_stats.postcopy_requests);
>      info->ram->page_size = page_size;
> +    info->ram->has_multifd_bytes = true;
>      info->ram->multifd_bytes = qatomic_read(&mig_stats.multifd_bytes);
>      info->ram->pages_per_second = s->pages_per_second;
> +    info->ram->has_precopy_bytes = true;
>      info->ram->precopy_bytes = qatomic_read(&mig_stats.precopy_bytes);
> +    info->ram->has_downtime_bytes = true;
>      info->ram->downtime_bytes = qatomic_read(&mig_stats.downtime_bytes);
> +    info->ram->has_postcopy_bytes = true;
>      info->ram->postcopy_bytes = qatomic_read(&mig_stats.postcopy_bytes);
>  
>      if (migrate_xbzrle()) {
> @@ -1094,6 +1101,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>  
>      if (s->state != MIGRATION_STATUS_COMPLETED) {
>          info->ram->remaining = ram_bytes_remaining();
> +        info->ram->has_dirty_pages_rate = true;
>          info->ram->dirty_pages_rate =
>             qatomic_read(&mig_stats.dirty_pages_rate);
>      }
> @@ -1209,6 +1217,33 @@ static void fill_destination_migration_info(MigrationInfo *info)
>      case MIGRATION_STATUS_COMPLETED:
>          info->has_status = true;
>          fill_destination_postcopy_migration_info(info);
> +        if (mis->total_time > 0) {
> +            info->has_total_time = true;
> +            info->total_time = mis->total_time;
> +        }
> +        {
> +            size_t page_size = qemu_target_page_size();
> +            uint64_t normal  = mis->received_normal_pages;
> +            uint64_t zero    = mis->received_zero_pages;
> +            uint64_t xbzrle  = mis->received_xbzrle_pages;
> +
> +            info->ram = g_malloc0(sizeof(*info->ram));
> +            info->ram->total        = ram_bytes_total();
> +            info->ram->remaining    = 0;
> +            info->ram->normal       = normal + xbzrle;
> +            info->ram->normal_bytes = (normal + xbzrle) * page_size;
> +            info->ram->duplicate    = zero;
> +            info->ram->transferred  = (normal + xbzrle) * page_size;
> +            info->ram->page_size    = page_size;
> +
> +            if (info->has_total_time) {
> +                info->ram->mbps = info->ram->transferred * 8.0
> +                                  / info->total_time / 1000.0;
> +                info->ram->pages_per_second = (normal + xbzrle + zero)
> +                                              * 1000.0 / info->total_time;
> +            }
> +            /* source-only optional omitted from output */
> +        }
>          break;
>      default:
>          return;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7134d4ce47..a695d04a22 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -68,13 +68,13 @@
>    'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
>             'duplicate': 'int',
>             'normal': 'int',
> -           'normal-bytes': 'int', 'dirty-pages-rate': 'int',
> -           'mbps': 'number', 'dirty-sync-count': 'int',
> -           'postcopy-requests': 'int', 'page-size': 'int',
> -           'multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
> -           'precopy-bytes': 'uint64', 'downtime-bytes': 'uint64',
> -           'postcopy-bytes': 'uint64',
> -           'dirty-sync-missed-zero-copy': 'uint64' } }
> +           'normal-bytes': 'int', '*dirty-pages-rate': 'int',
> +           'mbps': 'number', '*dirty-sync-count': 'int',
> +           '*postcopy-requests': 'int', 'page-size': 'int',
> +           '*multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
> +           '*precopy-bytes': 'uint64', '*downtime-bytes': 'uint64',
> +           '*postcopy-bytes': 'uint64',
> +           '*dirty-sync-missed-zero-copy': 'uint64' } }
>  
>  ##
>  # @XBZRLECacheStats:

This looks good and makes sense to me,
but looking forward to more authoritative voices.

Does this work build ok on all archs? Any tests that could be extended to cover these new stats,
maybe tests/qtest/migration/ ?

Thank you!

Claudio


