Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70B1FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKECU-0006NW-KN; Tue, 05 May 2026 07:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wKECQ-0006MS-4u
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wKECI-0007NY-KU
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777981453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rc+3Bksb6HZaTZMt5ERtfmcshhuI4z6FJKgovDQd9m8=;
 b=houLFT8cbsi1zl0aq+KevMooBa23eKDtB6UJrXSwuTvAznebPrVlBhMx0ERDZKLPWodOeE
 vO5fqmN3Ol+9gs3y9btqKoHvraL3pA9WH6GRsVbWP147qdwHRUtUqpIVsbhQDfjOp7vfrZ
 ZYQ5Me3uBNScgVWg7WH0uq+e7QFw8Ds=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-5ABh_u1dNU62v5ttJOanZA-1; Tue, 05 May 2026 07:44:11 -0400
X-MC-Unique: 5ABh_u1dNU62v5ttJOanZA-1
X-Mimecast-MFC-AGG-ID: 5ABh_u1dNU62v5ttJOanZA_1777981451
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488d8deb75fso43790355e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 04:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777981450; x=1778586250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rc+3Bksb6HZaTZMt5ERtfmcshhuI4z6FJKgovDQd9m8=;
 b=o5ASDIAOO+hS5TxuXY9hsS+q460PxUWneFz7PvW5QnIX3s1d69lxNORIBB93hX0cf7
 hCGE5VrpOLTXO7P6xQetCFRzEBskySfTIzFwrOGmuGDlgrI3IO3yFWZJ89FipOv9tWxd
 fKu/7bW/W7d8TCWY4VSOGoXz7lH7oiWqQQcEiLguemrzegnZhqWdzyvEDl0IQnhs37BA
 bA0jzMHykCiImaV9bo9U5JMX6LXlYHe/caSqid6o5AGy/4PaGzpnHmNOlS8XXIP5KoW4
 m7Uzd5tktTj+6YzwjZQIdNc/Ct4g26piYBcRQIixlVQIpi7FrHt0GSJv9NJtdxGkSA/o
 PI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777981450; x=1778586250;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rc+3Bksb6HZaTZMt5ERtfmcshhuI4z6FJKgovDQd9m8=;
 b=DHrVfK6EOcfiO8WthQoBuPyzo8+5QjZ3WTG4RA0RlvTj3lWesaoeJ+43knhpBBWBH3
 l3bgkFhAYpTG8QNvGlnYtotCB2tgLjLPXxjHsvUl9f5FyDWfGiPLgqtMDULHQaemyxMr
 aEtrzD+E2CNxw/gjEkfFCSerkNC4H7EfsLvG/DaKnAuRvCKje8qa42r7Qohtox5HBth3
 85P4XSZLZFVCSSaC8Wtidjfhm+/uRf0V4xeDAD4wjMLJF/cBjWUu9KaLI/tET4HJVpic
 bd5JbzAfmcB9d3M19sGeAB2VcQByT5PmSPMdPIr1T+r+OR11SQuk5/WshJOefLphrKrl
 SPMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+fVCkjAoSXfGiqrcf2tBIE3mQE3MuCTPTGMuGm9IES1toWVoGHt/I/cJF6nA7CRu3kQRcKvKzExu4@nongnu.org
X-Gm-Message-State: AOJu0YwdUVCiHl8/z8jL8p2GN43QtiINNx9rjvyWh/SGXMDlyPLhn/Jl
 sCedtn/ywxjjkzgWWQ9ydOuw7PN8r2QW8kticgf12fQ4yIO9YmDCzDQluWRByeSryaY5Cx9LZg6
 47TaY8VZ1RlXBrYaPNFIiwTTFjn1y4tdWFNrGv77mL7QTXg3U1f1OhBum
