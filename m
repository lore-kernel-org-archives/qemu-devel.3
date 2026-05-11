Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453D9CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVgG-0007BE-7Z; Mon, 11 May 2026 14:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMVgC-0007B1-Tg
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:48:36 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMVgA-00020g-R2
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:48:36 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7381E617F4;
 Mon, 11 May 2026 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778525310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lsfZ73LSDciMcVFXLjAuAu+15hExVSXznwEaW7SgAUU=;
 b=KM+gygbEy0XmevbHsAiT7qRJDnVH08RWtg/1jWp5AtGL9Bkf2Zmtf8ya5TQnObELDUo/dJ
 bffARrivy62180dSS1TkEUnfVccDGS7sHjWbWAwD+INJL00rWexIgeoLjPkxXQUp8s4r0r
 RkFxKoFI/4l2qqyhN8ezgY5l5IxGAI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778525310;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lsfZ73LSDciMcVFXLjAuAu+15hExVSXznwEaW7SgAUU=;
 b=dOSRup7M8S558M6w9w1EEI+mbBd5HwvWdDIp1FEnJ7ocl89yrzqblnDsF+TqrUnXuqEkaP
 8pLk9CWl0icfvCDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EkJhSfgS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=z0v+7Vr0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778525309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lsfZ73LSDciMcVFXLjAuAu+15hExVSXznwEaW7SgAUU=;
 b=EkJhSfgSe7IUyCQPBLGoY7oqqxGlye3wG8sQ8lp1jXdrSF56XCVT3k5wCrCJJkFxZDVAFA
 dEk0QnFYEUIVAcnka0ttR6QrrImdBgOijnfN9Yf7NNt0ltTWCqs/iUAum8NbHkRzVP60Wg
 0UnyKUVVDxTl9gVOD0SgpOmUhOo+Qn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778525309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lsfZ73LSDciMcVFXLjAuAu+15hExVSXznwEaW7SgAUU=;
 b=z0v+7Vr0teMJIoEuv5SDkIs8Q124wG54usX1RoX6iJ1nIl9hC6yIK+Ja9y/37DLsF+I5yC
 ArKwL6UmO/ENhvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DCC2593A3;
 Mon, 11 May 2026 18:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id clZWNHwkAmqrZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 May 2026 18:48:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Update RDMA migration entry with M:
In-Reply-To: <20260511143026.1296485-1-peterx@redhat.com>
References: <20260511143026.1296485-1-peterx@redhat.com>
Date: Mon, 11 May 2026 15:48:18 -0300
Message-ID: <877bp9ye8d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,fujitsu.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7381E617F4
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> We wanted to remove RDMA migration once but that didn't go further.  In
> reality, with the help of Zhijian it's in Odd Fixes stage, even if we just
> merged one new parameter for it, for performance improvements.
>
> Markus pointed out we'd better have at least one M: for it to match
> anything that is not orphaned.
>
> Remove the X: for Migration entry for RDMA files, then it'll start to cover
> RDMA migration again. Keep the separate entry so Zhijian can keep getting
> copied, and copy the M:s over to say someone is collecting patches.
> Logically these M:s aren't needed after removing X:, but make it clearer.
>
> Link: https://lore.kernel.org/r/5326b854-fcea-4af6-a479-792888a94a4d@fujitsu.com
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d3d645953..c57ef413ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3758,11 +3758,11 @@ F: docs/devel/migration/
>  F: qapi/migration.json
>  F: tests/migration-stress/
>  F: util/userfaultfd.c
> -X: migration/rdma*
>  
>  RDMA Migration
> +M: Peter Xu <peterx@redhat.com>
> +M: Fabiano Rosas <farosas@suse.de>
>  R: Li Zhijian <lizhijian@fujitsu.com>
> -R: Peter Xu <peterx@redhat.com>
>  S: Odd Fixes
>  F: migration/rdma*
>  F: scripts/rdma-migration-helper.sh

Acked-by: Fabiano Rosas <farosas@suse.de>

