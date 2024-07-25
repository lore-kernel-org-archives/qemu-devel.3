Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C34C3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 20:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX5E6-0007oP-45; Thu, 25 Jul 2024 16:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sX5E1-0007nE-Vf
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 16:38:11 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sX5Dz-0007By-G3
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 16:38:08 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52ed9b802ceso744231e87.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721939884; x=1722544684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UDA4aNvCbOcWcHi3TPHsEK0NFZnIwwCRHfrTCuZRxZM=;
 b=Cx47lsXcaEJgAyPcAXXqPZE856jHPmM/NP4KB5JVuRdzQzk89GueOXnnOukZz0hPB3
 uvkZetBeOJ1K0JmHsZxMsBhc2Xpx1RCsFMXNargsbMCHWyxopoOeCGBdFPtWGU8RHp6K
 fhTqs6H3KzE9ChXA46IyfwalNeDpcnrklaSb2s7n7gFOLbm3txLiF2V7W2u/JDTlq6kh
 Q2038pK5ie3Q7x8g6mIFTKdEiXEZEbx3ZhHAUQqS5/MdJjAgfOGvGfefp/yrJycM3JSN
 rTd2AIWBc7KVgAzvvueHhs4RuWSMtYCZHa4G4KHPkFnf149BUm4nfYYRET/I/HP4/ei9
 Nwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721939884; x=1722544684;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDA4aNvCbOcWcHi3TPHsEK0NFZnIwwCRHfrTCuZRxZM=;
 b=lMGCY1I9XYYZvtH1NEeHyOaHy7HhTP7oBc2+dAcrw54i8Ec9G9s+pE4gFuCzVKaVr1
 1/Sgfg+heNm8J70fdZ9C4Uxldz/AV/i3PHd7mX9oBRLCCLY2fB4z4kqADcGCOVbTOWxM
 Tt9yqshspv6wjSEFQnhCMpIceUpOFBuneM9QRu8K+japBs7szk8Z7BrK+BXOf4FfQj7g
 ubFXMCBEgdik3x241e2ahoLS/gjg94hkgkuiu1na34ANmT11WhU8BX1n+L9pLNadXzAW
 Jv4nVQEEwb3DWcTXO3y0d6VPSKoW4VW4GjlsZ5y4jVYTgzEs2gU/fSRuKX4r2TZRbDfU
 ILGA==
X-Gm-Message-State: AOJu0YwZpLfjcMvVOmJXyQZRthhj++OGZFb3NFILboiCrpdBfdgoAu3T
 XLc+sN1Cxq9n5oquHAH5I5zkoHMfS3iEwlC0shlzlRQOGXScdWIGgTo7t5Mqt1s=
X-Google-Smtp-Source: AGHT+IFo20+H8mdeDIRsbyOey5oyOcejAgXTYpiPKNkvMqzrcAHlRqdtIXkjKSYXNYjQj78EQgRbgQ==
X-Received: by 2002:a05:6512:1193:b0:52c:e133:7b2e with SMTP id
 2adb3069b0e04-52fd60407ecmr2294327e87.35.1721939883575; 
 Thu, 25 Jul 2024 13:38:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad91eeesm106310366b.178.2024.07.25.13.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:38:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 672FD5F863;
 Thu, 25 Jul 2024 21:38:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,
 richard.henderson@linaro.org,  peter.maydell@linaro.org
Subject: Re: [PATCH 3/4] tests/guest-debug: Support passing arguments to the
 GDB test script
In-Reply-To: <20240722160709.1677430-4-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Mon, 22 Jul 2024 16:07:08 +0000")
References: <20240722160709.1677430-1-gustavo.romero@linaro.org>
 <20240722160709.1677430-4-gustavo.romero@linaro.org>
Date: Thu, 25 Jul 2024 21:38:01 +0100
Message-ID: <87jzh9mcly.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12a.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> This commit adds a new option to run-test.py, --test-args, which can
> be used to pass arguments to the GDB test script specified by the --test
> option. The arguments passed are in the key=3Dvalue form, and multiple
> pairs can be passed, separated by a space. For example:
>
> run-test.py [...] --test <GDB_TEST_SCRIPT> --test-args v0=3D"string" v1=
=3D10
>
> The 'v0' and 'v1' variables will then be available in the GDB test
> script, like this:
>
> print(v0)
> print(v1)
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  tests/guest-debug/run-test.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
> index 368ff8a890..63b55fb8bd 100755
> --- a/tests/guest-debug/run-test.py
> +++ b/tests/guest-debug/run-test.py
> @@ -27,6 +27,7 @@ def get_args():
>      parser.add_argument("--binary", help=3D"Binary to debug",
>                          required=3DTrue)
>      parser.add_argument("--test", help=3D"GDB test script")
> +    parser.add_argument("--test-args", help=3D"Arguments to GDB test scr=
ipt")
>      parser.add_argument("--gdb", help=3D"The gdb binary to use",
>                          default=3DNone)
>      parser.add_argument("--gdb-args", help=3D"Additional gdb
> arguments")

I might be easier to do:

    parser.add_argument('test_args', nargs=3D'*',
                        help=3D"Additional args for test. "
                        "You should precede with -- "
                        "to avoid confusion with flags for runner script")


> @@ -91,6 +92,9 @@ def log(output, msg):
>      gdb_cmd +=3D " -ex 'target remote %s'" % (socket_name)
>      # finally the test script itself
>      if args.test:
> +        if args.test_args:
> +            test_args =3D args.test_args.replace(" ",";")
> +            gdb_cmd +=3D f" -ex 'py {test_args}'"
>          gdb_cmd +=3D " -x %s" % (args.test)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

