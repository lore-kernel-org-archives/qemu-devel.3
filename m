Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B52C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 11:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Aj9-0003K6-7H; Sun, 06 Sep 2026 07:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1x3Aj0-0003HL-PF
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 07:07:52 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1x3Aix-0006kx-HH
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 07:07:49 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 1A7AC240103
 for <qemu-devel@nongnu.org>; Sun,  6 Sep 2026 13:07:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1788692866;
 bh=pkr0KyrXyQqY5IYxL6uPTSNyEQeo0RAn8NujI9pcKt8=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=MkN3FS/G4EpbYq4n7eZ/L+4i7Jzb7yEhLRBcF/M8aTlFZS9X44ilo373nVvkPZRPN
 V5pjZ3rbZJdO2+C0cbpfwPhS/qTJLrMMdMW8mpsigZMhoWgMzaMi1S3oNGQVpcIMzH
 txfRb4ayekVr+p2vlU7PV5mMd/Re8haKWJ7ZGhz8GkD2Nqkc+NRzMpFt6YQ1T8Iqza
 7fTZe4j2+PtV5WmEW19qcqD2qPsDdNZtoUq5MbHOEKZPk9/xuDY3/W4GaWalxWAuZ8
 ABeoAaox038EN8k/0yQpoSlKJnWbl321OoE4oUnPeZoh/t3Wl0UrM74Dj7SRpiyruK
 mq9ifZJmtnFmA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hd6qf4zdPz9rxc;
 Sun,  6 Sep 2026 13:07:42 +0200 (CEST)
Date: Sun, 06 Sep 2026 11:07:45 +0000
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
Subject: Re: [PATCH 3/9] tests/functional/s390x: use QMP for balloon
Message-ID: <20260906130740.51d91c22@tpx1>
In-Reply-To: <20260906-nohmp-v1-3-daee96491c43@redhat.com>
References: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
 <20260906-nohmp-v1-3-daee96491c43@redhat.com>
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

Am Sun, 06 Sep 2026 12:42:34 +0400
schrieb Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>:

> Unit is changed from megabytes to bytes.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/functional/s390x/test_ccw_virtio.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/functional/s390x/test_ccw_virtio.py b/tests/functional=
/s390x/test_ccw_virtio.py
> index 1d4958bbe293..f816b1e201a1 100755
> --- a/tests/functional/s390x/test_ccw_virtio.py
> +++ b/tests/functional/s390x/test_ccw_virtio.py
> @@ -162,10 +162,10 @@ def test_s390x_devices(self):
>          # test the virtio-balloon device
>          exec_command_and_wait_for_pattern(self, 'head -n 1 /proc/meminfo=
',
>                                            'MemTotal:         115640 kB')
> -        self.vm.cmd('human-monitor-command', command_line=3D'balloon 96')
> +        self.vm.cmd('balloon', value=3D96 * 1024 * 1024)
>          exec_command_and_wait_for_pattern(self, 'head -n 1 /proc/meminfo=
',
>                                            'MemTotal:          82872 kB')
> -        self.vm.cmd('human-monitor-command', command_line=3D'balloon 128=
')
> +        self.vm.cmd('balloon', value=3D128 * 1024 * 1024)
>          exec_command_and_wait_for_pattern(self, 'head -n 1 /proc/meminfo=
',
>                                            'MemTotal:         115640 kB')
> =20
>=20

Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu>

