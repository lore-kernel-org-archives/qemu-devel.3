Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA27FC88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x629I-0003CJ-U4; Mon, 14 Sep 2026 04:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x629G-0003Bo-Bw
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x629D-0004Oc-Lv
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789374882;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hLbSBMm2TGXe3YxOChiExQDa4WeW2g5/Tbo7topPfxc=;
 b=JC+7xuXf6M8kBGzcoNFVbTgU5LTsI0z9os/0uH3aGZLrpKBDpmJQLDpSeLK3ZI30paUXAz
 wFS/5/MeyN3eGSRW2IvRRDb+s26pMa4xsZZoZaN90bK7N4qnCwriQWLtFT2siPuGyuN/lb
 YgAAmqV97fYemoZLn0O+ba/SfTCuCeY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-twHBuFmPNCGZdnDamXCWqw-1; Mon,
 14 Sep 2026 04:34:39 -0400
X-MC-Unique: twHBuFmPNCGZdnDamXCWqw-1
X-Mimecast-MFC-AGG-ID: twHBuFmPNCGZdnDamXCWqw_1789374877
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAC9B18002D7; Mon, 14 Sep 2026 08:34:35 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AF29195604D; Mon, 14 Sep 2026 08:34:30 +0000 (UTC)
Date: Mon, 14 Sep 2026 09:34:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 2/9] tests/tcg: improve check for working cross compilers
Message-ID: <aqexk7afMhWLxf3w@redhat.com>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-3-alex.bennee@linaro.org>
 <22dca41b-3833-45d2-912f-b05a77d7d883@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22dca41b-3833-45d2-912f-b05a77d7d883@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Sep 13, 2026 at 10:08:52PM -0700, Pierrick Bouvier wrote:
> On 9/10/26 11:14 AM, Alex Bennée wrote:
> > From: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > When it finds a cross compiler, tests/tcg/meson.build tries
> > building test_cc.c to validate that the compiler works. This
> > includes "stdint.h" as a witness for working C library, however,
> > that is not a good choice as it can be provided by the toolchain
> > alone:
> > 
> >    $ rpm -ql gcc-s390x-linux-gnu  | grep /stdint.h
> >    /usr/lib/gcc/s390x-linux-gnu/16/include/stdint.h
> > 
> > As a result, if you install the s390x GCC cross compiler, but
> > not any C library, meson decides to use the host compiler instead
> > of the container:
> > 
> >      cc for aarch64-softmmu          : aarch64-linux-gnu-gcc (from 'debian-all-test-cross' container)
> >      cc for loongarch64-softmmu      : loongarch64-unknown-linux-gnu-gcc (from 'debian-loongarch-cross' container)
> >      cc for riscv64-softmmu          : riscv64-linux-gnu-gcc (from 'debian-all-test-cross' container)
> >      cc for s390x-softmmu            : s390x-linux-gnu-gcc
> >      cc for x86_64-softmmu           : x86_64-linux-gnu-gcc (from 'debian-amd64-cross' container)
> > 
> > Eventually this results in failure to run 'make check':
> > 
> > [33/40] Generating tests/tcg/s390x-softmmu-hello with a custom command
> > FAILED: [code=1] tests/tcg/s390x-softmmu-hello.test
> > /usr/bin/s390x-linux-gnu-gcc /home/berrange/src/virt/qemu/tests/tcg/multiarch/system/hello.c -o tests/tcg/s390x-softmmu-hello.test -static -MMD -MF tests/tcg/s390x-softmmu-hello.d -Wall -Werror -O0 -g -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I /home/berrange/src/virt/qemu/tests/tcg/s390x/system/../../minilib /home/berrange/src/virt/qemu/tests/tcg/s390x/system/../../minilib/printf.c -I /home/berrange/src/virt/qemu/include/hw/s390x/ipl -march=z13 ../tests/tcg/s390x/system/../head64.S ../tests/tcg/s390x/system/../console.c
> > In file included from ../tests/tcg/s390x/system/../console.c:8:
> > ../tests/tcg/s390x/system/../../../../pc-bios/s390-ccw/sclp.c:11:10: fatal error: string.h: No such file or directory
> >     11 | #include <string.h>
> >        |          ^~~~~~~~~~
> > compilation terminated.
> > 
> > Adding more include files to the test program ensures the
> > meson probe makes a better decision.
> > 
> > Fixes: e5d084d622b1 (tests/tcg/meson.build: check host cross cc is working)
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > Message-ID: <20260910100120.2076092-1-berrange@redhat.com>
> > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> > ---
> >   tests/tcg/test_cc.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
> > index d3614a01fe6..fafee055b40 100644
> > --- a/tests/tcg/test_cc.c
> > +++ b/tests/tcg/test_cc.c
> > @@ -1,7 +1,11 @@
> >   /* SPDX-License-Identifier: GPL-2.0-or-later */
> > -/* Include a standard header to make sure cross compiler provides them */
> > +/* Use some standard headers to ensure the cross compiler provides them */
> >   #include <stdint.h>
> > +#include <string.h>
> > +#include <stdbool.h>
> > +#include <stddef.h>
> > +#include <stdio.h>
> >   int main(void)
> >   {
> 
> Ideally, we should do separate tests for system vs user tests.
> System ones are always compiled with -ffreestanding, while user ones should
> provide a C library.
> 
> From this standard:
> 
> https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2023/p2338r3.html
> ```
> A freestanding C implementation is required to provide the entirety of the
> following headers:
> 
> <float.h>
> <iso646.h>
> <limits.h>
> <stdalign.h>
> <stdarg.h>
> <stdbool.h>
> <stddef.h>
> <stdint.h>
> <stdnoreturn.h>
> Most of <string.h> is required (strdup, strndup, strcoll, strxfrm, and
> strerror are excluded). This includes strtok, which requires global data.
> ```
> 
> Maybe for now we can just remove stdio.h from current patch, as it's not
> supposed to be provided in a freestanding environment.

A huge number of files under tests/tcg/ have a #include <stdio.h>
currently.

In the example build failure in the commit message, we have

  tests/tcg/s390x/system/../console.c

which does

  #include "../../../pc-bios/s390-ccw/sclp.c"

and sclp.c has

  #include "s390-ccw.h"

and that header has:

  #include <stdbool.h>
  #include <stddef.h>
  #include <stdint.h>
  #include <stdio.h>

hence the 4 headers I added to the meson check.

So AFAICT, our code is expecting stdio.h to be provided in a
-ffreestanding build. Have we got a more fundamental mistake
wrt our use of -ffreestanding, such that it is relying on
unintended functionality ?

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


