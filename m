Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1619ECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Pxr-0001nZ-0b; Thu, 16 Oct 2025 11:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9Pxo-0001nC-Cu
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:32:25 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9Pxj-0005LB-Qx
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:32:24 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so821148b3a.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760628733; x=1761233533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GyjaHI+UqaINYr2roEiGX3exarI/C/IyoxelbzGiIIA=;
 b=shjnl6GFDIo7N1sMjhgZs7X+G7PKfUL0g3DlLYiZgc/U30d8gi4esukf9mPbRwFAzV
 S+1mkzc17F5cmwhSny2MvQUtSp6+pUlGPyEpRCRprtqciuAWEU1algOoTZQzddoj7FLy
 zdQa89U4wjgrPsFTxGB9uL1kHa2smXJzlm6ySQ1c3G6Hk3kWNtxe0T2R7UopygoE3cOS
 5dxYiINVIw8cr7y1CkjmlY7IDF/KpHVPiDPEbb8LCVQGCimzP/iU09vsBnMNxkqT9T9b
 8Hin0I43aWJ35lBn2LWH2ZxaRTNlNpPOaYnL+S88IsE4k+MgViN7URZrIlAztso82r92
 vmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760628733; x=1761233533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GyjaHI+UqaINYr2roEiGX3exarI/C/IyoxelbzGiIIA=;
 b=fUQPMe3Ul+Z28PofSE6tZWPz5MV3m1HqYmbqcXa0xLpGM1Q2FLqmoIJQmo1MQ3ZgFo
 u2jARd0QWvtY+1XaWcflIDt5rN+4OmIDLW0zOp2cB1aNa/JGQ1CN+PPqTEf+qOCWrqFV
 pB/QKKSY24OCrI7e5N1y5bIe/Pj97AZ9idJK+b++lLHxx55jH91nyoVChgjpRVs9Uuxv
 Xf6ftkxt2dn7C37+N28gnCOcTXYKcZzxI7PDmDCS1e7H9VFqCxmMca2skDzJgD5N5Pgp
 fXTPfWW5b0A4yyT7ll59qaGnBWZc5KW71Kyf1DIU70s/NCyhRcMQJYoEE+kl3+qv05AB
 OPtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/yLrbdZ3PcfedVLp7fgRDrjg37IdloJMMBTPg87gi9kLjKvBG28vXmw9yOsgektijQkQfgC6cLYv3@nongnu.org
X-Gm-Message-State: AOJu0YxN5E3UEWOyaaGZa0irIiByUgM1EeIBn3rNEE34by88oJ+WaBFQ
 SkmuLHOCCCPjaHa2p2TM7Q9havO+ICqWkgj1NsSUkB1UrWVaKwm0qco7SnR4Vl0G3zQ=
X-Gm-Gg: ASbGncvkxW2OkDpY3/14Y0zvPD++9L2SLY/95EwoO991GphPIVkRkO89lhoFfhix4YY
 7SEq+Ls9ULFYk3obvIO/j2e1zF1hp8ZEKRoNMeXZ9m/+/zM30NWY9DD6HZu4/RDK+ZZPoQOcTEO
 yyaUlMB6BS3Jl3sMgb2XgaC84OAwboXE2yQY0QhBM4zA/B4yPVX8cEgvWLuytT9YG8exWw6lLat
 QtNqO4b3arqpycJ1KLXUj06aIBOfZzjOX0TH/+ika9dPz2BgMMg2pniXO/MKrRzlBjqyAGwWG37
 jQpA9wMFBA5f55oYW6d/jhgxQv+o7pfAxXFsfJXPwiD2voUTjdvAPAC9R10hvE1waT/H3uVlFlB
 QDhkeTGIboOtVPJCovOZ1YnbJQJhOGJGSe4o9R3eZt0bu4+l5F55CBT88jVMXqjuyChZv3SPdoA
 u0n+Xz/zwU+6z9MwB6rxtNRRQ=
X-Google-Smtp-Source: AGHT+IFUE0OEu1D8x0ACMDgnZ7uVmSbZLTu+QC5hQnpmOQ5qF2X2oQGdgFAvqMkQVEyLZoVKUAMC/Q==
X-Received: by 2002:a05:6a20:4311:b0:246:d43a:3856 with SMTP id
 adf61e73a8af0-334a857d6f3mr403451637.22.1760628733227; 
 Thu, 16 Oct 2025 08:32:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a22b7866csm3159482a12.19.2025.10.16.08.32.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 08:32:12 -0700 (PDT)
