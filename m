Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B73C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 22:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpE0M-0006UE-L1; Mon, 03 Mar 2025 17:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpE0K-0006Tl-0g
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 17:11:16 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpE0F-0005DW-Ul
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 17:11:15 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bc6a6aaf7so9807345e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 14:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741039863; x=1741644663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QXfRL2pEQ2VY0ApLfWiY8JKsViq47NIBx28EgH8l5Nw=;
 b=p5odp2eiUNfcg4UTQQczOMhJ9Ez1Q6ugpS43I/HWzJ95VkQNfgABEGVUm3qulrlewC
 sfSQldzbKMiNSTO5UvezjFGDv4gvf70dzPK6h9T5xcA6OnnZBvj6XuJitoqh9WUeBmYs
 0VGLPZJRKH+NgDClbVCkj3kUBBMtD78z3vyDN3fknV2qQKjWM0yRzAwNlLawpUQXZLL8
 9qLt2vxsl9ybhhC15J+f2fSzjeTd0cCghT2GkcP/tR1dJ9ry63/djMP6eMw31gF0s3X6
 Z2naP89dbe9sh6/6cmxhY2gxGfr9SMdZar/sYjBAiIWg8kX2NyKXowPTSwIBCjmS9+lQ
 gDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741039863; x=1741644663;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QXfRL2pEQ2VY0ApLfWiY8JKsViq47NIBx28EgH8l5Nw=;
 b=WDnI8keU70fGhUrhn1B28Af9DaD3NXMgRPfjka9yY/Kc8CNEMWVzkYGr/VnyOrBJiT
 6GptLHNqMykvNNmIZXp3qowiHBzoDKShfNLyfOh6cKmVjyPI77zhJSXPARtIbFZ0VgEh
 aTBkViH3nJo9STJZkHt9yAN8PwUZ70wX4DPKXZ0Zss+IdNIPdZcIF4c4HRywuOm9fA9B
 WIsY75AX+DgdqER9/v7Lakub8vD2He5SzdruT5HhNH+UvoID8SVgZfdhBDEGeJbo7Ekn
 tKbjBePG1+S9LjffqKfl5Klihq3eTSU2U0bBmxGMwnoTt0xr1Xcg02B8jsXhF/IUxiwN
 6m3A==
X-Gm-Message-State: AOJu0Yxza3GkNj8hsdm14SaVJE8Mx0mwa3m6De61MlhzJfToa59BeL+/
 7CCHiOObbI9984/r6pR/yoDBNNokKexhV++ZPs4IWioTn4vdLc8PZ0tVGUJ1O+c=
X-Gm-Gg: ASbGncv0vAsHkjBfToUWeh14L8oISEJeFs+Y5exgwIJBRbd/Bqq5+gJffDAok3nen49
 2Jy3GCURf5gWLCEth0Fe0HUbN3GxcBZ6QMpma7sR+V4EtaRdNN1Wt2l/Q2NxF4kq9UwtOtyVT6B
 2Aai6D1sjpt95VmqdJmyqfLzO3ZN4lSAfszFHlMLfElEGmlnEnI6XJqkrjqWz7wd+d4c54sFaLE
 gTbct/8WF5yNQ96NAoZ+XsQmFh8IJVGxOBnb0HmMV/qeyt/2EMfeLsQLdMlF7SGMIVQhAagw6EU
 UR3jzL87zkf+YCj92YLXXh3XJWiGEHejfZYkrwxlIZr9XJGMyomZvnYD3FBsulyAVX9OleBiCFT
 EtayhaYz7W+/O
X-Google-Smtp-Source: AGHT+IEI2ibIdegW4oZozMGAhG1Hz97py8jxsQz+tvtUCJJ/wjJDLyux4Z9xE/MhMw/xzftIpB2f7w==
X-Received: by 2002:a05:600c:1392:b0:439:6ab6:5d45 with SMTP id
 5b1f17b1804b1-43ba6747775mr106759585e9.28.1741039862862; 
 Mon, 03 Mar 2025 14:11:02 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bbbff18b3sm65292105e9.24.2025.03.03.14.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 14:11:02 -0800 (PST)
