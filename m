Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F96C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjcuM-0005ca-27; Tue, 14 Jul 2026 09:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wjcuK-0005bv-6l
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 09:10:44 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wjcuI-0005OY-9O
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 09:10:43 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2DED77E69;
 Tue, 14 Jul 2026 13:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784034638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OYlbjUJnEWgZjnu4KdQ0oYnvV7siLWirY008CXmAf/o=;
 b=kHym1ilCmbsZ9n23qZyFc/L8uY9yVoP7Spbx43AlqdWTUHxHGBtSDhhvrdc5rD28wfL7nF
 euTnoFVgpiW1Qs/c0iDfOm/gM0001zQx5nzixVzU8ovS9XChDpvdXP/abt8+6tbeJq2Muu
 6FPV1Uajrqocvwc7x9tD9iLhnRpZOeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784034638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OYlbjUJnEWgZjnu4KdQ0oYnvV7siLWirY008CXmAf/o=;
 b=cd8qsQ69bD0rA6F0xpF8uKUXtj6fc6gV6wHsz92VBVDi7ZlMljTvANmcKOjz8awuXrvjol
 dKqdcUErrA+evMBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GbWXsFsN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wxlNae5a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784034637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OYlbjUJnEWgZjnu4KdQ0oYnvV7siLWirY008CXmAf/o=;
 b=GbWXsFsNwB2Xw061un7Rd6xs62h04fHQmpa3vme2iDx0j9TJODXeCLubGx8EBLbh20NE3g
 Dkj9jg4xU6B3FIefl4di7QDuigUkg7ICwqP/adobzMr66ar1NBHhH+K0jivvIczAXAtLo1
 51702K5lZ06BwcWbNTLjUthaWkilF+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784034637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OYlbjUJnEWgZjnu4KdQ0oYnvV7siLWirY008CXmAf/o=;
 b=wxlNae5a3KBNLkf3tlu9n+FulQcXlLBSrvROPiyIvloVxBtB+TiM0JckE4Rt1Ad0lwMnD1
 Ow4L4W9W4jAlAfCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B479779AE;
 Tue, 14 Jul 2026 13:10:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YbWzA001VmquSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 Jul 2026 13:10:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, nutty.liu@hotmail.com, Palmer Dabbelt
 <palmer@dabbelt.com>, Tao Tang <tangtao1634@phytium.com.cn>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 2/3] hw/riscv/riscv-iommu.c: fault when !PTE_U and no
 priv access
In-Reply-To: <c5a9e4fb-5715-4805-8376-8ea13f5b48c5@tls.msk.ru>
References: <20260701121111.537654-1-daniel.barboza@oss.qualcomm.com>
 <20260701121111.537654-3-daniel.barboza@oss.qualcomm.com>
 <731566cb-bbdd-418f-b80e-f68750f24212@tls.msk.ru> <87tsq3doxw.fsf@suse.de>
 <c5a9e4fb-5715-4805-8376-8ea13f5b48c5@tls.msk.ru>
Date: Tue, 14 Jul 2026 10:10:26 -0300
Message-ID: <87zezt4szh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[15]; SUBJECT_HAS_EXCLAIM(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,hotmail.com];
 FREEMAIL_CC(0.00)[nongnu.org,wdc.com,gmail.com,linux.alibaba.com,oss.qualcomm.com,hotmail.com,dabbelt.com,phytium.com.cn,redhat.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, tls.msk.ru:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A2DED77E69
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> On 7/13/26 16:00, Fabiano Rosas wrote:
>> Michael Tokarev <mjt@tls.msk.ru> writes:
>> 
>
> [..]
>>> So, this patch adds a fix for the testing bits.
>>>
>>> When trying to pick this one up for 10.0.x (LTS) series, I've another doubt.
>>> This testing fix fixes v10.2.0-1299-g9d8ffbfc1d3 "tests/qtest/libqos: Add RISC-V
>>> IOMMU helper library".  Quite some tests were added based on that library.
>>> It doesn't exist in 10.0.x, and neither is v10.2.0-656-g489812e32df
>>> "tests/qtest/libqos: Add SMMUv3 helper library".
>>> Sure I can drop the parts of this change which touches the tests.  But this
>>> means we don't have tests to cover the issues being fixed, and I don't know
>>> if the result of these fixes actually works or not.
>>>
>>> Should we pick up some testing bits in this area for 10.0.x (especially
>>> 9d8ffbfc1d3 and some subsequent commits which use this library)?  Or just
>>> ignore all riscv iommu patches in there?
>> 
>> I worry picking tests for stable could become a development task,
>> requiring new code to make tests suitable for an older codebase/test
>> codebase.
>> 
>> The test frameworks and their supporting infrastructure (such as the
>> riscv iommu lib) don't ensure a stable abi so that a test from one
>> version will run without issues when backported to an earlier
>> version.
>
>> Also, the tests are usually not structured in a way that allow us to
>> pick just the part that tests the code fixes being backported, so we
>> risk trying to test in an earlier version features that don't even exist
>> at that point. There could also exist a complex graph of what's broken
>> vs. what is being tested (e.g. broken in v10, fixed partially in v11,
>> then test needs change, then fixed properly in v12, test needs change
>> again, etc).
>
> Things aren't that bad in practice.  Even a large new test lib with
> some significant amount of tests built on top mostly Just Works (tm).
> A bigger problem is to pick them up across various restructuring of
> code, moving and splitting files, etc.
>

Well, for qtest I rely a lot on the maintainers of the actual code being
tested knowing what they're doing, I can't keep up with every single
test that's added, so I think even somewhat trivial shuffling of code
would be disruptive. You're probably quite used to dealing with these
things during normal (non-test) backporting, so it's probably fine.

> Also, if a test fails due to old code, we can look and fix it, - it
> is just a test after all.  Or even mark it as "ok to fail" - if we know
> it's due to the old code.
>

Right, but this requires carrying stable-only patches, which makes me
confused. Again, my own lack of understanding.

> But having no tests at all - in my view - is worse.  Besides the tests
> which also needs some back-porting/reviewing work when picked up for
> older releases, the main code needs the same.  And without the tests
> in place -- no tests in place at all -- we just don't know if something
> is broken until users start reporting it.  Provided there *are* users
> of this code in the older releases to begin with :)
>

Sure, if you think the effort is not that big, having tests makes
everything easier, I agree.

> And actually, this last one is a good question, I think.  As in - do
> we really need the fixed iommu stuff in 10.0.x, when a lot of other
> development happened in this and other parts of riscv64 since then?
> 10.0.x is used in debian trixie (current stable), and probably that's
> it, - not even ubuntu uses it (which is derived from debian).  So, I
> wonder, if this stuff is really interesting to someone outside of the
> most active riscv community, who most likely uses the current qemu
> anyway?
>
> I'll pick this particular change to 10.0.x as the last missing one from
> this pull request, since all the others has been picked up (but without
> the change to tests).  Speaking of the future changes, lemme send a
> separate email summarizing all this in a single place.  It feels like
> we don't actually need many riscv changes in older 10.0.x at least.
>
> Thanks,
>
> /mjt

