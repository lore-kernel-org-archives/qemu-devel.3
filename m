Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427E2E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 12:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTglh-0004I9-Fs; Fri, 03 Jan 2025 07:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTgld-0004HZ-OI
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 07:27:05 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTglb-0004fY-PA
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 07:27:05 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D20D2210F2;
 Fri,  3 Jan 2025 12:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735907219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d62PHd6LID9QUK+aHLv9Eiy9S69A2pYsS1JMhsU5/uE=;
 b=HNnYHgy1ZC/M667YxoI4eSeQOqX6J2AnLsiUQvgQyxlKtARYdsg2HsoheOrJlR2axg7qXv
 2OBjtE0QXa6qpq1PoeC3YU8cKL/wE1zcwol2SVSK29kz4+llcAEdQSGbGHIQc9B/lSTM99
 dPuMP/3ymz5P5f9NDMWBT+ouTo0gDeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735907219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d62PHd6LID9QUK+aHLv9Eiy9S69A2pYsS1JMhsU5/uE=;
 b=kNF1BFxs22Uyqp/R2yIhaJXkcVaYnE09csvwq+326/hBFp8q0xdGWhTYJZFYwn0FbKtDgy
 NZagQ8uE3az+B8DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735907219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d62PHd6LID9QUK+aHLv9Eiy9S69A2pYsS1JMhsU5/uE=;
 b=HNnYHgy1ZC/M667YxoI4eSeQOqX6J2AnLsiUQvgQyxlKtARYdsg2HsoheOrJlR2axg7qXv
 2OBjtE0QXa6qpq1PoeC3YU8cKL/wE1zcwol2SVSK29kz4+llcAEdQSGbGHIQc9B/lSTM99
 dPuMP/3ymz5P5f9NDMWBT+ouTo0gDeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735907219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d62PHd6LID9QUK+aHLv9Eiy9S69A2pYsS1JMhsU5/uE=;
 b=kNF1BFxs22Uyqp/R2yIhaJXkcVaYnE09csvwq+326/hBFp8q0xdGWhTYJZFYwn0FbKtDgy
 NZagQ8uE3az+B8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 589B5134E4;
 Fri,  3 Jan 2025 12:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2Nq+B5PXd2e3PAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 03 Jan 2025 12:26:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bandan Das <bsd@redhat.com>, Alexander Bulekov <alxndr@bu.edu>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/2] qtest: Remove uses of 'first_cpu'
In-Reply-To: <5d2a536d-9b68-4b31-8d92-6cc42ed72e5c@linaro.org>
References: <20241211233727.98923-1-philmd@linaro.org>
 <5d2a536d-9b68-4b31-8d92-6cc42ed72e5c@linaro.org>
Date: Fri, 03 Jan 2025 09:26:56 -0300
Message-ID: <87msg884mn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Fabiano,
>
> On 12/12/24 00:37, Philippe Mathieu-Daud=C3=A9 wrote:
>> Replace first_cpu->as by address_space_memory.
>>=20
>> Philippe Mathieu-Daud=C3=A9 (2):
>>    system/qtest: Remove uses of 'first_cpu'
>>    qtest/fuzz: Remove uses of 'first_cpu'
>>=20
>>   system/qtest.c                    | 53 ++++++++++++++++---------------
>>   tests/qtest/fuzz/generic_fuzz.c   |  3 +-
>>   tests/qtest/fuzz/qtest_wrappers.c | 53 ++++++++++++++++---------------
>>   3 files changed, 56 insertions(+), 53 deletions(-)
>
> Ping :)

Hi!

Good that you pinged, I thought you were looking into the test failures
from v1. I copied you in this other thread that mentioned them as well:

https://lore.kernel.org/r/87y10jctbd.fsf@suse.de

Applying this series on top of master just now:

Summary of Failures:

 10/519 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_usart-test              =
 ERROR            1.40s   exit status 1
165/519 qemu:qtest+qtest-arm / qtest-arm/sse-timer-test                    =
 ERROR            0.40s   killed by signal 6 SIGABRT
185/519 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_exti-test               =
 ERROR            0.19s   exit status 1
187/519 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_rcc-test                =
 ERROR            0.19s   exit status 1
515/519 qemu:qtest+qtest-arm / qtest-arm/microbit-test                     =
 TIMEOUT         60.01s   killed by signal 15 SIGTERM


>
> Tell me if you prefer I merge these patch myself.
>
> Regards,
>
> Phil.

