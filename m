Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6DCC47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNbN-0003jz-NA; Fri, 26 Jan 2024 09:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rTNbL-0003jX-OP
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:54:39 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rTNbJ-0005Zj-R3
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:54:39 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA83C1FD9F;
 Fri, 26 Jan 2024 14:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706280876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRHJ6/dT+GbZSJwEAdPKX0THiHz5n7eWwv37AoSeTEQ=;
 b=NyhaVtPvUp4wwfFhkVloOFKcpN9urX7Ekv2KtBcnhX+yAPEp33Ty8DRd+SECzR67d0vzOp
 Z7LShfvT0f5/f80GGC2tbLl4cWTandtQK7FArqu8SOVBhpvVhm/8Qu7uD1/aE12pBSElrn
 C8yDNmMCHdFWzg79THjov8QWa8cbfxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706280876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRHJ6/dT+GbZSJwEAdPKX0THiHz5n7eWwv37AoSeTEQ=;
 b=mQ0GtpSy149kjHfweYI195CH8nvh7Y/I86secVMFb/TyV76TWRG5C78aMgEYi4gCjTtJ/x
 tg3dqmS9kGItkABw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706280875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRHJ6/dT+GbZSJwEAdPKX0THiHz5n7eWwv37AoSeTEQ=;
 b=tzkAh7uDEDWEzyhomxdbBbnMwHbTAZIJdadExmA9APanML8KbbJ8t6+u4DmfQj305yHCLW
 bML99q0RNZmKmdSEoyU2PmW3aaqEObxhTYI4PkJRspC2h0aFA3Sk7xgHsseI67WPlRARap
 e3IgiSxBHFgep61F97dtrx1FdT1C6PM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706280875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRHJ6/dT+GbZSJwEAdPKX0THiHz5n7eWwv37AoSeTEQ=;
 b=bBOTp7V8dLQqzYM9Hg29pAf7RnVxsotXH/LVm8PP4/AZ4bGi84EUFPGH20HBPaHndLfuXr
 Boqr+32gCUaYPhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6790613A22;
 Fri, 26 Jan 2024 14:54:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dFfpC6vHs2UieQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Jan 2024 14:54:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
In-Reply-To: <CAFEAcA-x4WqvPsN-KZOA3SPN0F=vvYi=NFZ2qom2iT7-CN0RSg@mail.gmail.com>
References: <20240126041725.124562-1-peterx@redhat.com>
 <20240126041725.124562-7-peterx@redhat.com> <87le8c6u1d.fsf@suse.de>
 <CAFEAcA-x4WqvPsN-KZOA3SPN0F=vvYi=NFZ2qom2iT7-CN0RSg@mail.gmail.com>
Date: Fri, 26 Jan 2024 11:54:32 -0300
Message-ID: <87il3g6t7b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tzkAh7uD;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bBOTp7V8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; BAYES_HAM(-3.00)[100.00%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,linaro.org:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_IN_DNSWL_HI(-1.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: DA83C1FD9F
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 26 Jan 2024 at 14:36, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> peterx@redhat.com writes:
>>
>> > From: Fabiano Rosas <farosas@suse.de>
>> >
>> > The 'max' cpu is not expected to be stable in terms of features across
>> > QEMU versions, so it should not be expected to migrate.
>> >
>> > While the tests currently all pass with -cpu max, that is only because
>> > we're not testing across QEMU versions, which is the more common
>> > use-case for migration.
>> >
>> > We've recently introduced compatibility tests that use two different
>> > QEMU versions and the tests are now failing for aarch64. The next
>> > patch adds those tests to CI, so we cannot use the 'max' cpu
>> > anymore. Replace it with the 'neoverse-n1', which has a fixed set of
>> > features.
>> >
>> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > Link: https://lore.kernel.org/r/20240118164951.30350-2-farosas@suse.de
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  tests/qtest/migration-test.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> > index 7675519cfa..15713f3666 100644
>> > --- a/tests/qtest/migration-test.c
>> > +++ b/tests/qtest/migration-test.c
>> > @@ -820,7 +820,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>> >          memory_size = "150M";
>> >          machine_alias = "virt";
>> >          machine_opts = "gic-version=max";
>> > -        arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
>> > +        arch_opts = g_strdup_printf("-cpu neoverse-n1 -kernel %s", bootpath);
>> >          start_address = ARM_TEST_MEM_START;
>> >          end_address = ARM_TEST_MEM_END;
>> >      } else {
>>
>> This breaks the tests on an arm host with KVM support. We could drop
>> this patch from the PR, it doesn't affect anything else.
>>
>> Or squash in:
>>
>> -->8--
>> From b8aa5d8a2b33dcc28e4cd4ce2c4f4eacc3a3b845 Mon Sep 17 00:00:00 2001
>> From: Fabiano Rosas <farosas@suse.de>
>> Date: Fri, 26 Jan 2024 11:33:15 -0300
>> Subject: [PATCH] fixup! tests/qtest/migration: Don't use -cpu max for aarch64
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration-test.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 15713f3666..2ba9cab684 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -820,7 +820,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>          memory_size = "150M";
>>          machine_alias = "virt";
>>          machine_opts = "gic-version=max";
>> -        arch_opts = g_strdup_printf("-cpu neoverse-n1 -kernel %s", bootpath);
>> +        arch_opts = g_strdup_printf("-cpu %s -kernel %s",
>> +                                    qtest_has_accel("kvm") ?
>> +                                    "host" : "neoverse-n1", bootpath);
>>          start_address = ARM_TEST_MEM_START;
>>          end_address = ARM_TEST_MEM_END;
>>      } else {
>
> If you want to do that then a comment explaining why would be
> helpful for future readers, I think.

Ok, let's drop this one then, I'll resend.

Thanks

