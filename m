Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0917C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9q16-0005Ok-Od; Thu, 24 Sep 2026 16:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9q0x-0005N2-BV; Thu, 24 Sep 2026 16:25:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9q0u-000384-Ra; Thu, 24 Sep 2026 16:25:54 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5euY3079295; Thu, 24 Sep 2026 20:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WBMX1K
 xwJXZSEe7TXf9UvPXsNZsOytTDAkN7e8LMnVc=; b=YDEiSI+h3D8FLg1DZ7Xllp
 vyI94tIkiKH0vrIeoQgut9SUsl+n19VRsIY5Pcfab3bZB6gyLBYm6n8qoXBWLVNZ
 LPFgcNyzn1mTpacbOyaSeRs8W/W+5hEfDGzKwjViwpNs+55U+En1XiZH9MuuV1Pv
 IQTebAquAsaNMXMxGc12ZWtnkxKBim4qSg4N5XueDzKY4+iUB4u7LSOwYWp0SxRH
 aQ19SE6ezkOtClMyBMppKZPk36gcvl4rkbbGsdIOXnHZMSOSd6oSNSGrC2DYKikT
 OmF5Ex83HPxlQPLT+zTa4jfZZ6rF+gq9CqQJqu56/6tfwyUdZrPLEkdzZZGa9lug
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2ujeb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 20:25:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlXCU2559301; Thu, 24 Sep 2026 20:25:49 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1ymhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 20:25:49 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OKPmTg29426348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 20:25:48 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0602A5803F;
 Thu, 24 Sep 2026 20:25:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 691FA5804E;
 Thu, 24 Sep 2026 20:25:45 +0000 (GMT)
Received: from [9.61.7.131] (unknown [9.61.7.131])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 20:25:45 +0000 (GMT)
Message-ID: <d38eaf1a-2b72-462b-a4d1-db1d5e531532@linux.ibm.com>
Date: Thu, 24 Sep 2026 16:25:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] tests/qtest: Check s390x boot device support in
 pxe-test.c
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260924194837.80732-1-zycai@linux.ibm.com>
 <20260924194837.80732-7-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260924194837.80732-7-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iIwqa9sysXXsRnxSc7rX8Wmk2n6vPW2s
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab5874e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=GSR41NrXoBGxaPTtKDsA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4MiBTYWx0ZWRfX0DzNz7oA0xwM
 b1ofzwHrBNx44jvCblzxx4jnh+a4OMlutiNns0EsKje6eHkRYTrNoJ6g19x8HZxUsQkkhvurFZT
 B1Qec8p58Uj2lvrlQRsDsgWvorJCGsR3jBM8m8IysZh5ERnf3VTRlReJH77cA/rRBZl7L+dmwvD
 y3/dtr3Sz2kaA8tm9pq0A6F3+qRcBhT1+/7TUd7a7GPivYUZZU3jWhwNUa4bg+0H/GH4B6B1ctS
 YZoTwvhsRl4RpgMq5nqIpU6V8tU7B/SOVt1M7CXFWhObCOKSTOGn5deAEILggjO3YxaymckvFkp
 GBjVFZm2gYVej1HBUz8o2XUNivVNT7pl1k5Oga4RWWmCFT7+TmZvTqvv2KsabvghBSglX6j7Iud
 vev/cZIKwqcDSDVvRydh9SQt+yqbMx4D6nWAoCQOxcCBK2cBCNi9cN9CXs2U3/R+rc6WZ/6Kl17
 qBRs0hg2DWB9vFpxxFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4MiBTYWx0ZWRfX0aR0HwujrJZv
 X3lgaTTCaK183lBOIFLftxUMjx7FUleFUhNofqzATJ8LqRwfyYiAZCHIjjYpeT3AcGivbCZ7OG7
 g0B7XeRH7ONRvef56Q2vhVqR+RFhurk=
X-Proofpoint-GUID: iIwqa9sysXXsRnxSc7rX8Wmk2n6vPW2s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240082
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


> +
> +static bool s390_bios_has_net_ccw(void)
> +{

Since you'll need to respin anyway...

Sorry, I think there was some confusion about what I asked for here.

AFAIU checking for this string is going to unconditionally work as long
as we enter netboot code, before we even decide if -ccw- or -pci support
is actually available.  That's why you don't use this test for
virtio-net-pci.

Your old comment block said virtio-net-ccw support has always been there
(that's not strictly true)

So rather than removing the comment block, just reword it to explain
that the test just assumes virtio-net-ccw support is always available
and only checks that netboot started, it doesn't try to verify ccw support.

> +    return s390_bios_has_string("Network boot starting...");
> +}
> +
>  static testdef_t s390x_tests[] = {
> -    { "s390-ccw-virtio", "virtio-net-ccw" },
> +    { "s390-ccw-virtio", "virtio-net-ccw",
> +      .boot_dev_support = s390_bios_has_net_ccw },
>      { NULL },
>  };

