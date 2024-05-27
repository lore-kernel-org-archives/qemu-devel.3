Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2A7C25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 23:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBjJw-0006NY-ER; Mon, 27 May 2024 19:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sBjJu-0006Ms-Hy
 for qemu-devel@nongnu.org; Mon, 27 May 2024 18:59:58 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sBjJs-0002a0-P3
 for qemu-devel@nongnu.org; Mon, 27 May 2024 18:59:58 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D5FA1FFCB;
 Mon, 27 May 2024 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716850793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YkOKnEojlfWQPlxxO6l6jWk9fpMLbslJLa7y1qW4LvQ=;
 b=2YwjGRw4rF/2MgC1+B0FPSAtWHLaB0lPAKNPnjkuy3JXhXa2mLsV4AXhz/dY13hiH2PLOo
 aHEn9BPdJLMw5KlP/k7Pd/g0i/uXI40BZQNsy2eNh5gitaADV8xwNZUL01bU0McndV+Gmt
 veNf5kPafZ7V+5qDV0Gl9SDUAZvYPGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716850793;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YkOKnEojlfWQPlxxO6l6jWk9fpMLbslJLa7y1qW4LvQ=;
 b=Yo5tH3OrQCsymg2Pcwm95E4PBBjfwz4jdfSvNqeFV2cnyxU3dvNZzSmG4QiY4KrghZs/Mo
 aMSzVMXFxFmwfuDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2YwjGRw4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Yo5tH3Or
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716850793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YkOKnEojlfWQPlxxO6l6jWk9fpMLbslJLa7y1qW4LvQ=;
 b=2YwjGRw4rF/2MgC1+B0FPSAtWHLaB0lPAKNPnjkuy3JXhXa2mLsV4AXhz/dY13hiH2PLOo
 aHEn9BPdJLMw5KlP/k7Pd/g0i/uXI40BZQNsy2eNh5gitaADV8xwNZUL01bU0McndV+Gmt
 veNf5kPafZ7V+5qDV0Gl9SDUAZvYPGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716850793;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YkOKnEojlfWQPlxxO6l6jWk9fpMLbslJLa7y1qW4LvQ=;
 b=Yo5tH3OrQCsymg2Pcwm95E4PBBjfwz4jdfSvNqeFV2cnyxU3dvNZzSmG4QiY4KrghZs/Mo
 aMSzVMXFxFmwfuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD44F13A6B;
 Mon, 27 May 2024 22:59:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x4n0HGgQVWZAWgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 May 2024 22:59:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Marc-?=
 =?utf-8?Q?Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>, Het Gala
 <het.gala@nutanix.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 3/4] tests/qtest/migration: Add support for simple
 device tests
In-Reply-To: <ZlT3ORBU6-FbRXda@x1n>
References: <20240523201922.28007-1-farosas@suse.de>
 <20240523201922.28007-4-farosas@suse.de> <ZlT3ORBU6-FbRXda@x1n>
Date: Mon, 27 May 2024 19:59:50 -0300
Message-ID: <87wmneg8t5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2D5FA1FFCB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, May 23, 2024 at 05:19:21PM -0300, Fabiano Rosas wrote:
>> The current migration-tests are almost entirely focused on catching
>> bugs on the migration code itself, not on the device migration
>> infrastructure (vmstate). That means we miss catching some low hanging
>> fruits that would show up immediately if only we had the device in
>> question present in the VM.
>> 
>> Add a list of devices to include by default in the migration-tests,
>> starting with one that recently had issues, virtio-gpu. Also add an
>> environment variable QTEST_DEVICE_OPTS to allow test users to
>> experiment with different devices or device options.
>> 
>> Do not run every migration test with the devices because that would
>> increase the complexity of the command lines and, as mentioned, the
>> migration-tests are mostly used to test the core migration code, not
>> the device migration. Add a special value QTEST_DEVICE_OPTS=all that
>> enables testing with devices.
>> 
>> Notes on usage:
>> 
>> For this new testing mode, it's not useful to run all the migration
>> tests, a single test would probably suffice to catch any issues, so
>> provide the -p option to migration-test and the test of your choice.
>> 
>> Like with the cross-version compatibility tests in CI and the recently
>> introduced vmstate-static-checker test, to be of any use, a test with
>> devices needs to be run against a different QEMU version, like so:
>> 
>> $ cd build
>> $ QTEST_DEVICE_OPTS=all \
>>  QTEST_QEMU_BINARY=./qemu-system-x86_64 \
>>  QTEST_QEMU_BINARY_DST=../build-previous/qemu-system-x86_64 \
>>  ./tests/qtest/migration-test -p /x86_64/migration/precopy/tcp/plain
>> 
>> $ cd build
>> $ QTEST_DEVICE_OPTS='-device virtio-net' \
>>  QTEST_QEMU_BINARY=./qemu-system-x86_64 \
>>  QTEST_QEMU_BINARY_DST=../build-previous/qemu-system-x86_64 \
>>  ./tests/qtest/migration-test -p /x86_64/migration/precopy/tcp/plain
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration-test.c | 19 +++++++++++++++++--
>>  1 file changed, 17 insertions(+), 2 deletions(-)
>> 
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 2253e0fc5b..35bb224d18 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -71,6 +71,13 @@ static QTestMigrationState dst_state;
>>  #define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
>>  #define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
>>  
>> +/*
>> + * The tests using DEFAULT_DEVICES need a special invocation and
>> + * cannot be reached from make check, so don't bother with the
>> + * --without-default-devices build.
>
> What's this "--without-default-devices"?

A configure option. It removes from the build any devices that are
marked as default. It's an endless source of bugs because it is supposed
to be paired with a config file that adds back some of the removed
devices, but there's nothing enforcing that so we always run it as is
and generate a broken QEMU binary.

So anything in the tests that refer to devices should first check if
that QEMU binary even has the device present. I'm saying here that we're
not going to do that because this test cannot be accidentally reached
via make check. Realistically, most people will consume this test
through the CI job only.

