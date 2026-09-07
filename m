Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C756C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Y9Z-0002xs-9P; Mon, 07 Sep 2026 08:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Y9T-0002wc-In
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:08:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Y9R-0006Rz-6B
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:08:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687An9GB004092
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 12:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qq34gpx7Eb+vlU4KFfkllXw0X/b2NXp6YbLA2DpH2jo=; b=VfyOObVC7GL/vcDa
 njTktKsxZ0k51EvgL6rg0AJfQfup66Jjep5q0hzmbruDrJiLILAs2T87tMFsWe1K
 j14mZn8GYftJLjY6kYisBUFKte7NcA/Xm9Pd5P4KX7GDGEh0AJiHCN2NXMJVbkJH
 3wmJHSLG/nW+LXxZdJYR8F1Qb5oD+mRXRguqzIFgqawmxmIsVbEYL6Yem8eh8TGV
 T6cZaSjwUp8p1hXbi8dfFp+ua5R8Ww7RhbCXGfXSVstFoX2A0yECTZG911zr2lCp
 M9wv5XKICnqMmR0jWpe0tZvzNcsepHccaF+ZByDiGTd3YUD+Enb5azxhWVa0mE8g
 MMjZ1A==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghssg0wrv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 12:08:39 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-86617faa2b2so45800757b3.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 05:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788782919; x=1789387719; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qq34gpx7Eb+vlU4KFfkllXw0X/b2NXp6YbLA2DpH2jo=;
 b=QivmKrRQ/s7fn9J2Fpjk1hOBKXE4jl6pHqsXNqXVwC1hZVZq9W9ROYiM++3PF2H/RP
 ikPEt7yzmZtTMHEUl92O2hISYCq18FSDJ0jPaP1Vf0pxo1ooMMc6bkzQ76/a2Y0s/f3j
 XkfY4WPakN7VKY47WxTwQJE6vrY96csQjbsNLNxX7731MO8R2jt59xgzytRGuXCATwIe
 l9ZIQbhSudAsi2JlxbdCAOFZJ7t2IRztnPtwLDwfUx6m24Gq7f9bG2zG54rZ5qZb2viP
 57phrB76nMPDpp2wwCUuVS7SPGXULeIhWI2ZeloSOrdWFVKSXOpQXx0mhfK1sOEw5upF
 gj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788782919; x=1789387719;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qq34gpx7Eb+vlU4KFfkllXw0X/b2NXp6YbLA2DpH2jo=;
 b=I+UsPp6eVhGiLlPVgvRzQLNjNiCtZyDzeACztE8L6zPqpBnckp3WXpLFnimvm9IdV0
 k1r9NVgS3PZCSm9z5Pk9zqhfYwVFd3JJVL8r+uCl05X5v5fLPhjGGxdQ0eXVlaPPq0St
 nBjl9fADGQiFaKXqsThn1VrjFLBVni1I5xGZb1XglVjyvql4VQ7X6KrToJDtxxTmMtEY
 6lV/kOVaubLY0NLqJZC2jOxuL3R6I8FHcHAAlEmlwzgM6bKh/129gUFahBcvbKT0+Y8b
 wWmExQ10HqRU1qBzvBbO5dv/ZIvNfdZCOdi0Xdyz9UAM4S8+cmMMR9fDjIEevIhOgMAN
 w8Xw==
X-Gm-Message-State: AFuF++mjTbRQNIpHqkz45y/lwLu2kLt3Hzd0jcrziVm0PhHtWurQDJd9
 isAz5gJKj1e2+BNjynd2FbjM8IbjzxyP5rnITZUQ9iOAerBQu1+s0gMtxeNRxkjARc3YR/gugn+
 8y19KvIcNIC9PKfEmwpKk55MgSjHFCRQHc2hyf98g3XyTY5kgRiEgNzVMZQ==
X-Gm-Gg: AYBFou2qwwIz8yH6fPrRxOyWe0R9zb8cr+1acyvV3XZyg7cdSAMAsa4cw2sRQGb71PF
 ldiLkBNMOFDG1RaESCypOcKJAyc+Qq7jcHjDZBZSj/0pbarPIBbxTxWOpd+RswCxSROPnwykk54
 yKQrq8VE6vKzF55cR2XklhiWW8Wotq0/8bavOLtJ1tIr93RMTVC9XHg16vHsgBtB1UfjszrdJu1
 NiqeHm1i3ND1Z8IlUpQmwb+8kOLj3Q81CRD75oA1EuhANv4fC7JU7mY7P1xWFAslZqP1TUqht0v
 IRTCjGfWNXTT50DeIzoI4HVBVeTYxb6bBezrS3MXJ13modGUwYRyN3nbgI7lPWuSiJPORuyFPZf
 /rjrMhk3Er1GUG43dFguHec+FqpIfGoPdRKo=
