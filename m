Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881B6C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 15:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk3Jz-0008GZ-HI; Mon, 17 Feb 2025 10:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.ibm.com>)
 id 1tk3Jx-0008GC-21; Mon, 17 Feb 2025 10:46:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.ibm.com>)
 id 1tk3Js-0005Ha-Jx; Mon, 17 Feb 2025 10:46:08 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HAYUKi029535;
 Mon, 17 Feb 2025 15:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nY02Z9
 unjNhlICgDCQWo0N7MdIljjOyUwb6lt3AU0Fk=; b=NW+xzMc/YG9YKDBYaHioh+
 0j3BaGJuALzw9pwLQwQ//IIq9UWkaSEtck+h5VM5CY7j9xbFgH3VcnjRyBpxzHaB
 55BaKXmYo7TrEuOMHnlOWwKW5EcX330P/5nhlsC4epJV8qZdExPPjOjsbiXuPz2x
 4kLjxgx1PhvWLanLBFrYhh4paSYkmuYH0zFs0udNQDfQssoS8SoPYtziGJi99hAC
 m0ibFLu8eciPA5l6tBxLmtWQfXR/ZuB0nxaLW5BFVXTIJSvL9oUtplSF4fKVYPHZ
 mfqhlu4JldAflQondZOBe2pWQYtCWsU0EzP//urDptjjkBMU3qGQKEczHpyvTt8w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44us5a4696-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 15:45:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51HDXq78032427;
 Mon, 17 Feb 2025 15:45:56 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u6rkpntx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 15:45:56 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51HFjtjv36176472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 15:45:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92D3858055;
 Mon, 17 Feb 2025 15:45:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BBB958059;
 Mon, 17 Feb 2025 15:45:55 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Feb 2025 15:45:55 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 17 Feb 2025 09:45:54 -0600
From: dan tan <dantan@linux.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: dan tan <dantan@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com
Subject: Re: [PATCH v9 1/3] tpm/tpm_tis_spi: Support TPM for SPI (Serial
 Peripheral Interface)
In-Reply-To: <b13a02f2-c41f-4d51-8f60-5c97cd96c488@linaro.org>
References: <20250216221155.30013-1-dantan@linux.vnet.ibm.com>
 <20250216221155.30013-2-dantan@linux.vnet.ibm.com>
 <b13a02f2-c41f-4d51-8f60-5c97cd96c488@linaro.org>
Message-ID: <7a2d40456f37459e00e7d69bea27b342@linux.ibm.com>
X-Sender: dantan@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ga1WCOPW7N4YmqXcidWecd27drQPQ3Hj
X-Proofpoint-GUID: Ga1WCOPW7N4YmqXcidWecd27drQPQ3Hj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=dantan@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Yes, good point, Philippe!

I will send an update in a few days in case there are additional
changes to be made.

thank you,
---
dan tan
power simulation
phone:+1.7373.099.138
email:dantan@linux.ibm.com


On 2025-02-17 01:31, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 16/2/25 23:11, dan tan wrote:
>> Implement support for TPM via SPI interface. The SPI bus master
>> is provided by PowerNV SPI device which is an SSI peripheral.
>> It can uses the tpm_emulator driver backend with the external
>> swtpm.
>> 
>> Signed-off-by: dan tan <dantan@linux.ibm.com>
>> ---
>> 
>> v3:
>> - moved variable tis_addr from TPMStateSPI struct to local
>> - added the VM suspend/resume support:
>>    - added vmstate_tpm_tis_spi declaration
>>    - added tpm_tis_spi_pre_save() function
>> - fixed trace formatting string
>> 
>> v4:
>> - git commit amend only
>> 
>> v5:
>> - removed DEFINE_PROP_UINT32("irq", TPMStateSPI, tpm_state.irq_num, 0)
>>    from tpm_tis_spi_properties
>> - In tpm.rst document, under section 'The QEMU TPM emulator device',
>>    moved the 'PowerNV machine' section to immeidately below 'pSeriese
>>    machine'.
>> 
>> v6:
>> - amend commit description
>> - amend hw/tpm/tpm_tis_spi.c prolog to reflect the generic nature
>>    of the implementation
>> - remove irrelevant define of IBM_PONQ
>> - correct the function names to comply with the convention of
>>    beginning with tpm_tis_spi_xxxx()
>> 
>> v7:
>> - Reduce SPI wait states to improve performace.
>>    Although the real SPI buses have four wait states to accomodate
>>    the timing of various slave devices, there is no need to emulate
>>    that for this behavior model.
>> 
>> v8:
>> - re-package the email to comply with the convention.
>> 
>> v9:
>> - conform with the latest device property definition after rebase
>> 
>> ---
>>   docs/specs/tpm.rst   |  15 ++
>>   include/system/tpm.h |   3 +
>>   hw/tpm/tpm_tis_spi.c | 358 
>> +++++++++++++++++++++++++++++++++++++++++++
>>   hw/tpm/Kconfig       |   6 +
>>   hw/tpm/meson.build   |   1 +
>>   hw/tpm/trace-events  |   7 +
>>   6 files changed, 390 insertions(+)
>>   create mode 100644 hw/tpm/tpm_tis_spi.c
> 
> 
>> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
>> index a46663288c..5951c225cc 100644
>> --- a/hw/tpm/Kconfig
>> +++ b/hw/tpm/Kconfig
>> @@ -5,6 +5,12 @@ config TPM_TIS_I2C
>>       select I2C
>>       select TPM_TIS
>>   +config TPM_TIS_SPI
>> +    bool
>> +    depends on TPM
>> +    select TPM_BACKEND
>> +    select TPM_TIS
> 
>        depends on SSI?
> 
>>   config TPM_TIS_ISA
>>       bool
>>       depends on TPM && ISA_BUS

