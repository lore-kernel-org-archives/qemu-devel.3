Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50306C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 23:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfS8t-00044j-EK; Tue, 04 Feb 2025 18:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfS8m-00042y-DP; Tue, 04 Feb 2025 18:15:40 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfS8f-0001XF-K3; Tue, 04 Feb 2025 18:15:36 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso42910195e9.3; 
 Tue, 04 Feb 2025 15:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738710924; x=1739315724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xY51GZXLmI4xq4N5TaYgDOm2suzKwumQ6T0OX8XNwHA=;
 b=knynv5ykPXGBGO1HiAPq6yD8OC/Pb/o6FKxy+1CoJk5fi53jxDGfTIhR5VK58QOjDE
 QDCPt/akIYLIgp/DeB1Y6DFO2fy6rM+mxapMRdefOUQfQ9lql9E5VeX1v4Uisv/qD0Wn
 KT213W/jVRLQ9eo8pD+w44+Q19mnvAV0sZkM1xmGWyd9ZIXpLbIZlbLvo7En615NKEci
 6xynsGV/so6iZ3NQi95qBcncDmRwsIT3ZrWirpue579Zw6+2Ao3ZbDfkyCO489h1Va8q
 7toqze11V7YMzOD5aPaZ1OVxH0/gugPHclcf0WFvgUkwRLIQvC95UevgGguez9AplfHJ
 HfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738710924; x=1739315724;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xY51GZXLmI4xq4N5TaYgDOm2suzKwumQ6T0OX8XNwHA=;
 b=Wi+DMPHXklCuqDZpdtiRjTNpR+OT8XsQWxISwG+OYGkAvmSJ/U8Q2VZEsHeT5dd5eM
 ixuuZe/NVJURCUbCbueBOnC4dssqQgiTlF8TP9quYzZ+FNR0z/Kj+Jwk+ieU4IYUTQJh
 mfET6HXDPyxKBxc8hNqfZOfdhj/dp0QpYJLJwhXGlrtwl+twiqmbfkghdzpfKW6xcOiw
 kGX6dTps4gG6ul0WoRkaYkSV3d7PO0WuIj4Nd/FaLuH0FzeK3QksqpoBKB+bhvIhODrU
 bZ/66A4B4wKJ+9Dn3ni3Yrf7poc52jBdsglhoOJWURKMHZnpudX29h7wECwT6LCn/Uy3
 w5CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcREpJbxs/oI7EtZ99X6pAzCVMDfT4EtIm2odDHapz0zPpQ5CE6iFaf3YTj7loYLvtMohsgquh/jwD@nongnu.org,
 AJvYcCX/UYLMoH3XNQfG3E4pwbvHOD4P9mXzTo+3LzfZ30f9hL1d7SmJnQUc6NsSn/uOOSHIPf8MD4VRkqc=@nongnu.org
X-Gm-Message-State: AOJu0YxF230MgXcoe6dC0XQfNi6M2LzwWjY2fsnvOe/TcOeHk5xCLKeu
 RNlyRqgoXz1/AycYKVA9cosOgKG6gZxnbjXQwYimKOPWfZDyj4sJ
X-Gm-Gg: ASbGncvyshrMIQQCeSPuAQwLQHENanZK4CQ23QsYy1dBS6nMbIWpLsPcNc9w2f19wiZ
 t6HTfDyPYOFko078ZZPCJTZ33UOarYmT/em7BEbK3QC0h0z88M1L70uKa4CnRky/IC6Y9mDj+Jm
 uaQgSwlahJpZjaq16BZceYf3xRCv52uGKrmY8ivawx4yS7zH2Xfz1hUS/7I7cYd0BD4aUGpR+jU
 8xOoJuwnFyvMhSnhxm6ilxml5QH9z3QzioK1nvIuet4U1Oghvc4B2bkxHba4CKXIMT+kgueb3XD
 DQC77fZr8p5khR9IzvjYBk7xS1wqqIbrTjIyKt/tzZqolDbQmGm4eScopTZZbV/GajX6DzTRxig
 =