X-Received: by 2002:a05:690c:7483:b0:868:505e:b935 with SMTP id
 00721157ae682-87127843468mr93428497b3.13.1788782919024; 
 Mon, 07 Sep 2026 05:08:39 -0700 (PDT)
X-Received: by 2002:a05:690c:7483:b0:868:505e:b935 with SMTP id
 00721157ae682-87127843468mr93427807b3.13.1788782918500; 
 Mon, 07 Sep 2026 05:08:38 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714a979199sm70821517b3.29.2026.09.07.05.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 05:08:37 -0700 (PDT)
Message-ID: <87c05cee-b435-4c48-a441-9804d3b448a0@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 09:08:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/riscv/tt-atlantis: Add PRCMs to tt-atlantis
 model
To: Joel Stanley <joel@jms.id.au>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260817-atlantis_prcm-v2-0-ffba0b944419@oss.tenstorrent.com>
 <20260817-atlantis_prcm-v2-2-ffba0b944419@oss.tenstorrent.com>
 <CACPK8XcEk4xXDYnY_FSZ7Wud0RQqyLzX_VVA3vXT2q27Z2dn8g@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACPK8XcEk4xXDYnY_FSZ7Wud0RQqyLzX_VVA3vXT2q27Z2dn8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzNCBTYWx0ZWRfX6a+0XgZ77jia
 0pfPFIU/KgwWylttMhU4u+bhhlYXFZEfPGWdUKaopFB39+ILsYpEJ8BXTu6hDxRFJ6trV+L+Flv
 2FkFF+QnoOoUq4EfgGADooWWmluNRnRvMXhqXWzlWSjamoZHaxJeg1xSzhB3wBDz07BRWAuWg6q
 OI6Rp3eT5sHqoq5dAMiAOAwA6brl2YIZDLUIpfDZMeZw9JreFbL1jN5s9byZlUF7OPN0ItXS8S+
 B2aTljaQHDsDfjq6HtDRmWbBXyV4bGeT5y6VA6mkSKamNGZZHlX4XgnMafrxWAr5fedtUL/ozPZ
 SymtxEHw0/5GjVUkxWGd82OipS6xcXfdqGIzHgrg5wyj/kkm6SYp+gSn2JLJTdgTByWgvjuZXNb
 RtKL1slrLEsEStXgdqMagT8sUCDbl9goEFHR7nNaOz8E0DWmp3jysGrLa3+Q/CdUtOec3EkvcZC
 HBzrfvg/yH5LXcrFIVw==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a9ea947 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=t9496tuAAAAA:8 a=FRSEYCzRAAAA:8 a=BpZ-QL2r-Ufmruuip1YA:9
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22 a=4wQ91nGE5lQcD7eh5OX0:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: 2DF1EjFOMtsv29LLBqA2CvZWGdO3Dm5t
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzNCBTYWx0ZWRfXzESdHXFxfLEB
 7VhxsMsEw7UIcYDVMfWpOxSNjiZbORccv1x0O0pGvF6kZF2pc1ejC2emTHxMq0/3zNeo8bFGMg0
 vq1jSSipp9ar+kaiGDHwCtAoYcxacu8=
X-Proofpoint-GUID: 2DF1EjFOMtsv29LLBqA2CvZWGdO3Dm5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



