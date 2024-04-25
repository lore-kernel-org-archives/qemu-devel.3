Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97482C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 12:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzyes-0004e4-3R; Thu, 25 Apr 2024 08:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rzyeb-0004bh-Nw
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 08:56:48 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rzyeZ-00066i-Pb
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 08:56:45 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 13D0F20CC9;
 Thu, 25 Apr 2024 12:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714049798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qfc4QTLVzM9EF9ULvRftiCJIn5hAPCbQPbJdZWMOWrA=;
 b=EML+6mdE26ZS7D2IQ54rEABXG93x6Udmpn0TNV39OfVCZIB9B7FvDAziJ/zqKC85Jeuzdn
 zH6AgZwLdGTOHCK/BGprIXZ9VjXZT6XUS4QmyUkpPxoavoEs+RlXJoZQ/pI95TFGFxHsA6
 ymVP16IIVL86OTTWkhmQ4YQbZWY+H4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714049798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qfc4QTLVzM9EF9ULvRftiCJIn5hAPCbQPbJdZWMOWrA=;
 b=GfQ9Kcjghtrg5HyrvTG0S+geiazA/Pik1bCFsGEVFBYzqKHDvBE2aXSns6FUC6YFVjEsRI
 2+r6vNFsdFXJkJBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EML+6mdE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GfQ9Kcjg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714049798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qfc4QTLVzM9EF9ULvRftiCJIn5hAPCbQPbJdZWMOWrA=;
 b=EML+6mdE26ZS7D2IQ54rEABXG93x6Udmpn0TNV39OfVCZIB9B7FvDAziJ/zqKC85Jeuzdn
 zH6AgZwLdGTOHCK/BGprIXZ9VjXZT6XUS4QmyUkpPxoavoEs+RlXJoZQ/pI95TFGFxHsA6
 ymVP16IIVL86OTTWkhmQ4YQbZWY+H4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714049798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qfc4QTLVzM9EF9ULvRftiCJIn5hAPCbQPbJdZWMOWrA=;
 b=GfQ9Kcjghtrg5HyrvTG0S+geiazA/Pik1bCFsGEVFBYzqKHDvBE2aXSns6FUC6YFVjEsRI
 2+r6vNFsdFXJkJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94AA31393C;
 Thu, 25 Apr 2024 12:56:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d7wCFwVTKmYWaAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 25 Apr 2024 12:56:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 00/17] CI job updates, header cleanups and other misc
 patches
In-Reply-To: <ZioMUCj57Ad9qR8k@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
 <d4b2c78e-c8d4-465c-a47e-53aa49efeb06@linaro.org>
 <91090e7f-4972-4473-8378-402c43116dba@redhat.com>
 <ZioMUCj57Ad9qR8k@redhat.com>
Date: Thu, 25 Apr 2024 09:56:35 -0300
Message-ID: <87bk5xiosc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 13D0F20CC9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.71 / 50.00];
 SEM_URIBL(3.50)[gitlab.com:url]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 BAD_REP_POLICIES(0.10)[]; MX_GOOD(-0.01)[];
 R_DKIM_ALLOW(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Apr 25, 2024 at 07:11:41AM +0200, Thomas Huth wrote:
>> On 24/04/2024 18.21, Richard Henderson wrote:
>> > On 4/24/24 00:57, Thomas Huth wrote:
>> > > The following changes since commit 13b1e9667737132440f4d500c31cb6932=
0c6b15a:
>> > >=20
>> > > =C2=A0=C2=A0 Merge tag 'for-upstream' of https://gitlab.com/bonzini/=
qemu into
>> > > staging (2024-04-23 17:35:57 -0700)
>> > >=20
>> > > are available in the Git repository at:
>> > >=20
>> > > =C2=A0=C2=A0 https://gitlab.com/thuth/qemu.git tags/pull-request-202=
4-04-24
>> > >=20
>> > > for you to fetch changes up to 8f29bab03ea22694a127ee33edeb4ce99eeb1=
24e:
>> > >=20
>> > > =C2=A0=C2=A0 target/s390x: Remove KVM stubs in cpu_models.h (2024-04=
-24 09:45:02 +0200)
>> > >=20
>> > > ----------------------------------------------------------------
>> > > * Update OpenBSD CI image to 7.5
>> > > * Update/remove Ubuntu 20.04 CI jobs
>> > > * Update CentOS 8 CI jobs to CentOS 9
>> > > * Some clean-ups and improvements to travis.yml
>> > > * Minor test fixes
>> > > * s390x header clean-ups
>> > > * Doc updates
>> >=20
>> > This introduces a failure in the migration-compat-x86_64 job:
>> >=20
>> > https://gitlab.com/qemu-project/qemu/-/jobs/6707154868
>>=20
>> It wasn't failing for me:
>>=20
>>  https://gitlab.com/thuth/qemu/-/jobs/6702058896
>>=20
>> And according to the diffstat of my pull request, it's only touching test
>> files, docs, and s390x stuff, so I somehow fail to see how it could
>> influence x86 migration at a first glance. It also looks like the job is
>> running on opensuse, and not on CentOS or Ubuntu, so it should likely no=
t be
>> influenced by the changes in this PR.
>>=20
>> Could you please hit the re-run button of that job? If it then passes, w=
e're
>> likely rather facing an intermitted failure that might have been introdu=
ced
>> earlier already...
>
> The specific job that's failiing is the multifd cancellation test.
> This is exactly the kind of functional area of migration where
> non-deterministic failures are likely to appear. So one for the
> migration maintainers to look at most likely.
>

Yes, that's the test that catches any race conditions on
error/cleanup. I agree that the PR here doesn't seem to interact with
any of that. The previous PR from Peter Xu has code that changes error
paths, so it's more likely to be it. The recent changes to the migration
tests are out of the picture as well because that CI job uses the
previous QEMU version's tests (i.e. 9.0).

I tried to reproduce it and no luck so far. Usually these bugs reproduce
well on my machine. I'll probably need to leave it running overnight to
find the race.