X-Google-Smtp-Source: AGHT+IGpMQ51OFgiMVxDmzo5k+RyYk8722hSjNZGSU/Fyo9cYDKZoCLdqGRLlww2BONm7+aTZfQUBA==
X-Received: by 2002:a05:6000:4020:b0:385:de67:2269 with SMTP id
 ffacd0b85a97d-38db490e248mr359511f8f.36.1738710923989; 
 Tue, 04 Feb 2025 15:15:23 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf004300f426c70552435424.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:f426:c705:5243:5424])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d933a4bsm2660335e9.6.2025.02.04.15.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 15:15:23 -0800 (PST)
Date: Tue, 04 Feb 2025 23:12:03 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, Paul Durrant <paul@xen.org>,
 =?ISO-8859-1?Q?Cl=E9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_9/9=5D_hw/xen=3A_Have_legacy_Xen?=
 =?US-ASCII?Q?_backend_inherit_from_DYNAMIC=5FSYS=5FBUS=5FDEVICE?=
In-Reply-To: <02ea4b41-3594-4ead-90d3-0ab06f2be7fa@linaro.org>
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-10-philmd@linaro.org>
 <9A2B297A-6270-4482-B1B6-81F518C07C1E@gmail.com>
 <02ea4b41-3594-4ead-90d3-0ab06f2be7fa@linaro.org>
Message-ID: <685742EB-EDAA-488F-852C-C0AA24BD4721@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
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



Am 4=2E Februar 2025 21:25:46 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>Hi Bernhard,
>
>On 27/1/25 10:46, Bernhard Beschow wrote:
>> Am 25=2E Januar 2025 18:13:43 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@linaro=2Eorg>:
>>> Because the legacy Xen backend devices can optionally be plugged on th=
e
>>> TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE=
=2E
>>> Remove the implicit TYPE_XENSYSDEV instance_size=2E
>>>=20
>>> Untested, but I'm surprised the legacy devices work because they
>>> had a broken instance size (QDev instead of Sysbus=2E=2E=2E), so acces=
ses
>>> of XenLegacyDevice fields were overwritting sysbus ones=2E
>>>=20
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>> ---
>>> include/hw/xen/xen_pvdev=2Eh  | 3 ++-
>>> hw/xen/xen-legacy-backend=2Ec | 7 ++-----
>>> 2 files changed, 4 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/include/hw/xen/xen_pvdev=2Eh b/include/hw/xen/xen_pvdev=
=2Eh
>>> index 0c984440476=2E=2E48950dc2b57 100644
>>> --- a/include/hw/xen/xen_pvdev=2Eh
>>> +++ b/include/hw/xen/xen_pvdev=2Eh
>>> @@ -32,7 +32,8 @@ struct XenDevOps {
>>> };
>>>=20
>>> struct XenLegacyDevice {
>>> -    DeviceState        qdev;
>>> +    SysBusDevice parent_obj;
>>=20
>> This then needs sysbus=2Eh rather than qdev-core=2Eh include=2E
>>=20
>> Moreover, the patch in the reply needs to be inserted into the series b=
efore this patch=2E
>>=20
>> Both are needed for the patch to compile=2E
>
>Per your reply on patch #7, might I include your
>
>Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>
>Acked-by: Bernhard Beschow <shentey@gmail=2Ecom>
>(or R-b)

I only did a compile test and I'm not a Xen maintainer, so I guess above t=
ags don't apply=2E Right?


>
>squashing:
>
>-- >8 --
>diff --git a/include/hw/xen/xen_pvdev=2Eh b/include/hw/xen/xen_pvdev=2Eh
>index 48950dc2b57=2E=2E629bec90d09 100644
>--- a/include/hw/xen/xen_pvdev=2Eh
>+++ b/include/hw/xen/xen_pvdev=2Eh
>@@ -1,7 +1,7 @@
> #ifndef QEMU_HW_XEN_PVDEV_H
> #define QEMU_HW_XEN_PVDEV_H
>
>-#include "hw/qdev-core=2Eh"
>+#include "hw/sysbus=2Eh"
> #include "hw/xen/xen_backend_ops=2Eh"
>
> /* ------------------------------------------------------------- */
>---
>
>?

With the squash applied:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

