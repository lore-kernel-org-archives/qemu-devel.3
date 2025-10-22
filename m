Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296B0CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXwY-0000bf-BD; Wed, 22 Oct 2025 08:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBXwW-0000bG-Vu
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:27:53 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBXwR-0007yY-CB
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:27:52 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6FA3A1F449;
 Wed, 22 Oct 2025 12:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761136061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w6aM2Koc871aZKNKUC2Too36BGrrIpOqStO3wEIhgu8=;
 b=y4oDaxHtrr+IN9aJ7pQT0P1xlISHwQDyioZx3qwOqogjXiw3mYOMg0jfIyIM4jJc7fHU7v
 WWMtgJ9RIY/5Mf6fM4X2XRb2qokkV5swZnahujKB7Nu69cv1dPyRBG+UbIrw34Kc6xXc87
 k34Bah2jWtssSibm+E7BDqtRRwM2oL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761136061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w6aM2Koc871aZKNKUC2Too36BGrrIpOqStO3wEIhgu8=;
 b=UpG1oVmDxvFU5g1JRgfJWru4p2QdUzOot6KSE4myNR8iBgfrSIhgwV8M47PYopC9BoIv0o
 FYKummUgs6TB0oDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761136057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w6aM2Koc871aZKNKUC2Too36BGrrIpOqStO3wEIhgu8=;
 b=P9Cge2T+BiHRLNb5zL0x7j4P6rV40cCUTrOubyLCojmqTysxdR7QOwk/UNTH//Yfv81cYY
 iEwrQA3V6EBBUFeOItUCEdU/z9a6DToO5BKGpdoI49g95cAP7tdOIK3t7pZaEuq09XOMyw
 JKDZJAA0b+ewR9YxSbVXZGuIJHmNWmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761136057;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w6aM2Koc871aZKNKUC2Too36BGrrIpOqStO3wEIhgu8=;
 b=OhxcWngcI1Dic/6skY8IEJO2ZzgcJdNTIenKCktGlNbZRs/74JjYPYXxCvxPte32BBT4Kp
 x9fwoLspNabMFuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E30B213A29;
 Wed, 22 Oct 2025 12:27:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i0yYKLjN+Gg3LQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 Oct 2025 12:27:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Arun Menon
 <armenon@redhat.com>, Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v2 4/4] migration/cpr: Avoid crashing QEMU when cpr-exec
 runs with no args
In-Reply-To: <20251021220407.2662288-5-peterx@redhat.com>
References: <20251021220407.2662288-1-peterx@redhat.com>
 <20251021220407.2662288-5-peterx@redhat.com>
Date: Wed, 22 Oct 2025 09:27:34 -0300
Message-ID: <877bwnt93d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
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

> If an user invokes cpr-exec without setting the exec args first, currently
> it'll crash QEMU.
>
> Avoid it, instead fail the QMP migrate command.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index c8a5712993..4ed2a2e881 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2195,6 +2195,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>              error_setg(errp, "Cannot use %s with CPR", conflict);
>              return false;
>          }
> +
> +        if (s->parameters.mode == MIG_MODE_CPR_EXEC &&
> +            !s->parameters.cpr_exec_command) {
> +            error_setg(errp, "Parameter 'cpr-exec-command' required for cpr-exec");
> +            return false;
> +        }
>      }
>  
>      if (migrate_init(s, errp)) {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

