Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2512C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9jRp-0003QP-Vu; Thu, 24 Sep 2026 09:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9jRe-0003NE-W4
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:25:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9jRc-0004QW-R3
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:25:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC66FL314679; Thu, 24 Sep 2026 13:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JD2/jm
 /vC/FAiJwQbb4rXPqD+X600IPzKbAhIz/WQ9U=; b=SNoaFRVivXTETG5SH20olM
 6fjqzyQRq9GH6Dj3NIEYHzJffP6k6MrhJeYj6a7wn6EumtL4AX3Pok7QkxgBnfZi
 8Cm5TUtNgq9Oo2tpVeGgNEG9ZvZvGnIExQRBHwMis8ptLuoGF+lml5cvmBReNaQ/
 +8daTbkJts0KAOR0gu2oR40GEzl799T/Gnt0EuR/whMLL6gTraMrO5tiqP2QiYpR
 icQwvyFQp8Qf8HUF9CdlRkAjEgX4caCxmaGt3TJgfoBwrLOrX6H/jRM6fQi/s2iI
 48gBePfaJnYeqCtrtzt0UN4kwM+fb41NSCQikOfujhFg96mvCkfQeMpFLXbOSG5A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske21aqh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:24:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OCHWHC720142; Thu, 24 Sep 2026 13:24:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7ea7qw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:24:57 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ODOuQ752167080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 13:24:56 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74CAA5805A;
 Thu, 24 Sep 2026 13:24:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F5365803F;
 Thu, 24 Sep 2026 13:24:56 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 13:24:56 +0000 (GMT)
Message-ID: <6b7bdbd6-4f42-4b96-82ea-de9e1ed3c05c@linux.ibm.com>
Date: Thu, 24 Sep 2026 09:24:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] tpm_emulator: Reject sending commands smaller than
 the request header
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, armenon@redhat.com, marcandre.lureau@gmail.com
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
 <20260924012527.858527-4-stefanb@linux.ibm.com>
 <179023566485.1794827.3207875692317981911.b4-review@b4>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <179023566485.1794827.3207875692317981911.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: z5lbUeidb4BRpy-ENgUDcV_NoRGxHK_8
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab524aa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=nB7A7xXTZRbs8pxm6NgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX+bV1c++8D1Jv
 XDsjNWVxy8Faq0/ftjX/8bRSJcZQSqH4fuspwUleXeib0De5XEBj9DoOMemW1TvCiA67k40mLWK
 4JzJsjHFZ2ZcCJ/Il+5D6upyYZN5/kk=
X-Proofpoint-GUID: kUh-AeQWOFs36K5Fsq0G59nmTANgdv7J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX7CB6FmTpmoDs
 lV2dS/asuZcRxv9dJjWtuxNlKy+GmCmDnMFe+uKYAGPGDpkFMLqe6lIDxYR/9IAPV4ZqrN+XDFm
 Rf4g18uneaan3PLNpFW64dSYzuvuPHn3+KreBSUqNlGpIjHCrigw9GoajIkO1i2N2i3qZgxJgec
 ibu+8HoNSvBrUghLLwJ0tqFuW+bx9oyqDyCV1szsISFLrqvWk5slYA8DE9q4XXYLNAmjTJau5Ow
 MLRv+3kDr/C4yDm/LygbpEt9aFSdpyu/gQwaQsCunKpMfareIV8d48yPb7dkwpUvyAMMhsrPXSU
 984PZjnD5jZ0fId7j/hbBRXLjuurN2rkugKkytMrUTPloa88u6yLDbhHJlmlD8+EeipY6ujmMR4
 gqgjWsvDAeLYvUEPfqipXzSFvcNKBHQ9kiIGi43vsFXyFaNjk5W9zZgFwZmZQGg1VQ+6qt/B6st
 9LU3ikmhEYNH7o8xZYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240054
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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



On 9/24/26 3:41 AM, marcandre.lureau@redhat.com wrote:
>> Reject any TPM request from being sent to the TPM emulator that is shorter
>> than the size of the request header.
>>
>> Fixes: f4ede81eed29 ("tpm: Added support for TPM emulator")
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Message-ID: <20260924012527.858527-4-stefanb@linux.ibm.com>
>>
>> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
>> index 9c95b4d878b5..0c9e32f36a53 100644
>> --- a/backends/tpm/tpm_emulator.c
>> +++ b/backends/tpm/tpm_emulator.c
>> @@ -181,6 +181,11 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
>>       uint32_t to_read;
>>       ssize_t ret;
>>   
>> +    if (in_len < sizeof(struct tpm_req_hdr)) {
>> +        error_setg(errp, "tpm-emulator: invalid request size %u", in_len);
>> +        return -1;
>> +    }
> 
> It could probably be an assert() instead.

The TIS may actually send a command with only 6 bytes.

> 
>> +
>>       if (selftest_done) {
>>           *selftest_done = false;
>>           is_selftest = tpm_util_is_selftest(in, in_len);
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 