On 8/31/2026 4:06 AM, Joel Stanley wrote:
> On Tue, 18 Aug 2026 at 00:13, Anirudh Srinivasan
> <asrinivasan@oss.tenstorrent.com> wrote:
>>
>> Atlantis has 4 PRCMs that are visible from S mode by the Ascalon Core
>> (RCPU, HSIO, PCIe and MM). This commit adds these 4 PRCM blocks to the
>> tt-atlantis model, along with necessary device tree nodes for them.
>>
>> Reviewed-by: Chao Liu <chao.liu@processmission.com>
>> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>> ---
>>   docs/system/riscv/tt_atlantis.rst |  1 +
>>   hw/riscv/tt_atlantis.c            | 94 +++++++++++++++++++++++++++++++++++++++
>>   include/hw/riscv/tt_atlantis.h    | 19 ++++++++
>>   3 files changed, 114 insertions(+)
>>
>> diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
>> index 1f2880d617..539c22354f 100644
>> --- a/docs/system/riscv/tt_atlantis.rst
>> +++ b/docs/system/riscv/tt_atlantis.rst
>> @@ -14,6 +14,7 @@ tt-atlantis QEMU model features
>>   * 8-core Ascalon-X CPU Cluster
>>   * RISC-V compliant Advanced Interrupt Architecture
>>   * 16550A compatible UART
>> +* 4 PRCMs (Clock and Reset Controllers)
>>
>>   Known limitations
>>   -----------------
>> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
>> index d808bcc11c..9ebba07703 100644
>> --- a/hw/riscv/tt_atlantis.c
>> +++ b/hw/riscv/tt_atlantis.c
>> @@ -26,6 +26,7 @@
>>   #include "hw/char/serial-mm.h"
>>   #include "hw/intc/riscv_aclint.h"
>>   #include "hw/misc/unimp.h"
>> +#include "hw/misc/tt_atlantis_prcm.h"
>>
>>   #include "system/system.h"
>>   #include "system/device_tree.h"
>> @@ -59,6 +60,10 @@ static const MemMapEntry tt_atlantis_memmap[] = {
>>       [TT_ATL_I2C3] =             { 0xd4070000,       0x10000 },
>>       [TT_ATL_I2C4] =             { 0xd4080000,       0x10000 },
>>       [TT_ATL_UART1] =            { 0xd4110000,       0x10000 },
>> +    [TT_ATL_PRCM_RCPU] =        { 0xd0000000,       0x10000 },
>> +    [TT_ATL_PRCM_PCIE] =        { 0xd8000000,         0x100 },
>> +    [TT_ATL_PRCM_MM] =          { 0xdc000000,        0x1000 },
>> +    [TT_ATL_PRCM_HSIO] =        { 0xe00c0000,         0x510 },
>>       [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
>>       [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
>>   };
>> @@ -328,11 +333,35 @@ static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
>>       qemu_fdt_setprop_cell(fdt, name, "reg", addr);
>>   }
>>
>> +static char *create_fdt_prcm(void *fdt, const MemMapEntry *mem,
>> +                             const char *prcm_name)
>> +{
>> +    hwaddr base = mem->base;
>> +    hwaddr size = mem->size;
>> +    char *name = g_strdup_printf("/soc/prcm_%s@%" PRIx64,
>> +                                 prcm_name, mem->base);
> 
> Use the locals, or drop them and use mem->base both times.
> 
>> +    g_autofree char *compatible =
>> +        g_strdup_printf("tenstorrent,atlantis-prcm-%s", prcm_name);
>> +
>> +    qemu_fdt_add_subnode(fdt, name);
>> +    qemu_fdt_setprop_string(fdt, name, "compatible", compatible);
>> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, base, 2, size);
>> +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
>> +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
>> +    qemu_fdt_setprop_cell(fdt, name, "#clock-cells", 1);
>> +    qemu_fdt_setprop_cell(fdt, name, "#reset-cells", 1);
>> +    qemu_fdt_setprop_cell(fdt, name, "phandle", next_phandle());
> 
> If a phandle falls in the woods and nobody...
> 
> If you're not saving this value anywhere, is there any need to set one?

The code is retrieving this value down below:

 >> +    g_autofree char *rcpu_name = create_fdt_prcm(fdt,
 >> +        &s->memmap[TT_ATL_PRCM_RCPU], "rcpu");
 >> +    prcm_rcpu_phandle = qemu_fdt_get_phandle(fdt, rcpu_name);


This is a suggestion I made in v1 to avoid having to carry a pre-generated
phandle value when one can be autogenerated when needed.

Note that this suggestion was made before "next_phandle()" was introduced.

> 
>> +
>> +    return name;
>> +}
>> +
>>   static void finalize_fdt(TTAtlantisState *s)
>>   {
>>       uint32_t aplic_s_phandle = next_phandle();
>>       uint32_t imsic_s_phandle = next_phandle();
>>       uint32_t periph_clk_phandle = next_phandle();
>> +    uint32_t osc_24m_phandle = next_phandle();
>> +    uint32_t prcm_rcpu_phandle;
>>       void *fdt = MACHINE(s)->fdt;
>>
>>       create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
>> @@ -348,6 +377,34 @@ static void finalize_fdt(TTAtlantisState *s)
>>                       aplic_s_phandle);
>>
>>       create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
>> +    create_fdt_clk(fdt, "osc_24m", 24000000, osc_24m_phandle);
> 
> With the PRCM enabled the UART and I2C can get a real clock? So we can
> drop the periph-clk node and modify create_fdt_i2c as well as
> create_fdt_uart to use the real PRCM phandles. This will shake out any
> issues with how you're wiring up the device tree too.
> 
>> +
>> +    g_autofree char *rcpu_name = create_fdt_prcm(fdt,
>> +        &s->memmap[TT_ATL_PRCM_RCPU], "rcpu");
>> +    prcm_rcpu_phandle = qemu_fdt_get_phandle(fdt, rcpu_name);
> 
> This is a great function that I didn't know of when I wrote
> next_phandle(). I'm all for using it, but lets swap the entire file
> over at once.