X-Gm-Gg: AeBDietbIiN9LIH17+A7nwfJIsT1XPRN5/pMiCJPb2HwSKYWKSZxtjqcvSaUHyRUsvL
 5Lg8ONLnszYrtDC5MT4U5orpD+KWsjA+8ZEMGTihOCTgY76H08fKo5swGgleciK2gXk5dld1GhW
 Tg351TNpvjeQmu3lylv2ZiMQMCanYP7Sindmwb4j3MkEJcwdgW+vn+sMpwhxAZbho2lnTcLYaNd
 9eUt925LqyUQik1HUgcjGPLPtmdvTNKcTbzS7yhdKM0e6T2lF0wfxvANt3CO7bbi2Iv9dRzMg4Q
 y0SdBi8TpRBy8sXTelT1e2vT8hqcf2y8mlFaj05Esm3QJsnsTHuZS6Ao2WUyeKncK59Lm64nXIe
 wabLoEbb+Rxc3wHP2E4ApnJprqX11sw==
X-Received: by 2002:a05:600c:c082:b0:488:af7f:775f with SMTP id
 5b1f17b1804b1-48a988a2211mr156763945e9.18.1777981450001; 
 Tue, 05 May 2026 04:44:10 -0700 (PDT)
X-Received: by 2002:a05:600c:c082:b0:488:af7f:775f with SMTP id
 5b1f17b1804b1-48a988a2211mr156763545e9.18.1777981449586; 
 Tue, 05 May 2026 04:44:09 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d1a98247fsm26729675e9.0.2026.05.05.04.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 04:44:09 -0700 (PDT)
Message-ID: <1993d589-5e6c-4b60-a2f0-c5e61f88b961@redhat.com>
Date: Tue, 5 May 2026 13:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] gitlab: add initial MacOS 15 on gitlab runner
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260505103649.68361-1-alex.bennee@linaro.org>
 <20260505103649.68361-5-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260505103649.68361-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 05/05/2026 12.36, Alex Bennée wrote:
