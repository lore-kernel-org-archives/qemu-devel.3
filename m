Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09224CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 16:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpjQ-0000x0-Ci; Tue, 12 May 2026 12:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wMpjN-0000wN-3z; Tue, 12 May 2026 12:13:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wMpjI-0005FC-6P; Tue, 12 May 2026 12:13:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CBukXi2611849; Tue, 12 May 2026 16:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=R8FzmN
 f15DIdN47ecsg4oJyAKNfPe1Ts/4B20cSv23M=; b=kN/lWjhWGqgLBBpCUYKYjc
 fGyt8CPDMQDmc792ewG7zjinAQvu0JKWYGYlKsbYv+/mQlmlZSFwg7JFvRzwJ5UC
 BGizEaIMTuxMffBJAC22hKlHRn/uBmMw0o6d7NTtiJPB0jQgW6UNRF8FHimfUQWs
 pwfPEyPtGRl0YHAexog054f17Oxv/vMeBTvcTmLA93SzRyDTzTBDuHHV8x34RIL4
 qM2X+Ch6r5S2BPBU5NdfMgP6sIP2jaHzQOC+kwb8kMljbz5YkfOHepYJA/7nmVzs
 SwTJ1cT8mdxIR1Adt5MS5/UtY4UoeFFkxJ203QA0I74ik/6LFnQ9aJP1heRacaBA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nvduxhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 16:13:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CG9T7H022289;
 Tue, 12 May 2026 16:13:03 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgkug0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 16:13:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64CGD2Lx30606032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 16:13:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D14658059;
 Tue, 12 May 2026 16:13:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A85D5804B;
 Tue, 12 May 2026 16:13:01 +0000 (GMT)
Received: from [9.61.119.68] (unknown [9.61.119.68])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 12 May 2026 16:13:01 +0000 (GMT)
Message-ID: <1035a8d9-ce65-486d-845d-6a3b1d714ab0@linux.ibm.com>
Date: Tue, 12 May 2026 12:13:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] s390x: Introduce PCI SCSI IPLB and boot type
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, cohuck@redhat.com
Cc: jjherne@linux.ibm.com, mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260504221613.826825-1-jrossi@linux.ibm.com>
 <20260504221613.826825-5-jrossi@linux.ibm.com>
 <60502b8ce770a418bd8c66f3b236e15bcbda6892.camel@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <60502b8ce770a418bd8c66f3b236e15bcbda6892.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y/XIdBeN c=1 sm=1 tr=0 ts=6a035190 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=_zagPGYejBRFBEOedkEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LaqGXjCgrfBMuRJNdYhlbRjieM2XbyfB
X-Proofpoint-ORIG-GUID: LaqGXjCgrfBMuRJNdYhlbRjieM2XbyfB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2OCBTYWx0ZWRfX2b07XpwY6imt
 n/InpEboPJUHxG5aU9PzjZIELkklmtBYKNg+WKPynxpGznm5UwqtPI0Bt1ftzsTj0i/oHv9JzVW
 iUWTjkncccfSLJni2CeTYcTu0sVVlf2Lvp1WWJhKz5fRh4UAGO00ikDHT99umC58dEu73vI+wSu
 mteDLlliEg6gVQ85m5zj4BARDGM1zHsqcRp2Tk6qOFxXB81LmmFRmEP8xC0cmWbDrvhv0GXlkcG
 6O1T8ZFsrotoinoC7XCoDSWv8AieC3Ig9V0uOtQzbdgWj9K0XqfcgcRGBfXVyWIH7jfNPO9tHbl
 SkWmYl7gxaM2ynbbln0m9YD5d3F6xN1KooYbYNtQJMOBMa0JqJ2kWPcJSLLMN0crpoK6JPyISqD
 luyq2dQ8cAeUBh0oizycEmO6H485q5nQ6odkGrwhof+llaJJVmcd/lAuDSe+8ndDmWutps/oxf2
 qZfsvhldpvxq+NfTXVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120168
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/8/26 9:16 PM, Eric Farman wrote:
> On Mon, 2026-05-04 at 18:16 -0400, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Define a new IPLB format for SCSI PCI devices and add cases to handle it.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   include/hw/s390x/ipl/qipl.h    | 15 +++++++++++++++
>>   pc-bios/s390-ccw/main.c        | 11 ++++++++++-
>>   pc-bios/s390-ccw/virtio-pci.c  | 29 +++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/virtio-scsi.c | 14 +++++++++++++-
>>   pc-bios/s390-ccw/virtio.c      |  5 +++++
>>   5 files changed, 72 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
>> index 67db54c964..951c5e2d8e 100644
>> --- a/include/hw/s390x/ipl/qipl.h
>> +++ b/include/hw/s390x/ipl/qipl.h
>> @@ -25,6 +25,7 @@ enum S390IplType {
>>       S390_IPL_TYPE_CCW = 0x02,
>>       S390_IPL_TYPE_PCI = 0x04,
>>       S390_IPL_TYPE_PV = 0x05,
>> +    S390_IPL_TYPE_PCI_SCSI = 0xfe,
>>       S390_IPL_TYPE_CCW_SCSI = 0xff
>>   };
>>   typedef enum S390IplType S390IplType;
>> @@ -117,6 +118,19 @@ struct IplBlockPci {
>>   } QEMU_PACKED;
>>   typedef struct IplBlockPci IplBlockPci;
>>   
>> +struct IplBlockPciScsi {
>> +    uint32_t lun;
>> +    uint16_t target;
>> +    uint16_t channel;
>> +    uint8_t  reserved0[74];
>> +    uint8_t  opt;
>> +    uint8_t  reserved1[3];
>> +    uint32_t fid;
>> +    uint8_t  ssid;
>> +    uint16_t devno;
>> +} QEMU_PACKED;
>> +typedef struct IplBlockPciScsi IplBlockPciScsi;
> Now that I get to the point where I see why you renamed the ...QemuScsi struct in patch one, I'm
> struggling.
>
> This combines the PCI stuff in IplBlockPci, with the CCW (!) and SCSI stuff in IplBlockCcwScsi (nee
> IplBlockQemuScsi). Some of the stuff (ssid, devno) isn't needed for PCI, and I find myself wondering
> what the "right" struct should look like...
The ssid and devno should be removed from the PCI version, it was just an
oversight to leave them there.
> Can we add the PCI stuff to a (generalized) struct that's just "IplBlockScsi" and have fields that
> are specific to -ccw or -pci? That's basically what IplBlockPciScsi is, even though it's not used
> that way.
Yes, it is possible.  At first I did not think it was the proper 
approach, but
thinking about it again now I can see the benefit.  I will reconsider it.

> Or is it better that there's overlap between Ccw/CcwScsi (e.g., offsetof(Ccw.ssid) ==
> offsetof(CcwScsi.ssid)) and Pci/PciScsi? If the latter, there's quite a bit of difference in their
> layouts, e.g., the location of the opt and fid fields. That worries me...
You are correct that the offsets are wrong. At minimum I will fix the 
offsets to
match, otherwise I will rework it into a combined IPLB as described above.

Thanks for catching this error.

Regards,
Jared Rossi

