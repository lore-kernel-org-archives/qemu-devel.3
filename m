Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0325FD3F07E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7E9-00013L-7g; Wed, 28 Jan 2026 10:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl7E6-00012T-9i
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:13:02 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl7E4-0006t2-OA
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:13:02 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6DE3B5BCCE;
 Wed, 28 Jan 2026 15:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769613178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fi7Cq1Yy/eyvdJG/M8ov3aIA8+IZ+clidO/GyAlYrpQ=;
 b=vPYXKydz9q5KG2oBDXNY57GN5npX/JEaHsgCvYnpI5jghQ/0lWHwnpNNHtOana2PwqfJj6
 nwPgzXJ5Ek+sXdXNNA4SsMcSIOR+ESP9IRhInMWnNJEeNWhwcOUndlGdKzsnBqDzJy5sW6
 atz9qb3qbmPojp0bJKUKB2HQuoNqS3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769613178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fi7Cq1Yy/eyvdJG/M8ov3aIA8+IZ+clidO/GyAlYrpQ=;
 b=2g7bAL5VT6Bt4MkBqPbTg5aKGCVKyOaOcuLjtkCyifuSz5DYIpDl/mniQMgPItPXvCIeB6
 AQg/997fCQzo7NAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zsSILCy5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=k87vhFf0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769613177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fi7Cq1Yy/eyvdJG/M8ov3aIA8+IZ+clidO/GyAlYrpQ=;
 b=zsSILCy5lOMP5Vp4sY+Q+WmRSVghjek/ZZsmxqR20iHz0kW8XXnwNHniq4g/VGvh4FAvnY
 QdZMiuWWdIfmJppwwJbIdg293PdFmzREYv3HDJAbk1KBNVUfIkkl7fc1qUoH+C33u8uWLz
 cFsohAtYSbrY5Is89xBMOut1ErQhOVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769613177;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fi7Cq1Yy/eyvdJG/M8ov3aIA8+IZ+clidO/GyAlYrpQ=;
 b=k87vhFf0sMiOjGpSV5j6h6uTl3a3YGyryArnQ1J+jZYrzcvu5B5nR9LMo7Id3nwRFu+1CE
 svO2jMsH25HdRRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7C143EA61;
 Wed, 28 Jan 2026 15:12:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Pfb5JXgnemmrLAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Jan 2026 15:12:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 12/24] migration/colo: Send device states without
 copying buffer
In-Reply-To: <20260127185254.3954634-13-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
 <20260127185254.3954634-13-peterx@redhat.com>
Date: Wed, 28 Jan 2026 12:12:54 -0300
Message-ID: <87h5s5g495.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[web.de];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6DE3B5BCCE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

> We can safely use the async version of put buffer here because the qemufile
> will be flushed right away.
>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/colo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index 1b94e0f0ee..0b1a58cd8f 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -486,7 +486,8 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>          goto out;
>      }
>  
> -    qemu_put_buffer(s->to_dst_file, bioc->data, bioc->usage);
> +    /* We can use async put because flush happens right away */
> +    qemu_put_buffer_async(s->to_dst_file, bioc->data, bioc->usage, false);
>      ret = qemu_fflush(s->to_dst_file);
>      if (ret < 0) {
>          goto out;

Reviewed-by: Fabiano Rosas <farosas@suse.de>

