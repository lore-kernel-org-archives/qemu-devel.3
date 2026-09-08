Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BC1C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3qdY-0007Vt-E8; Tue, 08 Sep 2026 03:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3qdW-0007Vi-Sd
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:52:58 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3qdU-0002Bt-JE
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:52:58 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc149372c14so2060913a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 00:52:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788853970; cv=none;
 d=google.com; s=arc-20260327;
 b=SxkNXQqgTKTTvvmXbNtCraSHEk9uuyeUAQJTDzcjw6193loh2GclKMXx+3LoBL6uBU
 Mo/o34hy1cTCjn+vFbI1mJY7fnOqMzsTSClF39Bw81/+yDhWwGtnzend5VCH8IIxiima
 AOy5Zra9TnLluSfcEWryilnF0QZh223FPYcWvnb8NopDsdHo6H5efMIDmxP+GLB/8RXF
 ZULVVm5z/TN0GLPI7fWKQkFAXxbi8ZUS7bHpceDPi605cn1LZbz50sSNcz24RpyD7+HM
 krlOetVAuTuXv4k30ZfBHlCyfzb70EeTC96iOKnwizG5TtUkRh51DHQ69UNN5zjLc2Z/
 K4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wm6O4PqBk0NINGlhwEDq3Cyjn5LnB13dIOgrKhaxk3w=;
 fh=9nn+YFgC53vZ+VMZJMydBBV04JAGUMm3lN9pDyggxqQ=;
 b=VxkABqp32FPIScFXOhNViLbkXLczi5UjAYbJZO/DwevnSVJ39J0mq8+5JdF1rwHJwT
 mzcTlS2vkwYPqNfVBVeYuBEKN2FKMQrHcEAAV829F8sBhOx4pNUGbsDiHEDpQaN0Pb8a
 Pr8xG2h4POXGs2KJ397iUex4h9Eve/2xptj1tLngMxRK4KCxrVbbxLLv+eorP5C+HZeS
 JKC0oK8E1izWRHqNmeyJD3V14sOW9MqfZ0vksapFi6Bv7GCHVx/0MfqNPmp5UJb5C0Du
 WZZFswiBSNuIe3TVcQGqiTEt4yMgBgDAhVSExZ4hlVRshtsnkPkHu/dQBzXl2nsIr5mP
 ESpg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788853970; x=1789458770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wm6O4PqBk0NINGlhwEDq3Cyjn5LnB13dIOgrKhaxk3w=;
 b=GscI/PxRtj0S2BydvNRDUGabulWlj3q5E80eDSKgXXl0ix5rzYXxts1fZR12IK8zYJ
 I6QSX87Jyt4sPUfRHYJ3nsftZ8f0DcQmHT0gz0To/4f59gqmfJEMkD93I/aYOGmxkuea
 Jjyy8/KNlh0hPsGSvsvc8kW719on5opJhs1XHkNDcGHS2kmSqxcEiw4YRJ1oY3WaonW+
 QfQA6iHyXfeXeq0ntbPwWGTdDDFczSulZNEL2P116T7uMnP88XVuYnF9faeOYs5MiC6S
 ZspDhxijG/iDrj49QNapPpfcqrjsS+nxQgHXi4+x8R9A45M35hkLklIWX1WC9QzT5T3L
 2YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788853970; x=1789458770;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wm6O4PqBk0NINGlhwEDq3Cyjn5LnB13dIOgrKhaxk3w=;
 b=bXyqlhGpICev4vrZhpJMvtn3QoGyBaeVh9z56Z0wMQDFCmlTeIi1EhunMIOYF3maos
 6od9Nn59O24x9Q5ZTUIR5ZXE8ekojmKmAmEeNyyxnGOmbbMQDSLJuALbQRInqxD2SvLk
 VYpPegTDoDaKhuxvVipWT7WlFmjtC4HaS0cnFmvqjiINlOSUT4zoe1HE+XtO71km3zJq
 +gD5s8j2LfLkTqIJrbrE1v6TZZlFjSFVCoY8l32Iu4g0uOBAHCiZagCHd5ADXqDqK37x
 AFRCSYWokA3adBrPq4PBijAjcNLbrX/4wAVkTYi60+VIcVVswuitUTT6/JlvaWmGI+K/
 wV2g==
