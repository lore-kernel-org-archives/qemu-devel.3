Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBAEC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLCG-0005ve-GI; Thu, 02 Jul 2026 13:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfLCF-0005vF-IE
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:27:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfLC8-0007HF-Uf
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:27:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso12910295e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783013243; x=1783618043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8wUrJbRI3+sPbnvKF7cZc3/wpj90N524U9qWP5hr48=;
 b=QRuRz65Oq8JLPosJu0EdlIBGQNPWUSuUyW/uScVIbaIH/l2ZmWs8Y4XPc4oyy1JTpj
 wWJ3gov2I4XcymfO63cszh3dQYQ9eay/tjSpf36Ddt3RtPrGEYgEt90GUglRNWahznVw
 fLxqFGaXoKKyJh/BwxbyT+wzoPpdxa7w4xC7KhP0zY8jV/7AKN/HVenvoArcd4+WrAKU
 BKAV/yealK0hYT41Em4l+Q/NLSXu9zfj8jDMm8kDrso1oY8yY46qF3TR+ZA1EuuxMixf
 cY4sZvUi+9hviDoumgJZUPLJ/FCY+YDR2H9CIBJ4n9lZh6ODLkZua6S2vKtSdwq2g2+V
 e+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783013243; x=1783618043;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+8wUrJbRI3+sPbnvKF7cZc3/wpj90N524U9qWP5hr48=;
 b=Kf8CUsPZj58JlpbsaNWUj+HoZ/P6vA5xNDrNLHHcOVaK2WK1CcitsTcn8WTKgFMSTj
 PMV/WiEsiovM1RKyRhoyG9naMsa1KeVO2lO/lY0jC7aOcwJfDHuhXStxk8v61KuTIb0R
 UGRj0M0lfss41GZZ5EDK9cENIJZmOYiAhazvkWu9Bg59H/qO/enjJacrGxEkdnfntyaz
 P/W7FfY/Hwl+iXwKDInyUlX99sdQdh4GmOTfhO9M+Dgsy86Y1R4mQ/9rZ5oinp1kLCIE
 X/cuE1SyBQvY3kJowghbf8s/CSaylkYnrtyPj2X9LtIyQXyNxdDsXfbFC+HYwPlZixrW
 /N4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1ItO6whpeRfC2jFfbawz68rMrjClA0Ea447v6O45HPVWcsYcGCrSIL3sen6J2bH4wLGJfUl1XnUQr@nongnu.org
X-Gm-Message-State: AOJu0YwQ1jxdfAjjg3DtLz35bFpczG9I2OE6yfrz0/36uYgVi9HTf9Ni
 /5rqvOpag73HXwx3ohBn7cJkMcZla3dDk1n8gVRkJELYKbKvTv9ckWmx
X-Gm-Gg: AfdE7cnKf3sVlujQ2WKesyMh2b+x/U8CopBpncx7CI9bJHzkhXSw/PWRZJrnVq92WIh
 nhq8ApBVSHn5kYXtd9X7t1ryFn7kDTtk1JW8CH3bQF23jrTcorkkV4fQ2ypOSq7nXJmmLLmAYbL
 NqVBWIQOnmZLMq2NvxsGv+lij1o50OctOC5Lup1ZvxZ5NWSfdsrcmY/FpKHGRTydJv23PGcOJ21
 KcBIDREptRFEvRkHepx/akneJ2chch4pD31H8scylCc1UvU19T0RH5oEBfHY/N7wmP3cQRzdFvL
 Ifth1xs8EQI/8v+4lAxFQua5etoKdCcIfB3n2sbz+ezOmOis8MdwF7GD8xNWJXn5oUhlj2thbRv
 Y3V0zrBljMRFiLqhYQiUQmXL/2TmT7T3wGKmnbNWz87K+KYtrbX3r+KL60/xP4fMgFvGZQ8Sa5+
 1+RFJbkzHVBxdwTkeaOcM=
X-Received: by 2002:a05:600c:3510:b0:493:be08:c372 with SMTP id
 5b1f17b1804b1-493c2b43923mr108915215e9.17.1783013243026; 
 Thu, 02 Jul 2026 10:27:23 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.238.219.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c6372368sm72990735e9.12.2026.07.02.10.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:27:22 -0700 (PDT)
Date: Thu, 02 Jul 2026 17:13:26 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>
CC: Peter Maydell <peter.maydell@linaro.org>, Pavel Pisa <pisa@fel.cvut.cz>
Subject: Re: [PULL 34/54] hw/net/can/flexcan: NXP FlexCAN core emulation
In-Reply-To: <77d5891c-de12-467e-8746-02fe43121e3e@oss.qualcomm.com>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
 <20260629120032.1645265-35-peter.maydell@linaro.org>
 <77d5891c-de12-467e-8746-02fe43121e3e@oss.qualcomm.com>
