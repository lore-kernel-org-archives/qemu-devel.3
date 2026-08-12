Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AA5C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9kr-0000gZ-49; Wed, 12 Aug 2026 10:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wu9kc-0000d5-C6; Wed, 12 Aug 2026 10:16:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wu9kZ-0005Jz-Kl; Wed, 12 Aug 2026 10:16:14 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CE25io3688021; Wed, 12 Aug 2026 14:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PTlGKz
 BNRMNFIzM14jO0DqygtImmA2pty6ARcKa0EH8=; b=k+zE+oc20LD4FFjiK8KSEg
 MubjBMn5zhsgZKD/nvGjSMhqw3HvvI1kjdb5dzWo3vgPpLrapN9uG7xKhvoRXHsM
 3tRi7x0T6DqiZ54PBpJsIcyKo37bo1eufBwekt3pXIvbSV8R2q3brQs/xIlSXPlm
 34/yExPPuyxzQ/S0tcdFQ6hZuhbDu0r3XheLvf2yR21CWQ0HemXTS9huQfjtlPlI
 HcZ3SWvjjClELWRs4FdlKhtFRB8GcKX4GsATBx6uL6OhT9WwvXbgAi72icPYg7cW
 8uUhtGnviSmoCquDUH589ozwnZ43ZAxBkU459UY/VCuUAQ3iH3KWptliCvDmoVrw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9tvhc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 14:15:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CEBKnn028700;
 Wed, 12 Aug 2026 14:15:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjxbvb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 14:15:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CEFrQB30606004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 14:15:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 548C05805A;
 Wed, 12 Aug 2026 14:15:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B2B058056;
 Wed, 12 Aug 2026 14:15:51 +0000 (GMT)
Received: from [9.61.61.74] (unknown [9.61.61.74])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 14:15:51 +0000 (GMT)
Message-ID: <efcd0101-703d-4f6b-87ec-86e9ebb82bc2@linux.ibm.com>
Date: Wed, 12 Aug 2026 10:15:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2] hw: add compat machines for 11.2
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <20260723163806.368127-1-cohuck@redhat.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260723163806.368127-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExNCBTYWx0ZWRfX6X156Y0j4HEX
 Vji4IhigAwZzut3XQT1rpRQmQ7y8crBh5oP6ZzHsUnQE0ItxDAIYw0S6CQP9xKCX1cGo6WGwpKJ
 MAtvmrrEkWTsMh+R5BSoTvkR9lslxwlK108KMlOTr5Am0tBy4X9Kngful6Bk0pNJ1PPjF6R5War
 qM7+5754Kje1GyzEPoqKECRrYP72zmUgv5al3oAAQ2BCcjwm530n53csmIY4ie/pXimjj5jzo5f
 /hShkmbMI4iT3jv7LxnzKHJ0levMJIqrII3LQXKFP6yFCUJlrOZigbCuZZAXiN7S9hsq1mSTfl/
 Lu7FnrjacK5Bh5dVQhxBaklI5Fuq6S3r+xJg5r/HMbAbIK1cUfQmcNQ8m2jW9WJT+fyH1z5swrD
 0J7FK2/tZ8mbHxwdt3YeTBx1m+NzMSSd08ZVR3hSGbFOR8R2MaCwVzakeS3Wy5Je87FlpYv7c8+
 FSoFrF4pjIZOFrp25oQ==
