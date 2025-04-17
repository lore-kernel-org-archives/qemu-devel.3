Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC28DC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 19:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5VMY-0005n5-Ou; Thu, 17 Apr 2025 15:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1u5VMV-0005mJ-GE; Thu, 17 Apr 2025 15:57:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1u5VMT-00031q-Et; Thu, 17 Apr 2025 15:57:27 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HA4Fwo003094;
 Thu, 17 Apr 2025 19:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=X/GenB
 XaQaTTKnXuLcEi3xlPy6OPsvadj8VvgPfHqas=; b=idoenoP668nDZuPMQxVhhE
 rMBNMfU3JIjjadoDygC6jsWAkW3n/T2AQBLgUURpTyTbNbam/ilBFKgshAhV9coS
 NmhNHyUXWBF/ez/OFVQtX7pHU9oejv2hoGJykqf2DZpMM9J0b8S8/qUyHJLXvwrS
 oedokOwlvhIxNoUFV/WajOMfjGzuPrSEKzfLTC3C3LyjxPREooGWkUpykWZco37Y
 dJ2qrqb8PA4W2t074TvzR78xcJ4gtTP3WViybBCSIs1PtmH11c0k3PrWhFORFVlq
 tQG9EJY/Y5Iq6OhU4ZKT/Zx4J+d0wlca40J/rze5acJVJ6coqa4lyh/TJKCgLbzg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462yjjave0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 19:57:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HI7uX9017183;
 Thu, 17 Apr 2025 19:57:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040m79c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 19:57:20 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53HJvIYS20775490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 19:57:18 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C547558056;
 Thu, 17 Apr 2025 19:57:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F53F5803F;
 Thu, 17 Apr 2025 19:57:18 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 17 Apr 2025 19:57:18 +0000 (GMT)
Message-ID: <323c18f2-208f-4818-a95f-ac6ae068ea88@linux.ibm.com>
Date: Thu, 17 Apr 2025 15:57:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/24] s390x/diag: Implement DIAG 320 subcode 1
To: Thomas Huth <thuth@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com
Cc: jjherne@linux.ibm.com, jrossi@linux.ibm.com, fiuczy@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-7-zycai@linux.ibm.com>
 <bddc01e1-056a-454a-b1f1-165d1604deef@redhat.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <bddc01e1-056a-454a-b1f1-165d1604deef@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CMTq7e7RLUFS_Vtb4QQ7g0lUuYKhrJRY
X-Authority-Analysis: v=2.4 cv=MsNS63ae c=1 sm=1 tr=0 ts=68015d21 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=aq3tatrJt277NIGcrMUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CMTq7e7RLUFS_Vtb4QQ7g0lUuYKhrJRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504170143
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/11/25 9:57 AM, Thomas Huth wrote:
> On 08/04/2025 17.55, Zhuoying Cai wrote:
>> DIAG 320 subcode 1 provides information needed to determine
>> the amount of storage to store one or more certificates.
>>
>> The subcode value is denoted by setting the left-most bit
>> of an 8-byte field.
>>
>> The verification-certificate-storage-size block (VCSSB) contains
>> the output data when the operation completes successfully.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   include/hw/s390x/ipl/diag320.h | 25 ++++++++++++++++++++++
>>   target/s390x/diag.c            | 39 +++++++++++++++++++++++++++++++++-
>>   2 files changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
>> index d6f70c65df..ded336df25 100644
>> --- a/include/hw/s390x/ipl/diag320.h
>> +++ b/include/hw/s390x/ipl/diag320.h
>> @@ -13,7 +13,32 @@
>>   #define S390X_DIAG320_H
>>   
>>   #define DIAG_320_SUBC_QUERY_ISM     0
>> +#define DIAG_320_SUBC_QUERY_VCSI    1
>>   
>>   #define DIAG_320_RC_OK              0x0001
>> +#define DIAG_320_RC_NOMEM           0x0202
>> +
>> +#define VCSSB_MAX_LEN   128
>> +#define VCE_HEADER_LEN  128
>> +#define VCB_HEADER_LEN  64
>> +
>> +#define DIAG_320_ISM_QUERY_VCSI     0x4000000000000000
>> +
>> +struct VerificationCertificateStorageSizeBlock {
>> +    uint32_t length;
>> +    uint8_t reserved0[3];
>> +    uint8_t version;
>> +    uint32_t reserved1[6];
>> +    uint16_t totalvc;
>> +    uint16_t maxvc;
>> +    uint32_t reserved3[7];
>> +    uint32_t maxvcelen;
>> +    uint32_t reserved4[3];
>> +    uint32_t largestvcblen;
>> +    uint32_t totalvcblen;
>> +    uint32_t reserved5[10];
>> +} QEMU_PACKED;
>> +typedef struct VerificationCertificateStorageSizeBlock \
>> +VerificationCertificateStorageSizeBlock;
> 
> That's quite a long name, maybe shorten to VerificationCertStorageBlock or 
> something similar?
> 

I think it would benefit many of the data structures using the
"VerificationCertificate" prefix to be short-handed to "VC".

[...]

-- 
Regards,
  Collin

