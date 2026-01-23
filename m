Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56002D74ECF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHHF-0005zw-BS; Fri, 23 Jan 2026 08:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHH7-0005pT-Pm
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:32:37 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHH6-00040o-5i
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:32:33 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E850337DD;
 Fri, 23 Jan 2026 13:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769175150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWs0c8jGsG3nQfHNy/aSnDj7SfgTnXmeIFE1J+iuVNs=;
 b=SuqdYUWduBZbctipD+j8NRsaItwmYEQondqJDYaUX3TZP9ZU9u/KETxvKHtE+a9YsUozSl
 MfKyp7FGkbFYGKMwcgrCUbRdee5zYY+f6Gh+CGl59WLVru1ppws1Tnrg7W7BYwzQ9t+oZU
 1T9vRYkgt9ERPp5q5v9u6y3c8igjrg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769175150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWs0c8jGsG3nQfHNy/aSnDj7SfgTnXmeIFE1J+iuVNs=;
 b=KS8cw5fKKylDqO1Pw8rthW+zGJybfZAG/oyk/2RrX/qG4HhIFVX/EJEGRL4QEUrIO82Tym
 ZiIE1YT7C3Vdh8BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SuqdYUWd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KS8cw5fK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769175150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWs0c8jGsG3nQfHNy/aSnDj7SfgTnXmeIFE1J+iuVNs=;
 b=SuqdYUWduBZbctipD+j8NRsaItwmYEQondqJDYaUX3TZP9ZU9u/KETxvKHtE+a9YsUozSl
 MfKyp7FGkbFYGKMwcgrCUbRdee5zYY+f6Gh+CGl59WLVru1ppws1Tnrg7W7BYwzQ9t+oZU
 1T9vRYkgt9ERPp5q5v9u6y3c8igjrg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769175150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWs0c8jGsG3nQfHNy/aSnDj7SfgTnXmeIFE1J+iuVNs=;
 b=KS8cw5fKKylDqO1Pw8rthW+zGJybfZAG/oyk/2RrX/qG4HhIFVX/EJEGRL4QEUrIO82Tym
 ZiIE1YT7C3Vdh8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6EC0136AA;
 Fri, 23 Jan 2026 13:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vEyOKW14c2kNbgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 13:32:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH 03/10] migration: Remove one migration_in_colo_state()
 occurance
In-Reply-To: <20260121223336.3381912-4-peterx@redhat.com>
References: <20260121223336.3381912-1-peterx@redhat.com>
 <20260121223336.3381912-4-peterx@redhat.com>
Date: Fri, 23 Jan 2026 10:32:27 -0300
Message-ID: <87ikcsihec.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[web.de];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim, suse.de:email]
X-Rspamd-Queue-Id: 7E850337DD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> Move the send header operation directly into Xen's QMP command, as COLO
> doesn't need it.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

We should make an effort to unify qemu_save_device_state and
qemu_savevm_state_complete_precopy_non_iterable, they're almost the
same.

> ---
>  migration/savevm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 64bf445c98..61e873d90c 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1871,9 +1871,6 @@ int qemu_save_device_state(QEMUFile *f)
>      Error *local_err = NULL;
>      SaveStateEntry *se;
>  
> -    if (!migration_in_colo_state()) {
> -        qemu_savevm_send_header(f);
> -    }
>      cpu_synchronize_all_states();
>  
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> @@ -3335,6 +3332,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
>      qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-save-state");
>      f = qemu_file_new_output(QIO_CHANNEL(ioc));
>      object_unref(OBJECT(ioc));
> +    qemu_savevm_send_header(f);
>      ret = qemu_save_device_state(f);
>      if (ret < 0 || qemu_fclose(f) < 0) {
>          error_setg(errp, "saving Xen device state failed");

