Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910B1C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 13:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ljQ-000389-Uq; Wed, 22 May 2024 09:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9ljP-00036X-P0
 for qemu-devel@nongnu.org; Wed, 22 May 2024 09:10:11 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9ljN-0005j3-VO
 for qemu-devel@nongnu.org; Wed, 22 May 2024 09:10:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 82CEA34D44;
 Wed, 22 May 2024 13:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716383408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dE1LBQjmjPvye49bKp/MyD9xW0teWx5oA3kB0/Xn40E=;
 b=lTCP7dc2UuurVO0hsc2RjCVcKmznYeDct2EJz+ba7Oa4ViKuzTw42hlTyNgcFgbRW7utmz
 bBoHZSQcvAxoFikWsfGkkalbgDUcK+bQBgNfpx8qrzXY0hVtwOY3x7h/dpk/wg6J9+XGWt
 uN7BAKI8C75dLQ0wSgkgZUPN8Lvv2jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716383408;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dE1LBQjmjPvye49bKp/MyD9xW0teWx5oA3kB0/Xn40E=;
 b=wdm1hqzJOE4CY7uLaOy+MxKUt4/WBGlmqiF3fjTHlVc1D8p3TatuHTKH2VXW7zaKCWbnaL
 SVwqsDsY7eERwUBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716383407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dE1LBQjmjPvye49bKp/MyD9xW0teWx5oA3kB0/Xn40E=;
 b=LQOnUL5b0ALjer+aaferc0+957qTi4CrBhOMhC0Ar3i0pEXEPX/NtvTeG8p8QosvDmSH1D
 ihhWCLQF3U29+w8V3AZftY+kWiywccxDxrqLFwS/Qz6u+5FCvBWiAUbqlDmw98Dm/S1wl3
 i7KkIlyTTZ3UKUyWotgdO9QXhWVm5wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716383407;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dE1LBQjmjPvye49bKp/MyD9xW0teWx5oA3kB0/Xn40E=;
 b=lWWKSkQN6ixFstAN10AKgZuXZpc5+JGPDviKsIzXaZHQ1io88qwoVOLJmcwR3cINyI1miV
 6pDLyHoFE5UY6QCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EF5313A1E;
 Wed, 22 May 2024 13:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gWs8Ma7uTWYfFAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 May 2024 13:10:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/qtest/migration-test: Fix the check for a
 successful run of analyze-migration.py
In-Reply-To: <20240522092301.421883-1-thuth@redhat.com>
References: <20240522092301.421883-1-thuth@redhat.com>
Date: Wed, 22 May 2024 10:10:04 -0300
Message-ID: <87wmnmgfgz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Thomas Huth <thuth@redhat.com> writes:

> If analyze-migration.py cannot be run or crashes, the error is currently
> ignored since the code only checks for nonzero values in case the child
> exited properly. For example, if you run the test with a non-existing
> Python interpreter, it still succeeds:
>
>  $ PYTHON=wrongpython QTEST_QEMU_BINARY=./qemu-system-x86_64 tests/qtest/migration-test
>  ...
>  # Running /x86_64/migration/analyze-script
>  # Using machine type: pc-q35-9.1
>  # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-417639.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-417639.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-q35-9.1, -name source,debug-threads=on -m 150M -serial file:/tmp/migration-test-XPLUN2/src_serial -drive if=none,id=d0,file=/tmp/migration-test-XPLUN2/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1   -uuid 11111111-1111-1111-1111-111111111111  -accel qtest
>  # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-417639.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-417639.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-q35-9.1, -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-XPLUN2/dest_serial -incoming tcp:127.0.0.1:0 -drive if=none,id=d0,file=/tmp/migration-test-XPLUN2/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1     -accel qtest
>  **
>  ERROR:../../devel/qemu/tests/qtest/migration-test.c:1603:test_analyze_script: code should not be reached
>  migration-test: ../../devel/qemu/tests/qtest/libqtest.c:240: qtest_wait_qemu: Assertion `pid == s->qemu_pid' failed.
>  migration-test: ../../devel/qemu/tests/qtest/libqtest.c:240: qtest_wait_qemu: Assertion `pid == s->qemu_pid' failed.
>  ok 2 /x86_64/migration/analyze-script
>  ...
>
> Let's better fail the test in case the child did not exit properly, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/migration-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 5b4eca2b20..b7e3406471 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1604,7 +1604,7 @@ static void test_analyze_script(void)
>      }
>  
>      g_assert(waitpid(pid, &wstatus, 0) == pid);
> -    if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) != 0) {
> +    if (!WIFEXITED(wstatus) || WEXITSTATUS(wstatus) != 0) {
>          g_test_message("Failed to analyze the migration stream");
>          g_test_fail();
>      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

