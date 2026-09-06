Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E680AC79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 11:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Alb-0004pH-Qp; Sun, 06 Sep 2026 07:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1x3Ala-0004oh-A2
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 07:10:30 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1x3AlX-0007DR-CR
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 07:10:29 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id E172624002A
 for <qemu-devel@nongnu.org>; Sun,  6 Sep 2026 13:10:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1788693025;
 bh=ETB4YPbw4egXES0p2enWRkiq+/OVLJvDfb3Eotwyml4=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=eJJcucOp4xeJKD9OyMGR3bPVGqk2QenNGL+axlFaE8UhgSKc9K2LfKQ9ee4yNkDpX
 esUnon1ubafUdx4IJYrxF3nLeowPhML2gqTc1xypK8v7E7GDJI7nRRqMyG/Mv3iWH0
 cWkhrHqQ/mOvqzh/ZqA0B9b8QhTBAA5o2GGldxlhg8q6XbbHRcZTXEMe4ucDsSVobX
 dMMm3uAAWgDpSbZ1bbFKQCIoXbkkvKcbb4SeUyJuRmgM+TjR4OPoGqJh2/60pY1TwE
 rQTZCeJCb/+HwHtXNlJf1GjsfrThfR0tlOu5ZGWZ4pEDdIpBka1Grf2BIlY1CKJV5S
 Z9zbxkHQ9Sq0g==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hd6tk6nxpz9rxc;
 Sun,  6 Sep 2026 13:10:22 +0200 (CEST)
Date: Sun, 06 Sep 2026 11:10:25 +0000
From: Thomas Huth <th.huth+qemu@posteo.eu>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, "Denis V. Lunev"
 <den@openvz.org>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>, Aurelien Jarno
 <aurelien@aurel32.net>, qemu-arm@nongnu.org, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH 9/9] tests/functional: fix some tests that require HMP
Message-ID: <20260906131022.6302e9e0@tpx1>
In-Reply-To: <20260906-nohmp-v1-9-daee96491c43@redhat.com>
References: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
 <20260906-nohmp-v1-9-daee96491c43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth+qemu@posteo.eu;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am Sun, 06 Sep 2026 12:42:40 +0400
schrieb Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>:

> Those tests use "info registers" command and connot be converted

s/connot/cannot/

> easily, for now skip them
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/functional/m68k/test_nextcube.py | 1 +
>  tests/functional/ppc/test_ppe42.py     | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/tests/functional/m68k/test_nextcube.py b/tests/functional/m6=
8k/test_nextcube.py
> index dc99962eb75c..b0c0b653a7d0 100755
> --- a/tests/functional/m68k/test_nextcube.py
> +++ b/tests/functional/m68k/test_nextcube.py
> @@ -27,6 +27,7 @@ def check_bootrom_framebuffer(self, screenshot_path):
> =20
>          self.vm.add_args('-bios', rom_path)
>          self.vm.launch()
> +        self.skipTestIfNoHMP() # FIXME: QMP x-query-registers
> =20
>          self.log.info('VM launched, waiting for display')
>          # Wait for the FPU test to finish, then the display is available=
, too:
> diff --git a/tests/functional/ppc/test_ppe42.py b/tests/functional/ppc/te=
st_ppe42.py
> index 53958a7938d1..a9c154f67328 100755
> --- a/tests/functional/ppc/test_ppe42.py
> +++ b/tests/functional/ppc/test_ppe42.py
> @@ -72,6 +72,7 @@ def test_ppe42_instructions(self):
>          self.vm.add_args('-device', 'loader,addr=3D0xfff80040,cpu-num=3D=
0')
>          self.vm.add_args('-action', 'panic=3Dpause')
>          self.vm.launch()
> +        self.skipTestIfNoHMP() # FIXME: QMP x-query-registers
>          self._wait_pass_fail(self.timeout)

Why don't you use these as a decorator (with @) instead?

 Thomas

