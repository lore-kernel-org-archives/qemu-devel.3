Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E48D46BF9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 19:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlBdn-0006FG-RO; Wed, 28 Jan 2026 14:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vlBdP-00063c-FY
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 14:55:29 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vlBdK-00023K-8d
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 14:55:23 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ECD2033D4C;
 Wed, 28 Jan 2026 19:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769630121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nOv0BRzMNebvPaAa0fGZZ/V5lspOjz1ISD2qsxbb/tA=;
 b=w3E1bI+xlaGjxP6bZ07C8ciFXKQteMj2/6fTgfr/R6tex92Us2iPdRj24eWTJVxHtEaGjJ
 7wmR87+M62HTsCorwNBP6Eatpi7eEt5hCZVEPddrFV2ioBy8NId/JIozSF7BzGMV2G/mLt
 p0vLz5djOmlW7N9rqXm9M6SQq7KvVEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769630121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nOv0BRzMNebvPaAa0fGZZ/V5lspOjz1ISD2qsxbb/tA=;
 b=ygyYA7Jp/yFZSc94imHFgTX+TfBLfGOXq07JlpON8tn8VfNOBmYJUWqehCCtgYuMAPJtr/
 C4RJUEQJTeuEPxBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769630120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nOv0BRzMNebvPaAa0fGZZ/V5lspOjz1ISD2qsxbb/tA=;
 b=k/uBOoKlSMIO/CR8Gxu//rnbzuJnSHgA/5AeZdO3Iw1+P28nVVq5YkyC03zApnxqX+wYQy
 r8mZvD/Bctmp9lqtwMBoFnc2/c7blVdkkMZ+TfbQPFMhBbHwW+i2hC5xHp0E3f861lGURS
 PY6UR++yOOY5XbzCKpxz2d8Mlrj6lWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769630120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nOv0BRzMNebvPaAa0fGZZ/V5lspOjz1ISD2qsxbb/tA=;
 b=SrzI6KD2D9EJ1OBvBzdVLDjXnwQAdXbf291UPUHuIKsWF3tUTZ2mssO4F4qKGwhzxm5eRS
 Quo9CWJRTVWJcWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 637443EA61;
 Wed, 28 Jan 2026 19:55:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4aqZCahpemkUOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Jan 2026 19:55:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Subject: Re: [PATCH v2 23/24] migration: Simplify qemu_save_device_state()
In-Reply-To: <20260127185254.3954634-24-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
 <20260127185254.3954634-24-peterx@redhat.com>
Date: Wed, 28 Jan 2026 16:55:17 -0300
Message-ID: <87ms1xecm2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[web.de];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de,infradead.org,xen.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, infradead.org:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> This function is used by both COLO and Xen.  Simplify it with two changes:
>
> - Remove checks on qemu_savevm_se_iterable(): this is not needed as
>   vmstate_save() also checks for "save_state() || vmsd" instead.  Here,
>   save_setup() (or say, iterable states) should be mutual exclusive to
>   "save_state() || vmsd" [*].
>
> - Remove migrate_error_propagate(): both of the users are not using live
>   migration framework, but raw vmstate operations.  Error propagation is
>   not needed for query-migrate persistence.
>

s/not needed/only needed/

I can fixup if no repost.

> [*] One tricky user is VFIO, who provided _both_ save_state() and
> save_setup().  However VFIO mustn't have been used in these paths or it
> means both COLO and Xen have ignored VFIO data instead (that is,
> qemu_savevm_se_iterable() will return true for VFIO). Hence, this change is
> safe.
>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Paul Durrant <paul@xen.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> ---
>  migration/savevm.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 130b9764a7..b29272db3b 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1897,13 +1897,8 @@ int qemu_save_device_state(QEMUFile *f)
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>          int ret;
>  
> -        if (qemu_savevm_se_iterable(se)) {
> -            continue;
> -        }
>          ret = vmstate_save(f, se, NULL, &local_err);
>          if (ret) {
> -            migrate_error_propagate(migrate_get_current(),
> -                                    error_copy(local_err));
>              error_report_err(local_err);
>              return ret;
>          }

