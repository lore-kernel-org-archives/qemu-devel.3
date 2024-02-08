Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76908C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8lE-0001DL-1Z; Thu, 08 Feb 2024 13:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rY8lC-0001DB-JC
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:04:30 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rY8lA-0005KA-HV
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:04:29 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A0DEE2220E;
 Thu,  8 Feb 2024 18:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707415466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clwWsGB3HoObznGwy+h4k8HK1/UkDBM4GUApuYx8DgY=;
 b=JnsgHyTbxUfMoYI2RovfjWDN6vEjgEYLHnM6iL41NUlL3zlrIjL6WXcxKd6ZE97Q1g1Ih1
 OYJZbLBFDD1Sg/l0vnPfKQjKSTiAMCzzSLek38+wczv98v54msg45K/lzv9Rupdf1pLMoV
 S4Z/3t41LL/xYsEDZHNqbT7dT6EC/M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707415466;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clwWsGB3HoObznGwy+h4k8HK1/UkDBM4GUApuYx8DgY=;
 b=+KY6STTC/BSZUI8JlrgpIJjiSciyoyLN8v4HmgASA1HTLuivXVuiWzDiP9CuUJObodC9fc
 gnx9BiVVLd/UFbDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707415466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clwWsGB3HoObznGwy+h4k8HK1/UkDBM4GUApuYx8DgY=;
 b=JnsgHyTbxUfMoYI2RovfjWDN6vEjgEYLHnM6iL41NUlL3zlrIjL6WXcxKd6ZE97Q1g1Ih1
 OYJZbLBFDD1Sg/l0vnPfKQjKSTiAMCzzSLek38+wczv98v54msg45K/lzv9Rupdf1pLMoV
 S4Z/3t41LL/xYsEDZHNqbT7dT6EC/M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707415466;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clwWsGB3HoObznGwy+h4k8HK1/UkDBM4GUApuYx8DgY=;
 b=+KY6STTC/BSZUI8JlrgpIJjiSciyoyLN8v4HmgASA1HTLuivXVuiWzDiP9CuUJObodC9fc
 gnx9BiVVLd/UFbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A62E13984;
 Thu,  8 Feb 2024 18:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tfuLOKkXxWXQJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 08 Feb 2024 18:04:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com> 
Subject: Re: migration-test random intermittent failure, openbsd VM
In-Reply-To: <CAFEAcA8p9BKCrn9EfFXTpHE+5w-_8zhtE_52SpZLuS-+zpF5Gg@mail.gmail.com>
References: <CAFEAcA8p9BKCrn9EfFXTpHE+5w-_8zhtE_52SpZLuS-+zpF5Gg@mail.gmail.com>
Date: Thu, 08 Feb 2024 15:04:23 -0300
Message-ID: <87plx6bzo8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JnsgHyTb;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+KY6STTC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,linaro.org:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: A0DEE2220E
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Peter Maydell <peter.maydell@linaro.org> writes:

+cc Daniel.

> Random intermittent in migration-test when running the tests
> in the openbsd VM (i.e. what you get from 'make -C build vm-build-openbsd=
')
> Any ideas?

Where's your HEAD at?

>
> 106/847 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
>            ERROR          157.51s   killed by signal 6 SIGABRT
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95
> stderr:
> qemu-system-x86_64: multifd_send_sync_main: channel 12 has already quit
> qemu-system-x86_64: TLS handshake failed: The TLS connection was
> non-properly terminated.
> qemu-system-x86_64: TLS handshake failed: Error in the push function.
> qemu-system-x86_64: Failed to connect to '127.0.0.1:23083': Address
> already in use

Looks like a legitimate port clash here when doing the TLS
connection. It seems the test is not prepared to deal with it.

> qemu-system-x86_64: TLS handshake failed: Error in the push function.
> qemu-system-x86_64: TLS handshake failed: Error in the push function.
> qemu-system-x86_64: TLS handshake failed: Error in the push function.
> qemu-system-x86_64: TLS handshake failed: Error in the push function.
> **
> ERROR:../src/tests/qtest/migration-helpers.c:180:check_migration_status:
> assertion failed (current_status !=3D "failed"): ("failed" !=3D "failed")
> qemu-system-x86_64: TLS handshake failed: Error in the push function.
>
> (test program exited with status code -6)
>
>
> thanks
> -- PMM

