Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CB0C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x135I-0002aK-9f; Mon, 31 Aug 2026 10:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x135G-0002a6-Fb
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:34:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x135E-0001pT-7s
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:34:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VETP5R3703670
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eUQmCHoHoNB6GpnA0Df6YUSJwV1PqXsoMhxerctm6LE=; b=I66rcH0igPEaBH6q
 dckLJXk687EorwhkIINPKbeRy2FDuKr4OMdSdEkk4OTFdMgl5BGhRvoUn2o2vl4b
 8al00lFa9qZXkgnZ0t3GunYZrzkNvlA27kJooUChYngtZb60iN0wi04DpMMbZDxf
 PRUJXhwmNhxg68Hlj07rvYNhG0wzuQwBtKYUZILM/3XEOCTaZkrmTCXekXK2tO0y
 HrNlKsxpOnrQslZkiMJuoF9IGy/W42WHNt/wcEtRO1D5iDUbe70VwFWf9t1U87qC
 XbCTJs8hJX0FgTBYs51SRhhHVkQiOCw/zC7ylcgVI80BXo2DfIMOhVs1N1y4blVL
 Po741g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6yas8dr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:33:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90cea0b5522so33496766d6.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788186838; x=1788791638; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eUQmCHoHoNB6GpnA0Df6YUSJwV1PqXsoMhxerctm6LE=;
 b=Cu+MZVpFhYNKZUYWt6Kijc7etlPXCbcx+jrPhDw/Yisg4I48mBKaLiq8+cY9vLNWzh
 HYJwM+Y4dHg5kRIk6vslRRnA6/lfh3P8HHE8ja4Uucf2zIp3UyXx0EQDMk0LAJYUZfRL
 EGN+kZ3Gn4yxEIgfV3+Ggxpb43HgCv7WC9X2dO+HXdye7v4LOnQVVVuXZ5qe6UMrt8XG
 xAOAU0RwaimeKEcXIXXfz1mEZbQekilUFzv8kKrP0WTByzW+M33QKCEWdczzQt37T3xp
 ivsUOOZiBjJKm9D/4Kt/svm59lnKE+iTIzJdl9+eVvaA/gqMZs7HG4b29zKy+Z86HrMM
 TiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788186838; x=1788791638;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eUQmCHoHoNB6GpnA0Df6YUSJwV1PqXsoMhxerctm6LE=;
 b=C0UEW5SdBAKoaFuJsMKo/49UADYEePqTEL4Iz+Jt2Ded9KybSQjaPvUEUEN10sA5t3
 fWYzloRoCxToNuNUeJKBfT9gQ0t4ngfWquiM2g6rUH7k/Wla/XGjFCzBPDib8MVKKxGA
 p4HnOVLLUOPxLOII2cZYKAphTYUneFHGoff6z1ooi8u0Q9xpUI+JZI0XHNTqHFJpcWLy
 USjIxkn/nQwQ6JQLvyTnSaQ63o/2ae030cDTZo4QQ+7ffZTWAXnp3dfxQwHCNxA1Lk5g
 kTGtA4SWqqV+hwllYHZllGSBQcFv4wrLnJT67LoRA3yGeg7hjM3lZy9FARIWVyiO3jzO
 KvVA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6PNnl+DJQBFp1/l6Li/q/VG1KyUwNKrEQyY0vLBihVdQbnnd1p0AZFVqVUV/0uv5dlCoXWlat4XDs@nongnu.org
X-Gm-Message-State: AFuF++kIM4GMTuTGlt2NUnjg6n2PZtVZaJrwsrVBrxrx187ekH8bkKtN
 2xCWus0ZaDitTkywF3qCyAqKWSB9yjrWoC3PNr0/lgqbFB3cvZbKyiWkpiTmipwz4tATn6o5a1H
 Kz2zgeDcWdvvjuYPH/o0MwrKnNgBfTyWLbiniEAZV0eGnEOawMXX/O642eA==
X-Gm-Gg: AR+sD11vFYkkcDM+0wvAR262jzM6dkDCI3PpBndl1Fw/rD9sZau3Z/txaua11Br4TXG
 YOHMrgN2tAbmMxDEkxbC2cFlZfE2A6bNJLesWHTFsL4AkMsDMAk/Uf9uccSJDZOmxYgZIoK8L+B
 mMVzrsWP5qh3ZCBsdR1fH2Mv6OLZAEkfFThKMa7dcp9AMjDahUTi2ObwXJ+Q6Va8KxOLhOJUOi/
 XPUG8w3aOH4/DktDtS9uSzL6c7rPXvTIlS65CRVEI0TUHxq6hBYsBB1gvN0qSWnYRHvbp5MTgDA
 sk1IVay9+kz8B1idPbQ6wvLyXgbs8pLtQ/6bO70FD6n+S/tdFZqcInsDJFaSuYUnKCijNki1t29
 Ib25uncxZUWWq5ybQtGCJ
