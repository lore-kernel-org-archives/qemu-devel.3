Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC50CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJIa-0002VM-4u; Tue, 21 Oct 2025 16:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBJIO-00029q-IK
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:32 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBJII-0001En-5v
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CDFAA1F38D;
 Tue, 21 Oct 2025 20:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761079754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/6icJJeqpOP2VnFXpFmRabVCh0Xm/bp4TsLu9YlcLnM=;
 b=0mfRconk0i8+8BEjDGLpjYdvOvkyrAMQvGTr/ZGu86Jjw46/iZsk2p2+gBlc3k7rdqE/NV
 rbPmVou/meIi/V3ukPtPehBJ7WZ/cJ2IGijFRfQ7P8UkaQMx+SyCwL0PKMKzvZ8hcc1cx7
 4m70M6XBvSqGkEJX6KPC8//yLzFT2ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761079754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/6icJJeqpOP2VnFXpFmRabVCh0Xm/bp4TsLu9YlcLnM=;
 b=IEBJ/ejmV7WM9/19/l8H+LQmkhKdidDt00nsSz6D2KSIO2u7cF/Rg6OSMuX064Qd9xYmSK
 ruljA9y/q3SSU2Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="s7/oZM+x";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+pIEM+ez
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761079750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/6icJJeqpOP2VnFXpFmRabVCh0Xm/bp4TsLu9YlcLnM=;
 b=s7/oZM+xCr4RhDywdTe5S6rH3dIsBaVxkAYnAcu4yg+PRORdBGY/aYebts05MhZkwb/gMT
 safWMQsT0P4wfKMIn9+9GQonwmUJ0v9TlKkFugY6wGh7dJsvzu+Qt2vfNan3qJB0LaoSSO
 FiTiK3K1IzyeJEcGzb78unISPJR9kv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761079750;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/6icJJeqpOP2VnFXpFmRabVCh0Xm/bp4TsLu9YlcLnM=;
 b=+pIEM+ez1ku7A/pSBnLXcOE47RVDRaT5IfxPVpdpY5VZmpueBzqtNFmt6kzhnssDtMKgE+
 TBmcAEzNVNYgK/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52FF0139D2;
 Tue, 21 Oct 2025 20:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wnsqBsbx92iCVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 21 Oct 2025 20:49:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Arun Menon <armenon@redhat.com>, peterx@redhat.com, Peter Maydell
 <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 2/3] migration/cpr: Fix coverity report in
 cpr_exec_persist_state()
In-Reply-To: <20251021184132.2635958-3-peterx@redhat.com>
References: <20251021184132.2635958-1-peterx@redhat.com>
 <20251021184132.2635958-3-peterx@redhat.com>
Date: Tue, 21 Oct 2025 17:49:07 -0300
Message-ID: <87o6q0t1z0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: CDFAA1F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

> Per reported and analyzed by Peter:
>
> https://lore.kernel.org/r/CAFEAcA_mUQ2NeoguR5efrhw7XYGofnriWEA=+Dg+Ocvyam1wAw@mail.gmail.com
>
> mfd leak is a false positive, try to use a coverity annotation (which I
> didn't find manual myself, but still give it a shot).
>
> Fix the other one by dumping an error message if setenv() failed.
>
> Resolves: Coverity CID 1641391
> Resolves: Coverity CID 1641392
> Fixes: efc6587313 ("migration: cpr-exec save and load")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/cpr-exec.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> index d57714bc5d..3cf44634a9 100644
> --- a/migration/cpr-exec.c
> +++ b/migration/cpr-exec.c
> @@ -43,13 +43,16 @@ static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
>  void cpr_exec_persist_state(QEMUFile *f)
>  {
>      QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
> +    /* coverity[leaked_storage] - mfd intentionally kept open across exec() */
>      int mfd = dup(fioc->fd);
>      char val[16];
>  
>      /* Remember mfd in environment for post-exec load */
>      qemu_clear_cloexec(mfd);
>      snprintf(val, sizeof(val), "%d", mfd);
> -    g_setenv(CPR_EXEC_STATE_NAME, val, 1);
> +    if (!g_setenv(CPR_EXEC_STATE_NAME, val, 1)) {
> +        error_report("Setting env %s = %s failed", CPR_EXEC_STATE_NAME, val);
> +    }

Best to abort no? We don't want the rest of the code reading whatever
may be at that env variable and running with it.

>  }
>  
>  static int cpr_exec_find_state(void)

