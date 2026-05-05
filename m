Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609A0CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 13:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKFf8-000779-4k; Tue, 05 May 2026 09:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKFf6-00076I-9T
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:18:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKFf3-0004hp-5k
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:18:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ba840146so46077655e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777987083; x=1778591883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ar1rOur+4l4JeHNOGjq46BVBA9xUcd+1UWbkzSZd4MY=;
 b=bWTt1ak5BtCbkAP0fCBTCmq20inpqj+jBUTeh1JwLFaZUF3KEi72N5xfG8bGi7EfxY
 e7pN37bzGM/tmXjw/E1lL3TmxbJY75FSckoQ1m2uRyh1XPuLk+kBRb4JXmtw95z//hxH
 pEyz+IC3QuwCnQL3F3gs/7yZMZH+EOuVr1xkIsd5snrYoS+xtKqfqLDvCmpvKMzYGRDc
 buANogo8AkJnrd9d1pLTdqLcyIO2d07vEDBdbP+J44nLVLdcXrxKm13EsLSVeHawfZVt
 01RgkEC8afALw+WgoIYjDbS3UsHxDXLP7fjwf3oo0crW409hDIzEP9+Ydg9SHr0GkCVd
 bYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777987083; x=1778591883;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ar1rOur+4l4JeHNOGjq46BVBA9xUcd+1UWbkzSZd4MY=;
 b=kLDlYxp8UpfVrv0upZ4b7+3dFmwk70kWmW4lTwHAZYCLFloR1Mrc6edfeGut/i5jlp
 cqoEb9rxjBsIp8JpdL4ixkhUgrjSsrceYonARs5Q1J81jTb527nY6cw5WbxkS88N4UM7
 qfFdkMkpRdNA/ao7qhnBIIUUlQNduMmRCRwe7oB5X+G3zDXtaKyiwlJoYV/UHGYYNffh
 ihjfvbeXHwbuTxUKwyQPisHaIu0D1ckw6MYDm0iHaNesIUK6Uk4YVFB+mfBPoKEKU569
 fW4dRfH3TKSW678oe5iiBnkz/pABZEKWtq35mq7xrzh97TQnOStRlNNVNH1O0Lm4Ac6B
 7Uzg==
X-Gm-Message-State: AOJu0Yy8faPlcHBO47N3jrFdyr2lNoSQNvj6bCl7EgrfUDxwAeEK8uXq
 65HPYgVKX122VcMPxeaf02D6c+A+GoMCQHkAyBBRmJVi22fRzyTtuQQTErQoklo+l6s=
X-Gm-Gg: AeBDiesa0VGjLSGN1VN6K2BM81//z5owTrtYCDtzAuBjfdvsYSFvbq75jo/d0Cb7jF+
 QUplE1EcXITM3xvE6ATKp9xbBf52FqHT+TjuS4Y7tA41vtpboBp/UlsXNnFR+JtcEdyhyj+yHwg
 9k9beFkD1+nGNqZPuB3YdOpmcA/iP4p/S0lXerZPpQkVuF/Ban3GqpReFuPuWYAjSvoJJ4GJAp6
 ABi9OXoEtvshvpox8bgsH2LX7p47j+nn9mrjbnYW96Y+qO8k2CTXpCiqr8HdLB04rfpor9EBstV
 2BG38hh6dWQmQ6wL8SSsTGYY85JfmOA0eyoSuDDAKwE65nYqep+oBXolhun9h6w0P1pbN7NPt9E
 cjvfMl9NGTShI4tuI3cpjfwG1tHBorG9Xwt0cEGLCyB7WOLvnn6rN0w8PFWVJp32ThbiORDkFqb
 HxkbtkKN/8obCe4QKyak+cQsLsu1tUQkwCwg==