X-Received: by 2002:a05:620a:486e:b0:938:e95e:9377 with SMTP id
 af79cd13be357-9391394c9b6mr2360606185a.30.1788186837562; 
 Mon, 31 Aug 2026 07:33:57 -0700 (PDT)
X-Received: by 2002:a05:620a:486e:b0:938:e95e:9377 with SMTP id
 af79cd13be357-9391394c9b6mr2360596885a.30.1788186836910; 
 Mon, 31 Aug 2026 07:33:56 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dd2517sm294020205e9.7.2026.08.31.07.33.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 07:33:56 -0700 (PDT)
Message-ID: <0edef42e-06b2-4fca-af6f-8d17b0f15a3f@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/47] target-info: add target_config_nitro
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-26-pierrick.bouvier@oss.qualcomm.com>
 <4b9aa2f9-8546-4aee-92f0-d27e935be53c@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4b9aa2f9-8546-4aee-92f0-d27e935be53c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXwKMOIx3JlVzY
 opV++HVLFD1z2iM+qELTq1RhadbHzumW2b4lZlxE0iHfDQF+0yhYl/PFful4Hs2R1TYV2UI6aN2
 pa1fG6Q941PbGDtiELKzC2GM09SXfm0=
X-Authority-Analysis: v=2.4 cv=CpaPtH4D c=1 sm=1 tr=0 ts=6a9590d6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=gmLkG3rbZGpK/HF7jnAN4w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=akKINyWezlVBtN8CxxgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX846KwUoK3jh0
 sC18n7T9MO13mIEK6nVlwnx+0QeRE5oIXT53kOc0jLipGRZywdOvZZGQlYplBQtTrtuaBpXXFS5
 PrM65NlqizXrJNfjohP/afrfpHxEgnlZKOl6eABe4AdRSQMfVAtCXihF0fa6eV3uRGal7Ec6Mlw
 8N5PkO+BzXNqbdCej77ccI+vh2ABzznVadlhi58EvPj+jEx/Lz0L6QmM/ebza+6fzzovP5Ry5nl
 qCEsYVVdoTu57bBvxX85ym8+36IRruhDbK8LfcOWgUZi6baGLOz+xi8WP6nHomrsFAhpfz9uJvt
 sLkYl7LUviLCCZAYz30mJFaxsTKQ5f35zxRDqJXvHwjuaug4PxMgeLVdHu4VTxQlk+SzXAVXjZg
 WkD/MK1GM4TcetrzSljr7MZDYKmfUHz46RKWC8OXEkuEBzWfPYsmTBMGupXzYAWhoQr+EqU9tAz
 C0t5XXncXHhyRBXX6ug==
