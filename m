Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DBCFEFB56
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzOz-0006Lt-PV; Fri, 27 Feb 2026 10:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvzOw-0006KP-53
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:05:10 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvzOu-0003j3-Cq
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:05:09 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64ad9238d8fso2029383d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 07:05:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772204706; cv=none;
 d=google.com; s=arc-20240605;
 b=LerV/sp6diSbw4Ya7lFDCaX/XPXUVFPVZrPMiHELSRP3P+Zg15pa2R9Vp4gRVz97fj
 DlmND3I2j2W48WVbnDjlox0KtLXXFXsc+vOCATkZYQ+WLbDpRO6qjz4vnXLvnx6KRM6+
 3fyVH/nwlAjuwFo9qXsWIv9KkMalicdXFHJmJHKyD160bbdG6b/cvG0+3Bolq87cP+4y
 JSmff5GrHF91TCcNmUw9MSBw+6vz5Fk3OxzrZCdU6C6QMYuceEj+/IRUocIRn/B7aHj9
 wRVH43R9s2O7xTNyHgamwJHIcQIvVrp88WsrM7gAMxcl3K8EjgMJ9tXObrkkCQbVUEXj
 BkTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bQYyYl6AGFnau/0Z1LKVfDyYADIMLrkJIezRGu7W9DI=;
 fh=vSsjX+suop0RzrtKfDefoX/buIVLz4A+cyTU+k7ek34=;
 b=d0TzqHFU5IObpFv5MqnNIMvR5M7RkvQn239in0B2jZeB9g6RAAEb6n5gVLovFMvrCA
 QQDjWpGxKt/2/lWSzYS2xqSBZkkRbf3Sw/CcDDh5jNgxCc6+qpVTfPqhLd0cUpl4Eidq
 gPHiTot8MxbL9tUzApD1KMlOdSFG0GmeKN+1XX6MDDK2Ps8BY+s2LSuWdnaFZa68HJuo
 OnHy4kzXKIrvOqdn7aLViz1nioxMx5s82zUHXtP3fPcxReOO5gPFrSI9JVx+LY95bDLb
 zCXIrchcErpuRpvS/RUVxTL7rK1D0CozqVNdzQSwW3Mw+dY/+ccRLY7XOtZ4h0Tm63K7
 NTQg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772204706; x=1772809506; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bQYyYl6AGFnau/0Z1LKVfDyYADIMLrkJIezRGu7W9DI=;
 b=WufVHUymL0X7QWiKYpV7mf7uDiz/NPkA+3CFs3uLBFr2s/Y67yxAPT2iHDi4CztUaj
 JcAgCmtWJAm9OaV/6IvxHwKhe8zcDEcVkQ0rLd/RvEhenQNHbX2G7K8NlyFw+GwXdJHd
 3nyFBVWjqApe9NMO/BIMDwW2Xcy+rz1LAG++WR8q2xmwIvXLP/YJfnIJxYZaAHYJuH1q
 DtSJSUNBezWRkJdrlfZ1HtDlK+a8dCMB9kGKTEGI3WZvuVJOBsFk5ls9HspydAraP1XS
 G3dgHiyfaZpIMj6zccx1arXwcW4mQPjaPBwg+WSYv2nIJ3L2/dQCzkDjvxB6l2Y4JdxY
 MZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772204706; x=1772809506;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQYyYl6AGFnau/0Z1LKVfDyYADIMLrkJIezRGu7W9DI=;
 b=TzNIk0AQNNsBwd7XPKckrAr8ZfztGh7MQlrxAGDEHF/tqCUSj+Yvjg4z7a8NhmRVo1
 nW1j0VU7IykSBWiffnv7jtht7PRUJvEGvS3yKMsONEyWjjVBMIssmbl658umRrXDEt0R
 cvuh6O5hxeBUQYV8EWyYg+Yj+FPMFPVMtYj0fB1Sy7ZEQ5W1Lud4Mswu6srRupDUmccR
 LgVr43hwmcJRbexED3pwlZSVaO3VmlQ8rwvtnVzWHQH3Z+N2NnRkajBNDVKjPBfpmKEL
 8szvi4vtX6eyZi75hHDRduIaUVvnlpyZdQAdLThnElajRiXx7CvgioqBP8uVDlV7lF07
 5zqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiyxDbFYH4YFTWQf6/nRzPf2Bh4YuF4Xw8aphAQ+MTDW7qFa26ESdFkZxMAv7w+ppxcJIw4kS4+bmP@nongnu.org
X-Gm-Message-State: AOJu0Yy4/JeycJ+kR97Vz+H4Mfhvplf+3GqzdTiZoLVGVXWqV1fYQLQ1
 28Z+nTZ7JwzwHqJpAbSiqkXNSRajZ0+G8kNGSZJW6470JCujy5I/oHDxgzuFPkUZJnRHUNUKn3/
 9j00MgLWL5Ns6Fe0hnY8X36Vrapwn//EgJacZBWT9mQ==
