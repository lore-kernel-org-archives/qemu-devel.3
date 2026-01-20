Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8AFD2ECE9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 14:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viClp-0002Wf-4t; Tue, 20 Jan 2026 09:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1viClm-0002RW-Ax; Tue, 20 Jan 2026 09:31:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1viClk-0005FL-E2; Tue, 20 Jan 2026 09:31:46 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60K7XL7H001734;
 Tue, 20 Jan 2026 14:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3aLiCi
 iiGGwg7X5Wyz6Catjseq6MhPU6EcYxvts1tPY=; b=BNVZ2chLZYvjcnZ68kB13u
 R0WRKCFq3Vb3VdbTJtShpMSNgRyDDIDV6RzHTr575CnXgcc9xFp/pEm/GJZR8sRX
 cj8Yi9k4AYq6Gz9JDZQ55A64MdqVsHMZ4GHawgSIfT6mh8PZplTprADaWese8MYO
 2HYCFU55cAi1kSBlbRNgynaex7P1193ayu1p4/RUaTd9kC32NpfG1ULu+3N65ccu
 KaoLgnskbun2jZorLe7Ow+RI2w90RtvedSUwQDRLQesQLm1HPyLN8WOsNIWJIRsS
 6J9LPY/BwHP1vo+K/4Hs0us+lu+gYT1ppSHoN+kdyph4Kt39+//B9e3Ll7yEO2aA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0ufdeax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 14:31:41 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60KEDkno017336;
 Tue, 20 Jan 2026 14:31:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0ufdeat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 14:31:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60KED6Pe009265;
 Tue, 20 Jan 2026 14:31:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brp8k5a2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 14:31:40 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60KEVKHY14680624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jan 2026 14:31:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F77058059;
 Tue, 20 Jan 2026 14:31:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CE8058053;
 Tue, 20 Jan 2026 14:31:38 +0000 (GMT)
Received: from [9.10.80.137] (unknown [9.10.80.137])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Jan 2026 14:31:38 +0000 (GMT)
Message-ID: <6072a537-e18c-4d46-9142-36e9c25bb11c@linux.ibm.com>
Date: Tue, 20 Jan 2026 08:31:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ppc/pnv: Suppress some "pnv_chiptod unimplemented
 register" messages
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: milesg@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 npiggin@gmail.com, chalapathi.v@linux.ibm.com
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-2-calebs@linux.ibm.com>
 <1fa38659565cf4dc1dfe24cc365d685554faecf0.camel@linux.ibm.com>
 <5e13f2c3-2075-4d31-bddc-06dcc31f6eae@linux.ibm.com>
 <aW3wVCdyn3WkeUoF@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <aW3wVCdyn3WkeUoF@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TedUwzfyA3wc4WduEp2CQYEmeZtnq-db
X-Proofpoint-ORIG-GUID: ZpG9xfWc8y0mo7XnVNdejVXMyVDlTJUE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDExOCBTYWx0ZWRfXwJ1DGzDSRwnl
 OxXAZaeKPRbcmMTH4DSWPGrOluliUO7bX3FkHnDrD5uef4ifJYiXppEQKj6k9HTIqq4/zW8Ixbw
 1RcqTh5jvHat99XXzZuPxmymG2YH5AJoB9AyOMd/3cgyVOfJjOdESvEnm0xqrKOBATLy+/qWhqZ
 3SvxhsiQR/ErUlRdBmeIL6tgRz7SHsVZRT3Ujf+g4HFn1x2lORBhqxUGrN4MmGm39nXIghSNGGj
 6g/eF1kUAELoFF2Wk42RZOaaCblWLFxx159GeZFrh2LhmuyrXn60Dd8zWKk3cBKggXKAdn2GuTS
 o00ZL+AFAIrjojwJCYmCzesaTHWORUuGr3MBdLzlI8pn83aoOQFpK3SNpLU8ZCeg1475oq+14qF
 Hi73WrXLm+kxkxR5W6YcbFD/42Hx2sfkaJf9jO817+dgL9U8tNi8QdOqNtaL6rcXqQrFriyqMgc
 YAunRS9WwBoLLiY9fbQ==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=696f91cd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zemG__UicHLbtfz2P7kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601200118
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
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



On 1/19/26 4:18 AM, Aditya Gupta wrote:
> On 26/01/06 11:07AM, Caleb Schlossin wrote:
>>
>>
>> On 1/6/26 10:49 AM, Miles Glenn wrote:
>>> Hi Caleb.  I wonder if it makes sense to upstream this commit since I
>>> suspect that most upstream users will not have the "unimp" log messages
>>> enabled unless they are debugging a problem and in that case, we would
>>> be erroneously masking these unimplemented registers from the logged
>>> output.
>>>
>>> Thanks,
>>>
>>> Glenn
>>
>> I understand your point. Here are my thoughts:
>> - Cleaning up these logs for valid accesses (PowerVM bringup and development) reduces the overall log output and helps find real errors
>> - In the future, there may be a customer that wants to run PowerVM with upstream QEMU. The more we upstream, the easier that will be.
>> - In the future, we are going to have a number of cases like this where we accept accesses and don't log for every unimp access (to clean up log output). If we choose to keep those patches private and don't upstream them it's going to increase the number of private patches we keep, making future rebasing more difficult.
>> - I'd prefer to upstream more patches, and focus on keeping only the patches we need to private (for confidentiality or other reasons). To make future rebasing easier.
> 
> I agree with Glenn that we shouldn't mask these warnings for everyone.
> 
> Since a warning saying a feature is unimplemented is better than
> silently not doing anything without any warnings.
> 
> Maybe the excessive warnings should only be masked for PowerMV
> development work, rather than upstreaming, or we can always upstream
> once those are implemented.
> 
> - Aditya G
> 

Ok. Would you like me to pull out this patch from the series and send out v2 containing only the approved patches?

Thanks,
Caleb


