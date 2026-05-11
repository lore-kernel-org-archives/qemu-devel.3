Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB84CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRHj-0003uG-Mv; Mon, 11 May 2026 10:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wMRGL-0000u8-IT; Mon, 11 May 2026 10:05:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wMRGI-0007JE-1q; Mon, 11 May 2026 10:05:36 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B3umVi976191; Mon, 11 May 2026 14:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RFFaHp
 3RISPyXzGk+pQBfmCriICgyAjvZ4EI+Cx3cb0=; b=TaB/tvx3UTcmusTSsHFK2t
 27pr68gNV85dT3Nukd0VcHsDtiK9AIqvD7vyKKkeNKqMX8v4/n8Cuiv60RVxua8X
 Q4WcTC6ME6Mxic/m62AfEEvzNs/54gSDcXe5Fapiy8lKyCVZA4Jrnz317HdBDWkJ
 BVhahDdn3rizDuPLgq6Y3H8kELr4+6n/mHAeJ4i4O5A0Y5SM+qKzPk1lA64yY9eL
 WqVS5/QRt8M17CLQCpNPfKpvmNsbXvMTK4rUVk0D5tXRlvQ07ITRsQFbWtzz6XYy
 jL/ypBqthmVNCpLAlhjS6K/PgQ9z2gPfowFWl0yrsIpPbQjdZLLmp/gf4e2MW8EA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4rkcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 14:05:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BDsPEn003072;
 Mon, 11 May 2026 14:05:24 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2fmvwn2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 14:05:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BE5NDj24904232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 14:05:23 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B9F258058;
 Mon, 11 May 2026 14:05:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EED15805B;
 Mon, 11 May 2026 14:05:22 +0000 (GMT)
Received: from [9.61.44.159] (unknown [9.61.44.159])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 14:05:22 +0000 (GMT)
Message-ID: <85e738d9-0667-4ccd-8bc2-48f6b65bf215@linux.ibm.com>
Date: Mon, 11 May 2026 10:05:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/s390x: Fix memory leaks after removing elements
 with QTAILQ_REMOVE
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20260511063825.53633-1-thuth@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260511063825.53633-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=6a01e225 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=Nx961GGavPmN8L6er0kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1MSBTYWx0ZWRfX58SFGo7Az6Wx
 BQxEWtMY+BfN/fTg5slnFMfGs5RzyoGYHV54VCBflJtRrx5anvpM4Rh7EaTXpVMDJSNhUETNDrv
 AfroQiwu5iLoqBWMubtczFegxP+UYS8MyeInjcAYYVVv8vEUZMbvS1Q5ZzsBDTxqu/cmO73b6qA
 KHHElbrOVrVd8KIdP7/xIWVQwR6J86AtkSexWvLP6S5eG2nz9whB5pd/6qyHUtSqI54gfvOMAW2
 OqmTIqspy/f0QkLw45vTKZVANmULNxqVfcjWM2h/GBzySdPUo4Atrg+z0hkLUhAR+qtCqVfovQh
 1wSJDGWipgEMGa8XuUtnogRVjMVfOhDAT1kCBd+/9meclr/4tRhLTZWdD/OPdCgg8H41uXULqO3
 3W8SrL5mh1RhlrB9K0rwKflYMWf+iQaDGzRPUB+SDs4cN+gVlGNB7QVUC8KWzNUssR81cxGKOMf
 Ei3zVKGqL800Ap2skww==
X-Proofpoint-GUID: 6ooAMBLogtKZSyyPg0suu7U8usU4EWQX
X-Proofpoint-ORIG-GUID: 6ooAMBLogtKZSyyPg0suu7U8usU4EWQX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110151
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 5/11/26 2:38 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The elements that get removed with QTAILQ_REMOVE are never referenced
> afterwards anymore, so the corresponding memory should get freed.
> 
> Fixes: 37fa32de70 ("s390x/pci: Honor DMA limits set by vfio")
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Code looks good + re-ran tests:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>

Thanks Thomas!

> ---
>  v2: Drop change to hw/s390x/s390-pci-bus.c (since it needs other rework)
> 
>  hw/s390x/s390-pci-vfio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> index 7c754b656da..db6de00bd28 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -101,6 +101,7 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
>      cnt->users--;
>      if (cnt->users == 0) {
>          QTAILQ_REMOVE(&s->zpci_dma_limit, cnt, link);
> +        g_free(cnt);
>      }
>  }
>  


