Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C5CCEFCE2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 17:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdAX2-0000g7-Qt; Tue, 06 Jan 2026 12:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vdAWs-0000dV-4V; Tue, 06 Jan 2026 12:07:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vdAWq-0006OU-Ju; Tue, 06 Jan 2026 12:07:33 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 606H3tIe027916;
 Tue, 6 Jan 2026 17:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pIGWQ0
 a2+gUbEr3hIvYR1y+KijxlvuphJiqy4IM3ADI=; b=qJBK+DSBYtJ8MMYKfDwzTF
 hHVZn8WTXh4mWP3FtWZzJKx+ghW0IatlRWoh3WmdRoTWLQZCgbm6O4XspeTfk5a4
 E6EmdGiIrlm+bTfh33NSxhyZPHQ7zcFGFvWbPSPqkewcQL6+Zsc+r9Y5x1UCKyOW
 sEvMU9Fbc6KEpjOQ71HFaYMIfA8oFZQ5LIeIM3T4mrISc/2E6pwAPvouaSxcVtNC
 ep+owHVu1a7wZ8TiDayb6yUF2guvhwxwtV80WcKN6TTTub2m+Qus/UG732VRIzLz
 uSdhRWo6Owx76NA8Oh3nQUTpK07eG2Bzt/86h2XHqDoWGxoiahETShDkpqGdEAJg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtm2vs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 17:07:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 606H31iL005186;
 Tue, 6 Jan 2026 17:07:27 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtm2vq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 17:07:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 606E5uSi019341;
 Tue, 6 Jan 2026 17:07:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg5149xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 17:07:26 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 606H7O5u6816662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jan 2026 17:07:24 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4470358067;
 Tue,  6 Jan 2026 17:07:24 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D282B58052;
 Tue,  6 Jan 2026 17:07:23 +0000 (GMT)
Received: from [9.61.242.111] (unknown [9.61.242.111])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jan 2026 17:07:23 +0000 (GMT)
Message-ID: <5e13f2c3-2075-4d31-bddc-06dcc31f6eae@linux.ibm.com>
Date: Tue, 6 Jan 2026 11:07:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ppc/pnv: Suppress some "pnv_chiptod unimplemented
 register" messages
To: milesg@linux.ibm.com, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 chalapathi.v@linux.ibm.com
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-2-calebs@linux.ibm.com>
 <1fa38659565cf4dc1dfe24cc365d685554faecf0.camel@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <1fa38659565cf4dc1dfe24cc365d685554faecf0.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695d414f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=geCvSiIGcsAKCeZvhHgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: m7qRa-fjXI7cDDa6hRZ8E3Ex2ow5_3Ig
X-Proofpoint-ORIG-GUID: 507j8m6H7tY2dpmla2ideDQZ8CA1aSkj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE0NiBTYWx0ZWRfXxu/ez7sL7s1O
 7Sh/sFikK6n8VfcIPQwL8NjiIPAzIdYa4Uhx4ud3riKjlaFVChMd80YB7v/tZmyUyvPUxRqKKNx
 2MAwq1wpDwljw8iPvibB++S+xZqyARmB0/Y5GuVgEeFK2WF468c2vWycrJMhtzg3fQITerva9Vw
 4IvgsWJVVaK5qm4rKF9+rB7zhOgOmw4MHw96FQ+2lf8Bi5yIVB5fXhdyj9f8PI9cXhHxybByEEK
 0N9wyCsRmsyP3/CAvO2sHLbfkfaOIfhqlM31r5AGH0VlF1Xlpe2NSGzKX1q2dEtMXDtMSfJSLjO
 bCnwL3F3Jxn+yA6LGaovNt8CF59f4IdyNxY57O79nI+aEojSLdRlfCQr8tIwlJmLj2x02e7DGm1
 fy78yvHqNmn26/CSAqRU+vkyzy+OUl+5VJCg34q3FouP+KfTVVYFj6BWNsaZPUrMxM44KgeNXOO
 YkQIFa1VekISsD5RjyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601060146
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 1/6/26 10:49 AM, Miles Glenn wrote:
> Hi Caleb.  I wonder if it makes sense to upstream this commit since I
> suspect that most upstream users will not have the "unimp" log messages
> enabled unless they are debugging a problem and in that case, we would
> be erroneously masking these unimplemented registers from the logged
> output.
> 
> Thanks,
> 
> Glenn

I understand your point. Here are my thoughts:
- Cleaning up these logs for valid accesses (PowerVM bringup and development) reduces the overall log output and helps find real errors
- In the future, there may be a customer that wants to run PowerVM with upstream QEMU. The more we upstream, the easier that will be.
- In the future, we are going to have a number of cases like this where we accept accesses and don't log for every unimp access (to clean up log output). If we choose to keep those patches private and don't upstream them it's going to increase the number of private patches we keep, making future rebasing more difficult.
- I'd prefer to upstream more patches, and focus on keeping only the patches we need to private (for confidentiality or other reasons). To make future rebasing easier.

Feel free to contact me offline, if you'd like to discuss this further.

Thanks,
Caleb

> 
> On Thu, 2025-12-18 at 14:03 -0600, Caleb Schlossin wrote:
>> This commit suppresses the following informational messages
>> regarding unimplemented pnv_chiptod registers:
>>
>> pnv_chiptod: unimplemented register: Ox0
>> pnv_chiptod: unimplemented register: Ox1
>> pnv_chiptod: unimplemented register: Ox2
>> pnv_chiptod: unimplemented register: Ox3
>> pnv_chiptod: unimplemented register: Ox4
>> pnv_chiptod: unimplemented register: Ox5
>> pnv_chiptod: unimplemented register: Ox13
>>
>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
>> ---
>>  hw/ppc/pnv_chiptod.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
>> index f887a18cde..cd9b8ee348 100644
>> --- a/hw/ppc/pnv_chiptod.c
>> +++ b/hw/ppc/pnv_chiptod.c
>> @@ -145,6 +145,15 @@ static uint64_t pnv_chiptod_xscom_read(void *opaque, hwaddr addr,
>>              val |= PPC_BIT(4);
>>          }
>>          break;
>> +    case TOD_M_PATH_CTRL_REG:
>> +    case TOD_PRI_PORT_0_CTRL_REG:
>> +    case TOD_PRI_PORT_1_CTRL_REG:
>> +    case TOD_SEC_PORT_0_CTRL_REG:
>> +    case TOD_SEC_PORT_1_CTRL_REG:
>> +    case TOD_S_PATH_CTRL_REG:
>> +    case TOD_TX_TTYPE_2_REG:
>> +        /* unimplemented, but suppressing logging for now */
>> +        break;
>>      default:
>>          qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
>>                        HWADDR_PRIx "\n", addr >> 3);
>> @@ -420,6 +429,15 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
>>      case TOD_TX_TTYPE_5_REG:
>>          pctc->broadcast_ttype(chiptod, offset);
>>          break;
>> +    case TOD_M_PATH_CTRL_REG:
>> +    case TOD_PRI_PORT_0_CTRL_REG:
>> +    case TOD_PRI_PORT_1_CTRL_REG:
>> +    case TOD_SEC_PORT_0_CTRL_REG:
>> +    case TOD_SEC_PORT_1_CTRL_REG:
>> +    case TOD_S_PATH_CTRL_REG:
>> +    case TOD_TX_TTYPE_2_REG:
>> +        /* unimplemented, but suppressing logging for now */
>> +        break;
>>      default:
>>          qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
>>                        HWADDR_PRIx "\n", addr >> 3);
> 


