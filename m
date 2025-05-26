Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBBAC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 15:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJZo2-0006ve-2K; Mon, 26 May 2025 11:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uJZnz-0006vL-MU
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:31:59 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uJZnx-0007vX-EJ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:31:59 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19FC71F793;
 Mon, 26 May 2025 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748273514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hi8vFGGqXjk3GPhO18lRdZsbA1TazfxWNr5qmC52cIQ=;
 b=GdvRGp37FEm1WqqFecRT6fNJdZqMo1AMgpLT/u6nfGCbFb/6k/cMx4gle95M9Mdxmzfd75
 u60Vwkzmb/L/ti1qxWCvyQ+/KYL6H4cp1HvW5Jvkv70ShIU1eIobJrFQFgV0gdrzwaqQXT
 zjoDNM845edMXMA2Tlli5GMXGrCslvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748273514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hi8vFGGqXjk3GPhO18lRdZsbA1TazfxWNr5qmC52cIQ=;
 b=LCGXDqXmKM12oRDd1F6BzzsoS+KXRHq+UpWNZ6T8+UPeV2ZGt0XONBpfU7EPnVsVvAm2Cu
 h9RDOeFXN4zZDoBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GdvRGp37;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LCGXDqXm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748273514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hi8vFGGqXjk3GPhO18lRdZsbA1TazfxWNr5qmC52cIQ=;
 b=GdvRGp37FEm1WqqFecRT6fNJdZqMo1AMgpLT/u6nfGCbFb/6k/cMx4gle95M9Mdxmzfd75
 u60Vwkzmb/L/ti1qxWCvyQ+/KYL6H4cp1HvW5Jvkv70ShIU1eIobJrFQFgV0gdrzwaqQXT
 zjoDNM845edMXMA2Tlli5GMXGrCslvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748273514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hi8vFGGqXjk3GPhO18lRdZsbA1TazfxWNr5qmC52cIQ=;
 b=LCGXDqXmKM12oRDd1F6BzzsoS+KXRHq+UpWNZ6T8+UPeV2ZGt0XONBpfU7EPnVsVvAm2Cu
 h9RDOeFXN4zZDoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 879301397F;
 Mon, 26 May 2025 15:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kHGFEWmJNGhJYwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 May 2025 15:31:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] tests/qtest: Remove migration-helpers.c
In-Reply-To: <87msazkinq.fsf@pond.sub.org>
References: <20250523123023.19284-1-farosas@suse.de>
 <87msazkinq.fsf@pond.sub.org>
Date: Mon, 26 May 2025 12:31:50 -0300
Message-ID: <87frgrv15l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 19FC71F793
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
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

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Commit 407bc4bf90 ("qapi: Move include/qapi/qmp/ to include/qobject/")
>> brought the migration-helpers.c back by mistake. This file has been
>> replaced with migration/migration-qmp.c and
>> migration/migration-util.c.
>>
>> Fixes: 407bc4bf90 ("qapi: Move include/qapi/qmp/ to include/qobject/")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> I have no idea how that happened.  Rebase accident, perhaps?  Thanks for
> cleaning up the mess I made!
>
> Your patch does what it says on the tin, but there's another dangling
> #include:
>
>     $ git-grep migration-helpers
> --> tests/qtest/dbus-vmstate-test.c:#include "migration-helpers.h"
>     tests/qtest/migration-helpers.c:#include "migration-helpers.h"
>
> Missed in commit b7d7f723a985 (tests/qtest/migration: Rename
> migration-helpers.c).  Looks like dbus-vmstate-test is never compiled in
> CI.  Dig, dig...
>
>     dbus_daemon = find_program('dbus-daemon', required: false)
>     if dbus_daemon.found() and gdbus_codegen.found()
>       # Temporarily disabled due to Patchew failures:
> -->   #qtests_i386 += ['dbus-vmstate-test']
>       dbus_vmstate1 = custom_target('dbus-vmstate description',
>                                     output: ['dbus-vmstate1.h', 'dbus-vmstate1.c'],
>                                     input: meson.project_source_root() / 'backends/dbus-vmstate1.xml',
>                                     command: [gdbus_codegen, '@INPUT@',
>                                               '--interface-prefix', 'org.qemu',
>                                               '--generate-c-code', '@BASENAME@']).to_list()
>     else
>       dbus_vmstate1 = []
>     endif
>
> It's been "emporarily" disabled for more than five years:
>
> commit d46f81cb746d18b4530b5fe63e75b11f6b926f1f
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Tue Mar 10 15:21:41 2020 +0000
>
>     tests: Disable dbus-vmstate-test
>     
>     The dbus-vmstate-test has been failing in some Patchew configs
>     since about the 6th March:
>     
>       dbus-daemon[9321]: Could not get password database information for UID of current process: User "???" unknown or no memory to allocate password entry
>     
>       **
>       ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connection: assertion failed (err == NULL): The connection is closed (g-io-error-quark, 18)
>       cleaning up pid 9321
>       ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connection: assertion failed (err == NULL): The connection is closed (g-io-error-quark, 18)
>       make: *** [/tmp/qemu-test/src/tests/Makefile.include:632: check-qtest-x86_64] Error 1
>       make: *** Waiting for unfinished jobs....
>     
>     It's not clear why this is happening (perhaps a recently revealed
>     race condition or a change in the patchew build environment?).
>     
>     For the moment, disable this test so that patchew test runs are
>     useful and don't email the list with spurious failure mails.
>     
>     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>     Message-id: 20200310152141.13959-1-peter.maydell@linaro.org
>

Thanks for digging this up. I'll see what can be done about this test.

