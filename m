Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82346CC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6TH-0003MZ-0E; Wed, 14 Oct 2026 17:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xH6TC-0003Ev-82; Wed, 14 Oct 2026 17:25:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xH6TA-0002Pu-DI; Wed, 14 Oct 2026 17:25:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEiSX72327292; Wed, 14 Oct 2026 21:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0T+oQ1
 xsixLH09YEOZi4aAVQyJ6I0nKgEq9bc0c3Cmw=; b=dNHIRyHCtqmfc/NHsdlxif
 5D4JWGD457dmSBmYFN2aiBYWlYUkT2GwWtQUiUj0kEzpVVxVv0vu/IY3gA5uvf3C
 Z89el8scaw7syA5gzad5l/XJFi2a0bVlxMxs2Qu0oYepwc7AjKYY2eSNeNrBjsHJ
 bLQAszrpwxlIctWZC+P52rvfWcRUPR3wSMcztCWSuf+lnNcruDaJJWQAJUjj22m9
 iTVAs9T8JiAWl22y3k+LHYQvPaS8ctSPYmv7PCapmZ6JjxUT90eUxivgarFanKtA
 llZvo74NbDcVx76ieTHbdS+cEx8wqfZgnwGjIv18jeePR1U7eKUelc5FNC9VCUQQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwj6b6d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 21:25:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIgoeH669889; Wed, 14 Oct 2026 21:25:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9ypq459u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 21:25:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69ELP2UZ26673758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 21:25:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F93158061;
 Wed, 14 Oct 2026 21:25:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA0C55805D;
 Wed, 14 Oct 2026 21:25:01 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 21:25:01 +0000 (GMT)
Message-ID: <e1c84882-38be-4d34-bb4a-61603df9f337@linux.ibm.com>
Date: Wed, 14 Oct 2026 17:25:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v1 00/10] Merge tpm 2026/10/08 v1
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>
References: <20261008212723.3679685-1-stefanb@linux.ibm.com>
 <6f16a062-0c52-4cf3-8f6f-b1ab1b6b9c5d@tls.msk.ru>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <6f16a062-0c52-4cf3-8f6f-b1ab1b6b9c5d@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfXz7v2Ds0dG3FC
 ZRQAgdvL5bouBUxV/3CX/9ZlXBE6xFfzpiUJHKtgTbe0OioVru0T1YS4FeYAcVjGb54yGqip2jk
 SPyPOKJBTIDLwmJ40nb61CyRttEZ5A3mclw9pvOGc90NA4iRIC354ijq7TzR4Pu4pIIUsTiRMn3
 qsuzVkIHi360D49wHl4Utq10RcznNjvj5ZaU7agm2yaFSd0rT37BJ2gSJMG7QxG4n6ess/TUUcF
 JlEbbruhVjyBWFn7X3kNvB2vmh/2NiIxFDkBO2iji2wfr7GYI9Vv7F9OeMK1Y9xbf7vr8z9G1y3
 BwA+apvo8JxC8Qk+9LzT0ua+7fQGLGtW/eZAy62gpt/ZMJm7nKZjdpLe2aJUjDu5URMsfh8uQlA
 uJBxpGNUctImcY1YcpYt7qnI5zii4HmMJF7js5tjuW+Lcabz8Q9UEmC3iMfdmEpqBUNCoKCjmWG
 etbteJEgUxj/ISli4Og==
X-Proofpoint-GUID: pkZW6_zvL23Tq-ZOdfrVJnhHdvm2yqr2
X-Proofpoint-ORIG-GUID: pkZW6_zvL23Tq-ZOdfrVJnhHdvm2yqr2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX2V0EyYU3kDaB
 KSKPkuZxGwH6B1p7JZ6ewXMBeWqaXLvR67sg6w/BtrZ/rGQyT1KPsA8a6q+vCa3eLZJvhZIiRKr
 aH/YVHoF90lD8uG+Uni3BrQxeIMrh8k=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acff32f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=PMYbdM-VAbiKc3oEtvgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
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



On 10/11/26 3:35 AM, Michael Tokarev wrote:
> On 09.10.2026 00:27, Stefan Berger wrote:
>> This PR fixes a couple of issues in TPM-related code.
> 
>> Stefan Berger (10):
>>    tpm_util: Pass TPMVersion to function writing fatal error response
>>    tpm_emulator: Reject TPM responses whose size is too small
>>    tpm_emulator: Reject sending commands smaller than the request header
>>    hw/tpm: tis: Only read from response buffer if rw_offset < len
>>    hw/tpm: tis: Use uint32_t for len to avoid truncating size of command
>>    hw/tpm: crb: Do not clear internal buffers when backend is busy
>>    hw/tpm: crb: Avoid potential integer underflow
>>    hw/tpm: crb: Implement tpm_ppi_uninit and use it in tpm_crb_unrealize
>>    hw/tpm: crb: Consider response_buffer->len of received response
>>    tests: Add tests with commands with bad length
> 
> Hi!
> 
> Is there anything in there worth picking up for current qemu-stable
> series (10.0.x & 11.1.x)?  It feels like whole pullreq is, but I'm
> not sure :)

Thanks for asking.I just replied to on 3/10 and 6/10 to qemu-stable, 
which would be the most urgent ones.

> 
> Thanks,
> 
> /mjt