They're not the same thing though.  qemu_fdt_get_phandle(fdt, nodename)
retrieves the already assigned phandle value for nodename.  It doesn't do
the same as next_phandle().  I believe you're thinking about
qemu_fdt_alloc_phandle(fdt) instead.

And yes, ideally the board would either do the phandle management by its own,
i.e. what next_phandle() is doing and what other boards like 'virt' do, or
rely on alloc_phandle + get_phandle.  Mixing and matching them can work as
long as you're doing alloc_phandle last - otherwise the manual phandle
counter can collide with alloc_phandle.


Thanks,
Daniel



> 
>> +    qemu_fdt_setprop_cells(fdt, rcpu_name, "clocks", osc_24m_phandle);
>> +    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clocks",
>> +                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_ROOT,
>> +                           prcm_rcpu_phandle, TT_ATL_CLK_NOCC_CLK);
>> +    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clock-parents",
>> +                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_PLL,
>> +                           prcm_rcpu_phandle, TT_ATL_CLK_NOC_PLL);
> 
>> @@ -545,6 +602,43 @@ static void tt_atlantis_machine_init(MachineState *machine)
>>       serial_mm_init(system_memory, s->memmap[TT_ATL_UART1].base, 2,
>>                      qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
>>                      115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
>> +
>> +    /* Add rcpu prcm block */
>> +    object_initialize_child(OBJECT(s), "prcm-rcpu", &s->prcm[0],
>> +                            TYPE_TT_ATLANTIS_PRCM_RCPU);
>> +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[0]), &error_fatal);
>> +    memory_region_add_subregion(system_memory,
> 
> Since you're already sending a v3, can you rebase it on this series please:
> 
>   https://lore.kernel.org/qemu-riscv/20260831021500.82565-1-joel@jms.id.au/
> 
> Aside from code shuffling, you will pass s->memory to
> memory_region_add_subregion, the _realize calls go in
> tt_atlantis_soc_realize, and the initalise calls go in
> tt_atlantis_soc_init.
> 
>> +                                s->memmap[TT_ATL_PRCM_RCPU].base,
>> +                                sysbus_mmio_get_region(
>> +                                    SYS_BUS_DEVICE(&s->prcm[0]), 0));
>> +
> 
>> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
>> index 7f7d4a5a59..20bcdfeb52 100644
>> --- a/include/hw/riscv/tt_atlantis.h
>> +++ b/include/hw/riscv/tt_atlantis.h
> 
>> @@ -59,6 +62,22 @@ enum {
>>       TT_ATL_SAPLIC,
>>       TT_ATL_SIMSIC,
>>       TT_ATL_UART1,
>> +    TT_ATL_PRCM_RCPU,
>> +    TT_ATL_PRCM_HSIO,
>> +    TT_ATL_PRCM_PCIE,
>> +    TT_ATL_PRCM_MM,
>> +};
>> +
>> +/* RCPU PRCM Clock IDs */
> 
> Do these come from
> include/dt-bindings/clock/tenstorrent,atlantis-prcm-rcpu.h in linux?
> Add a comment.
> 
>> +enum {
>> +    TT_ATL_CLK_RCPU_PLL = 0,
>> +    TT_ATL_CLK_RCPU_ROOT = 1,
>> +    TT_ATL_CLK_NOC_PLL = 25,
>> +    TT_ATL_CLK_NOCC_CLK = 26,
>> +    TT_ATL_CLK_HSIO_PLL = 54,
>> +    TT_ATL_CLK_PCIE_PLL = 55,
>> +    TT_ATL_CLK_MM_PLL0 = 56,
>> +    TT_ATL_CLK_MM_PLL1 = 57,
>>   };
>>
>>   #endif
>>
>> --
>> 2.43.0
>>


