Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E65C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 12:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkjyw-0007CE-Gs; Thu, 14 Mar 2024 08:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rkjys-00077R-Pi
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:14:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rkjyp-0007MK-Nu
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:14:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-413e61525c2so5956565e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710418477; x=1711023277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QR4pjjwgm5XaOqh28NmkniJonDS9mW+ocYdqeu416MU=;
 b=p9/8jG+ZFu/wihgmYP37rfEseWf3727Ft8gpVSwmna+jG6sxf8pvvHuqsNHuhvUrtH
 Wg9UkOj+oaOj8KwyZziaiRieW3K0WCMTZvxljAb1Hp7AKjrVAgVp+0rm30vjS4xIX6Zh
 tTd28Wce/sPYcrwZQVX1TskAth1jHJwmSmeiXbJNaTqk2eJbPdIUQJ+G5dJgI0ke9jGc
 CCPno1WpUhzH1YDC3vrNckvMYQkPw7qjfDXyuA+Tm+olygCZRVLpXkSF3qz6JTphaHdQ
 HtGM0lroZYwKj/uH00B2X+mkcwn37l1GNje4jJKVj0eyIbs1+m6OCWSci3cMv2aTDH2g
 WGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710418477; x=1711023277;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QR4pjjwgm5XaOqh28NmkniJonDS9mW+ocYdqeu416MU=;
 b=wOATDMvh/UYSvcarE5mK2c4dEMirUWDH0I7MfS+ZyNWr7qOLEOqiD0uSyUSOPGLIIW
 iS/SaK3VYadcYXt5Bwvo67ezixPutwpkoVDDpL/sqSI85B1EdeRPRaQhDTZFMOHQR2VM
 73tqwsIgxveAkoM/oCrA7lcRHrVTSRe+c3WWSMX+jIilNg6F7FEHtXcUTVkvJFwj/Sb1
 4GTk4QYnXCjpwTuvFD98CBqSUBryBFR4xBKDZm3H1mkMn8J+f+wtQRsOJts6o2ebISlO
 lTRt+1nVVzhdKZrZGdatN/8NFNawOB5e5jXNHURkOJbUxnC3d08gos1ip9L4yx1zZO3l
 tnhA==
X-Gm-Message-State: AOJu0Yz7f34p5yZ6ynAeVgIOLjFLSVe390nVKen4KJdAjmWQOiaXMvm6
 r+zFc1PwLkKHkQ4nPcOWdveQ6sAiM3ygHWjLx+VbH+OLozvu/rlc0MLS8KEv1ss=
X-Google-Smtp-Source: AGHT+IGmeat4qaHOi72IuCm8G8viUwTAfVgOIb/E0xXwZAWAKvo5DtNdhubQrTU9vw/0LvU35vl+QA==
X-Received: by 2002:a05:600c:1389:b0:413:ee4b:cd8e with SMTP id
 u9-20020a05600c138900b00413ee4bcd8emr1210956wmf.24.1710418477446; 
 Thu, 14 Mar 2024 05:14:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l19-20020a05600c4f1300b004130378fb77sm5560207wmq.6.2024.03.14.05.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 05:14:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA02B5F87D;
 Thu, 14 Mar 2024 12:14:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org,  Radoslaw Biernacki <rad@semihalf.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Leif Lindholm
 <quic_llindhol@quicinc.com>,  Cleber Rosa <crosa@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Wainer dos Santos
 Moschetta
 <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Brad Smith
 <brad@comstyle.com>,  qemu-arm@nongnu.org
