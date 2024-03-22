Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096B8C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfct-0003O2-9D; Fri, 22 Mar 2024 10:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rnfcq-0003DJ-LB
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:12:04 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rnfco-0004Bl-G2
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:12:03 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 12C9738646;
 Fri, 22 Mar 2024 14:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711116721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IorRbZAygtCqqSFe05lghGg0J9T477xtskVZqmw9Gtw=;
 b=TUrKp50SPqSXVG29UKi1HjkbsTfNu89wMCLW7WPqCKwGoSOF2xrxlPXoYQ+lT2QxZwFesL
 m+rYOkcNYq/2PqE8qbJMAQ2XibxbXGBBc/dWO0+3OCpW0bl+c6+YaENmN3Mybk7CcBdoSQ
 BEgMop0s/78xCFQ6Jpfp8rQZ0Uyusaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711116721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IorRbZAygtCqqSFe05lghGg0J9T477xtskVZqmw9Gtw=;
 b=MBSGzOblf9RKXwTaTVu4LvifTYzyiE4fdl27S4k3QAM5VIPuyL12SojfL2EFDSAe6uYNJC
 UX2QmQGP9y1ygYAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711116721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IorRbZAygtCqqSFe05lghGg0J9T477xtskVZqmw9Gtw=;
 b=TUrKp50SPqSXVG29UKi1HjkbsTfNu89wMCLW7WPqCKwGoSOF2xrxlPXoYQ+lT2QxZwFesL
 m+rYOkcNYq/2PqE8qbJMAQ2XibxbXGBBc/dWO0+3OCpW0bl+c6+YaENmN3Mybk7CcBdoSQ
 BEgMop0s/78xCFQ6Jpfp8rQZ0Uyusaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711116721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IorRbZAygtCqqSFe05lghGg0J9T477xtskVZqmw9Gtw=;
 b=MBSGzOblf9RKXwTaTVu4LvifTYzyiE4fdl27S4k3QAM5VIPuyL12SojfL2EFDSAe6uYNJC
 UX2QmQGP9y1ygYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 935E913688;
 Fri, 22 Mar 2024 14:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DRufFrCR/WWjKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 22 Mar 2024 14:12:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, berrange@redhat.com, John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH 3/3] qapi: Fix bogus documentation of
 query-migrationthreads
In-Reply-To: <20240322135117.195489-4-armbru@redhat.com>
References: <20240322135117.195489-1-armbru@redhat.com>
 <20240322135117.195489-4-armbru@redhat.com>
Date: Fri, 22 Mar 2024 11:11:58 -0300
Message-ID: <87zfuql5jl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TUrKp50S;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MBSGzObl
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.50 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-2.99)[99.93%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 12C9738646
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Markus Armbruster <armbru@redhat.com> writes:

> The doc comment documents an argument that doesn't exist.  Would
> fail compilation if it was marked up correctly.  Delete.
>
> The Returns: section fails to refer to the data type, leaving the user
> to guess.  Fix that.
>
> The command name violates QAPI naming rules: it should be
> query-migration-threads.  Too late to fix.
>
> Reported-by: John Snow <jsnow@redhat.com>
> Fixes: 671326201dac (migration: Introduce interface query-migrationthreads)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

