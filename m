Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C37C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi0pG-0001Mh-7W; Thu, 09 Jul 2026 22:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wi0pE-0001M5-3Y; Thu, 09 Jul 2026 22:18:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wi0pC-0001Ig-Is; Thu, 09 Jul 2026 22:18:47 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HmSH32860889; Fri, 10 Jul 2026 02:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gFqtbU
 lic82IizJAaZkvfd65S6WVfLlh6R8b4Q4ztCc=; b=qhQxd5hOT5DHio2lPobXfE
 WZpQR9UsiWGvmE6ZlH6VU8cGMvTEJgorAZv5ept+7vDBFZHmMr3s228ct5U3OeBB
 IEAZdGCotbsYSRzcOcxXPidqG+FwEUKSdQBkMNuAwZnzpWr66sboho6Sed1HbM5o
 JQPbHrzG41L0yey5h9sT7X9CopRuIUhRIt7VSAxia1/hqhsO/hCERXVyoz1ZwuKF
 hXKG6KZW9E0r1+//ub2fu92W0CXjI+lRzXB8KMO7IMQ5/C1NO9YiEdCoglH0Tfco
 8WvdGGt6hoyNM1DmvbKcuPdV+t7J+CYBIXUkzaxVMVi1JVBGZd9UvEa+KoUZJHEw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fafh09ubf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 02:18:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A1ndjN026688;
 Fri, 10 Jul 2026 02:18:41 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hqv15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 02:18:41 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66A2Ied924642150
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 02:18:40 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0FE55805A;
 Fri, 10 Jul 2026 02:18:39 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16C5F58056;
 Fri, 10 Jul 2026 02:18:39 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.127.23]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jul 2026 02:18:38 +0000 (GMT)
Message-ID: <aff3a40fcb93249f7ea69826adf36e070baa1838.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390x/sclpcpi: check event length field before
 reading from buffer
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>, Cornelia Huck
 <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne	 <jjherne@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Ilya Leoshkevich	 <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Hendrik Brueckner	
 <brueckner@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-stable@nongnu.org
Date: Thu, 09 Jul 2026 22:18:38 -0400
In-Reply-To: <20260709142906.197474-3-borntraeger@linux.ibm.com>
References: <20260709142906.197474-1-borntraeger@linux.ibm.com>
 <20260709142906.197474-3-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a505682 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=rr8C8PCEPf10EkIFLe8A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: Y8uzJ2zr459o15khfZmzrGHz_AKyZHyM
X-Proofpoint-ORIG-GUID: Y8uzJ2zr459o15khfZmzrGHz_AKyZHyM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDAxOSBTYWx0ZWRfX+VcmKd0OEyOV
 DsK9kVjrJBKwH7hQ0JVUv58OQYeKArxjTcuCqpDCaJce6LLjitQ8jfjYtIMfJ71WH9vOBTfnf/d
 xTucOG1CVds9OERQHo30MXDUx45WKjY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDAxOSBTYWx0ZWRfX2ghxseB4CmZo
 CEX0R7PY/noHzKC71e1wMK9ibZus9xUcOaagszOKmV56ImOXnF8TnHj7C+Ztv/oMt6BdeoYcAVU
 9grTolHo4UdcjLneWv8gMHjvDWBv/qvBHpajF1ne4MYDlqYZc6cSG2S/85W77Z3Y2e00rM1K39Y
 qI3Sitsv1PoWeXf0V6kzX0bmwP62F2MgSEX1B31KHA4IrlWxK3M4CIYtfAVlaQGiT3+GfKkdzHu
 U1OM2vEstPGqw+FYc6FBdGpXRcHL+cVJLYv9Z/EGzGom4g25Zl2t2Lp/0JqjMazjdKFV2kQtrbV
 gr5UbkvHI86cSBBi27Im4eOWYn3hTfLz2wj+HJoE8roIkhgBDdhxcKLvcu15l3hQjIpdni9C5Q0
 /eclQXQoLXc+py4qGnZuyXDmOlft0RNdfvxBcKvVShAy4oz32gqi1yp3AkgO2UL0M9lYzuXYCuv
 Yb1W54akXaNW5nkvKcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100019
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

On Thu, 2026-07-09 at 16:29 +0200, Christian Borntraeger wrote:
> A guest might send a too short SCCB with SCLP_EVENT_CTRL_PGM_ID. QEMU
> would fill its data structures with garbage data. Check for the precise
> length of the CBI data structure and reject otherwise.
>=20
> Fixes: f345978f24be ("hw/s390x: add Control-Program Identification to QOM=
")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/sclpcpi.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

