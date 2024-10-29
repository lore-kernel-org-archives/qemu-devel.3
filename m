Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72930D3A68D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 19:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5rWa-00023q-Dt; Tue, 29 Oct 2024 15:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t5rWZ-00023P-0S
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:05:03 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t5rWX-000217-CK
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:05:02 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5561821EF9;
 Tue, 29 Oct 2024 19:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730228699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tS66NKYOeyFC+bFSpSpCfyMUPiJ2shTVe6SEBQb/DR0=;
 b=lTdzbv4BzC3Lp8iHtZLmQXeqMMb2gdWcwxTt65We/TOzaarNpyZaGVPhPA1R4HXYnVCj89
 KZDGlyUSP0GadNtNsciYS3j+qH/YY/gqx+XNh+x7zdAZOvlEo4R+Y6nn+EzqUbcbtGuu77
 RYBEMdrgKTVIUKx3EuG6v2gclMsC7U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730228699;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tS66NKYOeyFC+bFSpSpCfyMUPiJ2shTVe6SEBQb/DR0=;
 b=U+bNDZ4z8tzUz1bWZWuPlKgioOgx75m1QR/Rh25H2ulwTSC7hYvO2EfsGWgsIgLrcAnoiU
 Kx4VSXCxvwv5/pCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730228699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tS66NKYOeyFC+bFSpSpCfyMUPiJ2shTVe6SEBQb/DR0=;
 b=lTdzbv4BzC3Lp8iHtZLmQXeqMMb2gdWcwxTt65We/TOzaarNpyZaGVPhPA1R4HXYnVCj89
 KZDGlyUSP0GadNtNsciYS3j+qH/YY/gqx+XNh+x7zdAZOvlEo4R+Y6nn+EzqUbcbtGuu77
 RYBEMdrgKTVIUKx3EuG6v2gclMsC7U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730228699;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tS66NKYOeyFC+bFSpSpCfyMUPiJ2shTVe6SEBQb/DR0=;
 b=U+bNDZ4z8tzUz1bWZWuPlKgioOgx75m1QR/Rh25H2ulwTSC7hYvO2EfsGWgsIgLrcAnoiU
 Kx4VSXCxvwv5/pCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1D44136A5;
 Tue, 29 Oct 2024 19:04:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qBy5JdoxIWeNUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 29 Oct 2024 19:04:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
 peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 4/8] migration: Drop migration_is_setup_or_active()
In-Reply-To: <20241024213056.1395400-5-peterx@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-5-peterx@redhat.com>
Date: Tue, 29 Oct 2024 16:04:56 -0300
Message-ID: <87wmhqbuhz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.27 / 50.00]; BAYES_HAM(-2.97)[99.89%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

> This helper is mostly the same as migration_is_running(), except that one
> has COLO reported as true, the other has CANCELLING reported as true.
>
> Per my past years experience on the state changes, none of them should
> matter.
>
> To make it slightly safer, report both COLO || CANCELLING to be true in
> migration_is_running(), then drop the other one.  We kept the 1st only
> because the name is simpler, and clear enough.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

