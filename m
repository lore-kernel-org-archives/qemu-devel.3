Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ED7CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc16r-00063d-2S; Tue, 23 Jun 2026 09:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wc16p-00062U-9N; Tue, 23 Jun 2026 09:24:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wc16m-0003Z8-V9; Tue, 23 Jun 2026 09:24:11 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBn1u61858416; Tue, 23 Jun 2026 13:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=on+0QBgqn0KWED0Zji4ZXL+ApebeYMnDHgGTNc+b7Hk=; b=cyNnsDF3xNGC
 bmJgPP0oNW+Nx3TW/qMFIOuQDZu71/rQiM/XEa+asP7qh3Ycjz+8yv+gtjtj/QY/
 zfm6UL7ojTqgKlFZz+SjICSkDRUU+kXkBiXROqyiQ2/RJCyg4xZNUgWFnXRUGoX0
 0pcM9JIyeTThSSbYKAJ9PtDPjHIaQaDVdEdd/jHau7gxuGYrdb0PwSnf9ESGY9uv
 qNFHN5IRNlmMwgn44owtf2Ik1ZYEPSOaLNX9mntIcdnVJJZuj6KqwtPbX4mMyti0
 lnrzlVIigICo+kQOwYzdXaiIkV272zXL5c5PvgzLZaCGAHHTB7oR6moSp9F5e+Mg
 pqIX/KPyqQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hpx5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 13:24:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NDJe30018678;
 Tue, 23 Jun 2026 13:24:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qbmn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 13:24:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NDO2Gv46662082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 13:24:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEB275805F;
 Tue, 23 Jun 2026 13:24:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8641E58054;
 Tue, 23 Jun 2026 13:24:01 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 13:24:01 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 15:24:01 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 16/17] crypto: Add aes-helpers file to support some AES
 modes
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <b8f22f51-2613-4213-a5a6-d6525b9c253e@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-17-freude@linux.ibm.com>
 <b8f22f51-2613-4213-a5a6-d6525b9c253e@linux.ibm.com>
Message-ID: <a83b80f1c5dfb9b37bd2786667a8960a@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ce4kH9BbpJPCbCiOmZpTTtJCgXZk4-hP
X-Proofpoint-GUID: ce4kH9BbpJPCbCiOmZpTTtJCgXZk4-hP
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3a88f5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Cxrpp1Ua33vx6Cnz8XsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwOSBTYWx0ZWRfX0eRgMEppypHB
 Mv3UtIXUfT0L15quEJFt1k8pQkesgHvrh75U2y0A16uIrp1bWplPluFElYQe1MeiqqZWBd6sC3N
 OSxNT2EZgViJpETOOA3cOGV5vVKZKw67H4OZMJlvfDGFouIqwbavGeDYWhM7hg6ftbC2tydPffy
 s1fGp1TUXekejLou6pbAdqkExBLoEdIZHCeWuUW7Rz1UM0RQwiEOmBXp402jPsKwGl0uJFplKZV
 B8IYv+4iL8+GDXcT0jwtJV1ObVihN8+zfKN0Hi/lM1TPMpAn/b3Qq08cT20aANdkIywHYTyQqiE
 4gJe9QbbPy7kDktTFk/VXkkKuHILDHl7bRB9X3FfVE2W7f7bMuI7e5edRMWtVxWZRtLsSgEExzS
 Y+yuNZxiehbnI3W9aT5Msax0NOcfdPhO7g7txBNspnMmi/SUtm1rsqx/mGPyX7NnUNj+lmNBM5f
 x5BjGyKMCCtjNteLXcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwOSBTYWx0ZWRfXzNta9Ch6HFEF
 EYDLNBR0k2lBhWH7XHM3rAg3LKwy4hXTk2jU7KgVMe1YRjAE/0LKrws1tpORqS/POzwW/iCE9lA
 OTxxkLP2wtIiLdps6gMRVwIA+JpBDVM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230109
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
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
Reply-To: freude@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-06-18 08:31, Finn Callies wrote:
> On 17.06.26 11:48, Harald Freudenberger wrote:
>> Add a new file crypto/aes-helpers.c with simple functions
>> to support some AES modes:
>> - AES cbc: AES_cbc_encrypt() AES_cbc_decrypt()
>> - AES ctr: AES_ctr_encrypt()
>> - AES xts: AES_xts_encrypt() AES_xts_decrypt()
>> and some AES related helpers:
>> - AES_xor()
>> - AES_xts_prep_next_tweak()
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> I like this, but why do you do this so late in the series instead of
> implementing it directly like that? Otherwise:
> 
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

This was a suggestion by Holger. And I want to have this separate to
be able to remove this and the next patch without the need to rework
the implementation.

> 
>> ---
>>   crypto/aes-helpers.c | 101 
>> +++++++++++++++++++++++++++++++++++++++++++
>>   crypto/meson.build   |   1 +
>>   include/crypto/aes.h |  14 ++++++
>>   3 files changed, 116 insertions(+)
>>   create mode 100644 crypto/aes-helpers.c
> 
> [ snip ]