X-Received: by 2002:a05:600c:1991:b0:488:ac01:72b6 with SMTP id
 5b1f17b1804b1-48d18be473dmr51416455e9.21.1777987083403; 
 Tue, 05 May 2026 06:18:03 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a48c04sm4512005f8f.15.2026.05.05.06.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 06:18:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 891685F8E7;
 Tue, 05 May 2026 14:18:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <th.huth+qemu@posteo.eu>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  qemu-arm@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Brad Smith
 <brad@comstyle.com>,  Fabiano Rosas <farosas@suse.de>,  Kyle Evans
 <kevans@freebsd.org>,  Peter Maydell <peter.maydell@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Warner Losh <imp@bsdimp.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 4/5] gitlab: add initial MacOS 15 on gitlab runner
In-Reply-To: <1993d589-5e6c-4b60-a2f0-c5e61f88b961@redhat.com> (Thomas Huth's
 message of "Tue, 5 May 2026 13:44:07 +0200")
References: <20260505103649.68361-1-alex.bennee@linaro.org>
 <20260505103649.68361-5-alex.bennee@linaro.org>
 <1993d589-5e6c-4b60-a2f0-c5e61f88b961@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 05 May 2026 14:18:01 +0100
Message-ID: <87se86m1va.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 05/05/2026 12.36, Alex Benn=C3=A9e wrote:
>> The gitlab runners are currently in beta but available to projects on
>> the Premium and Ultimate plans (which QEMU is via the Open Source
>> program).
>> We install some compilers via brew so we can run some of the
>> check-tcg
>> softmmu test cases.
>> We disable rust as the version is too old.
>> We disable plugins because we haven't taught the test harness about
>> .dynlib vs .so yet.
>> There is a discrepancy between the vars and version of MacOS because
>> lcitool needs teaching about other versions (although I don't think it
>> matters as brew is shared across versions).
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   .gitlab-ci.d/macos-14.vars    | 16 ++++++++++++
>>   .gitlab-ci.d/macos.yml        | 49 +++++++++++++++++++++++++++++++++++
>>   .gitlab-ci.d/qemu-project.yml |  1 +
>>   tests/lcitool/refresh         | 11 ++++++++
>>   4 files changed, 77 insertions(+)
>>   create mode 100644 .gitlab-ci.d/macos-14.vars
>>   create mode 100644 .gitlab-ci.d/macos.yml
>> diff --git a/.gitlab-ci.d/macos-14.vars b/.gitlab-ci.d/macos-14.vars
>> new file mode 100644
>> index 00000000000..def77cfdea5
>> --- /dev/null
>> +++ b/.gitlab-ci.d/macos-14.vars
>> @@ -0,0 +1,16 @@
>> +# THIS FILE WAS AUTO-GENERATED
>> +#
>> +#  $ lcitool variables macos-14 qemu
>> +#
>> +# https://gitlab.com/libvirt/libvirt-ci
>> +
>> +CCACHE=3D'/opt/homebrew/bin/ccache'
>> +CPAN_PKGS=3D''
>> +CROSS_PKGS=3D''
>> +MAKE=3D'/opt/homebrew/bin/gmake'
>> +NINJA=3D'/opt/homebrew/bin/ninja'
>> +PACKAGING_COMMAND=3D'brew'
>> +PIP3=3D'/opt/homebrew/bin/pip3'
>> +PKGS=3D'bash bc bindgen bison bzip2 capstone ccache cmocka coreutils
>> ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed
>> gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy
>> libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1
>> libusb llvm lzo make meson mtools ncurses nettle ninja pixman
>> pkg-config python-setuptools python3 rpm2cpio rust sdl2 sdl2_image
>> snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3
>> vulkan-tools xorriso zlib zstd'
>> +PYPI_PKGS=3D'PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
>> +PYTHON=3D'/opt/homebrew/bin/python3'
>> diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
>> new file mode 100644
>> index 00000000000..edb500e937b
>> --- /dev/null
>> +++ b/.gitlab-ci.d/macos.yml
>> @@ -0,0 +1,49 @@
>> +.macos_job_template:
>> +  extends: .base_job_template
>> +  stage: build
>> +  tags:
>> +    - saas-macos-large-m2pro
>> +  needs: []
>> +  timeout: 80m
>> +  artifacts:
>> +    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
>> +    expire_in: 7 days
>> +    paths:
>> +      - build/meson-logs/
>> +      - build/tests/tcg/
>> +    reports:
>> +      junit: build/meson-logs/*.junit.xml
>> +    when: always
>> +  before_script:
>> +    - set -o allexport
>> +    - source .gitlab-ci.d/macos-14.vars
>> +    - set +o allexport
>> +    - export PATH=3D"$PATH_EXTRA:$PATH"
>> +    - export PKG_CONFIG_PATH=3D"$PKG_CONFIG_PATH"
>> +    - brew update
>> +    - brew install $PKGS
>> +    - brew install gdb aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
>> +    - python3 ./scripts/probe-gdb-support.py $(which gdb)
>
> Is the probe-gdb-support.py required here? If not, I'd rather remove
> that line again.
>
>> +    - if test -n "$PYPI_PKGS" ; then PYLIB=3D$($PYTHON -c 'import sysco=
nfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGE=
D; $PIP3 install --break-system-packages $PYPI_PKGS ; fi
>> +  script:
>> +    - mkdir build
>> +    - cd build
>> +    - env
>
> dito, the "env" looks like debugging leftovers ... I'd rather drop it.
>

Yes both are debug left overs. Will fix.

>> +    - ../configure --enable-werror $CONFIGURE_ARGS || { cat config.log =
meson-logs/meson-log.txt; exit 1; }
>> +    - $MAKE -j$(sysctl -n hw.ncpu)
>> +    - for TARGET in $TEST_TARGETS ; do $MAKE $TARGET ; done
>> +
>> +aarch64-macos-15-build:
>> +  extends: .macos_job_template
>> +  image: macos-15-xcode-16
>> +  variables:
>> +    NAME: macos-15
>> +    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
>
> As far as I can see, there is no cache configured for this runner ...
> so could you please drop the ccache stuff from this patch? It will
> only slow down compilation if the results get thrown away afterwards.

Yeah will drop that. The machine is beefy enough and the job duration is
~12 mins and most of that is installing brew bits.

>
>  Thomas
>
>> +    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncu=
rses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
>> +    CONFIGURE_ARGS:
>> +        --target-list=3Daarch64-softmmu,i386-softmmu,x86_64-softmmu
>> +        --cross-prefix-aarch64=3Daarch64-elf-
>> +        --cross-prefix-i386=3Di686-elf-
>> +        --cross-prefix-x86_64=3Dx86_64-elf-
>> +        --disable-plugins
>> +    TEST_TARGETS: check-unit check-tcg
>> diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.y=
ml
>> index 4d914c4897b..9cbb5fe787f 100644
>> --- a/.gitlab-ci.d/qemu-project.yml
>> +++ b/.gitlab-ci.d/qemu-project.yml
>> @@ -19,3 +19,4 @@ include:
>>     - local: '/.gitlab-ci.d/custom-runners.yml'
>>     - local: '/.gitlab-ci.d/cirrus.yml'
>>     - local: '/.gitlab-ci.d/windows.yml'
>> +  - local: '/.gitlab-ci.d/macos.yml'
>> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
>> index fa4a16e3583..4289cc381a6 100755
>> --- a/tests/lcitool/refresh
>> +++ b/tests/lcitool/refresh
>> @@ -87,6 +87,12 @@ def generate_cirrus(target, trailer=3DNone):
>>       generate(filename, cmd, trailer)
>>     +def generate_vars(target, trailer=3DNone):
>> +    filename =3D Path(src_dir, ".gitlab-ci.d", target + ".vars")
>> +    cmd =3D lcitool_cmd + ["variables", "--format", "shell", target, "q=
emu"]
>> +    generate(filename, cmd, trailer)
>> +
>> +
>>   def generate_pkglist(vm, target, project=3D"qemu"):
>>       filename =3D Path(src_dir, "tests", "vm", "generated", vm + ".json=
")
>>       cmd =3D lcitool_cmd + ["variables", "--format", "json", target, pr=
oject]
>> @@ -312,6 +318,11 @@ try:
>>       #
>>       generate_cirrus("freebsd-14")
>>   +    #
>> +    # GitLab packages lists
>> +    #
>> +    generate_vars("macos-14")
>> +
>>       #
>>       # VM packages lists
>>       #

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

