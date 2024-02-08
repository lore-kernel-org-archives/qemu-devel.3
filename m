Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4175C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 12:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY3m4-000175-Vr; Thu, 08 Feb 2024 07:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rY3m1-00016c-0P
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 07:45:01 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rY3lz-0002KC-Eu
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 07:45:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 36FF11FCE8;
 Thu,  8 Feb 2024 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707396296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=euEOCUnv7W10ZritYHhzhhGeyniSqB9yVg+BhmsCUr8=;
 b=bBVokycYZe3Qpp5AwrN5pYl/wdLJt5BxkG5MXAWpMCPLHI0mKxHLS6/tAnQXVnwRQYfQHT
 rRiXl8IU5NfCsnkUgrUpVC5YL+5EdmMDUmdZXXKvHF4YyDfwZfEVfmMK8Tu2EuWWxaWwis
 sdzOGJ64gUhKx1QnjKsmJM1Bvzc43qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707396296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=euEOCUnv7W10ZritYHhzhhGeyniSqB9yVg+BhmsCUr8=;
 b=/KLuyLLyGVVNgVNju4fgfMHIRsyOm4dBdVqCActJVbfwFDG3xgX6qPOoqJ6NYTPRXn5Esn
 F2qZQaI+TRkCklAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707396296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=euEOCUnv7W10ZritYHhzhhGeyniSqB9yVg+BhmsCUr8=;
 b=bBVokycYZe3Qpp5AwrN5pYl/wdLJt5BxkG5MXAWpMCPLHI0mKxHLS6/tAnQXVnwRQYfQHT
 rRiXl8IU5NfCsnkUgrUpVC5YL+5EdmMDUmdZXXKvHF4YyDfwZfEVfmMK8Tu2EuWWxaWwis
 sdzOGJ64gUhKx1QnjKsmJM1Bvzc43qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707396296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=euEOCUnv7W10ZritYHhzhhGeyniSqB9yVg+BhmsCUr8=;
 b=/KLuyLLyGVVNgVNju4fgfMHIRsyOm4dBdVqCActJVbfwFDG3xgX6qPOoqJ6NYTPRXn5Esn
 F2qZQaI+TRkCklAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3BF21326D;
 Thu,  8 Feb 2024 12:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ieJrHsfMxGVfSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 08 Feb 2024 12:44:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, peterx@redhat.com, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 1/2] migration/multifd: Cleanup TLS iochannel referencing
In-Reply-To: <20240208035126.370620-2-peterx@redhat.com>
References: <20240208035126.370620-1-peterx@redhat.com>
 <20240208035126.370620-2-peterx@redhat.com>
Date: Thu, 08 Feb 2024 09:44:53 -0300
Message-ID: <874jejcegq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bBVokycY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/KLuyLLy"
X-Spamd-Result: default: False [-6.26 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-2.45)[97.49%];
 MIME_GOOD(-0.10)[text/plain]; RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 36FF11FCE8
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> Commit a1af605bd5 ("migration/multifd: fix hangup with TLS-Multifd due to
> blocking handshake") introduced a thread for TLS channels, which will
> resolve the issue on blocking the main thread.  However in the same commit
> p->c is slightly abused just to be able to pass over the pointer "p" into
> the thread.
>
> That's the major reason we'll need to conditionally free the io channel in
> the fault paths.
>
> To clean it up, using a separate structure to pass over both "p" and "tioc"
> in the tls handshake thread.  Then we can make it a rule that p->c will
> never be set until the channel is completely setup.  With that, we can drop
> the tricky conditional unref of the io channel in the error path.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Ok, I'm convinced after reading your reply on the other thread.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

