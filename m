Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF4DCCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 04:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB4HZ-0005a5-TJ; Tue, 21 Oct 2025 00:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vB4HX-0005Zl-W8; Tue, 21 Oct 2025 00:47:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vB4HU-0001gV-6B; Tue, 21 Oct 2025 00:47:35 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KMmlEL015153;
 Tue, 21 Oct 2025 04:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GgvboB
 U+W647qvpi+meffxeQma1mChnfSc+CHzTZfuo=; b=M36JHK6gdyD99so4Djt3IU
 XvT4+0XWY9LGhvqo9iEeGKac0Onar6ZirgLUPaSFPnJmnJKfSGoOf08g0ghx/Bcs
 3HBncOpQ/giveOWCNEp4M3tn9pzgBROVez+jvk3ddaYvbAHXPldxq8uH4luowwh6
 /DfAF6qt4fUTYUHcJ6Dr+H+n5jJbJOnFihsLS7oljrQoEabyAJFODOiasOmlbBZQ
 sS+PAZ7gOgrhGW1UhF30Qt8GRrQ/2tRkBB5UR+sRorw/PiwnqHdU82vi7Cq+d50v
 3ghIAjGE4+6wBFk4oBItcBgJSdc/bBH78wgRuaiDBdaTSPtbwQV0vkhBc3t7tN6A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rw2fd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 04:47:23 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59L4lN2U007345;
 Tue, 21 Oct 2025 04:47:23 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rw2f9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 04:47:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L06iUc002281;
 Tue, 21 Oct 2025 04:47:22 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqej8urm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 04:47:22 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59L4lLe124052272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 04:47:21 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A000F58067;
 Tue, 21 Oct 2025 04:47:21 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5417758056;
 Tue, 21 Oct 2025 04:47:18 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Oct 2025 04:47:18 +0000 (GMT)
Message-ID: <fa5751f3-3e72-40cc-aaa3-2ecb66dbdce3@linux.ibm.com>
Date: Tue, 21 Oct 2025 10:17:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] hw/boards: Extend DEFINE_MACHINE macro to cover
 more use cases
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <d75c8bbed97650f1a4d2d675444582a240a335b4.1760798392.git.balaton@eik.bme.hu>
 <9a1fe708-66a1-489c-ad2f-23705497c470@linaro.org>
 <00108467-9f4f-4078-a430-0f18297da94c@linaro.org>
 <814b7e32-07ae-5872-f94f-cf5b04dac2d7@eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <814b7e32-07ae-5872-f94f-cf5b04dac2d7@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZrA6MZVnCjYWv7AIh4M-C06bV2HdRmH7
X-Proofpoint-GUID: 0KPDEwk9uV-Gr5IQ7BiwOcI1YvSssYug
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXxlIU2Evbqagj
 LKJpz+UP/Aw1f8knwvEV5v+vqzI9U69d+nx4p+Z3BMYPJcTAxYSAywUwQyn50uC1mTUUbn78z5b
 u33iutmnyifwumk6B2tmOR1hUDifjkNECDpY75RJzs/ztZyVIRW3orPlwA2c+cun3+sOvCemiaF
 AuebfyHyNuQDsfZv2W0Cioaw3KUSteri5Kt2zcmmqhnDr9Tfm18aXgeFWSRS+Dqoz0UBvILvKqz
 R/ZFuoG5fy0rlIMItm+OYu7PUx16S39bSVxxJ/iZy2gw/hIKR0ARZRfohnKHoHKwI4gsMmz9sSM
 Psi3JgyAmEC7OXNOc2abZeGt60nxuZ2pHjDHWjzeH0eC9lmRAKxqNm9B4HhZ1kt2PNzM3KZXOt8
 SJEDP61htTrCPmJHQX8Mr42kFYSqog==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f7105b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VfDTYis41J_8eadQhHkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

+ Eduardo, Marcel (since changes in boards.h)

