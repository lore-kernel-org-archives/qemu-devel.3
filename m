Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE49CD4F37
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 10:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMkZ5-00006G-Dy; Tue, 12 May 2026 06:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wMkZ4-00005y-D3
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:42:14 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wMkZ0-0004nu-FP
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:42:14 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-670ab084a39so9051407a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1778582529; x=1779187329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+1xwboLiSqH+1ANQwEJZxI5O8NRl+K7IpgASc+i90VE=;
 b=YRSdXdaD7q+uzAMLoJMAveyip6kcXAOzQTAlbQPkKL8beiCKTIgb8U/EM65EAzM6sF
 VN1C8QZcjcRzPypgxx5QeweBRjCO9Pb32sZ6K0kC+vCe/24HW8UBfSNSTgisg3K9WnD0
 kXOd+88TMPxtn0v8rA/hUKARfGsT9FTg/IDG4mgCwZOyQZ5mpwPAezAcEUVsr3XE4DBE
 IojKwXdnEDa5+JixJ1TtshWx56WVaSOstAV1PogyJ0w1ng7tpXfIlwXzX6AIzP6AwdLx
 bxZWqpenAUsafDLgZSKY0Rcl/wXZPEZNu/R4OdVjU/Q55+KnRDaxeRZsj3tPeDx93UqU
 Gppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778582529; x=1779187329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+1xwboLiSqH+1ANQwEJZxI5O8NRl+K7IpgASc+i90VE=;
 b=SZVzRQK0bytESmMl1U1JAiXqN22ErViCsN7/qCYb3eiLiIlngKej0rqjfap3KWVNVe
 Ib7NoQzUbrDmMcEcUeOlgaHVNqKP3H2LoJjBCg0Lq/y2u46iFDtQg8y0fN4PXNA5E82e
 CF8TGduqlE9eocg1qU7lsazhpmxHdY+4VJH4F2+WdCmDdB+Wx2YcoAAFs/XCfSH0W2LP
 8E/5P33eqQPfwYnv5TGNg8DoTOnm0Df1x65Xuci4RGhDmdDViGnhDfnnDt5Rp4v7d9e2
 uKAWOWVylJEI1wzTxibChmgGZ3Yne1+kRLArwLfNDbhiz/6Br7T7BSlh6Al4zVz+1S2m
 4UbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ90aMW1dT5LZMTpa/8g/4YI8hb6nmUJOSVA+0xpFhE5liVtikWa24oM9gxXXnhfWGwYWXjViZMHXrYO@nongnu.org
X-Gm-Message-State: AOJu0Ywg0fYtdnwhOflP5T0o6El1rgJxDItHRcKul9zXH54ThlYCm9GM
 xjSvBzZGsG8fff72qip8twGLL5yXF+wI6aYLJZioqt5SFF6HejprXZ03C6VuM4S3dWQ=
X-Gm-Gg: Acq92OFIelS3kaW+liHefZ1OQGzmTdwxXefEJY5a24mp+5XniX6auuelSKh3axIulkW
 DDSLmqU/0/hmPdTgqYazcxUMPRy3nRYvcYLjj+fSkBKxOaNn7wNJ4w8TZQpZPv3yr6lMJu0ZA5i
 gZuw9MbNwaYkLVD/O0nWgqHreXH5RrMin39aRzBjIUcbsRiPMmYK2xSxMXlYqTO+4Vd76GZIn5J
 ONFAdNa9qu89Z/vtjRkS/8e9Dp3gom5zSTjxZCQRWN+S+WVdUKemk7N1CTNrwPTXHd4ni24Ufiu
 QGIkXVSQuTghMC6khpIyjtsPqxubcNgboMWYyaMDPBKz9Z14r7DeKjleuPaQUpi4IM9CFayP1nd
 tZ9y3LCbPLrCHF30QBoyizT11ptMwrguFZqXjbf/f79NlGNLK3lEEIAH3gVQrhww983jyECM77F
 kKBtmzq2a9qLTErggG1ERsO7C1ZTfFTFKLN2bY5ZFwDQ==
X-Received: by 2002:a05:6402:1941:b0:670:4445:c326 with SMTP id
 4fb4d7f45d1cf-680cde24cacmr1310353a12.7.1778582528615; 
 Tue, 12 May 2026 03:42:08 -0700 (PDT)
