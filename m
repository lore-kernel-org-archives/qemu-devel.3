Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01146CD4857
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 15:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sls8f-0003JK-QJ; Wed, 04 Sep 2024 11:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sls8Z-0003IX-Gy
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 11:41:42 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sls8W-0000nC-CR
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 11:41:37 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so116835166b.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725464494; x=1726069294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95GG3NQ+TGBMcO386o2bnbs0ML8QWDbFOz90P5GVySs=;
 b=N07cYe6HmIEO5luS3Csls36dRwT/Eqa0L4uSd9VxdcGiiehta5zlTQhKMt51Zk3AvL
 IPWjgTu+pzmN4oeCcLJnIW6pw4n+MMUSecn00y8J4MEb5TIurLLYiTi2hmyBLBmtt1Ph
 baTNEaKmxXdCNR0GUg7HiVS/gOUNdVvlPEgHEzpJVKATteB1XEU+1K6rdmIN2edxT8Go
 bdpL/WuKwRGRNuPV3S6OZnpWLfGm7OjHKBBLrOioc6NCb+cWzJhc16EciCo667oLfYNw
 S9YXAZlagl5y4tk8hBm2+2WCDmIYdgtBQNZqRo9KoWvb3EVPJ0+FtLUTdE8PwoznFfd9
 4/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725464494; x=1726069294;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=95GG3NQ+TGBMcO386o2bnbs0ML8QWDbFOz90P5GVySs=;
 b=MymdfOW4VWiDTNxInmr1dahr6yQgrUi8E/XKEgfYdzEvTj3p4oysRaMf6rrHuiWbjJ
 hU3gK2O/mNd0RQ4PQHRpZNNB36Lb4qlaxgEYHpBrbezXe86MOT04BG3j+mdLSrsviPeT
 QAL0m+Vm7GwPdQwOt0hDCEzqFDwGYtMZWD4D0BiaXv+LP+XexYSJNCO7o4acbn/v/9nS
 Tp3vz04wJELJeWyJcjx1nkyBpjSF7TthMndjE0dmEp4e+Kuou3g+STimpciP18VFpsKS
 E5Aaz+rnUDM1sanlx6wXx8HDXram6JvH579D5aGzTB5NeBylt+MO3qcQEORG0A0F5UE6
 P3kg==
X-Gm-Message-State: AOJu0YzW39osRbuMj41KprVIxC8s18MULjXNQ2QcATQS6pyWBfW4AXdG
 pmp7Eq0bRcL71m1OigpDee+Ev1vfurTpzb1lBLv/bMZKctZFaUD/fAMxInKW0/Y=
X-Google-Smtp-Source: AGHT+IGW0nO4+BXiADd7/1TnNvLFccvz4rMbQGpkjnY46u0ApY5gZbGrI1QyC9ke+YabLLC9NDx24g==
X-Received: by 2002:a17:907:7e9c:b0:a7a:a06b:eecd with SMTP id
 a640c23a62f3a-a8a3f0ee73emr239387166b.5.1725464493556; 
 Wed, 04 Sep 2024 08:41:33 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a61fbb039sm7284366b.18.2024.09.04.08.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 08:41:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C03655FA1C;
 Wed,  4 Sep 2024 16:41:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Yanan
 Wang <wangyanan55@huawei.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Xingtao Yao
 <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v7 6/6] tests/tcg/multiarch: add test for plugin memory
 access
In-Reply-To: <20240724194708.1843704-7-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Wed, 24 Jul 2024 12:47:08 -0700")
References: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
 <20240724194708.1843704-7-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 04 Sep 2024 16:41:28 +0100
Message-ID: <87seuftoif.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Add an explicit test to check expected memory values are read/written.
> 8,16,32 load/store are tested for all arch.
> 64,128 load/store are tested for aarch64/x64.
> atomic operations (8,16,32,64) are tested for x64 only.
>
> By default, atomic accesses are non atomic if a single cpu is running,
> so we force creation of a second one by creating a new thread first.
>
> load/store helpers code path can't be triggered easily in user mode (no
> softmmu), so we can't test it here.
>
> Output of test-plugin-mem-access.c is the list of expected patterns in
> plugin output. By reading stdout, we can compare to plugins output and
> have a multiarch test.
>
> Can be run with:
> make -C build/tests/tcg/$ARCH-linux-user run-plugin-test-plugin-mem-acces=
s-with-libmem.so
>
> Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  tests/tcg/multiarch/test-plugin-mem-access.c  | 175 ++++++++++++++++++
>  tests/tcg/multiarch/Makefile.target           |   7 +
>  .../tcg/multiarch/check-plugin-mem-access.sh  |  30 +++
>  3 files changed, 212 insertions(+)
>  create mode 100644 tests/tcg/multiarch/test-plugin-mem-access.c
>  create mode 100755 tests/tcg/multiarch/check-plugin-mem-access.sh
>
> diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/mul=
tiarch/test-plugin-mem-access.c
> new file mode 100644
> index 00000000000..09d1fa22e35
<snip>
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Ma=
kefile.target
> index 5e3391ec9d2..d90cbd3e521 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -170,5 +170,12 @@ run-plugin-semiconsole-with-%:
>  TESTS +=3D semihosting semiconsole
>  endif
>

Also you need:

test-plugin-mem-access: CFLAGS+=3D-pthread
test-plugin-mem-access: LDFLAGS+=3D-pthread

So less tolerant gcc's include pthread (otherwise the alpha-linux-user
fails), with that fix I get:

   TEST    check plugin libmem.so output with test-plugin-mem-access
  ",store_u8,.*,8,store,0xf1" not found in test-plugin-mem-access-with-libm=
em.so.pout
  make[1]: *** [Makefile:181: run-plugin-test-plugin-mem-access-with-libmem=
.so] Error 1
  make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:56: run-tcg-te=
sts-alpha-linux-user] Error 2

> +# Test plugin memory access instrumentation
> +run-plugin-test-plugin-mem-access-with-libmem.so: \
> +	PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
> +run-plugin-test-plugin-mem-access-with-libmem.so: \
> +	CHECK_PLUGIN_OUTPUT_COMMAND=3D \
> +	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-mem-access.sh
> +
>  # Update TESTS
>  TESTS +=3D $(MULTIARCH_TESTS)
> diff --git a/tests/tcg/multiarch/check-plugin-mem-access.sh b/tests/tcg/m=
ultiarch/check-plugin-mem-access.sh
> new file mode 100755
> index 00000000000..909606943bb
> --- /dev/null
> +++ b/tests/tcg/multiarch/check-plugin-mem-access.sh
> @@ -0,0 +1,30 @@
> +#!/usr/bin/env bash
> +
> +set -euo pipefail
> +
> +die()
> +{
> +    echo "$@" 1>&2
> +    exit 1
> +}
> +
> +check()
> +{
> +    file=3D$1
> +    pattern=3D$2
> +    grep "$pattern" "$file" > /dev/null || die "\"$pattern\" not found i=
n $file"
> +}
> +
> +[ $# -eq 1 ] || die "usage: plugin_out_file"
> +
> +plugin_out=3D$1
> +
> +expected()
> +{
> +    ./test-plugin-mem-access ||
> +        die "running test-plugin-mem-access executable failed"
> +}
> +
> +expected | while read line; do
> +    check "$plugin_out" "$line"
> +done

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