X-Gm-Message-State: AFuF++l5iDN0rOnxiX73cO/GU50KbkHLXik72uyeznERnVblZC80dp5p
 6jLKHEPbbwqsplltcJoGH814aMLCvKRLlscic295/7ysyU/XFxOAya7SEjj6kmboomH83WHO1u5
 SSG/B5z8ZLadTNmjryiNkY9uHWCLmhDg=
X-Gm-Gg: AYBFou1wQa5q2+5ZAtK0iKubGrDyvi7JuZsjmY8GrI+3LvvF6Hej/8j7ffirhLpu1UL
 IMl4cD4rLyB8v0oVB9OXIoeaDrK0+zH13PP9ttzCDjZ7dVHUPztTaEREydOxBA8SC05HhPdb/4Q
 dSVb+f2p0Y09PpK40EkdcmO2pE4cIMw/baFPBXMr1OvhyhCsEWeFeLMXUO572+Oyynb7vKjsOuH
 kJNAp+xlhjWazkqV4152C2D7LPpER7DSOJ+/VxdaiXXR9TPtM9UCAgkpeS23DYQ+Xx8wNWgBu+m
 aBi6jhH201TT5uac90XLWZYC5wlachOnWfbb0xbffAtyOeSvOWLGxlkqrBYaOHvtVSMFJAtSmLH
 1
X-Received: by 2002:a17:90b:2ccf:b0:398:a2a3:b631 with SMTP id
 98e67ed59e1d1-39b262aaf3dmr44095620a91.19.1788853969635; Tue, 08 Sep 2026
 00:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260908074016.2143292-1-berrange@redhat.com>
In-Reply-To: <20260908074016.2143292-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 8 Sep 2026 11:52:36 +0400
X-Gm-Features: AcwNN1WDTMx4-pFIlJdnCUKLH4RtlYfmDx6TEPHVORtegLgYyUQhEf1ilLGvmYw
Message-ID: <CAJ+F1C+ePMV0Zd7_YFsVMC31JnEopG0V9cwKJjCcqxfBUwkNRg@mail.gmail.com>
Subject: Re: [PATCH] meson: refresh build options script
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Sep 8, 2026 at 11:41=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> Recent changes added more meson options, but missed refreshing of
> the meson-buildoptions.sh file, causing it to frequently appear
> dirty when doing builds.
>
> Fixes: 7e1d54da6faf (tests/tcg/meson.build: implement ./configure -cross-=
cc-* options)
> Fixes: 522b299ca431 (tests/tcg/meson.build: implement ./configure contain=
ers options)
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

indeed,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  scripts/meson-buildoptions.sh | 138 ++++++++++++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
>
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.s=
h
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
> +  printf "%s\n" '                           cc for loongarch64 tcg tests=
'
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
> +  printf "%s\n" '                           cflags for aarch64 tcg tests=
'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-aarch64-be=3DVALUE'
> +  printf "%s\n" '                           cflags for aarch64_be tcg te=
sts'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-alpha=3DVALUE'
> +  printf "%s\n" '                           cflags for alpha tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-arm=3DVALUE'
> +  printf "%s\n" '                           cflags for arm tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-hexagon=3DVALUE'
> +  printf "%s\n" '                           cflags for hexagon tcg tests=
'
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
> +  printf "%s\n" '                           cflags for ppc64le tcg tests=
'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-riscv64=3DVALUE'
> +  printf "%s\n" '                           cflags for riscv64 tcg tests=
'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-s390x=3DVALUE'
> +  printf "%s\n" '                           cflags for s390x tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-sh4=3DVALUE'
> +  printf "%s\n" '                           cflags for sh4 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-tricore=3DVALUE'
> +  printf "%s\n" '                           cflags for tricore tcg tests=
'
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
> --
> 2.55.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

