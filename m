Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38711C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 10:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpQ4T-0007Xv-06; Wed, 27 Mar 2024 05:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1rpQ4Q-0007XB-9Q; Wed, 27 Mar 2024 05:59:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1rpQ4N-0000MC-UZ; Wed, 27 Mar 2024 05:59:46 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42R9wG1D011318; Wed, 27 Mar 2024 09:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jvubQiXmeYKchE0Kuuc7ZbzpHYAVCfELKU0XblzVAmc=;
 b=Q7czaGyHxyrx5jbMWniaG2FqSsAQ5HHDX2dE7xK3cIenlI2a6/AmECYDr3sZYQO61Vag
 edaiyG0Wact/1/iBniz0VKdM/JXE1fN3fxZPFpHZZOg5znbcHmW80QgphAiDVaHBnEM8
 Cs3nUs3v6hYIv4UGJ/9k0UC/LKfylETE65IxdkwEFLlKfAGcMVUoDI961MCviUrzZlp4
 cJBoWCHVN8lmF1VMeHlBohlI/vMgvPI7yiqeEL8urTiizzKC52MuWqC+xx5XKtJkSBwY
 hkn1/Q2MxajIsyuDOswpZZnYKIjIH5gOO7IXHea+WnVcHMcvu+H7QFOGBZ7rhPR5oq7e +w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x4h9br052-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 09:59:31 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42R9xU9k012744;
 Wed, 27 Mar 2024 09:59:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x4h9br04w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 09:59:30 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42R70CgQ012975; Wed, 27 Mar 2024 09:59:29 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x29t0p2e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 09:59:29 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42R9xQv059638134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2024 09:59:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EE8D5806B;
 Wed, 27 Mar 2024 09:59:24 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B36658065;
 Wed, 27 Mar 2024 09:59:20 +0000 (GMT)
Received: from [9.43.74.143] (unknown [9.43.74.143])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 27 Mar 2024 09:59:19 +0000 (GMT)
Message-ID: <4777474d-fc4b-4ef1-8847-b6568bec4937@linux.vnet.ibm.com>
Date: Wed, 27 Mar 2024 15:29:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] pnv/phb4: Mask off LSI Source-ID based on number of
 interrupts
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
References: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
 <20240321100422.5347-11-saif.abrar@linux.vnet.ibm.com>
 <26c7a63d-78fe-4378-b950-0673f0c96114@kaod.org>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <26c7a63d-78fe-4378-b950-0673f0c96114@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JK15QO-jmYTHBn7UUYAN0iJ2hBxx6xvp
X-Proofpoint-GUID: BQ4ajzeMjmdfIHbAbRmvrNFaUdau8fT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403270067
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hello Cedric,

>   }
>   +static void pnv_phb4_fund_A_reset(PnvPHB4 *phb)
>
> What is fund_A ?

I used 'fund_A' as an abbreviation to "Fundamental Register Set A".

Please let know if you suggest another abbreviation to name this method.


>> +{
>> +    phb->regs[PHB_LSI_SOURCE_ID >> 3] = PPC_BITMASK(4, 12);
>
> Is this mask the default value for HW ?
Yes, the spec defines the bits[04:12] of LSI Source ID having reset 
value: 0x1FF


Regards,

Saif


On 25-03-2024 07:04 pm, Cédric Le Goater wrote:
> On 3/21/24 11:04, Saif Abrar wrote:
>> Add a method to reset the value of LSI Source-ID.
>> Mask off LSI source-id based on number of interrupts in the big/small 
>> PHB.
>
> Looks ok.
>
>
>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>> ---
>>   hw/pci-host/pnv_phb4.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
>> index f48750ee54..8fbaf6512e 100644
>> --- a/hw/pci-host/pnv_phb4.c
>> +++ b/hw/pci-host/pnv_phb4.c
>> @@ -489,6 +489,7 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
>>         lsi_base = GETFIELD(PHB_LSI_SRC_ID, 
>> phb->regs[PHB_LSI_SOURCE_ID >> 3]);
>>       lsi_base <<= 3;
>> +    lsi_base &= (xsrc->nr_irqs - 1);
>>         /* TODO: handle reset values of PHB_LSI_SRC_ID */
>>       if (!lsi_base) {
>> @@ -1966,6 +1967,12 @@ static void pnv_phb4_ro_mask_init(PnvPHB4 *phb)
>>       /* TODO: Add more RO-masks as regs are implemented in the model */
>>   }
>>   +static void pnv_phb4_fund_A_reset(PnvPHB4 *phb)
>
> What is fund_A ?
>
>> +{
>> +    phb->regs[PHB_LSI_SOURCE_ID >> 3] = PPC_BITMASK(4, 12);
>
> Is this mask the default value for HW ?
>
>
> Thanks,
>
> C.
>
>
>> +    pnv_phb4_update_xsrc(phb);
>> +}
>> +
>>   static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
>>   {
>>       STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
>> @@ -2023,6 +2030,7 @@ static void pnv_phb4_reset(void *dev)
>>       pnv_phb4_cfg_core_reset(phb);
>>       pnv_phb4_pbl_core_reset(phb);
>>   +    pnv_phb4_fund_A_reset(phb);
>>       pnv_phb4_err_reg_reset(phb);
>>       pnv_phb4_pcie_stack_reg_reset(phb);
>>       pnv_phb4_regb_err_reg_reset(phb);
>> @@ -2102,8 +2110,6 @@ static void pnv_phb4_realize(DeviceState *dev, 
>> Error **errp)
>>           return;
>>       }
>>   -    pnv_phb4_update_xsrc(phb);
>> -
>>       phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, 
>> xsrc->nr_irqs);
>>         pnv_phb4_xscom_realize(phb);
>