Subject: Re: [PATCH v2 3/4] tests/avocado: use OpenBSD 7.4 for sbsa-ref
In-Reply-To: <20240314-sbsa-ref-firmware-update-v2-3-b557c56559cd@linaro.org>
 (Marcin Juszkiewicz's message of "Thu, 14 Mar 2024 10:23:26 +0100")
References: <20240314-sbsa-ref-firmware-update-v2-0-b557c56559cd@linaro.org>
 <20240314-sbsa-ref-firmware-update-v2-3-b557c56559cd@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.2
Date: Thu, 14 Mar 2024 12:14:36 +0000
Message-ID: <87bk7hggcz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org> writes:

> 7.4 was released in October 2023, time to update before 7.3 gets dropped.
>
> Disabled tests for 'max' cpu as OpenBSD fails there.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>  tests/avocado/machine_aarch64_sbsaref.py | 47 +++++++++++++++++++++++---=
------
>  1 file changed, 34 insertions(+), 13 deletions(-)
>
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/mac=
hine_aarch64_sbsaref.py
> index 259225f15f..0e52dc5854 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -159,14 +159,14 @@ def test_sbsaref_alpine_linux_max(self):
>      # This tests the whole boot chain from EFI to Userspace
>      # We only boot a whole OS for the current top level CPU and GIC
>      # Other test profiles should use more minimal boots
> -    def boot_openbsd73(self, cpu):
> +    def boot_openbsd(self, cpu):
>          self.fetch_firmware()
>=20=20
>          img_url =3D (
> -            "https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.im=
g"
> +            "https://cdn.openbsd.org/pub/OpenBSD/7.4/arm64/miniroot74.im=
g"
>          )
>=20=20
> -        img_hash =3D "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c=
44b9c129b707e5"
> +        img_hash =3D "7b08b2ce081cff6408d183f7152ddcfd2779912104866e4fdf=
6ae2d864b51142"
>          img_path =3D self.fetch_asset(img_url, algorithm=3D"sha256", ass=
et_hash=3Dimg_hash)
>=20=20
>          self.vm.set_console()
> @@ -180,23 +180,44 @@ def boot_openbsd73(self, cpu):
>          self.vm.launch()
>          wait_for_console_pattern(self,
>                                   "Welcome to the OpenBSD/arm64"
> -                                 " 7.3 installation program.")
> +                                 " 7.4 installation program.")
>=20=20
> -    def test_sbsaref_openbsd73_cortex_a57(self):
> +    def test_sbsaref_openbsd_cortex_a57(self):
>          """
>          :avocado: tags=3Dcpu:cortex-a57
> +        :avocado: tags=3Dos:openbsd
>          """
> -        self.boot_openbsd73("cortex-a57")
> +        self.boot_openbsd("cortex-a57")
>=20=20
> -    def test_sbsaref_openbsd73_neoverse_n1(self):
> +    def test_sbsaref_openbsd_neoverse_n1(self):
>          """
>          :avocado: tags=3Dcpu:neoverse-n1
> +        :avocado: tags=3Dos:openbsd
>          """
> -        self.boot_openbsd73("neoverse-n1")
> +        self.boot_openbsd("neoverse-n1")
>=20=20
> -    def test_sbsaref_openbsd73_max(self):
> -        """
> -        :avocado: tags=3Dcpu:max
> -        """
> -        self.boot_openbsd73("max")
> +# OpenBSD 7.4 does not boot on current max cpu.
> +#
> +#   def test_sbsaref_openbsd_max_pauth_off(self):
> +#       """
> +#       :avocado: tags=3Dcpu:max
> +#       :avocado: tags=3Dos:openbsd
> +#       """
> +#       self.boot_openbsd("max,pauth=3Doff")

If we are not going to delete the entries then at least use a @skip
instead of commenting. Maybe:

  @skip("Potential un-diagnosed upstream bug?")

but it would be nice to figure out exactly where is breaks.

> +
> +#   @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeo=
ut')
> +#   def test_sbsaref_openbsd_max_pauth_impdef(self):
> +#       """
> +#       :avocado: tags=3Dcpu:max
> +#       :avocado: tags=3Dos:openbsd
> +#       """
> +#       self.boot_openbsd("max,pauth-impdef=3Don")
> +
> +#   @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeo=
ut')
> +#   def test_sbsaref_openbsd_max(self):
> +#       """
> +#       :avocado: tags=3Dcpu:max
> +#       :avocado: tags=3Dos:openbsd
> +#       """
> +#       self.boot_openbsd("max")

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

