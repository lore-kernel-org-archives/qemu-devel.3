Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7635C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 17:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taebo-00033J-Gm; Wed, 22 Jan 2025 12:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taebm-000336-L0
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:33:42 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taebk-00053G-QC
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:33:42 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43618283d48so52477425e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 09:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737567219; x=1738172019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=synsY6tQ8ZhXSPYRBlEQ8Zvr9M+GKNzyNjmn9WoEKKY=;
 b=am1z2X06oeHyVRUBiZy2fI+xFeHxLNAUj1MGRXb30PtszQXkayUXPZAobtcoaldpAA
 4Tpvejpl38MJuW2t6MAvg6xjPCNoS4PIYszYwPFlCd2nc7Enw9liZhSMVM/ggA87B7tS
 +RVLMi/4ukKkiSJhvXboCsc8xiSHSBM+gtsYnSuyzHnHinQuwkQ5uFy77XybUS0HyhhU
 O5+dxURVWzodBoHNAMRTw51GjgkZpMu5PF46RJLfIWu8cPlPNBtNuXI2wY3mBhltVaZ/
 MM6AsqVW7qB0BgwJfqxEHgQHg5qBdsW9vWV+tx5Fby3/6eq9AkiNs6dM0p6VlbxTKt6K
 3yGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737567219; x=1738172019;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=synsY6tQ8ZhXSPYRBlEQ8Zvr9M+GKNzyNjmn9WoEKKY=;
 b=vuaAOz2AofdSuPxtBFa5l5zdKK0Ikdkpi6YS0+rTxppUEf3O2SZLkf2a4Crp2ITKcG
 3+PBey+60MPm7+zeqddoWfhrmk2bMBeLwKGvatOyS5D4gggtdF8ZK6+IUHkuPnxB1s37
 Oof5TYLzxtJThkB4GnN9ka76qE0h+inm5jMwkJr6CrnYMjaENURQQyPLhvSRC0vxg+tt
 OjMXihQxn70dKDJEHvB3RgrmqVsS2t5twJqdiC/H8xgAgWsKUtS7dTU0SYov8Sgb+dHm
 MFTlgVTvyes4iwmrRlSulJL2sRJ2B+NUT9L3Dlsua6bYhUnQcW+Rwj4/MeX4Mp/qJxJW
 3gQA==
X-Gm-Message-State: AOJu0Yw1i5mtW4Q1PQc37fPyNC/CxtNp74YncWgVb4gLtJH3Ms0F2/y4
 Sy6ObQoBRENnVx0WbQ6R1p/ayE2+Q6Bu5RTZsjQiv0olpqkVQJ4hvN6dY6OMihk=
X-Gm-Gg: ASbGncu7RHG+sInGLKwRM2OmrfLKL5IV8+xBJXDFuTS4iTVBp0suKL0CY9YX+bFtgDd
 NKpBPftv73FSONdUte1JlpL6EQ0zcx8sJu1J6nhZaNShBIQUedQuphpsRUqCvRyVawuMSRMqTGZ
 1+pmigX91jpj5vmJbAN3w7OQHYg1qfXR8XFwc1SDlX0r143rxc2j0h8cshRIHOjNLNwj5KKsZHU
 EmJHGSNeuCmNomnlh9svrKRVgTibNW2DOJeHBFyOiFwftnyaEArUMVl0o7HxerJVuhE
X-Google-Smtp-Source: AGHT+IEYvR24cS6cikLmhcevrLPalIiqxnWLHz+Lv2nU4/NMM3fLuaW/B3lEOH6OY7GQO15hzurNPQ==
X-Received: by 2002:a05:600c:4ed4:b0:434:fdbc:5cf7 with SMTP id
 5b1f17b1804b1-438914373e4mr206889615e9.27.1737567218102; 
 Wed, 22 Jan 2025 09:33:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b318c176sm34011155e9.3.2025.01.22.09.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:33:36 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BFBAB5FA4B;
 Wed, 22 Jan 2025 17:33:35 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Alexandre
 Iooss
 <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] tests/functional: Fix the aarch64_tcg_plugins test
