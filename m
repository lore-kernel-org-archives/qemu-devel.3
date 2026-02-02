Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FB8E7DEE3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmv9A-0003WI-8G; Mon, 02 Feb 2026 09:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmv97-0003V8-42
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:43:21 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmv95-0001IK-C1
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:43:20 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 752185BCEC;
 Mon,  2 Feb 2026 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770043396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+E57wbVoXgVydSEXrnl1l9A+3Vw9Bjg72WvrVDgDSKY=;
 b=ZN19eYlV8B0uO2wYO0X/Glpzf0iPxSyawkkQp/D0ENi024NCBi5N29T0L/g8D+HOB9khVB
 xKyEe9sJY7maCxCToPoI+jy2ThQ1csyLTmzTGqXrB3S44sWy1K8yy373RlI6PSIkzYGDqj
 9vqCHz/YXGGoZC/7j/yzxwyOSeHV9yo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770043396;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+E57wbVoXgVydSEXrnl1l9A+3Vw9Bjg72WvrVDgDSKY=;
 b=V+He8DzES3X8RvztMaMSNKA8hI0j/6F95eiN2aiRuSvLqv6op1LdnUkxp2yawAP0ueJoDi
 GCptNAjyd78U7rCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770043396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+E57wbVoXgVydSEXrnl1l9A+3Vw9Bjg72WvrVDgDSKY=;
 b=ZN19eYlV8B0uO2wYO0X/Glpzf0iPxSyawkkQp/D0ENi024NCBi5N29T0L/g8D+HOB9khVB
 xKyEe9sJY7maCxCToPoI+jy2ThQ1csyLTmzTGqXrB3S44sWy1K8yy373RlI6PSIkzYGDqj
 9vqCHz/YXGGoZC/7j/yzxwyOSeHV9yo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770043396;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+E57wbVoXgVydSEXrnl1l9A+3Vw9Bjg72WvrVDgDSKY=;
 b=V+He8DzES3X8RvztMaMSNKA8hI0j/6F95eiN2aiRuSvLqv6op1LdnUkxp2yawAP0ueJoDi
 GCptNAjyd78U7rCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC8EF3EA62;
 Mon,  2 Feb 2026 14:43:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zY35JgO4gGk+TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 14:43:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Markus Armbruster <armbru@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v4 06/16] colo: Don't send ENABLE_COLO command
In-Reply-To: <20260130-colo_unit_test_multifd-v4-6-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
 <20260130-colo_unit_test_multifd-v4-6-7115ab6f0e77@web.de>
Date: Mon, 02 Feb 2026 11:43:13 -0300
Message-ID: <87ikcfryta.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de]; RCVD_TLS_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[web.de,nongnu.org];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,xfusion.com,fujitsu.com,treblig.org,web.de];
 RCPT_COUNT_SEVEN(0.00)[11]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

Lukas Straub <lukasstraub2@web.de> writes:

> We only support COLO with the same version on both sides so this is
> not needed anymore.
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  migration/migration.c  | 5 -----
>  migration/savevm.c     | 8 +-------
>  migration/savevm.h     | 1 -
>  migration/trace-events | 1 -
>  4 files changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 3f3fc5276bb067ae1960e4b675b33208ad641b23..5515be1bf305b40ba0b590136df18a53451872c5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3496,11 +3496,6 @@ static void *migration_thread(void *opaque)
>          qemu_savevm_send_postcopy_advise(s->to_dst_file);
>      }
>  
> -    if (migrate_colo()) {
> -        /* Notify migration destination that we enable COLO */
> -        qemu_savevm_send_colo_enable(s->to_dst_file);
> -    }
> -
>      if (migrate_auto_converge()) {
>          /* Start RAMBlock dirty bitmap sync timer */
>          cpu_throttle_dirty_sync_timer(true);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 413688b75f4bee6cb10878eb51886cf6ba14872d..a3af09616a7bd22194ffba3cfb7cc4cf15fc88e0 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -90,7 +90,7 @@ enum qemu_vm_cmd {
>                                        were previously sent during
>                                        precopy but are dirty. */
>      MIG_CMD_PACKAGED,          /* Send a wrapped stream within this stream */
> -    MIG_CMD_ENABLE_COLO,       /* Enable COLO */
> +    MIG_CMD_UNUSED_0,          /* Unused since 11.0 */
>      MIG_CMD_POSTCOPY_RESUME,   /* resume postcopy on dest */
>      MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
>      MIG_CMD_SWITCHOVER_START,  /* Switchover start notification */
> @@ -1092,12 +1092,6 @@ static void qemu_savevm_command_send(QEMUFile *f,
>      qemu_fflush(f);
>  }
>  
> -void qemu_savevm_send_colo_enable(QEMUFile *f)
> -{
> -    trace_savevm_send_colo_enable();
> -    qemu_savevm_command_send(f, MIG_CMD_ENABLE_COLO, 0, NULL);
> -}
> -
>  void qemu_savevm_send_ping(QEMUFile *f, uint32_t value)
>  {
>      uint32_t buf;
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 125a2507b7279412bcb0745b95a774874c31c54f..0a1e5bfd1ca125565a4c90c6f31b2f8c94404117 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -62,7 +62,6 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
>                                             uint16_t len,
>                                             uint64_t *start_list,
>                                             uint64_t *length_list);
> -void qemu_savevm_send_colo_enable(QEMUFile *f);
>  void qemu_savevm_live_state(QEMUFile *f);
>  int qemu_save_device_state(QEMUFile *f);
>  
> diff --git a/migration/trace-events b/migration/trace-events
> index 91d7506634c9f110e8f0b5f9183728058fe6542a..cfd4d58a0f82ec299ca9e8a9260dd3c3a210cece 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -37,7 +37,6 @@ savevm_send_ping(uint32_t val) "0x%x"
>  savevm_send_postcopy_listen(void) ""
>  savevm_send_postcopy_run(void) ""
>  savevm_send_postcopy_resume(void) ""
> -savevm_send_colo_enable(void) ""
>  savevm_send_recv_bitmap(char *name) "%s"
>  savevm_send_switchover_start(void) ""
>  savevm_state_setup(void) ""

Reviewed-by: Fabiano Rosas <farosas@suse.de>

