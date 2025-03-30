Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869ADC28B20
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 10:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1typY8-0003tO-A3; Sun, 30 Mar 2025 06:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1typY6-0003su-Q9
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 06:05:50 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1typY4-0006qr-OY
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 06:05:50 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so466025366b.1
 for <qemu-devel@nongnu.org>; Sun, 30 Mar 2025 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743329146; x=1743933946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=RLzDUT9juDmhvwIq920XpGL0rFD8vWVPvyawvZiMQwk=;
 b=UIS3eoYuFRaobhjBOxOTfjums6QekqamduXno5w/y/98T5+Bi6TVYvhTlQn4eP8YGn
 +1l81oXBgHf+NEP7LI6/ox106kzHL/kjmYyK3FQlILHsTxRIOx5M9eplSABepXWaJXlu
 HQ9TSV/DhrWjquJUmenC2T1xIIWCLjXwIKqC+PylgfjJfSOsAVjLVLtSioWlQ1170HZJ
 tqQU0uh9Jn1RkUtzF7HvyBTeqys/0nzbSz6g3i6QlHfUJ9lQNnhj1WMXp/NrAUl1TxuV
 SmsJNyqhtLt+ozyYz5UWX9TkoHyDR0beAwlPzQxXbH0nInNzznzdCT6QSu6DoH+taoXU
 u1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743329146; x=1743933946;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RLzDUT9juDmhvwIq920XpGL0rFD8vWVPvyawvZiMQwk=;
 b=bq26ILyoKAngBWuep1LDnEnbKLBnQn3GYYdIzQhVIHvSllpsncZVWMR0WFppyW21HU
 Z+gj2dB6vd6us1hcNLL84LCgQtFdVKT85U3RvppZuQcD7NZjLZbh0ZnsECFIu5eD5aPP
 7VpfgJTsPnOOMSLFM7VEtdVg9msY7xxrN0EYU52xtXmmBtcSJZrNndxr5qhrp1R2Sfp5
 VrCnTpbneQaUcDVYEogJgyqQDA1L+UA+qgGDbW9SMyBcntNVGNjoZ65zshf7KDDI19JR
 18sOaTk5pt/U2ETSbSNVQVLT/9e7ipbs9KRrzWTlIRCntJwAyqE0JYxEpMDeL7QoW2EY
 0TXA==
X-Gm-Message-State: AOJu0YymxoiUkT9h3FipDKLJadSakso9t4uaJwsHdxcedH8hZzwFdqQu
 jMIt5lxBovtNl6kUrEJOJ2fkwalEZC04GkH4iXXo1NVn89lpoK/cSqBO4Q==
X-Gm-Gg: ASbGncsweeAh4eH/lmaG2mDmJEZwv5+kFErDV70I0aiC7YPkaiiHdQa7W5XZnzycQtt
 xTUfqdkoETHw7qqCGf/ACKDa4zC2AYcOqnHlHqCfSQF0RBXczXppqw31SISxBoVmo6rwFSfAyss
 q6Zz0MvUDwaqLZay29l7BgWyluLLed4UH4Y0TGSKxjSydR+dyBjtYzZed182I990BExx0E/AXTH
 TeRESPoAHpC2bvcbJowvuU1PVQl7+QaKW0ep1t9iCdzsiKsW9A8VYkA0JlLKdzZZER8Q9499pX0
 2mOvKmbSrIaApmS8sT9v/7HxHowFqpjJnoDLH/nIymcUhTiAaZ7dar7knfQ/6uf6Hm0rCEZWwqA
 Oo/b9iVhiwqwEDy2BBwQh6IwJTkStv+f8SSysatYzhrWXvBVyd8cr1kAHrxpIdJ4=
