Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB16FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHO50-0003ac-IZ; Mon, 27 Apr 2026 11:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wHO4r-0003aJ-4c
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:40:53 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wHO4o-00028B-G1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:40:51 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 554A75BCCD;
 Mon, 27 Apr 2026 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777304448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/uiYnWu1b4rX/JrqXNIc1s4aISJjoa2VVVRvrGImHqE=;
 b=R+FTWhx5J8Trg5EgwqjujxDz95uQvsSiLeEy2YuwMLux3sL/vWefAGwhrWxz7pCrPlwIbj
 PjZJixsrk5x6y/6uVZyzh7ZoDhVBviZ5nrHs93wgN34b2wK0/U+i03V9HFDN+73OJ96QG5
 puZiipbPyLN4x3AE/nzz6WEqC2s9cXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777304448;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/uiYnWu1b4rX/JrqXNIc1s4aISJjoa2VVVRvrGImHqE=;
 b=N9rWT3iWX23ahOdy3PtzNKgGO89678PGYI53Sd60BKXAqRoNqEJnvUjN6RDfES9MF016Of
 wYmq/9n+/JNiXgBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=R+FTWhx5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N9rWT3iW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777304448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/uiYnWu1b4rX/JrqXNIc1s4aISJjoa2VVVRvrGImHqE=;
 b=R+FTWhx5J8Trg5EgwqjujxDz95uQvsSiLeEy2YuwMLux3sL/vWefAGwhrWxz7pCrPlwIbj
 PjZJixsrk5x6y/6uVZyzh7ZoDhVBviZ5nrHs93wgN34b2wK0/U+i03V9HFDN+73OJ96QG5
 puZiipbPyLN4x3AE/nzz6WEqC2s9cXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777304448;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/uiYnWu1b4rX/JrqXNIc1s4aISJjoa2VVVRvrGImHqE=;
 b=N9rWT3iWX23ahOdy3PtzNKgGO89678PGYI53Sd60BKXAqRoNqEJnvUjN6RDfES9MF016Of
 wYmq/9n+/JNiXgBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E77A4593B0;
 Mon, 27 Apr 2026 15:40:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id STtPLX+D72kRYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Apr 2026 15:40:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/qtest: Make qtest_get_arch() cleverer
In-Reply-To: <20260427150007.1185559-1-peter.maydell@linaro.org>
References: <20260427150007.1185559-1-peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 12:40:41 -0300
Message-ID: <87h5owif7q.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 554A75BCCD
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The qtest_get_arch() function tries to determine the architecture
> under test by extracting it from the binary name as provided in
> QTEST_QEMU_BINARY.  The current logic finds the last '-' in the
> string and assumes everything beyond it is the architecture name.
> Although we also look for the substring "-system-", the only effect
> this check has is that we will exit with an error if it is not
> present.
>
> Because the logic at the moment is very simplistic, although
> it is possible to provide more complex commands than a bare
> QEMU binary path, such as:
>   QTEST_QEMU_BINARY='rr record ./qemu-system-x86_64'
> it is not possible to provide extra arguments to QEMU, such as:
>   QTEST_QEMU_BINARY='./qemu-system-x86_64 -d trace:foo'
>
> Because the "-system-" check and the "find the architecture" check
> are not the same, the latter example will pass the "we found
> -system-" check and not notice that the "architecture name" it has
> found starts further on in the string; so rather than printing an
> error it will return "d trace:foo" to the test.
>
> Improve the "find the architecture name" logic to look for the
> rightmost occurrence of the substring "-system-" in
> QTEST_QEMU_BINARY, and take the architecture name as starting there
> and continuing until the first whitespace character or the end of the
> string.
>
> Because we now need to potentially modify the environment variable
> string to terminate the architecture name if it is not the last part
> of the string, we make a copy of it which we cache in a static
> variable.  This lets us avoid having to modify all the callers to get
> them to take ownership of the returned string.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I wanted to be able to pass trace arguments to a QEMU to help
> debug a failing test; in the past I've done this by writing
> a little wrapper shell script with the right shaped name, but
> we can do better than that.
>

There's QTEST_TRACE which can inject any command line option if you give
it a tracepoint name as first string:

QTEST_TRACE="cpu_reset -d guest_errors"

Maybe we should just rename it to QTEST_QEMU_ARGS.


