Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EC3D10366
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0n8-0001ix-N4; Tue, 25 Nov 2025 16:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vO0mQ-00017H-QS
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:40:59 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vO0mP-0003tc-4O
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:40:58 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CCA0522A0A;
 Tue, 25 Nov 2025 21:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1764106854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1yAh3Cf4tneLmoMw+WYJia0u6mv9b27HwXIJ0gsG4To=;
 b=uDpC+MjMqAkgfm/xJ2g2awty023ndGLZ0N7esN99DjXOOUIzUSDjLrB5q2Tbk9xEmo9p+P
 Kogi3yhGadiXzT/l2l+1jHwvTs+opmKg636hbdpoRM9gAa1/93++FIMV7C0RDDGlvuUvqo
 JaPn2yDUO4Y7W2mBBB9FfM2lZAR0TuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1764106854;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1yAh3Cf4tneLmoMw+WYJia0u6mv9b27HwXIJ0gsG4To=;
 b=bJKvpQqzSMpQz3RlDSeMoOaz2HqKvv48/ms9oWAAP6DPXBoJPst+fxE23ROiDCFwbeDKM4
 Q40RJDYSCuu9zYAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1764106853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1yAh3Cf4tneLmoMw+WYJia0u6mv9b27HwXIJ0gsG4To=;
 b=fMY06k9nVfnoB7GFVTAvfhWQKKmVJ8VCjruh424cC5osJf+vMIGxiCFz6l+kEYz0I0EqNS
 kcKL2RQAzgEeBB/0aEeiaqS0JTejBh76YFG5DNVzYEJUy2PrVGcF3s/P6VJq49lwJSREj5
 M/KYdty3YkM/xaNFbam4HtGlPKL0KwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1764106853;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1yAh3Cf4tneLmoMw+WYJia0u6mv9b27HwXIJ0gsG4To=;
 b=tWEenmbod9ViC0+Yq0lEV+nqyVymktH9HEVb61M7VLVRLZSAhQnX53uPvDOoZlgR6bE5vl
 UsXZLReVafPrk8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 476573EA63;
 Tue, 25 Nov 2025 21:40:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P+9kAmUiJmnBBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 25 Nov 2025 21:40:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com, Pawel Zmarzly
 <pzmarzly0@gmail.com>, michel@michel-slm.name
Subject: Re: [PATCH RFC] tests/migration-test: Add mapped-ram +
 ignore-shared test
In-Reply-To: <20251125194003.833842-1-peterx@redhat.com>
References: <20251125194003.833842-1-peterx@redhat.com>
Date: Tue, 25 Nov 2025 18:40:50 -0300
Message-ID: <87qztleqot.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,michel-slm.name];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

> It was broken, add a test for it.
>
> NOTE: here we do not really need any shared memory blocks, enabling of both
> of the features alone would cover the ramblock layout difference that the
> bug triggers.
>
> Cc: Pawel Zmarzly <pzmarzly0@gmail.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: michel@michel-slm.name
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>
> RFC because currently master branch is broken with it, so need to merge
> only after a proper fix lands.
>
> Pawel, feel free to take this with your fix when repost, or I'll manage.
> ---
>  tests/qtest/migration/file-tests.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
> index 4d78ce0855..ab1b477bdf 100644
> --- a/tests/qtest/migration/file-tests.c
> +++ b/tests/qtest/migration/file-tests.c
> @@ -137,6 +137,22 @@ static void test_precopy_file_mapped_ram(void)
>      test_file_common(&args, true);
>  }
>  
> +static void test_precopy_file_mapped_ram_ignore_share(void)

s/share/shared/

Acked-by: Fabiano Rosas <farosas@suse.de>

