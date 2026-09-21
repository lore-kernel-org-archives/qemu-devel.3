Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441B8C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8f1F-00024u-7V; Mon, 21 Sep 2026 10:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8f0h-0001v7-AB
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:28:53 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8f0c-00006K-Og
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:28:46 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45DD021CD2;
 Mon, 21 Sep 2026 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790000915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hEH4QaKvFGPtJq74lNej8Rl21ud0D9kOPYSsl9p8Ip4=;
 b=CiyOxa5QdghbnKyJLPEDzZ6qWXCyDuqJpgJjJjkGr1l27cGkIYUrtjmRrk++/CQxCxrdc2
 nwGgvE+v+rUNO8fC1atq1w+jNpBNcYfsKHz0LHoLiJ/aLbJnyub5jlP+wPR1JmvZ+ZCTyg
 QnXbrm45qgWHjNj1GHeHqpc3qOuB1LY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790000915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hEH4QaKvFGPtJq74lNej8Rl21ud0D9kOPYSsl9p8Ip4=;
 b=6m8jJkWtI8rJtc3nFrgudbsTyEHcHszG8OjP8ccXgitEVG9jKbkqHqMTWsi43u1VDPwqCi
 NQLZxjGagZSjnqDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790000911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hEH4QaKvFGPtJq74lNej8Rl21ud0D9kOPYSsl9p8Ip4=;
 b=vyq0fva9k1sY/BohGwJQxfuZbFI7Tk261ahUXUJVPQ3aEopJeXZUO8P9QHjUHW36EgsWfZ
 X6ZwnYO153KpIK60A6Ab/8QnbYIXUtT+rPyohXtgD0siimf70uDFKZp4p2cT9DBKptCYQg
 LhKJ7E63p2Q9Ov7k7UcG7dpjRkDsees=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790000911;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hEH4QaKvFGPtJq74lNej8Rl21ud0D9kOPYSsl9p8Ip4=;
 b=OMK8+OkfpM4HcVVAL8axJkgamXaqlD0PnH4z3vimIFG11Mv3/uu2w6Jl+yrVgjL1WjoFxU
 i5rq0t2bSNTZs6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BBEA1368D;
 Mon, 21 Sep 2026 14:28:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VNlyEA4/sWqPQQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 21 Sep 2026 14:28:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] meson: Fix meson suites invocation from make check
In-Reply-To: <arEMa6GTGGdIC1rZ@redhat.com>
References: <20260918203153.3874488-1-farosas@suse.de>
 <arEMa6GTGGdIC1rZ@redhat.com>
Date: Mon, 21 Sep 2026 11:28:24 -0300
Message-ID: <874ifismpj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[14]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[mtest2make.py:url, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, meson.build:url]
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

Thomas Huth <thuth@redhat.com> writes:

> On 18/09/2026 22.31, Fabiano Rosas wrote:
>> make check is currently by default running tests tagged
>> "slow".=20
> That's a regression, it did not used to be that way. Thus could you pleas=
e=20
> add a "Fixes:" tag to your patch?
>

So, in a sense, it's this commit:

  f4b2607228 ("tests: tag slow tests with 'slow' suite for easy filtering").

It added some qtests to the 'slow' suite. But the problem actually has
always existed, it's just that we usually put tests not only the 'slow'
suite but also some 'foo-slow'. The mtest2make.py script then omits the
'slow' suite...

  def process_tests(test, targets, suites):
              ...
              if s =3D=3D 'slow' or s =3D=3D 'thorough':
                  continue

...while the filtering omits the foo-slow:

  .speed.quick =3D $(foreach s,$(sort $(filter-out %-slow %-thorough,
  $1)), --suite $s)

But using the 'exclude_suites' in the main meson.build never did
anything. So the 'slow' suite is actually useless aside from the fact
that it carries the environment variables along.


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Sep 18, 2026 at 05:31:52PM -0300, Fabiano Rosas wrote:
>> make check is currently by default running tests tagged
>> "slow". Running make check with no SPEED variable set should be
>> equivalent to SPEED=3Dquick and run the meson 'quick' test setup, which
>> explicitly excludes slow tests:
>
> Can you give an example of some tests that you think should not
> be running.
>

Sorry, I could have worded this patch a bit better. I'm aiming
specifically at the (presumed) assumption that 'excluded_suites' in
meson.build is sufficient to stop a test from running if that test is in
one of the suites listed there.

For instance, all tests listed in the tests/qtest/meson.build
'slow_qtests' variable are affected:

$ ../configure
--target-list=3Dx86_64-softmmu,i386-softmmu,x86_64-linux-user,aarch64-softm=
mu,arm-softmmu,ppc64-softmmu,ppc-softmmu,s390x-softmmu,riscv64-softmmu,aarc=
h64-linux-user,mips64-softmmu,loongarch64-softmmu
--enable-plugins --enable-modules --enable-werror --enable-debug
--disable-docs --enable-slirp --disable-containers

$ make -j$(nproc) check | grep "+slow"
 1/1100 qemu:qtest+qtest-s390x+slow / qtest-s390x/qom-test
 2/1100 qemu:qtest+qtest-mips64+slow / qtest-mips64/qom-test
 3/1100 qemu:qtest+qtest-loongarch64+slow / qtest-loongarch64/qom-test
 4/1100 qemu:qtest+qtest-i386+slow / qtest-i386/qom-test
 <plus a bunch>

> I just run 'make check' and looked at two examples
>
> tests/unit/test-crypto-pbkdf.c  skips registering some tests
> unless "SPEED=3Dslow" and that correctly skipped them.
>
> tests/qemu-iotests/meson.build skips running 'raw' format tests
> unless SPEED=3Dslow, and that appears to be correctly working,
> only running qcow2 format tests by default.
>

Right, make SPEED=3Dspeed check works in the sense that:

1) it sets the SPEED properly
2) it excludes 'foo-slow' and 'slow' tests ("manually" via mtest2make.py)

however,

3) it does not exclude _the same test_ if it's part of another suite.


