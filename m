Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A56C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizlf-0007rZ-Hp; Mon, 04 Aug 2025 14:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uiyFA-0007NK-PS
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:41:04 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uiyF8-0005VJ-LH
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:41:00 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76bd7676e60so2486902b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 09:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754325657; x=1754930457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g8d/CzNHs0G9ASNJxC2oXrgkO/yfXUAC6Fskpz1lSXA=;
 b=mwVRqNJBrPegR/i8L+dBiUdhRBt1TvYHO1FQZfjWhkKoqpB1s38/rZrfj8SrBAa29u
 ccouj1/t6vVWpgTQIWsI/ZmM4ShIvzEXdmF6GjIQdNJ6cZye3J+SlKOE+ozilnApucqT
 BBSps/ADIgQkV2U/y+IZkYRlrDSt/UGF4aYOZad9DSXi4mFRsRdggNzB9uOYXoh1Md5F
 XDDUCW6Fk+WJmzYw4Z+bzdkYEXCUgKksBPRWVAQHgLepjU3Ln4bttu8Z4u6D5No4ywHz
 d469dCnlvQLK23KsHPiJSISmnn0Tcfm28mPphHoPoP0lP5r+uCjxFwu9/AFGx7c7Tm7E
 J+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325657; x=1754930457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g8d/CzNHs0G9ASNJxC2oXrgkO/yfXUAC6Fskpz1lSXA=;
 b=lk0A7gkeyaD6KYF4LRUvnDGxSq3VMCf2X7ANugpfmDDlk509xnamRs/hhWIH+M/y9V
 chLtQcEwss4/TYFShWfTv6OshmBaIAy1t1Uug8L9pYzzdBj3FXYDdn0EipWj2gjZbpx1
 cU+9fdiRd/aHP0hor54BoBkCIEJODJHwh9Q658+2bkFyehFCGx0if4VrybMNcj0kseI5
 q3+zO0+Vj/HYFaMZsQtvhkwO8SLL8WXN6utMr3JWQrCmz1+k2BkjFx/sciJIWDYG4oH9
 +GDxq+b4PA22a09C0rJi1oSKl/voC85rEizUj1jkKY8dk3O9Xk5+ZgYex5KqMZu6fhcI
 0iEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw9/r/iJWUF37VrfnvxxsPfdqAnEA3OH9UDfAQe6p/oYle8csO4W4L0OWH9/LLusViZswid8qJEY71@nongnu.org
X-Gm-Message-State: AOJu0YyXUrBH7o1HdaQ+a9jinn360yoU0IaDq0ijcpkRXzc2BEzCVilY
 JiTTBQepQ0gl7uLMJQCrrhzgx3JMC/8/z0MJaEEt1p1fnd2UinJIMdFZR+vdeg1gwt4=
X-Gm-Gg: ASbGncuvWurX7Jko2uQSR3+jmxz2OwqvK+K7nRgzciRM6fxdfkAXWTeIjpOv+rBqYB2
 6z00a9f1ceJMSDvhhms+oTXRNIc/dd4WJdywBk3L2fzjpOoQbrPLNPkQFDsrMuAmMneub3PpIqx
 j+RS7kVPQ0D6d3C+DqAcj7aRf2fjC/dD6djTmnSgukK8MQcJHtmh042dp+y9+2XiMGfTPMbTUs2
 3AVyYEdjswiZ0t9j7Il7xWlHU96lmHlRuyQiIhCm0IWunPKYn3Tc4cbuYNxn6et1J5HPk3or/if
 hvlUiYkd0z9xEYwWSGllJEC7o9msgoiqZfN2NkuVteAznU3lX2bU/1/mLARQmbxqLgdpOz2VAfP
 l6aX0jaWLTJOoS0T4yi3SVlLt77y+E1N7z/4=
X-Google-Smtp-Source: AGHT+IF/0EyAGmzC7c/AyRWIm9NMZQ+uO/p43AvudX0xpI7Qimn7xsG6N4Sb1b1+GhWeTrdSdin7zA==
X-Received: by 2002:a05:6a20:12c9:b0:240:356:f06e with SMTP id
 adf61e73a8af0-2400356f28fmr8309480637.0.1754325656773; 
 Mon, 04 Aug 2025 09:40:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccead744sm10788651b3a.57.2025.08.04.09.40.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 09:40:56 -0700 (PDT)
