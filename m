Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE55E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 18:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMAiq-0005oD-Pq; Fri, 13 Dec 2024 13:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tMAio-0005n4-Oj; Fri, 13 Dec 2024 13:49:06 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tMAij-0001Hu-7S; Fri, 13 Dec 2024 13:49:06 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB1361F387;
 Fri, 13 Dec 2024 18:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734115738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oHoUgQ6+kCXnKXGlj6FBXb+XJKY1m7l4AWPkOyOUO+c=;
 b=g3CYPbPFF4DDf4JJKpIFJSpq3z1+/urBWBO0MsF2o87oOFDF9qDBdHi3KEZeWtAWKWjvLR
 43ZsYwtzxpa3VuAiDMDdrcJ/odpHygsiLT8uUFq5IQE3YJP6oLH2TmCG8+d5ZfqR6LqbFt
 ymQH6I7H68F7iMwQdLO2jWIeuM8zsG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734115738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oHoUgQ6+kCXnKXGlj6FBXb+XJKY1m7l4AWPkOyOUO+c=;
 b=umYa4/cMYACKclBsSsbXlHZwA0AF3vr0LKPgbA7sLPZi0CcC556k/ia3Tlz4xWSqsw2oaA
 mP6kwRyUlpP4uoBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734115738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oHoUgQ6+kCXnKXGlj6FBXb+XJKY1m7l4AWPkOyOUO+c=;
 b=g3CYPbPFF4DDf4JJKpIFJSpq3z1+/urBWBO0MsF2o87oOFDF9qDBdHi3KEZeWtAWKWjvLR
 43ZsYwtzxpa3VuAiDMDdrcJ/odpHygsiLT8uUFq5IQE3YJP6oLH2TmCG8+d5ZfqR6LqbFt
 ymQH6I7H68F7iMwQdLO2jWIeuM8zsG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734115738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oHoUgQ6+kCXnKXGlj6FBXb+XJKY1m7l4AWPkOyOUO+c=;
 b=umYa4/cMYACKclBsSsbXlHZwA0AF3vr0LKPgbA7sLPZi0CcC556k/ia3Tlz4xWSqsw2oaA
 mP6kwRyUlpP4uoBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E31313927;
 Fri, 13 Dec 2024 18:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xK92AZqBXGcKegAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Dec 2024 18:48:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Nabih Estefan <nabihestefan@google.com>,
 peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com,
 pbonzini@redhat.com, roqueh@google.com, venture@google.com, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] tests/qtest/sse-timer-test: Add watchdog reset to
 sse-timer test
In-Reply-To: <f03adc63-5167-4982-90e6-70b65f0c90cc@redhat.com>
References: <20241213002602.4181289-1-nabihestefan@google.com>
 <f03adc63-5167-4982-90e6-70b65f0c90cc@redhat.com>
Date: Fri, 13 Dec 2024 15:48:54 -0300
Message-ID: <87y10jctbd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Thomas Huth <thuth@redhat.com> writes:

> On 13/12/2024 01.26, Nabih Estefan wrote:
>> Recent CDMSK Watchdog changes (eff9dc5660fad3a610171c56a5ec3fada245e519)
>> updated the CDMSK APB Watchdog to not free run out of reset. That led to
>> this test failing since it never triggers the watchdog to start running.
>> No watchdog running means that the timer and counter in the test cannot
>> start, leading to failures in the assert statements throughout the test.
>> Adding a reset and enable of the watchdog to the reset function solves
>> this problem by enabling the watchdog and thus letting the timer and
>> counter run as expected
>> 
>> Also renaming the reset_counter_and_timer function since it now also
>> affects the watchdog.
>> 
>> To reproduce the failure at HEAD:
>> ./configure --target-list=arm-softmmu
>> make -j check-report-qtest-arm.junit.xml
>> 
>> Signed-off-by: Nabih Estefan <nabihestefan@google.com>

I don't see any failure with the sse-timer-test on master
(83aaec1d5a). Is it supposed to be intermittent? Nabih, can you confirm
whether this is the same issue Thomas has seen?

> I think this fixes the problem that I was seeing on Travis-CI:
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2702

I did see this^ issue, however, with Philippe's series [1] (and this
patch doesn't fix it).

Here's a CI job with both series applied:
https://gitlab.com/farosas/qemu/-/jobs/8638126011

1- https://lore.kernel.org/r/20241211233727.98923-2-philmd@linaro.org