Message-ID: <81390b0b-bae7-43bc-84d4-7447805a1a83@linaro.org>
Date: Mon, 3 Mar 2025 23:11:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 11/11] hw/vmapple/vmapple: Add vmapple machine type
To: Phil Dennis-Jordan <phil@philjordan.eu>, peter.maydell@linaro.org,
 berrange@redhat.com, pbonzini@redhat.com, John Snow <jsnow@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, mst@redhat.com,
 stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 marcandre.lureau@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, Alexander Graf
 <graf@amazon.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20250112210056.16658-1-phil@philjordan.eu>
 <20250112210056.16658-12-phil@philjordan.eu>
 <2a4229cf-c789-41ed-ab46-0f0fd9efd19a@linaro.org>
 <CAAibmn0tV_YLwJwcgfy5sZiPyeaBWE_FPOPEEE_0aZ7mMANFig@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAibmn0tV_YLwJwcgfy5sZiPyeaBWE_FPOPEEE_0aZ7mMANFig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 3/3/25 21:36, Phil Dennis-Jordan wrote:
> 
> 
> On Mon, 3 Mar 2025 at 19:20, Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     On 12/1/25 22:00, Phil Dennis-Jordan wrote:
>      > From: Alexander Graf <graf@amazon.com <mailto:graf@amazon.com>>
>      >
>      > Apple defines a new "vmapple" machine type as part of its proprietary
>      > macOS Virtualization.Framework vmm. This machine type is similar
>     to the
>      > virt one, but with subtle differences in base devices, a few special
>      > vmapple device additions and a vastly different boot chain.
>      >
>      > This patch reimplements this machine type in QEMU. To use it, you
>      > have to have a readily installed version of macOS for VMApple,
>      > run on macOS with -accel hvf, pass the Virtualization.Framework
>      > boot rom (AVPBooter) in via -bios, pass the aux and root volume
>     as pflash
>      > and pass aux and root volume as virtio drives. In addition, you also
>      > need to find the machine UUID and pass that as -M vmapple,uuid=
>     parameter:
>      >
>      > $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=0x1234 -m 4G \
>      >      -bios /System/Library/Frameworks/Virtualization.framework/
>     Versions/A/Resources/AVPBooter.vmapple2.bin
>      >      -drive file=aux,if=pflash,format=raw \
>      >      -drive file=root,if=pflash,format=raw \
>      >      -drive file=aux,if=none,id=aux,format=raw \
>      >      -device vmapple-virtio-blk-pci,variant=aux,drive=aux \
>      >      -drive file=root,if=none,id=root,format=raw \
>      >      -device vmapple-virtio-blk-pci,variant=root,drive=root
>      >
>      > With all these in place, you should be able to see macOS booting
>      > successfully.
>      >
>      > Known issues:
>      >   - Currently only macOS 12 guests are supported. The boot
>     process for
>      >     13+ will need further investigation and adjustment.
>      >
>      > Signed-off-by: Alexander Graf <graf@amazon.com
>     <mailto:graf@amazon.com>>
>      > Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu
>     <mailto:phil@philjordan.eu>>
>      > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu
>     <mailto:phil@philjordan.eu>>
>      > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>
>      > ---
> 
> 
>      >   MAINTAINERS                 |   1 +
>      >   contrib/vmapple/uuid.sh     |   9 +
>      >   docs/system/arm/vmapple.rst |  63 ++++
>      >   docs/system/target-arm.rst  |   1 +
>      >   hw/vmapple/Kconfig          |  20 ++
>      >   hw/vmapple/meson.build      |   1 +
>      >   hw/vmapple/vmapple.c        | 618 +++++++++++++++++++++++++++++
>     +++++++
>      >   7 files changed, 713 insertions(+)
>      >   create mode 100755 contrib/vmapple/uuid.sh
>      >   create mode 100644 docs/system/arm/vmapple.rst
>      >   create mode 100644 hw/vmapple/vmapple.c
>      >
>      > diff --git a/MAINTAINERS b/MAINTAINERS
>      > index e220744abf..3a3d9e19f4 100644
>      > --- a/MAINTAINERS
>      > +++ b/MAINTAINERS
>      > @@ -2791,6 +2791,7 @@ M: Phil Dennis-Jordan <phil@philjordan.eu
>     <mailto:phil@philjordan.eu>>
>      >   S: Maintained
>      >   F: hw/vmapple/*
>      >   F: include/hw/vmapple/*
>      > +F: docs/system/arm/vmapple.rst
>      >
>      >   Subsystems
>      >   ----------
>      > diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh
>      > new file mode 100755
>      > index 0000000000..956e8c3afe
>      > --- /dev/null
>      > +++ b/contrib/vmapple/uuid.sh
>      > @@ -0,0 +1,9 @@
>      > +#!/bin/sh
>      > +# Used for converting a guest provisioned using
>     Virtualization.framework
>      > +# for use with the QEMU 'vmapple' aarch64 machine type.
>      > +#
>      > +# Extracts the Machine UUID from Virtualization.framework VM
>     JSON file.
>      > +# (as produced by 'macosvm', passed as command line argument)
>      > +
>      > +plutil -extract machineId raw "$1" | base64 -d | plutil -extract
>     ECID raw -
>      > +
>      > diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/
>     vmapple.rst
>      > new file mode 100644
>      > index 0000000000..5090a8997c
>      > --- /dev/null
>      > +++ b/docs/system/arm/vmapple.rst
>      > @@ -0,0 +1,63 @@
> 
>     Alex, Phil, we now mandate a SPDX tag. Due to the license used in
>     vmapple.c in this patch, are you OK with me squashing here:
> 
> 
> Sorry about that, I forgot all about the SPDX tags in scripts and docs - 
> yes, please add that SPDX on uuid.sh. The vmapple.rst is Alex's creation 
> (I think I tweaked a few lines max) - but if that's the usual license we 
> use for documentation as well then it seems a reasonable assumption to 
> use GPL2+ there too if we don't hear from him.

TBH IDK and IANAL :) "GPL-2.0-or-later" is about *program*, is it
relevant for documentation? This is the single license used with SPDX
in docs/:

$ git grep SPDX docs
docs/system/devices/igb.rst:1:.. SPDX-License-Identifier: GPL-2.0-or-later
docs/system/devices/virtio-gpu.rst:2:   SPDX-License-Identifier: 
GPL-2.0-or-later

Note we also use the FreeBSD-DOC in bitmaps.rst (not as SPDX tag):

docs/interop/bitmaps.rst:5:   This file is licensed via The FreeBSD 
Documentation License, the full

Per commit 2b96c1a4931 ("scripts: validate SPDX license choices"):

+    my $prefer = "GPL-2.0-or-later";
+    my @valid = qw(
+       GPL-2.0-only
+       LGPL-2.1-only
+       LGPL-2.1-or-later
+       BSD-2-Clause
+       BSD-3-Clause
+       MIT
+       );

GPL: "program"
LGPL: "library"
BSD/MIT: "software"

In doubt I'll stick with $prefer except if someone has a better clue /
suggestion.

> Thanks for the doc syntax fix as well.
> 
>     -- >8 --
>     diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst
>     index 5090a8997c3..c5b1bcf45ea 100644
>     --- a/docs/system/arm/vmapple.rst
>     +++ b/docs/system/arm/vmapple.rst
>     @@ -0,0 +1,2 @@
>     +.. SPDX-License-Identifier: GPL-2.0-or-later
>     +
>     diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh
>     index 956e8c3afed..f5637221d23 100755
>     --- a/contrib/vmapple/uuid.sh
>     +++ b/contrib/vmapple/uuid.sh
>     @@ -1,0 +2 @@
>     +#
>     @@ -6,0 +8,2 @@
>     +#
>     +# SPDX-License-Identifier: GPL-2.0-or-later
>     ---
> 
>     ?


