Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE87FC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pBS-0000Jk-4R; Thu, 10 Sep 2026 20:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4n3L-0002u5-TQ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 18:15:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4n2m-0004LL-8G
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 18:15:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so2570765e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789078492; x=1789683292; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UGDs+y+6X+HLy2gsZDl6WRNlqbZU5T+BP1IRxUou/fA=;
 b=KZFHT+M8CJzJp0zsf9zO1E+5U5uF0rNwwsU5h9w30nFl9r+t6fNUiDqxWLPH/FDXpK
 xsUShLjOxAKWCudAg2qbXCbHIKaQS/asx8J/q9nQNDTHo5bD3aJpQvTNAaVuwUta7kp7
 2lCR8eqPbuqAzdA6fu9C3ud1OY+v3tHnWYOCJQn0gKGW0gRYT+cimuSW1TGgCTV+olDy
 4fUDXauf2ogbb9Pix9fyGutAxq+eJ9XNnP6467qcvMUFHd5EDYIzdgj9yEaMg5/KE1Nc
 dFayCdNwf6oWalHVbez2Om47OKTfv/tqMMNHCiSTiOB32ZbVF/qdhKNLnphqA1LO0/+J
 T71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789078492; x=1789683292;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UGDs+y+6X+HLy2gsZDl6WRNlqbZU5T+BP1IRxUou/fA=;
 b=ZunyfL9kDtVmfxSrXI/27Q230oPRycTf75HiEfRwp3R1GZ6Mhm321SJuB4uvy5oPPC
 wHHg0lf8Vu2k31VY5eJmMkVHwFoGmp2lELFl6xFbwYvsTYggNHbjNcaBp9SfxyG7/gDG
 oypZnyzmsTtVM1oGlqZy/cEpHJi+T7X9O+U0XWfG7xemMLQj9J/HZjEgKN9cKXgevcw/
 hSw/jGw0HS+tinyiSY2P1EEwArqs9GmoPp+6kcpcYm+PTuNAISciZgQ0hcG1I0YKy/+5
 9XT+NvqvFLQoIys0zWHph137+BStO7B2XgGolW0bTOu9DRWVpzv07E67dtmQCeu4X4GH
 UCeA==
X-Gm-Message-State: AFuF++k/M0GfcwRuNVcgZPsXB5/YwtpZ8kRL74RctQVdL6rKRFtssPav
 mirZxSf2krYtWpQ3Zt96JD2dPYAM4jk8yb1m16/CEzjyPvWrguULcIpXhSo0m5EDVkf3j0UgtKh
 bcNoXwQQ=
X-Gm-Gg: AYBFou1ydssIF+Fq/YtGt6suCE9LSRIXzkaiin2yDWo8RfOeJJUyJeHbGvx+jTekTYw
 Uac4t+wIzbwxoSx0+O5zK07CMZZ6QyGM1uJ7EIZ7U/x1s3Ed8wmR+lm3MMioW7Rae6xtv3Bx/Co
 /Le3D7AcY/QTMmF/IfUdBN/xE8TTMurZrUZ2o27PtsGgmTIxwWFwJNyr3hPhFgxu6faQ5U60aTB
 DQsPU9y8iVxGsqy/ua6ZoljVSlHDeIGkLouT7FLoHLI7aulXnXFCtfOgFs6fisTDElphp8q0qLC
 afLpw6yvxthmGl/jCItl/e4B97QegS9HTNAVbtj7AJf9x9gLFP3G01Q6VWbq978rnNFENDwHN8w
 oBc4o0deI+h5sdGfuN5W7iUI7CUHxLSuwM5yDNoBCCNkLmU/nw7syDDRYZKU6OHJVblsxmjRN7L
 //BgeAEJ2ZpQZ1PGOxOS1AKltRfoLmOaiA6C7vMLVhPkSeFTl1Ldps9+FLI1+pAFKjv99vFRs=
