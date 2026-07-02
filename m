Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0209C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf6um-0001bU-J0; Wed, 01 Jul 2026 22:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf6ul-0001bH-5G; Wed, 01 Jul 2026 22:12:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf6uj-00053f-Jj; Wed, 01 Jul 2026 22:12:30 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KsAj2647620; Thu, 2 Jul 2026 02:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WLSz7T
 hj01xJw6aYrrlLDmcmMUPTxL3mxhLbyM3+WT8=; b=odY2vynXh8jYkvArk7K5Ny
 LF29La47LX/IKefmoCjauHyrThLFzKXlbEXPleaD9cyAJpt81uJl5SihHHvVQbCt
 YdlC7ywvmR7Ro6aZTqgneid0ehj9ktbF084cxSvq2nrStxy+zDLmL4MkdAas0v12
 BxvGlf6H7MQWgoW/24BUtTyDqSTmKVwrHlRlrRO4NWZ+0o0CZniD7F6lKIz4RUOO
 IiFH5cuY2b9flvwwvkaJSU8YrCXuCpr+jbGsusJYoj7etKIwmQbgotoIAUsBSKpB
 XSgNrw7XNwBzM5U29iudmV86KOZnQE9Sd8o83OZohiurdQm50wsjbfhXnbhZoQYw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg7m2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:12:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66224jAc027839;
 Thu, 2 Jul 2026 02:12:26 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wa3y3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:12:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6622CP3R19006186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 02:12:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A68358053;
 Thu,  2 Jul 2026 02:12:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BBA158043;
 Thu,  2 Jul 2026 02:12:24 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 02:12:24 +0000 (GMT)
Message-ID: <0efd5c26-a660-4165-8f6f-30b2d4ffe96a@linux.ibm.com>
Date: Wed, 1 Jul 2026 22:12:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] pc-bios/s390-ccw/virtio.c: Fix missing break for
 PCI notifications
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com,
 farman@linux.ibm.com, nrb@linux.ibm.com
References: <20260630141917.673995-1-jrossi@linux.ibm.com>
 <20260630141917.673995-3-jrossi@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260630141917.673995-3-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a45c90b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=twGliZnIbIM6_6Ds3yIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfXx4ODGMhY38dR
 r+ZtorCEJR6gOo522Wcp+S+Ltw7Iw0wgdYxa2KIYSQuof2DC0LkRwuxZl0EnewNxBBmZWplYxkq
 ePcEDmIVcBpbZSNNPJZlyXVniOGYpHI=
X-Proofpoint-GUID: FFXvPiFFxQH-irAaZ2dgsZEgmjcBxCZd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfXwqAr9r1DCtN8
 8IVEuhz0s7XINV2EqAl26fm0B5ZY90lBvhAzIGMUVEnWyJGHNLn5IUpu9Bb5T3UjTCC1YZRZYDu
 bpWRV7TWGyBzYZmINLuKfxJqF/zsRKCQFKxX1Sg+xeSjLiOfbMEHZdQPNF1F7hXSmdpPv5joFrF
 1wdPf9+6j5EkqK/TsHLm7zVHcuD+M8EE/RXgGx71pDfwnf5Mp+hl4y8DYSa39zhQqSo+OZGtsd2
 Vd+Kzd1wdASletaUKcGNz0VEo/KvSUXvlLPuv+AN75xMPPmMyxuQ0B2GF4omMPQP2auxHMU54l5
 bdnDbkJnMIhZjUaNFOREcQ2UKpnliRupySYK0BsxJupT2kA+hNf9E9G8ezn+gxBel6yLkhMtf8O
 Dfc/xXtSgp1CFmLhXwZa1GSYKiRYf/wAU7+xoIItneufjtYnLm1xk7PseHxo6ae39xr8rOHhsG3
 tQ9YIlKxQQi3w6WigBw==
X-Proofpoint-ORIG-GUID: FFXvPiFFxQH-irAaZ2dgsZEgmjcBxCZd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020016
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

On 6/30/26 10:19 AM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Add a break after calling the PCI specific notification function instead of
> falling through to the default case.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

With fixes tag as pointed out by Eric:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