X-Google-Smtp-Source: AGHT+IEeDf9XcQryqUvrM+igi5Xw24J+4g/fUBRjdzxUh71270Z0ATVC1iPfVnXfJgxrjr4BARhzKg==
X-Received: by 2002:a17:907:7250:b0:abc:b96:7bd2 with SMTP id
 a640c23a62f3a-ac738975e17mr498565866b.11.1743329145870; 
 Sun, 30 Mar 2025 03:05:45 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2ddd-7900-69d2-56f6-a5af-50a8.310.pool.telefonica.de.
 [2a02:3100:2ddd:7900:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7192ea05fsm455755066b.86.2025.03.30.03.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 03:05:45 -0700 (PDT)
Date: Sun, 30 Mar 2025 10:05:45 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Pavel Pisa <pisa@fel.cvut.cz>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Matyas Bobek <bobekmat@fel.cvut.cz>
Subject: =?US-ASCII?Q?Re=3A_Plea_for_advice_with_PCIe_on_QEMU_for_iM?=
 =?US-ASCII?Q?X6_and_plan_to_add_FlexCAN_controller_support?=
In-Reply-To: <202410021706.01967.pisa@fel.cvut.cz>
References: <202410021706.01967.pisa@fel.cvut.cz>
Message-ID: <E4AF9EE3-C829-4E26-A3F0-91F627CB1BE1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
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



Am 2=2E Oktober 2024 15:06:01 UTC schrieb Pavel Pisa <pisa@fel=2Ecvut=2Ecz=
>:
>Dear Nikita and other,
>
>my student Matyas Bobek has chosen to work
>on QEMU CAN support in a frame of his study
>final project=2E
>
>We have identified iMX6 FlexCAN as the next interesting
>CAN controller for emulation=2E

I'd be interested in emulating FlexCAN as well! Is there any repository fo=
r a sneak preview?

>One of our industrial partners
>is using iMX6 based system with CAN and iMX6 SabreLite
>is supported by QEMU=2E iMX6 is often used in industry
>still and FlexCAN has use even for iMX8 emulation
>if it is added into QEMU in the future=2E

As luck would have it, QEMU will support i=2EMX 8M Plus in the upcoming re=
lease: <https://lore=2Ekernel=2Eorg/qemu-devel/20250225180510=2E1318207-32-=
peter=2Emaydell@linaro=2Eorg/> I'm more than happy to integrate FlexCAN emu=
lation!

>
>In the preparatory work, we want to setup
>shared directory between host and guest
>kernel using 9P FS on PCI virtio=2E
>
>The development environment is based on current
>mainline QEMU and mainline Linux kernel sources=2E
>
>We use standard QEMU options
>
>  -virtfs local,path=3Dshareddir,security_model=3Dnone,mount_tag=3Dshared=
dir
>
>and the 1af4:1009 is seen by monitor command "info pci"
>but on the guest kernel side only "16c3:abcd" DWC_usb3 / PCIe bridge
>is seen but none from the mapped devices, virtio (1af4:1009),
>CTU CAN FD, Kvaser CAN=2E

Should be fixed in master / QEMU 10=2E0 by <https://lore=2Ekernel=2Eorg/qe=
mu-devel/20250225180510=2E1318207-30-peter=2Emaydell@linaro=2Eorg/>

>
>The imx6q-sabrelite DTS is used with standard device-tree
>
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
tree/arch/arm/boot/dts/nxp/imx/imx6q-sabrelite=2Edts
>
>We hope that all required drivers are enabled
>in the kernel=2E But it is possible that something
>has been overlooked=2E
>
>Do you have some hint or some kernel
>and QEMU working example for iMX6 PCIe
>device mapping?

When adding a PCI device via command line, add `bus=3Ddw-pcie` as an addit=
ional option as a workaround for earlier QEMUs=2E

Best regards,
Bernhard

>
>Thanks in advance=2E
>
>Best wishes,
>
>                Pavel
>--
>                Pavel Pisa
>    phone:      +420 603531357
>    e-mail:     pisa@cmp=2Efelk=2Ecvut=2Ecz
>    Department of Control Engineering FEE CVUT
>    Karlovo namesti 13, 121 35, Prague 2
>    university: http://control=2Efel=2Ecvut=2Ecz/
>    personal:   http://cmp=2Efelk=2Ecvut=2Ecz/~pisa
>    social:     https://social=2Ekernel=2Eorg/ppisa
>    projects:   https://www=2Eopenhub=2Enet/accounts/ppisa
>    CAN related:http://canbus=2Epages=2Efel=2Ecvut=2Ecz/
>    RISC-V education: https://comparch=2Eedu=2Ecvut=2Ecz/
>    Open Technologies Research Education and Exchange Services
>    https://gitlab=2Efel=2Ecvut=2Ecz/otrees/org/-/wikis/home
>