In-Reply-To: <20250122091517.1429734-1-thuth@redhat.com> (Thomas Huth's
 message of "Wed, 22 Jan 2025 10:15:17 +0100")
References: <20250122091517.1429734-1-thuth@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 22 Jan 2025 17:33:35 +0000
Message-ID: <87ed0un47k.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> Unfortunately, this test had not been added to meson.build, so we did
> not notice a regression: Looking for 'Kernel panic - not syncing: VFS:'
> as the indication for the final boot state of the kernel was a bad
> idea since 'Kernel panic - not syncing' is the default failure
> message of the LinuxKernelTest class, and since we're now reading
> the console input byte by byte instead of linewise (see commit
> cdad03b74f75), the failure now triggers before we fully read the
> success string. Let's fix this by simply looking for the previous
> line in the console output instead.
>
> Also, replace the call to cancel() - this was only available in the
> Avocado framework. In the functional framework, we must use skipTest()
> instead.
>
> Fixes: 3abc545e66 ("tests/functional: Convert the tcg_plugins test")
> Fixes: cdad03b74f ("tests/functional: rewrite console handling to be byte=
wise")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/meson.build                 | 1 +
>  tests/functional/test_aarch64_tcg_plugins.py | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 5457331643..e0a276f349 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -72,6 +72,7 @@ tests_aarch64_system_thorough =3D [
>    'aarch64_sbsaref',
>    'aarch64_sbsaref_alpine',
>    'aarch64_sbsaref_freebsd',
> +  'aarch64_tcg_plugins',

The test only takes a few seconds to run so maybe it can go in the basic te=
sts?

>    'aarch64_tuxrun',
>    'aarch64_virt',
>    'aarch64_xlnx_versal',
> diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functio=
nal/test_aarch64_tcg_plugins.py
> index 01660eb090..357eb48477 100755
> --- a/tests/functional/test_aarch64_tcg_plugins.py
> +++ b/tests/functional/test_aarch64_tcg_plugins.py
> @@ -46,7 +46,7 @@ def run_vm(self, kernel_path, kernel_command_line,
>          except:
>              # TODO: probably fails because plugins not enabled but we
>              # can't currently probe for the feature.
> -            self.cancel("TCG Plugins not enabled?")
> +            self.skipTest("TCG Plugins not enabled?")

We can be more explicit now, something like:

        try:
            vm.launch()
        except VMLaunchFailure as excp:
            if "plugin interface not enabled in this build" in excp.output:
                self.skipTest("TCG plugins not enabled")
            else:
                self.log.info(f"unhandled launch failure: {excp.output}")
                raise excp


>=20=20
>          self.wait_for_console_pattern(console_pattern, vm)
>          # ensure logs are flushed
> @@ -65,7 +65,7 @@ def test_aarch64_virt_insn(self):
>          kernel_path =3D self.ASSET_KERNEL.fetch()
>          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
>                                 'console=3DttyAMA0')
> -        console_pattern =3D 'Kernel panic - not syncing: VFS:'
> +        console_pattern =3D 'Please append a correct "root=3D" boot opti=
on'
>=20=20
>          plugin_log =3D tempfile.NamedTemporaryFile(mode=3D"r+t", prefix=
=3D"plugin",
>                                                   suffix=3D".log")
> @@ -91,7 +91,7 @@ def test_aarch64_virt_insn_icount(self):
>          kernel_path =3D self.ASSET_KERNEL.fetch()
>          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
>                                 'console=3DttyAMA0')
> -        console_pattern =3D 'Kernel panic - not syncing: VFS:'
> +        console_pattern =3D 'Please append a correct "root=3D" boot opti=
on'
>=20=20
>          plugin_log =3D tempfile.NamedTemporaryFile(mode=3D"r+t", prefix=
=3D"plugin",
>                                                   suffix=3D".log")

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