X-Gm-Gg: ATEYQzxgLTUGPdZHOyMaqssTsj3u4vlR+dvvuyDf6mTBRDS/7e7A3nU6yGQWdwZeLyF
 HK0HlIG7o/iUHsTCI6uJJPDVDqCJjSqwpbiURyAfqu8e2Q3njXepYmiSbwfGglRFLOrlSG8h96f
 JE89LDIv9c5t4lc1M5dEWydCutR2MgFy/O5P2xSq4uo6eHRkxs63IZ8eFtcXVVesSi+nYEIBLGk
 LGr2sMwupVelRraEBa2yyv4ttbp1cItb8q0eXW5Mjx+aaXHoObupoZDBMpCsPAeXIoHO3PQYUcF
 MYudWVft3nBsJX/MQw0nWaOJpZFgCT8yK6dsA6ChJ7zkGtgp/WsxNAUy6WHw2gbszps=
X-Received: by 2002:a05:690e:44a5:b0:64c:a894:f723 with SMTP id
 956f58d0204a3-64cc1f2704emr2043353d50.0.1772204706420; Fri, 27 Feb 2026
 07:05:06 -0800 (PST)
MIME-Version: 1.0
References: <20260227135736.2280161-1-peter.maydell@linaro.org>
 <20260227135736.2280161-2-peter.maydell@linaro.org>
In-Reply-To: <20260227135736.2280161-2-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Feb 2026 15:04:53 +0000
X-Gm-Features: AaiRm521CMDjXfjtvXpLaKxDxfrq5PyN4OGz451qxRCQIRIESTccqQ-z6s0XMk0
Message-ID: <CAFEAcA853KSRD7yJKjyoM-E2R4YNou=x+BCR9EWrjym==-tQjA@mail.gmail.com>
Subject: Re: [PATCH 1/4] scripts: Move lsan_suppressions.txt out of oss-fuzz
 subdir
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

I forgot to cc the 'device fuzzing' maintainers on this patch;
sorry about that.

-- PMM

On Fri, 27 Feb 2026 at 13:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The oss-fuzz code uses an lsan_suppressions file to suppress certain
> leak-sanitizer cases that are known issues or not our code's bug.
> This is useful more widely than just for the fuzzer harness: if you
> want to build QEMU with the leak sanitizer enabled and run 'make
> check' then you will want to suppress some bogus leak reports.
>
> Move the file up a directory, and add the usual SPDX identifier
> and a comment describing how to use it.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  .gitlab-ci.d/buildtest.yml             |  2 +-
>  scripts/lsan_suppressions.txt          | 11 +++++++++++
>  scripts/oss-fuzz/lsan_suppressions.txt |  5 -----
>  3 files changed, 12 insertions(+), 6 deletions(-)
>  create mode 100644 scripts/lsan_suppressions.txt
>  delete mode 100644 scripts/oss-fuzz/lsan_suppressions.txt
>
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 1b656b9eb0..7548057c54 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -626,7 +626,7 @@ build-oss-fuzz:
>      IMAGE: fedora
>    script:
>      - mkdir build-oss-fuzz
> -    - export LSAN_OPTIONS=suppressions=scripts/oss-fuzz/lsan_suppressions.txt
> +    - export LSAN_OPTIONS=suppressions=scripts/lsan_suppressions.txt
>      - CC="clang" CXX="clang++" CFLAGS="-fsanitize=address"
>        ./scripts/oss-fuzz/build.sh
>      - export ASAN_OPTIONS="fast_unwind_on_malloc=0"
> diff --git a/scripts/lsan_suppressions.txt b/scripts/lsan_suppressions.txt
> new file mode 100644
> index 0000000000..ffade3ba5a
> --- /dev/null
> +++ b/scripts/lsan_suppressions.txt
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# This is a set of suppressions for LeakSanitizer; you can use it by setting
> +#   LSAN_OPTIONS="suppressions=/path/to/scripts/lsan_suppressions.txt"
> +# when running a QEMU built with the leak-sanitizer.
> +
> +# The tcmalloc on Fedora37 confuses things
> +leak:/lib64/libtcmalloc_minimal.so.4
> +
> +# libxkbcommon also leaks in qemu-keymap
> +leak:/lib64/libxkbcommon.so.0
> diff --git a/scripts/oss-fuzz/lsan_suppressions.txt b/scripts/oss-fuzz/lsan_suppressions.txt
> deleted file mode 100644
> index 7d90c280d0..0000000000
> --- a/scripts/oss-fuzz/lsan_suppressions.txt
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -# The tcmalloc on Fedora37 confuses things
> -leak:/lib64/libtcmalloc_minimal.so.4
> -
> -# libxkbcommon also leaks in qemu-keymap
> -leak:/lib64/libxkbcommon.so.0
> --
> 2.43.0

