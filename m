Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F0BCFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMctj-0007sn-Sk; Fri, 21 Nov 2025 20:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vMbp8-0002jL-Cg
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:49:59 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vMbn6-0008Iw-SW
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:49:55 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A94735BCC3;
 Fri, 21 Nov 2025 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763747426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I7KHBREE1e4L/Jn7uLJUAmaCsFAXpLmGXbwNhR4TXIk=;
 b=kM/9tDlVGcj5u4Il7Wm4OtbVeLga7IbkqgkRrpH7DMeMVMB4s4k+bjst25qZq3c4iZGo12
 bujT0O794d1UCUJfNbXTpzSE6ZP5xVdUv7a7dSS6zqv6KMjAdNpDGbutJbmVtRLAYgju5e
 o5fQN09/Ej/zAoXLg3iBJW4RzHAX4io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763747426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I7KHBREE1e4L/Jn7uLJUAmaCsFAXpLmGXbwNhR4TXIk=;
 b=LFz2kS46mzRj5ndyTDixVQHUafm020YTMOVpoHNB77AL+5DzjcH/ObOhoDFfufmEOTktoa
 M9yh5VXQzq9z/VAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763747426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I7KHBREE1e4L/Jn7uLJUAmaCsFAXpLmGXbwNhR4TXIk=;
 b=kM/9tDlVGcj5u4Il7Wm4OtbVeLga7IbkqgkRrpH7DMeMVMB4s4k+bjst25qZq3c4iZGo12
 bujT0O794d1UCUJfNbXTpzSE6ZP5xVdUv7a7dSS6zqv6KMjAdNpDGbutJbmVtRLAYgju5e
 o5fQN09/Ej/zAoXLg3iBJW4RzHAX4io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763747426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I7KHBREE1e4L/Jn7uLJUAmaCsFAXpLmGXbwNhR4TXIk=;
 b=LFz2kS46mzRj5ndyTDixVQHUafm020YTMOVpoHNB77AL+5DzjcH/ObOhoDFfufmEOTktoa
 M9yh5VXQzq9z/VAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 264883EA61;
 Fri, 21 Nov 2025 17:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qKQ4NmGmIGnDWQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Nov 2025 17:50:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 0/4] tests/migration-test: Introduce mem_type
In-Reply-To: <20251117223908.415965-1-peterx@redhat.com>
References: <20251117223908.415965-1-peterx@redhat.com>
Date: Fri, 21 Nov 2025 14:50:23 -0300
Message-ID: <878qfzff6o.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> This is a small refactor series to merge memory_backend and use_shmem
> parameters that migration-test uses to specify memory types.  No rush for
> having it for 10.2, but since this is test code, we can also consider it as
> the current two parameters are definitely confusing..
>
> This series will also make guest-memfd support extremely easy to add too.
>
> Comments welcomed, thanks.
>
> Peter Xu (4):
>   tests/migration-test: Introduce MemType
>   tests/migration-test: Merge shmem_opts into memory_backend
>   tests/migration-test: Add MEM_TYPE_SHMEM
>   tests/migration-test: Use MEM_TYPE_MEMFD for memory_backend
>
>  tests/qtest/migration/framework.h  |  26 +++++--
>  tests/qtest/migration/cpr-tests.c  |   8 +-
>  tests/qtest/migration/framework.c  | 113 ++++++++++++++++++++---------
>  tests/qtest/migration/misc-tests.c |   2 +-
>  4 files changed, 104 insertions(+), 45 deletions(-)

Series:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

