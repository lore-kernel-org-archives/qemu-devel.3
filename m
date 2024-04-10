Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB86CD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 13:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruYI2-0001fg-9q; Wed, 10 Apr 2024 09:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ruYHs-0001eb-1R
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 09:46:56 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ruYHn-0003XF-7E
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 09:46:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CB69D5CE6D;
 Wed, 10 Apr 2024 13:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712756806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HPCaSvLWx8Sw1ak1MIpoqBJkJ5XkgnAxT2lujHe/VS4=;
 b=E7Xe4wsbqjbHF1/G1ilIe3K1eHQtf5JJ5HgsQ1u/JgAJcS0YVw1UXnX+aWUB57AwxO7e69
 pAc1yfO/IcGtLx7uhyPnflF26zGLZrYx1FJJxWnkGxjMS/UE9unB8tIApL2XgUzOadzURl
 mxIw/4/uEmyqj7HnUFKnTkwixwhfnxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712756806;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HPCaSvLWx8Sw1ak1MIpoqBJkJ5XkgnAxT2lujHe/VS4=;
 b=UJohR9MxtEHLgRXuSd35upp2/8FsE3CpXH6r+2c+3rEAbfc8NLTsNRQHTB4j1+HBaczAkp
 5Lw/RMleTsfXaAAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712756805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HPCaSvLWx8Sw1ak1MIpoqBJkJ5XkgnAxT2lujHe/VS4=;
 b=QYGpIzvlqxX310DhtMnovBmXGuy8cz54ASh4JTrDvYWh33sqgp6SBA66Yfa52p+pW6PHd9
 yWXCigIPXT+84qqSUDa5/Y2PJRbsqz4UayP1RM0UHc9oaaKS2PZpbfTUYF8CsdLzzBXosG
 Yfx6lZMQwASOUxZyNJ+MU+LF2i7PlfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712756805;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HPCaSvLWx8Sw1ak1MIpoqBJkJ5XkgnAxT2lujHe/VS4=;
 b=atnX61UuBPy3WfZ5YlfEyfHYEBp1THMJ9VJoMakuQxB/EEMkRGqVm2o9FppHUgXsIm/DRZ
 e4FzBpqD6dKxUrAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55A6513691;
 Wed, 10 Apr 2024 13:46:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id glSLB0WYFmZlFQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Apr 2024 13:46:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com
Subject: Re: [PATCH] tests/qtest: Standardize qtest function caller strings.
In-Reply-To: <84e782ab-d4d2-4e66-8d55-28206e313bb8@nutanix.com>
References: <20240326193843.8444-1-het.gala@nutanix.com>
 <87zfukvh0r.fsf@suse.de>
 <1f336795-5c5d-4320-8783-3cbe238f894c@nutanix.com>
 <87a5m7vq73.fsf@suse.de>
 <84e782ab-d4d2-4e66-8d55-28206e313bb8@nutanix.com>
Date: Wed, 10 Apr 2024 10:46:42 -0300
Message-ID: <87ttk9ba9p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, nutanix.com:email, suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On 05/04/24 7:58 pm, Fabiano Rosas wrote:
>> !-------------------------------------------------------------------|
>>    CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> On 27/03/24 2:37 am, Fabiano Rosas wrote:
>>>> Het Gala<het.gala@nutanix.com>   writes:
>>>>
>>>> Some comments, mostly just thinking out loud...
>>>>
>>>>> For <test-type> --> migrate
>>>>> /<test-type>/<migration-mode>/<method>/<transport>/<invocation>/
>>>>> <compression>/<encryption>/O:<others>/...
>>>>>
>>>>> For <test-type> --> validate
>>>>> /<test-type>/<validate-variable>/O:<transport>/O:<invocation>/
>>>>> <validate-test-result>/O:<test-reason>/O:<others>/...
>>>> Do we need an optional 'capability' element? I'm not sure how practical
>>>> is to leave that as 'others', because that puts it at the end of the
>>>> string. We'd want the element that's more important/with more variants
>>>> to be towards the start of the string so we can run all tests of the
>>>> same kind with the -r option.
>>> While also looking at different functions for figuring out the transport
>>> and invocation, my observation was that, there might be many capabiliti=
es
>>> added to the same test, while it might not be important also.
>>> Ex: /migrate/multifd/tcp/plain
>>> 1. multifd is defined as a migration mode.
>>> 2. It is also a capability, and comes in 2 parts [multifd, multifd-chan=
nels]
>>>   =C2=A0=C2=A0 though one is a capability and another is parameter
>>> Similarly in other examples of compression, there are many capabilities
>>> and parameters added, but it might be not important to mention that ?
>>>
>>> Secondly, there are multiple migration capabilities IIRC (> 15). And a =
test
>>> requiring multiple capabilities, the overall string would be too long, =
and
>>> not that important also to mention all capabilities.
>>>
>>> Just thinking out of mind - Can we have selective list of capabilities ?
>>> 1. multifd 2. compress (again, there might be confusion with multifd
>>> compression methods like zstd, zlib and just 'compress') 3. zero-page
>>> (This will have sub capabilities ?)
>> I was thinking of keeping that part more open-ended. So not specifying
>> capabilities one by one, but more like "if you're testing a capability,
>> it comes here".
>>
>> About multifd, it's a bit special since it cannot be seen as just a
>> "feature" anymore. It's a core part of the migration code. I wouldn't
>> classify it as capability for the purposes of the tests.
> Ack, got it.