X-Proofpoint-ORIG-GUID: 1lEkrO5ZfThM0FQx5Uy_Z1JAXSx0gwEl
X-Proofpoint-GUID: 1lEkrO5ZfThM0FQx5Uy_Z1JAXSx0gwEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 2026-08-31 9:15, Philippe Mathieu-DaudÃ© wrote:
> On 29/8/26 00:58, Pierrick Bouvier wrote:
> 
> Also wondering why we need a special config for a target device.
> 
> So why are we listing we can not plug? Maybe the bus Kconfig is
> missing the accelerator dependency?
> 
> -- >8 --
> diff --git a/hw/nitro/Kconfig b/hw/nitro/Kconfig
> index cfae85920a0..2e4125f8710 100644
> --- a/hw/nitro/Kconfig
> +++ b/hw/nitro/Kconfig
> @@ -1,4 +1,5 @@
>   config NITRO_VSOCK_BUS
> +    depends on NITRO
>       bool
> 
>   config NITRO_SERIAL_VSOCK
> ---
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/qemu/target-info-impl.h | 2 ++
>>   include/qemu/target-info.h      | 7 +++++++
>>   target-info-def.c               | 3 +++
>>   target-info.c                   | 5 +++++
>>   4 files changed, 17 insertions(+)
>>
>> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target- 
>> info-impl.h
>> index dbd7a5a2071..4f6c898c707 100644
>> --- a/include/qemu/target-info-impl.h
>> +++ b/include/qemu/target-info-impl.h
>> @@ -33,6 +33,8 @@ typedef struct TargetInfo {
>>       /* CONFIG_MULTIPROCESS */
>>       bool config_multiprocess;
>> +    /* CONFIG_NITRO */
>> +    bool config_nitro;
>>   } TargetInfo;
>>   /**
>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>> index 579c43332fb..d775c94d1e3 100644
>> --- a/include/qemu/target-info.h
>> +++ b/include/qemu/target-info.h
>> @@ -49,6 +49,13 @@ bool target_big_endian(void);
>>    */
>>   bool target_config_multiprocess(void);
>> +/**
>> + * target_config_nitro:
>> + *
>> + * Returns true if target defines CONFIG_NITRO.
>> + */
>> +bool target_config_nitro(void);
>> +
>>   /**
>>    * target_base_arm:
>>    *
>> diff --git a/target-info-def.c b/target-info-def.c
>> index 9d51371f766..96fd1f8c73d 100644
>> --- a/target-info-def.c
>> +++ b/target-info-def.c
>> @@ -46,6 +46,9 @@ static const TargetInfo target_info_stub = {
>>   #ifdef CONFIG_MULTIPROCESS
>>       .config_multiprocess = true,
>>   #endif
>> +#ifdef CONFIG_NITRO
>> +    .config_nitro = true,
>> +#endif
>>   };
>>   target_info_init(target_info_stub)
>> diff --git a/target-info.c b/target-info.c
>> index 5db2a6049ac..67127da16fe 100644
>> --- a/target-info.c
>> +++ b/target-info.c
>> @@ -47,6 +47,11 @@ bool target_config_multiprocess(void)
>>       return target_info()->config_multiprocess;
>>   }
>> +bool target_config_nitro(void)
>> +{
>> +    return target_info()->config_nitro;
>> +}
>> +
>>   bool target_base_arm(void)
>>   {
>>       switch (target_arch()) {
> 

Since the goal of this effort is solely to keep the CLI
output unchanged, we can do simpler without having to add
TargetInfo::config_nitro:

-- >8 --
diff --git a/hw/nitro/Kconfig b/hw/nitro/Kconfig
index cfae85920a..2e4125f871 100644
--- a/hw/nitro/Kconfig
+++ b/hw/nitro/Kconfig
@@ -1,2 +1,3 @@
  config NITRO_VSOCK_BUS
+    depends on NITRO
      bool
diff --git a/hw/nitro/meson.build b/hw/nitro/meson.build
index b9bd0d4300..39a087f8d7 100644
--- a/hw/nitro/meson.build
+++ b/hw/nitro/meson.build
@@ -1 +1,2 @@
+system_ss.add(when: 'CONFIG_NITRO', if_true: files('nitro-common.c'))
  system_ss.add(when: 'CONFIG_NITRO_VSOCK_BUS', if_true: 
files('nitro-vsock-bus.c'))
diff --git a/hw/nitro/nitro-common.c b/hw/nitro/nitro-common.c
new file mode 100644
index 0000000000..cfb47a9a49
--- /dev/null
+++ b/hw/nitro/nitro-common.c
@@ -0,0 +1,15 @@
+/*
+ * Nitro common helpers
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/target-info.h"
+#include "system/nitro-accel.h"
+
+bool target_config_nitro(void)
+{
+    return (target_aarch64() || target_x86_64()) && nitro_enabled();
+}
diff --git a/include/system/nitro-accel.h b/include/system/nitro-accel.h
index a93aa6fb00..a5126bcf02 100644
--- a/include/system/nitro-accel.h
+++ b/include/system/nitro-accel.h
@@ -18,2 +18,4 @@ static inline bool nitro_enabled(void)

+bool target_config_nitro(void);
+
  #define TYPE_NITRO_ACCEL ACCEL_CLASS_NAME("nitro")
---

Amending in patches #30 "hw/nitro: filter from CONFIG_NITRO":

-- >8 --
diff --git a/hw/nitro/heartbeat.c b/hw/nitro/heartbeat.c
index dc41323266..c4d2a4637e 100644
--- a/hw/nitro/heartbeat.c
+++ b/hw/nitro/heartbeat.c
@@ -21,2 +21,3 @@
  #include "hw/nitro/heartbeat.h"
+#include "system/nitro-accel.h"
  #include "trace.h"
diff --git a/hw/nitro/serial-vsock.c b/hw/nitro/serial-vsock.c
index 1d56c33804..ec5aea4617 100644
--- a/hw/nitro/serial-vsock.c
+++ b/hw/nitro/serial-vsock.c
@@ -25,2 +25,3 @@
  #include "hw/nitro/serial-vsock.h"
+#include "system/nitro-accel.h"
  #include "trace.h"
---

And with another preliminary patch introducing target_x86_64():

-- >8 --
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 5cce27d4f6..f71a1b8bb6 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -128,2 +128,9 @@ bool target_riscv64(void);

+/**
+ * target_x86_64:
+ *
+ * Returns whether the target architecture is 64-bit x86.
+ */
+bool target_x86_64(void);
+
  #endif
diff --git a/target-info.c b/target-info.c
index c9e0be3279..6f03f412b7 100644
--- a/target-info.c
+++ b/target-info.c
@@ -116 +116,6 @@ bool target_riscv64(void)
  }
+
+bool target_x86_64(void)
+{
+    return target_arch() == SYS_EMU_TARGET_X86_64;
+}
---

Only tested on Linux/Aarch64, not Linux/x86_64.

