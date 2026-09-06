Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12AAC79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 11:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Ajp-00040W-BG; Sun, 06 Sep 2026 07:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1x3Ajl-0003rQ-Lo
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 07:08:37 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1x3Aji-0006o0-GH
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 07:08:35 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 5AD95240103
 for <qemu-devel@nongnu.org>; Sun,  6 Sep 2026 13:08:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1788692913;
 bh=T609RS/e+7zlTIokq4TP2rk84u81oCaTo3eg5TIuQUs=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=eP2214ZpVyb522IfJCVSixUAGJiPGxSAYdERkZK7N2uCnLTHdBswitG08okB2d+bz
 eWbNeiExn1l3xJy5ItE0Kr3GTykxMegjFjOY1AxmpRU+3V774FzIlw2mrV0ABMkXym
 DhbQnVRLlinZWWv0Y6wF8ee40zvMDbzWD6ER5WMoCkl89TiD7ieAkYxjyJk3/a9rR6
 DLJqK180WrbpjLAcKcFBE6Grg6QUw1qGC+NsuD7E7cutyzfC2yII43Bkc56IQ4r+Ih
 SQnrxmmMRZ8KeMQIfwp5NesaJukvn6qKU1XGsZZSKI20GPN44RnxSXqrEImj3/zTwB
 Z7yZr3Tv3Z35g==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hd6rZ1pRCz9rxh;
 Sun,  6 Sep 2026 13:08:30 +0200 (CEST)
Date: Sun, 06 Sep 2026 11:08:32 +0000
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
Subject: Re: [PATCH 8/9] tests/functional: add skipTestIfNoHMP() helper
Message-ID: <20260906130829.5926f44d@tpx1>
In-Reply-To: <20260906-nohmp-v1-8-daee96491c43@redhat.com>
References: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
 <20260906-nohmp-v1-8-daee96491c43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth+qemu@posteo.eu;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am Sun, 06 Sep 2026 12:42:39 +0400
schrieb Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/functional/qemu_test/testcase.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qe=
mu_test/testcase.py
> index 69d3d06cc0e3..bf2dc1dc101c 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -369,6 +369,12 @@ def require_accelerator(self, accelerator):
>              self.skipTest("%s accelerator does not seem to be "
>                            "available" % accelerator)
> =20
> +    def skipTestIfNoHMP(self):
> +        commands =3D self.vm.cmd('query-commands')
> +        if not any(cmd['name'] =3D=3D 'human-monitor-command'
> +                   for cmd in commands):
> +            self.skipTest('HMP support is not available')
> +
>      def require_netdev(self, netdevname):
>          helptxt =3D run([self.qemu_bin, '-M', 'none', '-netdev', 'help'],
>                        capture_output=3DTrue, check=3DTrue, encoding=3D'u=
tf8').stdout
>=20

Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu>

