Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD41FA3753
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 16:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbhaw-0004w9-5Q; Fri, 02 Jan 2026 11:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vbhao-0004vI-Bm; Fri, 02 Jan 2026 11:01:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vbhak-0005V3-Sn; Fri, 02 Jan 2026 11:01:34 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 601LRKHm002948;
 Fri, 2 Jan 2026 16:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SY+QM6
 SwOQlEOtNArQaFnQGASZ22U/kNCco7JJZueNc=; b=coGEFXF+9veuqaMNGeBEDU
 NmEnp3ZS9fwUvC/mWm1a2yg9DgXH1zG+QM1msC1CBgHldL9wGSphpEGqalsl6BOj
 f2zZbzCvzSCO8ZVJW9XJhKoNUxUIsDBTBpW8C+P2jB3Vd1n0OKF/pFvyyKNcQ8Rk
 Fezz5z5y2gjBdo/eyKQmFl4VUNhQ/abmQMrnXRcGJ0utal9Ik/Cz2vpPestMLlyJ
 phSNj5ajYiI4nEdTHsnfZ00bx0fjuzif/Om63RPCyZkJRaN8TEy5MFan7QSn79sf
 Iw9towhnovMiZrhN2fIM053V7ur6QL267dgOqOhkn/Y6ctf+HkkbcU2g7f9IfrXA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73w519f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jan 2026 16:01:11 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 602G1BOQ012861;
 Fri, 2 Jan 2026 16:01:11 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73w519c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jan 2026 16:01:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 602F4dBX008050;
 Fri, 2 Jan 2026 16:01:10 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bav0k70f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jan 2026 16:01:10 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 602G19Br28508926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Jan 2026 16:01:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EC645805C;
 Fri,  2 Jan 2026 16:01:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B31E75805A;
 Fri,  2 Jan 2026 16:01:08 +0000 (GMT)
Received: from [9.61.250.167] (unknown [9.61.250.167])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Jan 2026 16:01:08 +0000 (GMT)
Message-ID: <9006fe79-1065-464d-bfba-3b9bf5a422b4@linux.ibm.com>
Date: Fri, 2 Jan 2026 10:01:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Add dummy MMIO support for OCMB chips
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, milesg@linux.ibm.com,
 rathc@linux.ibm.com, chalapathi.v@linux.ibm.com
References: <20251224142249.1356424-1-calebs@linux.ibm.com>
 <41ece6d5-e211-4b32-ab87-d1fe5f359228@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <41ece6d5-e211-4b32-ab87-d1fe5f359228@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F2tuCu933Y9V04hNNAPcGLSPAywt36bF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE0MSBTYWx0ZWRfX5mGzl4kehjw4
 qK2PN5h42tNQ+jxIxUXFZpU/V5so1VZGv26uW8TPNuj2h2vAS6CWJ13TSMaeZzml6AFPh1EnXJ7
 LdjUeb7mStGjzHSN+WjyXNJ3WiOBWlfa18EcygfRfyzDhb+22wjk88KeiR6XYJkh7KoXjHQtJid
 ejbwmWsRnvIIS/yBLdtLQ/vB4ophMtai+e/2UlkCLxveAbiRFBSA8qM3Wc4gGo4UZ/EDqi9et6g
 W/OM5nHPfmOevbtjhXxjC5orrWAuDKsnV7wf10eYrfMj3EsrZ7pfZXaPiCP2JVe82g7hOZksn/U
 nPikL+LCKwmY1ovnMlslxTIX3PN86rorcuWOES+lVhzP7p91SQZl0s+G2fipmelVFicFRL5UYFm
 e8zrmNQ1ZexXdDpLcxDA5834CmVfCOr20TsyzG8fR8oop6rxq5ADxYys94toQbBL9qMNgxLNKzv
 em9uYhNVvZAbgGOxCIg==
X-Authority-Analysis: v=2.4 cv=fobRpV4f c=1 sm=1 tr=0 ts=6957ebc7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=D4yLe6ciAAAA:8 a=VnNF1IyMAAAA:8 a=BSKlWoiaO1rI1dpI8jIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=RJBimmv2CioV9QQA5JKZ:22
X-Proofpoint-GUID: Es4j0coB1qF_7bMgKMjWtcH6nvytJE40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601020141
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



On 1/1/26 12:45 AM, Aditya Gupta wrote:
> On 24/12/25 19:52, Caleb Schlossin wrote:
> 
>> The Power Hypervisor for P10 expects to be able to access certain
>> Open CAPI Memory Buffer (OCMB) chip registers.  Since QEMU does not
>> currently support these registers, several access errors are being
>> posted.  The hypervisor is able to progress despite these errors,
>> but it does create unwanted noise on the console.  Adding some
>> dummy MMIO support for this IO region in order to suppress the
>> error messages.
> 
> Hi Caleb,
> 
> If there any public document/spec available that documents these registers ? Can you please point me to it.
> 
> I don't find any 'ocmb' mention in any docs here: https://computeexpresslink.org/resource/opencapi-specification-archive/
> 
> Since a new TODO is getting introduced here to implement those register accesses, it can only be done if some public information is available.
> 
> 
> Thanks,
> - Aditya G

Aditya,
I did some searching and couldn't seem to find the registers used in any of the public OpenCAPI documentation. I think the registers being accessed are Vendor-specific and likely not publicly defined. If that is a new requirement, we don't have to proceed with upstreaming of this patch and can keep it private.

Thanks,
Caleb

> 
> 
>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
>> ---
>>   hw/ppc/meson.build        |   1 +
>>   hw/ppc/pnv.c              |  10 ++++
>>   hw/ppc/pnv_ocmb.c         | 103 ++++++++++++++++++++++++++++++++++++++
>>   include/hw/ppc/pnv.h      |   3 ++
>>   include/hw/ppc/pnv_chip.h |   2 +
>>   include/hw/ppc/pnv_ocmb.h |  38 ++++++++++++++
>>   6 files changed, 157 insertions(+)
>>   create mode 100644 hw/ppc/pnv_ocmb.c
>>   create mode 100644 include/hw/ppc/pnv_ocmb.h
>>


