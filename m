Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80550C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 19:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf3G8-0006e8-1c; Tue, 27 Feb 2024 14:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rf3G6-0006ca-KI
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 14:36:58 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rf3G4-0001vs-SF
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 14:36:58 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33de620be53so994648f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 11:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709062614; x=1709667414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ik4wwRMPrCLyHC57PB4KMsNysABJZFgdjJv+Ih7c0/c=;
 b=zZN2fI7nD5g1T9Pt8xbFzEVNJw1SHn6i9rXAvwkgoXx7lz11Mjhs2wuJu/kV+JCR+L
 oEuUDxhSH2OxVdfdFikeyKxh8udR92DVZTdUL/j5XJeiWKuFAmo0jtK5NrVxh2Peyy7k
 YI3aKzHWGhennQHHOE4KL1HC6U+kxMc1EZGpRZA2WhJZm960O7tAmOscD2iEG8FzUa33
 kvY3qsKq+OTi1g09d4qRTj1qTAyi3u1jxPNJJDfp5rUJXgEBq2fERclT326QS8pE8458
 p0QjJLw57i1EetixZ/s0tE5QqI5M3VH8kEd9TMI8ue9m34WGf1HTy3+PY6SRtGJFAIKR
 ReVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709062614; x=1709667414;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ik4wwRMPrCLyHC57PB4KMsNysABJZFgdjJv+Ih7c0/c=;
 b=NASp0A0z2uXCf6cpOrKpsYnJpegBOYN0cGe/K9V7I9VcgGC3OlCEp4h0M3PridSIoD
 E8h6hQOn3CH+7b8nbq6Lu/WyMqwDRaTzCQZgiDp+F/tKrB4/vVi3qox5HCcsrNTahDCS
 5wBXE65EBXzb5lKHWm3JDvQM9geqvnwR13f266Rag9VVS89lOldW9ZyIsRd3Zi5XNboz
 wSUZ9q1/7djd//IS0Lli2HP4SZSFMqYhoOsbQRUnFu03HKc9iDE+ML3n0ALY0EBkOzL5
 K76Vu1dZ9QIeRR1O2kMuNP3T580OB6O6QusjhbqpDXLdkYKbmSZvUFgqHetWyHgT7KDJ
 Uxeg==
X-Gm-Message-State: AOJu0Yz7gnoUahUaHU+Ee2lNXzQ+n/HwofJEoTJhkIJifkAa74U+xNY2
 gmirl2Yyb4pd5dizs6lsEDgDyZVZsoFUOtNCRVdgUltEI+8dijVjjCvS8thWZCI=
X-Google-Smtp-Source: AGHT+IE9jGWOITPKeXkvtuJHfebsUpehK+abDT6T//haHq6W4axYpT9xRRVxlNQGuDiif9C4zgpB+g==
X-Received: by 2002:adf:f9c6:0:b0:33d:1ee9:d71a with SMTP id
 w6-20020adff9c6000000b0033d1ee9d71amr7355897wrr.64.1709062614103; 
 Tue, 27 Feb 2024 11:36:54 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 by6-20020a056000098600b0033d568f8310sm12439240wrb.89.2024.02.27.11.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 11:36:53 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 72C8E5F7AE;
 Tue, 27 Feb 2024 19:36:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>
Subject: Re: [PATCH v3 9/9] tests/avocado/reverse_debugging.py: mark aarch64
 and pseries as not flaky
In-Reply-To: <20240226082945.1452499-10-npiggin@gmail.com> (Nicholas Piggin's
 message of "Mon, 26 Feb 2024 18:29:45 +1000")
References: <20240226082945.1452499-1-npiggin@gmail.com>
 <20240226082945.1452499-10-npiggin@gmail.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Tue, 27 Feb 2024 19:36:53 +0000
Message-ID: <874jdtd7hm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

> These seem to be quite solid, including on several gitlab CI runs.
> Enabling them should help catch breakage in future.
>
> And update the powernv comment -- gitlab isn't the problem, there are
> known gaps in implementation.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/avocado/reverse_debugging.py | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_d=
ebugging.py
> index 92855a02a5..8fe76ff921 100644
> --- a/tests/avocado/reverse_debugging.py
> +++ b/tests/avocado/reverse_debugging.py
> @@ -223,9 +223,6 @@ class ReverseDebugging_AArch64(ReverseDebugging):
>=20=20
>      REG_PC =3D 32
>=20=20
> -    # unidentified gitlab timeout problem
> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on=
 GitLab')
> -
>      def test_aarch64_virt(self):
>          """
>          :avocado: tags=3Darch:aarch64
> @@ -248,14 +245,10 @@ class ReverseDebugging_ppc64(ReverseDebugging):
>=20=20
>      REG_PC =3D 0x40
>=20=20
> -    # unidentified gitlab timeout problem
> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on=
 GitLab')
> -
>      def test_ppc64_pseries(self):
>          """
>          :avocado: tags=3Darch:ppc64
>          :avocado: tags=3Dmachine:pseries
> -        :avocado: tags=3Dflaky
>          """
>          # SLOF branches back to its entry point, which causes this test
>          # to take the 'hit a breakpoint again' path. That's not a proble=
m,
> @@ -264,7 +257,7 @@ def test_ppc64_pseries(self):
>          self.reverse_debugging()
>=20=20
>      # See https://gitlab.com/qemu-project/qemu/-/issues/1992
> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on=
 GitLab')
> +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'powernv migration s=
upport is incomplete so rr debugging is flaky')
>=20=20
>      def test_ppc64_powernv(self):
>          """

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

