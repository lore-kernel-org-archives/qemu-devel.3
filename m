Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9671FCE8D55
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 04:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr8gw-0003ka-4R; Thu, 19 Sep 2024 00:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sr8gu-0003iI-MA; Thu, 19 Sep 2024 00:22:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sr8gr-0004iL-W3; Thu, 19 Sep 2024 00:22:52 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IIP2CS018273;
 Thu, 19 Sep 2024 04:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=9
 5u1DYlnvISlhbA20kHPYmiwVdtwBPQuyPZrRrI7ZtQ=; b=YFU5YVNeYBq27w8LJ
 iDtAP7YvUSAEzQSRgrlIkA30SMEEA33ItZ33mSMDTHgvkwwbtM5k794mTKN4+Wud
 zMd/zgqg3ax+PfWFkyts4jDCgZPy386BCH33sVVNr7hs7+kg0DHO8TX/cUueMY80
 44oIb+3uR/fSdh3uUKgy0pqNr1HWDYjoxKUp3p9tUz4bZ6z5yXmnIeJ3lqYami1q
 eZMMNheDa+7/YDMbk1z+eU1ii4AMzoJQEXrrbi+Hsv93tmEdHu3ZVs9TRn7S7H7H
 RMd68xLHVjVDJGIqsBd+tnGZ9A5+A+IkcfvFAiGOUJfftgDPgHM6IK2t+lYp5Zqv
 iUUkA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vdsqbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Sep 2024 04:21:53 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48J4LrJ7024625;
 Thu, 19 Sep 2024 04:21:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vdsqb8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Sep 2024 04:21:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48J3VQXP031056;
 Thu, 19 Sep 2024 04:21:52 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41npanf1js-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Sep 2024 04:21:52 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48J4LpJx17367564
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Sep 2024 04:21:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8623A5805F;
 Thu, 19 Sep 2024 04:21:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC90458043;
 Thu, 19 Sep 2024 04:21:49 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Sep 2024 04:21:49 +0000 (GMT)
Message-ID: <83ed520d-b8b1-4f25-b003-ff48e2f3c57a@linux.ibm.com>
Date: Thu, 19 Sep 2024 09:51:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: remove deprecated machines specific code
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com
References: <20240917060300.943496-1-harshpb@linux.ibm.com>
 <6ed1b5e4-cdd4-4805-ae24-36810ef11fe3@kaod.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <6ed1b5e4-cdd4-4805-ae24-36810ef11fe3@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yZ_MdrjFO2poKTzKNuZ1G6mmtT6SkcWD
X-Proofpoint-GUID: eqgflQhUHQDgIgYqPmEi2NdtepglZhFK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_02,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409190025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Cedric,

On 9/17/24 12:31, Cédric Le Goater wrote:
> Hello Harsh,
> 
> On 9/17/24 08:03, Harsh Prateek Bora wrote:
>> Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
>> deprecated with reasons mentioned in its commit log.
>> Removing the arch specific code for the now deprecated machine types.
>>
>> Suggested-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
> There is more to it :/
> 
> Some machine versions have their own set of properties, like the
> "pre-*-migration" ones, and the associated code should be removed
> also. It impacts more models than just the machine model.
> 
> I suggest one patch per machine version, or one patch per complex
> machine version and a combo patch for the simple ones.

Sure, I shall post v2 as a patchset addressing your inputs.

regards,
Harsh

> 
> Thanks,
> 
> C.
> 
> 
>> ---
>>   hw/ppc/spapr.c | 235 -------------------------------------------------
>>   1 file changed, 235 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 8aa3ce7449..04f06377b4 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -5157,241 +5157,6 @@ static void 
>> spapr_machine_2_12_sxxm_class_options(MachineClass *mc)
>>   DEFINE_SPAPR_MACHINE_TAGGED(2, 12, sxxm);
>> -/*
>> - * pseries-2.11
>> - */
>> -
>> -static void spapr_machine_2_11_class_options(MachineClass *mc)
>> -{
>> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>> -
>> -    spapr_machine_2_12_class_options(mc);
>> -    smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_ON;
>> -    compat_props_add(mc->compat_props, hw_compat_2_11, 
>> hw_compat_2_11_len);
>> -}
>> -
>> -DEFINE_SPAPR_MACHINE(2, 11);
>> -
>> -/*
>> - * pseries-2.10
>> - */
>> -
>> -static void spapr_machine_2_10_class_options(MachineClass *mc)
>> -{
>> -    spapr_machine_2_11_class_options(mc);
>> -    compat_props_add(mc->compat_props, hw_compat_2_10, 
>> hw_compat_2_10_len);
>> -}
>> -
>> -DEFINE_SPAPR_MACHINE(2, 10);
>> -
>> -/*
>> - * pseries-2.9
>> - */
>> -
>> -static void spapr_machine_2_9_class_options(MachineClass *mc)
>> -{
>> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>> -    static GlobalProperty compat[] = {
>> -        { TYPE_POWERPC_CPU, "pre-2.10-migration", "on" },
>> -    };
>> -
>> -    spapr_machine_2_10_class_options(mc);
>> -    compat_props_add(mc->compat_props, hw_compat_2_9, 
>> hw_compat_2_9_len);
>> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>> -    smc->pre_2_10_has_unused_icps = true;
>> -    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
>> -}
>> -
>> -DEFINE_SPAPR_MACHINE(2, 9);
>> -
>> -/*
>> - * pseries-2.8
>> - */
>> -
>> -static void spapr_machine_2_8_class_options(MachineClass *mc)
>> -{
>> -    static GlobalProperty compat[] = {
>> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, 
>> "pcie-extended-configuration-space", "off" },
>> -    };
>> -
>> -    spapr_machine_2_9_class_options(mc);
>> -    compat_props_add(mc->compat_props, hw_compat_2_8, 
>> hw_compat_2_8_len);
>> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>> -    mc->numa_mem_align_shift = 23;
>> -}
>> -
>> -DEFINE_SPAPR_MACHINE(2, 8);
>> -
>> -/*
>> - * pseries-2.7
>> - */
>> -
>> -static bool phb_placement_2_7(SpaprMachineState *spapr, uint32_t index,
>> -                              uint64_t *buid, hwaddr *pio,
>> -                              hwaddr *mmio32, hwaddr *mmio64,
>> -                              unsigned n_dma, uint32_t *liobns, Error 
>> **errp)
>> -{
>> -    /* Legacy PHB placement for pseries-2.7 and earlier machine types */
>> -    const uint64_t base_buid = 0x800000020000000ULL;
>> -    const hwaddr phb_spacing = 0x1000000000ULL; /* 64 GiB */
>> -    const hwaddr mmio_offset = 0xa0000000; /* 2 GiB + 512 MiB */
>> -    const hwaddr pio_offset = 0x80000000; /* 2 GiB */
>> -    const uint32_t max_index = 255;
>> -    const hwaddr phb0_alignment = 0x10000000000ULL; /* 1 TiB */
>> -
>> -    uint64_t ram_top = MACHINE(spapr)->ram_size;
>> -    hwaddr phb0_base, phb_base;
>> -    int i;
>> -
>> -    /* Do we have device memory? */
>> -    if (MACHINE(spapr)->device_memory) {
>> -        /* Can't just use maxram_size, because there may be an
>> -         * alignment gap between normal and device memory regions
>> -         */
>> -        ram_top = MACHINE(spapr)->device_memory->base +
>> -            memory_region_size(&MACHINE(spapr)->device_memory->mr);
>> -    }
>> -
>> -    phb0_base = QEMU_ALIGN_UP(ram_top, phb0_alignment);
>> -
>> -    if (index > max_index) {
>> -        error_setg(errp, "\"index\" for PAPR PHB is too large (max %u)",
>> -                   max_index);
>> -        return false;
>> -    }
>> -
>> -    *buid = base_buid + index;
>> -    for (i = 0; i < n_dma; ++i) {
>> -        liobns[i] = SPAPR_PCI_LIOBN(index, i);
>> -    }
>> -
>> -    phb_base = phb0_base + index * phb_spacing;
>> -    *pio = phb_base + pio_offset;
>> -    *mmio32 = phb_base + mmio_offset;
>> -    /*
>> -     * We don't set the 64-bit MMIO window, relying on the PHB's
>> -     * fallback behaviour of automatically splitting a large "32-bit"
>> -     * window into contiguous 32-bit and 64-bit windows
>> -     */
>> -
>> -    return true;
>> -}
>> -
>> -static void spapr_machine_2_7_class_options(MachineClass *mc)
>> -{
>> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>> -    static GlobalProperty compat[] = {
>> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0xf80000000", },
>> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem64_win_size", "0", },
>> -        { TYPE_POWERPC_CPU, "pre-2.8-migration", "on", },
>> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pre-2.8-migration", "on", },
>> -    };
>> -
>> -    spapr_machine_2_8_class_options(mc);
>> -    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power7_v2.3");
>> -    mc->default_machine_opts = "modern-hotplug-events=off";
>> -    compat_props_add(mc->compat_props, hw_compat_2_7, 
>> hw_compat_2_7_len);
>> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>> -    smc->phb_placement = phb_placement_2_7;
>> -}
>> -
>> -DEFINE_SPAPR_MACHINE(2, 7);
>> -
>> -/*
>> - * pseries-2.6
>> - */
>> -
>> -static void spapr_machine_2_6_class_options(MachineClass *mc)
>> -{
>> -    static GlobalProperty compat[] = {
>> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "ddw", "off" },
>> -    };
>> -
>> -    spapr_machine_2_7_class_options(mc);
>> -    mc->has_hotpluggable_cpus = false;
>> -    compat_props_add(mc->compat_props, hw_compat_2_6, 
>> hw_compat_2_6_len);
>> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>> -}
>> -
>> -DEFINE_SPAPR_MACHINE(2, 6);
>> -
>> -/*
>> - * pseries-2.5
>> - */
>> -
>> -static void spapr_machine_2_5_class_options(MachineClass *mc)
>> -{
>> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>> -    static GlobalProperty compat[] = {
>> -        { "spapr-vlan", "use-rx-buffer-pools", "off" },
>> -    };
>> -
>> -    spapr_machine_2_6_class_options(mc);
>> -    smc->use_ohci_by_default = true;
>> -    compat_props_add(mc->compat_props, hw_compat_2_5, 
>> hw_compat_2_5_len);
>> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>> -}
>> -
>> -DEFINE_SPAPR_MACHINE(2, 5);
>> -
>> -/*
>> - * pseries-2.4
>> - */
>> -
>> -static void spapr_machine_2_4_class_options(MachineClass *mc)
>> -{
>> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>> -
>> -    spapr_machine_2_5_class_options(mc);
>> -    smc->dr_lmb_enabled = false;
>> -    compat_props_add(mc->compat_props, hw_compat_2_4, 
>> hw_compat_2_4_len);
>> -}
>> -
>> -DEFINE_SPAPR_MACHINE(2, 4);
>> -
>> -/*
>> - * pseries-2.3
>> - */
>> -
>> -static void spapr_machine_2_3_class_options(MachineClass *mc)
>> -{
>> -    static GlobalProperty compat[] = {
>> -        { "spapr-pci-host-bridge", "dynamic-reconfiguration", "off" },
>> -    };
>> -    spapr_machine_2_4_class_options(mc);
>> -    compat_props_add(mc->compat_props, hw_compat_2_3, 
>> hw_compat_2_3_len);
>> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>> -}
>> -DEFINE_SPAPR_MACHINE(2, 3);
>> -
>> -/*
>> - * pseries-2.2
>> - */
>> -
>> -static void spapr_machine_2_2_class_options(MachineClass *mc)
>> -{
>> -    static GlobalProperty compat[] = {
>> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0x20000000" },
>> -    };
>> -
>> -    spapr_machine_2_3_class_options(mc);
>> -    compat_props_add(mc->compat_props, hw_compat_2_2, 
>> hw_compat_2_2_len);
>> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>> -    mc->default_machine_opts = 
>> "modern-hotplug-events=off,suppress-vmdesc=on";
>> -}
>> -DEFINE_SPAPR_MACHINE(2, 2);
>> -
>> -/*
>> - * pseries-2.1
>> - */
>> -
>> -static void spapr_machine_2_1_class_options(MachineClass *mc)
>> -{
>> -    spapr_machine_2_2_class_options(mc);
>> -    compat_props_add(mc->compat_props, hw_compat_2_1, 
>> hw_compat_2_1_len);
>> -}
>> -DEFINE_SPAPR_MACHINE(2, 1);
>> -
>>   static void spapr_machine_register_types(void)
>>   {
>>       type_register_static(&spapr_machine_info);
> 

