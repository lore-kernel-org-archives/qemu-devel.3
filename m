Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182D2C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 13:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5PhH-00051H-Kk; Thu, 17 Apr 2025 09:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1u5Pgj-0004xf-SA; Thu, 17 Apr 2025 09:53:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1u5Pgi-0005rI-0e; Thu, 17 Apr 2025 09:53:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H9eJGE017979;
 Thu, 17 Apr 2025 13:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+sbMMS
 2xOkkgRzw2UKaUSDOLAsw1BUAyCom4ATkQxtc=; b=b0E4225UVw71vsi7aDr6T4
 ut0EZMKDpMCjk/DESKDZ8HrqpC5KlDo1a92S7gLuPogs7LZC98Lo8xrAoRlGId90
 xdNAJoiJS1bmRlodrcaUVCbyWspIuEf+h1VCOHU4Zz2fC34ri3q84SxXOTc6j4Ov
 Y1OlD64vvfY8mdMPx+ZeMV/pqy2WMcKD/20CegkjUEnl9gPx17zL9kCH04g6T7lx
 iyn2MvoHtG5Ne1FiPaw8CxOUtZ0Q8DjPPX4MpMjnfd71nsOEiO3KShPhOAfoWAS2
 P7XIKqmHfEg0yr2gUJ5TZdpr+yG0DKZ7h6olFHc6SMAVz9R7j1JlxHwoiT8JjS8A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mhu3y5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 13:53:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBcuYX010392;
 Thu, 17 Apr 2025 13:53:50 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qkdp4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 13:53:50 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53HDrn7Z20906650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 13:53:49 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20F1E58053;
 Thu, 17 Apr 2025 13:53:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF6A858043;
 Thu, 17 Apr 2025 13:53:47 +0000 (GMT)
Received: from [9.61.172.222] (unknown [9.61.172.222])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 17 Apr 2025 13:53:47 +0000 (GMT)
Message-ID: <2c954bc6-4574-42dd-ab46-08188291d48f@linux.ibm.com>
Date: Thu, 17 Apr 2025 09:53:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 24/24] hw/s390x/ipl: Handle secure boot without
 specifying a boot device
To: Collin Walling <walling@linux.ibm.com>, Zhuoying Cai
 <zycai@linux.ibm.com>, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com
Cc: jjherne@linux.ibm.com, fiuczy@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-25-zycai@linux.ibm.com>
 <93f3cb7f-9dda-4ff4-b3e9-81a6c870d115@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <93f3cb7f-9dda-4ff4-b3e9-81a6c870d115@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Hvd2G1TS c=1 sm=1 tr=0 ts=680107ef cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=fosz5jRaRB39iTwj5awA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fcWUs5Aak2hVoJMJcojAanuvDY0Tcrlh
X-Proofpoint-GUID: fcWUs5Aak2hVoJMJcojAanuvDY0Tcrlh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170101
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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



On 4/16/25 6:11 PM, Collin Walling wrote:
> On 4/8/25 11:55 AM, Zhuoying Cai wrote:
>> If secure boot in audit mode or True Secure IPL mode is enabled without
>> specifying a boot device, the boot process will terminate with an error.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   hw/s390x/ipl.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 60bafcbd2e..0510f16a7d 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -767,6 +767,16 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>>           s390_ipl_create_cert_store(&ipl->cert_store);
>>           if (!ipl->iplb_valid) {
>>               ipl->iplb_valid = s390_init_all_iplbs(ipl);
>> +
>> +            /*
>> +             * Secure IPL without specifying a boot device.
>> +             * IPLB is not generated if no boot device is defined.
>> +             */
>> +            if ((s390_has_certificate() || s390_secure_boot_enabled()) &&
>> +                !ipl->iplb_valid) {
>> +                error_report("No boot devicie defined for Secure IPL");
>> +                exit(1);
>> +            }
> I'm confused why this check is needed.  If there is no valid iplb, won't
> boot just fail outright anyway?
No.  If there is no IPLB (e.g. no device has been assigned a boot 
index), we have a rudimentary probing routine that will examine if a 
device is potentially bootable, and, if so, try to boot from it.
This check is basically stating that boot device probing is not 
supported when using secure IPL, so at least one device must be defined 
with a boot index.

>
>>           } else {
>>               ipl->qipl.chain_len = 0;
>>           }
>


