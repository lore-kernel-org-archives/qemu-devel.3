Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544ADC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5LLv-0001v9-Qy; Sat, 12 Sep 2026 06:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5LLu-0001ut-QM
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:52:58 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5LLt-00047u-AO
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:52:58 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-8625b35e11eso348511b3a.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789210375; x=1789815175; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SIjR+qWW/bcbGiCOAf+oq5jma7o18Z7P6rym8C9015Q=;
 b=NWpbECIQY+vFCBBX9hCh8wd8L94dfRb1cTJIYPLmb8SXj9BkeBNGrMQAp6rQ4E/ZkU
 lJJgMnqpxgnJncM9ers+Xr5Dg6/0/EwhZdJxBVeZNxwbjOrbZElZ1oknKw900vZ4mcQr
 ZP3H780IXp1ulEG0aUVqEK2nEDGUL1f+SxENVbgLHEKFTg3GoGjDt8C+GXH3LxgpyCNH
 dBzqQUYRBKUMa74bgHHkEBzQf7XIkPiywUDlwp1bVGP960oGI1LOr7qY7GXsQ+88JwQx
 7MIhBT/JtxzP5ZXlpVFwQ1XulpmK1xWiXi8X4DZhvzOuzQ0NTWMVRDmnPssZrPtTVfaV
 K+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789210375; x=1789815175;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SIjR+qWW/bcbGiCOAf+oq5jma7o18Z7P6rym8C9015Q=;
 b=H8sKwYsxVieg62AEBc4bTZNa1pVL0XuykEX68co+oiRXrGklvUlDJwBrjb5fg1eISo
 XaTUMXwPUKsuXAxxa5siiVtRvPIAer8BC1Pa2rwHkQaapyUfnMyEHSdInorVcuE6rSfp
 guSUHqsl7OtPGs6So10YZLTbHWn6GL2MuwfTLf6FTiCCSFdof1zpUpDf6r781+38UM9r
 KmzlnuX86xiQCHVpDtFspgwe+2UzZtTfaE2ZjXRxvTxwKN56TeeHAYPQoEk2wK7d1s28
 1Wgk2y30YuvhrzLMvsiKWgxjrSWzhpEbBtDARACI6uSYEZatm08iIWbcypLFiIY/mfob
 ZdeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBpA0o2vsXPdGiZRjE/gP4AFIquTXKFE1tV+brvZuKa63oXLnx+SNUmjSZeG1DjpNWhkSTEDch6bTb@nongnu.org
X-Gm-Message-State: AFuF++lC3WdkWnujK+Njgb94y2HDSTpMZW1EAjm8gigXUVCMeL1dNBIQ
 NNkM9NGrYojmtLYdiuyxAuUV6VIqDmL5oAtmbcu2RFdQVRNpMxsoVdMhnOtccCFnzhM=
X-Gm-Gg: AYBFou0yHMysUWeif7IkGYIEzX7IVgIxLoWE0PGo5XN7oPDMCmefSJ9WEzEeF3e4MkE
 m/b7qvZA297fATxxYliJPBl3CNwzB+iaCIbDk9rlPPGOml5kJPQ/9Tbk/iAqpYfakcWsYQGW5mi
 9mvh4OhFMYYXBI4k+gyaEQerxJflUEJ7OiR48EfC9FpBqjX2CIjGafaBeWKsB9xGwLxZWiXuOcs
 EYnH/DOZLziY6Y6AHKcROB7jzROe85DiGxGMhhHYTemzCYNPDcINQBAhTEhFp1+0pulHWmY8qur
 c+J6Qsp5JR4IuTUUywWcBvrkSGmMUnw5M+tr5Xj/IOQFWO8pbhXPjRglV+/39jqZo8zyr3bgGlt
 U1MHvZhvMGqW2yLVxP6O6CGhUnhSfMBtnvASCvFFjdsbf8wFx+yJglolu47FGGZmcCsU+pRvC0j
 1yv2qlwcEx24sqYXNr6m3I4DqehSB1skF12QZduKngmDgLpXBzG/Est4DUkWgVt9/53vAWvY9Qa
 7MvD5ggP0A2ROH/gVTIAuIEN0E5x0UnJwxCNJtcqy8IP/Iy1QcEVePD2UOBsw==
X-Received: by 2002:a05:6a21:b93:b0:3d3:ae40:51e7 with SMTP id
 adf61e73a8af0-3db0e5af225mr4380490637.27.1789210375449; 
 Sat, 12 Sep 2026 03:52:55 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:bf2d:a6f5:e308:cd27?
 ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8f1f7sm11393471c88.11.2026.09.12.03.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 03:52:55 -0700 (PDT)
Message-ID: <bd5b1565-2bbc-4f8d-9124-7b2a0edcfb20@linaro.org>
Date: Sat, 12 Sep 2026 00:52:51 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] testing: various docker clean-ups post meson tcg
 conversion
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Cleber Rosa <crosa@redhat.com>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910181504.1010916-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/10/26 08:14, Alex Bennée wrote:
> This cleans up a few bits and pieces although doesn't totally solve
> the issue of an apparent stall while meson builds the docker image.
> However with these changes there should be no difference between the
> meson build and the equivalent "make docker-image-foo" invocation.
> 
> We also finally get rid of the ill-advised magic caching support in
> docker.py.
> 
> Please review.
> 
> Alex.
> 
> Alex Bennée (8):
>    scripts/meson-buildoptions.sh: update missing options
>    tests/tcg: prefix meson built docker tags with qemu/
>    tests/tcg: use --add-current-user when building containers
>    tests/docker: add container registry to configure and use
>    tests/docker: remove used _read_qemu_dockerfile
>    tests/docker: strip remaining caching logic from docker.py
>    tests/docker: add specific command to parser
>    tests/docker: swap --quiet for --verbose

Something in here breaks things badly:

$ make
/home/rth/qemu/bld/pyvenv/bin/meson introspect --buildoptions 
/home/rth/qemu/src/meson.build | /home/rth/qemu/bld/pyvenv/bin/python3 -B \
   scripts/meson-buildoptions.py > 
/home/rth/qemu/src/scripts/meson-buildoptions.sh.tmp && mv 
/home/rth/qemu/src/scripts/meson-buildoptions.sh.tmp 
/home/rth/qemu/src/scripts/meson-buildoptions.sh
Failure in scripts/meson-buildoptions.py parsing stdin as json

../src/meson.build:96:12: ERROR: Unknown compiler(s): [['rustc']]
The following exception(s) were encountered:
Running `rustc --version` gave "[Errno 2] No such file or directory: 
'rustc'"

make: *** [Makefile:134: 
/home/rth/qemu/src/scripts/meson-buildoptions.sh] Error 1


r~

