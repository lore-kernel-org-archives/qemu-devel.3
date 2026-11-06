Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28179606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DxyMNB8K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPNQr-000798-Uc; Fri, 06 Nov 2026 12:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPNQm-00078W-Nc
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:08:48 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPNQk-00021G-QM
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:08:48 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b0db268bd8so6144537b3.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 09:08:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793984925; cv=none;
 d=google.com; s=arc-20260327;
 b=bANamFgm9tqLhI9pYwGqnB9st/I/IvabXnIaf0C0s2RaWQbLVriuF83kxoqCv64tPp
 b22F7qA6h2mJKn5bbaW9DaNsH767LnQBldSv3sV9d1MGqzytNDyPzWVfHQhxMZxTarMR
 iqdcrx7qZSiaw+5PzwugLThXpIbu+qzAyH6ky+eqaXK97w6I6XEyy9W5hjF8B7pAE42G
 2eKZSAv8VBrxuPBM2do/POx5kboIQpKe9l+oLXTTDh/7wfSfx6O6r0ViuxqGQD7kiV2q
 Cm5skPfAp8wH5bCM52LQGKWFmgfOfp0QegsciegrAXezdsl6w5/qHy7vP5Bjfe3xxDBp
 XLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OO8Ac8DJWpsrwJd268MEQU23+7uGcwRK+DZ60CP1NWE=;
 fh=evYu65HJqNwMd16sFKkvgyTnNtakHsnIGR2/vsBd+ww=;
 b=IKMh6Pj6/8B5bW0zh3PGFLdQF5/L9o3sB+w5cTmW+NtxVaZVxCjnewuC8skoEayXkR
 lrU/XaYoOSd3Hryddz3YEupKudn4ttOjnz+pC1eKmad/TrpCoppBOQeg6fxTi5xQNogP
 SsGMA54yFwNue5HUCOgnOOjNtU3ZrlYwBBeTV/8ndeIIAmZUJvthIlUyZfsspHqV/hhn
 Nsyawewv5TwLyotwiJagmQsLKIHJ55UgEENLfryj6ljAiu9EAw2piBvWkjxfJAtkTjp0
 JJqKG4mb5sp9tsVEYlB+LRm4kt/4S1uwzBZoi3R0jey1B1+DeUFfZS3Xz+7EhNTA95Rl
 IRAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793984925; x=1794589725; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OO8Ac8DJWpsrwJd268MEQU23+7uGcwRK+DZ60CP1NWE=;
 b=DxyMNB8K96fHJB2Pmv6ZQ7Zc11YGAybaqrTxgvEuxcMZuykocvzAV8gh0OMFSlb6f8
 vYm8Kl7nGo2BaMGUf5pEElB3jyBbUZGGw6TxyLYZnp4R7xzes/wZtTdl+bY0LSFZDjpG
 Y0nI/tEyXmTAZn/VlWSDaeQGowjKBNie84SsWSaEoYBi+MPvB2jq+imnFTc84qCinn0w
 HBqQvCZ4tgV1jYqCPKJq4rtA2Q+Hs/0aRcAEZyhWjqkJZY7TTtz7KWf/pJTjkfEUAJUT
 Drn8KxYEtm3WH5I1I65SwCTNvdcLHHknVjfrDAV9UPtFU7l5ezI8AuHxGcx89q5bQd48
 darw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793984925; x=1794589725;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OO8Ac8DJWpsrwJd268MEQU23+7uGcwRK+DZ60CP1NWE=;
 b=XgFxG9inJ7Ygor97n8GdkhM4qO+25OA6hsFlfuomxyMJZ6+bUIGQ0b3EPszEeg8lLE
 TqZVWGgWPsfbueJSz9IdyQFvVrGteevNNhP/k/6tQkpN3bCskwH7VMs1MMLCJLE+8Sqy
 KH3c8ORG8lzX2IUalQ+nFO61WSGjXMuRdB2PGO1XT3aCNtbC7Vl5L7BptMPmzPm6O4TY
 DgqlYTIl7VIhJOCpoVtwttUZ+r7H/dwgZJRkyA/cU9oMcciTVTzCIyrub11drZ5A2M/8
 BHJWrb38gBaCM80efcUUXTxaHztuBOta4J+b1oysnTfgbyPvWFnjJb1s04VIB8jQSTPC
 t7AQ==
X-Gm-Message-State: APuU4Z/aL7aRg8ddJ5seCpb0IOlcrr2inwjT+3u2j+CiWPVlGAVNjUaU
 ywCAlWG/rw5b4JQiKgY6swScD3HElJHuHwzcqrb7WKbJPFATebB+rN9zTwejbjvWIv5UhPzB9F2
 hjdQxrIw6ZPqdttnBHJ+tRFQsTdZb13/QR0b/CRV1eg==