Received: from [10.93.128.145] ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0b6a648sm4907999a12.7.2026.05.12.03.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 03:42:08 -0700 (PDT)
Message-ID: <1fec82cd-33ff-4cbf-9f8b-c14a5cf622a5@9elements.com>
Date: Tue, 12 May 2026 12:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] ast2600: yosemite4 initial support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, titusr@google.com
References: <20260505154410.230969-1-alexander.hansen@9elements.com>
 <20260505154410.230969-5-alexander.hansen@9elements.com>
 <78ded35c-18d9-4469-a20d-6974646e4557@kaod.org>
Content-Language: en-US
From: Alexander Hansen <alexander.hansen@9elements.com>
In-Reply-To: <78ded35c-18d9-4469-a20d-6974646e4557@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alexander.hansen@9elements.com; helo=mail-ed1-x52f.google.com
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

Hi Cedric,

thanks for your ongoing review :)

I sent v5, summary of changes:

- I CCd you and Titus on all the patches now.
- removed the backticks (markdown syntax) from my patches. I was used to 
this workflow since some other projects use commit linters which get 
tripped up by log outputs.
- restructured the series as you suggested (board, then functional test, 
then sensors)
- removed some unused includes on the machine file
- removed some unnecessary variables from the machine file
- linked to your github tree for the fw image for the functional test, 
since the image is now available there
- added new section for each sensor to the functional test with some 
command sequences and expected outputs
- added new entries in MAINTAINERS file for Titus for the individual 
sensors. Your maintenance of the fby4 seems to already be covered by 
existing regex.

Let me know in case there is extra tests i should write for the sensors 
other than the functional test.

I saw the tests/qtest/tmp105-test.c , would that be helpful for the new 
sensors as well to write a test like that?

Thanks,

Alexander

