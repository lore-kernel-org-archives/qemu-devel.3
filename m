Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E751C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 04:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmnf6-0000bG-Ad; Wed, 20 Mar 2024 00:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmnf4-0000al-QI
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 00:34:46 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmnf3-0004Td-2H
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 00:34:46 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e6c0098328so5170048b3a.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710909283; x=1711514083; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6FQIGA8JStx9X9I34Q1TVbzh9rgLQH+hIzRj+naRA8=;
 b=LftQLyVQSjVI4fdMJZ7zaoDO0UWxaLb0Un3WedIFD7cHb5d7zofmqesLKlBuvYRTkY
 sjXJMVRzLAsj+YgCSEVe695V/TZDozouWcVYidIKGaggUHSuStflf7KBknBRe93naFLF
 3aeyprdDtUSj6zK6s9mGPmLeHk1/ZCl8rJ8VbCzDqxa5Q0n6TXRL9ov0Rjck/8eH1iwY
 YyU1JiNakmw4mq07FSwTFyHwHc/Sc76g63NKHPcB+3/cNDCC4veHvIUWFhoTfCl49jGJ
 Z8PsvPW3wPzhK60U4dz3o5niS3dXCq/EQLnfVp8LV0qLwSvuc/u2978wwmn2y9ViZGdD
 ZP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710909283; x=1711514083;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M6FQIGA8JStx9X9I34Q1TVbzh9rgLQH+hIzRj+naRA8=;
 b=vW0uDuo3Q+ujpgeBBrrLwDK99XeHQgm/yNq7Pbax6YZIu+uEKsHoqH7uA2CWY9bLtM
 C0qa9fyMODeSaWguWA4yFgDRGE1UrJcfwuGerqOMGlCgPY01aJP7NgeZEDd9bxvVg0AJ
 hq0Isz3zhZUt8oZ1Y1FbLTg+yR1FKOWwaImb/wT/vdLapyf6NcXaPwOpuYJW7Obc2hNs
 BozbYZrXNZC+ur1fSjDeGw2r3jC0foo5eeCZH3vFxHcekByJPa17bXhKCQrDBw33FAf6
 qJZ+K4zY5mAlbL2TI6lV9h/lwGHLiBnvoDTxCK59PuLJjfvszp+8FDXMr0gAb1QD+Pa6
 cmzA==
X-Gm-Message-State: AOJu0Yz4LtopJ7xSb6qLspusImOe2NMVEiu6m9WXAMxVC3SB77Kct5u2
 MB7HmWwwowhqrQZlJ2wXjncfDBlqOIpSWTGfY47Y/BImhQAHM0R4
X-Google-Smtp-Source: AGHT+IGCsufb64e8+r8chUO2d9cK/mN3Gp9QvGp5cszLZn6yL9mVysGX6HgKZCqUs6F4Bjo38TDnbg==
X-Received: by 2002:a05:6a20:8427:b0:1a3:636d:642d with SMTP id
 c39-20020a056a20842700b001a3636d642dmr1031770pzd.45.1710909283347; 
 Tue, 19 Mar 2024 21:34:43 -0700 (PDT)
Received: from localhost (193-116-208-39.tpgi.com.au. [193.116.208.39])
 by smtp.gmail.com with ESMTPSA id
 t22-20020a17090ae51600b002a000f06db4sm306615pjy.5.2024.03.19.21.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 21:34:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Mar 2024 14:34:36 +1000
Message-Id: <CZYAPZ3RDQVU.2BHTMBKV41JH3@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: <qemu-devel@nongnu.org>, "Pavel Dovgalyuk" <Pavel.Dovgalyuk@ispras.ru>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "John Snow" <jsnow@redhat.com>, "Cleber Rosa"
 <crosa@redhat.com>, "Wainer dos Santos Moschetta" <wainersm@redhat.com>,
 "Beraldo Leal" <bleal@redhat.com>, "Michael Tokarev" <mjt@tls.msk.ru>
Subject: Re: [PATCH v5 13/24] tests/avocado: replay_linux.py remove the
 timeout expected guards