Message-ID: <9a436ca6-792b-4c46-bdb4-1a84d6286b58@linaro.org>
Date: Thu, 16 Oct 2025 08:32:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] gitlab: use template for ubuntu-24.04-aarch64 jobs
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
 <20251016150357.876415-2-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251016150357.876415-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 10/16/25 8:03 AM, Alex Bennée wrote:
> Most of the test is pure boilerplate so to save ourselves from
> repetition move all the main bits into a minimal copy of
> native_build_job_template but without the caching.
> 
> We keep all the current allow_fail and configure setups but do take
> the opportunity to replace the -j`nproc --ignore=40` hack with
> something that almost, but not quite, saturates the machine its being
> built on.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .../custom-runners/ubuntu-24.04-aarch64.yml   | 230 ++++++++----------
>   1 file changed, 96 insertions(+), 134 deletions(-)
> 
> diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
> index d26c7827f45..46db9ae0138 100644
> --- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
> +++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
> @@ -2,150 +2,112 @@
>   # setup by the scripts/ci/setup/ubuntu/build-environment.yml task
>   # "Install basic packages to build QEMU on Ubuntu 24.04"
>   
> +.ubuntu_aarch64_template:
> +  extends: .custom_runner_template
> +  needs: []
> +  stage: build
> +  tags:
> +    - ubuntu_24.04
> +    - aarch64
> +  rules:
> +    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> +    - if: "$AARCH64_RUNNER_AVAILABLE"
> +  before_script:
> +    - source scripts/ci/gitlab-ci-section
> +    - section_start setup "Pre-script setup"
> +    - JOBS=$(expr $(nproc) - 4)
> +    - section_end setup
> +  script:
> +    - mkdir build
> +    - cd build
> +    - section_start configure "Running configure"
> +    - ../configure $CONFIGURE_ARGS ||
> +          { cat config.log meson-logs/meson-log.txt && exit 1; }
> +    - section_end configure
> +    - section_start build "Building QEMU"
> +    - make --output-sync -j"$JOBS"
> +    - section_end build
> +    - section_start test "Running tests"
> +    - if test -n "$MAKE_CHECK_ARGS";
> +      then
> +        make -j"$JOBS" $MAKE_CHECK_ARGS ;
> +      fi
> +    - section_end test
> +
>   ubuntu-24.04-aarch64-all-linux-static:
> - extends: .custom_runner_template
> - needs: []
> - stage: build
> - tags:
> - - ubuntu_24.04
> - - aarch64
> - rules:
> - - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> - - if: "$AARCH64_RUNNER_AVAILABLE"
> - script:
> - - mkdir build
> - - cd build
> - # Disable -static-pie due to build error with system libc:
> - # https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1987438
> - - ../configure --enable-debug --static --disable-system --disable-pie
> -   || { cat config.log meson-logs/meson-log.txt; exit 1; }
> - - make --output-sync -j`nproc --ignore=40`
> - - make check-tcg
> - - make --output-sync -j`nproc --ignore=40` check
> +  extends: .ubuntu_aarch64_template
> +  variables:
> +    # Disable -static-pie due to build error with system libc:
> +    # https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1987438
> +    CONFIGURE_ARGS: --enable-debug --static --disable-system --disable-pie
> +    MAKE_CHECK_ARGS: check-tcg
>   
>   ubuntu-24.04-aarch64-all:
> - extends: .custom_runner_template
> - needs: []
> - stage: build
> - tags:
> - - ubuntu_24.04
> - - aarch64
> - rules:
> - - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> -   when: manual
> -   allow_failure: true
> - - if: "$AARCH64_RUNNER_AVAILABLE"
> -   when: manual
> -   allow_failure: true
> - script:
> - - mkdir build
> - - cd build
> - - ../configure
> -   || { cat config.log meson-logs/meson-log.txt; exit 1; }
> - - make --output-sync -j`nproc --ignore=40`
> - - make --output-sync -j`nproc --ignore=40` check
> +  extends: .ubuntu_aarch64_template
> +  variables:
> +    MAKE_CHECK_ARGS: check
> +  rules:
> +    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> +      when: manual
> +      allow_failure: true
> +    - if: "$AARCH64_RUNNER_AVAILABLE"
> +      when: manual
> +      allow_failure: true
>   
>   ubuntu-24.04-aarch64-without-defaults:
> - extends: .custom_runner_template
> - needs: []
> - stage: build
> - tags:
> - - ubuntu_24.04
> - - aarch64
> - rules:
> - - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> -   when: manual
> -   allow_failure: true
> - - if: "$AARCH64_RUNNER_AVAILABLE"
> -   when: manual
> -   allow_failure: true
> - script:
> - - mkdir build
> - - cd build
> - - ../configure --disable-user --without-default-devices --without-default-features
> -   || { cat config.log meson-logs/meson-log.txt; exit 1; }
> - - make --output-sync -j`nproc --ignore=40`
> - - make --output-sync -j`nproc --ignore=40` check
> +  extends: .ubuntu_aarch64_template
> +  variables:
> +    CONFIGURE_ARGS: --disable-user --without-default-devices --without-default-features
> +    MAKE_CHECK_ARGS: check
> +  rules:
> +    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> +      when: manual
> +      allow_failure: true
> +    - if: "$AARCH64_RUNNER_AVAILABLE"
> +      when: manual
> +      allow_failure: true
>   
>   ubuntu-24.04-aarch64-alldbg:
> - extends: .custom_runner_template
> - needs: []
> - stage: build
> - tags:
> - - ubuntu_24.04
> - - aarch64
> - rules:
> - - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> - - if: "$AARCH64_RUNNER_AVAILABLE"
> - script:
> - - mkdir build
> - - cd build
> - - ../configure --enable-debug
> -   || { cat config.log meson-logs/meson-log.txt; exit 1; }
> - - make clean
> - - make --output-sync -j`nproc --ignore=40`
> - - make --output-sync -j`nproc --ignore=40` check
> +  extends: .ubuntu_aarch64_template
> +  variables:
> +    CONFIGURE_ARGS: --enable-debug
> +    MAKE_CHECK_ARGS: check-tcg
>   
>   ubuntu-24.04-aarch64-clang:
> - extends: .custom_runner_template
> - needs: []
> - stage: build
> - tags:
> - - ubuntu_24.04
> - - aarch64
> - rules:
> - - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> -   when: manual
> -   allow_failure: true
> - - if: "$AARCH64_RUNNER_AVAILABLE"
> -   when: manual
> -   allow_failure: true
> - script:
> - - mkdir build
> - - cd build
> - - ../configure --disable-libssh --cc=clang --cxx=clang++ --enable-ubsan
> -   || { cat config.log meson-logs/meson-log.txt; exit 1; }
> - - make --output-sync -j`nproc --ignore=40`
> - - make --output-sync -j`nproc --ignore=40` check
> +  extends: .ubuntu_aarch64_template
> +  variables:
> +    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-ubsan
> +    MAKE_CHECK_ARGS: check
> +  rules:
> +    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> +      when: manual
> +      allow_failure: true
> +    - if: "$AARCH64_RUNNER_AVAILABLE"
> +      when: manual
> +      allow_failure: true
>   
>   ubuntu-24.04-aarch64-tci:
> - needs: []
> - stage: build
> - tags:
> - - ubuntu_24.04
> - - aarch64
> - rules:
> - - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> -   when: manual
> -   allow_failure: true
> - - if: "$AARCH64_RUNNER_AVAILABLE"
> -   when: manual
> -   allow_failure: true
> - script:
> - - mkdir build
> - - cd build
> - - ../configure --enable-tcg-interpreter
> -   || { cat config.log meson-logs/meson-log.txt; exit 1; }
> - - make --output-sync -j`nproc --ignore=40`
> +  extends: .ubuntu_aarch64_template
> +  variables:
> +    CONFIGURE_ARGS: --enable-tcg-interpreter
> +    MAKE_CHECK_ARGS: check
> +  rules:
> +    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> +      when: manual
> +      allow_failure: true
> +    - if: "$AARCH64_RUNNER_AVAILABLE"
> +      when: manual
> +      allow_failure: true
>   
>   ubuntu-24.04-aarch64-notcg:
> - extends: .custom_runner_template
> - needs: []
> - stage: build
> - tags:
> - - ubuntu_24.04
> - - aarch64
> - rules:
> - - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> -   when: manual
> -   allow_failure: true
> - - if: "$AARCH64_RUNNER_AVAILABLE"
> -   when: manual
> -   allow_failure: true
> - script:
> - - mkdir build
> - - cd build
> - - ../configure --disable-tcg --with-devices-aarch64=minimal
> -   || { cat config.log meson-logs/meson-log.txt; exit 1; }
> - - make --output-sync -j`nproc --ignore=40`
> - - make --output-sync -j`nproc --ignore=40` check
> +  extends: .ubuntu_aarch64_template
> +  variables:
> +    CONFIGURE_ARGS: --disable-tcg --with-devices-aarch64=minimal
> +    MAKE_CHECK_ARGS: check
> +  rules:
> +    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> +      when: manual
> +      allow_failure: true
> +    - if: "$AARCH64_RUNNER_AVAILABLE"
> +      when: manual
> +      allow_failure: true

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


