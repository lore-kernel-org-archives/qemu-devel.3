Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E148BC5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxP8U-0000Gp-Q7; Fri, 21 Aug 2026 09:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wxP8T-0000Ge-6I
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:18:17 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wxP8R-0004xc-KZ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:18:16 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C6E0B856C8;
 Fri, 21 Aug 2026 13:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787318289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=axP7TqNU9plvOVzbE0MznSZR2Kb3H8p0piTTk2cT8ho=;
 b=Pjzr4hZGE52H6tIRKaGpAhBmpGCeuSyxYmSaMJ7LUGtaTYkzoAsZM2DbndDT5UJyK3FKUD
 Cdf8gzH4B+caZhBYSoRjHm5LYrDUj5IX2GjzUdNmd/+1ce/+dUNq/xmVvGqHSsfXeDqlnI
 HIsXlGxKqp3Eyx4he1E5Du3h3hiTlwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787318289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=axP7TqNU9plvOVzbE0MznSZR2Kb3H8p0piTTk2cT8ho=;
 b=268mBZuPY9O499Ev4XkoZfG1d5LscBtSncG+HNZ4rInIk8FI8mzYkNGjVXyqv0vr1FJTTE
 qJEgqFwm0NjBhkCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YxoWffrS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iavxqZg8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787318285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=axP7TqNU9plvOVzbE0MznSZR2Kb3H8p0piTTk2cT8ho=;
 b=YxoWffrShleJx3cCfJL5lRYwyac+ULCDG/A6i5oWpN4WlZRKaj/emDSzkgUzpq/qJBicTC
 dojaSyDmOPjUJebzVxlP3RflLgwxlqkH+XZPqoevO5mKaLY+XlLUPCHrS0LGA7FR3tUEYJ
 pozhLE86Pwc2DdVD1iKxeM+r4DpliMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787318285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=axP7TqNU9plvOVzbE0MznSZR2Kb3H8p0piTTk2cT8ho=;
 b=iavxqZg8sOZvlPUrmsWVdWAuyc9SKqR6ekcELBpygRG7yjSFN1Gaa9jPL7RGeOKnBOvnPS
 TNefb+D51VFdEfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6710726F8;
 Fri, 21 Aug 2026 13:18:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sl16Dg1QiGoIDQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Aug 2026 13:18:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>, Samuel
 Zhang <guoqing.zhang@amd.com>, Yanfei Xu <yanfei.xu@bytedance.com>, Jinpu
 Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH v2 01/10] migration/rdma: Introduce RDMA_CONTROL_NUM
In-Reply-To: <20260820200322.3321036-2-peterx@redhat.com>
References: <20260820200322.3321036-1-peterx@redhat.com>
 <20260820200322.3321036-2-peterx@redhat.com>
Date: Fri, 21 Aug 2026 10:17:55 -0300
Message-ID: <87ik53liik.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Queue-Id: C6E0B856C8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

> Introduce this to say how many control messages we have.  We did it because
> we're going to remove the last one (RDMA_CONTROL_UNREGISTER_FINISHED) soon.
>
> Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/rdma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 438419d189..62a509b236 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -144,6 +144,7 @@ enum {
>      RDMA_CONTROL_REGISTER_FINISHED,   /* current iteration finished */
>      RDMA_CONTROL_UNREGISTER_REQUEST,  /* dynamic UN-registration */
>      RDMA_CONTROL_UNREGISTER_FINISHED, /* unpinning finished */
> +    RDMA_CONTROL_NUM,
>  };
>  
>  
> @@ -235,7 +236,7 @@ static const char *control_desc(unsigned int rdma_control)
>          [RDMA_CONTROL_UNREGISTER_FINISHED] = "UNREGISTER FINISHED",
>      };
>  
> -    if (rdma_control > RDMA_CONTROL_UNREGISTER_FINISHED) {
> +    if (rdma_control >= RDMA_CONTROL_NUM) {
>          return "??BAD CONTROL VALUE??";
>      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

