Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EA5109C05B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5U3C-0000Fo-1I; Wed, 25 Mar 2026 15:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w5U3A-0000FL-2g; Wed, 25 Mar 2026 15:37:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w5U38-0003az-5p; Wed, 25 Mar 2026 15:37:55 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PIOvBI3681168; Wed, 25 Mar 2026 19:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XhN3uC
 M4S5ezk3rQMWlT77JEkvidYs72hYpPaErS5oU=; b=pot5w6fZhCbAj3bEXAL/RI
 GotncqSVE3iXupdxR/36OhJoTLm2oFhm6g+uUGwvnG4y2XvdfbdgyHpe7IkRSjom
 YeWEobRbmsY9umLLwpKIDx7+ddI02tPxAlvnAtp2N/BloywwIEnXJooQJFlM/ZXY
 dnjkyYAbzIGrt4ihSEnWmBxzfHU5HeLVE8C+EoiuOACYgs3NTe/C9R1YBvlTsW0W
 45aZ6DY7U+IXHsfxnWYLaFTvgAva5zy12QeL5fo/MGHNgqhz0YSc9rnYSSqdvF6N
 ttHp4eex7T8aOk8vFGv3oNvyHwTd7wWWXK+44uqJ5JLhdN86fyJqLZFBR400UYNw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa2585-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 19:37:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PGPOGU011788;
 Wed, 25 Mar 2026 19:37:46 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk7t3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 19:37:46 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62PJbkjQ20251268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2026 19:37:46 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F177558052;
 Wed, 25 Mar 2026 19:37:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 582065805D;
 Wed, 25 Mar 2026 19:37:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Mar 2026 19:37:45 +0000 (GMT)
Message-ID: <f292fab3-a92e-4e8a-a3a6-23d356186548@linux.ibm.com>
Date: Wed, 25 Mar 2026 15:37:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/tpm: add PPI support to tpm-tis-device for ARM64
 virt
To: Mohammadfaiz Bawa <mbawa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
 <20260324-tpm-tis-sysbus-ppi-v1-3-e59175210954@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260324-tpm-tis-sysbus-ppi-v1-3-e59175210954@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: TeEu5lnqrW2mY6VPyF0OOOPpIIDyAu2Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0MSBTYWx0ZWRfX9afQ8AmH3DGU
 A4EWG6aabsp+IHk9KJG4hiDH9Sv6BFjkp3rfLxLtaAdnYvZ1pDHTwwdYeuHAHh51lUpqXXQLmda
 x5916KojXsmguALMJs1bOZrmPdDAKEVhFzO3bKA4wZu1nJsCynt8JbT5HkCJju/apeOxl1saiz/
 1/6x48lWrtQ3fh5zl1SJQO8m5/iqWixo1BFvfEr8tlknjoyqCHA6GIx1b3q+onf6ZwY9rKfx0ah
 tm8Kzf0VT52niW7Ae5G67RyjRicM/eu1K7yLf5xTuERruQmMldlIborFvnKU5CE8r3PUQSgCKap
 AVRdBuUXlTt8V427Jk1mJbrDR6lvLt6gkgPHZ1t9oePkwo3WQnTlp4xFBD5WW0UQVK58mM9HK7R
 fyo3jHiWJdKQ2WmFqVhmE5cmzqGoncZiHaF4G1I89U+jxKFrzPjkcLmJjDGjc3WBJVowndEm3lL
 dohPhIi47EyfQeNwT9w==
X-Proofpoint-GUID: FNOdA6MfNU6ZqZMByzQh7FLhk0Y1FzRd
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c4398b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=znrGVGnwMIbQcWmeExcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250141
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/24/26 3:10 AM, Mohammadfaiz Bawa wrote:
> Add PPI memory region and ACPI _STA, _DSM to tpm-tis-sysbus so
> Windows 11 ARM64 guests no longer log Event ID 15 errors from
> tpm.sys on every boot.
> 
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> ---
>   docs/specs/tpm.rst       |  8 +++++---
>   hw/arm/virt-acpi-build.c |  9 ++++++++-
>   hw/tpm/tpm_tis_sysbus.c  | 11 +++++++++++
>   3 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
> index 63cc0b68cd79d64138d4dd05ae158430c6a74643..ba2b0d726745fdf8ebc4c73c9c42e1ff8047a9db 100644
> --- a/docs/specs/tpm.rst
> +++ b/docs/specs/tpm.rst
> @@ -201,9 +201,11 @@ address dynamically at device plug time. The ACPI ``_DSM`` method
>   and PPI operation regions reference this dynamically resolved
>   address.
> 
> -PPI is enabled by default and can be controlled with the ``ppi``
> -property (e.g. ``-device tpm-tis-device,tpmdev=tpm0,ppi=on``).
> -Without PPI support, guest operating systems such as Windows 11
> +PPI is controlled by the ``ppi`` property (default ``on``)::
> +
> +    -device tpm-tis-device,tpmdev=tpm0,ppi=on
> +
> +Without PPI, guest operating systems such as Windows 11

This change brings nothing new. It could be in the first patch.

>   ARM64 will log errors when attempting to query TPM Physical
>   Presence capabilities via the ACPI ``_DSM`` method.
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 719d2f994e65f976f6e754259d0b4f1336f82f13..27a7389a33df221a9dfb0cde1bc35b3ab62e56be 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -240,7 +240,8 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
>       Aml *dev = aml_device("TPM0");
>       aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
>       aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
> -    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> 
>       Aml *crs = aml_resource_template();
>       aml_append(crs,
> @@ -248,6 +249,12 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
>                                     (uint32_t)memory_region_size(sbdev_mr),
>                                     AML_READ_WRITE));
>       aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    hwaddr ppi_base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
> +    if (ppi_base != -1) {
> +        ppi_base += pbus_base;
> +        tpm_build_ppi_acpi(TPM_IF(sbdev), dev, ppi_base);
> +    }
>       aml_append(scope, dev);
>   }
>   #endif
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index e9372e7316305fe1a4d415a712ab516e0fd5f073..f8b63dd4607cacb319e27ea83e421ec5bdc1cb0f 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -30,6 +30,7 @@
>   #include "hw/core/sysbus.h"
>   #include "tpm_tis.h"
>   #include "qom/object.h"
> +#include "qemu/memalign.h"
> 
>   struct TPMStateSysBus {
>       /*< private >*/
> @@ -93,12 +94,14 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
>   static const Property tpm_tis_sysbus_properties[] = {
>       DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
>       DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
> +    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, true),
>   };
> 
>   static void tpm_tis_sysbus_initfn(Object *obj)
>   {
>       TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
>       TPMState *s = &sbdev->state;
> +    size_t host_page_size = qemu_real_host_page_size();
> 
>       memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
>                             s, "tpm-tis-mmio",
> @@ -106,6 +109,12 @@ static void tpm_tis_sysbus_initfn(Object *obj)
> 
>       sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>       sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
> +
> +    s->ppi.buf = qemu_memalign(host_page_size,
> +                                ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
> +    memory_region_init_ram_device_ptr(&s->ppi.ram, obj, "tpm-ppi",
> +                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ppi.ram);
>   }
> 
>   static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
> @@ -122,6 +131,8 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
>           error_setg(errp, "'tpmdev' property is required");
>           return;
>       }
> +
> +    vmstate_register_ram(&s->ppi.ram, dev);
>   }
> 
>   static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
> 

Aside from the documentation part:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


