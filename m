Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2E2C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x63qG-0000iF-K5; Mon, 14 Sep 2026 06:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x63q9-0000ho-KU
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 06:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x63px-0004CD-Mu
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 06:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789381374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=69lofhhw4X032a8ReFn3EkjdT8UDSxqyhKGc/UOcu70=;
 b=RY1Zms8jv5c6Sxwxkjc0K7/0r+/+vcfZ6oW/fGGvyhORXfNj4dHcJVNdo6to7PDfXwJ8Qy
 d3lnwMkMgkjEgDw59HGltVq2wbBHr4r+X49wJohVaNqTdvAcEWaHAPVR8pTQ3CxEToymW2
 bA0Fgn2saH58Q9qM1RIWbyq8Ww0ACKo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-0hiIF5eAPgy5AH3T8YgMQw-1; Mon, 14 Sep 2026 06:22:51 -0400
X-MC-Unique: 0hiIF5eAPgy5AH3T8YgMQw-1
X-Mimecast-MFC-AGG-ID: 0hiIF5eAPgy5AH3T8YgMQw_1789381370
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cced8309bso28735795e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 03:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789381370; cv=none;
 d=google.com; s=arc-20260327;
 b=Ema4ktlaGrGafa79eHemwGFodYpZH5lI8SKZtp4fCPrcOnHe29o8ripWNWgeWOXI+0
 Gb+t0n/RvhKAsRyhb22/MNJYIJim1h8j4UH7eDwIYuvHRoeZ/OJYZV75KtG0l9T1ywJD
 Z7ZF3mzXSusDE1SwBUR+Z9YPrjCajxSruxAGrsXgx/PcxzMXit6FYktfD9UDjYSmacdO
 Fg+cFPK8xICS6aKxZO6m7qiK+i7Yf8dB6ClXbAYbAm8SbZBf5hmmrH2/eR6EH60U7xo1
 Eag6lrNk2Uzl4f6BhBMZAFtTZ7yG5dJUjIGBeVcEmt97GhnR9d/b/IdTG/2rpkhTX4D8
 SfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=69lofhhw4X032a8ReFn3EkjdT8UDSxqyhKGc/UOcu70=;
 fh=MNAypxE+DyOxWAxZ4QJ75igWD2dtdSqEJqtgA55mPiI=;
 b=NPcdkMlmK2QtRdEcrlFu4xrlIaDiHpKalQIsxBm7UQ5uwwOJ/c3HCWxZ70N7j+90TN
 JslDygjmZ8xahr5r4ks5d5Fo7pRpfcS8iunxTTHsy8bX34mK8eScuElDrqqPu8pynjcQ
 78rWtoc7NCDA1lnZQRqKzkMQeCFUEk/J+1eapXF57C2zzWvL0Zd313RRsHrDoH3SV238
 ihXI+mBKvMwRgopmwdQCuVGZEo6fMS3jPtoa0UzKVxOer3TAzA/NeD200CZpNVrw5MjQ
 w0mv06+ioYgAjDRdW4kBDgAbBJT1jwXBna8kd+zoEzWXbLeHg8B7Y7GItZ2DfPan+Ivh
 NCaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789381370; x=1789986170; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=69lofhhw4X032a8ReFn3EkjdT8UDSxqyhKGc/UOcu70=;
 b=s22alitIy9THhFU+Sv0Ma1UCXYiPYtSE2kCvXZC81X0wY/UBu3WJaqVvF28tWllOo4
 dcN5JmTO2aMFBUic2/qr04ptSusXBjlnvv5ORpmQYdTuxo6NpVoRwp/EL1zL2ussrIOI
 PDAWkNWAgtUI0LRvZer8m3Yvr8DHysbHPnpRkBStQIbJLvmhGYq6FjmIXy8TiufRP+rR
 zVaNtAtIJcxYMVP8AiulvE8NYxvaULcXp+diaMyNsjYZ0oYJcFD1Kq5i2PwYB9x38ue4
 YNKF73wEmCTvz5PVHs3PLagHNITmOZHShljxRVCP98edXEoDDQbY2yEENAeoUr2XA8tf
 7nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789381370; x=1789986170;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=69lofhhw4X032a8ReFn3EkjdT8UDSxqyhKGc/UOcu70=;
 b=edqpqPPpXWLB3QC1X5/mgFQqBPT2SZ0ysaEGPwbeHAwDUM0SMgCx1R7V+8IWq05eYd
 HTLqXIoMbllALfRTw8JJra5nywUGj883KUXZHb2UIrJhCjzF/0LflnuFRUiZkN2U0qeW
 3PTAjc5Aa8YmRAm7KgY+DI7WfdkQnc0ZnSiakHnw9kTnb3TXPAESwCYObIKMDVSzy3GV
 Qo/au7aGdwEmQHKqt3E0JxLFBtqM0V09KkFNhKIUAKG+SHRaKpbpCEbs0B1PLnyHW/vU
 MMA9Bu/UIsAfOKPIrxsj/jkkurk5Z478rNcF/8Hp3c1tUHgO2uyVMt4a8lEu9QqXmg1J
 ESGA==