X-Received: by 2002:a05:600c:1385:b0:49c:fc6e:a3d5 with SMTP id
 5b1f17b1804b1-49e619bfebcmr9838155e9.20.1789078491883; 
 Thu, 10 Sep 2026 15:14:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62230e72sm4911275e9.4.2026.09.10.15.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 15:14:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DD9795F834;
 Thu, 10 Sep 2026 23:14:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] meson: refresh build options script
In-Reply-To: <20260908074016.2143292-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 8 Sep 2026 08:40:16 +0100")
References: <20260908074016.2143292-1-berrange@redhat.com>
User-Agent: mu4e 1.14.4-pre2; emacs 30.1
Date: Thu, 10 Sep 2026 23:14:49 +0100
Message-ID: <87wlss92jq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Recent changes added more meson options, but missed refreshing of
> the meson-buildoptions.sh file, causing it to frequently appear
> dirty when doing builds.
>
> Fixes: 7e1d54da6faf (tests/tcg/meson.build: implement ./configure -cross-=
cc-* options)
> Fixes: 522b299ca431 (tests/tcg/meson.build: implement ./configure contain=
ers options)
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Queued to testing/next, thanks.

> ---
>  scripts/meson-buildoptions.sh | 138 ++++++++++++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
>
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 5a67e59a16..eb15551286 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -10,7 +10,10 @@ meson_options_help() {
>    printf "%s\n" '  --block-drv-rw-whitelist=3DVALUE'
>    printf "%s\n" '                           set block driver read-write =
whitelist (by default'
>    printf "%s\n" '                           affects only QEMU, not tools=
 like qemu-img)'
> +  printf "%s\n" '  --container-command=3DVALUE'
> +  printf "%s\n" '                           command to build/run contain=
ers'
>    printf "%s\n" '  --datadir=3DVALUE          Data file directory [share=
]'
> +  printf "%s\n" '  --disable-containers     use containers to cross comp=
ile tcg tests'
>    printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better p=
erformance)'
>    printf "%s\n" '  --disable-debug-info     Enable debug symbols and oth=
er information'
>    printf "%s\n" '  --disable-hexagon-idef-parser'
> @@ -77,6 +80,94 @@ meson_options_help() {
>    printf "%s\n" '  --rtsig-map=3DVALUE        default value of QEMU_RTSI=
G_MAP [NULL]'
>    printf "%s\n" '  --smbd=3DVALUE             Path to smbd for slirp net=
working'
>    printf "%s\n" '  --sysconfdir=3DVALUE       Sysconf data directory [et=
c]'
> +  printf "%s\n" '  --tcg-tests-cross-cc-aarch64=3DVALUE'
> +  printf "%s\n" '                           cc for aarch64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-aarch64-be=3DVALUE'
> +  printf "%s\n" '                           cc for aarch64_be tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-alpha=3DVALUE'
> +  printf "%s\n" '                           cc for alpha tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-arm=3DVALUE'
> +  printf "%s\n" '                           cc for arm tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-hexagon=3DVALUE'
> +  printf "%s\n" '                           cc for hexagon tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-hppa=3DVALUE'
> +  printf "%s\n" '                           cc for hppa tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-i386=3DVALUE'
> +  printf "%s\n" '                           cc for i386 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-loongarch64=3DVALUE'
> +  printf "%s\n" '                           cc for loongarch64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-m68k=3DVALUE'
> +  printf "%s\n" '                           cc for m68k tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-mips=3DVALUE'
> +  printf "%s\n" '                           cc for mips tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-mips64=3DVALUE'
> +  printf "%s\n" '                           cc for mips64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-mips64el=3DVALUE'
> +  printf "%s\n" '                           cc for mips64el tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-or1k=3DVALUE'
> +  printf "%s\n" '                           cc for or1k tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-ppc64=3DVALUE'
> +  printf "%s\n" '                           cc for ppc64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-ppc64le=3DVALUE'
> +  printf "%s\n" '                           cc for ppc64le tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-riscv64=3DVALUE'
> +  printf "%s\n" '                           cc for riscv64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-s390x=3DVALUE'
> +  printf "%s\n" '                           cc for s390x tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-sh4=3DVALUE'
> +  printf "%s\n" '                           cc for sh4 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-tricore=3DVALUE'
> +  printf "%s\n" '                           cc for tricore tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-x86-64=3DVALUE'
> +  printf "%s\n" '                           cc for x86_64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-xtensa=3DVALUE'
> +  printf "%s\n" '                           cc for xtensa tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-xtensaeb=3DVALUE'
> +  printf "%s\n" '                           cc for xtensaeb tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-aarch64=3DVALUE'
> +  printf "%s\n" '                           cflags for aarch64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-aarch64-be=3DVALUE'
> +  printf "%s\n" '                           cflags for aarch64_be tcg te=
sts'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-alpha=3DVALUE'
> +  printf "%s\n" '                           cflags for alpha tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-arm=3DVALUE'
> +  printf "%s\n" '                           cflags for arm tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-hexagon=3DVALUE'
> +  printf "%s\n" '                           cflags for hexagon tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-hppa=3DVALUE'
> +  printf "%s\n" '                           cflags for hppa tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-i386=3DVALUE'
> +  printf "%s\n" '                           cflags for i386 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-loongarch64=3DVALUE'
> +  printf "%s\n" '                           cflags for loongarch64 tcg t=
ests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-m68k=3DVALUE'
> +  printf "%s\n" '                           cflags for m68k tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-mips=3DVALUE'
> +  printf "%s\n" '                           cflags for mips tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-mips64=3DVALUE'
> +  printf "%s\n" '                           cflags for mips64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-mips64el=3DVALUE'
> +  printf "%s\n" '                           cflags for mips64el tcg test=
s'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-or1k=3DVALUE'
> +  printf "%s\n" '                           cflags for or1k tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-ppc64=3DVALUE'
> +  printf "%s\n" '                           cflags for ppc64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-ppc64le=3DVALUE'
> +  printf "%s\n" '                           cflags for ppc64le tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-riscv64=3DVALUE'
> +  printf "%s\n" '                           cflags for riscv64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-s390x=3DVALUE'
> +  printf "%s\n" '                           cflags for s390x tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-sh4=3DVALUE'
> +  printf "%s\n" '                           cflags for sh4 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-tricore=3DVALUE'
> +  printf "%s\n" '                           cflags for tricore tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-x86-64=3DVALUE'
> +  printf "%s\n" '                           cflags for x86_64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-xtensa=3DVALUE'
> +  printf "%s\n" '                           cflags for xtensa tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-xtensaeb=3DVALUE'
> +  printf "%s\n" '                           cflags for xtensaeb tcg test=
s'
>    printf "%s\n" '  --tls-priority=3DVALUE     Default TLS protocol/ciphe=
r priority string'
>    printf "%s\n" '                           [NORMAL]'
>    printf "%s\n" '  --with-coroutine=3DCHOICE  coroutine backend to use (=
choices:'
> @@ -281,6 +372,9 @@ _meson_option_parse() {
>      --disable-cocoa) printf "%s" -Dcocoa=3Ddisabled ;;
>      --enable-colo-proxy) printf "%s" -Dcolo_proxy=3Denabled ;;
>      --disable-colo-proxy) printf "%s" -Dcolo_proxy=3Ddisabled ;;
> +    --container-command=3D*) quote_sh "-Dcontainer_command=3D$2" ;;
> +    --enable-containers) printf "%s" -Dcontainers=3Dtrue ;;
> +    --disable-containers) printf "%s" -Dcontainers=3Dfalse ;;
>      --enable-coreaudio) printf "%s" -Dcoreaudio=3Denabled ;;
>      --disable-coreaudio) printf "%s" -Dcoreaudio=3Ddisabled ;;
>      --with-coroutine=3D*) quote_sh "-Dcoroutine_backend=3D$2" ;;
> @@ -517,6 +611,50 @@ _meson_option_parse() {
>      --disable-tcg) printf "%s" -Dtcg=3Ddisabled ;;
>      --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=3Dtrue ;;
>      --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=3Dfalse ;;
> +    --tcg-tests-cross-cc-aarch64=3D*) quote_sh "-Dtcg_tests_cross_cc_aar=
ch64=3D$2" ;;
> +    --tcg-tests-cross-cc-aarch64-be=3D*) quote_sh "-Dtcg_tests_cross_cc_=
aarch64_be=3D$2" ;;
> +    --tcg-tests-cross-cc-alpha=3D*) quote_sh "-Dtcg_tests_cross_cc_alpha=
=3D$2" ;;
> +    --tcg-tests-cross-cc-arm=3D*) quote_sh "-Dtcg_tests_cross_cc_arm=3D$=
2" ;;
> +    --tcg-tests-cross-cc-hexagon=3D*) quote_sh "-Dtcg_tests_cross_cc_hex=
agon=3D$2" ;;
> +    --tcg-tests-cross-cc-hppa=3D*) quote_sh "-Dtcg_tests_cross_cc_hppa=
=3D$2" ;;
> +    --tcg-tests-cross-cc-i386=3D*) quote_sh "-Dtcg_tests_cross_cc_i386=
=3D$2" ;;
> +    --tcg-tests-cross-cc-loongarch64=3D*) quote_sh "-Dtcg_tests_cross_cc=
_loongarch64=3D$2" ;;
> +    --tcg-tests-cross-cc-m68k=3D*) quote_sh "-Dtcg_tests_cross_cc_m68k=
=3D$2" ;;
> +    --tcg-tests-cross-cc-mips=3D*) quote_sh "-Dtcg_tests_cross_cc_mips=
=3D$2" ;;
> +    --tcg-tests-cross-cc-mips64=3D*) quote_sh "-Dtcg_tests_cross_cc_mips=
64=3D$2" ;;
> +    --tcg-tests-cross-cc-mips64el=3D*) quote_sh "-Dtcg_tests_cross_cc_mi=
ps64el=3D$2" ;;
> +    --tcg-tests-cross-cc-or1k=3D*) quote_sh "-Dtcg_tests_cross_cc_or1k=
=3D$2" ;;
> +    --tcg-tests-cross-cc-ppc64=3D*) quote_sh "-Dtcg_tests_cross_cc_ppc64=
=3D$2" ;;
> +    --tcg-tests-cross-cc-ppc64le=3D*) quote_sh "-Dtcg_tests_cross_cc_ppc=
64le=3D$2" ;;
> +    --tcg-tests-cross-cc-riscv64=3D*) quote_sh "-Dtcg_tests_cross_cc_ris=
cv64=3D$2" ;;
> +    --tcg-tests-cross-cc-s390x=3D*) quote_sh "-Dtcg_tests_cross_cc_s390x=
=3D$2" ;;
> +    --tcg-tests-cross-cc-sh4=3D*) quote_sh "-Dtcg_tests_cross_cc_sh4=3D$=
2" ;;
> +    --tcg-tests-cross-cc-tricore=3D*) quote_sh "-Dtcg_tests_cross_cc_tri=
core=3D$2" ;;
> +    --tcg-tests-cross-cc-x86-64=3D*) quote_sh "-Dtcg_tests_cross_cc_x86_=
64=3D$2" ;;
> +    --tcg-tests-cross-cc-xtensa=3D*) quote_sh "-Dtcg_tests_cross_cc_xten=
sa=3D$2" ;;
> +    --tcg-tests-cross-cc-xtensaeb=3D*) quote_sh "-Dtcg_tests_cross_cc_xt=
ensaeb=3D$2" ;;
> +    --tcg-tests-cross-cflags-aarch64=3D*) quote_sh "-Dtcg_tests_cross_cf=
lags_aarch64=3D$2" ;;
> +    --tcg-tests-cross-cflags-aarch64-be=3D*) quote_sh "-Dtcg_tests_cross=
_cflags_aarch64_be=3D$2" ;;
> +    --tcg-tests-cross-cflags-alpha=3D*) quote_sh "-Dtcg_tests_cross_cfla=
gs_alpha=3D$2" ;;
> +    --tcg-tests-cross-cflags-arm=3D*) quote_sh "-Dtcg_tests_cross_cflags=
_arm=3D$2" ;;
> +    --tcg-tests-cross-cflags-hexagon=3D*) quote_sh "-Dtcg_tests_cross_cf=
lags_hexagon=3D$2" ;;
> +    --tcg-tests-cross-cflags-hppa=3D*) quote_sh "-Dtcg_tests_cross_cflag=
s_hppa=3D$2" ;;
> +    --tcg-tests-cross-cflags-i386=3D*) quote_sh "-Dtcg_tests_cross_cflag=
s_i386=3D$2" ;;
> +    --tcg-tests-cross-cflags-loongarch64=3D*) quote_sh "-Dtcg_tests_cros=
s_cflags_loongarch64=3D$2" ;;
> +    --tcg-tests-cross-cflags-m68k=3D*) quote_sh "-Dtcg_tests_cross_cflag=
s_m68k=3D$2" ;;
> +    --tcg-tests-cross-cflags-mips=3D*) quote_sh "-Dtcg_tests_cross_cflag=
s_mips=3D$2" ;;
> +    --tcg-tests-cross-cflags-mips64=3D*) quote_sh "-Dtcg_tests_cross_cfl=
ags_mips64=3D$2" ;;
> +    --tcg-tests-cross-cflags-mips64el=3D*) quote_sh "-Dtcg_tests_cross_c=
flags_mips64el=3D$2" ;;
> +    --tcg-tests-cross-cflags-or1k=3D*) quote_sh "-Dtcg_tests_cross_cflag=
s_or1k=3D$2" ;;
> +    --tcg-tests-cross-cflags-ppc64=3D*) quote_sh "-Dtcg_tests_cross_cfla=
gs_ppc64=3D$2" ;;
> +    --tcg-tests-cross-cflags-ppc64le=3D*) quote_sh "-Dtcg_tests_cross_cf=
lags_ppc64le=3D$2" ;;
> +    --tcg-tests-cross-cflags-riscv64=3D*) quote_sh "-Dtcg_tests_cross_cf=
lags_riscv64=3D$2" ;;
> +    --tcg-tests-cross-cflags-s390x=3D*) quote_sh "-Dtcg_tests_cross_cfla=
gs_s390x=3D$2" ;;
> +    --tcg-tests-cross-cflags-sh4=3D*) quote_sh "-Dtcg_tests_cross_cflags=
_sh4=3D$2" ;;
> +    --tcg-tests-cross-cflags-tricore=3D*) quote_sh "-Dtcg_tests_cross_cf=
lags_tricore=3D$2" ;;
> +    --tcg-tests-cross-cflags-x86-64=3D*) quote_sh "-Dtcg_tests_cross_cfl=
ags_x86_64=3D$2" ;;
> +    --tcg-tests-cross-cflags-xtensa=3D*) quote_sh "-Dtcg_tests_cross_cfl=
ags_xtensa=3D$2" ;;
> +    --tcg-tests-cross-cflags-xtensaeb=3D*) quote_sh "-Dtcg_tests_cross_c=
flags_xtensaeb=3D$2" ;;
>      --tls-priority=3D*) quote_sh "-Dtls_priority=3D$2" ;;
>      --enable-tools) printf "%s" -Dtools=3Denabled ;;
>      --disable-tools) printf "%s" -Dtools=3Ddisabled ;;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