X-Proofpoint-ORIG-GUID: jeEJgoylzkOMUKO_scrzRg22wbu3wVNu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExNCBTYWx0ZWRfX7WaNnf3w/Qba
 8j98qfU6ohhP0XQHp1JRiYtu5lZU413+VDyyyX1QJw+FnWf/56BY6iPuZUQpq14OkH7Rj2afSGP
 oqaP9ZhoJTNPTL5x0DnqpVDPOKvskLQ=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c801c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=q1QqzxBElETWh38XZlcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nqZL9eL4uj2H90IIbDkBXKN-S_DUuj0O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120114
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 7/23/26 12:38 PM, Cornelia Huck wrote:
> Add 11.2 machine types for arm/i440fx/loongarch/m68k/q35/s390x/spapr.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/arm/virt.c              |  9 ++++++++-
>   hw/core/machine.c          |  3 +++
>   hw/i386/pc.c               |  3 +++
>   hw/i386/pc_piix.c          | 13 +++++++++++--
>   hw/i386/pc_q35.c           | 13 +++++++++++--
>   hw/loongarch/virt.c        | 11 +++++++++--
>   hw/m68k/virt.c             |  9 ++++++++-
>   hw/ppc/spapr.c             | 15 +++++++++++++--
>   hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>   include/hw/core/boards.h   |  3 +++
>   include/hw/i386/pc.h       |  3 +++
>   11 files changed, 85 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 219597cabd0b..e7a56e37f731 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -4441,10 +4441,17 @@ static void machvirt_machine_init(void)
>   }
>   type_init(machvirt_machine_init);
>   
> +static void virt_machine_11_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
> +
>   static void virt_machine_11_1_options(MachineClass *mc)
>   {
> +    virt_machine_11_2_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>   }
> -DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
> +DEFINE_VIRT_MACHINE(11, 1)
>   
>   static void virt_machine_11_0_options(MachineClass *mc)
>   {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 805148678d57..354b93c62037 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -40,6 +40,9 @@
>   #include "qemu/audio.h"
>   #include "hw/arm/smmuv3.h"
>   
> +GlobalProperty hw_compat_11_1[] = {};
> +const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
> +
>   GlobalProperty hw_compat_11_0[] = {
>       { "chardev-vc", "encoding", "cp437" },
>       { "tpm-crb", "cap-chunk", "off" },

This hunk doesn't apply because of a5cff318f0 ("virtio-mmio: fix 
QUEUE_NUM_MAX"), but is easy to resolve. I'll fix/pick this.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f064aa2b3e32..e9e4fc262b83 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -74,6 +74,9 @@
>   #include "hw/xen/xen-bus.h"
>   #endif
>   
> +GlobalProperty pc_compat_11_1[] = {};
> +const size_t pc_compat_11_1_len = G_N_ELEMENTS(pc_compat_11_1);
> +
>   GlobalProperty pc_compat_11_0[] = {};
>   const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
>   
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 82457bdb167a..223a19cc4bbc 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -428,12 +428,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
>                        pc_piix_compat_defaults, pc_piix_compat_defaults_len);
>   }
>   
> -static void pc_i440fx_machine_11_1_options(MachineClass *m)
> +static void pc_i440fx_machine_11_2_options(MachineClass *m)
>   {
>       pc_i440fx_machine_options(m);
>   }
>   
> -DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
> +DEFINE_I440FX_MACHINE_AS_LATEST(11, 2);
> +
> +static void pc_i440fx_machine_11_1_options(MachineClass *m)
> +{
> +    pc_i440fx_machine_11_2_options(m);
> +    compat_props_add(m->compat_props, hw_compat_11_1, hw_compat_11_1_len);
> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
> +}
> +
> +DEFINE_I440FX_MACHINE(11, 1);
>   
>   static void pc_i440fx_machine_11_0_options(MachineClass *m)
>   {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 6c1e4eff5f1d..94cd71124b18 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -383,12 +383,21 @@ static void pc_q35_machine_options(MachineClass *m)
>                        pc_q35_compat_defaults, pc_q35_compat_defaults_len);
>   }
>   
> -static void pc_q35_machine_11_1_options(MachineClass *m)
> +static void pc_q35_machine_11_2_options(MachineClass *m)
>   {
>       pc_q35_machine_options(m);
>   }
>   
> -DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
> +DEFINE_Q35_MACHINE_AS_LATEST(11, 2);
> +
> +static void pc_q35_machine_11_1_options(MachineClass *m)
> +{
> +    pc_q35_machine_11_2_options(m);
> +    compat_props_add(m->compat_props, hw_compat_11_1, hw_compat_11_1_len);
> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
> +}
> +
> +DEFINE_Q35_MACHINE(11, 1);
>   
>   static void pc_q35_machine_11_0_options(MachineClass *m)
>   {
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 6693dea647be..9cc79929a8ab 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1465,7 +1465,6 @@ static void virt_class_init(ObjectClass *oc, const void *data)
>       mc->default_ram_id = "loongarch.ram";
>       mc->desc = "QEMU LoongArch Virtual Machine";
>       mc->max_cpus = LOONGARCH_MAX_CPUS;
> -    mc->is_default = 1;
>       mc->default_kernel_irqchip_split = false;
>       mc->block_default_type = IF_VIRTIO;
>       mc->default_boot_order = "c";
> @@ -1546,6 +1545,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
>           MACHINE_VER_DEPRECATION(__VA_ARGS__); \
>           if (latest) { \
>               mc->alias = "virt"; \
> +            mc->is_default = true; \
>           } \
>       } \
>       static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
> @@ -1600,7 +1600,14 @@ static void machvirt_machine_init(void)
>   
>   type_init(machvirt_machine_init);
>   
> +static void virt_machine_11_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
> +
>   static void virt_machine_11_1_options(MachineClass *mc)
>   {
> +    virt_machine_11_2_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>   }
> -DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
> +DEFINE_VIRT_MACHINE(11, 1)
> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
> index 51158ce1c08c..274970978ffb 100644
> --- a/hw/m68k/virt.c
> +++ b/hw/m68k/virt.c
> @@ -367,10 +367,17 @@ type_init(virt_machine_register_types)
>   #define DEFINE_VIRT_MACHINE(major, minor) \
>       DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
>   
> +static void virt_machine_11_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
> +
>   static void virt_machine_11_1_options(MachineClass *mc)
>   {
> +    virt_machine_11_2_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>   }
> -DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
> +DEFINE_VIRT_MACHINE(11, 1)
>   
>   static void virt_machine_11_0_options(MachineClass *mc)
>   {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b79828b4e90c..7e284edd7d0b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4763,15 +4763,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
>   #define DEFINE_SPAPR_MACHINE(major, minor) \
>       DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
>   
> +/*
> + * pseries-11.2
> + */
> +static void spapr_machine_11_2_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE_AS_LATEST(11, 2);
> +
>   /*
>    * pseries-11.1
>    */
>   static void spapr_machine_11_1_class_options(MachineClass *mc)
>   {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_11_2_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>   }
>   
> -DEFINE_SPAPR_MACHINE_AS_LATEST(11, 1);
> +DEFINE_SPAPR_MACHINE(11, 1);
>   
>   /*
>    * pseries-11.0
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 25a9fa495540..55131c1a4445 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -925,14 +925,26 @@ static const TypeInfo ccw_machine_info = {
>       DEFINE_CCW_MACHINE_IMPL(false, major, minor)
>   
>   
> +static void ccw_machine_11_2_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_11_2_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE_AS_LATEST(11, 2);
> +
>   static void ccw_machine_11_1_instance_options(MachineState *machine)
>   {
> +    ccw_machine_11_2_instance_options(machine);
>   }
>   
>   static void ccw_machine_11_1_class_options(MachineClass *mc)
>   {
> +    ccw_machine_11_2_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>   }
> -DEFINE_CCW_MACHINE_AS_LATEST(11, 1);
> +DEFINE_CCW_MACHINE(11, 1);
>   
>   static void ccw_machine_11_0_instance_options(MachineState *machine)
>   {
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index 29c68931d8a7..a436d48c8e52 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -815,6 +815,9 @@ compat_props_add(GPtrArray *arr,
>       }
>   }
>   
> +extern GlobalProperty hw_compat_11_1[];
> +extern const size_t hw_compat_11_1_len;
> +
>   extern GlobalProperty hw_compat_11_0[];
>   extern const size_t hw_compat_11_0_len;
>   
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index d4b6d3ed57fa..ac03da97b645 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -209,6 +209,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
>   /* sgx.c */
>   void pc_machine_init_sgx_epc(PCMachineState *pcms);
>   
> +extern GlobalProperty pc_compat_11_1[];
> +extern const size_t pc_compat_11_1_len;
> +
>   extern GlobalProperty pc_compat_11_0[];
>   extern const size_t pc_compat_11_0_len;
>   


