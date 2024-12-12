Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC3EE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkP1-0007AD-QN; Thu, 12 Dec 2024 09:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tLkOs-000798-O7; Thu, 12 Dec 2024 09:42:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tLkOn-00041U-Sc; Thu, 12 Dec 2024 09:42:46 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC60V0o000724;
 Thu, 12 Dec 2024 14:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JKYPUX
 zT4eeZNWweVHBUtTi4XwSojwEPHXoeXjVggVs=; b=ihRRmcZixJF35lbufc4N8P
 xNvioWjHKpaZZzf2iC0v0DMKL2sT9vAdzRV2e0BBtelLKJ392EquSTON9hY2u/SH
 uousehJXerlUxGwdJq/K01rw9mzk4qtUjJSYf0tHyyRmkWKMG7fuqGnY3QEhcKem
 tkQgEe6eVXFbKKHzeTc2DHFh+bmEwzkUJ/jf8jLpSuw5RjZsCRvbld46riK7fTOz
 boQEERpzQjrEmog5seO48EqEC9KkXqOfoaqxI2Yac3u4izaOXDpsCksvUFsY4/3T
 ySJuNfRMrJIGcove+Qvh/TjQY+a7YleTgYh2tgDKX2xsN3ak5VOmpfv94Re7H54g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ft6d2nmg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2024 14:42:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCD7H1b032724;
 Thu, 12 Dec 2024 14:42:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0pss6f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2024 14:42:37 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BCEga8X17236538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2024 14:42:37 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9884258059;
 Thu, 12 Dec 2024 14:42:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BC905804B;
 Thu, 12 Dec 2024 14:42:35 +0000 (GMT)
Received: from [9.61.107.222] (unknown [9.61.107.222])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2024 14:42:35 +0000 (GMT)
Message-ID: <9b143fc7-9ac7-4b87-8089-5209aab186ec@linux.ibm.com>
Date: Thu, 12 Dec 2024 09:42:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] s390x/pci: relax I/O address translation requirement
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
 <990f5ccd-b05f-4e25-bc68-60793d4d21ad@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <990f5ccd-b05f-4e25-bc68-60793d4d21ad@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H1F4Y7wXeKm7haJt0I1oBQVpZ0k27znI
X-Proofpoint-ORIG-GUID: H1F4Y7wXeKm7haJt0I1oBQVpZ0k27znI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxlogscore=809 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120104
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12/12/24 4:10 AM, Thomas Huth wrote:
> On 09/12/2024 20.29, Matthew Rosato wrote:
>> This series introduces the concept of the relaxed translation requirement
>> for s390x guests in order to allow bypass of the guest IOMMU for more
>> efficient PCI passthrough.
>>
>> With this series, QEMU can indicate to the guest that an IOMMU is not
>> strictly required for a zPCI device.  This would subsequently allow a
>> guest linux to use iommu.passthrough=1 and bypass their guest IOMMU for
>> PCI devices.
>>
>> When this occurs, QEMU will note the behavior via an intercepted MPCIFC
>> instruction and will fill the host iommu with mappings of the entire
>> guest address space in response.
>>
>> There is a kernel series [1] that adds the relevant behavior needed to
>> exploit this new feature from within a s390x linux guest.
>>
>> [1]: https://lore.kernel.org/linux-s390/20241209192403.107090-1-mjrosato@linux.ibm.com/
>>
>> Matthew Rosato (2):
>>    s390x/pci: add support for guests that request direct mapping
>>    s390x/pci: indicate QEMU supports relaxed translation for passthrough
> 
>  Hi again!
> 
> One more thought: This is a guest-visible feature, isn't it? So do we also need some migration handling for this? For example, what happens if you start a guest that is aware of this feature on a host that has a QEMU with this feature, and then try to live-migrate the guest to a QEMU that does not have this feature? I guess the guest will crash? It would be better to fail the migration instead. At least we should disable the feature in older machine types and only allow it for the latest one.

zPCI devices are currently marked as unmigratable in s390_pci_device_vmstate so it's not a reproducible issue yet.

Re: disabling the feature for older machines, OK -- Shall I fence similar to what we did for interpret/forwarding-assist with a new device property that is default to off on older machines ("relax-translation"? alternative suggestions welcome) 



