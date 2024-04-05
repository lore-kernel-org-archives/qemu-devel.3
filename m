Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4AAC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 14:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rskYr-00073L-Qo; Fri, 05 Apr 2024 10:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rskYp-00072x-Vn
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 10:28:56 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rskYn-00073A-Vn
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 10:28:55 -0400
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B67B1F7DA;
 Fri,  5 Apr 2024 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712327331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=43qzFEdqzV8CwjSduoipTxQTf7ex2AgBgKROnVNshPI=;
 b=K+m/bkR7f11LT/dAtqj6WspISgP2l4uFOH4qAtW/nn4m5ekMItyytFKA4F2nOMdPEOH2V+
 WERJW+7GawOKcgmQWwAa0tE3aqrp1Zn/u+jDXsTcs8NhCdyeIlHQPkum8Uq4s5YkzaJ+Y/
 lclX2FxxCQqLZV2a5BO++iZhkII/Csw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712327331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=43qzFEdqzV8CwjSduoipTxQTf7ex2AgBgKROnVNshPI=;
 b=ROa4+jnYal29RUa+wAcrlPaVvfnto15IsedoEWt+YAT6bbDUfoqQ0s6dqdG/PV1Q64njWJ
 k4auvKTigu+Q5/CA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="K+m/bkR7";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ROa4+jnY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712327331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=43qzFEdqzV8CwjSduoipTxQTf7ex2AgBgKROnVNshPI=;
 b=K+m/bkR7f11LT/dAtqj6WspISgP2l4uFOH4qAtW/nn4m5ekMItyytFKA4F2nOMdPEOH2V+
 WERJW+7GawOKcgmQWwAa0tE3aqrp1Zn/u+jDXsTcs8NhCdyeIlHQPkum8Uq4s5YkzaJ+Y/
 lclX2FxxCQqLZV2a5BO++iZhkII/Csw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712327331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=43qzFEdqzV8CwjSduoipTxQTf7ex2AgBgKROnVNshPI=;
 b=ROa4+jnYal29RUa+wAcrlPaVvfnto15IsedoEWt+YAT6bbDUfoqQ0s6dqdG/PV1Q64njWJ
 k4auvKTigu+Q5/CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BBC0B139E8;
 Fri,  5 Apr 2024 14:28:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id x/pZIKIKEGbwRAAAn2gu4w
 (envelope-from <farosas@suse.de>); Fri, 05 Apr 2024 14:28:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com
Subject: Re: [PATCH] tests/qtest: Standardize qtest function caller strings.
In-Reply-To: <1f336795-5c5d-4320-8783-3cbe238f894c@nutanix.com>
References: <20240326193843.8444-1-het.gala@nutanix.com>
 <87zfukvh0r.fsf@suse.de>
 <1f336795-5c5d-4320-8783-3cbe238f894c@nutanix.com>
Date: Fri, 05 Apr 2024 11:28:48 -0300
Message-ID: <87a5m7vq73.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3B67B1F7DA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Het Gala <het.gala@nutanix.com> writes:

> On 27/03/24 2:37 am, Fabiano Rosas wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>> Some comments, mostly just thinking out loud...
>>
>>> For <test-type> --> migrate
>>> /<test-type>/<migration-mode>/<method>/<transport>/<invocation>/
>>> <compression>/<encryption>/O:<others>/...
>>>
>>> For <test-type> --> validate
>>> /<test-type>/<validate-variable>/O:<transport>/O:<invocation>/
>>> <validate-test-result>/O:<test-reason>/O:<others>/...
>> Do we need an optional 'capability' element? I'm not sure how practical
>> is to leave that as 'others', because that puts it at the end of the
>> string. We'd want the element that's more important/with more variants
>> to be towards the start of the string so we can run all tests of the
>> same kind with the -r option.
> While also looking at different functions for figuring out the transport
> and invocation, my observation was that, there might be many capabilities
> added to the same test, while it might not be important also.
> Ex: /migrate/multifd/tcp/plain
> 1. multifd is defined as a migration mode.
> 2. It is also a capability, and comes in 2 parts [multifd, multifd-channe=
ls]
>  =C2=A0=C2=A0 though one is a capability and another is parameter
> Similarly in other examples of compression, there are many capabilities
> and parameters added, but it might be not important to mention that ?
>
> Secondly, there are multiple migration capabilities IIRC (> 15). And a te=
st
> requiring multiple capabilities, the overall string would be too long, and
> not that important also to mention all capabilities.
>
> Just thinking out of mind - Can we have selective list of capabilities ?=
=20
> 1. multifd 2. compress (again, there might be confusion with multifd=20
> compression methods like zstd, zlib and just 'compress') 3. zero-page=20
> (This will have sub capabilities ?)

I was thinking of keeping that part more open-ended. So not specifying
capabilities one by one, but more like "if you're testing a capability,
it comes here".

About multifd, it's a bit special since it cannot be seen as just a
"feature" anymore. It's a core part of the migration code. I wouldn't
classify it as capability for the purposes of the tests.

>
>>> test-type            :: migrate | validate
>> We could alternatively drop migration|migrate|validate. They are kind of
>> superfluous.
> I agree with the above comment. 'migrate' and 'validate' have a different
> set of variables required, some necessary, while other optional. IMO this
> will help is in streamlining the design further.
>>> migration-mode
>>>    a. migrate -->     :: precopy | postcopy | multifd
>>>    b. validate -->    :: (what to validate)
>>> methods              :: preempt | recovery | reboot | suspend | simple
> I want some inputs here.
> 1. is there a better variable name rather than 'methods'

Does this fall into the "mode" terminology that Steven introduced?

> 2. 'simple' does not fit perfect here IMO.

Can we go without it?

>>> transport            :: tcp | fd | unix | file
>>> invocation           :: uri | channels | both
>>> CompressionType      :: zlib | zstd | none
>> s/none/nocomp/ ? We're already familiar with that.
> Ack. Will change that.
>>> encryptionType       :: tls | plain
>> s/plain/notls/ ?
> What if there is another encryption technique in future ?
>> Or maybe we simply omit the noop options. It would make the string way
>> shorter in most cases.
> This might be a better approach. Can have some keys/variables as optional
> while some necessary. For ex: for 'migrate' - transport and invocation
> might be necessary while it might not be necessary for 'validate' qtests

Yep

>>> validate-test-result :: success | failure
>>> others               :: other comments/capability that needs to be
>>>                          addressed. Can be multiple
>>>
>>> (more than one applicable, separated by using '-' in between)
>>> O: optional
>>>
>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>>> ---
>>>   tests/qtest/migration-test.c | 143 ++++++++++++++++++-----------------
>>>   1 file changed, 72 insertions(+), 71 deletions(-)
>>>
>>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>>> index bd9f4b9dbb..bf4d000b76 100644
>>> --- a/tests/qtest/migration-test.c
>>> +++ b/tests/qtest/migration-test.c
> Regards,
> Het Gala

I'm wondering whether we should leave the existing tests untouched and
require the new format only for new tests. Going through a git bisection
with a change in the middle that alters test names would be infuriating.

