Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE7CD3F074
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7Jg-0004DO-Ry; Wed, 28 Jan 2026 10:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl7Je-0004BJ-K0
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:18:47 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl7Jd-0001Z1-1Y
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:18:46 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 43E5E5BCEF;
 Wed, 28 Jan 2026 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769613519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=48JAsfA6vxYTtDMSXqG258Z07SyH06wqbiVuZZIcvNY=;
 b=Du73aOssPSlHzuhUO/2uA+BdXRSQ815yRVy4OAEhx+6fECInwxCX33S+emzU4jQ/gXF0+N
 boi6z1DZdUJ0W+0aMGBAcDKqYimszzohiQ7Kc8MsUKcTA2d08FWS0/7xLHlhFdw4BC8eoY
 nRSvzKJPOAhNiv7vvtc04u7tv589Jyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769613519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=48JAsfA6vxYTtDMSXqG258Z07SyH06wqbiVuZZIcvNY=;
 b=wch/FhjVYg9r9E7oKDYi1WAGn7CKuMwwLCHcV653tvPsn6Ps6AgDI2ueaA5Sh/+LRnnWRb
 3E36amY91p7OSGCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769613514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=48JAsfA6vxYTtDMSXqG258Z07SyH06wqbiVuZZIcvNY=;
 b=T0WVUHIsnzOJpTLJNoY8CZhTZt28UoYBZT2B6yUYtauEZv3z/LOsYbYHcQi1kJG0rkjB67
 Y3Z6B9Oa7M89XKRZaDB63WlSNjPml8x+g0PL9Rlmyq3hLkfYz2/pVPY+I62XqOP1x5O2+x
 fV5oyRMnG81YYbpNCv01dAHkvqnH/Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769613514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=48JAsfA6vxYTtDMSXqG258Z07SyH06wqbiVuZZIcvNY=;
 b=/d9Xk108sWQhManitGe7rhmj/l5obI02l3uCbHgPVLVnF+C3v4VGCdaU8da47bQj1i6Rka
 5FK/Wer/Ti/y70AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 691743EA62;
 Wed, 28 Jan 2026 15:18:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rgKLOMgoemk9MgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Jan 2026 15:18:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 13/24] migration/postcopy: Send device states without
 copying buffer
In-Reply-To: <20260127185254.3954634-14-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
 <20260127185254.3954634-14-peterx@redhat.com>
Date: Wed, 28 Jan 2026 12:18:25 -0300
Message-ID: <87ecn9g3zy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[web.de]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Peter Xu <peterx@redhat.com> writes:

> Put buffer can be async as long as the flush happens before the buffer will
> be recycled / reused.  Do it for postcopy package data.  Quick measurement
> shows a small VM the time to push / flush the package shrinks from 91us to
> 38us.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/savevm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 9d2109718a..d41e89228d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1136,7 +1136,8 @@ int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
>      trace_qemu_savevm_send_packaged();
>      qemu_savevm_command_send(f, MIG_CMD_PACKAGED, 4, (uint8_t *)&tmp);
>  
> -    qemu_put_buffer(f, buf, len);
> +    /* We can use async put because the qemufile will be flushed right away */
> +    qemu_put_buffer_async(f, buf, len, false);
>      qemu_fflush(f);
>  
>      return 0;

Reviewed-by: Fabiano Rosas <farosas@suse.de>