Message-ID: <19F69CC0-3BB0-41E4-93B0-D86215CB9B1F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001, FREEMAIL_REPLY=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 2=2E Juli 2026 12:37:59 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phil=
md@oss=2Equalcomm=2Ecom>:
>Hi Maty=C3=A1=C5=A1,
>
>On 29/6/26 14:00, Peter Maydell wrote:
>> From: Maty=C3=A1=C5=A1 Bobek <matyas=2Ebobek@gmail=2Ecom>
>>=20
>> Added the FlexCAN2 emulator implementation core, with
>> CAN_FLEXCAN Kconfig flag and MAINTAINERS entry=2E
>>=20
>> FlexCAN2 version can be found in i=2EMX6 SoCs and others=2E
>>=20
>> More information about the implementation can be found in [1]=2E
>>=20
>> Some macro and struct defintions were borrowed from the Linux kernel=2E
>> The original authors agreed with relicensing them to GPL-2=2E0-or-later=
 on
>> the qemu-devel mailing list=2E
>>=20
>> [1] http://dspace=2Ecvut=2Ecz/bitstream/handle/10467/122654/F3-BP-2025-=
Bobek-Matyas-BP_Bobek_FlexCAN_final_4=2Epdf
>>=20
>> Signed-off-by: Maty=C3=A1=C5=A1 Bobek <matyas=2Ebobek@gmail=2Ecom>
>> Signed-off-by: Pavel Pisa <pisa@fel=2Ecvut=2Ecz>
>> Tested-by: Pavel Pisa <pisa@fel=2Ecvut=2Ecz>
>> Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> Reviewed-by: Pavel Pisa <pisa@fel=2Ecvut=2Ecz>
>> Message-id: 03dc62ff8013bb946aab8f64e51638b810629529=2E1782140438=2Egit=
=2Ematyas=2Ebobek@gmail=2Ecom
>> Signed-off-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>> ---
>>   MAINTAINERS               |    8 +
>>   hw/net/Kconfig            |    5 +
>>   hw/net/can/flexcan=2Ec      | 1396 ++++++++++++++++++++++++++++++++++=
+++
>>   hw/net/can/flexcan_regs=2Eh |  197 ++++++
>>   hw/net/can/meson=2Ebuild    |    1 +
>>   hw/net/can/trace-events   |   18 +
>>   include/hw/net/flexcan=2Eh  |  145 ++++
>>   7 files changed, 1770 insertions(+)
>
>This commit is huge, not easy to follow / review=2E
>
>>   create mode 100644 hw/net/can/flexcan=2Ec
>>   create mode 100644 hw/net/can/flexcan_regs=2Eh
>>   create mode 100644 include/hw/net/flexcan=2Eh
>
>
>> diff --git a/hw/net/can/flexcan=2Ec b/hw/net/can/flexcan=2Ec
>> new file mode 100644
>> index 0000000000=2E=2E1ea459d9f6
>> --- /dev/null
>> +++ b/hw/net/can/flexcan=2Ec
>> @@ -0,0 +1,1396 @@
>> +/*
>> + * QEMU model of the NXP FLEXCAN device=2E
>> + *
>> + * This implementation is based on the following reference manual:
>> + * i=2EMX 6Dual/6Quad Applications Processor Reference Manual
>> + * Document Number: IMX6DQRM, Rev=2E 6, 05/2020
>> + *
>> + * Copyright (c) 2025 Matyas Bobek <matyas=2Ebobek@gmail=2Ecom>
>> + *
>> + * Based on CTU CAN FD emulation implemented by Jan Charvat=2E
>> + *
>> + * SPDX-License-Identifier: GPL-2=2E0-or-later
>> + */
>> +
>> +#include "qemu/osdep=2Eh"
>> +#include "qemu/log=2Eh"
>> +#include "hw/core/sysbus=2Eh"
>> +#include "qapi/error=2Eh"
>> +#include "hw/core/irq=2Eh"
>> +#include "migration/vmstate=2Eh"
>> +#include "net/can_emu=2Eh"
>> +#include "hw/core/qdev-properties=2Eh"
>> +#include "trace=2Eh"
>> +
>> +#include "hw/net/flexcan=2Eh"
>> +#include "flexcan_regs=2Eh"
>> +#include "qemu/timer=2Eh"
>
>
>> +/**
>> + * flexcan_get_bitrate() - Calculate CAN bitrate (in Hz)
>> + * @s: FlexCAN device pointer
>> + *
>> + * The bitrate is determined by FlexCAN configuration in CTRL1 registe=
r,
>> + * and CCM co
>> + */
>> +static uint32_t flexcan_get_bitrate(FlexcanState *s)
>> +{
>> +    uint32_t conf_presdiv =3D (s->regs=2Ectrl & FLEXCAN_CTRL_PRESDIV_M=
ASK) >> 24;
>> +    uint32_t conf_pseg1 =3D (s->regs=2Ectrl & FLEXCAN_CTRL_PSEG1_MASK)=
 >> 19;
>> +    uint32_t conf_pseg2 =3D (s->regs=2Ectrl & FLEXCAN_CTRL_PSEG2_MASK)=
 >> 16;
>> +    uint32_t conf_propseg =3D s->regs=2Ectrl & FLEXCAN_CTRL_PROPSEG_MA=
SK;
>> +
>> +    /* N of time quanta for segments */
>> +    uint32_t tseg1 =3D 2 + conf_pseg1 + conf_propseg;
>> +    uint32_t tseg2 =3D 1 + conf_pseg2;
>> +    uint32_t total_qpb =3D 1 + tseg1 + tseg2;
>> +
>> +    uint32_t pe_freq, s_freq, bitrate;
>> +
>> +    assert(s->ccm);
>
>Instead of that deep buried late unexplained assertion crashing
>when the guest is running, =2E=2E=2E
>
>> +
>> +    /* s_freq: CAN clock from CCM divided by the prescaler */
>> +    pe_freq =3D imx_ccm_get_clock_frequency(s->ccm, CLK_CAN);
>> +    s_freq =3D pe_freq / (1 + conf_presdiv);
>> +    bitrate =3D s_freq / total_qpb;
>> +
>> +    trace_flexcan_get_bitrate(DEVICE(s)->canonical_path, pe_freq,
>> +                              1 + conf_presdiv, s_freq, tseg1, tseg2, =
total_qpb,
>> +                              bitrate);
>> +    return bitrate;
>> +}
>> +static void flexcan_init(Object *obj)
>> +{
>> +    FlexcanState *s =3D CAN_FLEXCAN(obj);
>> +
>> +    memory_region_init_io(
>> +        &s->iomem, obj, &flexcan_ops, s, TYPE_CAN_FLEXCAN,
>> +        offsetof(FlexcanRegs, _reserved6)
>> +    );
>> +}
>> +
>> +static void flexcan_realize(DeviceState *dev, Error **errp)
>> +{
>> +    FlexcanState *s =3D CAN_FLEXCAN(dev);
>> +
>> +    if (s->canbus) {
>> +        if (flexcan_connect_to_bus(s, s->canbus) < 0) {
>> +            error_setg(errp, "%s: flexcan_connect_to_bus failed",
>> +                       dev->canonical_path);
>> +            return;
>> +        }
>> +    }
>
>=2E=2E=2E expose it as a link in [*] and check it is set here, returning
>an error to the upper layer before starting emulation:
>
>    if (!s->dma_mr) {
>        error_setg(errp, TYPE_CAN_FLEXCAN " 'clock-control-module' "
>                         "link not set");
>        return;
>    }
>
>> +
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>> +    sysbus_init_irq(SYS_BUS_DEVICE(SYS_BUS_DEVICE(dev)), &s->irq);
>> +}
>> +
>> +static const VMStateDescription vmstate_can =3D {
>> +    =2Ename =3D TYPE_CAN_FLEXCAN,
>> +    =2Eversion_id =3D 1,
>> +    =2Eminimum_version_id =3D 1,
>> +    =2Efields =3D (const VMStateField[]) {
>> +        VMSTATE_INT64(timer_start, FlexcanState),
>> +        VMSTATE_UINT32_ARRAY(regs_raw, FlexcanState, sizeof(FlexcanReg=
s) / 4),
>> +        VMSTATE_INT32(locked_mbidx, FlexcanState),
>> +        VMSTATE_INT32(smb_target_mbidx, FlexcanState),
>> +        VMSTATE_END_OF_LIST(),
>> +    },
>> +};
>> +
>> +static const Property flexcan_properties[] =3D {
>> +    DEFINE_PROP_LINK("canbus", FlexcanState, canbus, TYPE_CAN_BUS,
>> +                     CanBusState *),
>
>[*] here:
>
>       DEFINE_PROP_LINK("clock-control-module", FlexcanState, ccm,
>                        TYPE_IMX_CCM, IMXCCMState *),
>

Yeah, this is even consistent with the "canbus" property=2E I'll take care=
 of it in my imx8mp-flexcan series, so I can address your comment there, to=
o=2E

Best regards,
Bernhard

>> +};
>> +
>> +static void flexcan_class_init(ObjectClass *klass, const void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>> +
>> +    rc->phases=2Eenter =3D flexcan_reset_enter;
>> +    rc->phases=2Ehold =3D flexcan_reset_hold;
>> +    dc->realize =3D flexcan_realize;
>> +    device_class_set_props(dc, flexcan_properties);
>> +    dc->vmsd =3D &vmstate_can;
>> +    dc->desc =3D "i=2EMX FLEXCAN Controller";
>> +}
>> +
>> +static const TypeInfo flexcan_info =3D {
>> +    =2Ename          =3D TYPE_CAN_FLEXCAN,
>> +    =2Eparent        =3D TYPE_SYS_BUS_DEVICE,
>> +    =2Einstance_size =3D sizeof(FlexcanState),
>> +    =2Eclass_init    =3D flexcan_class_init,
>> +    =2Einstance_init =3D flexcan_init,
>> +};
>