On 5/9/26 18:39, Cédric Le Goater wrote:
> Hello Alexander,
>
> Could you please cc: me on the whole series ? I'd like to see
> what the rest is about. However, I am not the sensor maintainer,
> Titus is.
>
> On 5/5/26 17:42, Alexander Hansen wrote:
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
>>
>> Tested: functional test (see [5] for the image) passed.
>>
>> ```
>
> Please remove the markdown annotations. This is a git commit log.
>
>> export QEMU_TEST_QEMU_BINARY=qemu-system-arm
>> ./build/run tests/functional/arm/test_aspeed_fby4.py
>> TAP version 13
>> ok 1 
>> test_aspeed_fby4.YosemiteV4Machine.test_arm_ast2600_yosemitev4_openbmc
>> 1..1
>> ```
>>
>> References:
>> [1] 
>> https://github.com/9elements/qemu/commit/32139f913c2bd0ebe4bd26c46765861f6f9f2d49
>> [2] arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
>> [3] https://github.com/legoater/qemu-aspeed-boot/pull/5
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
>>   hw/arm/aspeed_ast2600_fby4.c             | 289 +++++++++++++++++++++++
>>   hw/arm/meson.build                       |   1 +
>>   tests/functional/arm/meson.build         |   2 +
>>   tests/functional/arm/test_aspeed_fby4.py |  44 ++++
>
> I would prefer the functional test to be proposed in its own patch.
>
> The machine looks good. Just a few minor comments.
>
>>   4 files changed, 336 insertions(+)
>>   create mode 100644 hw/arm/aspeed_ast2600_fby4.c
>>   create mode 100755 tests/functional/arm/test_aspeed_fby4.py
>>
>> diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
>> new file mode 100644
>> index 0000000000..284f64e3f3
>> --- /dev/null
>> +++ b/hw/arm/aspeed_ast2600_fby4.c
>> @@ -0,0 +1,289 @@
>> +/*
>> + * Yosemite V4
>> + *
>> + * Copyright 2026 9elements.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
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
>
> I don't think this include is needed.
>
>
>> +
>> +#define FBY4_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
>> +
>> +/* START OF EEPROM CONTENTS */
>> +
>> +/*
>> + *./frugen -s board.mfg="Wiwynn" \
>> + * --set board.pname="Fan Board FSC-MAX ADC-TI LED-NXP EFUSE-MAX" \
>> + * --set text:board.pn="BRD-PN-345" \
>> + * --board-date "10/1/2017 12:58:00" \
>> + * --set board.serial="123456" \
>> + * --set product.pname="Yosemite V4" \
>> + * --set product.mfg="Wiwynn" \
>> + * --set product.ver="v1.1" \
>> + * --set product.serial="123456" \
>> + * --set product.atag="PLACEHOLDER" \
>> + * --set product.custom="Fanboard Custom1" \
>> + * --set product.custom.1="Fanboard Custom2" \
>> + * --set text:product.pn="PN-345" \
>> + * fru-yv4-fanboard.bin
>> + */
>> +/* EM Config: 
>> yosemite4_fanboard_fsc_max_adc_ti_led_nxp_ons_efuse_max.json */
>> +/* Yosemite4 fan board */
>> +static const uint8_t fru_yv4_fanboard_bin[] = {
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
>> +static const size_t fru_yv4_fanboard_bin_len = 
>> sizeof(fru_yv4_fanboard_bin);
>> +
>> +/*
>> + *./frugen -s board.mfg="Wiwynn" \
>> + * --set board.pname="Sentinel Dome without Retimer" \
>> + * --set text:board.pn="BRD-PN-345" \
>> + * --board-date "10/1/2017 12:58:00" \
>> + * --set board.serial="123456" \
>> + * --set product.pname="Yosemite V4" \
>> + * --set product.mfg="Wiwynn" \
>> + * --set product.ver="v1.1" \
>> + * --set product.serial="123456" \
>> + * --set product.atag="PLACEHOLDER" \
>> + * --set product.custom="Yosemite V4 T1" \
>> + * --set product.custom.1="Yosemite V4 T1" \
>> + * --set text:product.pn="PN-345" \
>> + * fru-yv4-sentineldome-board.bin
>> + */
>> +/* product.cust maps to PRODUCT_INFO_AM2 */
>> +/* EM Config: yosemite4_sentineldome_t1.json */
>> +/* Yosemite4 Sentinel Dome without Retimer Boards */
>> +static const uint8_t fru_yv4_sentineldome_board_bin[] = {
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
>> +static const size_t fru_yv4_sentineldome_board_bin_len =
>> +    sizeof(fru_yv4_sentineldome_board_bin);
>> +
>> +/*
>> + *./frugen -s board.mfg="Wiwynn" \
>> + * --set board.pname="Sentinel Dome" \
>> + * --set text:board.pn="BRD-PN-345" \
>> + * --board-date "10/1/2017 12:58:00" \
>> + * --set board.serial="123456" \
>> + * --set product.pname="Yosemite V4" \
>> + * --set product.mfg="Wiwynn" \
>> + * --set product.ver="v1.1" \
>> + * --set product.serial="123456" \
>> + * --set product.atag="PLACEHOLDER" \
>> + * --set text:product.pn="PN-345" \
>> + * fru-yv4-sentineldome-chassis.bin
>> + */
>> +/* EM Config: yosemite4_sentineldome_chassis.json */
>> +/* Yosemite 4 Sentinel Dome Chassis FRU */
>> +static const uint8_t fru_yv4_sentineldome_chassis_bin[] = {
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
>> +static const size_t fru_yv4_sentineldome_chassis_bin_len =
>> +    sizeof(fru_yv4_sentineldome_chassis_bin);
>> +
>> +/*
>> + *./frugen -s board.mfg="Wiwynn" \
>> + * --set board.pname="Management Board wBMC" \
>> + * --set text:board.pn="BRD-PN-345" \
>> + * --board-date "10/1/2017 12:58:00" \
>> + * --set board.serial="123456" \
>> + * --set product.pname="Yosemite V4" \
>> + * --set product.mfg="Wiwynn" \
>> + * --set product.ver="v1.1" \
>> + * --set product.serial="123456" \
>> + * --set product.atag="PLACEHOLDER" \
>> + * --set text:product.pn="PN-345" \
>> + * fru-yv4-eclosure.bin
>> + */
>> +/* EM Config: yosemite4_chassis.json, yosemite4.json */
>> +/* Yosemite 4 Sentinel Dome Enclosure FRU */
>> +static const uint8_t fru_yv4_eclosure_bin[] = {
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
>> +static const size_t fru_yv4_eclosure_bin_len = 
>> sizeof(fru_yv4_eclosure_bin);
>> +
>> +/* END OF EEPROM CONTENTS */
>> +
>> +static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t 
>> eepromSize)
>> +{
>> +    /* 2 fan boards */
>> +    for (int i = 0; i <= 1; i++) {
>> +        /* downstream bus */
>> +        I2CBus *bus = pca954x_i2c_get_bus(fan_mux, i);
>> +
>> +        /* ti,adc128d818 @ 0x1f    (adc) */
>> +        /* the driver will throw away the last 4 bits, set them 0 */
>> +        static const uint16_t adc_values1[8] = {
>> +            0b011110000000, 0b010100010000,
>> +            0b001000110000, 0b100000100000,
>> +            0b011110000000, 0b010100010000,
>> +            0b001000110000, 0b100000100000};
>> +        adc128d818_init_with_values(bus, 0x1f, adc_values1, 8);
>> +
>> +        /* maxim,max31790 @ 0x20   (pwm) */
>> +        i2c_slave_create_simple(bus, TYPE_MAX31790, 0x20);
>> +
>> +        /*
>> +         * ti,tca6424 @ 0x22       (gpio)
>> +         * linux handles tca6424 with PCA953X_TYPE, same as pca9535
>> +         * { "pca9535", 16 | PCA953X_TYPE | PCA_INT, },
>> +         * { "tca6424", 24 | PCA953X_TYPE | PCA_INT, },
>> +         * so we _could_ be fine here unless more than 16 gpios are 
>> used
>> +         */
>> +        i2c_slave_create_simple(bus, TYPE_PCA9535, 0x22);
>> +
>> +        /*
>> +         * NOTE: above works and could use for gpio presence:
>> +         * $ gpioget gpiochip2 2
>> +         * 1
>> +         */
>> +
>> +        /* maxim,max31790 @ 0x2f   (pwm) */
>> +        i2c_slave_create_simple(bus, TYPE_MAX31790, 0x2f);
>> +
>> +        /* maxim,max11615 @ 0x33   (adc) */
>> +        static const uint16_t adc_values[8] = {
>> +            0b011110000010, 0b010100011000,
>> +            0b001000110100, 0b100000101001,
>> +            0b011110000010, 0b010100011000,
>> +            0b001000110100, 0b100000101001};
>> +        max11615_init_with_values(bus, 0x33, adc_values, 8);
>> +
>> +        at24c_eeprom_init_rom(
>> +            bus, 0x52, eepromSize,
>> +            fru_yv4_fanboard_bin,
>> +            fru_yv4_fanboard_bin_len);
>> +
>> +        /* LED blink driver / gpio expander */
>> +        /* nxp,pca9552 @ 0x61   (gpio) */
>> +        i2c_slave_create_simple(bus, TYPE_PCA9552, 0x61);
>> +    }
>> +}
>> +
>> +static void fby4_i2c_init_blade_chassis(I2CBus *bus, size_t eepromSize)
>> +{
>> +    /* Sentinel Dome Blade EEPROMS */
>> +
>> +    /* Board */
>> +    at24c_eeprom_init_rom(bus, 0x54, eepromSize,
>> +        fru_yv4_sentineldome_board_bin, 
>> fru_yv4_sentineldome_board_bin_len);
>> +
>> +    /* Chassis */
>> +   at24c_eeprom_init_rom(bus, 0x55, eepromSize,
>> +       fru_yv4_sentineldome_chassis_bin, 
>> fru_yv4_sentineldome_chassis_bin_len);
>> +}
>> +
>> +static void fby4_i2c_init_multiple_blade_chassis(I2CBus **i2c,
>> +    size_t eepromSize)
>> +{
>> +    /* there is 8 blade chassis, but we only emulate 2 for 
>> performance reason */
>> +    for (int bus = 1; bus <= (8 / 4); bus++) {
>> +
>
> Extra line.
>
>> + fby4_i2c_init_blade_chassis(i2c[bus], eepromSize);
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
>
> These variables seem superflous.
>
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
>> +static void aspeed_machine_fby4_class_init(ObjectClass *oc, const 
>> void *data)
>> +{
>> +    MachineClass *mc = MACHINE_CLASS(oc);
>> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
>> +
>> +    mc->desc       = "Facebook fby4 BMC (Cortex-A7)";
>> +    amc->fmc_model = "mx66l1g45g";
>> +    amc->num_cs    = 2;
>> +    amc->macs_mask = ASPEED_MAC3_ON;
>> +    amc->i2c_init  = fby4_i2c_init;
>> +    mc->default_ram_size = FBY4_BMC_RAM_SIZE;
>> +    aspeed_machine_class_init_cpus_defaults(mc);
>> +}
>> +
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
>> diff --git a/tests/functional/arm/meson.build 
>> b/tests/functional/arm/meson.build
>> index 2f538f29a2..10c0006f22 100644
>> --- a/tests/functional/arm/meson.build
>> +++ b/tests/functional/arm/meson.build
>> @@ -14,6 +14,7 @@ test_arm_timeouts = {
>>     'aspeed_ast2600_sdk_otp' : 720,
>>     'aspeed_bletchley' : 480,
>>     'aspeed_catalina' : 480,
>> +  'aspeed_fby4': 480,
>>     'aspeed_gb200nvl_bmc' : 480,
>>     'aspeed_rainier' : 480,
>>     'bpim2u' : 500,
>> @@ -47,6 +48,7 @@ tests_arm_system_thorough = [
>>     'aspeed_ast2600_sdk_otp',
>>     'aspeed_bletchley',
>>     'aspeed_catalina',
>> +  'aspeed_fby4',
>>     'aspeed_gb200nvl_bmc',
>>     'aspeed_rainier',
>>     'bpim2u',
>> diff --git a/tests/functional/arm/test_aspeed_fby4.py 
>> b/tests/functional/arm/test_aspeed_fby4.py
>> new file mode 100755
>> index 0000000000..9679e4a1c5
>> --- /dev/null
>> +++ b/tests/functional/arm/test_aspeed_fby4.py
>> @@ -0,0 +1,44 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that boots the ASPEED machines
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +from qemu_test import Asset
>> +from aspeed import AspeedTest
>> +
>> +
>> +class YosemiteV4Machine(AspeedTest):
>> +
>> +    ASSET_YOSEMITE_V4_FLASH = Asset(
>> + 
>> 'https://github.com/pointbazaar/qemu-aspeed-boot/raw/3ef9a0d8cd2902c2039924ad1f16c8f2345486f3/images/yosemite4-bmc/openbmc-20260505132843/obmc-phosphor-image-yosemite4-20260505132843.static.mtd.xz',
>> + 'dff6946363b41f952b15cfc3156482b89fcfc1b0ecfc3ec8b3ed496a5f001ef9')
>
> Now that the yosemite4 image is merged in my image test tree, may be
> it is best to update the asset ? As you wish. Works like that too.
>
>> +
>> +    def do_test_arm_aspeed_openbmc_no_network(self, machine, image, 
>> uboot,
>> +                                   cpu_id, soc):
>> +
>> +        self.set_machine(machine)
>> +        self.vm.set_console()
>> +        self.vm.add_args('-drive', f'file={image},if=mtd,format=raw',
>> +                         '-snapshot')
>> +        self.vm.launch()
>> +
>> +        self.wait_for_console_pattern(f'U-Boot {uboot}')
>> +        self.wait_for_console_pattern('## Loading kernel from FIT 
>> Image')
>> +        self.wait_for_console_pattern('Starting kernel ...')
>> +        self.wait_for_console_pattern(f'Booting Linux on physical 
>> CPU {cpu_id}')
>> +        self.wait_for_console_pattern(f'ASPEED {soc}')
>> +        self.wait_for_console_pattern('/init as init process')
>> +        # yosemite v4 does not emit the hostname log which is
>> +        # different from the other machines.
>> +        self.wait_for_console_pattern('yosemite4 login:')
>> +
>> +    def test_arm_ast2600_yosemitev4_openbmc(self):
>> +        image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
>> +
>> +        self.do_test_arm_aspeed_openbmc_no_network('fby4-bmc', 
>> image=image_path,
>> +                                        uboot='2019.04', 
>> cpu_id='0xf00',
>> +                                        soc='AST2600 rev A3')
>
>
> I don't see any tests regarding the new sensor models.
>
> The commit logs of patch 1-3 :
>
>   hw/sensor: MAX31790 support
>   hw/sensor: support MAX11615
>   hw/sensor: support Texas Instruments ADC128D818
>
> contain Linux command sequences that could be included in this test
> case. Could you do that please ?
>
> Also, for sensors, please cc:
>
>  Titus Rwantare <titusr@google.com>
>
> and we will need new entries under MAINTAINERS.
>
> Thanks,
>
> C.
>