X-Mailer: aerc 0.15.2
References: <20240318154621.2361161-1-npiggin@gmail.com>
 <20240318154621.2361161-14-npiggin@gmail.com>
 <87h6h23y01.fsf@draig.linaro.org>
In-Reply-To: <87h6h23y01.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed Mar 20, 2024 at 3:57 AM AEST, Alex Benn=C3=A9e wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > replay_linux tests with virtio on aarch64 gciv3 and x86-64 q35 machines
> > seems to be more reliable now, so timeouts are no longer expected.
> > pc_i440fx, gciv2, and non-virtio still have problems, so mark them as
> > flaky: they are not just long-running, but can hang indefinitely.
> >
> > These tests take about 400 seconds each, so add the SPEED=3Dslow guard.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  tests/avocado/replay_linux.py | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux=
.py
> > index b3b91ddd9a..b3b74a367c 100644
> > --- a/tests/avocado/replay_linux.py
> > +++ b/tests/avocado/replay_linux.py
> > @@ -118,7 +118,7 @@ def run_replay_dump(self, replay_path):
> >          except subprocess.CalledProcessError:
> >              self.fail('replay-dump.py failed')
> > =20
> > -@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout=
')
> > +@skipUnless(os.getenv('SPEED') =3D=3D 'slow', 'runtime limited')
> >  class ReplayLinuxX8664(ReplayLinux):
> >      """
> >      :avocado: tags=3Darch:x86_64
> > @@ -127,19 +127,21 @@ class ReplayLinuxX8664(ReplayLinux):
> > =20
> >      chksum =3D 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc02695=
4f3c5c27a0'
> > =20
> > +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable'=
)
> >      def test_pc_i440fx(self):
> >          """
> >          :avocado: tags=3Dmachine:pc
> >          """
> >          self.run_rr(shift=3D1)
> > =20
> > +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable'=
)
> >      def test_pc_q35(self):
> >          """
> >          :avocado: tags=3Dmachine:q35
> >          """
> >          self.run_rr(shift=3D3)
> > =20
> > -@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout=
')
> > +@skipUnless(os.getenv('SPEED') =3D=3D 'slow', 'runtime limited')
> >  class ReplayLinuxX8664Virtio(ReplayLinux):
> >      """
> >      :avocado: tags=3Darch:x86_64
> > @@ -153,6 +155,7 @@ class ReplayLinuxX8664Virtio(ReplayLinux):
> > =20
> >      chksum =3D 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc02695=
4f3c5c27a0'
> > =20
> > +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable'=
)
> >      def test_pc_i440fx(self):
> >          """
> >          :avocado: tags=3Dmachine:pc
> > @@ -165,7 +168,7 @@ def test_pc_q35(self):
> >          """
> >          self.run_rr(shift=3D3)
> > =20
> > -@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout=
')
> > +@skipUnless(os.getenv('SPEED') =3D=3D 'slow', 'runtime limited')
> >  class ReplayLinuxAarch64(ReplayLinux):
> >      """
> >      :avocado: tags=3Daccel:tcg
> > @@ -187,6 +190,7 @@ def get_common_args(self):
> >                  '-device', 'virtio-rng-pci,rng=3Drng0',
> >                  '-object', 'rng-builtin,id=3Drng0')
> > =20
> > +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is
> > unstable')
>
> This needs to apply to both I think:
>
> (5/7) ./tests/avocado/replay_linux.py:ReplayLinuxAarch64.test_virt_gicv2:=
 SKIP: Test is unstable
>  (6/7)
>  ./tests/avocado/replay_linux.py:ReplayLinuxAarch64.test_virt_gicv3:
>  INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred:
>  Timeout reached\nOriginal status: ERROR\n{'name':
>  '6-./tests/avocado/replay_linux.py:ReplayLinuxAarch64.test_virt_gicv3',
>  'logdir':
>  '/home/alex/avocado/job-results/job-2024-03-19T16.50-686495d/test-result=
s/...
>  (1800.17 s)

Oh, aarch64 is hanging for you too? It was passing for me... But I'll
guard it out for now and maybe we can get back to it later.

Thanks,
Nick

>
> With that:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


