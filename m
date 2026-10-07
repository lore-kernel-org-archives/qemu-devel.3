Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682F9CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEQK4-00050J-DL; Wed, 07 Oct 2026 08:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEQJo-0004qz-MX
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:00:21 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEQJm-0000Lh-QC
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:00:20 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48b9d8055dfso3316067f8f.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 05:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791374417; x=1791979217; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8IM2yFcIuUTlPPR93lMuCwkoZS9UdQ+IlbsfQ+DAECU=;
 b=MYgdAI7fheW1ajYEGhIPEb7gpl9I4dRxdJInskz1HgKAyTCqMZJPlzfarQ6UJ68nRa
 nBo7JZPzwjXIsWfssuBHruANPwsUwShpynq2aD1W/yE8FDi4G/iZgKQRh/RjgRtiZVPk
 QFBns5hmalTdDNPfozIrq+mTKKZQ4mVISx+/EVj2r8LPIyKm1YU8vJv0Qg2vlh+c3ppY
 KYIX3Pt6g3NaJBbsfRG2sUYiEdgOLtp0G5eFbES/eaAL8WXaSIpcEJsT+YN2k8xwZIj8
 YKKXGvbfVFZB29weRcdQHSTS3tgx5NXUFIY2pf0Pxxe5oOEH09e3aihKnRb5RVnPplGg
 RCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791374417; x=1791979217;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8IM2yFcIuUTlPPR93lMuCwkoZS9UdQ+IlbsfQ+DAECU=;
 b=bSxqlZRxizKU/EAgsirMe9UodqORl2id+YbslUXykwp7/jREtgLPFunPVNCg/KB5Kl
 YnDTUWrCvMyCNEbO1tuNKvmSGKrUtTevcofyAMU1p4kpQZ4POFu7AKc1o+peVSXVM5fd
 8dKPVWQ7gZsWcGtHkQNSdAzC5dG/+WEQOw10OAqTx7nQs9WNBV3WaWJNKulwnYc0Skor
 1rgTAukM1Y4uNtMB+VrLDI9URwzmnZiyFlumGvmsPmIRm220snstl81hamY9XMF+9z+1
 AiNcmf4+aLQ59fOCKAUjlkeVW4So5q+p/qOOGfBadRcTkNTjQPVQhbFAmpzzlHAQOK5i
 35vg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxq9V5xZ+92YfuvQBUwYajU6+PZdUrMGKv4b/aiYY292hVKhFnucAQQJKFDHRPTzjWBwT37dMFsfcB@nongnu.org
X-Gm-Message-State: AFq9FYIGDl4gFFYZOH9ZqMfxeySY53xPGI/2YBoxN8QQqb+wVyT72TaK
 7PfXAlKKUr48eJcdviex/hCubF2GdtkVLHj8A5t+nHn0C+E/JzgzFn6b
X-Gm-Gg: AYBFou3RNuvBxLQq8/1AsemM9oOPz2nCmfwqMMw61qQRIE0zVMwxsV3igxf2TB2HsR7
 QeWt1lhT9CaidXSWc9I+XTaS5t6fHa4IxA3OSA3NKLTEHfP0adc+CAxLcIgDESTFOGazm1+p9rx
 aOunsmHBHfEMWg34WtAnRIjrdn0bk4sev1MIFGHZS1fFssIzpVpHHk1sAldVgSSPhuu+R8TI2ws
 80EyXWBpvMXrBBzU5n4hRadEawXS12oRZVQJEyXQSPkXrhichwOasUnG490gVafrKrA1ge2Vj8O
 A4cGl2af3YBqqsQl9kPo1tk7pWk6Z5J9fLN1lJ+ufhqOa31PuXb8v0eNVBfIFVkejpfCHjoSQpb
 oSabc+7/fdV6p72UrxrRdDrPiyoNDcA/5lnqr/EgBOhxRg2bmvzB3sGzTJU8G2/3mZJNSWduww8
 lTV9kHMvsmQnrhp5Kp+KdtfyrgqPUUOmD8pSMPzPGlhUiHujnVTDSKbclX7QfJlkjBFj3dtAo8P
 FwcMMucbRvYSNbwXR7BzbrGAE3UgliefElbzwPuZhlrlEsknwQ9puGOtFtSxHaceWSEKJmCzVr3
 JT5SPA==
