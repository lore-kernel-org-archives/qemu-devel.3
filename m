Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C767FE8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIDj-0000fI-J3; Tue, 03 Feb 2026 10:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vnIDc-0000Vo-Lz; Tue, 03 Feb 2026 10:21:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vnIDa-0000Hm-C7; Tue, 03 Feb 2026 10:21:31 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6137xW5h005339;
 Tue, 3 Feb 2026 15:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uBs1bp
 ZC5DNa87wY74RKTIxAJoNza/+9iiL9xfQjRp8=; b=lOrxgDSiB1hABzZP0kE+59
 Py4dvar4yWwrT9r+58OSUGU6oUl96eAnX9vYpNWuZP1l8bV1yOPyBM9oEmqn1h6f
 lqF3uwfO9Pnmq+PvFJZRPxoDohvsVjGwrAIKSFHcQfCIfiYMT/PyMysZL3nxb3sq
 wnpEtidxlphefK0XiYf++rAv2BqnE1DzPnRHDYpeKF4SgeaXY5G5447FMiYh/840
 N5YxjEnR0sMpOWFzhhzW0Jzwec0Ej5322Znf5vrKAfuafEgHtxjgFGNkC1au3aTT
 JHNAFZh1NuhT1vylxAyfA7+OQAbeMpRj8CFaNOuuiOGBNSSktMPJuGFjEfI2d51Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986e1au-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 15:21:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 613FLNXH027789;
 Tue, 3 Feb 2026 15:21:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986e1ak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 15:21:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 613BL7KL004422;
 Tue, 3 Feb 2026 15:21:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1wjjsj8u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 15:21:22 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 613FLMJe6882056
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Feb 2026 15:21:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47B4B5805C;
 Tue,  3 Feb 2026 15:21:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D7EC5805E;
 Tue,  3 Feb 2026 15:21:21 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Feb 2026 15:21:21 +0000 (GMT)
Message-ID: <26b39a30-8ef0-4f68-af65-58a6718226a6@linux.ibm.com>
Date: Tue, 3 Feb 2026 10:21:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4 qemu] Exclude TPM ioctls definitions for the
 GNU/Hurd
To: Paolo Bonzini <pbonzini@redhat.com>, Damien Zammit <damien@zamaudio.com>, 
 bug-hurd@gnu.org
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 peter.maydell@linaro.org, kwolf@redhat.com, berrange@redhat.com,
 eblake@redhat.com, bugaevc@gmail.com
References: <20260130031954.1661880-1-damien@zamaudio.com>
 <20260130031954.1661880-4-damien@zamaudio.com>
 <ac182e8e-cd4f-467b-b6a8-31f03b70b3b9@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <ac182e8e-cd4f-467b-b6a8-31f03b70b3b9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDExNSBTYWx0ZWRfXzu/uo1puBFqA
 nGje+8lHBynemZp6ZUqqzVqrE1zD9qbx7J2kWGuFV2S5vAiaoNH6oWD3pVRf8kTeOgBL7RWaexa
 /8e4uEpxHJ3kxNhC0FRiQEPz0VmxXyc45YEd3CMQgknTbQed18s/OCmUFtiYMEutghuQhR14AEL
 RSrovL4HOduo6Yd56ebg6q3ONyAyj7ekmAlkILSL1dFeUvf4l74tEbedxKLYv97mPWhAWR58xPb
 brRTi7VRNckNpyowd0BwPhQs4Vr4R9Ovj211+opbDQStoWbDpCgvtDYbJFPD8KVJv9D8getoOO4
 n6F8WjPg0ADh8/ypiqftJ0Mbz3cIZZMbnzOVVr83Ce/Ik/kEg3Xu2BP97j1kwfdy/l5QrfMEy/r
 aJblAE6VIiIq3cT3GgIXCfXgQQFWTViItHh9L4ZSJiWa6bCJkJuqbw0UVV1GS8N15JqrM3JCzs9
 OK7Kijw71jUaTepJKhw==
X-Proofpoint-GUID: aR0UZa91qQLQbJ59xCBqyVHGkjw-iO6m
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=69821274 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=oPMGwu8xAAAA:20 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=_KKo3MieFKyQ8d2-XqgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: 8M6zu97pdPmnNjci-ZzUZFBzGNk4zmn2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602030115
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 1/30/26 3:27 AM, Paolo Bonzini wrote:
> On 1/30/26 04:20, Damien Zammit wrote:
>> From: Manolo de Medici <manolodemedici@gmail.com>
>>
>> The Hurd currently doesn't have any TPM driver, compilation fails
>> for missing symbols unless these are left undefined.
> 
> This is due to the missing _IO* symbols, not the TPM driver.
> 
> Fortunately, these are unused and the whole enum can be removed.  Please 
> check if it's also possible to remove
> 
> #ifndef _WIN32
> #include <sys/uio.h>
> #include <sys/ioctl.h>
> #endif
> 
> #ifdef HAVE_SYS_IOCCOM_H
> #include <sys/ioccom.h>
> #endif

So this file comes originally from swtpm here: 
https://github.com/stefanberger/swtpm/blob/master/include/swtpm/tpm_ioctl.h

To keep them in sync as much as possible -- would this here work?

#ifndef _WIN32
#include <sys/uio.h>
#include <sys/ioctl.h>
#endif

#ifdef HAVE_SYS_IOCCOM_H
#include <sys/ioccom.h>
#endif

#ifdef __gnu_hurd__
#include <mach/x86_64/ioccom.h>
#endif

and then keep this as-is?

#if !defined(_WIN32)
enum {
     PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
     PTM_INIT               = _IOWR('P', 1, ptm_init),
     PTM_SHUTDOWN           = _IOR('P', 2, ptm_res),



> 
> at the top of the file.
> 
> Paolo
> 
>> Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   backends/tpm/tpm_ioctl.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
>> index ee2dd15d35..e466311455 100644
>> --- a/backends/tpm/tpm_ioctl.h
>> +++ b/backends/tpm/tpm_ioctl.h
>> @@ -285,7 +285,7 @@ typedef struct ptm_lockstorage ptm_lockstorage;
>>   #define PTM_CAP_SEND_COMMAND_HEADER (1 << 15)
>>   #define PTM_CAP_LOCK_STORAGE       (1 << 16)
>> -#ifndef _WIN32
>> +#if !defined(_WIN32) && !defined(__GNU__)
>>   enum {
>>       PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
>>       PTM_INIT               = _IOWR('P', 1, ptm_init),
> 
> 