X-Gm-Message-State: AFuF++lsI9er1WQvWt9HtqQyJJ9ujieRxFgtTcnFV9rd5f2oyPbSYE7m
 d0Pghf9fnlNDhjPXDmsBW63C6mwHHwEKeG48J7DdB5detarTbjOUMfY2Ul6bjjAy33v68ON75C2
 9J1EuOVQjfTke+Hd2TqIFr5Pn7U3DTJ8Cd/ro0FDDTFQrdK5NzRxy3LTNtPB+cWtOT/ZWCvAvkR
 PntQuF9RH4g1oHowIJ4uFvBVyCQejfq9A=
X-Gm-Gg: AYBFou27O6rkIkRH91jO2gTuQsY9sXqa55rUAHN4jvVMQzgfseuTqFuZJy4T05rQDqp
 AKBWsz7uI58pIHYei9H/WKJgt0iR71MV8k7bHsMbjnpcib/afFb7wmOZTw8Rfjos/J+4lQyOZgg
 k3qusW2kAdOr5g7bQnnH8v9p0XTTacmTo5XhS+Bfi+yCkaFycRG3lGzhR1lf58IAPlXonHLqpWj
 S5JooFLntzNrgmd2Bee7tk2zSDrnRwwhgvVhCz5DkpyIpnFC9h+3zNg3WkCFQ==
X-Received: by 2002:a05:600c:8716:b0:49e:732e:6b79 with SMTP id
 5b1f17b1804b1-49e7a67dce4mr20064055e9.32.1789381370040; 
 Mon, 14 Sep 2026 03:22:50 -0700 (PDT)
X-Received: by 2002:a05:600c:8716:b0:49e:732e:6b79 with SMTP id
 5b1f17b1804b1-49e7a67dce4mr20063555e9.32.1789381369587; Mon, 14 Sep 2026
 03:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-2-alex.bennee@linaro.org>
In-Reply-To: <20260910181504.1010916-2-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 14 Sep 2026 12:22:37 +0200
X-Gm-Features: AcwNN1VYFP9XCryzJeDZQlxFlsiGWCeOJ70xwcHSkwFMIoOpDyh97aDRI-BEPrs
Message-ID: <CABgObfZmvkH9G7RMqN2CRFdepjVL1mF+eXRqD9iLPp4-6ctvig@mail.gmail.com>
Subject: Re: [PATCH 1/9] scripts/meson-buildoptions.sh: update missing options
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>, 
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Brian Cain <brian.cain@oss.qualcomm.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e6fe9e065b6ed00a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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

--000000000000e6fe9e065b6ed00a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 10 set 2026, 20:15 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scri=
tto:

> This should have been updated when the meson check-tcg changes where
> made. Include it now.
>

No, please revert the moving of containers out of configure.

Paolo


> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  scripts/meson-buildoptions.sh | 142 ++++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
>
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.s=
h
> index 5a67e59a167..67c5e33b011 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -10,7 +10,13 @@ meson_options_help() {
>    printf "%s\n" '  --block-drv-rw-whitelist=3DVALUE'
>    printf "%s\n" '                           set block driver read-write
> whitelist (by default'
>    printf "%s\n" '                           affects only QEMU, not tools
> like qemu-img)'
> +  printf "%s\n" '  --container-command=3DVALUE'
> +  printf "%s\n" '                           command to build/run
> containers'
> +  printf "%s\n" '  --container-registry=3DVALUE'
> +  printf "%s\n" '                           container registry to cache
> from'
> +  printf "%s\n" '                           [
> registry.gitlab.com/qemu-project/qemu]'
>    printf "%s\n" '  --datadir=3DVALUE          Data file directory [share=
]'
> +  printf "%s\n" '  --disable-containers     use containers to cross
> compile tcg tests'
>    printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better
> performance)'
>    printf "%s\n" '  --disable-debug-info     Enable debug symbols and
> other information'
>    printf "%s\n" '  --disable-hexagon-idef-parser'
> @@ -77,6 +83,94 @@ meson_options_help() {
>    printf "%s\n" '  --rtsig-map=3DVALUE        default value of
> QEMU_RTSIG_MAP [NULL]'
>    printf "%s\n" '  --smbd=3DVALUE             Path to smbd for slirp
> networking'
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
> +  printf "%s\n" '                           cflags for aarch64_be tcg
> tests'
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
> +  printf "%s\n" '                           cflags for loongarch64 tcg
> tests'
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
r
> priority string'
>    printf "%s\n" '                           [NORMAL]'
>    printf "%s\n" '  --with-coroutine=3DCHOICE  coroutine backend to use
> (choices:'
> @@ -281,6 +375,10 @@ _meson_option_parse() {
>      --disable-cocoa) printf "%s" -Dcocoa=3Ddisabled ;;
>      --enable-colo-proxy) printf "%s" -Dcolo_proxy=3Denabled ;;
>      --disable-colo-proxy) printf "%s" -Dcolo_proxy=3Ddisabled ;;
> +    --container-command=3D*) quote_sh "-Dcontainer_command=3D$2" ;;
> +    --container-registry=3D*) quote_sh "-Dcontainer_registry=3D$2" ;;
> +    --enable-containers) printf "%s" -Dcontainers=3Dtrue ;;
> +    --disable-containers) printf "%s" -Dcontainers=3Dfalse ;;
>      --enable-coreaudio) printf "%s" -Dcoreaudio=3Denabled ;;
>      --disable-coreaudio) printf "%s" -Dcoreaudio=3Ddisabled ;;
>      --with-coroutine=3D*) quote_sh "-Dcoroutine_backend=3D$2" ;;
> @@ -517,6 +615,50 @@ _meson_option_parse() {
>      --disable-tcg) printf "%s" -Dtcg=3Ddisabled ;;
>      --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=3Dtrue ;;
>      --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=3Dfalse ;;
> +    --tcg-tests-cross-cc-aarch64=3D*) quote_sh
> "-Dtcg_tests_cross_cc_aarch64=3D$2" ;;
> +    --tcg-tests-cross-cc-aarch64-be=3D*) quote_sh
> "-Dtcg_tests_cross_cc_aarch64_be=3D$2" ;;
> +    --tcg-tests-cross-cc-alpha=3D*) quote_sh
> "-Dtcg_tests_cross_cc_alpha=3D$2" ;;
> +    --tcg-tests-cross-cc-arm=3D*) quote_sh "-Dtcg_tests_cross_cc_arm=3D$=
2" ;;
> +    --tcg-tests-cross-cc-hexagon=3D*) quote_sh
> "-Dtcg_tests_cross_cc_hexagon=3D$2" ;;
> +    --tcg-tests-cross-cc-hppa=3D*) quote_sh "-Dtcg_tests_cross_cc_hppa=
=3D$2"
> ;;
> +    --tcg-tests-cross-cc-i386=3D*) quote_sh "-Dtcg_tests_cross_cc_i386=
=3D$2"
> ;;
> +    --tcg-tests-cross-cc-loongarch64=3D*) quote_sh
> "-Dtcg_tests_cross_cc_loongarch64=3D$2" ;;
> +    --tcg-tests-cross-cc-m68k=3D*) quote_sh "-Dtcg_tests_cross_cc_m68k=
=3D$2"
> ;;
> +    --tcg-tests-cross-cc-mips=3D*) quote_sh "-Dtcg_tests_cross_cc_mips=
=3D$2"
> ;;
> +    --tcg-tests-cross-cc-mips64=3D*) quote_sh
> "-Dtcg_tests_cross_cc_mips64=3D$2" ;;
> +    --tcg-tests-cross-cc-mips64el=3D*) quote_sh
> "-Dtcg_tests_cross_cc_mips64el=3D$2" ;;
> +    --tcg-tests-cross-cc-or1k=3D*) quote_sh "-Dtcg_tests_cross_cc_or1k=
=3D$2"
> ;;
> +    --tcg-tests-cross-cc-ppc64=3D*) quote_sh
> "-Dtcg_tests_cross_cc_ppc64=3D$2" ;;
> +    --tcg-tests-cross-cc-ppc64le=3D*) quote_sh
> "-Dtcg_tests_cross_cc_ppc64le=3D$2" ;;
> +    --tcg-tests-cross-cc-riscv64=3D*) quote_sh
> "-Dtcg_tests_cross_cc_riscv64=3D$2" ;;
> +    --tcg-tests-cross-cc-s390x=3D*) quote_sh
> "-Dtcg_tests_cross_cc_s390x=3D$2" ;;
> +    --tcg-tests-cross-cc-sh4=3D*) quote_sh "-Dtcg_tests_cross_cc_sh4=3D$=
2" ;;
> +    --tcg-tests-cross-cc-tricore=3D*) quote_sh
> "-Dtcg_tests_cross_cc_tricore=3D$2" ;;
> +    --tcg-tests-cross-cc-x86-64=3D*) quote_sh
> "-Dtcg_tests_cross_cc_x86_64=3D$2" ;;
> +    --tcg-tests-cross-cc-xtensa=3D*) quote_sh
> "-Dtcg_tests_cross_cc_xtensa=3D$2" ;;
> +    --tcg-tests-cross-cc-xtensaeb=3D*) quote_sh
> "-Dtcg_tests_cross_cc_xtensaeb=3D$2" ;;
> +    --tcg-tests-cross-cflags-aarch64=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_aarch64=3D$2" ;;
> +    --tcg-tests-cross-cflags-aarch64-be=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_aarch64_be=3D$2" ;;
> +    --tcg-tests-cross-cflags-alpha=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_alpha=3D$2" ;;
> +    --tcg-tests-cross-cflags-arm=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_arm=3D$2" ;;
> +    --tcg-tests-cross-cflags-hexagon=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_hexagon=3D$2" ;;
> +    --tcg-tests-cross-cflags-hppa=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_hppa=3D$2" ;;
> +    --tcg-tests-cross-cflags-i386=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_i386=3D$2" ;;
> +    --tcg-tests-cross-cflags-loongarch64=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_loongarch64=3D$2" ;;
> +    --tcg-tests-cross-cflags-m68k=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_m68k=3D$2" ;;
> +    --tcg-tests-cross-cflags-mips=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_mips=3D$2" ;;
> +    --tcg-tests-cross-cflags-mips64=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_mips64=3D$2" ;;
> +    --tcg-tests-cross-cflags-mips64el=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_mips64el=3D$2" ;;
> +    --tcg-tests-cross-cflags-or1k=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_or1k=3D$2" ;;
> +    --tcg-tests-cross-cflags-ppc64=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_ppc64=3D$2" ;;
> +    --tcg-tests-cross-cflags-ppc64le=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_ppc64le=3D$2" ;;
> +    --tcg-tests-cross-cflags-riscv64=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_riscv64=3D$2" ;;
> +    --tcg-tests-cross-cflags-s390x=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_s390x=3D$2" ;;
> +    --tcg-tests-cross-cflags-sh4=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_sh4=3D$2" ;;
> +    --tcg-tests-cross-cflags-tricore=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_tricore=3D$2" ;;
> +    --tcg-tests-cross-cflags-x86-64=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_x86_64=3D$2" ;;
> +    --tcg-tests-cross-cflags-xtensa=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_xtensa=3D$2" ;;
> +    --tcg-tests-cross-cflags-xtensaeb=3D*) quote_sh
> "-Dtcg_tests_cross_cflags_xtensaeb=3D$2" ;;
>      --tls-priority=3D*) quote_sh "-Dtls_priority=3D$2" ;;
>      --enable-tools) printf "%s" -Dtools=3Denabled ;;
>      --disable-tools) printf "%s" -Dtools=3Ddisabled ;;
> --
> 2.47.3
>
>

