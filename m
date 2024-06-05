Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2843C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErB8-0003R4-1y; Wed, 05 Jun 2024 09:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sErB7-0003Qr-En
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:59:49 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sErB5-0000Xl-J4
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:59:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C58DC1F80B;
 Wed,  5 Jun 2024 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717595985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IN9jMpKPCKRpVmJ+AQpWXDEUZvPROq9bZ6hrmJXCxlE=;
 b=KrEj+L5Fv1oCMG8S/gd0UGpHHur+YkYRVP7lNhnlP0QqcuXKGjvB0/Ijylurlo8LmuAl7G
 q1fZdfKu2j8eF7WvJJgtbVhqtmWWXfjSTedJPhHJdVaO3m4wJAoewobop5d1PJ/di49lEj
 qivvWB8Q/TktuP5rpgkmmr2aJdB8164=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717595985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IN9jMpKPCKRpVmJ+AQpWXDEUZvPROq9bZ6hrmJXCxlE=;
 b=/ARteBBAFSWebonMet7VzRVCv/YVaYAH7ggtbWBWk8RoIQGTwv9gK34kR9bZrk632TfJF2
 yhx1ctPMl6XnUdCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q67vKBHL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7eE+aCKt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717595984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IN9jMpKPCKRpVmJ+AQpWXDEUZvPROq9bZ6hrmJXCxlE=;
 b=q67vKBHL1HtF3G32wYJH7DjbdPpAzJKw+s/MZTlPPeATT5xTj3GQPqJWf8qxXfPhQKU8rx
 zi01sumouYjzP4PUsn+ovppk4AX2/SJ7lOePX4aVS198eHD7dPUW82Hu5SeE8Bku5WcOy/
 f5Ztz7YunMyyNbHtWSBgXMx0DFZ2RMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717595984;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IN9jMpKPCKRpVmJ+AQpWXDEUZvPROq9bZ6hrmJXCxlE=;
 b=7eE+aCKtgmzyJzqWnIFLUQ4Jo5Sq/Tod++NU4IEe+l2/ABM2NflYe5QA4l4X80qYOw1wpC
 UDsYbDeqpeOEeFBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E78913A24;
 Wed,  5 Jun 2024 13:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XdeEBVBvYGa4KQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 05 Jun 2024 13:59:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Subject: Re: [RFC PATCH] migration/savevm: do not schedule
 snapshot_save_job_bh in qemu_aio_context
In-Reply-To: <20240605120848.358654-1-f.ebner@proxmox.com>
References: <20240605120848.358654-1-f.ebner@proxmox.com>
Date: Wed, 05 Jun 2024 10:59:41 -0300
Message-ID: <874ja7h4mq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C58DC1F80B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> The fact that the snapshot_save_job_bh() is scheduled in the main
> loop's qemu_aio_context AioContext means that it might get executed
> during a vCPU thread's aio_poll(). But saving of the VM state cannot
> happen while the guest or devices are active and can lead to assertion
> failures. See issue #2111 for two examples. Avoid the problem by
> scheduling the snapshot_save_job_bh() in the iohandler AioContext,
> which is not polled by vCPU threads.
>
> Solves Issue #2111.
>
> This change also solves the following issue:
>
> Since commit effd60c878 ("monitor: only run coroutine commands in
> qemu_aio_context"), the 'snapshot-save' QMP call would not respond
> right after starting the job anymore, but only after the job finished,
> which can take a long time. The reason is, because after commit
> effd60c878, do_qmp_dispatch_bh() runs in the iohandler AioContext.
> When do_qmp_dispatch_bh() wakes the qmp_dispatch() coroutine, the
> coroutine cannot be entered immediately anymore, but needs to be
> scheduled to the main loop's qemu_aio_context AioContext. But
> snapshot_save_job_bh() was scheduled first to the same AioContext and
> thus gets executed first.
>
> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/2111
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>
> While initial smoke testing seems fine, I'm not familiar enough with
> this to rule out any pitfalls with the approach. Any reason why
> scheduling to the iohandler AioContext could be wrong here?

FWIW, I couldn't find any reason why this would not work. But let's see
what Stefan and Paolo have to say.

>
> Should the same be done for the snapshot_load_job_bh and
> snapshot_delete_job_bh to keep it consistent?

Yep, I think it makes sense.

>
>  migration/savevm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index c621f2359b..0086b76ab0 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3459,7 +3459,7 @@ static int coroutine_fn snapshot_save_job_run(Job *job, Error **errp)
>      SnapshotJob *s = container_of(job, SnapshotJob, common);
>      s->errp = errp;
>      s->co = qemu_coroutine_self();
> -    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +    aio_bh_schedule_oneshot(iohandler_get_aio_context(),
>                              snapshot_save_job_bh, job);
>      qemu_coroutine_yield();
>      return s->ret ? 0 : -1;