Message-ID: <f870c073-61f3-4693-90cf-e75372047c84@linaro.org>
Date: Mon, 4 Aug 2025 09:40:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] wasm: Enable 64bit guests on TCI using wasm64
Content-Language: en-US
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1754310749.git.ktokunaga.mail@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <cover.1754310749.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 8/4/25 5:57 AM, Kohei Tokunaga wrote:
> This patch series enables the TCI of the Wasm build to run 64bit
> guests. Unlike the previous series[1], this patch series is implemented by
> adding support for WebAssembly's "wasm64" target which enables 64bit
> pointers.
> 
> In the previous discussion[2], the main challenge of using wasm64 was its
> limited adoption, particularly the lack of support in our dependency
> (libffi) and some engines such as Safari.
> 
> For libffi, I've completed the addition of wasm64 support upstream[3] so it
> can be used.
> 
> To support wasm32 engines, this patch uses Emscripten's compatibility
> feature, -sMEMORY64=2 flag[4]. This flag still enables 64bit pointers in the
> C code while Emscripten lowers the output binary to wasm32 and limits the
> maximum memory size to 4GB. As a result, QEMU can run on wasm32 engiens
> while still supporting 64bit guests.
> 
> # Overview of the build process
> 
> To compile QEMU with Emscripten, the following dependencies are required.
> The emsdk-wasm-cross.docker environment includes all necessary components
> and can be used as the build environment:
> 
> - Emscripten SDK (emsdk) v4.0.10
> - Libraries cross-compiled with Emscripten (please see also
>    emsdk-wasm-cross.docker for build steps)
>    - GLib v2.84.0
>    - zlib v1.3.1
>    - libffi v3.5.2
>    - Pixman v0.44.2
> 
> The configure script supports --cpu=wasm64 flag to compile QEMU with 64bit
> pointer support.
> 
> emconfigure ./configure --cpu=wasm64 \
>                          --static --disable-tools \
>                          --target-list=x86_64-softmmu \
>                          --enable-tcg-interpreter
> emmake make -j$(nproc)
> 
> If the output needs to run on wasm32 engines, use --wasm64-memory64=2
> flag. This flag propagates the value to Emscripten's -sMEMORY64 flag[4].
> 
> emconfigure ./configure --cpu=wasm64 --wasm64-memory64=2 \
>                          --static --disable-tools \
>                          --target-list=x86_64-softmmu \
>                          --enable-tcg-interpreter
> emmake make -j$(nproc)
> 
> Either of the above commands generates the following files:
> 
> - qemu-system-x86_64.js
> - qemu-system-x86_64.wasm
> 
> Guest images can be packaged using Emscripten's file_packager.py tool.
> For example, if the images are stored in a directory named "pack", the
> following command packages them, allowing QEMU to access them through
> Emscripten's virtual filesystem:
> 
> /path/to/file_packager.py qemu-system-x86_64.data --preload pack > load.js
> 
> This process generates the following files:
> 
> - qemu-system-x86_64.data
> - load.js
> 
> Emscripten allows passing arguments to the QEMU command via the Module
> object in JavaScript:
> 
> Module['arguments'] = [
>      '-nographic', '-m', '512M',
>      '-L', 'pack/',
>      '-drive', 'if=virtio,format=raw,file=pack/rootfs.bin',
>      '-kernel', 'pack/bzImage',
>      '-append', 'earlyprintk=ttyS0 console=ttyS0 root=/dev/vda loglevel=7',
> ];
> 
> The sample repository[5] (tcidev64 branch) provides a complete setup,
> including an HTML file that implements a terminal UI.
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg05376.html
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2025-04/msg01795.html
> [3] https://github.com/libffi/libffi/pull/927
> [4] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64
> [5] https://github.com/ktock/qemu-wasm-sample/tree/tcidev64
> 
> Kohei Tokunaga (4):
>    meson: Add wasm64 support to the --cpu flag
>    configure: Enable to propagate -sMEMORY64 flag to Emscripten
>    dockerfiles: Add support for wasm64 to the wasm Dockerfile
>    .gitlab-ci.d: Add build tests for wasm64
> 
>   .gitlab-ci.d/buildtest.yml                    | 24 +++++++++++++--
>   .gitlab-ci.d/container-cross.yml              | 18 +++++++++++-
>   .gitlab-ci.d/container-template.yml           |  4 ++-
>   MAINTAINERS                                   |  2 +-
>   configure                                     | 14 ++++++++-
>   meson.build                                   |  4 +--
>   ...2-cross.docker => emsdk-wasm-cross.docker} | 29 ++++++++++++++-----
>   7 files changed, 79 insertions(+), 16 deletions(-)
>   rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (85%)
> 

Excellent, thanks for adding this.

Out of curiosity, and out of the scope of this PR, would that be 
possible to make a "universal" build, which can selectively select the 
appropriate wasm64 support at runtime, so a single build works on all 
browsers out of the box?

As well, what are the limitations of -sMEMORY64 regarding limited 
address space? Is it just the maximum size of memory a guest can have, 
or does it limit the VA that can be accessed also?

Thanks,
Pierrick

