Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AB8D44D54
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8fje-0008Bw-5z; Wed, 06 Nov 2024 08:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8fjb-00088E-Vw
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:06:08 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8fjY-0000u4-V4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:06:07 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8554E21A44;
 Wed,  6 Nov 2024 13:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730898362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uW50Zw6iYoaYh9sOx08chGWiuvn2hbUKMkj2LafXYJ4=;
 b=1u6ZygJ5fJjkSViWX/kS0FasGuRqeqfjELPQVZzMdHE8Jel/fski+/EsyCorJNtUqLu7YG
 Y3SHZlGsVAVcRwzrm3l3hhb9uBQA/JdaRjapjk53sB2Iq2YoXPYWBu1VdmbeR8I6JBziYT
 VK3xRvYxAzAELEjRLb5ALiq9xL8Z9rM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730898362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uW50Zw6iYoaYh9sOx08chGWiuvn2hbUKMkj2LafXYJ4=;
 b=xqdMgmTdowtaaFI9yncjrPN/7VJn2+ACcee6oQP6nDAnDTEnrdHkdn9WB3x0QuKEX95X80
 2AwA1Z/GQzcMdCCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1u6ZygJ5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xqdMgmTd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730898362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uW50Zw6iYoaYh9sOx08chGWiuvn2hbUKMkj2LafXYJ4=;
 b=1u6ZygJ5fJjkSViWX/kS0FasGuRqeqfjELPQVZzMdHE8Jel/fski+/EsyCorJNtUqLu7YG
 Y3SHZlGsVAVcRwzrm3l3hhb9uBQA/JdaRjapjk53sB2Iq2YoXPYWBu1VdmbeR8I6JBziYT
 VK3xRvYxAzAELEjRLb5ALiq9xL8Z9rM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730898362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uW50Zw6iYoaYh9sOx08chGWiuvn2hbUKMkj2LafXYJ4=;
 b=xqdMgmTdowtaaFI9yncjrPN/7VJn2+ACcee6oQP6nDAnDTEnrdHkdn9WB3x0QuKEX95X80
 2AwA1Z/GQzcMdCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1076013736;
 Wed,  6 Nov 2024 13:06:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vQ3eMblpK2cJHAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 06 Nov 2024 13:06:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 12/22] tests/qtest/migration: Split TLS tests from
 migration-test.c
In-Reply-To: <ZytP7hMbUkkDS1MX@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-13-farosas@suse.de> <ZytP7hMbUkkDS1MX@redhat.com>
Date: Wed, 06 Nov 2024 10:05:59 -0300
Message-ID: <87o72s1phk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8554E21A44
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Nov 05, 2024 at 03:08:27PM -0300, Fabiano Rosas wrote:
>> The migration-test.c file has become unwieldy large. It's quite
>> confusing to navigate with all the test definitions mixed with hook
>> definitions. The TLS tests make this worse with ifdef'ery.
>>=20
>> Since we're planning on having a smaller set of tests to run as smoke
>> testing on all architectures, I'm taking the time to split some tests
>> into their own file.
>>=20
>> Move the TLS tests into a file of their own.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/meson.build                  |   8 +-
>>  tests/qtest/migration-test.c             | 788 +---------------------
>>  tests/qtest/migration/migration-common.h |   6 +
>>  tests/qtest/migration/tls-tests.c        | 790 +++++++++++++++++++++++
>>  4 files changed, 803 insertions(+), 789 deletions(-)
>>  create mode 100644 tests/qtest/migration/tls-tests.c
>
>
>> diff --git a/tests/qtest/migration/migration-common.h b/tests/qtest/migr=
ation/migration-common.h
>> index 8d0081c698..c546e92259 100644
>> --- a/tests/qtest/migration/tls-tests.c
>> +++ b/tests/qtest/migration/tls-tests.c
>
>
>> +
>> +void migration_test_add_tls(MigrationTestEnv *env)
>> +{
>> +    tmpfs =3D env->tmpfs;
>> +
>> +    migration_test_add("/migration/precopy/unix/tls/psk",
>> +                       test_precopy_unix_tls_psk);
>> +
>
> ...snip...
>
>> +}
>
> Looking at this, and considering the later patch which introduces
> 'make qtest-<subsystem>' support, I wonder if we actually need to
> have a single 'migration-test' binary. Why not just add a main()
> method to this  test-tests.c, and have a 'migration-test-tls'
> binary ?

I did that initially, but then I realised it duplicates the -qmp, -util
and -common helpers into every new test binary. With the current split,
that would be 7x.

Another point is that we can't then implement the smoke tests like in
this series, we'd have to make every migration-foo-test.c choose between
smoke or full tests individually. Which is doable, but it seemed against
your and Alex's suggestions of having 2 separate binaries.

If we're fine with the duplication in the build, I could go back to that
approach. Each main() function would need to look like this:
=20=20=20=20=20=20
    if (g_test_thorough() || env->has_kvm) {
        /* add all tests */
        migration_test_add();
        migration_test_add();
        ...
    } else {
        /* only the smoke suite */
        migration_test_add_smoke();
    }

>
> "make qtest-migration" would provoide a way to run the same level
> of functionality seen when everything was in one 'migration-test'
> binary.

Yes... but not quite, because running all tests with gdb or valgrind
attached is something that I do frequently, e.g.:

PYTHON=3D$(which python3.11) \
QTEST_QEMU_BINARY_SRC=3D\'valgrind -q --leak-check=3Dfull --show-leak-kinds=
=3Ddefinite,indirect \
--sim-hints=3Dlax-ioctls --suppressions=3D${BASEDIR}/valgrind-suppressions =
./qemu-system-${ARCH}\' \
QTEST_QEMU_BINARY=3D./qemu-system-${ARCH} ./tests/qtest/migration-test -r /=
${ARCH}/migration || exit 1

QTEST_QEMU_BINARY=3D./qemu-system-x86_64 QTEST_QEMU_BINARY_SRC=3D'gdb -q
--ex "set pagination off" --ex "set print thread-events off" --ex
"handle SIGUSR1 noprint" --ex "handle SIGPIPE noprint" --ex "run" --ex
"quit \$_exitcode" --args ./qemu-system-x86_64'
./tests/qtest/migration-test

This could probably be done with meson directly, if that happens to fit
their opinionated view of the world, but I'd rather not delve into that.
On the other hand, maybe it's not a big deal and I can live with only
running a group of tests with the -r or -p flag instead of all of them.

>
> With regards,
> Daniel

