Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CCAE9A03E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 20:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsRhS-0003Qz-3D; Tue, 17 Feb 2026 15:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vsRhQ-0003Qa-2d; Tue, 17 Feb 2026 15:29:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vsRhO-0000GE-KP; Tue, 17 Feb 2026 15:29:35 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61HItIOg3356257; Tue, 17 Feb 2026 20:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CHmE2H
 fq8aZMZCk3sZsT3YIu/YC0B91u7fM09GxVBiQ=; b=c446BkX+yM562OUVAif94O
 Tl2ylwdzJJTLuavibDCHGAnUjOOub3VltUy3dK6AzLUGZEsH8qMZTIPB40BtT6MG
 iazouT2x8lq9ShhKH+7L6uEg216a0t11RKo8x3v8dyUAoZB/rEKPMhR7HVJHNQQS
 75SbTZEBMgGQP5y7qWIILUaSlKBHkPppYmsgPrQQhhKyOWxoYg4F1C89bKcfLFjj
 ETfQqFW7+hWZgo+1XqJI6l5H37hDvYPyQAZEcnRdE7mmuk/fL/KuuyrVqKMC/kct
 eCI61zx/G6rr/SfZHnspxLk5Hn3locwL+Nhe3L/zRmr3LY6wuAUI28YGxkdB016Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rxe47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 20:29:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HJ0PAe011912;
 Tue, 17 Feb 2026 20:29:27 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb26w1fv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 20:29:27 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61HKTPwj18940636
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Feb 2026 20:29:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFE1858058;
 Tue, 17 Feb 2026 20:29:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9E8758059;
 Tue, 17 Feb 2026 20:29:23 +0000 (GMT)
Received: from [9.61.75.187] (unknown [9.61.75.187])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Feb 2026 20:29:23 +0000 (GMT)
Message-ID: <e3c184c3-5009-474f-9c78-3b3697f7cc09@linux.ibm.com>
Date: Tue, 17 Feb 2026 15:29:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 30/30] docs/system/s390x: Add secure IPL documentation
To: Markus Armbruster <armbru@redhat.com>
Cc: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-31-zycai@linux.ibm.com> <87bjhnpzeb.fsf@pond.sub.org>
 <87tsvfok6p.fsf@pond.sub.org>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <87tsvfok6p.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=6994cfa8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=fkdjs8v7KmaFqklBIpgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gh-SCuRIxBphyu2OFR25Y33reLJ4qGSz
X-Proofpoint-ORIG-GUID: gh-SCuRIxBphyu2OFR25Y33reLJ4qGSz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE2NSBTYWx0ZWRfX7ZIqENdirSRT
 jk6ZIzBd5o48oTrVMldLxF9bu+CKR9Mt5dli7uEQvIzO33xyUbKn+CjFPOjSQX77/PbAVSRTRnl
 /W29PnDFtRAyaM454o/xyEwcCvs0wRF+Qi+giFk6FH2U+GVZaC8GxZWM/bDtiDApd3Fb5qcdvld
 9acRDuZJuGWh7Ijy1in3++m2dUWboP/jDRhWEJPDdIYsj0HMKy61CIPq9ki95idLxxI9ViB7fuQ
 emZF24Nt1Wq4dgal/6ye4SmGNb734FLVTnYXX0vgwFHiT5aSR/ntiBEjOJ/T3Rvy7Ccsplu51Rx
 UzDFs7tfD/Az8js/kq3ljv/lqz+1uXiQJm4iDSSRHKEA4MEbg9yyWWeWohhgP8fpqMWE0ELJRBc
 tVXKcxx4p3Up/SH8lt1t3kE0giYOlm0HTE7qHBLfO255BEcnTOlYeAwBdlzRLkokElBHIbRkNZV
 U+vyT6TxI4h1uXUwHrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170165
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=1.999,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/17/26 3:20 AM, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> Zhuoying Cai <zycai@linux.ibm.com> writes:
>>
>>> Add documentation for secure IPL
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>> ---
>>>  docs/system/s390x/secure-ipl.rst | 96 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 96 insertions(+)
>>>
>>> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
>>> index e0af086c38..275aa422c7 100644
>>> --- a/docs/system/s390x/secure-ipl.rst
>>> +++ b/docs/system/s390x/secure-ipl.rst
>>
>> [...]
>>
>>> +Command line options for starting the guest
>>> +----------------------------
>>
>> Does not build:
>>
>>     docs/system/s390x/secure-ipl.rst:172: WARNING: Title underline too short.
>>
>>     Command line options for starting the guest
>>     ---------------------------- [docutils]
>>
>> Please test with configure --enable-docs.
> 
> With that fixed, I get
> 
>     docs/specs/s390x-secure-ipl.rst: WARNING: document isn't included in any toctree [toc.not_included]
> 

Thank you for the review. I’ll test the series with configure
--enable-docs and will fix the documentation build issues in the next
version.

>>> +
>>> +.. code-block:: shell
>>> +
>>> +    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certs.0.path=cert.pem ...
> 


