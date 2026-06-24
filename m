Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A3BCDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcOzx-0001Bd-S0; Wed, 24 Jun 2026 10:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcOzr-0001BA-JF
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:54:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcOzp-00079P-W0
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:54:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-46cbe01d4b6so424711f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782312872; x=1782917672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLBor9SSfwnE0xzMTqhApNDSzUC1PT3lW3joM8mFsTs=;
 b=XViBfvIMJD2OInk530gAp/5R6gtn5KR13l87gIwNlVvupPW0Bw5TO3Zrq9TX8uSPKZ
 S6+K2fqjX4IKz84ROM6W3ewtNy+WA2AiT2Lg3CNJKDEdls0QiILk/56quntFIUyw4ltG
 eAZw51uzC6HAOsOPabDE7izelQSmsnCAgW7hPu1j0xRR0suWZIRuAShF8G4pF6lgYW8J
 KZ4yQ5e1SmeWpkItkD0L/ylknz3lMKVj5HD3SQ4AyCrqb73BAB27lcvO0RxM7CDJbd+J
 dPvM8xOuW5UuoHryO+LDAlUf5HpoyQ898fTXUylpbJ5HSGzS3+JlxlMXFH6IfGDLnWM5
 a22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782312872; x=1782917672;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hLBor9SSfwnE0xzMTqhApNDSzUC1PT3lW3joM8mFsTs=;
 b=UjJ3F7ULjPPEO8iM5ZJlznB16xFA0t1+NBjF2T70fNwCmNC/6NYMgMUbCqXOa/rYkd
 US10kacrBMGV01eeVg56YuYIDGeBLhrWMl10PR3a4v4AsKshUWmNAIuHI0QWrbnJdJyd
 A9uOzmTnkK3G8o2Nf46JkVjnHJ/YcCwleInarPS6kwUFcu3YZi0EBibH02hP5+2s6MpJ
 XuGh/+V9qHstqO+fJu8/W/tozgLsacjJf78zfjyhb+tJ5raIB+k+55FLzxKEDP7qFPYW
 rf9gqMQDSCgMGrh2VeKBi+bnFGMLzFF5JxnpJ/yfrfQIkwgqPCci/1skHq1agXcJ0aRX
 h4OA==
X-Gm-Message-State: AOJu0YyHsn/XF2apU/aNAmUQaRGHUxc9P0vNbx+rsF77RFAgQCUpLcpv
 6g3u9vK0mtXMw5U0DK+gjtt/OCiArpeB2MYvpmtLnkJvkayUyIMEuqU3JBO1Aa0Pcsw=
X-Gm-Gg: AfdE7ckxxzz1uQx7IX5Jhx8l6xHWXOIv+XhduKfmXYVOVwYoF7vd+bwZA4wccS9EF31
 SMxhiGIdhPCT5tGf48/iwUUwKnkWRdFzO9Lnro1ao98FVBuri2cMj68ABO/Xuqq7HlWPzRasLPF
 j/IOPBpVV3dLZ9rt6S9XWINMNwdGRAyL7vo0l0qKgt4aiFwV+Fq+wzmtkk9VvvPbEpOQ2cXLCb3
 mDcwFulRXhcrQm4PGN7r8SqU4qnan/DxQKGyO+4Tap4OQbLlVF8c/o8lyHhpY+FZgg9nJZEH9s0
 b2ndvu1/f96Y/qFHPTRMlGwwgslcOW747oLEYMP645VcHQCCZTUqAPU5rrONz+DUPry1yV15mCC
 npn3WE6OLTDyRUY7KOCAjbNlE6YBTttRPA3G/KEJttrH+OZbZ2bMm84a8FwU0RrGNQvoSNEtrkZ
 +9qOTsNc8ynuZu
X-Received: by 2002:a05:6000:2c12:b0:462:e086:35f with SMTP id
 ffacd0b85a97d-46adadd217amr13042846f8f.21.1782312872100; 
 Wed, 24 Jun 2026 07:54:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01d51sm6133429f8f.15.2026.06.24.07.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 07:54:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8002B5F80B;
 Wed, 24 Jun 2026 15:54:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-arm@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 04/27] tests/tcg: introduce meson.build
In-Reply-To: <20260609214745.772536-5-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 9 Jun 2026 14:47:22 -0700")
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-5-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 24 Jun 2026 15:54:30 +0100
Message-ID: <87v7b8j8ex.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Every target declare its tests, and add them in global tcg_tests
> dictionary, indexed by target name. See comment for full description.
>
> We make sure that if a user repeats a test several time it won't result
> in duplicated executables or tests. In next commits, we'll introduce
> what's needed to deal with that.
>
> A test is compiled from a single source file (and later, a single set of
> compile flags). We make sure dependencies are correctly handled by
> generating a depfile.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/meson.build     |  2 +-
>  tests/tcg/meson.build | 94 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 95 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/meson.build
>
> diff --git a/tests/meson.build b/tests/meson.build
> index 9ba04bbedd3..5877d2f60b1 100644
<snip>
> +
> +      # build executable if needed
> +      if exe_name not in built_tests
> +        exe =3D custom_target(exe_name,
> +                            input: file,
> +                            command: [cc, '@INPUT@',
> +                                      '-o', '@OUTPUT@', '-static',
> +                                      '-MMD', '-MF', '@DEPFILE@',
> +                                      '-Wall', '-Werror',
> +                                      '-O0', '-g', '-fno-strict-aliasing=
',
> +                                      ],
> +                            depfile: exe_name + '.d',
> +                            output: exe_name + '.test',
> +                            build_by_default: false)
> +        built_tests +=3D {exe_name: exe}
> +      endif

I noticed:

  ninja -v tests/tcg/aarch64-linux-user-sve-str.test
  [1/1] /usr/lib/ccache/aarch64-linux-gnu-gcc ../../tests/tcg/aarch64/sve-s=
tr.c -o tests/tcg/aarch64-linux-user-sve-str.test -static -MMD -MF tests/tc=
g/aarch64-linux-user-sve-str.d -Wall -Werror -O0 -g -fno-strict-aliasing -m=
arch=3Darmv8.1-a+sve -O1

and as the compiler parses the command line left to right it does the
right thing, but perhaps a comment here to point out additional flags
can be added.

Otherwise with your other fixes:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> +
> +      depends =3D []
> +
> +      exe =3D built_tests[exe_name]
> +      cmd =3D [qemu, exe]
> +
> +      # some tests expect QEMU env var to be set
> +      cmd =3D ['QEMU=3D' + qemu.full_path(), cmd]
> +
> +      test(test_name, env, args: cmd,
> +           depends: depends,
> +           suite: ['tcg', 'tcg-' + target])
> +      added_tests +=3D {test_name: true}
> +    endforeach
> +  endforeach
> +endforeach

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

