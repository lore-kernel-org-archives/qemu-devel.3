Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FD1E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNvio-0004tp-8v; Wed, 18 Dec 2024 10:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNvim-0004tY-5g
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:12:20 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNvik-0002Hp-3H
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:12:19 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B75B81F396;
 Wed, 18 Dec 2024 15:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734534734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kg2I0Rv0QX6iUOKg3eiNNb6AJbn7YiCh0Cz7INSwnVM=;
 b=Ddzudcc140AeaDcrNDcH5fkiq8LLRQNuZWsuXaKpsQeLYo3BBM1UwSA3/ZVcy3nrzKM/hM
 h4SIxh9up6UMbxmaJzQQNiwuKFe3WgT1/LjaElWun6VY4kD0SrAaLSTzjvjGfrTmmPLObZ
 OBtWaYVxNXbJhfgCOfaOKej1BpdlT8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734534734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kg2I0Rv0QX6iUOKg3eiNNb6AJbn7YiCh0Cz7INSwnVM=;
 b=h7s7wDz2YMNUAbCgaxV6AFCDoPGqBXRlF6mTEzWLmr+zR7nUm6k2NDwFQg3rV+LhFyrZvi
 QLpPTm6appwq7eCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734534734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kg2I0Rv0QX6iUOKg3eiNNb6AJbn7YiCh0Cz7INSwnVM=;
 b=Ddzudcc140AeaDcrNDcH5fkiq8LLRQNuZWsuXaKpsQeLYo3BBM1UwSA3/ZVcy3nrzKM/hM
 h4SIxh9up6UMbxmaJzQQNiwuKFe3WgT1/LjaElWun6VY4kD0SrAaLSTzjvjGfrTmmPLObZ
 OBtWaYVxNXbJhfgCOfaOKej1BpdlT8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734534734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kg2I0Rv0QX6iUOKg3eiNNb6AJbn7YiCh0Cz7INSwnVM=;
 b=h7s7wDz2YMNUAbCgaxV6AFCDoPGqBXRlF6mTEzWLmr+zR7nUm6k2NDwFQg3rV+LhFyrZvi
 QLpPTm6appwq7eCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39250132EA;
 Wed, 18 Dec 2024 15:12:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8c1TAE7mYmcfMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 18 Dec 2024 15:12:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest/migration: Restore include for postcopy
In-Reply-To: <Z2KGUnQIcxZNohzi@redhat.com>
References: <20241217212201.23376-1-farosas@suse.de> <Z2Hxe0PyVACaKIlZ@x1n>
 <Z2KGUnQIcxZNohzi@redhat.com>
Date: Wed, 18 Dec 2024 12:12:11 -0300
Message-ID: <87ldwduit0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Dec 17, 2024 at 04:47:39PM -0500, Peter Xu wrote:
>> On Tue, Dec 17, 2024 at 06:22:01PM -0300, Fabiano Rosas wrote:
>> > Commit 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to
>> > utils") moved the ufd_version_check() function to another file but
>> > failed to bring along the <sys/syscall> include, which is necessary to
>> > pull in <asm/unistd.h> for __NR_userfaultd.
>> >=20
>> > Restore the missing include.
>>=20
>> Ohhhhhhh.. so postcopy tests will always be skipped as of now?  Maybe wo=
rth
>> explicit mention that in the commit message if so, only when you merge.
>>=20
>> >=20
>> > While here, remove the ifdef __linux__ that's redundant and fix a
>> > couple of typos.
>> >=20
>> > Fixes: 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to u=
tils")
>> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>=20
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>=20
>> Maybe we don't need to be as careful on old kernels anymore especially in
>> tests, because userfaultfd syscall existed for ~10 years. So if we want =
we
>> can start requiring __NR_userfaultfd present for __linux__, then no way =
to
>> miss such spot next time.
>
> Yes, I think that check is obsolete, based on our supported platforms
> list. It would suffice to just check __linux__.

This breaks the cross builds. It seems the __NR_userfaultfd was actually
stopping several archs from reaching ufd_version_check(). Since
<sys/ioctl.h> is under HOST_X86_64, these new instances now fail to find
the 'ioctl' symbol:

https://gitlab.com/farosas/qemu/-/pipelines/1594332399

Of course I could just include <sys/ioctl.h> unconditionally, but the
fact that new code is not being built means the assumption that we can
imply __NR_userfaultfd from __linux__ alone is not correct.