--000000000000e6fe9e065b6ed00a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 10 set 2026, 20:15 Alex B=
enn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro=
.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">This should have been updated when the meson check-tcg changes w=
here<br>
made. Include it now.<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">No, please revert the moving of containers out of conf=
igure.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gma=
il_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;<br>
---<br>
=C2=A0scripts/meson-buildoptions.sh | 142 +++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 142 insertions(+)<br>
<br>
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh<=
br>
index 5a67e59a167..67c5e33b011 100644<br>
--- a/scripts/meson-buildoptions.sh<br>
+++ b/scripts/meson-buildoptions.sh<br>
@@ -10,7 +10,13 @@ meson_options_help() {<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 --block-drv-rw-whitelist=
=3DVALUE&#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set block=
 driver read-write whitelist (by default&#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0affects o=
nly QEMU, not tools like qemu-img)&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --container-command=3DVALUE&#39=
;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command to build=
/run containers&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --container-registry=3DVALUE&#3=
9;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0container regist=
ry to cache from&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[<a href=3D"http=
://registry.gitlab.com/qemu-project/qemu" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">registry.gitlab.com/qemu-project/qemu</a>]&#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 --datadir=3DVALUE=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Data file directory [share]&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --disable-containers=C2=A0 =C2=
=A0 =C2=A0use containers to cross compile tcg tests&#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 --disable-coroutine-pool c=
oroutine freelist (better performance)&#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 --disable-debug-info=C2=A0=
 =C2=A0 =C2=A0Enable debug symbols and other information&#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 --disable-hexagon-idef-par=
ser&#39;<br>
@@ -77,6 +83,94 @@ meson_options_help() {<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 --rtsig-map=3DVALUE=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 default value of QEMU_RTSIG_MAP [NULL]&#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 --smbd=3DVALUE=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Path to smbd for slirp networking&#39=
;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 --sysconfdir=3DVALUE=C2=A0=
 =C2=A0 =C2=A0 =C2=A0Sysconf data directory [etc]&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-aarch64=3D=
VALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for aarch64 t=
cg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-aarch64-be=
=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for aarch64_b=
e tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-alpha=3DVA=
LUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for alpha tcg=
 tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-arm=3DVALU=
E&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for arm tcg t=
ests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-hexagon=3D=
VALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for hexagon t=
cg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-hppa=3DVAL=
UE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for hppa tcg =
tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-i386=3DVAL=
UE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for i386 tcg =
tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-loongarch6=
4=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for loongarch=
64 tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-m68k=3DVAL=
UE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for m68k tcg =
tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-mips=3DVAL=
UE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for mips tcg =
tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-mips64=3DV=
ALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for mips64 tc=
g tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-mips64el=
=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for mips64el =
tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-or1k=3DVAL=
UE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for or1k tcg =
tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-ppc64=3DVA=
LUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for ppc64 tcg=
 tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-ppc64le=3D=
VALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for ppc64le t=
cg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-riscv64=3D=
VALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for riscv64 t=
cg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-s390x=3DVA=
LUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for s390x tcg=
 tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-sh4=3DVALU=
E&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for sh4 tcg t=
ests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-tricore=3D=
VALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for tricore t=
cg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-x86-64=3DV=
ALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for x86_64 tc=
g tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-xtensa=3DV=
ALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for xtensa tc=
g tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cc-xtensaeb=
=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc for xtensaeb =
tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-aarch6=
4=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for aarch=
64 tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-aarch6=
4-be=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for aarch=
64_be tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-alpha=
=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for alpha=
 tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-arm=3D=
VALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for arm t=
cg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-hexago=
n=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for hexag=
on tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-hppa=
=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for hppa =
tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-i386=
=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for i386 =
tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-loonga=
rch64=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for loong=
arch64 tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-m68k=
=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for m68k =
tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-mips=
=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for mips =
tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-mips64=
=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for mips6=
4 tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-mips64=
el=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for mips6=
4el tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-or1k=
=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for or1k =
tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-ppc64=
=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for ppc64=
 tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-ppc64l=
e=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for ppc64=
le tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-riscv6=
4=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for riscv=
64 tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-s390x=
=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for s390x=
 tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-sh4=3D=
VALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for sh4 t=
cg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-tricor=
e=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for trico=
re tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-x86-64=
=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for x86_6=
4 tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-xtensa=
=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for xtens=
a tcg tests&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 --tcg-tests-cross-cflags-xtensa=
eb=3DVALUE&#39;<br>
+=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cflags for xtens=
aeb tcg tests&#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 --tls-priority=3DVALUE=C2=
=A0 =C2=A0 =C2=A0Default TLS protocol/cipher priority string&#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[NORMAL]&=
#39;<br>
=C2=A0 =C2=A0printf &quot;%s\n&quot; &#39;=C2=A0 --with-coroutine=3DCHOICE=
=C2=A0 coroutine backend to use (choices:&#39;<br>
@@ -281,6 +375,10 @@ _meson_option_parse() {<br>
=C2=A0 =C2=A0 =C2=A0--disable-cocoa) printf &quot;%s&quot; -Dcocoa=3Ddisabl=
ed ;;<br>
=C2=A0 =C2=A0 =C2=A0--enable-colo-proxy) printf &quot;%s&quot; -Dcolo_proxy=
=3Denabled ;;<br>
=C2=A0 =C2=A0 =C2=A0--disable-colo-proxy) printf &quot;%s&quot; -Dcolo_prox=
y=3Ddisabled ;;<br>
+=C2=A0 =C2=A0 --container-command=3D*) quote_sh &quot;-Dcontainer_command=
=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --container-registry=3D*) quote_sh &quot;-Dcontainer_registr=
y=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --enable-containers) printf &quot;%s&quot; -Dcontainers=3Dtr=
ue ;;<br>
+=C2=A0 =C2=A0 --disable-containers) printf &quot;%s&quot; -Dcontainers=3Df=
alse ;;<br>
=C2=A0 =C2=A0 =C2=A0--enable-coreaudio) printf &quot;%s&quot; -Dcoreaudio=
=3Denabled ;;<br>
=C2=A0 =C2=A0 =C2=A0--disable-coreaudio) printf &quot;%s&quot; -Dcoreaudio=
=3Ddisabled ;;<br>
=C2=A0 =C2=A0 =C2=A0--with-coroutine=3D*) quote_sh &quot;-Dcoroutine_backen=
d=3D$2&quot; ;;<br>
@@ -517,6 +615,50 @@ _meson_option_parse() {<br>
=C2=A0 =C2=A0 =C2=A0--disable-tcg) printf &quot;%s&quot; -Dtcg=3Ddisabled ;=
;<br>
=C2=A0 =C2=A0 =C2=A0--enable-tcg-interpreter) printf &quot;%s&quot; -Dtcg_i=
nterpreter=3Dtrue ;;<br>
=C2=A0 =C2=A0 =C2=A0--disable-tcg-interpreter) printf &quot;%s&quot; -Dtcg_=
interpreter=3Dfalse ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-aarch64=3D*) quote_sh &quot;-Dtcg_tests=
_cross_cc_aarch64=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-aarch64-be=3D*) quote_sh &quot;-Dtcg_te=
sts_cross_cc_aarch64_be=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-alpha=3D*) quote_sh &quot;-Dtcg_tests_c=
ross_cc_alpha=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-arm=3D*) quote_sh &quot;-Dtcg_tests_cro=
ss_cc_arm=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-hexagon=3D*) quote_sh &quot;-Dtcg_tests=
_cross_cc_hexagon=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-hppa=3D*) quote_sh &quot;-Dtcg_tests_cr=
oss_cc_hppa=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-i386=3D*) quote_sh &quot;-Dtcg_tests_cr=
oss_cc_i386=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-loongarch64=3D*) quote_sh &quot;-Dtcg_t=
ests_cross_cc_loongarch64=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-m68k=3D*) quote_sh &quot;-Dtcg_tests_cr=
oss_cc_m68k=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-mips=3D*) quote_sh &quot;-Dtcg_tests_cr=
oss_cc_mips=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-mips64=3D*) quote_sh &quot;-Dtcg_tests_=
cross_cc_mips64=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-mips64el=3D*) quote_sh &quot;-Dtcg_test=
s_cross_cc_mips64el=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-or1k=3D*) quote_sh &quot;-Dtcg_tests_cr=
oss_cc_or1k=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-ppc64=3D*) quote_sh &quot;-Dtcg_tests_c=
ross_cc_ppc64=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-ppc64le=3D*) quote_sh &quot;-Dtcg_tests=
_cross_cc_ppc64le=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-riscv64=3D*) quote_sh &quot;-Dtcg_tests=
_cross_cc_riscv64=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-s390x=3D*) quote_sh &quot;-Dtcg_tests_c=
ross_cc_s390x=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-sh4=3D*) quote_sh &quot;-Dtcg_tests_cro=
ss_cc_sh4=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-tricore=3D*) quote_sh &quot;-Dtcg_tests=
_cross_cc_tricore=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-x86-64=3D*) quote_sh &quot;-Dtcg_tests_=
cross_cc_x86_64=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-xtensa=3D*) quote_sh &quot;-Dtcg_tests_=
cross_cc_xtensa=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cc-xtensaeb=3D*) quote_sh &quot;-Dtcg_test=
s_cross_cc_xtensaeb=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-aarch64=3D*) quote_sh &quot;-Dtcg_t=
ests_cross_cflags_aarch64=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-aarch64-be=3D*) quote_sh &quot;-Dtc=
g_tests_cross_cflags_aarch64_be=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-alpha=3D*) quote_sh &quot;-Dtcg_tes=
ts_cross_cflags_alpha=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-arm=3D*) quote_sh &quot;-Dtcg_tests=
_cross_cflags_arm=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-hexagon=3D*) quote_sh &quot;-Dtcg_t=
ests_cross_cflags_hexagon=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-hppa=3D*) quote_sh &quot;-Dtcg_test=
s_cross_cflags_hppa=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-i386=3D*) quote_sh &quot;-Dtcg_test=
s_cross_cflags_i386=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-loongarch64=3D*) quote_sh &quot;-Dt=
cg_tests_cross_cflags_loongarch64=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-m68k=3D*) quote_sh &quot;-Dtcg_test=
s_cross_cflags_m68k=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-mips=3D*) quote_sh &quot;-Dtcg_test=
s_cross_cflags_mips=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-mips64=3D*) quote_sh &quot;-Dtcg_te=
sts_cross_cflags_mips64=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-mips64el=3D*) quote_sh &quot;-Dtcg_=
tests_cross_cflags_mips64el=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-or1k=3D*) quote_sh &quot;-Dtcg_test=
s_cross_cflags_or1k=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-ppc64=3D*) quote_sh &quot;-Dtcg_tes=
ts_cross_cflags_ppc64=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-ppc64le=3D*) quote_sh &quot;-Dtcg_t=
ests_cross_cflags_ppc64le=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-riscv64=3D*) quote_sh &quot;-Dtcg_t=
ests_cross_cflags_riscv64=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-s390x=3D*) quote_sh &quot;-Dtcg_tes=
ts_cross_cflags_s390x=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-sh4=3D*) quote_sh &quot;-Dtcg_tests=
_cross_cflags_sh4=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-tricore=3D*) quote_sh &quot;-Dtcg_t=
ests_cross_cflags_tricore=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-x86-64=3D*) quote_sh &quot;-Dtcg_te=
sts_cross_cflags_x86_64=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-xtensa=3D*) quote_sh &quot;-Dtcg_te=
sts_cross_cflags_xtensa=3D$2&quot; ;;<br>
+=C2=A0 =C2=A0 --tcg-tests-cross-cflags-xtensaeb=3D*) quote_sh &quot;-Dtcg_=
tests_cross_cflags_xtensaeb=3D$2&quot; ;;<br>
=C2=A0 =C2=A0 =C2=A0--tls-priority=3D*) quote_sh &quot;-Dtls_priority=3D$2&=
quot; ;;<br>
=C2=A0 =C2=A0 =C2=A0--enable-tools) printf &quot;%s&quot; -Dtools=3Denabled=
 ;;<br>
=C2=A0 =C2=A0 =C2=A0--disable-tools) printf &quot;%s&quot; -Dtools=3Ddisabl=
ed ;;<br>
-- <br>
2.47.3<br>
<br>
</blockquote></div></div></div>

--000000000000e6fe9e065b6ed00a--


