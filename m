Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59449C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 20:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkUF4-0004c6-TT; Tue, 18 Feb 2025 15:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tkUF0-0004bH-Bp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:30:52 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tkUEy-0004wj-2O
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:30:49 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8D14D21125;
 Tue, 18 Feb 2025 20:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739910643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mEa2c2lH+kqtMuhUKKLEIUSaDokdmC508h15cc6NpAQ=;
 b=09U2KdOBn63lJp1fQHf+m80aBfh2LblhPGYrwQz0GgkZWACJ4sW4jXSicOGtE52cZgUf0L
 8/5ozEdiyMODzu4Rj8tR4IxR7BErLT8mBVu2B6iqx4xWeIU7YFaRPMuais4wy8tx/QdckX
 cfN95E6I48/4j5GV5uiHiOUP8ALDu6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739910643;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mEa2c2lH+kqtMuhUKKLEIUSaDokdmC508h15cc6NpAQ=;
 b=zq0w82XPFiNIiJk5Ok+OMJ8hdVCvnXy1noA3wsOx/5qgwnyu1w5fqhxkcKwqheDSeyy9Jb
 ZN0IctTWURsZ/vDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739910643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mEa2c2lH+kqtMuhUKKLEIUSaDokdmC508h15cc6NpAQ=;
 b=09U2KdOBn63lJp1fQHf+m80aBfh2LblhPGYrwQz0GgkZWACJ4sW4jXSicOGtE52cZgUf0L
 8/5ozEdiyMODzu4Rj8tR4IxR7BErLT8mBVu2B6iqx4xWeIU7YFaRPMuais4wy8tx/QdckX
 cfN95E6I48/4j5GV5uiHiOUP8ALDu6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739910643;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mEa2c2lH+kqtMuhUKKLEIUSaDokdmC508h15cc6NpAQ=;
 b=zq0w82XPFiNIiJk5Ok+OMJ8hdVCvnXy1noA3wsOx/5qgwnyu1w5fqhxkcKwqheDSeyy9Jb
 ZN0IctTWURsZ/vDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05E52132C7;
 Tue, 18 Feb 2025 20:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mvKFLfLttGflVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 18 Feb 2025 20:30:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Li Zhijian via <qemu-devel@nongnu.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 1/2] migration: Prioritize RDMA in ram_save_target_page()
In-Reply-To: <20250218074345.638203-1-lizhijian@fujitsu.com>
References: <20250218074345.638203-1-lizhijian@fujitsu.com>
Date: Tue, 18 Feb 2025 17:30:40 -0300
Message-ID: <8734gb9erz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: permerror client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Li Zhijian via <qemu-devel@nongnu.org> writes:

> Address an error in RDMA-based migration by ensuring RDMA is prioritized
> when saving pages in `ram_save_target_page()`.
>
> Previously, the RDMA protocol's page-saving step was placed after other
> protocols due to a refactoring in commit bc38dc2f5f3. This led to migration
> failures characterized by unknown control messages and state loading errors
> destination:
> (qemu) qemu-system-x86_64: Unknown control message QEMU FILE
> qemu-system-x86_64: error while loading state section id 1(ram)
> qemu-system-x86_64: load of migration failed: Operation not permitted
> source:
> (qemu) qemu-system-x86_64: RDMA is in an error state waiting migration to abort!
> qemu-system-x86_64: failed to save SaveStateEntry with id(name): 1(ram): -1
> qemu-system-x86_64: rdma migration: recv polling control error!
> qemu-system-x86_64: warning: Early error. Sending error.
> qemu-system-x86_64: warning: rdma migration: send polling control error
>
> RDMA migration implemented its own protocol/method to send pages to
> destination side, hand over to RDMA first to prevent pages being saved by
> other protocol.
>
> Fixes: bc38dc2f5f3 ("migration: refactor ram_save_target_page functions")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  migration/ram.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 6f460fd22d2..635a2fe443a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1964,6 +1964,11 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
>      ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>      int res;
>  
> +    /* Hand over to RDMA first */
> +    if (control_save_page(pss, offset, &res)) {
> +        return res;
> +    }
> +

Can we hoist that migrate_rdma() from inside the function? Since the
other paths already check first before calling their functions.

>      if (!migrate_multifd()
>          || migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
>          if (save_zero_page(rs, pss, offset)) {
> @@ -1976,10 +1981,6 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
>          return ram_save_multifd_page(block, offset);
>      }
>  
> -    if (control_save_page(pss, offset, &res)) {
> -        return res;
> -    }
> -
>      return ram_save_page(rs, pss);
>  }

