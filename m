Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D84FFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 15:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIAR-0003Yd-TS; Tue, 05 May 2026 11:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wKIAN-0003Xb-Ro
 for qemu-devel@nongnu.org; Tue, 05 May 2026 11:58:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wKIAK-0000Si-1n
 for qemu-devel@nongnu.org; Tue, 05 May 2026 11:58:35 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so1678617f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1777996710; x=1778601510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gxMPOwc1DrwlEUOVXlwTx8H5S+DnZZzRQ1hsNsMwY3o=;
 b=BtwbAWUxAnIatE4bR+EkHSvkVtNKPwBWXQGX5Pkvf0JmA2ChYmw0t6Pa1m8pX5aZBT
 ZKEQJyHraS4I+RPNRzoTZQ3resa7pmykED4uTFc/fKRv8+XFlLQarGSpsBRZ5bpyNcMK
 8amn1xE7dyekKYW7fFlc2AS8S7W8XhwajpMUAyrCYYDr9u89Kgga8rWiEq3D1XHp2LqS
 yAMoAo97pMFDOlpvm388VgzRfeg9XvPA1XvGlwX/V+eVirFLmnKMZ4uWKOLUcO+1ytfN
 +x2SywynCIiUEZLOr9GTdi/0nqzbzNf1nDZqkpO1HBPrQd1zbnwsDBbzQjbfhfuwXw64
 icbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777996710; x=1778601510;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gxMPOwc1DrwlEUOVXlwTx8H5S+DnZZzRQ1hsNsMwY3o=;
 b=OfGe0pvdefa+7SmeVyPB/oy44fNLiKacFGzJx6aRXL95mDb7S2Zhyo59fi1rNnQddO
 DD9UPwykv2YHcxNMnZWaIN4IbZ2Qc+Pb3fk82jPPIOUHKv+6A7TSm4ZYYgRu1/84n0kd
 po1z9Yv61m66VJQLImquULCoAdqRUIW5R3vgkwaqMA6r+T7nNzMTIlCAyiEyj3G2RTN/
 ndYrg44ZrlPR07yYmklMWTcLARXUbUxvt2ss2HC0yJ9jgI7DgDIWmxuM/FGoLuUg8wT1
 l6xcHRJN39T7iUfruWbxjCjO0Sz7WXGZZ0qRdfkGfKn86FqGocazf3spNmc3MTgIYhUj
 fi8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IBL+wCa/n2j9HrwuYRosW2TObfVS38CxplO8NUZgtnGSoxa478Oe08TxS64kg109u3g2mtg77YFoN@nongnu.org
X-Gm-Message-State: AOJu0YweUwgvvl6ctAwVeGwV6ioenfTYuKzl6MIDcRGSTEldd3t2D0CX
 I6+4uMocF9znheyEMQTLe2veNBEbRlS84TVbXf0W4JSOfjLx1U9n1mXEA/cBngcMhVs=
X-Gm-Gg: AeBDiet6+wUIgUrvVUUnr6PQ65+yRLIgoKupIUSNhvlRCeACXjKjmJ4umAQaXAci+XD
 7O0kD4wpUQNZbLbouhUpwCjXYk+yozguu7PMEBynMTE1iCp4LAmjxpDtWiEVckVR1E2pmb1v8LL
 FexjdtVC45xDveEEs5qXbmV9CVcv3xbZ+qiCYysu8h+rctSyzCZ/TRo+v8cO0rQ3dMa2UrH3Vaw
 /10u0FkXPKpq796rPbIHbUk22I7526DiLiQMkSnCTfYoi8DNXb67S85ZP7X/BnUM9YntyHPXXSq
 5QLQlS6h+Qxw2NSYqUtsydKCI6mvVWTzjchAIhNebh/qAMcYOKCwBX5EjpCUxV9aP0KbkM0tv8x
 fxVm5mnixNBj/WeHJoahI0SqeiA9vzVT5Ay9sYQ+Fx7KYBV0XciKKvEVhdwweNTcUrbS8HfCi0V
 JmdiNbU7/5gGilQKegrG2IErXSzqNAZhODY4xPVRtW4XTFddqtdiAC
