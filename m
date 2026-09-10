Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99ACC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oaM-0004ls-DZ; Thu, 10 Sep 2026 19:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4n4u-0003W4-RQ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 18:17:14 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4n4r-0004qS-Sc
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 18:17:08 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so1553795e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789078623; x=1789683423; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4J3Q9psQA5aXO9idDePlIthqcvOsCf7HP12XT335C94=;
 b=t2rrn/L9O2ConpRSxOGwaE03j2kX+5iZiAlt1Yf+6bLeZcMPZ1pOUlYZ/hNArPkLiB
 KF1laZ60v/vLzutGDFgp6Vi7j+zcSWKAFNPZ0YB/clhV+MfXJ17bTkuvAdZR68u9F9FG
 THhNUiUAbRgzXQ3IHBHCrnkjawdL3QbffEGMRBq126pWmLXKH5w2+bYCHM9hrI3piyvT
 43b75qgL/nAcab3t7T2s0hRAwLdpEI7jCQbp3y8tAk/HNIJIko2I+l3ITTLYXIaZQAmS
 cvpMvacomN9Ur/EWSU0jGpNdHdXZJyZ8zAHl+2veaV5m4sYARmTo2GeE2TWo3zIWr9sE
 UhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789078623; x=1789683423;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4J3Q9psQA5aXO9idDePlIthqcvOsCf7HP12XT335C94=;
 b=nCebh5CJ4KvxqTZ4uxlMntO2c1jHLZYBXgcpVxCMzXeJ2prpnPorHjXMAP8vJR8evJ
 2laj5t9gg1qUFRJ3BXFinhn//IwTI9DcDNN/dDKn87g6fhb+f+zeoqGfoIfoGk55SLy1
 TkvbT9Vx9CPxjx18LOHkD5j4Hl7wNSIJcvCfWlYFIayt0cQHX/AbH3ORVN5EUk84frK5
 ZYqAsusepCzO19+bzKQXfPhhkk7iObCt9QBe+LWtGyo5MwLjXpJqRonNRoyHB33LPJda
 /woy4xHl8ny81VaciKzKXozx5D/f6FbGv759Vawv0plyrmDvKOXlJ72VoH3I0Spu2dAe
 EMww==
X-Gm-Message-State: AFuF++n3rvrOeQ3JBqHSbl/pqvqzdZkORrkxn/UA5yHVw/hOwS15pK97
 dBYshdNY8O7aVKdtd7lXHZozijRlaRln6ynGfx8e+4iVwoixmMKvwh5F1Zsw4pUanbXKEsPPMM0
 gFG7QD+E=
X-Gm-Gg: AYBFou3uxOu+UdseEIc0Xb3M/Ks8hmudCLk+m+blTeRgGDCKv1aU7ukhbSF0m97YV4F
 UvuXoRCVU1c3+2HxuIMVbQa2GfOIfuqK2DrKoCZkt2vbHRYPqv11GNEMCXLymEYbtUkkJMHy2YI
 ldLznZqIZvujApQV8upJ6WtW9PXcew3sVF+jreolqN8IX3EK6xfOfwNLl2TsAfkO+Wr732LbwzZ
 UTE7xTMpV/gyAzqHr5d9HUAZeVvM43LB89rKTqr5aKA3qwi3wSo0mY4e4js40lo7Hwru9sLPb6l
 QJmVo2eCy9HkN2H8Yv4zTlFQCqB0o+EhDCmeBn94qaNiA4YwArlb6u8UN6C+4fUqjaFiCts+/Cz
 bYeos5KWoL/aygDIP7ifs7MvrGFYxKfNRwx2M+bO45GISJJrOlsRj16vU36gvRESwDMuKMpPWg5
 tznfTZXDvdutgFmNOGG1ApD9f39YAtn6MXLIguuzFEe8xE1XMuuchEOFN1XBIwlZF/j67pyE4=
