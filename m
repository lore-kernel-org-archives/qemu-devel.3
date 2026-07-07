Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDAFC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 01:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgudk-0006Zo-CB; Mon, 06 Jul 2026 21:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wgudh-0006RT-VO; Mon, 06 Jul 2026 21:30:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wgudg-0004tR-Ef; Mon, 06 Jul 2026 21:30:21 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KIQYr1188940; Tue, 7 Jul 2026 01:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=escg7a
 o9cbjzKQti8+3PvIXpcPgD2ILlYaqeR9WAlrQ=; b=Ao+qw4U1f8jiuXPxscqFqN
 8346kfA2OKyxPzp+Lw+AmfBri53X3ULQ2OFmBa9fUB5MFS6wgsmgpOU8Nrkw2LI6
 VxcFK+3refy4/AbA89cRPXasoqcrduvfyOXNDiD8Fh6oOVbk/TcbfuApQs23oaIk
 k8y6HfHKf6FNVLsK3Pd1s9OLHHRr4/j2AyN7auNwl+hNdiPJvyg7yaTAC0s2J54l
 0GSdSEH153xFWKBCX5AA2AmHPjogimiq/skq8PQuy+YHjf+O7Dtn5dl18r5+vQ+y
 Iw0Gvx2kvQ1jieuR0dFvSIrA4H+b1pqWTE/uye7C+IU6J2s8z8eGOYrAmgD5qSPA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4man6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 01:30:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6671Jblk015839;
 Tue, 7 Jul 2026 01:30:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq0axu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 01:30:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6671UEQZ11338240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 01:30:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 611EA58062;
 Tue,  7 Jul 2026 01:30:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2860A58054;
 Tue,  7 Jul 2026 01:30:13 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.133.144]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 01:30:13 +0000 (GMT)
Message-ID: <99ff1b72dfbab5b29d06222da9e27c5fa6950b49.camel@linux.ibm.com>
Subject: Re: [PATCH 4/5] s390x/ioinst: Require strict length and format for
 SEI CHSC handler
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>, Cornelia Huck
 <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne	 <jjherne@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Ilya Leoshkevich	 <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-stable@nongnu.org
Date: Mon, 06 Jul 2026 21:30:12 -0400
In-Reply-To: <20260706091909.864405-5-borntraeger@linux.ibm.com>
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
 <20260706091909.864405-5-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cuGbM6wMyIVO8yMi3ciVT5ziYWnz77Gq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDAxMCBTYWx0ZWRfX72zgnqNOcWMi
 9M1CChITR0ViNCXYHAcX4sZtJavFtS9KmAvL4vxIvwvSDWak4FdXJ+CFfYH6K3m12IoEYqnHkkq
 jVWtqWQIqNSCFrqxyfdyoAeHoX6eBcyIXCDyRHBdUtkzdLPKjqycyynTVlknIIhchFpNI4KJQBl
 YG4ut6bGCj+57bvdsYKAPsVI5Rveo0KT3gc/xqTJhk3jZgXTpR0nPIsKi3tGnF5kd1t3JKCl2Qx
 XvEXlfmJLysjeDiJLttCVD5y1iTvjCiai4B7wCss6p7lfcX06sBgqfvWPQpTG2FRMIqODA3YAIb
 N2yKD8u/AgZQWKCDhVUITp4q4RhJ8eixMpgvSiF0JFSXUln3kGYowYmMc4ypVGiHK1Y94ZEShn0
 pFwDiqNHsFnJddnhe43F5BQRKNAjzUR5cRLexpFu0pSzIAGqeeTV8JguvWDCWg2wwat5lyBtvg2
 rsS10Yl0OoPa/1aOBmQ==
X-Proofpoint-ORIG-GUID: cuGbM6wMyIVO8yMi3ciVT5ziYWnz77Gq
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4c56a8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=OA4XwO7CFN31Cgcr7A4A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDAxMCBTYWx0ZWRfX9qPr3weBZydH
 SA7TnecSl0cIH4jl7ELopfBOSMozOlxScl97+o4Zpi6pxl9luSFD4J6vyG7bMfkEaid5MziMQZZ
 bhL82toeVJJpkT3893MfHJAZNVa3mG0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070010
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

On Mon, 2026-07-06 at 11:19 +0200, Christian Borntraeger wrote:
> From: Matthew Rosato <mjrosato@linux.ibm.com>
>=20
> Ensure SEI commands that are received are of the appropriate length and
> format before handling.
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: 8cba80c3a0 ("s390: Add PCI bus support")
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  target/s390x/ioinst.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

