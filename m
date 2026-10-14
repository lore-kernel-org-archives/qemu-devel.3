Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6ECCC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6ql-0006w0-Bg; Wed, 14 Oct 2026 17:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xH6qi-0006va-B3
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:49:25 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xH6qg-0004RX-QB
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:49:24 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A56D1F7D2;
 Wed, 14 Oct 2026 21:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792014559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8h9DP/QKhQ3Skl6nCL92t+mXBADVesZkBZpFtr2f18=;
 b=bDjiAx1wgH32IznrT3myBrB00YHiEJ/7xxV3UDvIHdjenDiG1GCIXKsRGrR2I00fYLU4Jp
 +wL7xf57NtGyZGWe3oNa9hjcKhp0owRzRfPH/ZDSRjcBxzB+9hD6ArMr1kCBEhWVMSKfh+
 sqCV6qP4tsidzoHXk81+B+xCvyhTR6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792014559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8h9DP/QKhQ3Skl6nCL92t+mXBADVesZkBZpFtr2f18=;
 b=HYUZyf+7zCRvbkiQLQPjN4VOrWvYUvFCUZo4CsuewBqrcvDIO+yIH2imjtuwcP3MHmX0wG
 bTSWghTtfGL8jaBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792014558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8h9DP/QKhQ3Skl6nCL92t+mXBADVesZkBZpFtr2f18=;
 b=FQIkH2RpHyQVFRC/xMoJxQoDAcSsOnGRxyJD6B+XwIj0YSSGfK4m3d0PIdNsPQXnLSETPL
 QiX9gVx3WZ28lCyJoppZopEjg6UXHfEJN6tuA0AHCNrZr4OiwLUS3oWuOyedU/oODSP4Q/
 JDV4LQXoL9aPJLnzXGMS1C8gfce2kwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792014558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8h9DP/QKhQ3Skl6nCL92t+mXBADVesZkBZpFtr2f18=;
 b=MgrpxBxFkGUXR72mGkq2MMtPfNZ57m85IuOyABx9yQJxY4i40EJIKigfNEnjM6wzr8R8Fu
 /NDuGiQT0eWjXRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F16751368E;
 Wed, 14 Oct 2026 21:49:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QzFHJd34z2r1XwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Oct 2026 21:49:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin
 <jmarcin@redhat.com>
Subject: Re: [PATCH v2 1/7] tests/migration-test: Add multifd+postcopy test
 for preempt recovery
In-Reply-To: <20261006182046.3767283-2-peterx@redhat.com>
References: <20261006182046.3767283-1-peterx@redhat.com>
 <20261006182046.3767283-2-peterx@redhat.com>
Date: Wed, 14 Oct 2026 18:49:11 -0300
Message-ID: <87h5iolzqg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
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

> We have one for TLS, but we don't have the non-TLS version.  Add it.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration/postcopy-tests.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
> index 13a5759655..6c4fd31152 100644
> --- a/tests/qtest/migration/postcopy-tests.c
> +++ b/tests/qtest/migration/postcopy-tests.c
> @@ -89,6 +89,15 @@ static void test_multifd_postcopy_preempt(char *name, MigrateCommon *args)
>      test_postcopy_common(args);
>  }
>  
> +static void test_multifd_postcopy_preempt_recovery(char *name,
> +                                                   MigrateCommon *args)
> +{
> +    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> +    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
> +
> +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
> +}
> +
>  void migration_test_add_postcopy(MigrationTestEnv *env)
>  {
>      migration_test_add_postcopy_smoke(env);
> @@ -113,6 +122,8 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
>                             test_multifd_postcopy);
>          migration_test_add("/migration/multifd+postcopy/preempt/plain",
>                             test_multifd_postcopy_preempt);
> +        migration_test_add("/migration/multifd+postcopy/preempt/recovery/plain",
> +                           test_multifd_postcopy_preempt_recovery);
>          if (env->is_x86) {
>              migration_test_add("/migration/postcopy/suspend",
>                                 test_postcopy_suspend);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

