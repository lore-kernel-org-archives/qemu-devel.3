Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E95C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb67-0005fo-Fs; Mon, 29 Jan 2024 18:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rUb5r-0005Sn-6H
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:22 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rUb5o-00051v-13
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:10 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E4051F810;
 Mon, 29 Jan 2024 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706571066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hfrUNpJYEWG+VjoWyqgkRzEj+XoRImb+gGq9nb59qwk=;
 b=peMh6BVJUNSmQvD/kd0u7fFXdR7cm6uGl1LuBFpEvdsjdH25rya3MpVVwSd6gic6ihD5Ei
 6e86JeKk9jhdN9Lo6EZ9tjFhoFEuyV9YhFraTQCHepfimx11GltHNUL9zfCn1+xH/ltj2F
 eQixEwFQzfIrHKJi8h1yzYlQzmNE+Yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706571066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hfrUNpJYEWG+VjoWyqgkRzEj+XoRImb+gGq9nb59qwk=;
 b=uOX9gej4eujAQIQuD7btbbLyma/RUfIlXjKlxGK2CIQNA5G7wne/SiWf9BDCmHnmIDk1fI
 +SPGmH1XxK3hSMAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706571064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hfrUNpJYEWG+VjoWyqgkRzEj+XoRImb+gGq9nb59qwk=;
 b=dW2DwkkOBlV93Or/YF87K2bfSMKV7cj2NjDeuI0H6TIVkcCaBZk+RMcn0SMrq7/JnL1mCM
 zje7m6V2pK0kQch21VC57GKmvpwsv3XLMdnqq4I4oizGPIUOjYd/4DljKh5PiIUyIPSurf
 e3I+kMCzkXQvch4IipZNrTr4Cw8wYYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706571064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hfrUNpJYEWG+VjoWyqgkRzEj+XoRImb+gGq9nb59qwk=;
 b=A9fODNqbjKUsXEoRSWXjTPB1aNvW3lbUoBdAg+wtNiiuQ4X0qt3L2cJT2mVl5iYfT7s+T1
 2utEWND87C8AmoDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E8A913647;
 Mon, 29 Jan 2024 23:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VyenGTc1uGXRLQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Jan 2024 23:31:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
In-Reply-To: <87sf2ge3qu.fsf@suse.de>
References: <20240126041725.124562-1-peterx@redhat.com>
 <20240126041725.124562-7-peterx@redhat.com> <87le8c6u1d.fsf@suse.de>
 <CAFEAcA-x4WqvPsN-KZOA3SPN0F=vvYi=NFZ2qom2iT7-CN0RSg@mail.gmail.com>
 <87il3g6t7b.fsf@suse.de> <ZbcSqyGNLGu7ugBb@x1n> <87sf2ge3qu.fsf@suse.de>
Date: Mon, 29 Jan 2024 20:30:13 -0300
Message-ID: <87y1c7ogze.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dW2DwkkO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A9fODNqb
X-Spamd-Result: default: False [-4.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1E4051F810
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Fabiano Rosas <farosas@suse.de> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> On Fri, Jan 26, 2024 at 11:54:32AM -0300, Fabiano Rosas wrote:
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>> 
>>> > On Fri, 26 Jan 2024 at 14:36, Fabiano Rosas <farosas@suse.de> wrote:
>>> >>
>>> >> peterx@redhat.com writes:
>>> >>
>>> >> > From: Fabiano Rosas <farosas@suse.de>
>>> >> >
>>> >> > The 'max' cpu is not expected to be stable in terms of features across
>>> >> > QEMU versions, so it should not be expected to migrate.
>>> >> >
>>> >> > While the tests currently all pass with -cpu max, that is only because
>>> >> > we're not testing across QEMU versions, which is the more common
>>> >> > use-case for migration.
>>> >> >
>>> >> > We've recently introduced compatibility tests that use two different
>>> >> > QEMU versions and the tests are now failing for aarch64. The next
>>> >> > patch adds those tests to CI, so we cannot use the 'max' cpu
>>> >> > anymore. Replace it with the 'neoverse-n1', which has a fixed set of
>>> >> > features.
>>> >> >
>>> >> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>> >> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> >> > Link: https://lore.kernel.org/r/20240118164951.30350-2-farosas@suse.de
>>> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
>>> >> > ---
>>> >> >  tests/qtest/migration-test.c | 2 +-
>>> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
>>> >> >
>>> >> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>>> >> > index 7675519cfa..15713f3666 100644
>>> >> > --- a/tests/qtest/migration-test.c
>>> >> > +++ b/tests/qtest/migration-test.c
>>> >> > @@ -820,7 +820,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>> >> >          memory_size = "150M";
>>> >> >          machine_alias = "virt";
>>> >> >          machine_opts = "gic-version=max";
>>> >> > -        arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
>>> >> > +        arch_opts = g_strdup_printf("-cpu neoverse-n1 -kernel %s", bootpath);
>>> >> >          start_address = ARM_TEST_MEM_START;
>>> >> >          end_address = ARM_TEST_MEM_END;
>>> >> >      } else {
>>> >>
>>> >> This breaks the tests on an arm host with KVM support. We could drop
>>> >> this patch from the PR, it doesn't affect anything else.
>>> >>
>>> >> Or squash in:
>>> >>
>>> >> -->8--
>>> >> From b8aa5d8a2b33dcc28e4cd4ce2c4f4eacc3a3b845 Mon Sep 17 00:00:00 2001
>>> >> From: Fabiano Rosas <farosas@suse.de>
>>> >> Date: Fri, 26 Jan 2024 11:33:15 -0300
>>> >> Subject: [PATCH] fixup! tests/qtest/migration: Don't use -cpu max for aarch64
>>> >>
>>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> >> ---
>>> >>  tests/qtest/migration-test.c | 4 +++-
>>> >>  1 file changed, 3 insertions(+), 1 deletion(-)
>>> >>
>>> >> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>>> >> index 15713f3666..2ba9cab684 100644
>>> >> --- a/tests/qtest/migration-test.c
>>> >> +++ b/tests/qtest/migration-test.c
>>> >> @@ -820,7 +820,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>> >>          memory_size = "150M";
>>> >>          machine_alias = "virt";
>>> >>          machine_opts = "gic-version=max";
>>> >> -        arch_opts = g_strdup_printf("-cpu neoverse-n1 -kernel %s", bootpath);
>>> >> +        arch_opts = g_strdup_printf("-cpu %s -kernel %s",
>>> >> +                                    qtest_has_accel("kvm") ?
>>> >> +                                    "host" : "neoverse-n1", bootpath);
>>> >>          start_address = ARM_TEST_MEM_START;
>>> >>          end_address = ARM_TEST_MEM_END;
>>> >>      } else {
>>> >
>>> > If you want to do that then a comment explaining why would be
>>> > helpful for future readers, I think.
>>> 
>>> Ok, let's drop this one then, I'll resend.
>>
>> I'll drop this one for now then, thanks.
>>
>> Just to double check: Fabiano, you meant that "-cpu host" won't hit the
>> same issue as what "-cpu max" would have for the new "n-1" CI test, right?
>
> Well, no. What we need here is a cpu that works with KVM. Currently
> that's 'host'. If that breaks the n-1 test, then it's a regression.
>
> We also need a cpu that works with TCG. Any of them would do. Except max
> which changes in incompatible ways (that was the original patch's
> purpose).
>
> The issue that occurs to me now is that 'cpu host' will not work with
> TCG. We might actually need to go poking /dev/kvm for this to work.

Nevermind this last part. There's not going to be a scenario where we
build with CONFIG_KVM, but run in an environment that does not support
KVM.