On 10/20/25 21:05, BALATON Zoltan wrote:
> On Mon, 20 Oct 2025, Philippe Mathieu-Daudé wrote:
>> +Pierrick
>>
>> On 20/10/25 17:05, Philippe Mathieu-Daudé wrote:
>>> On 18/10/25 17:11, BALATON Zoltan wrote:
>>>> Add a more general DEFINE_MACHINE_EXTENDED macro and define simpler
>>>> versions with less parameters based on that. This is inspired by how
>>>> the OBJECT_DEFINE macros do this in a similar way to allow using the
>>>> shortened definition in more complex cases too.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>   include/hw/boards.h | 16 ++++++++++++++--
>>>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>>> index 665b620121..fd3d549ff5 100644
>>>> --- a/include/hw/boards.h
>>>> +++ b/include/hw/boards.h
>>>> @@ -762,7 +762,8 @@ struct MachineState {
>>>>           } \
>>>>       } while (0)
>>>> -#define DEFINE_MACHINE(namestr, machine_initfn) \
>>>> +#define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
>>>> +                                machine_initfn, ABSTRACT, ...) \
>>>>       static void machine_initfn##_class_init(ObjectClass *oc, const 
>>>> void *data) \
>>>>       { \
>>>>           MachineClass *mc = MACHINE_CLASS(oc); \
>>>> @@ -770,8 +771,11 @@ struct MachineState {
>>>>       } \
>>>>       static const TypeInfo machine_initfn##_typeinfo = { \
>>>>           .name       = MACHINE_TYPE_NAME(namestr), \
>>>> -        .parent     = TYPE_MACHINE, \
>>>> +        .parent     = TYPE_##PARENT_NAME, \
>>>>           .class_init = machine_initfn##_class_init, \
>>>> +        .instance_size = sizeof(InstanceName), \
>>>> +        .abstract = ABSTRACT, \
>>
>> IIUC we don't want to have abstract type with interfaces, but
>> only QOM leaves. So maybe better always use .abstract = false in
>> DEFINE_MACHINE_EXTENDED()?
> 
> Where did you get that from? What about these then:
> 
> static const TypeInfo pnv_psi_info
> static const TypeInfo spapr_machine_info
> static const TypeInfo e1000_base_info
> static const TypeInfo ivshmem_common_info
> static const TypeInfo macio_type_info
> static const TypeInfo bus_info
> static const TypeInfo device_type_info
> static const TypeInfo hppa_machine_types
> static const TypeInfo qxl_pci_type_info
> static const TypeInfo pic_common_type
> static const TypeInfo xive2_router_info
> static const TypeInfo arm_gic_common_type
> static const TypeInfo arm_gicv3_common_type
> static const TypeInfo ioapic_common_type
> static const TypeInfo loongarch_extioi_common_types
> static const TypeInfo rp_info
> static const TypeInfo virt_machine_info (hw/arm/virt.c)
> static const TypeInfo mps2tz_info
> static const TypeInfo armsse_info
> static const TypeInfo m48txx_isa_type_info
> static const TypeInfo m48txx_sysbus_type_info
> static const TypeInfo pci_ide_type_info
> static const TypeInfo ccw_machine_info
> static const TypeInfo virtio_ccw_md_info
> static const TypeInfo pc_machine_info
> static const TypeInfo x86_machine_info
> static const TypeInfo vfio_pci_device_info
> static const TypeInfo ehci_pci_type_info
> static const TypeInfo xhci_pci_info
> static const TypeInfo uhci_pci_type_info
> static const TypeInfo via_pm_info
> static const TypeInfo via_isa_info
> static const TypeInfo piix_pci_type_info
> static const TypeInfo pcie_slot_type_info
> static const TypeInfo pci_bridge_type_info
> static const TypeInfo intel_hda_info
> static const TypeInfo virtio_md_pci_info
> 
>>>> +        .interfaces = (const InterfaceInfo[]) { __VA_ARGS__ } , \
>>>
>>> IIUC Richard asked for array argument in order to save .rodata?
> 
> Do you have an example for that? I'm not sure what do you mean.
> 
> Regards,
> BALATON Zoltan
> 
>>>>       }; \
>>>>       static void machine_initfn##_register_types(void) \
>>>>       { \
>>>> @@ -779,6 +783,14 @@ struct MachineState {
>>>>       } \
>>>>       type_init(machine_initfn##_register_types)
>>>> +#define DEFINE_MACHINE(namestr, machine_initfn) \
>>>> +    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, 
>>>> machine_initfn, \
>>>> +                            false, { })
>>>> +
>>>> +#define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
>>>> +    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, 
>>>> machine_initfn, \
>>>> +                            false, __VA_ARGS__)
>>>> +
>>>>   extern GlobalProperty hw_compat_10_1[];
>>>>   extern const size_t hw_compat_10_1_len;
>>
>>

