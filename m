Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F43C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfesy-0000An-Lo; Fri, 03 Jul 2026 10:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfesw-0000AZ-WD; Fri, 03 Jul 2026 10:28:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfesv-0007LA-G8; Fri, 03 Jul 2026 10:28:54 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636Je4h1816007; Fri, 3 Jul 2026 14:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CeNwTA
 hRLc9CI2NvhSuFt4T3+1RDRsHH5RHiFGBEoLQ=; b=cwRRgOANRr8yYRra2yv7Kb
 eNASxn42mWyN1xCYxlo6/6VfUcdw5RuCwqzoSE2s6/jrFh8CMGJVeOouKlFZHFx3
 /F46otsrnXA85cm0shjpNj2eh05Uqk+dato6mpVadDViPxwYo/AC0E8qF9/C4EHV
 Za9Ftp+PaPNomkXyxm7B04k3yPFoxVcS6GHcftxDRWC8UrdBXYXWcvBXROTiMR5m
 HmymxNc6OpLjeUOsxh3/jOym1NB8X5pVhLSM61BWVzWB9bbuSRb4pJj0WzPVbmG2
 wnJfV9f0yUJqKtyzvY7wUFKtnyuaIvU2wrxh3WVRECUPnjSe6JCImNdfhIbCDROQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rff4ef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 14:28:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663EJYDU011128;
 Fri, 3 Jul 2026 14:28:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7whbck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 14:28:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663ESluC21627624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 14:28:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B787A58053;
 Fri,  3 Jul 2026 14:28:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 835A558043;
 Fri,  3 Jul 2026 14:28:44 +0000 (GMT)
Received: from [9.61.75.28] (unknown [9.61.75.28])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 14:28:44 +0000 (GMT)
Message-ID: <1235ff64-6b14-4d68-92e2-cf166fb5a883@linux.ibm.com>
Date: Fri, 3 Jul 2026 10:28:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 21/33] pc-bios/s390-ccw: Rework zipl_load_segment
 function
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, pierrick.bouvier@oss.qualcomm.com,
 jdaley@linux.ibm.com
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
 <20260703022933.1805010-22-zycai@linux.ibm.com>
 <a381b13b-1e80-40a5-a5b0-a30831dd045b@oss.qualcomm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <a381b13b-1e80-40a5-a5b0-a30831dd045b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a47c721 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=46WKqapYcF6banA1GeQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XaAy3bCnZE9XprJxuF3ZTi7X768gk23o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE0MSBTYWx0ZWRfX+6CA62WLJJpu
 O1ldPozMCfoeJEY65OASG7BjfSHdMZxoFDkg6UrBl4iFZyIdMkx0DcsKScw85vpAmIOg/MFtHNR
 Q6Oo15BqeCKJI5TPU3zcrQOxSbwupP2XrasSdUk2p3QVq6kb0qcV0fmIB3cyo0wW2UL+a5DtCIn
 TIJ4cnLJkJ/OOdxql7gcU1lLT1tey7nVxXTaamLZqU3nSZT+VifxRryWabNz5x3Iorlmw/Fs020
 msc0lWsNcjfefBFvqCufwxxLRxb0ZrBPOFwm/skn6LbAUljwL8HNNeXXCIuOSBFujcgGARRaTtl
 tIdo8TJW5e3tHUa2ia3ryYI+OJWRcgHWBQSopDb8NOv4o/4SR1XHtsoYIJU2OmYMKz0L5pRJ4QE
 Y0Ss+iWaRxs5NsGaSfcfCFE27PzKWQG0ghwA9NExN1Xr4u5c1VskPQbgWNNtwIdnyyG7kVSyZCf
 /gFelvvCDb6qB/cURTQ==
X-Proofpoint-GUID: XaAy3bCnZE9XprJxuF3ZTi7X768gk23o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE0MSBTYWx0ZWRfX4uMFnaR99QSC
 YTtzE8qzxRjbDddHMyIzBUn+5CPl5bKw/KYydwEyXVtb1pIKUwjWonRX39Ku/7zO8GjxtStD7qL
 DyAP0HIkHVPDerUNrM/B1QlPKmn7duA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030141
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/2/26 10:38 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 3/7/26 04:29, Zhuoying Cai wrote:
>> Change zipl_load_segment() to accept explicit blockno and address
>> parameters instead of ComponentEntry pointer and return segment length.
>>
>> Modify this function to allow the caller to specify a memory address
>> where segment data should be loaded into.
>>
>> seg_len variable is necessary to store the calculated segment length and
>> is used during signature verification. Return the length on success, or
>> a negative return code on failure.
>>
>> Remove static qualifier and add function declaration to bootmap.h to
>> make it accessible to other modules.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Collin Walling <walling@linux.ibm.com>
>> Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/bootmap.c | 18 ++++++++++--------
>>   pc-bios/s390-ccw/bootmap.h |  2 ++
>>   2 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index b9ba004cfc..b19981feb1 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -613,19 +613,19 @@ static int ipl_eckd(void)
>>    * IPL a SCSI disk
>>    */
>>   
>> -static int zipl_load_segment(ComponentEntry *entry)
>> +/*
>> + * Returns: length of the segment on success,
>> + *          negative value on error.
>> + */
>> +int zipl_load_segment(block_number_t blockno, uint64_t address)
>>   {
> 
> 
>> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
>> index 95943441d3..8d61ac383c 100644
>> --- a/pc-bios/s390-ccw/bootmap.h
>> +++ b/pc-bios/s390-ccw/bootmap.h
>> @@ -113,6 +113,8 @@ typedef struct ScsiMbr {
>>       ScsiBlockPtr pt;   /* block pointer to program table */
>>   } __attribute__ ((packed)) ScsiMbr;
>>   
> 
> Isn't it better to document the declaration rather than the
> definition?
> 

Thanks for the review! I can move the documentation to the declaration.

>> +int zipl_load_segment(block_number_t blockno, uint64_t address);
>> +
>>   #define ZIPL_MAGIC              "zIPL"
>>   #define ZIPL_MAGIC_EBCDIC       "\xa9\xc9\xd7\xd3"
>>   #define IPL1_MAGIC "\xc9\xd7\xd3\xf1" /* == "IPL1" in EBCDIC */
> 


