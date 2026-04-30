Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D556FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGa-00046h-BC; Thu, 30 Apr 2026 10:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wIROL-000396-E8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:25:21 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wIROJ-0000Gu-Ii
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:25:21 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 384335BD2E;
 Thu, 30 Apr 2026 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777555516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xBb8VrJ787Bn8rFHBwuqbgMgMtBtySGT/i8DpAthULA=;
 b=fjkjYBtXKseqPqXqdPkVf8pikzgE5qJX5nB1/W49kjGYLeuJ9lBLKRHQoOcy1n8YrC4qxe
 iBeSp4D0kF11TczKeYovZAUDPNeiie7tlzQxR4YGhCTMkC+FR68GlMAqiIZNHKWzuJ4HrG
 h3ph1nyca0RRLv0RNmn/Q8Gy7jfdkA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777555516;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xBb8VrJ787Bn8rFHBwuqbgMgMtBtySGT/i8DpAthULA=;
 b=9JxoniHBmfbYGl56Sg9cA7biYvJrSyFeeaRhq7nemJkMCtA5gH8KIJqmiEw7TCKsh45s/J
 0nYcmbjoysPVK7CQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fjkjYBtX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9JxoniHB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777555516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xBb8VrJ787Bn8rFHBwuqbgMgMtBtySGT/i8DpAthULA=;
 b=fjkjYBtXKseqPqXqdPkVf8pikzgE5qJX5nB1/W49kjGYLeuJ9lBLKRHQoOcy1n8YrC4qxe
 iBeSp4D0kF11TczKeYovZAUDPNeiie7tlzQxR4YGhCTMkC+FR68GlMAqiIZNHKWzuJ4HrG
 h3ph1nyca0RRLv0RNmn/Q8Gy7jfdkA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777555516;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xBb8VrJ787Bn8rFHBwuqbgMgMtBtySGT/i8DpAthULA=;
 b=9JxoniHBmfbYGl56Sg9cA7biYvJrSyFeeaRhq7nemJkMCtA5gH8KIJqmiEw7TCKsh45s/J
 0nYcmbjoysPVK7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9221593B0;
 Thu, 30 Apr 2026 13:25:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B4i8JTtY82m/MwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 30 Apr 2026 13:25:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v1 3/3] docs/devel/qtest: Mention environment variables
 usage
In-Reply-To: <CAFEAcA_bpXeKpjKU30=DFRCuoi4ubqhNxq9RO8mfUwmwwChGVQ@mail.gmail.com>
References: <20260429003130.15164-1-farosas@suse.de>
 <20260429003130.15164-4-farosas@suse.de>
 <CAFEAcA_bpXeKpjKU30=DFRCuoi4ubqhNxq9RO8mfUwmwwChGVQ@mail.gmail.com>
Date: Thu, 30 Apr 2026 10:25:09 -0300
Message-ID: <871pfwr362.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email,linaro.org:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 384335BD2E
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

> On Wed, 29 Apr 2026 at 01:31, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Document the QTEST_ environment variables. Only include the ones used
>> by QTest itself, don't document test-specific variables as they are
>> more prone to change.
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  docs/devel/testing/qtest.rst | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/docs/devel/testing/qtest.rst b/docs/devel/testing/qtest.rst
>> index 73ef7702b7..0aac0f0aaf 100644
>> --- a/docs/devel/testing/qtest.rst
>> +++ b/docs/devel/testing/qtest.rst
>> @@ -91,3 +91,36 @@ libqtest API reference
>>  ----------------------
>>
>>  .. kernel-doc:: tests/qtest/libqtest.h
>> +
>> +
>> +QTest valid environment variables
>> +---------------------------------
>> +
>> +A few environment variables are used to point QTest at artifacts to be
>> +used in the tests, mostly QEMU binaries or to control the behavior of
>> +the tests. Environment variables are set automatically by the build
>> +system, but it can be useful to alter them when running tests
>> +manually. The following are the environment variables recognized by
>> +QTest, not including test-specific ones:
>> +
>> +QTEST_QEMU_BINARY - The QEMU binary itself
>> +
>> +QTEST_QEMU_ARGS - Extra arguments for the QEMU command line
>> +
>> +QTEST_QEMU_IMG - The qemu-img binary
>> +
>> +QTEST_QEMU_STORAGE_DAEMON_BINARY - The qemu-storage-daemon binary
>> +
>> +QTEST_STOP - Instruct QTest to stop the QEMU process with SIGSTOP before continuing execution.
>> +
>> +QTEST_LOG - Comma-separated list of log domains to allow verbose logging. Basic log domains include:
>> +
>> +           qmp - controls verbose output of QMP command invocations.
>> +
>> +           qtest - controls verbose ouput of qtest operations.
>
> "output"
>
>> +
>> +           test - controls verbose output of tests.
>> +
>> +           A dash '-' used in front of a log domain has the effect of
>> +           enabling verbose logging for all other domains while
>> +           keeping it disabled for the specified domain.
>
> We could write this using rST definition-lists, which I think
> makes the generated HTML look a little nicer. Here's a version
> which is basically the same text but with a little more rST
> markup sprinkled over it:
>
> ===begin===
> +
> +
> +QTest valid environment variables
> +---------------------------------
> +
> +A few environment variables are used to point QTest at artifacts to be
> +used in the tests, mostly QEMU binaries or to control the behavior of
> +the tests. Environment variables are set automatically by the build
> +system, but it can be useful to alter them when running tests
> +manually. The following are the environment variables recognized by
> +QTest, not including test-specific ones:
> +
> +``QTEST_QEMU_BINARY``
> +    The QEMU binary itself (generally a ``qemu-system-<arch>`` binary).
> +
> +``QTEST_QEMU_ARGS``
> +    Extra arguments for the QEMU command line.
> +
> +``QTEST_QEMU_IMG``
> +    The ``qemu-img`` binary.
> +
> +``QTEST_QEMU_STORAGE_DAEMON_BINARY``
> +    The ``qemu-storage-daemon`` binary.
> +
> +``QTEST_STOP``
> +    Instruct QTest to stop the QEMU process with SIGSTOP before continuing
> +    execution.
> +
> +``QTEST_LOG``
> +    Comma-separated list of log domains to allow verbose logging.
> +    The currently-defined log domains are:
> +
> +    ``qmp``
> +        controls verbose output of QMP command invocations.
> +
> +    ``qtest``
> +        controls verbose output of QTest operations.
> +
> +    ``test``
> +        controls verbose output of tests.
> +
> +    A dash ``-`` used in front of a log domain name has the effect
> +    of enabling verbose logging for all other domains while
> +    keeping it disabled for the specified domain.
> ===endit===
>

Excellent, thank you for this.

> Either way,
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>


> thanks
> -- PMM

