Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67BBCDB470
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbfbb-0002PI-M1; Mon, 22 Jun 2026 10:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wbfbR-0002MW-CR; Mon, 22 Jun 2026 10:26:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wbfbC-0007V4-8d; Mon, 22 Jun 2026 10:26:09 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MDIJ4O2921878; Mon, 22 Jun 2026 14:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=t9QG54R598kRwsuFIhk79tzIxihZgphNGgNvgoq9sjk=; b=XxweMTq4tyPB
 woCuESR/Mt6WEFZ4K0g9HcUX/N8Va6iwzvTFRHEqdtyTYuaf7x4LYo3oP4DUqJaE
 MTQGdthYNqNOuMuoS+pb3Hj30eQTE0VnBx/LkoV1FGj9za3UFp7m1YEl7thBGxQX
 JWkcq9vqRZDCedPYh+pxXDApMWFtcFxPhrYOw1lyFSPXRqRETpg9tHhKoTwNSfPE
 x/aD+1psTWk89W9REB01InPtZU/cfp6PNZszi1oVACv292g2Z/D7Bwf1o4ui4C2t
 ODPi4mJQqlG31nBwernWPTJdqOM+bPMN972lhwYZAhswqDyl9tJPsXBt07GoIEn2
 yB/rYC39zw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk49p11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 14:25:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MEKAlZ025935;
 Mon, 22 Jun 2026 14:25:58 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyea4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 14:25:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65MEPu2127853458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2026 14:25:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A14CF5805A;
 Mon, 22 Jun 2026 14:25:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FB2A58056;
 Mon, 22 Jun 2026 14:25:56 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jun 2026 14:25:55 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 22 Jun 2026 16:25:55 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 08/17] target/s390x: Support AES XTS for cpacf km
 instruction
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <f3d24c22-ae20-4f06-9c08-4fb7063d2c23@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-9-freude@linux.ibm.com>
 <f3d24c22-ae20-4f06-9c08-4fb7063d2c23@linux.ibm.com>
Message-ID: <1cf4fde3189c6ebe7f805a70a82fc8c3@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0MiBTYWx0ZWRfX6VstDe9CPF1B
 Lcd/XL6FZNG1V66Dq118f4foFB6Ppt5r9LsfCJtQM/25IKk/Xqe64J3w2T7AI+uhJQppUbsUlxm
 SxVdsxN/anb9vrhja55+nIQOmMhrKHA=
X-Proofpoint-ORIG-GUID: Ntx2PcgkFQ7RG5LAfdPwUv5oM5ea3z61
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3945f7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=p4tzmAMT5gm4kcY_ohcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0MiBTYWx0ZWRfX0QjGfSByIJ5k
 WAcBWWC0QtrhvkzcznjPaNeJQz1VIYjwonhYAVEppVC5EQG36n5dcZB0Ad/2+l/yrUIhJ6wwmy8
 VZUKoCwKFdiBeqS1DKyx4AtWwWSQe0XNM3hHM+1W41g9PrY4uRdNK3aXDcXJYFGRFw5y/eCDd3p
 zjEQSGdKQVnklQDJzfDBHGfu1+bZBDpK8UKCvrej5peyDyFU4NWiF91+UcJ9GNU8xm7V2t5JeYd
 3lLCcBS5/sFaJ1zNbX5YUktICAKx0HH390s/OHuogBh3TN/Iclkd1aD72a0LCZZB1n0gH0Nem05
 XhhyefXajjq13TZxjXkEmMhBMNsSTDaSgdkf0mklko5vaCrq22mNvIPhPSTI88Ec1HW0kuQ3k8v
 2WOUzgbvzAy26KUA5EAdz9+AUjeZn7qAM3dKyLCMcRcJmHb5PHvT4nzKzDoxl1l9aCnBCCYkGFS
 F68ayeR+KZOIBkKu4sQ==
X-Proofpoint-GUID: Ntx2PcgkFQ7RG5LAfdPwUv5oM5ea3z61
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220142
Received-SPF: pass client-ip=148.163.156.1; envelope-from=freude@linux.ibm.com;
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
Reply-To: freude@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-06-18 07:45, Finn Callies wrote:
> On 17.06.26 11:48, Harald Freudenberger wrote:
>> Support the subfunctions XTS-AES-128 and XTS-AES-256
>> for the cpacf km instruction.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>> ---
>>   target/s390x/gen-features.c      |   2 +
>>   target/s390x/tcg/cpacf.h         |   4 ++
>>   target/s390x/tcg/cpacf_aes.c     | 107 
>> +++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c |   6 ++
>>   4 files changed, 119 insertions(+)
> 
> [ snip ]
> 
>> +
>> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
>> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) 
>> {
> 
> I guess this has the same "feature" as the real xts where the pcc part
> is not included if not explicitly done beforehand by the user right?
> But since CPACF does it that way I guess you can't do it the "correct"
> way. Instead of XTS + PCC you could implement Full XTS... just
> something to think about.
> 
>> +        /* fetch one AES block into buf1  */
>> +        aes_read_block(env, mmu_idx, *src_ptr_reg + done, buf1, ra);
>> +        /* buf1 xor tweak => buf2 */
> 
> [ snip ]

Well Finn, it is a CPACF emulation - not an emulation about what CPACF
should return if it would have been designed the right way :-)

