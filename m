Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8D6D44D57
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 12:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8f7K-0006Zd-46; Wed, 06 Nov 2024 07:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8f7H-0006ZE-NX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:26:31 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8f7F-0004dK-2H
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:26:30 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8111521B5A;
 Wed,  6 Nov 2024 12:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730895987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SO/NQmfXrbSFdFIGg74In/vjx/28U2h7dmVirLIwqjQ=;
 b=UfHSvWXwc5eqQuyghyL/KwlwRhnYeLWlDs34MKoVDQ16fdsUn1Ly3PxsPYpEXrdflgMhcC
 9fVSkWBqmTkbcXM7RMFgzSxw8wnmZ8rovvxYkFp6PA9Vi4fE3KF2ZvqvA4CWcJceYMFDDT
 TMZ25JoDwcjAMNIogUttrcfX9CMxFv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730895987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SO/NQmfXrbSFdFIGg74In/vjx/28U2h7dmVirLIwqjQ=;
 b=1csRu/SY/v4MjTlP3ZDMsufxSn/ZpYwWoJw3EtrJNRwlykiae5rniU9XnvO3vIn68433P3
 Zdr23ApXVSWWFVAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UfHSvWXw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="1csRu/SY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730895987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SO/NQmfXrbSFdFIGg74In/vjx/28U2h7dmVirLIwqjQ=;
 b=UfHSvWXwc5eqQuyghyL/KwlwRhnYeLWlDs34MKoVDQ16fdsUn1Ly3PxsPYpEXrdflgMhcC
 9fVSkWBqmTkbcXM7RMFgzSxw8wnmZ8rovvxYkFp6PA9Vi4fE3KF2ZvqvA4CWcJceYMFDDT
 TMZ25JoDwcjAMNIogUttrcfX9CMxFv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730895987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SO/NQmfXrbSFdFIGg74In/vjx/28U2h7dmVirLIwqjQ=;
 b=1csRu/SY/v4MjTlP3ZDMsufxSn/ZpYwWoJw3EtrJNRwlykiae5rniU9XnvO3vIn68433P3
 Zdr23ApXVSWWFVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AB2D137C4;
 Wed,  6 Nov 2024 12:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lr/aMHJgK2e6DgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 06 Nov 2024 12:26:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 11/22] tests/qtest/migration: Move common test code
In-Reply-To: <ZytNb_nTrePsYabA@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-12-farosas@suse.de> <ZytNb_nTrePsYabA@redhat.com>
Date: Wed, 06 Nov 2024 09:26:24 -0300
Message-ID: <87ttck1rbj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8111521B5A
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Nov 05, 2024 at 03:08:26PM -0300, Fabiano Rosas wrote:
>> Put the common test code in a separate file. Leave only individual
>> test functions and their static helpers in migration-test.c.
>>=20
>> This moves the shared:
>>=20
>>  test_postcopy_common
>>  test_postcopy_recovery_common
>>  test_precopy_common
>>  test_file_common
>>  migrate_precopy_tcp_multifd_start_common
>>  migrate_start
>>  migrate_end
>>  migration_get_env
>>  migration_env_clean
>>=20
>> and some of their static helpers to migrate-common.c.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/meson.build                  |    1 +
>>  tests/qtest/migration-test.c             | 1124 +---------------------
>>  tests/qtest/migration/bootfile.c         |    2 +-
>>  tests/qtest/migration/bootfile.h         |    2 +-
>>  tests/qtest/migration/migration-common.c |  963 ++++++++++++++++++
>>  tests/qtest/migration/migration-common.h |  214 ++++
>>  tests/qtest/migration/migration-util.h   |   13 -
>
> Looking at these I guess I'd ask the question of what is the rule for
> deciding whether to put something in -common vs in -util ?
>
> Both names sounds like being a general "bag of bits", so it isn't
> obvious to me what their distinct roles are.
>

The idea was to make -util the general bag of bits just like
migration-helpers is currently.

-common should be the more "important" migration-specific functions,
code that we spend more time reading and that are actually responsible
for the results of the tests. Consider:

static void test_multifd_file_mapped_ram_fdset_dio(void)
{
    ...
    if (!probe_o_direct_support(tmpfs)) {          <--- just a helper
        g_test_skip("Filesystem does not support O_DIRECT");
        return;
    }

    test_file_common(&args, true);  <--- actually doing the heavy-lifting
}

We could to some renaming and restructuring, but I think the distinction
is important. We already have it today, what is -common is all stuffed
into migration-test.c and the rest is in migration-helpers.c.

>>  7 files changed, 1193 insertions(+), 1126 deletions(-)
>>  create mode 100644 tests/qtest/migration/migration-common.c
>>  create mode 100644 tests/qtest/migration/migration-common.h
>>=20
>
> With regards,
> Daniel

