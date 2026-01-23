Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9086D74EC5
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjH82-0000dp-MI; Fri, 23 Jan 2026 08:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjH7y-0000da-S4
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:23:07 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjH7x-0001la-7F
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:23:06 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8266F5BCD3;
 Fri, 23 Jan 2026 13:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769174583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7zeK3BlA9S5NWhRJgkZnxA3O5cewxPWS8lAkQeWPGbk=;
 b=kIuHQDTAAE7UuRkmLIYdb7WcBgj5+uya3P0o6wr6z2FFw0PF55Pogr1/Ai4bvQ8lC17App
 8U7TnJzQL/r3FwxBOAlN7N+1OSYHrO0j42T7gG0mXJoxnmJl7m5LGLBmasQyf7vG3rdK4L
 ZsBNMC0eumB3CzorJO6w61MryWURH5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769174583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7zeK3BlA9S5NWhRJgkZnxA3O5cewxPWS8lAkQeWPGbk=;
 b=gPfNYFbezzs0M55rbkiHNPNaAgCRsFx5/BCUsbb18fCGdcIZpWMdXUB2rvfaN2xe7GESJK
 +dpprs/QNyHzoDCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kIuHQDTA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gPfNYFbe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769174583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7zeK3BlA9S5NWhRJgkZnxA3O5cewxPWS8lAkQeWPGbk=;
 b=kIuHQDTAAE7UuRkmLIYdb7WcBgj5+uya3P0o6wr6z2FFw0PF55Pogr1/Ai4bvQ8lC17App
 8U7TnJzQL/r3FwxBOAlN7N+1OSYHrO0j42T7gG0mXJoxnmJl7m5LGLBmasQyf7vG3rdK4L
 ZsBNMC0eumB3CzorJO6w61MryWURH5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769174583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7zeK3BlA9S5NWhRJgkZnxA3O5cewxPWS8lAkQeWPGbk=;
 b=gPfNYFbezzs0M55rbkiHNPNaAgCRsFx5/BCUsbb18fCGdcIZpWMdXUB2rvfaN2xe7GESJK
 +dpprs/QNyHzoDCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC615136AA;
 Fri, 23 Jan 2026 13:23:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id knDEKjZ2c2nNZAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 13:23:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH 01/10] migration: Introduce qemu_savevm_send_* helpers
In-Reply-To: <20260121223336.3381912-2-peterx@redhat.com>
References: <20260121223336.3381912-1-peterx@redhat.com>
 <20260121223336.3381912-2-peterx@redhat.com>
Date: Fri, 23 Jan 2026 10:23:00 -0300
Message-ID: <87o6mkihu3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[web.de];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FREEMAIL_CC(0.00)[redhat.com,web.de];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8266F5BCD3
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

> Split qemu_savevm_state_header() into two parts.   This paves way for a
> reuse elsewhere.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/savevm.h |  1 +
>  migration/savevm.c | 58 +++++++++++++++++++++++++++-------------------
>  2 files changed, 35 insertions(+), 24 deletions(-)
>
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 125a2507b7..5d815af742 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -37,6 +37,7 @@ int qemu_savevm_state_prepare(Error **errp);
>  int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
>  bool qemu_savevm_state_guest_unplug_pending(void);
>  int qemu_savevm_state_resume_prepare(MigrationState *s);
> +void qemu_savevm_send_header(QEMUFile *f);
>  void qemu_savevm_state_header(QEMUFile *f);
>  int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>  void qemu_savevm_state_cleanup(void);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 3dc812a7bb..e26656cca3 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1282,38 +1282,48 @@ void qemu_savevm_non_migratable_list(strList **reasons)
>      }
>  }
>  
> -void qemu_savevm_state_header(QEMUFile *f)
> +void qemu_savevm_send_header(QEMUFile *f)
>  {
> -    MigrationState *s = migrate_get_current();
> -    JSONWriter *vmdesc = s->vmdesc;
> -    Error *local_err = NULL;
> -
>      trace_savevm_state_header();
>      qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
>      qemu_put_be32(f, QEMU_VM_FILE_VERSION);
> +}
>  
> -    if (s->send_configuration) {
> -        qemu_put_byte(f, QEMU_VM_CONFIGURATION);
> +static void qemu_savevm_send_configuration(MigrationState *s, QEMUFile *f)
> +{
> +    JSONWriter *vmdesc = s->vmdesc;
> +    Error *local_err = NULL;
>  
> -        if (vmdesc) {
> -            /*
> -             * This starts the main json object and is paired with the
> -             * json_writer_end_object in
> -             * qemu_savevm_state_complete_precopy_non_iterable
> -             */
> -            json_writer_start_object(vmdesc, NULL);
> -            json_writer_start_object(vmdesc, "configuration");
> -        }
> +    qemu_put_byte(f, QEMU_VM_CONFIGURATION);
>  
> -        vmstate_save_state(f, &vmstate_configuration, &savevm_state,
> -                           vmdesc, &local_err);
> -        if (local_err) {
> -            error_report_err(local_err);
> -        }
> +    if (vmdesc) {
> +        /*
> +         * This starts the main json object and is paired with the
> +         * json_writer_end_object in
> +         * qemu_savevm_state_complete_precopy_non_iterable
> +         */
> +        json_writer_start_object(vmdesc, NULL);
> +        json_writer_start_object(vmdesc, "configuration");
> +    }
>  
> -        if (vmdesc) {
> -            json_writer_end_object(vmdesc);
> -        }
> +    vmstate_save_state(f, &vmstate_configuration, &savevm_state,
> +                       vmdesc, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
> +
> +    if (vmdesc) {
> +        json_writer_end_object(vmdesc);
> +    }
> +}
> +
> +void qemu_savevm_state_header(QEMUFile *f)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    qemu_savevm_send_header(f);
> +    if (s->send_configuration) {
> +        qemu_savevm_send_configuration(s, f);
>      }
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

