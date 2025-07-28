Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F189AC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 22:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugVup-0005Fx-IL; Mon, 28 Jul 2025 18:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1ugVuc-0005AF-6u; Mon, 28 Jul 2025 18:01:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1ugVua-0001fy-7w; Mon, 28 Jul 2025 18:01:37 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SHahMm028332;
 Mon, 28 Jul 2025 22:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nQBX+B
 oaNBdrCBIHGARUEsbM1wbYNTmxMlsG+93Dazg=; b=e/RR46LjgVgPytozf1H2LC
 ZTnWZMcYKOu0eoaL+Isj2oBT3gsFomGHf1Bps2i1Zbo9FWaZfEg5gfPf524A4qew
 eQO0MgaRD19wJwkxinONBNImdZTYU6tar0r6KBEuvWR9yo/fwPMFY9um9wYn2j3M
 uKXofg3uSiLfdfORRx4jzqdkt4Z2Dug1WIugiXyj5VKf/AJ+bEsbY6jqwD65A0ba
 3A6tALagMDMFOTCrhNg9sqbHFHweEyCgSr5PgPHTJ4SH0VqDI43fBbkzQlZfl0Xj
 GgG5h+PYNFMK+7Yn5QlRntrBNjxKuoO+KFaZjrwe9MjwPyiuW+/0gh5wsPY5eG4Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd5bdk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Jul 2025 22:01:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56SJdcom015929;
 Mon, 28 Jul 2025 22:01:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485aumfhp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Jul 2025 22:01:32 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56SM1US629688462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Jul 2025 22:01:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBFA35805A;
 Mon, 28 Jul 2025 22:01:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7961C58054;
 Mon, 28 Jul 2025 22:01:29 +0000 (GMT)
Received: from [9.61.72.118] (unknown [9.61.72.118])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 28 Jul 2025 22:01:29 +0000 (GMT)
Message-ID: <204b01fb-b456-4f54-8bd1-d048a9df8cef@linux.ibm.com>
Date: Mon, 28 Jul 2025 18:01:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/28] s390x/diag: Implement DIAG 320 subcode 1
To: Eric Farman <farman@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-8-zycai@linux.ibm.com>
 <58a1b29e31f13e0fa58d29f222a652b4ccba0f83.camel@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <58a1b29e31f13e0fa58d29f222a652b4ccba0f83.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE1OCBTYWx0ZWRfX4CGcHL5Rb8Lw
 J1eySWghX2in7ttK0gtaxq5gZQJ0dQmpoICwjJ/ph867h8v6BFameP4VIjjHco1wYHNpSCzaLvn
 NSTrJNjbWkzcVkII5wLAYoB8a1R9DKj+lQOTa68DK7IORc09Y4OrENCHkiPwDvtIM2dUf3v2LaT
 gmvVSqsrUk5JBlc1UqoAnqQGOcQ7jMtg8wU0qUpjDWsht5SPTsTCgf7hw5+PK5qbNBN8n5uunqI
 g8S528C6qtXrkoJSkDI93db6na/wL7QjZG+M9ED36fVIGNyMAU2ItUUhkeckOpTPWdl7n02bv1T
 HCoBlGj0aZdBEAQolpv5+I006KHWQ41YZ9s9WtpPnck55hGXTOyWqEcvoxTfXvkUp3aAoJaUKKZ
 GX5ttti6vzpyB50SfhMfByzmElS8EXEk/cavwSIPO45CPBfMyMUfiDiJeUF/BPkxm6ethXY0
X-Proofpoint-ORIG-GUID: 8-5vJ01g56viX3eEq1WvCwDfRh9fByab
X-Authority-Analysis: v=2.4 cv=B9q50PtM c=1 sm=1 tr=0 ts=6887f33c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=xn3pKtoKZQ7XhVX2-AUA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8-5vJ01g56viX3eEq1WvCwDfRh9fByab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_04,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=652
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280158
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 7/23/25 4:17 PM, Eric Farman wrote:
> On Fri, 2025-07-11 at 17:10 -0400, Zhuoying Cai wrote:

...

>> +        if (!diag_parm_addr_valid(addr, sizeof(VCStorageSizeBlock),
>> +                                  true)) {
>> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
>> +            return;
>> +        }
>> +
>> +        if (!qcs || !qcs->count) {
> 
> For my own curiosity, can qcs actually be NULL? Looks like s390_ipl_get_certificate_store() returns
> the address of the cert_store struct in the IPL device.
>

Thanks for pointing it out. qcs can't be NULL for the reason you
mentioned. I'll remove the check since it's unnecessary.

>> +            vcssb.length = cpu_to_be32(4);
>> +        } else {
>> +            vcssb.length = cpu_to_be32(VCSSB_MAX_LEN);
>> +            vcssb.version = 0;
>> +            vcssb.total_vc_ct = cpu_to_be16(qcs->count);
>> +            vcssb.max_vc_ct = cpu_to_be16(MAX_CERTIFICATES);
>> +            vcssb.max_vce_len = cpu_to_be32(VCE_HEADER_LEN + qcs->max_cert_size);
>> +            vcssb.max_single_vcb_len = cpu_to_be32(VCB_HEADER_LEN + VCE_HEADER_LEN +
>> +                                                   qcs->max_cert_size);
>> +            vcssb.total_vcb_len = cpu_to_be32(VCB_HEADER_LEN +
>> +                                              qcs->count * VCE_HEADER_LEN +
>> +                                              qcs->total_bytes);
>> +        }
>> +
>> +        if (s390_cpu_virt_mem_write(cpu, addr, r1, &vcssb, sizeof(VCStorageSizeBlock))) {
>> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +            return;
>> +        }
>>          rc = DIAG_320_RC_OK;
>>          break;
>>      default:


