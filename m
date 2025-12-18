Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55474D6ACDC
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 12:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWCpt-0007as-PU; Thu, 18 Dec 2025 07:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vWCpq-0007Xx-Ju
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 07:10:23 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vWCpm-0005Zs-BP
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 07:10:22 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A842A5BD9A;
 Thu, 18 Dec 2025 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766059814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5TlMZwmcORGis1wHegJhhucyc8kKIgslTZmM9e6NK40=;
 b=kqHcnBN1q6iz6mjbFdj1rKD+XhuDWN5EUIuglZYzbRzdLaFl61a4/RE0aFJ928OGSUkIPl
 8Hke71jyzQpNQN5wYGN0k6H10KMDXxpBlW9VqZSb926RU53se1trIznUbC5T1TAL4hfxvM
 UHbyoss50Ul+rsXR0CbrRJvTT8fIn7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766059814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5TlMZwmcORGis1wHegJhhucyc8kKIgslTZmM9e6NK40=;
 b=FR9rQ2CwRu2rTxbBu5O4Z7q458F8Sr9ijoCbFoWJl+FlzQKo6ZNuaCkFnfYSlO3AAqd0Qb
 tnMMFI6E0+M+8HAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766059814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5TlMZwmcORGis1wHegJhhucyc8kKIgslTZmM9e6NK40=;
 b=kqHcnBN1q6iz6mjbFdj1rKD+XhuDWN5EUIuglZYzbRzdLaFl61a4/RE0aFJ928OGSUkIPl
 8Hke71jyzQpNQN5wYGN0k6H10KMDXxpBlW9VqZSb926RU53se1trIznUbC5T1TAL4hfxvM
 UHbyoss50Ul+rsXR0CbrRJvTT8fIn7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766059814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5TlMZwmcORGis1wHegJhhucyc8kKIgslTZmM9e6NK40=;
 b=FR9rQ2CwRu2rTxbBu5O4Z7q458F8Sr9ijoCbFoWJl+FlzQKo6ZNuaCkFnfYSlO3AAqd0Qb
 tnMMFI6E0+M+8HAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 267853EA63;
 Thu, 18 Dec 2025 12:10:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RNhcNiXvQ2nubgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Dec 2025 12:10:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] tests/functional: Allow tests to be run individually
In-Reply-To: <dbfcbfff-b2fd-4c23-82da-ad9eed22a812@redhat.com>
References: <20251216200555.4374-1-farosas@suse.de>
 <dbfcbfff-b2fd-4c23-82da-ad9eed22a812@redhat.com>
Date: Thu, 18 Dec 2025 09:10:10 -0300
Message-ID: <87bjjw0z4t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> On 16/12/2025 21.05, Fabiano Rosas wrote:
>> The functional tests currently don't allow a single test to be
>> selected for execution by dotted name, e.g:
>> 
>> ../tests/functional/ppc64/test_pseries.py PseriesMachine.test_ppc64_linux_boot
>>                                            ^
>> The issue is that the testcase.py main function passes the test
>> module's name as the second argument to unittest.main(), which makes
>> it ignore all other positional arguments (presumably because the
>> module is already the superset of all tests).
>> 
>> After commit cac08383f0 ("tests/functional: expose sys.argv to
>> unittest.main"), the situation improves by passing the rest of the
>> argv from the command line invocation into unittest.main(), but it
>> still doesn't fix the issue. The short form options are now accepted,
>> so the -k option could be used to filter for a pattern, which is
>> useful, but not the same as listing the test names.
>> 
>> Fix this by passing the test module name via the "module" argument to
>> unittest.main() and stop touching argv. The ways of invoking tests are
>> now as per unittests documentation (-k still works):
>> 
>>    Examples:
>>      test_pseries.py                           - run default set of tests
>>      test_pseries.py MyTestSuite               - run suite 'MyTestSuite'
>>      test_pseries.py MyTestCase.testSomething  - run MyTestCase.testSomething
>>      test_pseries.py MyTestCase                - run all 'test*' test methods in MyTestCase
> Tested-by: Thomas Huth <thuth@redhat.com>
>
> If you've got some spare time, maybe you could also add some words about 
> running individual sub-tests to docs/devel/testing/functional.rst ?
>

Ah, thanks for the reminder, I'll do it right away.