X-Received: by 2002:a05:600c:3ba9:b0:49c:fa21:e73e with SMTP id
 5b1f17b1804b1-49e619c0558mr13581515e9.20.1789078622617; 
 Thu, 10 Sep 2026 15:17:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32d3c7sm1299263f8f.10.2026.09.10.15.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 15:17:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 282EA5F834;
 Thu, 10 Sep 2026 23:17:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Brad Smith <brad@comstyle.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Song Gao <gaosong@loongson.cn>,  Warner Losh
 <imp@bsdimp.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  John Snow
 <jsnow@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Thomas Huth
 <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  qemu-arm@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Kyle
 Evans
 <kevans@freebsd.org>,  Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 1/9] scripts/meson-buildoptions.sh: update missing options
In-Reply-To: <87jyosub4v.fsf@suse.de> (Fabiano Rosas's message of "Thu, 10 Sep
 2026 17:03:44 -0300")
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-2-alex.bennee@linaro.org>
 <87jyosub4v.fsf@suse.de>
User-Agent: mu4e 1.14.4-pre2; emacs 30.1
Date: Thu, 10 Sep 2026 23:17:01 +0100
Message-ID: <87qzj092g2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

Fabiano Rosas <farosas@suse.de> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> This should have been updated when the meson check-tcg changes where
>> made. Include it now.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> There's this previous change by Daniel doing this already:
>
> https://lore.kernel.org/r/20260908074016.2143292-1-berrange@redhat.com

I've grabbed that (and noticed this update has extra bits from later in it)
>
>> ---
>>  scripts/meson-buildoptions.sh | 142 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 142 insertions(+)
>>
>> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.=
sh
>> index 5a67e59a167..67c5e33b011 100644
>> --- a/scripts/meson-buildoptions.sh
>> +++ b/scripts/meson-buildoptions.sh
>> @@ -10,7 +10,13 @@ meson_options_help() {
>>    printf "%s\n" '  --block-drv-rw-whitelist=3DVALUE'
>>    printf "%s\n" '                           set block driver read-write=
 whitelist (by default'
>>    printf "%s\n" '                           affects only QEMU, not tool=
s like qemu-img)'
>> +  printf "%s\n" '  --container-command=3DVALUE'
>> +  printf "%s\n" '                           command to build/run contai=
ners'
>> +  printf "%s\n" '  --container-registry=3DVALUE'
>> +  printf "%s\n" '                           container registry to cache=
 from'
>> +  printf "%s\n" '                           [registry.gitlab.com/qemu-p=
roject/qemu]'
>>    printf "%s\n" '  --datadir=3DVALUE          Data file directory [shar=
e]'
>> +  printf "%s\n" '  --disable-containers     use containers to cross com=
pile tcg tests'
>>    printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better =
performance)'
>>    printf "%s\n" '  --disable-debug-info     Enable debug symbols and ot=
her information'
>>    printf "%s\n" '  --disable-hexagon-idef-parser'
>> @@ -77,6 +83,94 @@ meson_options_help() {
>>    printf "%s\n" '  --rtsig-map=3DVALUE        default value of QEMU_RTS=
IG_MAP [NULL]'
>>    printf "%s\n" '  --smbd=3DVALUE             Path to smbd for slirp ne=
tworking'
>>    printf "%s\n" '  --sysconfdir=3DVALUE       Sysconf data directory [e=
tc]'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-aarch64=3DVALUE'
>> +  printf "%s\n" '                           cc for aarch64 tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-aarch64-be=3DVALUE'
>> +  printf "%s\n" '                           cc for aarch64_be tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-alpha=3DVALUE'
>> +  printf "%s\n" '                           cc for alpha tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-arm=3DVALUE'
>> +  printf "%s\n" '                           cc for arm tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-hexagon=3DVALUE'
>> +  printf "%s\n" '                           cc for hexagon tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-hppa=3DVALUE'
>> +  printf "%s\n" '                           cc for hppa tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-i386=3DVALUE'
>> +  printf "%s\n" '                           cc for i386 tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-loongarch64=3DVALUE'
>> +  printf "%s\n" '                           cc for loongarch64 tcg test=
s'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-m68k=3DVALUE'
>> +  printf "%s\n" '                           cc for m68k tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-mips=3DVALUE'
>> +  printf "%s\n" '                           cc for mips tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-mips64=3DVALUE'
>> +  printf "%s\n" '                           cc for mips64 tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-mips64el=3DVALUE'
>> +  printf "%s\n" '                           cc for mips64el tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-or1k=3DVALUE'
>> +  printf "%s\n" '                           cc for or1k tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-ppc64=3DVALUE'
>> +  printf "%s\n" '                           cc for ppc64 tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-ppc64le=3DVALUE'
>> +  printf "%s\n" '                           cc for ppc64le tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-riscv64=3DVALUE'
>> +  printf "%s\n" '                           cc for riscv64 tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-s390x=3DVALUE'
>> +  printf "%s\n" '                           cc for s390x tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-sh4=3DVALUE'
>> +  printf "%s\n" '                           cc for sh4 tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-tricore=3DVALUE'
>> +  printf "%s\n" '                           cc for tricore tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-x86-64=3DVALUE'
>> +  printf "%s\n" '                           cc for x86_64 tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-xtensa=3DVALUE'
>> +  printf "%s\n" '                           cc for xtensa tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cc-xtensaeb=3DVALUE'
>> +  printf "%s\n" '                           cc for xtensaeb tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-aarch64=3DVALUE'
>> +  printf "%s\n" '                           cflags for aarch64 tcg test=
s'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-aarch64-be=3DVALUE'
>> +  printf "%s\n" '                           cflags for aarch64_be tcg t=
ests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-alpha=3DVALUE'
>> +  printf "%s\n" '                           cflags for alpha tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-arm=3DVALUE'
>> +  printf "%s\n" '                           cflags for arm tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-hexagon=3DVALUE'
>> +  printf "%s\n" '                           cflags for hexagon tcg test=
s'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-hppa=3DVALUE'
>> +  printf "%s\n" '                           cflags for hppa tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-i386=3DVALUE'
>> +  printf "%s\n" '                           cflags for i386 tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-loongarch64=3DVALUE'
>> +  printf "%s\n" '                           cflags for loongarch64 tcg =
tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-m68k=3DVALUE'
>> +  printf "%s\n" '                           cflags for m68k tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-mips=3DVALUE'
>> +  printf "%s\n" '                           cflags for mips tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-mips64=3DVALUE'
>> +  printf "%s\n" '                           cflags for mips64 tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-mips64el=3DVALUE'
>> +  printf "%s\n" '                           cflags for mips64el tcg tes=
ts'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-or1k=3DVALUE'
>> +  printf "%s\n" '                           cflags for or1k tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-ppc64=3DVALUE'
>> +  printf "%s\n" '                           cflags for ppc64 tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-ppc64le=3DVALUE'
>> +  printf "%s\n" '                           cflags for ppc64le tcg test=
s'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-riscv64=3DVALUE'
>> +  printf "%s\n" '                           cflags for riscv64 tcg test=
s'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-s390x=3DVALUE'
>> +  printf "%s\n" '                           cflags for s390x tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-sh4=3DVALUE'
>> +  printf "%s\n" '                           cflags for sh4 tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-tricore=3DVALUE'
>> +  printf "%s\n" '                           cflags for tricore tcg test=
s'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-x86-64=3DVALUE'
>> +  printf "%s\n" '                           cflags for x86_64 tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-xtensa=3DVALUE'
>> +  printf "%s\n" '                           cflags for xtensa tcg tests'
>> +  printf "%s\n" '  --tcg-tests-cross-cflags-xtensaeb=3DVALUE'
>> +  printf "%s\n" '                           cflags for xtensaeb tcg tes=
ts'
>>    printf "%s\n" '  --tls-priority=3DVALUE     Default TLS protocol/ciph=
er priority string'
>>    printf "%s\n" '                           [NORMAL]'
>>    printf "%s\n" '  --with-coroutine=3DCHOICE  coroutine backend to use =
(choices:'
>> @@ -281,6 +375,10 @@ _meson_option_parse() {
>>      --disable-cocoa) printf "%s" -Dcocoa=3Ddisabled ;;
>>      --enable-colo-proxy) printf "%s" -Dcolo_proxy=3Denabled ;;
>>      --disable-colo-proxy) printf "%s" -Dcolo_proxy=3Ddisabled ;;
>> +    --container-command=3D*) quote_sh "-Dcontainer_command=3D$2" ;;
>> +    --container-registry=3D*) quote_sh "-Dcontainer_registry=3D$2" ;;
>> +    --enable-containers) printf "%s" -Dcontainers=3Dtrue ;;
>> +    --disable-containers) printf "%s" -Dcontainers=3Dfalse ;;
>>      --enable-coreaudio) printf "%s" -Dcoreaudio=3Denabled ;;
>>      --disable-coreaudio) printf "%s" -Dcoreaudio=3Ddisabled ;;
>>      --with-coroutine=3D*) quote_sh "-Dcoroutine_backend=3D$2" ;;
>> @@ -517,6 +615,50 @@ _meson_option_parse() {
>>      --disable-tcg) printf "%s" -Dtcg=3Ddisabled ;;
>>      --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=3Dtrue ;;
>>      --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=3Dfalse ;;
>> +    --tcg-tests-cross-cc-aarch64=3D*) quote_sh "-Dtcg_tests_cross_cc_aa=
rch64=3D$2" ;;
>> +    --tcg-tests-cross-cc-aarch64-be=3D*) quote_sh "-Dtcg_tests_cross_cc=
_aarch64_be=3D$2" ;;
>> +    --tcg-tests-cross-cc-alpha=3D*) quote_sh "-Dtcg_tests_cross_cc_alph=
a=3D$2" ;;
>> +    --tcg-tests-cross-cc-arm=3D*) quote_sh "-Dtcg_tests_cross_cc_arm=3D=
$2" ;;
>> +    --tcg-tests-cross-cc-hexagon=3D*) quote_sh "-Dtcg_tests_cross_cc_he=
xagon=3D$2" ;;
>> +    --tcg-tests-cross-cc-hppa=3D*) quote_sh "-Dtcg_tests_cross_cc_hppa=
=3D$2" ;;
>> +    --tcg-tests-cross-cc-i386=3D*) quote_sh "-Dtcg_tests_cross_cc_i386=
=3D$2" ;;
>> +    --tcg-tests-cross-cc-loongarch64=3D*) quote_sh "-Dtcg_tests_cross_c=
c_loongarch64=3D$2" ;;
>> +    --tcg-tests-cross-cc-m68k=3D*) quote_sh "-Dtcg_tests_cross_cc_m68k=
=3D$2" ;;
>> +    --tcg-tests-cross-cc-mips=3D*) quote_sh "-Dtcg_tests_cross_cc_mips=
=3D$2" ;;
>> +    --tcg-tests-cross-cc-mips64=3D*) quote_sh "-Dtcg_tests_cross_cc_mip=
s64=3D$2" ;;
>> +    --tcg-tests-cross-cc-mips64el=3D*) quote_sh "-Dtcg_tests_cross_cc_m=
ips64el=3D$2" ;;
>> +    --tcg-tests-cross-cc-or1k=3D*) quote_sh "-Dtcg_tests_cross_cc_or1k=
=3D$2" ;;
>> +    --tcg-tests-cross-cc-ppc64=3D*) quote_sh "-Dtcg_tests_cross_cc_ppc6=
4=3D$2" ;;
>> +    --tcg-tests-cross-cc-ppc64le=3D*) quote_sh "-Dtcg_tests_cross_cc_pp=
c64le=3D$2" ;;
>> +    --tcg-tests-cross-cc-riscv64=3D*) quote_sh "-Dtcg_tests_cross_cc_ri=
scv64=3D$2" ;;
>> +    --tcg-tests-cross-cc-s390x=3D*) quote_sh "-Dtcg_tests_cross_cc_s390=
x=3D$2" ;;
>> +    --tcg-tests-cross-cc-sh4=3D*) quote_sh "-Dtcg_tests_cross_cc_sh4=3D=
$2" ;;
>> +    --tcg-tests-cross-cc-tricore=3D*) quote_sh "-Dtcg_tests_cross_cc_tr=
icore=3D$2" ;;
>> +    --tcg-tests-cross-cc-x86-64=3D*) quote_sh "-Dtcg_tests_cross_cc_x86=
_64=3D$2" ;;
>> +    --tcg-tests-cross-cc-xtensa=3D*) quote_sh "-Dtcg_tests_cross_cc_xte=
nsa=3D$2" ;;
>> +    --tcg-tests-cross-cc-xtensaeb=3D*) quote_sh "-Dtcg_tests_cross_cc_x=
tensaeb=3D$2" ;;
>> +    --tcg-tests-cross-cflags-aarch64=3D*) quote_sh "-Dtcg_tests_cross_c=
flags_aarch64=3D$2" ;;
>> +    --tcg-tests-cross-cflags-aarch64-be=3D*) quote_sh "-Dtcg_tests_cros=
s_cflags_aarch64_be=3D$2" ;;
>> +    --tcg-tests-cross-cflags-alpha=3D*) quote_sh "-Dtcg_tests_cross_cfl=
ags_alpha=3D$2" ;;
>> +    --tcg-tests-cross-cflags-arm=3D*) quote_sh "-Dtcg_tests_cross_cflag=
s_arm=3D$2" ;;
>> +    --tcg-tests-cross-cflags-hexagon=3D*) quote_sh "-Dtcg_tests_cross_c=
flags_hexagon=3D$2" ;;
>> +    --tcg-tests-cross-cflags-hppa=3D*) quote_sh "-Dtcg_tests_cross_cfla=
gs_hppa=3D$2" ;;
>> +    --tcg-tests-cross-cflags-i386=3D*) quote_sh "-Dtcg_tests_cross_cfla=
gs_i386=3D$2" ;;
>> +    --tcg-tests-cross-cflags-loongarch64=3D*) quote_sh "-Dtcg_tests_cro=
ss_cflags_loongarch64=3D$2" ;;
>> +    --tcg-tests-cross-cflags-m68k=3D*) quote_sh "-Dtcg_tests_cross_cfla=
gs_m68k=3D$2" ;;
>> +    --tcg-tests-cross-cflags-mips=3D*) quote_sh "-Dtcg_tests_cross_cfla=
gs_mips=3D$2" ;;
>> +    --tcg-tests-cross-cflags-mips64=3D*) quote_sh "-Dtcg_tests_cross_cf=
lags_mips64=3D$2" ;;
>> +    --tcg-tests-cross-cflags-mips64el=3D*) quote_sh "-Dtcg_tests_cross_=
cflags_mips64el=3D$2" ;;
>> +    --tcg-tests-cross-cflags-or1k=3D*) quote_sh "-Dtcg_tests_cross_cfla=
gs_or1k=3D$2" ;;
>> +    --tcg-tests-cross-cflags-ppc64=3D*) quote_sh "-Dtcg_tests_cross_cfl=
ags_ppc64=3D$2" ;;
>> +    --tcg-tests-cross-cflags-ppc64le=3D*) quote_sh "-Dtcg_tests_cross_c=
flags_ppc64le=3D$2" ;;
>> +    --tcg-tests-cross-cflags-riscv64=3D*) quote_sh "-Dtcg_tests_cross_c=
flags_riscv64=3D$2" ;;
>> +    --tcg-tests-cross-cflags-s390x=3D*) quote_sh "-Dtcg_tests_cross_cfl=
ags_s390x=3D$2" ;;
>> +    --tcg-tests-cross-cflags-sh4=3D*) quote_sh "-Dtcg_tests_cross_cflag=
s_sh4=3D$2" ;;
>> +    --tcg-tests-cross-cflags-tricore=3D*) quote_sh "-Dtcg_tests_cross_c=
flags_tricore=3D$2" ;;
>> +    --tcg-tests-cross-cflags-x86-64=3D*) quote_sh "-Dtcg_tests_cross_cf=
lags_x86_64=3D$2" ;;
>> +    --tcg-tests-cross-cflags-xtensa=3D*) quote_sh "-Dtcg_tests_cross_cf=
lags_xtensa=3D$2" ;;
>> +    --tcg-tests-cross-cflags-xtensaeb=3D*) quote_sh "-Dtcg_tests_cross_=
cflags_xtensaeb=3D$2" ;;
>>      --tls-priority=3D*) quote_sh "-Dtls_priority=3D$2" ;;
>>      --enable-tools) printf "%s" -Dtools=3Denabled ;;
>>      --disable-tools) printf "%s" -Dtools=3Ddisabled ;;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

