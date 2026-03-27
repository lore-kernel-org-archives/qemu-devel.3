Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFE410F284A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6A0R-0003aY-QY; Fri, 27 Mar 2026 12:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w6A0O-0003ZG-3M; Fri, 27 Mar 2026 12:25:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w6A0M-0007gl-7U; Fri, 27 Mar 2026 12:25:51 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62REd08s3640057; Fri, 27 Mar 2026 16:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4Kpmy0
 nocA4XGBRZnxcTxESuqTaa2DrO7Dbh6zOZEAM=; b=jDq1yOKYUMWkCjiJta755e
 rSJaFhmtoyA0znuRIkE09Li3KWCUnUZkpUlQVeU659MentLmDKOJBezyXychQ8c4
 KBBdNNX3fsIbeFv85LnCz0yfZzcW9H6Q61JS5nQPZXlHnDu/k+2NH1BGU1nd8yDT
 v3Z0d188hv+poPyPTX0KZt93wmiGx+jq82BKlyu2CEQRRS0DVeSYiCZJobDLrTab
 XsJf/juu/MiQhlUBytBr1rIhShpsdvXrtDPOqkMpt+Dxf9sDMqp+KvNHNyrjABUZ
 oexH5GrBwnsO2vcqozjwwI5K2UNoWkPU3RMApQf1jbnycZyPheX6tl5lEemgj1zw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky0huey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 16:25:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RF3L5w009143;
 Fri, 27 Mar 2026 16:25:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26np07u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 16:25:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62RGPk0Y23921220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2026 16:25:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 661CA58056;
 Fri, 27 Mar 2026 16:25:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69C595805A;
 Fri, 27 Mar 2026 16:25:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Mar 2026 16:25:45 +0000 (GMT)
Message-ID: <d529bf0d-7385-4a3a-b8e0-094b7b8a9c26@linux.ibm.com>
Date: Fri, 27 Mar 2026 12:25:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] hw/tpm: add PPI support to tpm-tis-device on ARM64
 virt
To: Mohammadfaiz Bawa <mbawa@redhat.com>
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com,
 pierrick.bouvier@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, mohamed@unpredictable.fr
References: <20260327-tpm-tis-sysbus-ppi-v2-0-d8ec84d25dbc@redhat.com>
 <d7f6f5e3-678a-4a63-8031-1af2cfd2c7a2@linux.ibm.com>
 <CAJg9Kky+TJO_gDoYs_+sOGqQ0j7Gw4tWrboAooby3F_sWPYOKA@mail.gmail.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAJg9Kky+TJO_gDoYs_+sOGqQ0j7Gw4tWrboAooby3F_sWPYOKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDExMyBTYWx0ZWRfX0Z35BtI1N0yK
 9oN5TBaMKrQxd/VQZUPjgMMatlS9Fir+YKxM0kC7zZG1738TqSvnnIvcbQsuKQlr6MJqudcjTTM
 KoNeC9xdDr920RTU4fLqMhJ4YcUBSiJP7YPB3gpHajON3v0JocahC5ebJe1U95HuhCZRMfS7r4U
 TO2cfg4mWxysD41QlZU2LSjHeE7TLw7lqmmPihzEqFgPhw9AakPk2N4/GpN+/aFgb5i7W5LwJay
 ubsCGH9743Bd/sGCwg5nKahUZz23sOfNIPosottIuwchH5Le2lDGc3RkuUiTrXNA+MI75KnWiwM
 Ig079uo/hh52GAlqx1w8zl2z2+YtuRaMaKpo/rmOeM3NBDP3skxp8U5Y1peu8NWPTdRQLlXGIQg
 EQX30kcwbPm5w2rka+yx6OK1FZ2S05gex3iqTIgkMGYdfroleVo/PxqWI8zgwAQwcqiUusZCnlk
 fmc7XpiGRJVLnieuzKg==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c6af8c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=m9nI0JjokUbbiq9yuuIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: rIUHrz06cNJvKf3aURcIdK_DMI-bSPRu
X-Proofpoint-GUID: 3lsvFAwvD5259gvIuRqu1Eyfhc6aR04h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270113
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 3/27/26 12:05 PM, Mohammadfaiz Bawa wrote:
> On Fri, Mar 27, 2026 at 9:15 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 3/27/26 7:48 AM, Mohammadfaiz Bawa wrote:
>>> The ARM virt machine's tpm-tis-device lacks Physical Presence Interface
>>> (PPI) support - no _DSM, _STA, or PPI operation regions in the ACPI
>>> namespace. This causes Windows 11 ARM64 guests to log Event ID 15
>>> (tpm.sys) errors per boot.
>>>
>>> This series documents the change, refactors tpm_build_ppi_acpi() to
>>> accept a dynamic PPI base address, then wires up PPI MMIO and ACPI
>>> on tpm-tis-sysbus via the platform bus.
>>>
>>> Tested: aarch64 KVM, upstream QEMU, Win11 ARM64 25H2, swtpm.
>>> Event ID 15 eliminated.
>>>
>>> Changes in v2:
>>> - Moved tpm.rst documentation hunk from patch 3 into patch 1 (Stefan)
>>> - Added Reviewed-by tags
>>>
>>> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
>>> ---
>>> Mohammadfaiz Bawa (3):
>>>         docs/specs/tpm: document PPI support on ARM64 virt
>>>         hw/acpi/tpm: parameterize PPI base address in tpm_build_ppi_acpi
>>>         hw/tpm: add PPI support to tpm-tis-device for ARM64 virt
>>>
>>>    docs/specs/tpm.rst       | 24 ++++++++++++++++++++++++
>>>    hw/acpi/tpm.c            |  8 ++++----
>>>    hw/arm/virt-acpi-build.c |  9 ++++++++-
>>>    hw/tpm/tpm_tis_isa.c     |  2 +-
>>>    hw/tpm/tpm_tis_sysbus.c  | 11 +++++++++++
>>>    include/hw/acpi/tpm.h    |  3 ++-
>>>    6 files changed, 50 insertions(+), 7 deletions(-)
>>> ---
>>> base-commit: 8e711856d7639cbffa51405f2cc2366e3d9e3a23
>>> change-id: 20260324-tpm-tis-sysbus-ppi-ef31a7d71753
>>
>> Does this branch contain this series here:
>>
>> https://lore.kernel.org/qemu-devel/20260317120241.16320-1-philmd@linaro.org/
>>
>> A patch in this series changed TPMState to not have ppi_enabled anymore:
>>
>> diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
>> index 184632ff66..1531620bf9 100644
>> --- a/hw/tpm/tpm_tis.h
>> +++ b/hw/tpm/tpm_tis.h
>> @@ -75,7 +75,6 @@ typedef struct TPMState {
>>
>>        size_t be_buffer_size;
>>
>> -    bool ppi_enabled;
>>        TPMPPI ppi;
>>    } TPMState;
>>
> 
> No, my branch doesn't include this series. Looking at it, the only thing
> I'd need to adjust is a small change in patch 3, the ppi_enabled
> property wiring in
> tpm_tis_sysbus.c. The rest should apply cleanly on top.
> 
> Happy to rebase and send v3 on top once it's ready, or however
> you'd like to handle it.

Please rebase. That series should be ready.


> 
> 
>>
>>>
>>> Best regards,
>>
> 


