Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA99C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 20:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcVmI-0001GP-6c; Mon, 27 Jan 2025 15:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tcVmG-0001FG-2y; Mon, 27 Jan 2025 15:32:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tcVmE-0002Sm-6Z; Mon, 27 Jan 2025 15:32:11 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RFuvva025771;
 Mon, 27 Jan 2025 20:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cZpMuj
 +fM3X7a4+76JOAdq3UPWr4FwRFkfFhHshxUP4=; b=f1AOPnEEn1wD7ey9gWURVr
 4d9xBnmsc2VRpVqLg0GX34iQvhZ3ZzFmCgb+TMT2qDcAIN2AavJLULnmVOSM/3Uv
 N/aTvrbnT93MlzssI9mE8xDX61kZZ4dgpMe6q5RmnzQBCOg/hKo81WD/tyoUyljw
 dp9WZ6+eHp5251thAc98Cm8h7OdrtGyA+3Qq/oV/aTrD/JpAecMYaYGvV8Yd+J6R
 gNRkccaJw004EeQSUxQ6nab/3yERgCxh4G1Ou93Rtg2Gt+rSvsH98Aj4edF352zv
 7PcxwdzFEAKPsVj9SVl+6d6GlLqkEcopXI4+kAcpnodPC4nFvnJCKaSruHWMw7Rw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44e079d360-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2025 20:31:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50RHPWUZ022236;
 Mon, 27 Jan 2025 20:31:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dcgjfqr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2025 20:31:36 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50RKVYdF31916650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 20:31:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D29FE58059;
 Mon, 27 Jan 2025 20:31:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91A3758043;
 Mon, 27 Jan 2025 20:31:33 +0000 (GMT)
Received: from [9.61.39.122] (unknown [9.61.39.122])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jan 2025 20:31:33 +0000 (GMT)
Message-ID: <316ba215-929a-4311-be9b-12c4410e545c@linux.ibm.com>
Date: Mon, 27 Jan 2025 15:31:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] s390x/pci: add support for guests that request
 direct mapping
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
References: <20250124202115.349386-1-mjrosato@linux.ibm.com>
 <20250124202115.349386-2-mjrosato@linux.ibm.com>
 <cbe2a998-dc7d-4e86-8da6-659759f1b0cd@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <cbe2a998-dc7d-4e86-8da6-659759f1b0cd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uebRj63nwtGI2xNyCzTFRdpM4vGauSZC
X-Proofpoint-GUID: uebRj63nwtGI2xNyCzTFRdpM4vGauSZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_10,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501270161
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


>>   +void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu)
>> +{
>> +    MachineState *ms = MACHINE(qdev_get_machine());
>> +    S390CcwMachineState *s390ms = S390_CCW_MACHINE(ms);
>> +
>> +    /*
>> +     * For direct-mapping we must map the entire guest address space.  Rather
>> +     * than using an iommu, create a memory region alias that maps GPA X to
>> +     * iova X + SDMA.  VFIO will handle pinning via its memory listener.
>> +     */
>> +    g_autofree char *name = g_strdup_printf("iommu-dm-s390-%04x",
>> +                                            iommu->pbdev->uid);
>> +    memory_region_init_alias(&iommu->dm_mr, OBJECT(&iommu->mr), name, ms->ram,
>> +                             0, s390_get_memory_limit(s390ms));
> 
> Hm, the memory limit can exceed  ms->ram.
> 
> Would it be possible to use get_system_memory() here, such that whatever is mapped into physical address space (including virtio-mem devices etc) would simply be aliased with an offset?
> 
> Or does that blow up elsewhere?

Testing with

    memory_region_init_alias(&iommu->dm_mr, OBJECT(&iommu->mr), name,
                             get_system_memory(), 0,
                             s390_get_memory_limit(s390ms));

Looks good so far, will change for next version


> 
> target/i386/kvm/kvm.c seems to do that:
> 
> memory_region_init_alias(&smram_as_mem, OBJECT(kvm_state), "mem-smram",
>              get_system_memory(), 0, ~0ull);
> 
> and target/i386/tcg/system/tcg-cpu.c
> 


