Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38346C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZSlD-000375-0Z; Thu, 01 Aug 2024 06:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZSlA-0002zK-P0
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:10:12 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZSl7-0007e9-Jr
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:10:12 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5a79df5af51so3511742a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722507006; x=1723111806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s3fRlURdb45/5xQ0tKGyepiwT9X1nBv2BpjzcUfb2so=;
 b=Ft+JYq4ppmt/dFMNUEVBbGX4znfn2won8qzkVad7/GegTgTqdQKoBRa+9dfVvKHRmz
 CwDRn95RsgYfKbzfW5Fs1EwQw/+L5sv7pQv5c1c/4CBTRX1aL7Uk2Z5fKX9R4Iz8vLIE
 X2i7Yi6TY0zNsbdLS4x79u70/dtXuTHV7GeR8ikNPSmuWSS7fYuf9rYzXTPTGzB1VajB
 q9ERopQCEplPh4w5hZvIkZBIxy6md4jSPqHdib6fyZLT3I135iR9YaSDBDRTqLUpqTim
 eKHst8tEib/LY7imsO/I6ZtzXSIvzZ9fyydL40VmWaDOQi/TEqdBOD2+HE1X/ZnJ4C3Y
 /36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722507006; x=1723111806;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s3fRlURdb45/5xQ0tKGyepiwT9X1nBv2BpjzcUfb2so=;
 b=decaBr6+PzHvLAYjrAI2waVcOneloCzG6Q7A1VzKofZvdmEkWpI2snG79yTSl455RZ
 rwgFNO+0oCt7E/2Fu1F4jNTEMCxdA10RoE/WENdv8gVdZ5YMEi0cBn+LBal+1EUhcS/D
 4zEoJx17inX8LX79Xahj+Rg6z2DPNe2vjsz/WFJVJiZM+We9al+Yu06BU8h5KXwYK6R5
 bZAIJVS9juG1eBWMFjWkHV1J/63ZM1E3l61+zj13hoWyC3mHQa/+aBUAH5IxKmYfdAWB
 EmZ0y55lZXm/DT95In1PQ4sCYj3fyO9P0koFIgjBVMssMG/Pz5pw37SqQG2CsxOHI25a
 H/hw==
X-Gm-Message-State: AOJu0YwIPX20IfJQC0m7sMFqyuPJXGKPM3ANPeiACC+qggrrlDVBv73C
 +kVDMnUkgzps1jFyL39sexlVW1ZaBp9LuEUgLvMFrTLLzsQ51NfRql9OrsLW0tU=
X-Google-Smtp-Source: AGHT+IHaJgPhIpHdQowJGPxOUCZFu1DmSYh8brYpdrD68QFhJkwUcjlNbN1dm8ewAQrDGx3b6X7psA==
X-Received: by 2002:a17:907:843:b0:a7a:b561:358e with SMTP id
 a640c23a62f3a-a7dbcd197bbmr72134666b.33.1722507005774; 
 Thu, 01 Aug 2024 03:10:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acac61218sm883512066b.94.2024.08.01.03.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:10:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4F3435F80C;
 Thu,  1 Aug 2024 11:10:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  John
 Snow <jsnow@redhat.com>,  qemu-ppc@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Ani Sinha <anisinha@redhat.com>,  Thomas
 Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 03/24] tests/functional: Set up logging
In-Reply-To: <20240730170347.4103919-4-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 30 Jul 2024 18:03:23
 +0100")
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-4-berrange@redhat.com>
Date: Thu, 01 Aug 2024 11:10:04 +0100
Message-ID: <875xskeepv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> Create log files for each test separately, one file that contains
> the basic logging and one that contains the console output.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/qemu_test/testcase.py | 27 +++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qe=
mu_test/testcase.py
> index 82cc1d454f..27bbf4a0af 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -31,7 +31,8 @@ class QemuBaseTest(unittest.TestCase):
>      arch =3D None
>=20=20
>      workdir =3D None
> -    log =3D logging.getLogger('qemu-test')
> +    log =3D None
> +    logdir =3D None
>=20=20
>      def setUp(self, bin_prefix):
>          self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must =
be set')
> @@ -42,6 +43,20 @@ def setUp(self, bin_prefix):
>          if not os.path.exists(self.workdir):
>              os.makedirs(self.workdir)
>=20=20
> +        self.logdir =3D self.workdir
> +        self.log =3D logging.getLogger('qemu-test')
> +        self.log.setLevel(logging.DEBUG)
> +        self._log_fh =3D logging.FileHandler(os.path.join(self.logdir,
> +                                                        'base.log'), mod=
e=3D'w')
> +        self._log_fh.setLevel(logging.DEBUG)
> +        fileFormatter =3D logging.Formatter(
> +            '%(asctime)s - %(levelname)s: %(message)s')
> +        self._log_fh.setFormatter(fileFormatter)
> +        self.log.addHandler(self._log_fh)

This is in the wrong place, we have a unique machine directory for each
run, the console.log should go in there.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

