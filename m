Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F6CCAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 21:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzM0h-0006qF-MF; Thu, 18 Sep 2025 17:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzM0f-0006q3-TV
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 17:17:45 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzM0d-0003nt-TL
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 17:17:45 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 976E533711;
 Thu, 18 Sep 2025 21:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758230260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CuvgcC+cAs3URyNEioePwzLQsKpr7P2tmbC1YtDy2LM=;
 b=PO/p8FilkNE2Z775ySHC3UuKo/LPBH2XlhRMfHrTIBbiDN+XjLpQnJCid8erg4V8HFgFE8
 wAPbwHSsPuYXrQl3NYo/fCUrZ5/V+MjbVi9y0r5PjHhnjD8s/lwJdRikRXBgkNUAU39oRA
 1SCp3GBesRXbzvTnq1R6Sf2B0HQuC4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758230260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CuvgcC+cAs3URyNEioePwzLQsKpr7P2tmbC1YtDy2LM=;
 b=J9ea68oqO9axTuxRiAiZww7KoQxtfeHBf3NYShKt1APHvGTtB5F36AzNj5BterGqhbI4zJ
 vzTre7BOz67yZeBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="PO/p8Fil";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=J9ea68oq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758230260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CuvgcC+cAs3URyNEioePwzLQsKpr7P2tmbC1YtDy2LM=;
 b=PO/p8FilkNE2Z775ySHC3UuKo/LPBH2XlhRMfHrTIBbiDN+XjLpQnJCid8erg4V8HFgFE8
 wAPbwHSsPuYXrQl3NYo/fCUrZ5/V+MjbVi9y0r5PjHhnjD8s/lwJdRikRXBgkNUAU39oRA
 1SCp3GBesRXbzvTnq1R6Sf2B0HQuC4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758230260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CuvgcC+cAs3URyNEioePwzLQsKpr7P2tmbC1YtDy2LM=;
 b=J9ea68oqO9axTuxRiAiZww7KoQxtfeHBf3NYShKt1APHvGTtB5F36AzNj5BterGqhbI4zJ
 vzTre7BOz67yZeBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F58D13A39;
 Thu, 18 Sep 2025 21:17:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Dye1L/N2zGjuRAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Sep 2025 21:17:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v3 0/2] migration/tls: Graceful shutdowns for main and
 postcopy channels
In-Reply-To: <20250918203937.200833-1-peterx@redhat.com>
References: <20250918203937.200833-1-peterx@redhat.com>
Date: Thu, 18 Sep 2025 18:17:37 -0300
Message-ID: <875xdfv4su.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 976E533711
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

> v3:
> - Patch 1
>   - Update qcrypto_tls_session_read() doc to reflect the new retval [Dan]
>   - Update commit message to explain the qatomic_read() change [Dan]
> - Patch 2 (old)
>   - Dropped for now, more at the end
>
> This is v3 of the series.
>
> Fabiano fixed graceful shutdowns for multifd channels previously:
>
> https://lore.kernel.org/qemu-devel/20250206175824.22664-1-farosas@suse.de/
>
> However we can still see an warning when running preempt unit test on TLS,
> even though migration functionality will not be affected:
>
> QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --full -r /x86_64/migration/postcopy/preempt/tls/psk
> ...
> qemu-kvm: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> ...
>
> It turns out this is because the crypto code only passes the ->shutdown
> field into the read function, however that value can change concurrently in
> another thread by a concurrent qio_channel_shutdown().
>
> Patch 1 should fix this issue.
>
> Patch 2 is something I found when looking at this problem, there's no known
> issues I am aware of with them, however I still think they're logically
> flawed, so I post them together here.
>
> Please review, thanks.
>
> ============= ABOUT OLD PATCH 2 ===================
>
> I dropped it for now to unblock almost patch 1, because patch 1 will fix a
> real warning that can be triggered for not only qtest but also normal tls
> postcopy migration.
>
> While I was looking at temporary settings for multifd send iochannels to be
> blocking always, I found I cannot explain how migration_tls_channel_end()
> currently works, because it writes to the multifd iochannels while the
> channels should still be owned (and can be written at the same time?) by
> the sender threads.  It sounds like a thread-safety issue, or is it not?
>

IIUC, the multifd channels will be stuck at p->sem because this is the
success path so migration will have already finished when we reach
migration_cleanup(). The ram/device state migration will hold the main
thread until the multifd channels finish transferring.

> Peter Xu (2):
>   io/crypto: Move tls premature termination handling into QIO layer
>   migration: Make migration_has_failed() work even for CANCELLING
>
>  include/crypto/tlssession.h | 10 +++-------
>  crypto/tlssession.c         |  7 ++-----
>  io/channel-tls.c            | 21 +++++++++++++++++++--
>  migration/migration.c       |  3 ++-
>  4 files changed, 26 insertions(+), 15 deletions(-)

