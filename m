Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061F1D637C7
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 21:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBKgk-00067X-Ui; Wed, 13 Nov 2024 16:14:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBKgi-000677-1d
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 16:14:08 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBKgg-0003zH-9Y
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 16:14:07 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 18D7B1F7A5;
 Wed, 13 Nov 2024 21:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731532441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6XBC8XCrNWsYs7PXPf96UPGfKjn7tw+an0toAJ4Sg3g=;
 b=g0fq//l5km53XH2U+PHX7MZbDjDtTeINqhDQnRZW7antBWJMj+c6ocgU2GT5J+n/3DsyH5
 m0zCiX+D7mouT+3P+3h76bHzwctF3OPQ3+3UD4TzsFV89Jj1kFT05Wo0U5jC90tGiXnGEO
 h3wgmoQkXWlSN9OyIKypDCzAM8o9dC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731532441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6XBC8XCrNWsYs7PXPf96UPGfKjn7tw+an0toAJ4Sg3g=;
 b=0sMmbrF7ujI84ZkB8XzUAABcWjCis6RW0Yejx87hNsCps7/oRqkIB5R74mtCWB0ZpCX4Pu
 fc1uH6xnb5k1VcDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731532441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6XBC8XCrNWsYs7PXPf96UPGfKjn7tw+an0toAJ4Sg3g=;
 b=g0fq//l5km53XH2U+PHX7MZbDjDtTeINqhDQnRZW7antBWJMj+c6ocgU2GT5J+n/3DsyH5
 m0zCiX+D7mouT+3P+3h76bHzwctF3OPQ3+3UD4TzsFV89Jj1kFT05Wo0U5jC90tGiXnGEO
 h3wgmoQkXWlSN9OyIKypDCzAM8o9dC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731532441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6XBC8XCrNWsYs7PXPf96UPGfKjn7tw+an0toAJ4Sg3g=;
 b=0sMmbrF7ujI84ZkB8XzUAABcWjCis6RW0Yejx87hNsCps7/oRqkIB5R74mtCWB0ZpCX4Pu
 fc1uH6xnb5k1VcDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85C5413301;
 Wed, 13 Nov 2024 21:14:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8zYCE5gWNWfcCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 21:14:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Dmitry Frolov <frolov@swemel.ru>, lvivier@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org, Dmitry Frolov
 <frolov@swemel.ru>
Subject: Re: [PATCH] tests/qtest: add TIMEOUT_MULTIPLIER
In-Reply-To: <20241113094342.282676-2-frolov@swemel.ru>
References: <20241113094342.282676-2-frolov@swemel.ru>
Date: Wed, 13 Nov 2024 18:13:57 -0300
Message-ID: <87bjyij0q2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.21 / 50.00]; BAYES_HAM(-2.91)[99.62%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email, swemel.ru:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Dmitry Frolov <frolov@swemel.ru> writes:

> Some tests need more time when qemu is built with
> "--enable-asan --enable-ubsan"
>
> As was discussed here:
> https://patchew.org/QEMU/20241112120100.176492-2-frolov@swemel.ru/
>
> TIMEOUT_MULTIPLIER enviroment variable will be
> a useful option, allowing non-invasive timeouts
> increasing for a specific build.
>
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>

Tested-by: Fabiano Rosas <farosas@suse.de>

and queued for qtest.

