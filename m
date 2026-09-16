Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B3CC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6meG-0007r0-5h; Wed, 16 Sep 2026 06:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6meC-0007qm-Bj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:13:48 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6meA-0006aa-4E
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:13:47 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea48edcso563960a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 03:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789553625; x=1790158425; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y2y0r3csQobljLetqX8eKWSFh1bXU3rUJlSrAQH4Eeo=;
 b=k0IX5CGoyhIFz7VjPoeW1UZOTtC3CfTUgaiQviGAOBUSVtjdv9Igkw1JV+snA08sOs
 5T6wjwqWhkfWfnhOXtBkO4jBd/PLAatjJmqqwN2CD+waTrY9667y/OBSfyWkvTHJSoFV
 GbI4uuVPIpANtzWB/ilj9CQa802CwyGdE5ifAY5NBTKyy+gWaUMJIq4X+pDoQT9Iftl/
 93xTWTtctwlMZRyUG6ZwslIij+2wsK8b9ci7Y1Gq5TKDuPQm8b/Be1dfsrI0+lwAxKUC
 A38eRTI7BNRmsrmBidh5zJstkwJpKegmomiHfB5/fKaxxm3BQlRa0nmxqTOASTj1DeRw
 8LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789553625; x=1790158425;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y2y0r3csQobljLetqX8eKWSFh1bXU3rUJlSrAQH4Eeo=;
 b=Qgh59BJJfcgM5xqnjVUMzF8v8ISQQp8k1G4eY3sXHA6F6kn2zvYd+rMN6hsxC3u7iZ
 8DzCiSED/jJxVMpx6x0cWXzlXg3gh8ADYG2KA3v7qg/q1mKofOjlhJLbUPAgkg+moXOU
 lOqCgwhkezSWB3rBMyu4RUGBdvlCrvgXwy6ePI3N8uR37r1vqRJfIBpzWY9LXTjyGjbq
 +vC/IS5+72hDcn8S7PxS5jebe8Iulqk9GjL/m7uB+lGqr+rrEGUF0jFHEeaXsN32FI7A
 eV80NsBMECtbixSkVQHdd+n2TqVwVlhQy0LpQIRuJ/uRBiIY+wcg53P/Nk0aoe/DLu0V
 wcXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmrPVxTgTqXtpZxs623WhbEX+CPekeVKLhQh6yzrbunhuHqzGGdQ58p4alnAB/JHLDqsSQ1//nvONC@nongnu.org
X-Gm-Message-State: AFuF++kC78tLOgTC7BJn9J1X5OkwOZ1yxk8jOKGpqYwz33qqAQtqYoqv
 LzjKatSpjWAB6w/hnR941goKNO0gkGEKBDc2DgrML3ETcZMTVvbn2GkEwYFA8XuhycOtMl4N7sT
 Yv7QETF8=
X-Gm-Gg: AYBFou2xU+HID6E3cum3ZV1VJ5felHEDSJBdqzOWrn2v6ydRQCLurc7n6Aa6f4zgKqd
 jhGj03GqfTdx0HzTUpdI7yCRaqETG7RgMKaVWoAvC0dP0uDvHEckYopNYRAbx0KXsayhVyA+OyM
 92dQ5CBbisnFQ2O1cfEnmhWtFLAMDDUiqtyTIRbyFKzhsA8fcHm/a46TieFJ5uenKv5uXNOzLYM
 lkFWkM4GbpZK9dgrT/Bnc1hKlUhK6sdz+PyeKD5GpWL6AAfIs2jITcLDtESmfXjHR11Qi/FT8kp
 RJHY8j8rGAHFzvTqfCIr5OInFP5aixaGnCy37l/D7HE0wYG0TeN+wEpa7Wv8A/KOCdGWwOE19+i
 fkefABXbYxjs6gW/3EuGoMd/Nad7m4lIfB7euKb7BPXft4N9JVcIiMYT9G9oX43TnIfNChZIjEr
 hL85+rFRVORH5aTj5KGaLPWyQ5baEW/yS5irA2c+f4rTI9RNjFbwUCdggwGAYZaD4B/4RZ6w0Cq
 6KYDxzs6vUp65rmjLkh0zAbVzk3nAd8k/g0PsqwwqVKiMY1RIEDu7K/295LGw==
X-Received: by 2002:a05:6a21:1193:b0:3da:ebec:69c1 with SMTP id
 adf61e73a8af0-3dd5f7acb7amr5205327637.24.1789553624548; 
 Wed, 16 Sep 2026 03:13:44 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:845c:f507:397b:9b72?
 ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm5811581c88.7.2026.09.16.03.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 03:13:44 -0700 (PDT)
Message-ID: <78b25d1a-5b32-4327-8bb0-5c863293f014@linaro.org>
Date: Wed, 16 Sep 2026 00:13:41 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] testing: various docker clean-ups post meson tcg
 conversion
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260915201601.1207839-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260915201601.1207839-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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

