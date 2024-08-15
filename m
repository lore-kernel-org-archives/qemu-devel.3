Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CB6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 00:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seOTF-0006bA-1p; Wed, 14 Aug 2024 20:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1seOT9-0006Ze-7m; Wed, 14 Aug 2024 20:36:00 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1seOT4-0006Vt-QF; Wed, 14 Aug 2024 20:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1723682144;
 bh=zxYdA6kLcVsZr6AK0FSC3cRNk37DunjX/5eQvUQxYmw=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=MR7hC6ge9K8X6PS4PH/2PqQsOVFB2lGd23Sd9YSf5JqeQQT4Yl3H9yxKkjAdZTe5d
 mrReOsszo1619Kev6QUUin65iF+6jXbDcpp+RL+nyZLdF92JILbq0Y8X+QZtzwP4cc
 Ov/70RYBB+Pm7T+XGnaZ7mACmnMTbAh54+hMEmqk/c+V94GwrDWtb7VwR7ik1fovpp
 rSNEtxg3eUEDDDE4ER6DgIX+ML/jiF2RH+BrLxTqbeY2WXheZK72A3X6JcPuCasS7I
 BJFo1vxjUUJFXWjKL41K6HTpCGO77CzcJwfnWtv+QQam3PGTH2geaLqg8XfoaCrbJF
 j3C3PcljhlE5A==
Received: from [192.168.68.112]
 (ppp118-210-65-51.adl-adc-lon-bras32.tpg.internode.on.net [118.210.65.51])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 190D464C85;
 Thu, 15 Aug 2024 08:35:35 +0800 (AWST)
Message-ID: <ba5ba799e27f2eb03e703b4741ad3b4e9e06eb11.camel@codeconstruct.com.au>
Subject: Re: [PATCH 5/5] hw/char: Extract serial-mm
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Niek Linnenbank
 <nieklinnenbank@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, Paul Burton
 <paulburton@kernel.org>, Stafford Horne <shorne@gmail.com>,
 qemu-ppc@nongnu.org,  Tyrone Ting <kfting@nuvoton.com>, Joel Stanley
 <joel@jms.id.au>, Eduardo Habkost <eduardo@habkost.net>,  Sergio Lopez
 <slp@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Hao Wu <wuhaotsh@google.com>, Alistair
 Francis <Alistair.Francis@wdc.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jan Kiszka <jan.kiszka@web.de>, Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt
 <palmer@dabbelt.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Jia Liu
 <proljc@gmail.com>, Helge Deller <deller@gmx.de>,  Max Filippov
 <jcmvbkbc@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>,  =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau
 <marcandre.lureau@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Steven Lee <steven_lee@aspeedtech.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,  Huacai Chen
 <chenhuacai@kernel.org>, Richard Henderson <richard.henderson@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Troy Lee <leetroy@gmail.com>, Jamin
 Lin <jamin_lin@aspeedtech.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat <fbarrat@linux.ibm.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, 
 =?ISO-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 qemu-riscv@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Song
 Gao <gaosong@loongson.cn>
Date: Thu, 15 Aug 2024 10:05:34 +0930
In-Reply-To: <20240814181534.218964-6-shentey@gmail.com>
References: <20240814181534.218964-1-shentey@gmail.com>
 <20240814181534.218964-6-shentey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 2024-08-14 at 20:15 +0200, Bernhard Beschow wrote:
> hw/char/serial currently contains the implementation of both TYPE_SERIAL =
and
> TYPE_SERIAL_MM. According to serial_class_init(), TYPE_SERIAL is an inter=
nal
> class while TYPE_SERIAL_MM is used by numerous machine types directly. Le=
t's
> move the latter into its own module which makes the dependencies more obv=
ious
> and the code more tidy.
>=20
> The includes and the dependencies have been converted mechanically except=
 in the
> hw/char directories which were updated manually. The result was compile-t=
ested.
> Now, only hw/char makes direct use of TYPE_SERIAL:
>=20
>   # grep -r -e "select SERIAL" | grep -v SERIAL_
>   hw/char/Kconfig:    select SERIAL
>   hw/char/Kconfig:    select SERIAL
>   hw/char/Kconfig:    select SERIAL
>   hw/char/Kconfig:    select SERIAL
>   hw/char/Kconfig:    select SERIAL
>=20
>   # grep -r -e "/serial\\.h"
>   include/hw/char/serial-mm.h:#include "hw/char/serial.h"
>   hw/char/serial-pci-multi.c:#include "hw/char/serial.h"
>   hw/char/serial.c:#include "hw/char/serial.h"
>   hw/char/serial-isa.c:#include "hw/char/serial.h"
>   hw/char/serial-pci.c:#include "hw/char/serial.h"
>=20
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/arm/aspeed_soc.h         |   2 +-
...

>  hw/arm/aspeed_ast2400.c             |   2 +-
>  hw/arm/aspeed_soc_common.c          |   2 +-

For the Aspeed bits:

Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>

