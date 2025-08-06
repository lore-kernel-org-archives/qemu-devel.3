Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD5EC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhea-0001u5-5H; Wed, 06 Aug 2025 13:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujgzD-00066F-26
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:27:32 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujgzB-0007wA-8g
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:27:30 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b79bddd604so3527f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754497647; x=1755102447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ab9xaOaSmdru+YTLHhqNJtRC+d29amj/27Jw0SUzjTY=;
 b=pfKBivJVgI1tR9N3KzB2D1vZjODUtFOReDcD+IOSyxgaBQEqS2jqCZ2rNm9Tr+tPMy
 EIvs00gP3Uy00Q8zeKEd8JTnuAbfak4Qvi6lx2EQxNDav9Gl3XiLJbtmqmzWdGZ0O1sd
 GG5d30w8EQSdiSYl+HlbiAl3gs/P0gWXsigMpGpq8xEFD5cjQWtkROHxrP5GvGJsohwv
 sIKDq9BiO9yC4qDlKIXt45Y6c3TYhxtPyMLDnvkjcQdpAHMNX/gVAXl8/g+OxzPys6h5
 TyikOK1tuteKrPZk7P5BD2ly7VlrvdR19G4gWgBgM65fs/JHJSAaJ9dSX/z3U39JMVve
 sJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754497647; x=1755102447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ab9xaOaSmdru+YTLHhqNJtRC+d29amj/27Jw0SUzjTY=;
 b=c8cYUwqVFM/VqOXEwJfMHu6FI2482Eqg9btwhhIp5dc0JvGrX0lBrYendQOZO4hbSM
 U90/dsDv8Go8V8xPXVoOdExn280B4L+6p2mMjg0S7voZBjFd8Uqc9NPc2fduta+pXQTH
 g+ZXC/lcw/iDl7idzb0qhPDaHJOe6q21veTfZ2PHRv54DyuzdSWs1cdeLrxeN/Fc33DL
 rkotLRBBS2291cyBIHm6fMxqLgiVBI0Qt7CgfrGwPuKenvyfzm2QyeFpauPP8fC4dc6E
 SF7xZ3q4V9KjeENt+YWjC0WFv6shUl7TmI7VIoPCaOWMffrIiLfs7pNYZdGTC9EY5098
 L42A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgJcSEVYFVVbSY6HdGvFOmmQVQXo1d1SjYLRFMzQ3xYvQwss08629Rb5XpyVi/gk/uPfwSmcNLthVo@nongnu.org
X-Gm-Message-State: AOJu0YxXFY1HnYDSoUeH3uEhgX0Oukt8s8GRkLVyLuL1WeohQqqepxqH
 v/87IwJQNrj/1fqgUzM6309HKUk3lEkmzYPWCFdmiTg77+/F30UoWszcy+p7h2IfAZk=
X-Gm-Gg: ASbGncvoBpq+uUIIq9VvEKpEZp0kX0LkVKc5ev2rl4IRinEkWvydZGkT2DMsyuXYcJE
 YRVeex9pFjRw9wN9Tbkx3HqtqcTVjN9U0GceKd6C8cZEppHEQe8gyUqP4Ab+kFpiPRqUS/kXDHO
 uyx+QoTNj9+n/HD0a/Pnlnz1F16TY7e44zLtd/vUT6nQGEvvvMKN79e9382ehv+9UNfac7s6Shf
 lGNp7r92GP+vHNvFjXC/Zy7YtQgIoh9eeDb+0K3h1KrfdVuTrSfAR/O3TsT9Kjs5am6Ikgx+gyR
 XJje+xdEeQ4LfeTsYuzXY0mILBkYJvKmo8QoK8hDP2CbfmkkTPh/AxXwiFrobgqwDJoQ2hsl59A
 5DEsrPsLjwvWAUjoYbmaGw3+wD/eSDODJLfUT+QoARL798fZZP/zA/pqRUOW8JsDunQ==
X-Google-Smtp-Source: AGHT+IHIe8sTg25S/xb3g3uRJYvmA8LgelGglHte4LofnavMoOn3U1wntWpjkyTqLtC8IrmQZPSuzw==
X-Received: by 2002:a05:6000:250a:b0:3b7:9bd2:7ae7 with SMTP id
 ffacd0b85a97d-3b8f41f1356mr2694302f8f.57.1754497646920; 
 Wed, 06 Aug 2025 09:27:26 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e587ed97sm55555665e9.25.2025.08.06.09.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 09:27:26 -0700 (PDT)
Message-ID: <9772039a-53c3-4850-82e4-d0efdfa94f2d@linaro.org>
Date: Wed, 6 Aug 2025 18:27:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] .gitlab-ci.d: Add build tests for wasm64
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1754494089.git.ktokunaga.mail@gmail.com>
 <c10d9f2b85a2791d9f734678fba186e6eacc1b37.1754494089.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c10d9f2b85a2791d9f734678fba186e6eacc1b37.1754494089.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 6/8/25 17:49, Kohei Tokunaga wrote:
