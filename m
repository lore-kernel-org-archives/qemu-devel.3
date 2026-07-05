Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED89C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEfl-0004qM-G9; Sun, 05 Jul 2026 00:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEfj-0004lW-6i
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:41:39 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEfh-0006a6-DP
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:41:38 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2c821a50615so14997225ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226496; x=1783831296; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5MUzXI8ouuPti3N1gFh2O6Ilebd1H5XSMn4/tL7E5JU=;
 b=lOy/6v6IMhAbB5cWEQilqdmZh2OhobSg9+z3Us/GZkH2MGYHYsuOMyjuqtSgXnGupG
 oMfcM/0dPRAu9lL5uXUFiM8exYFxq0GHp2tfcJEnCzBkCoLnUtMCnItnDOZwXukYWlAo
 eZA6xjNx3BXPJGDMQaPEopFyXzPdS8EMrZ+iSkDMCplOFk1nFMZsdYgfoNjHvZF4iHH7
 iY1H0GWCviYW++3D8jujfxXEfclRZV6t8txdJXGfFVg77xRst2/06O3Dhf/7KVkKJrrK
 FcOEQRYDKG2jcLhywtSnI0Zitkzkqm6P1BougBnIS7WMMVHJ+Avgdpesh8+f3v3Uwwss
 zSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226496; x=1783831296;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5MUzXI8ouuPti3N1gFh2O6Ilebd1H5XSMn4/tL7E5JU=;
 b=Vj6RLuHi3kvgCF/7q5qunSo76YHbrytpHOcIOwsG+w7hGE+lpGyKDUDqh9FZEZshu5
 lmzbz/DTUlDn3/YRwDArIyf6b1anCQ2MV2lpUTxaiQMEdfpBGSieUl86KbPeQkZyI2t7
 FxDqossh2rvZCjzK2134QUSU4edOvokXn5Sy3FMk6yO0xtRQ1Ze7NnElhOz02AMO9/17
 bKn2S+qluQGIsPEmoF1A+ec8EHool2gNv2qdV6OMpvv55ge7xR5cMguH4Gc3u+kJdiZV
 NRAglxW8wBWYluEuonN+vUb6qOcbeh55JHK3MHwtwKs9gDq9dujTwZ4Arzh0kwQAIZou
 eoaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrY4zBoltRFfKqz1r1ft01Br5g1P8+JPbIuHGLMwKuLaxDkzwW5+tjy4Ny991HbaGChsYR5EMJYOjTP@nongnu.org
X-Gm-Message-State: AOJu0YyHDRhvZrlDKjstFOaqzkHgQajHND8i8dLafw7wcBqq9OWIaS1B
 vsb3AYcq4CagHpOuI5k92q6J6Y7QN8sa7UgkFPnOGhAafEfanRqwC4CUIzd4PcrHQsxSQ/I5Pkn
 9ETnj
X-Gm-Gg: AfdE7cnUAEkB+G+rK8xibkou4tonv9KmdBOQSrFdG5HcRLUAvcqQTvFc9zhxUtAb4Dl
 MASAestGQGDEw6XCzoV213iLOKszX2aluTDzmx7qCSeEfd+LeTz+p0YBxzExrdUZD1YU9xfgl1f
 ctPaRkSmtEb+JIz7S4wQ/SaL59nweY/9ntZVcFIhHWx5kGFpVXUjA6NFyi2KxNB1lEhbVbuVEqW
 ZMtfGydudo16u0mLoTqkbUxJMs/gocTBQavWnQXAacC8D6fcti1jtkhHLZNrKJR0J5FS0hrQJiw
 dwHtIYtviDpAz41sYbOBBwykIfQEU3vAVAdGzMPeOxYyP97SzHbJySdtSX6+Xd1/nm/pb5j5pkJ
 SR8zGUT/jXZfk2Mb7Ukl3miyzycVo5Ia74CL+x7bbtre92/lj3fC+zBSxGha2ge99xL2k4nivx/
 jVt1i8yVJwxkVx5MPUkOU7pCZcRVmqN8Dd2sJ9+nANIwOyJafyhyEKZzg=
X-Received: by 2002:a17:902:ce83:b0:2c9:97a8:aff3 with SMTP id
 d9443c01a7336-2cbb9f28153mr47141065ad.44.1783226496046; 
 Sat, 04 Jul 2026 21:41:36 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad7894b06sm29853855ad.77.2026.07.04.21.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2026 21:41:35 -0700 (PDT)
Message-ID: <f5df268a-cc86-4a8a-aa5b-91c005244a2a@linaro.org>
Date: Sat, 4 Jul 2026 21:41:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: docker-image-debian-all-test-cross errors
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <4b08f4e2-2274-409a-86d8-469c73e21579@linaro.org>
 <7e3536cd-8f02-420c-a85d-3cc027fcd660@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <7e3536cd-8f02-420c-a85d-3cc027fcd660@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 7/4/26 14:41, Mark Cave-Ayland wrote:
> On 04/07/2026 22:20, Richard Henderson wrote:
> 
>> Has anyone else been seeing
>>
>> Error: Failed to fetch http://deb.debian.org/debian/pool/main/d/dpkg/libdpkg- 
>> perl_1.22.21_all.deb  404  Not Found [IP: 151.101.22.132 80]
>> Error: Failed to fetch http://deb.debian.org/debian/pool/main/d/dpkg/dpkg- 
>> dev_1.22.21_all.deb  404  Not Found [IP: 151.101.22.132 80]
>> Error: Failed to fetch http://deb.debian.org/debian/pool/main/p/python3.13/ 
>> libpython3.13_3.13.5-2_amd64.deb  404 Not Found [IP: 151.101.22.132 80]
>> Error: Failed to fetch http://deb.debian.org/debian/pool/main/g/glibc/libc6- 
>> i386_2.41-12_amd64.deb  404  Not Found [IP: 151.101.22.132 80]
>> Error: Unable to fetch some archives, maybe run apt-get update or try with --fix- missing?
>> Error: building at STEP "RUN DEBIAN_FRONTEND=noninteractive eatmydata   apt install - y 
>> --no-install-recommends   clang  dpkg-dev  gdb-multiarch  libclang-rt-dev": while 
>> running runtime: exit status 100
>> make: *** [/home/rth/qemu/src/tests/docker/Makefile.include:43: docker-image-debian- 
>> all-test-cross] Error 100
>>
>> This has been consistently failing for me for a couple of weeks...
>>
>> r~
> 
> I wonder if docker build has cached the existing layers, and since apt-get update only 
> runs in the first part of the Dockerfile then the subsequent layers try to access an old 
> base image?
> 
> Does running "docker builder prune" (possibly with --all) help at all? That should purge 
> the cache and force docker to rebuild all the layers again.

No, it doesn't.


r~

