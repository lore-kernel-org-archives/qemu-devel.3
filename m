Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC108F43824
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 14:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD1P1-0003na-UW; Wed, 15 Apr 2026 10:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wD1Oz-0003jZ-OX
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 10:39:37 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wD1Oy-0001lr-2k
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 10:39:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 458155BE44;
 Wed, 15 Apr 2026 14:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776263974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9dAr+/8x33VxEYHjHhFuXCbHNp3lZhkN3hzBxgOVk6w=;
 b=YSBH1tziefnAPrNtB0geIkm7Mv1fwaEARPwAEjtR6ctgbusefbZxvCFXetNIzVCNEfpDHU
 cALx9cRf9YbVa93THWU8xP9zTMxxkgZJfAUYKBe3PfxwtFEg/4vbDHfOLs/cwXTYnFMxU9
 P36bILixiDnnLypRCx5SlYKWYh7KNf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776263974;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9dAr+/8x33VxEYHjHhFuXCbHNp3lZhkN3hzBxgOVk6w=;
 b=x+o+RpMiG65CcCViSkvCdRoxUTEpjpGpHX4HDzbcIl505agd6psniJ/YUjnnchlRxRE9r0
 1TLpbvwNqRYyymDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YSBH1tzi;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=x+o+RpMi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776263974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9dAr+/8x33VxEYHjHhFuXCbHNp3lZhkN3hzBxgOVk6w=;
 b=YSBH1tziefnAPrNtB0geIkm7Mv1fwaEARPwAEjtR6ctgbusefbZxvCFXetNIzVCNEfpDHU
 cALx9cRf9YbVa93THWU8xP9zTMxxkgZJfAUYKBe3PfxwtFEg/4vbDHfOLs/cwXTYnFMxU9
 P36bILixiDnnLypRCx5SlYKWYh7KNf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776263974;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9dAr+/8x33VxEYHjHhFuXCbHNp3lZhkN3hzBxgOVk6w=;
 b=x+o+RpMiG65CcCViSkvCdRoxUTEpjpGpHX4HDzbcIl505agd6psniJ/YUjnnchlRxRE9r0
 1TLpbvwNqRYyymDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D55874BA67;
 Wed, 15 Apr 2026 14:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aca4KCWj32kZLAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 15 Apr 2026 14:39:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v1] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_test_apply
In-Reply-To: <20260414223718.23965-1-farosas@suse.de>
References: <20260414223718.23965-1-farosas@suse.de>
Date: Wed, 15 Apr 2026 11:39:27 -0300
Message-ID: <87zf34xp7k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,szmigiero.name:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 458155BE44
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

Fabiano Rosas <farosas@suse.de> writes:

> Use QAPI_CLONE_MEMBERS instead of making an assignment. The QAPI
> method makes the handling of the TLS strings more intuitive because it
> clones them as well.
>
> This also fixes a segfault when a NULL TLS option is accessed as part
> of a validation check for another option (e.g. in the zero-copy +
> multifd compression case). Details follow:
>
> Currently, after copying s->parameters to the temporary
> MigrationParameters object before migrate_params_check(), the
> references in temporary object to the TLS options are dropped, either
> because:
>
> a) the user set a new option, in which case that's fine as
>    s->parameters still holds the reference to the old memory or,
>
> b) the user did not set a new option, in which case keeping the
>    references in the temporary object would later cause them to be
>    freed along with it, leading to double-free when s->parameters is
>    also freed later on.
>
> In this second case, it was overlooked that the TLS options can be
> accessed already during migrate_params_check() as part of validation
> of another option. Those pointers should not have been cleared.
>
> Using QAPI_CLONE_MEMBERS fixes the issue because the temporary object
> is not stealing a reference from s->parameters anymore.
>
> Fixes: aed97f0563 ("migration: Normalize tls arguments")
> Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Link: https://lore.kernel.org/r/a65a1049-9f19-460a-8e27-a62bb30d2727@maciej.szmigiero.name
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> NOTE#1: For the release we could have a simpler fix just checking for
> NULL, but that would allow two unsupported configurations to be
> accepted: zero-copy with either multifd compression or TLS.
>

Peter Xu just pointed out on IRC that it's actually only the zero-copy +
TLS configuration that will be allowed with the simpler fix. I think
it's best we go that route instead and hold this patch until after the
release.