On 9/15/26 10:15, Alex Bennée wrote:
> This cleans up a few bits and pieces although doesn't totally solve
> the issue of an apparent stall while meson builds the docker image.
> However with these changes there should be no difference between the
> meson build and the equivalent "make docker-image-foo" invocation.
> 
> We also finally get rid of the ill-advised magic caching support in
> docker.py.
> 
> v2
> 
> I've restored the configure based compiler checks for so we can build
> roms and the vdso blobs again. It looks like we could never build roms
> with container based images so I've left it for now. Unlike the vdso
> build we can't trigger a container build through Makefile.prereqs.
> 
> TODO
> ----
> 
> I've still got Ilya's s390 test image patches to look at but I'm
> sending v2 because enough people are hitting issues.
> 
> I've got a very hacky patch which fishes the docker image names out of
> the custom commands and exposes them via Makefile.mtest which will
> trigger the containers to be built outside of meson although meson
> will still attempt to build (and find everything cached).
> 
> I also need to look at the timestamp stuff that Pierrick has suggested
> to see if that improves the caching from the registry.
> 
> Please test and review.

Normal configure allowing podman seems to work:

>   TCG tests
>     gdb                             : /usr/bin/gdb
>     container registry              : registry.gitlab.com/qemu-project/qemu
>     cc for aarch64-softmmu          : aarch64-linux-gnu-gcc
>     cc for aarch64-linux-user       : aarch64-linux-gnu-gcc
>     cc for aarch64_be-linux-user    : aarch64-linux-gnu-gcc
>     cc for alpha-softmmu            : alpha-linux-gnu-gcc (from 'qemu/debian-all-test-cross' container)
>     cc for alpha-linux-user         : alpha-linux-gnu-gcc (from 'qemu/debian-all-test-cross' container)
>     cc for arm-softmmu              : arm-linux-gnueabihf-gcc
>     cc for arm-linux-user           : arm-linux-gnueabihf-gcc
>     cc for hexagon-linux-user       : hexagon-unknown-linux-musl-clang (from 'qemu/debian-hexagon-cross' container)
>     cc for hppa-linux-user          : hppa-linux-gnu-gcc (from 'qemu/debian-all-test-cross' container)
>     cc for i386-softmmu             : i686-linux-gnu-gcc
>     cc for i386-linux-user          : i686-linux-gnu-gcc
>     cc for loongarch64-softmmu      : loongarch64-unknown-linux-gnu-gcc (from 'qemu/debian-loongarch-cross' container)
>     cc for loongarch64-linux-user   : loongarch64-unknown-linux-gnu-gcc (from 'qemu/debian-loongarch-cross' container)
>     cc for m68k-linux-user          : m68k-linux-gnu-gcc (from 'qemu/debian-all-test-cross' container)
>     cc for mips-linux-user          : mips-linux-gnu-gcc (from 'qemu/debian-all-test-cross' container)
>     cc for mips64-linux-user        : mips64-linux-gnuabi64-gcc (from 'qemu/debian-all-test-cross' container)
>     cc for mips64el-linux-user      : mips64el-linux-gnuabi64-gcc (from 'qemu/debian-all-test-cross' container)
>     cc for or1k-linux-user          : or1k-none-linux-musl-gcc (from 'qemu/debian-all-test-cross' container)
>     cc for ppc64-linux-user         : powerpc64-linux-gnu-gcc (from 'qemu/debian-all-test-cross' container)
>     cc for ppc64le-linux-user       : powerpc64le-linux-gnu-gcc
>     cc for riscv64-softmmu          : riscv64-linux-gnu-gcc
>     cc for riscv64-linux-user       : riscv64-linux-gnu-gcc
>     cc for s390x-softmmu            : s390x-linux-gnu-gcc
>     cc for s390x-linux-user         : s390x-linux-gnu-gcc
>     cc for sh4-linux-user           : sh4-linux-gnu-gcc (from 'qemu/debian-all-test-cross' container)
>     cc for tricore-softmmu          : tricore-gcc (from 'qemu/debian-tricore-cross' container)
>     cc for x86_64-softmmu           : x86_64-linux-gnu-gcc
>     cc for x86_64-linux-user        : x86_64-linux-gnu-gcc
>     cc for xtensa-softmmu           : xtensa-dc232b-elf-gcc (from 'qemu/debian-xtensa-cross' container)
>     cc for xtensaeb-softmmu         : xtensa-test_kc705_be-elf-gcc (from 'qemu/debian-xtensa-cross' container)

However --disable-containers yields the exact same output ("from ... 
container" and all).  Confirmed by "make check-tcg" attempting to 
rebuild said containers.  So that's not working at all.


r~

