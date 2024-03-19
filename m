Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D04C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 17:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmdin-0006QN-M1; Tue, 19 Mar 2024 13:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmdim-0006OQ-69
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:57:56 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmdik-0006ZX-Gi
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:57:55 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56b93b45779so1437443a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710871071; x=1711475871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JlcRRynTmpL9IMC4HDXotCzYQJy69q+QUKQEx/wcOK4=;
 b=vatvv+c4pn/LdmdQjV64qvHLk0NMk5tT9ZpNDIAzNPEiPMgD9/xsN85B4QmN/To6D2
 ZQa5j1/zOq6uzpIO29temAfwBzzxlCG18nDpcniPQdiUnb831XtYUX77WvtgtK42V0me
 eebb/I/Mij87YRGQj3qVTA0ht80fMNt5sP5foEHsbjkAk+wMJ8ehy5TcCuDiGOdpuSH1
 GnEDNdYOfUXz1Ua/Pv9OBfXwxApqbvieJjiWpqCsD9iIkmbsMw18/5wKYWTgKwMFaB5C
 pJGJEBZj4Gk3/25bpI7sF8yfefvcGaqEbXwj+vj4z4NFXjlPjorHp4Ir/maefL8XV9+3
 1qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710871071; x=1711475871;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JlcRRynTmpL9IMC4HDXotCzYQJy69q+QUKQEx/wcOK4=;
 b=GLQsIDv7gL03f18NAtblj54sE8f66KQrpRhHGPBe1VMelS2nEtMlDHR373uBmXMAgd
 BgYGjkKSDezlecbPU0vf90TO5RM4gkh36ZscA6cCspw3DSHUH5sLOUS1pE2ZmE0daCeV
 CTef2gYdRucnTGt22uz4NmoQy4fd7IhgUcLPjujEv8VdSo09CwLx6w8CJvh+8ozXQf60
 GTPyNu/JPkt3+I00qN1t57QSVaLJCwtVzDU4Zl1o8gmo4kXuEx6yosZz9ftcKoqsUdFO
 AbS8oWwv0yaiP0OxQkHWFkdepDY2PRBp9fwQ/Y9+BtLfSHbwdcbEXOOl3hTNCye/PYmC
 W21g==
X-Gm-Message-State: AOJu0YxGTwOK9tWUstouoBHDqwO4V/6f6znx/IvLVJiX7fV13fiziq7D
 NAKyTFLzAzK7arWEqv4z7GiZp0y2HPpNEO+JRooSn0EaeLxdvT2Eu6z52Lhz9hw=
X-Google-Smtp-Source: AGHT+IH2fIn40Y0iDv2svBhhomfmJQBrPQorCZTaS3tWIYOQBR4uzSaJ9uYUw1lzlRgp7ov9Cm2VHQ==
X-Received: by 2002:a17:906:22cd:b0:a46:5a46:7512 with SMTP id
 q13-20020a17090622cd00b00a465a467512mr10263969eja.74.1710871070995; 
 Tue, 19 Mar 2024 10:57:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 pv27-20020a170907209b00b00a44fcdf20d1sm6323130ejb.189.2024.03.19.10.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 10:57:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2217C5F75D;
 Tue, 19 Mar 2024 17:57:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v5 13/24] tests/avocado: replay_linux.py remove the
 timeout expected guards
In-Reply-To: <20240318154621.2361161-14-npiggin@gmail.com> (Nicholas Piggin's
 message of "Tue, 19 Mar 2024 01:46:10 +1000")
References: <20240318154621.2361161-1-npiggin@gmail.com>
 <20240318154621.2361161-14-npiggin@gmail.com>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Tue, 19 Mar 2024 17:57:50 +0000
Message-ID: <87h6h23y01.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Nicholas Piggin <npiggin@gmail.com> writes:

> replay_linux tests with virtio on aarch64 gciv3 and x86-64 q35 machines
> seems to be more reliable now, so timeouts are no longer expected.
> pc_i440fx, gciv2, and non-virtio still have problems, so mark them as
> flaky: they are not just long-running, but can hang indefinitely.
>
> These tests take about 400 seconds each, so add the SPEED=3Dslow guard.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/avocado/replay_linux.py | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
> index b3b91ddd9a..b3b74a367c 100644
> --- a/tests/avocado/replay_linux.py
> +++ b/tests/avocado/replay_linux.py
> @@ -118,7 +118,7 @@ def run_replay_dump(self, replay_path):
>          except subprocess.CalledProcessError:
>              self.fail('replay-dump.py failed')
>=20=20
> -@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
> +@skipUnless(os.getenv('SPEED') =3D=3D 'slow', 'runtime limited')
>  class ReplayLinuxX8664(ReplayLinux):
>      """
>      :avocado: tags=3Darch:x86_64
> @@ -127,19 +127,21 @@ class ReplayLinuxX8664(ReplayLinux):
>=20=20
>      chksum =3D 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f=
3c5c27a0'
>=20=20
> +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable')
>      def test_pc_i440fx(self):
>          """
>          :avocado: tags=3Dmachine:pc
>          """
>          self.run_rr(shift=3D1)
>=20=20
> +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable')
>      def test_pc_q35(self):
>          """
>          :avocado: tags=3Dmachine:q35
>          """
>          self.run_rr(shift=3D3)
>=20=20
> -@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
> +@skipUnless(os.getenv('SPEED') =3D=3D 'slow', 'runtime limited')
>  class ReplayLinuxX8664Virtio(ReplayLinux):
>      """
>      :avocado: tags=3Darch:x86_64
> @@ -153,6 +155,7 @@ class ReplayLinuxX8664Virtio(ReplayLinux):
>=20=20
>      chksum =3D 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f=
3c5c27a0'
>=20=20
> +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable')
>      def test_pc_i440fx(self):
>          """
>          :avocado: tags=3Dmachine:pc
> @@ -165,7 +168,7 @@ def test_pc_q35(self):
>          """
>          self.run_rr(shift=3D3)
>=20=20
> -@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
> +@skipUnless(os.getenv('SPEED') =3D=3D 'slow', 'runtime limited')
>  class ReplayLinuxAarch64(ReplayLinux):
>      """
>      :avocado: tags=3Daccel:tcg
> @@ -187,6 +190,7 @@ def get_common_args(self):
>                  '-device', 'virtio-rng-pci,rng=3Drng0',
>                  '-object', 'rng-builtin,id=3Drng0')
>=20=20
> +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is
> unstable')

This needs to apply to both I think:

(5/7) ./tests/avocado/replay_linux.py:ReplayLinuxAarch64.test_virt_gicv2: S=
KIP: Test is unstable
 (6/7)
 ./tests/avocado/replay_linux.py:ReplayLinuxAarch64.test_virt_gicv3:
 INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred:
 Timeout reached\nOriginal status: ERROR\n{'name':
 '6-./tests/avocado/replay_linux.py:ReplayLinuxAarch64.test_virt_gicv3',
 'logdir':
 '/home/alex/avocado/job-results/job-2024-03-19T16.50-686495d/test-results/=
...
 (1800.17 s)

With that:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