> The wasm builds are tested for 3 targets: wasm32, wasm64(-sMEMORY64=1) and
> wasm64(-sMEMORY64=2). The CI builds the containers using the same Dockerfile
> (emsdk-wasm-cross.docker) with different build args.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   .gitlab-ci.d/buildtest.yml          | 24 +++++++++++++++++++++---
>   .gitlab-ci.d/container-cross.yml    | 18 +++++++++++++++++-
>   .gitlab-ci.d/container-template.yml |  4 +++-
>   3 files changed, 41 insertions(+), 5 deletions(-)
> 
> V2:
> - Fixed to use --wasm64-32bit-address-limit instead of the removed
>    --wasm64-memory64. This can be considered as a significant change from the
>    previous version of this patch so the Reviewed-by tag has been removed.
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index d888a60063..0dded04188 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -787,11 +787,29 @@ coverity:
>       # Always manual on forks even if $QEMU_CI == "2"
>       - when: manual
>   
> -build-wasm:
> +build-wasm32:

OK (or following bellow logic, "build-wasm32-32-bit").

>     extends: .wasm_build_job_template
>     timeout: 2h
>     needs:
> -    job: wasm-emsdk-cross-container
> +    job: wasm32-emsdk-cross-container
>     variables:
>       IMAGE: emsdk-wasm32-cross
> -    CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter
> +    CONFIGURE_ARGS: --static --cpu=wasm32 --disable-tools --enable-debug --enable-tcg-interpreter
> +
> +build-wasm-wasm64:

Maybe build-wasm64-64bit?> +  extends: .wasm_build_job_template
> +  timeout: 2h
> +  needs:
> +    job: wasm64-emsdk-cross-container
> +  variables:
> +    IMAGE: emsdk-wasm64-cross
> +    CONFIGURE_ARGS: --static --cpu=wasm64 --disable-tools --enable-debug --enable-tcg-interpreter
> +
> +build-wasm-wasm64l:

So this one becomes build-wasm64-32bit (or better name, "wasm64[l]" is
not easy to distinct and figure out this is the 32-bit AS version.

> +  extends: .wasm_build_job_template
> +  timeout: 2h
> +  needs:
> +    job: wasm64l-emsdk-cross-container
> +  variables:
> +    IMAGE: emsdk-wasm64l-cross
> +    CONFIGURE_ARGS: --static --cpu=wasm64 --wasm64-32bit-address-limit --disable-tools --enable-debug --enable-tcg-interpreter
> diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
> index 8d3be53b75..1bacaff818 100644
> --- a/.gitlab-ci.d/container-cross.yml
> +++ b/.gitlab-ci.d/container-cross.yml
> @@ -92,7 +92,23 @@ win64-fedora-cross-container:
>     variables:
>       NAME: fedora-win64-cross
>   
> -wasm-emsdk-cross-container:
> +wasm32-emsdk-cross-container:
>     extends: .container_job_template
>     variables:
>       NAME: emsdk-wasm32-cross
> +    BUILD_ARGS: --build-arg TARGET_CPU=wasm32
> +    DOCKERFILE: emsdk-wasm-cross
> +
> +wasm64-emsdk-cross-container:
> +  extends: .container_job_template
> +  variables:
> +    NAME: emsdk-wasm64-cross
> +    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg WASM64_MEMORY64=1
> +    DOCKERFILE: emsdk-wasm-cross
> +
> +wasm64l-emsdk-cross-container:

(same comments)

> +  extends: .container_job_template
> +  variables:
> +    NAME: emsdk-wasm64l-cross
> +    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg WASM64_MEMORY64=2
> +    DOCKERFILE: emsdk-wasm-cross
> diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
> index 4eec72f383..01ca840413 100644
> --- a/.gitlab-ci.d/container-template.yml
> +++ b/.gitlab-ci.d/container-template.yml
> @@ -10,12 +10,14 @@
>       - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
>       - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
>       - until docker info; do sleep 1; done
> +    - export DOCKERFILE_NAME=${DOCKERFILE:-$NAME}
>     script:
>       - echo "TAG:$TAG"
>       - echo "COMMON_TAG:$COMMON_TAG"
>       - docker build --tag "$TAG" --cache-from "$TAG" --cache-from "$COMMON_TAG"
>         --build-arg BUILDKIT_INLINE_CACHE=1
> -      -f "tests/docker/dockerfiles/$NAME.docker" "."
> +      $BUILD_ARGS
> +      -f "tests/docker/dockerfiles/$DOCKERFILE_NAME.docker" "."
>       - docker push "$TAG"
>     after_script:
>       - docker logout
Nitpicking about names, otherwise LGTM!

