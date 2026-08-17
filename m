Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1CBC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvsgB-0002QS-RM; Mon, 17 Aug 2026 04:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wvsgA-0002Pz-4T; Mon, 17 Aug 2026 04:26:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wvsg8-0002vn-Ih; Mon, 17 Aug 2026 04:26:45 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLVleE1866101; Mon, 17 Aug 2026 08:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ABa85G
 wVsCvEyGDCfjRL6QZvFE6C0irciCG034FBzUc=; b=Y9Bd07/9pEzVBvKInFtx1B
 lE0QN4RUrDC8YKj67bz5W3ApVDpi7PthBrlTT0yimIpImZIsNo1WBTNmA647V86Z
 AEf3aTiOoGCnH4cTkLLNQmak1p1A1PsJpRCpS65RD5ro6yQd77xIeDoSMlGZea5+
 ALxtoiPZ8gAPlU7jeTScW5rXgRqXP1nQI7eRofeDu0iWToyr0/uofVOyde6gylan
 EOxsXGzI4vSOlt0NedpCByDVKQTpI07WAW+FQXz+Tb70rgweB8LOzx0bgkVgkVHR
 hUEVH7UfID+Gwlrj4yPRMewPryqhz0AJpgsnaHIk4c3YGyD6Ow6z1rTy0HaW5wjg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqh64t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 08:26:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H8QIT2018691;
 Mon, 17 Aug 2026 08:26:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epw9qn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 08:26:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67H8QacV38732278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 08:26:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DC0620040;
 Mon, 17 Aug 2026 08:26:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8867620043;
 Mon, 17 Aug 2026 08:26:35 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 08:26:35 +0000 (GMT)
Message-ID: <731e16e6-8734-4e5b-929c-02ff6393c927@linux.ibm.com>
Date: Mon, 17 Aug 2026 10:26:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 13/19] target/s390x: Support protected key AES ECB for
 cpacf km instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-14-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806151302.26846-14-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX7PFew0pPX2+j
 r0zg3ikjlRAx5f2YcHlKU1qH/aj4pQoTiXAFJBdGx0ZObYaYREiTmNa8FvQAPfdMrXyndyrbGVh
 wfXbCpH4zqzri0QfIWtznGiScwEBZuEBC6JfMaeHNRC0m/YzjfWK2RDF12X9NKRBM+h8JP3cqJo
 s0FK3NGhcTgVTSSY4HJVNe6w1ydApWJqaoFLWXSWUCAWe+5Iupc1y0ixeU8w+dXDOUCIeqRkKV8
 jPCs6yihbrvWgddAupbQMm0KvWoWEcL7XiPNb2W44g32yZgdtkryL2mV+qUFYhrOV5T2+ZSpF4K
 8jBH4ZVqXeqIiWouJcl1S3mg8XdYyIJzszjycGHlRP1s9cqOuTg3I+LhfZn18CzWq7io+PLPCNI
 NEPl7VQFfvylC1dBRbaOWFFopN072XN2IUjvWbVh1Qn3u+brpLO7YVfqDiam3xRckgV9WD22kXe
 hMdrZFpcqGGFqRAxaZA==
X-Proofpoint-ORIG-GUID: ZlD99gvc3L_JFMD57GrDsMsVO264iGfL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX6X/sz3b86f1N
 5z8khCZr3VaMeBYEKSS5CBJtaNzZo2uYiuIS5b+q6UhxOxssAIzBIbbw7bBDQUPCASB+RjL5j5y
 5r7f/MU5fKMJjdNQkYehbwebceN3NF8=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a82c5c0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=7BqUVm1WvOX2Y447tpAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZlD99gvc3L_JFMD57GrDsMsVO264iGfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170059
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 8/6/26 17:12, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_PAES_128, CPACF_KM_PAES_192
> and CPACF_KM_PAES_256 for the cpacf km instruction.
> 
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         |  4 ++
>   target/s390x/tcg/cpacf_aes.c     | 91 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  7 +++
>   4 files changed, 105 insertions(+)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