X-Gm-Gg: AYBFou1nYAtjzz+GKVFEAA1yY/gWtLyt4ZbWP009pZCI+KkiEAeV2cQSHLpcwirSWAA
 n82dGRf0gp/QYDMJznw9R5iy9tgSVD9M3omxOQxmvFA/1aIbi0jCVRyhbkxPt5Ew1Kji63u9MT9
 mkgJ3TCjljuC8ciaZjFmGgcoFfesZdzGjkDxXM0+cQ97l5ZnhnOC0quT9/a59zTiGrbOxO45Pag
 rKGddMCTHOmy0172XoJVtccvvSWqp/ebXjb9ZofXPCKAAhuhWR5bjNSZga8I7i2tSqmsn9UnKVr
 rlmW2PsVllsc2na+RbNnaFInRsRO/795WNowqidJhc8yc2PCdAqswCkKGJTpenukYUNsTPOBNp7
 awyltEGlVUD7vS1L8REUvrXxZYBstrhxpg0PqRQ/FlEU9rLm/NWnHcqupyCOHAEOi6m7AHDf4wZ
 fMc/ZK7ERFeIR9A6C/crT/ew==
X-Received: by 2002:a05:690c:6602:b0:8b1:6740:6e7b with SMTP id
 00721157ae682-8b34192bec0mr16183457b3.27.1793984925158; Fri, 06 Nov 2026
 09:08:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106155858.3779237-1-peter.maydell@linaro.org>
 <20261106155858.3779237-2-peter.maydell@linaro.org>
 <a66e5489-7898-43b6-a7c3-8a7a3deedbb7@oss.qualcomm.com>
 <CAFEAcA8jLh_5B563-Y-JmhFoimssDB71Lncq8vy4cf9RdqVm6A@mail.gmail.com>
In-Reply-To: <CAFEAcA8jLh_5B563-Y-JmhFoimssDB71Lncq8vy4cf9RdqVm6A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2026 17:08:33 +0000
X-Gm-Features: AclHuK9DlsuZjb8K1IGjRxKRgP6Eg2hk2LgN057BOWvKa0rh20ZL2PXY6BBAJks
Message-ID: <CAFEAcA88de=0uh1yYNvRsJH3hsqH5Ecqju5FcdRReL_z2UB_sQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "meson: rewrite scripts/qemu-version.sh
 directly in meson.build"
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yonggang Luo <luoyonggang@gmail.com>, John Snow <jsnow@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 17:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> $ git log --oneline -1
> f71afb409a8 Merge tag 'pull-loongarch-20261105' of
> https://github.com/bibo-mao/qemu into staging
> $ rm -rf build/arm && mkdir build/arm && (cd build/arm &&
> '../../configure'
> '--target-list=arm-softmmu,aarch64-softmmu,arm-linux-user,aarch64-linux-user,aarch64_be-linux-user'
> '--cc=ccache gcc' '--with-pkgversion=pm215' '--enable-debug'
> '--enable-docs') && make -C build/arm -j20
> [...]
> $ make -C build/arm -j20
> make: Entering directory '/home/pm215/qemu/build/arm'
> [1/35] Generating tests/include/QAPI test (include) with a custom command
> make: Leaving directory '/home/pm215/qemu/build/arm'

Whoops, there's a missing step here:

$ rm build/arm/qemu-version.h

> $ make -C build/arm -j20
> make: Entering directory '/home/pm215/qemu/build/arm'
> [1/27] Compiling C object qga/qemu-ga.p/main.c.o
> FAILED: qga/qemu-ga.p/main.c.o
> /usr/bin/ccache gcc -m64 -Iqga/qemu-ga.p -Iqga -I../../qga -I. -Iqapi
> -Itrace -Iui -Iui/shader -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fdiagnostics-color=auto
> -Wall -Winvalid-pch -Werror -std=gnu11 -O0 -g -mcx16 -msse2
> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
> -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero
> -fzero-call-used-regs=used-gpr -fstack-protector-strong -Wempty-body
> -Wendif-labels -Wexpansion-to-defined -Wformat-overflow=2
> -Wformat-security -Wformat-y2k -Wignored-qualifiers
> -Wimplicit-fallthrough=2 -Winit-self -Wmissing-format-attribute
> -Wmissing-prototypes -Wnested-externs -Wold-style-declaration
> -Wold-style-definition -Wredundant-decls -Wshadow=local
> -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings
> -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value
> -isystem /home/pm215/qemu/linux-headers -isystem linux-headers -iquote
> . -iquote /home/pm215/qemu -iquote /home/pm215/qemu/include -iquote
> /home/pm215/qemu/host/include/x86_64 -iquote
> /home/pm215/qemu/host/include/generic -iquote
> /home/pm215/qemu/tcg/x86_64 -pthread -fPIE -MD -MQ
> qga/qemu-ga.p/main.c.o -MF qga/qemu-ga.p/main.c.o.d -o
> qga/qemu-ga.p/main.c.o -c ../../qga/main.c
> In file included from ../../qga/main.c:33:
> /home/pm215/qemu/include/qemu/version.h:11:10: fatal error:
> qemu-version.h: No such file or directory
>    11 | #include "qemu-version.h"
>       |          ^~~~~~~~~~~~~~~~
> compilation terminated.
> [etc]

-- PMM