Meta: it's a good idea to add a blank line before and after your reply
when replying inline like this, it makes it easier on the eyes to spot
the various snippets in a wall of text (note how this reply itself has
extra blank lines before and after it).

>>>>> test-type            :: migrate | validate
>>>> We could alternatively drop migration|migrate|validate. They are kind =
of
>>>> superfluous.
>>> I agree with the above comment. 'migrate' and 'validate' have a differe=
nt
>>> set of variables required, some necessary, while other optional. IMO th=
is
>>> will help is in streamlining the design further.
>>>>> migration-mode
>>>>>     a. migrate -->     :: precopy | postcopy | multifd
>>>>>     b. validate -->    :: (what to validate)
>>>>> methods              :: preempt | recovery | reboot | suspend | simple
>>> I want some inputs here.
>>> 1. is there a better variable name rather than 'methods'
>> Does this fall into the "mode" terminology that Steven introduced?
> Yes, as we decided that we don't want 'migration-mode' key-value pair,
> naming 'mode' would be a better term.
>
> In cases, where multiple modes are to be used ex: postcopy_preempt_recove=
ry
> I feel it might be a good idea to separate multiple modes by '-'
> For example - .../preempty-recovery/...
> Similarly for other keys too if required

Possibly... as long as we don't lose the ability of running subsets of
tests in one command, i.e. "all postcopy tests", "all postcopy recovery
tests", etc.

>>> 2. 'simple' does not fit perfect here IMO.
>> Can we go without it?
> You mean omit the key itself in case of a no-op ?

Yes

>>>>> transport            :: tcp | fd | unix | file
>>>>> invocation           :: uri | channels | both
>>>>> CompressionType      :: zlib | zstd | none
>>>> s/none/nocomp/ ? We're already familiar with that.
>>> Ack. Will change that.
>>>>> encryptionType       :: tls | plain
>>>> s/plain/notls/ ?
>>> What if there is another encryption technique in future ?
>>>> Or maybe we simply omit the noop options. It would make the string way
>>>> shorter in most cases.
>>> This might be a better approach. Can have some keys/variables as option=
al
>>> while some necessary. For ex: for 'migrate' - transport and invocation
>>> might be necessary while it might not be necessary for 'validate' qtests
>> Yep
> Ack, will do that!
>>>>> validate-test-result :: success | failure
>>>>> others               :: other comments/capability that needs to be
>>>>>                           addressed. Can be multiple
>>>>>
>>>>> (more than one applicable, separated by using '-' in between)
>>>>> O: optional
>>>>>
>>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>>>>> ---
>>>>>    tests/qtest/migration-test.c | 143 ++++++++++++++++++-------------=
----
>>>>>    1 file changed, 72 insertions(+), 71 deletions(-)
>>>>>
>>>>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-tes=
t.c
>>>>> index bd9f4b9dbb..bf4d000b76 100644
>>>>> --- a/tests/qtest/migration-test.c
>>>>> +++ b/tests/qtest/migration-test.c
>>> Regards,
>>> Het Gala
>> I'm wondering whether we should leave the existing tests untouched and
>> require the new format only for new tests. Going through a git bisection
>> with a change in the middle that alters test names would be infuriating.
> Hmm yup. I had this doubt on, how would we be enforcing the new design
> for any new qtests that gets added from now on ?

We put a big comment somewhere and refer to it during review. Perhaps at
main(), right before the migration_test_add calls.

> Can we have this design started for validation tests maybe for now, the
> number is low and might get some feedback to improve this ?

Ok. Please put this all together in a new version, make sure you mention
that you're not touching the old tests to preserve bisectability and
let's see what others think.

>
>
> Regards,
> Het Gala