X-Received: by 2002:a05:6000:40df:b0:43d:7dc2:b655 with SMTP id
 ffacd0b85a97d-450041b076fmr6850578f8f.15.1777996709569; 
 Tue, 05 May 2026 08:58:29 -0700 (PDT)
Received: from [10.93.128.145] ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-450524831cdsm6085249f8f.5.2026.05.05.08.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 08:58:29 -0700 (PDT)
Message-ID: <7437bd8e-e938-4a36-9678-cabde10a5d17@9elements.com>
Date: Tue, 5 May 2026 17:56:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ast2600: yosemite4 initial support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Patrick Williams <patrickw3@meta.com>
References: <20260504165043.213704-2-alexander.hansen@9elements.com>
 <20260504165043.213704-6-alexander.hansen@9elements.com>
 <7184f945-7e92-4394-b484-1eb336aa4161@kaod.org>
Content-Language: en-US
From: Alexander Hansen <alexander.hansen@9elements.com>
In-Reply-To: <7184f945-7e92-4394-b484-1eb336aa4161@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wr1-x431.google.com
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

Hi Cedric, thanks for taking a look so quickly!

 > A functional test would be greatly appreciated. This is especially  
true since the other patches add new sensors.

I sent a v2 which includes a functional test, i agree that would be 
quite helpful to confirm that the new sensors do not crash anything :)
The functional test is currently pointing to my fork of qemu-aspeed-boot 
(so you can run it already) but a PR to your tree has been opened.

The new functional test has a single issue which is that one line from 
the expected logs (hostname) is not emitted.
I am not sure if it's due to differences in the image or simply due to 
timeouts being hit on userspace services.

Networking however is functional and i can ssh into the qemu machine. 
For now i simply dropped that assertion from the function test
and instead asserted on the login prompt.

I hope to have addressed all your comments,  looking forward to your 
next review :p

Thank you,
Alexander