> The gitlab runners are currently in beta but available to projects on
> the Premium and Ultimate plans (which QEMU is via the Open Source
> program).
> 
> We install some compilers via brew so we can run some of the check-tcg
> softmmu test cases.
> 
> We disable rust as the version is too old.
> 
> We disable plugins because we haven't taught the test harness about
> .dynlib vs .so yet.
> 
> There is a discrepancy between the vars and version of MacOS because
> lcitool needs teaching about other versions (although I don't think it
> matters as brew is shared across versions).
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/macos-14.vars    | 16 ++++++++++++
>   .gitlab-ci.d/macos.yml        | 49 +++++++++++++++++++++++++++++++++++
>   .gitlab-ci.d/qemu-project.yml |  1 +
>   tests/lcitool/refresh         | 11 ++++++++
>   4 files changed, 77 insertions(+)
>   create mode 100644 .gitlab-ci.d/macos-14.vars
>   create mode 100644 .gitlab-ci.d/macos.yml
> 
> diff --git a/.gitlab-ci.d/macos-14.vars b/.gitlab-ci.d/macos-14.vars
> new file mode 100644
> index 00000000000..def77cfdea5
> --- /dev/null
> +++ b/.gitlab-ci.d/macos-14.vars
> @@ -0,0 +1,16 @@
> +# THIS FILE WAS AUTO-GENERATED
> +#
> +#  $ lcitool variables macos-14 qemu
> +#
> +# https://gitlab.com/libvirt/libvirt-ci
> +
> +CCACHE='/opt/homebrew/bin/ccache'
> +CPAN_PKGS=''
> +CROSS_PKGS=''
> +MAKE='/opt/homebrew/bin/gmake'
> +NINJA='/opt/homebrew/bin/ninja'
> +PACKAGING_COMMAND='brew'
> +PIP3='/opt/homebrew/bin/pip3'
> +PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka coreutils ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python-setuptools python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 vulkan-tools xorriso zlib zstd'
> +PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
> +PYTHON='/opt/homebrew/bin/python3'
> diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
> new file mode 100644
> index 00000000000..edb500e937b
> --- /dev/null
> +++ b/.gitlab-ci.d/macos.yml
> @@ -0,0 +1,49 @@
> +.macos_job_template:
> +  extends: .base_job_template
> +  stage: build
> +  tags:
> +    - saas-macos-large-m2pro
> +  needs: []
> +  timeout: 80m
> +  artifacts:
> +    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
> +    expire_in: 7 days
> +    paths:
> +      - build/meson-logs/
> +      - build/tests/tcg/
> +    reports:
> +      junit: build/meson-logs/*.junit.xml
> +    when: always
> +  before_script:
> +    - set -o allexport
> +    - source .gitlab-ci.d/macos-14.vars
> +    - set +o allexport
> +    - export PATH="$PATH_EXTRA:$PATH"
> +    - export PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
> +    - brew update
> +    - brew install $PKGS
> +    - brew install gdb aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
> +    - python3 ./scripts/probe-gdb-support.py $(which gdb)

Is the probe-gdb-support.py required here? If not, I'd rather remove that 
line again.

> +    - if test -n "$PYPI_PKGS" ; then PYLIB=$($PYTHON -c 'import sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGED; $PIP3 install --break-system-packages $PYPI_PKGS ; fi
> +  script:
> +    - mkdir build
> +    - cd build
> +    - env

dito, the "env" looks like debugging leftovers ... I'd rather drop it.

> +    - ../configure --enable-werror $CONFIGURE_ARGS || { cat config.log meson-logs/meson-log.txt; exit 1; }
> +    - $MAKE -j$(sysctl -n hw.ncpu)
> +    - for TARGET in $TEST_TARGETS ; do $MAKE $TARGET ; done
> +
> +aarch64-macos-15-build:
> +  extends: .macos_job_template
> +  image: macos-15-xcode-16
> +  variables:
> +    NAME: macos-15
> +    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin

As far as I can see, there is no cache configured for this runner ... so 
could you please drop the ccache stuff from this patch? It will only slow 
down compilation if the results get thrown away afterwards.

  Thomas

> +    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
> +    CONFIGURE_ARGS:
> +        --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu
> +        --cross-prefix-aarch64=aarch64-elf-
> +        --cross-prefix-i386=i686-elf-
> +        --cross-prefix-x86_64=x86_64-elf-
> +        --disable-plugins
> +    TEST_TARGETS: check-unit check-tcg
> diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.yml
> index 4d914c4897b..9cbb5fe787f 100644
> --- a/.gitlab-ci.d/qemu-project.yml
> +++ b/.gitlab-ci.d/qemu-project.yml
> @@ -19,3 +19,4 @@ include:
>     - local: '/.gitlab-ci.d/custom-runners.yml'
>     - local: '/.gitlab-ci.d/cirrus.yml'
>     - local: '/.gitlab-ci.d/windows.yml'
> +  - local: '/.gitlab-ci.d/macos.yml'
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index fa4a16e3583..4289cc381a6 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -87,6 +87,12 @@ def generate_cirrus(target, trailer=None):
>       generate(filename, cmd, trailer)
>   
>   
> +def generate_vars(target, trailer=None):
> +    filename = Path(src_dir, ".gitlab-ci.d", target + ".vars")
> +    cmd = lcitool_cmd + ["variables", "--format", "shell", target, "qemu"]
> +    generate(filename, cmd, trailer)
> +
> +
>   def generate_pkglist(vm, target, project="qemu"):
>       filename = Path(src_dir, "tests", "vm", "generated", vm + ".json")
>       cmd = lcitool_cmd + ["variables", "--format", "json", target, project]
> @@ -312,6 +318,11 @@ try:
>       #
>       generate_cirrus("freebsd-14")
>   
> +    #
> +    # GitLab packages lists
> +    #
> +    generate_vars("macos-14")
> +
>       #
>       # VM packages lists
>       #


