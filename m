Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A609CD2A536
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 17:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t17Ot-0002GH-9j; Wed, 16 Oct 2024 13:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t17Or-0002G8-MY
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 13:01:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t17On-0002lu-LD
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 13:01:29 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGskAx015412
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 17:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GzcGgE
 eWPvsufjSRiTrwSsFnbW81alfZwC8pOVz+Hy0=; b=FFWji+K1pbfjkotqmPAerN
 5HE3OxK0muKUPmOW5ASm53nqmkQxXdxVZaGNxYoCwiWjuors7DMoHXGJKoGdmEF3
 I3scBpDesaLOfYkzdZI5/+VR5PAZhD96NgCPRF7JIK3s2NkUAmvHODt00ZeHd4s/
 U8nrdeCU+UwLMNEnGNwrRuPd9FDKXAYxEU8uxrCEdqtT3H1ccgsIHYYE5KxY4dZh
 goIO3XcmHCOOwbrYbe9DJMmJPPaP5jsCmfkEXKyEBjOdPde1rCxPownHW0yOP0Y9
 GE8lckOgwUt0dHlRseyZQdP0yzQpHEt5xbpnZ4/SeTfGxLVR6YQTbxxIEySteCrw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ahe100u7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 17:01:17 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GH1HFT028398
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 17:01:17 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ahe100u4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 17:01:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GF1qTK005930;
 Wed, 16 Oct 2024 17:01:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428651262g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 17:01:16 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49GH1GsH48234914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Oct 2024 17:01:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C6435805A;
 Wed, 16 Oct 2024 17:01:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07A9958056;
 Wed, 16 Oct 2024 17:01:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Oct 2024 17:01:15 +0000 (GMT)
Message-ID: <5558e41c-5d22-481e-9bc7-b46cd65e5d34@linux.ibm.com>
Date: Wed, 16 Oct 2024 13:01:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] tpm: Use new ptm_cap_n structure for
 PTM_GET_CAPABILITY
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com
References: <20241016145708.1166471-1-stefanb@linux.ibm.com>
 <20241016145708.1166471-2-stefanb@linux.ibm.com>
 <Zw_VpwVc_qSpJS6y@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <Zw_VpwVc_qSpJS6y@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tTKQg1pnYTSmOrUS3HtkaRG4Bf4gtn1L
X-Proofpoint-ORIG-GUID: 4-Y-w8qdd--I8gsTxhxdBus2JTKRFe6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410160108
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/16/24 11:03 AM, Daniel P. Berrangé wrote:
> On Wed, Oct 16, 2024 at 10:57:07AM -0400, Stefan Berger wrote:
>> Use the new ptm_cap_n structure for getting the PTM_GET_CAPABILITY response
>> from swtpm. Previously only 17 bits could possibly have been set in ptm_cap
>> (=uint64_t) in big endian order and those bits are now found in the 2nd
>> 32bit word in the response in the caps field.
>>
>> This data structure makes it now clear that the 1st 32bit word carries the
>> tpm_result like all the other response structures of all other commands
>> do.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   backends/tpm/tpm_emulator.c | 14 ++++++++------
>>   backends/tpm/tpm_ioctl.h    | 13 ++++++++++++-
>>   backends/tpm/trace-events   |  2 +-
>>   3 files changed, 21 insertions(+), 8 deletions(-)
>>
> 
>> diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
>> index 1933ab6855..ee2dd15d35 100644
>> --- a/backends/tpm/tpm_ioctl.h
>> +++ b/backends/tpm/tpm_ioctl.h
>> @@ -29,6 +29,16 @@
>>   
>>   typedef uint32_t ptm_res;
>>   
>> +/* PTM_GET_CAPABILITY: Get supported capabilities (ioctl's) */
>> +struct ptm_cap_n {
>> +    union {
>> +        struct {
>> +            ptm_res tpm_result; /* will always be TPM_SUCCESS (0) */
>> +            uint32_t caps;
>> +        } resp; /* response */
>> +    } u;
>> +};
> 
> The union here is pointless surely, since it only has one entry and
> the following patch doesn't add a 2nd either ?

I did this because all commands have a union.
> 
> 
> With regards,
> Daniel