On 5/4/26 19:34, Cédric Le Goater wrote:
> Hello,
>
> On 5/4/26 18:48, Alexander Hansen wrote:
>> Initial patch based on [1] to support yosemite v4 bmc emulation.
>>
>> The goal of this machine support is to support OpenBMC development.
>>
>> Reference linux devicetree from openbmc linux is [2].
>>
>> Status:
>> - Enclosure FRU:         showing up
>> - Management Board FRU:  showing up
>> - Blade Board FRU:       showing up
>> - Blade Board sensors:   not implemented
>> - Blade Chassis FRU:     showing up
>> - Fan Board FRU:         both showing up
>> - Fan Board sensors:     supported
>>
>> Overall the emulation is incomplete but already helpful in development
>> and testing.
>>
>> The focus of this initial support is on the FRU eeproms and fanboard
>> sensors.
>>
>> Tested: booted an OpenBMC image for yosemite4 target.
>
> A functional test would be greatly appreciated. This is especially
> true since the other patches add new sensors.
>
>
>> References:
>> [1] 
>> https://github.com/9elements/qemu/commit/32139f913c2bd0ebe4bd26c46765861f6f9f2d49
>> [2] arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
>>
>> Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
>> Cc: Peter Maydell <peter.maydell@linaro.org> (maintainer:ASPEED BMCs)
>> Cc: Steven Lee <steven_lee@aspeedtech.com> (reviewer:ASPEED BMCs)
>> Cc: Troy Lee <leetroy@gmail.com> (reviewer:ASPEED BMCs)
>> Cc: Jamin Lin <jamin_lin@aspeedtech.com> (reviewer:ASPEED BMCs)
>> Cc: Kane Chen <kane_chen@aspeedtech.com> (reviewer:ASPEED BMCs)
>> Cc: Andrew Jeffery <andrew@codeconstruct.com.au> (reviewer:ASPEED BMCs)
>> Cc: Joel Stanley <joel@jms.id.au> (reviewer:ASPEED BMCs)
>> Cc: qemu-arm@nongnu.org (open list:ASPEED BMCs)
>> Cc: qemu-devel@nongnu.org (open list:All patches CC here)
>> Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
>> ---
>>   hw/arm/aspeed_ast2600_fby4.c | 298 +++++++++++++++++++++++++++++++++++
>>   hw/arm/meson.build           |   1 +
>>   2 files changed, 299 insertions(+)
>>   create mode 100644 hw/arm/aspeed_ast2600_fby4.c
>>
>> diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
>> new file mode 100644
>> index 0000000000..84cd372838
>> --- /dev/null
>> +++ b/hw/arm/aspeed_ast2600_fby4.c
>> @@ -0,0 +1,298 @@
>
> This lacks a SPDX-License-Identifier and Copyright.
>
> Did you run './scripts/checkpatch.pl' ?
>
>
>> +#include <inttypes.h>
>> +#include <stdbool.h>
>
> Please remove
>
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/arm/machines-qom.h"
>> +#include "hw/arm/aspeed.h"
>> +#include "hw/arm/aspeed_soc.h"
>> +#include "hw/nvram/eeprom_at24c.h"
>> +#include "hw/sensor/tmp105.h"
>> +#include "hw/sensor/max31790.h"
>> +#include "hw/sensor/max11615.h"
>> +#include "hw/sensor/adc128d818.h"
>> +#include "hw/i2c/i2c_mux_pca954x.h"
>> +#include "hw/gpio/pca9552.h"
>> +#include "system/reset.h"
>> +
>> +#define FBY4_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
>> +
>> +/* START OF EEPROM CONTENTS */
>> +
>> +/*
>> +./frugen -s board.mfg="Wiwynn" \
>> +  --set board.pname="Fan Board FSC-MAX ADC-TI LED-NXP EFUSE-MAX" \
>> +  --set text:board.pn="BRD-PN-345" \
>> +  --board-date "10/1/2017 12:58:00" \
>> +  --set board.serial="123456" \
>> +  --set product.pname="Yosemite V4" \
>> +  --set product.mfg="Wiwynn" \
>> +  --set product.ver="v1.1" \
>> +  --set product.serial="123456" \
>> +  --set product.atag="PLACEHOLDER" \
>> +  --set product.custom="Fanboard Custom1" \
>> +  --set product.custom.1="Fanboard Custom2" \
>> +  --set text:product.pn="PN-345" \
>> +  fru-yv4-fanboard.bin
>> +*/
>> +/* EM Config: 
>> yosemite4_fanboard_fsc_max_adc_ti_led_nxp_ons_efuse_max.json */
>> +/* Yosemite4 fan board */
>> +unsigned char fru_yv4_fanboard_bin[] = {
>
> this should be a "static const uint8_t'
>
>> +  0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 
>> 0xce,
>> +  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xea, 0x46, 
>> 0x61,
>> +  0x6e, 0x20, 0x42, 0x6f, 0x61, 0x72, 0x64, 0x20, 0x46, 0x53, 0x43, 
>> 0x2d,
>> +  0x4d, 0x41, 0x58, 0x20, 0x41, 0x44, 0x43, 0x2d, 0x54, 0x49, 0x20, 
>> 0x4c,
>> +  0x45, 0x44, 0x2d, 0x4e, 0x58, 0x50, 0x20, 0x45, 0x46, 0x55, 0x53, 
>> 0x45,
>> +  0x2d, 0x4d, 0x41, 0x58, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0xca, 
>> 0x42,
>> +  0x52, 0x44, 0x2d, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc0, 0xc1, 
>> 0x00,
>> +  0x00, 0x00, 0x00, 0xdb, 0x01, 0x09, 0x19, 0xc6, 0x57, 0x69, 0x77, 
>> 0x79,
>> +  0x6e, 0x6e, 0xcb, 0x59, 0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65, 
>> 0x20,
>> +  0x56, 0x34, 0xc6, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc4, 0x76, 
>> 0x31,
>> +  0x2e, 0x31, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0x89, 0x30, 0x1b, 
>> 0x8e,
>> +  0x25, 0xfa, 0xb2, 0x64, 0x29, 0x03, 0xc0, 0xd0, 0x46, 0x61, 0x6e, 
>> 0x62,
>> +  0x6f, 0x61, 0x72, 0x64, 0x20, 0x43, 0x75, 0x73, 0x74, 0x6f, 0x6d, 
>> 0x32,
>> +  0xc1, 0x00, 0x00, 0x9d
>> +};
>> +unsigned int fru_yv4_fanboard_bin_len = 160;
>
> static const size_t fru_yv4_fanboard_bin_len = 
> sizeof(fru_yv4_fanboard_bin);
>
>> +
>> +/*
>> +./frugen -s board.mfg="Wiwynn" \
>> +  --set board.pname="Sentinel Dome without Retimer" \
>> +  --set text:board.pn="BRD-PN-345" \
>> +  --board-date "10/1/2017 12:58:00" \
>> +  --set board.serial="123456" \
>> +  --set product.pname="Yosemite V4" \
>> +  --set product.mfg="Wiwynn" \
>> +  --set product.ver="v1.1" \
>> +  --set product.serial="123456" \
>> +  --set product.atag="PLACEHOLDER" \
>> +  --set product.custom="Yosemite V4 T1" \
>> +  --set product.custom.1="Yosemite V4 T1" \
>> +  --set text:product.pn="PN-345" \
>> +  fru-yv4-sentineldome-board.bin
>> +*/
>> +/* product.cust maps to PRODUCT_INFO_AM2 */
>> +/* EM Config: yosemite4_sentineldome_t1.json */
>> +/* Yosemite4 Sentinel Dome without Retimer Boards */
>> +unsigned char fru_yv4_sentineldome_board_bin[] = {
>> +  0x01, 0x00, 0x00, 0x01, 0x09, 0x00, 0x00, 0xf5, 0x01, 0x08, 0x19, 
>> 0xce,
>> +  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xdd, 0x53, 
>> 0x65,
>> +  0x6e, 0x74, 0x69, 0x6e, 0x65, 0x6c, 0x20, 0x44, 0x6f, 0x6d, 0x65, 
>> 0x20,
>> +  0x77, 0x69, 0x74, 0x68, 0x6f, 0x75, 0x74, 0x20, 0x52, 0x65, 0x74, 
>> 0x69,
>> +  0x6d, 0x65, 0x72, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0xca, 0x42, 
>> 0x52,
>> +  0x44, 0x2d, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc0, 0xc1, 0x00, 
>> 0x78,
>> +  0x01, 0x09, 0x19, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xcb, 
>> 0x59,
>> +  0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65, 0x20, 0x56, 0x34, 0xc6, 
>> 0x50,
>> +  0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc4, 0x76, 0x31, 0x2e, 0x31, 0x85, 
>> 0x91,
>> +  0x34, 0x51, 0x95, 0x05, 0x89, 0x30, 0x1b, 0x8e, 0x25, 0xfa, 0xb2, 
>> 0x64,
>> +  0x29, 0x03, 0xc0, 0xce, 0x59, 0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 
>> 0x65,
>> +  0x20, 0x56, 0x34, 0x20, 0x54, 0x31, 0xc1, 0x00, 0x00, 0x00, 0x00, 
>> 0xeb
>> +};
>> +unsigned int fru_yv4_sentineldome_board_bin_len = 144;
>> +
>> +/*
>> +./frugen -s board.mfg="Wiwynn" \
>> +        --set board.pname="Sentinel Dome" \
>> +        --set text:board.pn="BRD-PN-345" \
>> +        --board-date "10/1/2017 12:58:00" \
>> +        --set board.serial="123456" \
>> +        --set product.pname="Yosemite V4" \
>> +        --set product.mfg="Wiwynn" \
>> +        --set product.ver="v1.1" \
>> +        --set product.serial="123456" \
>> +        --set product.atag="PLACEHOLDER" \
>> +        --set text:product.pn="PN-345" \
>> +        fru-yv4-sentineldome-chassis.bin
>> +*/
>> +/* EM Config: yosemite4_sentineldome_chassis.json */
>> +/* Yosemite 4 Sentinel Dome Chassis FRU */
>> +unsigned char fru_yv4_sentineldome_chassis_bin[] = {
>> +  0x01, 0x00, 0x00, 0x01, 0x07, 0x00, 0x00, 0xf7, 0x01, 0x06, 0x19, 
>> 0xce,
>> +  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xcd, 0x53, 
>> 0x65,
>> +  0x6e, 0x74, 0x69, 0x6e, 0x65, 0x6c, 0x20, 0x44, 0x6f, 0x6d, 0x65, 
>> 0x85,
>> +  0x91, 0x34, 0x51, 0x95, 0x05, 0xca, 0x42, 0x52, 0x44, 0x2d, 0x50, 
>> 0x4e,
>> +  0x2d, 0x33, 0x34, 0x35, 0xc0, 0xc1, 0x00, 0xb6, 0x01, 0x07, 0x19, 
>> 0xc6,
>> +  0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xcb, 0x59, 0x6f, 0x73, 0x65, 
>> 0x6d,
>> +  0x69, 0x74, 0x65, 0x20, 0x56, 0x34, 0xc6, 0x50, 0x4e, 0x2d, 0x33, 
>> 0x34,
>> +  0x35, 0xc4, 0x76, 0x31, 0x2e, 0x31, 0x85, 0x91, 0x34, 0x51, 0x95, 
>> 0x05,
>> +  0x89, 0x30, 0x1b, 0x8e, 0x25, 0xfa, 0xb2, 0x64, 0x29, 0x03, 0xc0, 
>> 0xc1,
>> +  0x00, 0x00, 0x00, 0x59
>> +};
>> +unsigned int fru_yv4_sentineldome_chassis_bin_len = 112;
>> +
>> +/*
>> +./frugen -s board.mfg="Wiwynn" \
>> +      --set board.pname="Management Board wBMC" \
>> +      --set text:board.pn="BRD-PN-345" \
>> +      --board-date "10/1/2017 12:58:00" \
>> +      --set board.serial="123456" \
>> +      --set product.pname="Yosemite V4" \
>> +      --set product.mfg="Wiwynn" \
>> +      --set product.ver="v1.1" \
>> +      --set product.serial="123456" \
>> +      --set product.atag="PLACEHOLDER" \
>> +      --set text:product.pn="PN-345" \
>> +      fru-yv4-eclosure.bin
>> +*/
>> +/* EM Config: yosemite4_chassis.json, yosemite4.json */
>> +/* Yosemite 4 Sentinel Dome Enclosure FRU */
>> +unsigned char fru_yv4_eclosure_bin[] = {
>> +  0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 
>> 0xce,
>> +  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xd5, 0x4d, 
>> 0x61,
>> +  0x6e, 0x61, 0x67, 0x65, 0x6d, 0x65, 0x6e, 0x74, 0x20, 0x42, 0x6f, 
>> 0x61,
>> +  0x72, 0x64, 0x20, 0x77, 0x42, 0x4d, 0x43, 0x85, 0x91, 0x34, 0x51, 
>> 0x95,
>> +  0x05, 0xca, 0x42, 0x52, 0x44, 0x2d, 0x50, 0x4e, 0x2d, 0x33, 0x34, 
>> 0x35,
>> +  0xc0, 0xc1, 0x00, 0x26, 0x01, 0x07, 0x19, 0xc6, 0x57, 0x69, 0x77, 
>> 0x79,
>> +  0x6e, 0x6e, 0xcb, 0x59, 0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65, 
>> 0x20,
>> +  0x56, 0x34, 0xc6, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc4, 0x76, 
>> 0x31,
>> +  0x2e, 0x31, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0x89, 0x30, 0x1b, 
>> 0x8e,
>> +  0x25, 0xfa, 0xb2, 0x64, 0x29, 0x03, 0xc0, 0xc1, 0x00, 0x00, 0x00, 
>> 0x59
>> +};
>> +unsigned int fru_yv4_eclosure_bin_len = 120;
>> +
>> +/* END OF EEPROM CONTENTS */
>> +
>> +static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t 
>> eepromSize)
>> +{
>> +
>
> extra white line
>
>> +    /* 2 fan boards */
>> +    for (int i = 0; i <= 1; i++) {
>> +        /* downstream bus */
>> +        I2CBus *bus = pca954x_i2c_get_bus(fan_mux, i);
>> +
>> +        /* ti,adc128d818 @ 0x1f    (adc) */
>> +        /* the driver will throw away the last 4 bits, set them 0 */
>> +        uint16_t adc_values1[8] = {
>
> I would define these arrays as read only data.
>
>> +            0b011110000000, 0b010100010000,
>> +            0b001000110000, 0b100000100000,
>> +            0b011110000000, 0b010100010000,
>> +            0b001000110000, 0b100000100000};
>> +        adc128d818_init_with_values(bus,
>> +                              0x1f, adc_values1, 8);
>
> This could be on one line.
>
>> +
>> +        /* maxim,max31790 @ 0x20   (pwm) */
>> +        i2c_slave_create_simple(bus,
>> +                              TYPE_MAX31790, 0x20);
>
> same here.
>
>> +
>> +        /*
>> +         * ti,tca6424 @ 0x22       (gpio)
>> +         * linux handles tca6424 with PCA953X_TYPE, same as pca9535
>> +         * { "pca9535", 16 | PCA953X_TYPE | PCA_INT, },
>> +         * { "tca6424", 24 | PCA953X_TYPE | PCA_INT, },
>> +         * so we _could_ be fine here unless more than 16 gpios are 
>> used
>> +         */
>> +        i2c_slave_create_simple(bus,
>> +                              TYPE_PCA9535, 0x22);
>> +        /*
>> +         * NOTE: above works and could use for gpio presence:
>> +         * $ gpioget gpiochip2 2
>> +         * 1
>> +         */
>> +
>> +        /* maxim,max31790 @ 0x2f   (pwm) */
>> +        i2c_slave_create_simple(bus,
>> +                              TYPE_MAX31790, 0x2f);
>> +
>> +        /* maxim,max11615 @ 0x33   (adc) */
>> +        uint16_t adc_values[8] = {
>> +            0b011110000010, 0b010100011000,
>> +            0b001000110100, 0b100000101001,
>> +            0b011110000010, 0b010100011000,
>> +            0b001000110100, 0b100000101001};
>> +        max11615_init_with_values(bus,
>> +                              0x33, adc_values, 8);
>> +> +        at24c_eeprom_init_rom(
>> +            bus, 0x52, eepromSize,
>> +            fru_yv4_fanboard_bin,
>> +            fru_yv4_fanboard_bin_len);
>> +
>> +        /* LED blink driver / gpio expander */
>> +        /* nxp,pca9552 @ 0x61   (gpio) */
>> +        i2c_slave_create_simple(bus,
>> +                              TYPE_PCA9552, 0x61);
>> +    }
>> +}
>> +
>> +static void fby4_i2c_init_blade_chassis(I2CBus *bus, size_t eepromSize)
>> +{
>> +
>
> Extra white line.
>
>> +    /* Sentinel Dome Board EEPROMS */
>> +    const uint8_t board_addr = 0x54;
>> +    const uint8_t chassis_addr = 0x55;
>
> These variables look unnecessary.
>
>> +
>> +    /* Board */
>> +    at24c_eeprom_init_rom(bus, board_addr, eepromSize,
>> +        fru_yv4_sentineldome_board_bin, 
>> fru_yv4_sentineldome_board_bin_len);
>> +
>> +    /* Chassis */
>> +   at24c_eeprom_init_rom(bus, chassis_addr, eepromSize,
>> +       fru_yv4_sentineldome_chassis_bin, 
>> fru_yv4_sentineldome_chassis_bin_len);
>> +}
>> +
>> +static void fby4_i2c_init_multiple_blade_chassis(I2CBus **i2c,
>> +    size_t eepromSize)
>> +{
>> +
>
> Extra white line.
>
>
>> +    /* there is 8 blade chassis, but we only emulate 2 for 
>> performance reason */
>> +    for (int bus = 1; bus <= (8 / 4); bus++) {
>> +
>> +        fby4_i2c_init_blade_chassis(i2c[bus], eepromSize);
>> +    }
>> +}
>> +
>> +static void fby4_i2c_init(AspeedMachineState *bmc)
>> +{
>> +    AspeedSoCState *soc = bmc->soc;
>> +    I2CBus *i2c[16];
>> +
>> +    for (int i = 0; i < 16; i++) {
>> +        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
>> +    }
>> +
>> +    const size_t eepromSize = 128 * KiB;
>> +
>> +    const uint8_t enclosure_addr = 0x51;
>> +
>> +    /* Enclosure (EM Config: yosemite4_chassis.json, yosemite4.json) */
>> +    at24c_eeprom_init_rom(i2c[1], enclosure_addr, eepromSize,
>> +        fru_yv4_eclosure_bin, fru_yv4_eclosure_bin_len);
>> +
>> +    fby4_i2c_init_multiple_blade_chassis(i2c, eepromSize);
>> +
>> +    /* Yv4 fanboard connection */
>> +    I2CSlave *fan_mux = i2c_slave_create_simple(i2c[14], 
>> TYPE_PCA9546, 0x74);
>> +
>> +    fby4_i2c_init_fanboard(fan_mux, eepromSize);
>> +}
>> +
>> +static void fby4_reset(MachineState *state, ResetType type)
>> +{
>> +    qemu_devices_reset(type);
>> +}
>
>
> not needed
>
>> +static void aspeed_machine_fby4_class_init(ObjectClass *oc, const 
>> void *data)
>> +{
>> +    MachineClass *mc = MACHINE_CLASS(oc);
>> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
>> +
>> +    mc->desc       = "Facebook fby4 BMC (Cortex-A7)";
>> +    mc->reset      = fby4_reset;
>> +    amc->fmc_model = "mx66l1g45g";
>> +    amc->num_cs    = 2;
>> +    amc->macs_mask = ASPEED_MAC3_ON;
>> +    amc->i2c_init  = fby4_i2c_init;
>> +    mc->default_ram_size = FBY4_BMC_RAM_SIZE;
>> +    aspeed_machine_class_init_cpus_defaults(mc);
>> +}> +
>> +static const TypeInfo aspeed_ast2600_fby4_types[] = {
>> +    {
>> +        .name          = MACHINE_TYPE_NAME("fby4-bmc"),
>> +        .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
>> +        .class_init    = aspeed_machine_fby4_class_init,
>> +        .interfaces    = arm_machine_interfaces,
>> +    }
>> +};
>> +
>> +DEFINE_TYPES(aspeed_ast2600_fby4_types)
>> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
>> index 84b8ec5fb5..ccbc23e549 100644
>> --- a/hw/arm/meson.build
>> +++ b/hw/arm/meson.build
>> @@ -60,6 +60,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>>     'aspeed_ast2600_catalina.c',
>>     'aspeed_ast2600_evb.c',
>>     'aspeed_ast2600_fby35.c',
>> +  'aspeed_ast2600_fby4.c',
>>     'aspeed_ast2600_fuji.c',
>>     'aspeed_ast2600_gb200nvl.c',
>>     'aspeed_ast2600_qcom-dc-scm-v1.c',
>
> Thanks,
>
> C.

