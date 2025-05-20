Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C01AC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 19:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHSI1-0002lb-It; Tue, 20 May 2025 15:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uHSHy-0002l8-Tt
 for qemu-devel@nongnu.org; Tue, 20 May 2025 15:06:10 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uHSHu-00084A-6u
 for qemu-devel@nongnu.org; Tue, 20 May 2025 15:06:10 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5DE251F7DF;
 Tue, 20 May 2025 19:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747767961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LBhs9K7cDJCD0mTJ0NAqOms7TMclS1Q931/0BZErBiA=;
 b=y2WhFH0JlrpsGfsALARFsKJ3Bv8owq/PQbZmtSfYVrQRPiaSUGcce6/MAoqPEOkIhN7uEX
 qDARxCQWudeVucoohotyC3BIblBo8W8giW6Ba6vwBM5XfvmQf2RGGmpCspJEWYEvy09FJa
 P0cqwCrdiZ0c4/Y4Vj19xKTeM8Y5hqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747767961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LBhs9K7cDJCD0mTJ0NAqOms7TMclS1Q931/0BZErBiA=;
 b=VGYFpZemiFSpWFvVPoJN8vUGw8Cxc32+nYaCtIwSq97gZtnLyrnpwKHzx1I25M1UFdHWOB
 YLoGxFvFe02wxHAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y2WhFH0J;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VGYFpZem
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747767961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LBhs9K7cDJCD0mTJ0NAqOms7TMclS1Q931/0BZErBiA=;
 b=y2WhFH0JlrpsGfsALARFsKJ3Bv8owq/PQbZmtSfYVrQRPiaSUGcce6/MAoqPEOkIhN7uEX
 qDARxCQWudeVucoohotyC3BIblBo8W8giW6Ba6vwBM5XfvmQf2RGGmpCspJEWYEvy09FJa
 P0cqwCrdiZ0c4/Y4Vj19xKTeM8Y5hqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747767961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LBhs9K7cDJCD0mTJ0NAqOms7TMclS1Q931/0BZErBiA=;
 b=VGYFpZemiFSpWFvVPoJN8vUGw8Cxc32+nYaCtIwSq97gZtnLyrnpwKHzx1I25M1UFdHWOB
 YLoGxFvFe02wxHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C94CC13888;
 Tue, 20 May 2025 19:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QDelIZjSLGjVaQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 May 2025 19:06:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yanfei Xu <yanfei.xu@bytedance.com>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, Yanfei Xu <yanfei.xu@bytedance.com>
Subject: Re: [RFC PATCH] migration/ram: avoid to do log clear in the last round
In-Reply-To: <20250514115827.3216082-1-yanfei.xu@bytedance.com>
References: <20250514115827.3216082-1-yanfei.xu@bytedance.com>
Date: Tue, 20 May 2025 16:05:57 -0300
Message-ID: <87zff75ch6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5DE251F7DF
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Yanfei Xu <yanfei.xu@bytedance.com> writes:

> There won't be any ram sync after the stage of save_complete, therefore
> it's unnecessary to do manually protect for dirty pages being sent. Skip
> to do this in last round can reduce noticeable downtime.
>
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> ---
> As I don't have proper machine to test this patch in qemu and verify if it has
> risks like in postcopy, colo and so on.(But I tested this idea on my rust VMM,
> it works and can reduce ~50ms for a 128GB guest). So I raise the patch with RFC
> for suggestions.
>
>  migration/ram.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index e12913b43e..2b169cdd18 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -838,7 +838,9 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>       * the page in the chunk we clear the remote dirty bitmap for all.
>       * Clearing it earlier won't be a problem, but too late will.
>       */
> -    migration_clear_memory_region_dirty_bitmap(rb, page);
> +    if (!rs->last_stage) {
> +        migration_clear_memory_region_dirty_bitmap(rb, page);
> +    }
>  
>      ret = test_and_clear_bit(page, rb->bmap);
>      if (ret) {

Well, it looks ok to me and passes all my tests.

Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>