X-Received: by 2002:a05:6000:25f6:b0:48c:67d6:a87a with SMTP id
 ffacd0b85a97d-48c72786a1emr4216404f8f.32.1791374416555; 
 Wed, 07 Oct 2026 05:00:16 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf09ae00acd063e77b8fcf27.dip0.t-ipconnect.de.
 [2003:fa:af09:ae00:acd0:63e7:7b8f:cf27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d3f05asm7006854f8f.55.2026.10.07.05.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 05:00:15 -0700 (PDT)
Date: Wed, 07 Oct 2026 12:00:12 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
CC: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>, Alistair Francis <alistair@alistair23.me>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_12/31=5D_hw/arm/fsl-imx?=
 =?US-ASCII?Q?25=3A_Derive_from_TYPE=5FSYS=5FBUS=5FDEVICE?=
In-Reply-To: <9fff40ae-6378-41c8-9cff-74d4a15645de@oss.qualcomm.com>
References: <20261006083445.30362-1-shentey@gmail.com>
 <20261006083445.30362-13-shentey@gmail.com>
 <d63caf07-24f1-4911-b0f9-f375c48b6159@oss.qualcomm.com>
 <1EAADDBD-1ED9-47BA-81AA-E6539880B7E4@gmail.com>
 <9fff40ae-6378-41c8-9cff-74d4a15645de@oss.qualcomm.com>
Message-ID: <A8B6BD08-C23F-4029-91F6-575D04C7C3D2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42e.google.com
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



Am 6=2E Oktober 2026 10:01:51 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@oss=2Equalcomm=2Ecom>:
>On 2026-10-06 11:47, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 6=2E Oktober 2026 09:26:52 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@oss=2Equalcomm=2Ecom>:
>>> On 6/10/26 10:34, Bernhard Beschow wrote:
>>>> Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset up=
on
>>>> machine reset=2E
>>>>=20
>>>> Reviewed-by: Bin Meng <bin=2Emeng@processmission=2Ecom>
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>> ---
>>>>    include/hw/arm/fsl-imx25=2Eh | 5 ++---
>>>>    hw/arm/fsl-imx25=2Ec         | 7 +------
>>>>    hw/arm/imx25_pdk=2Ec         | 2 +-
>>>>    3 files changed, 4 insertions(+), 10 deletions(-)
>>>>=20
>>>> diff --git a/include/hw/arm/fsl-imx25=2Eh b/include/hw/arm/fsl-imx25=
=2Eh
>>>> index b68d4334a0=2E=2E4bb4d5b3e5 100644
>>>> --- a/include/hw/arm/fsl-imx25=2Eh
>>>> +++ b/include/hw/arm/fsl-imx25=2Eh
>>>> @@ -29,6 +29,7 @@
>>>>    #include "hw/sd/sdhci=2Eh"
>>>>    #include "hw/usb/chipidea=2Eh"
>>>>    #include "hw/watchdog/wdt_imx2=2Eh"
>>>> +#include "hw/core/sysbus=2Eh"
>>>>    #include "system/memory=2Eh"
>>>>    #include "target/arm/cpu=2Eh"
>>>>    #include "qom/object=2Eh"
>>>> @@ -45,10 +46,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX25State, FSL_IMX2=
5)
>>>>    #define FSL_IMX25_NUM_USBS 2
>>>>      struct FslIMX25State {
>>>> -    /*< private >*/
>>>> -    DeviceState parent_obj;
>>>> +    SysBusDevice parent_obj;
>>>>    -    /*< public >*/
>>>>        ARMCPU         cpu;
>>>>        IMXAVICState   avic;
>>>>        IMX25CCMState  ccm;
>>>> diff --git a/hw/arm/fsl-imx25=2Ec b/hw/arm/fsl-imx25=2Ec
>>>> index 7f65f4ca4b=2E=2Eefb22359c5 100644
>>>> --- a/hw/arm/fsl-imx25=2Ec
>>>> +++ b/hw/arm/fsl-imx25=2Ec
>>>> @@ -317,16 +317,11 @@ static void fsl_imx25_class_init(ObjectClass *o=
c, const void *data)
>>>>        device_class_set_props(dc, fsl_imx25_properties);
>>>>        dc->realize =3D fsl_imx25_realize;
>>>>        dc->desc =3D "i=2EMX25 SOC";
>>>> -    /*
>>>> -     * Reason: uses serial_hds in realize and the imx25 board does n=
ot
>>>> -     * support multiple CPUs
>>>> -     */
>>>> -    dc->user_creatable =3D false;
>>>=20
>>> Can we explain this change?
>>=20
>> SysBus devices aren't user-creatable, are they?
>
>"Remove clearing user-creatable which is implicit for
> SysBus-based devices" comment would have cleared any
> doubts=2E

All patches are reviewed now, thanks! So this series probably won't need a=
 respin in which case I had incorporated above sentence into the commit mes=
sage myself=2E I'm fine if this got done when merging=2E

Best regards,
Bernhard

