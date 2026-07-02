Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C931C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 01:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf6YG-000529-Bv; Wed, 01 Jul 2026 21:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf6YD-00050v-WF; Wed, 01 Jul 2026 21:49:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf6YC-0005dA-H9; Wed, 01 Jul 2026 21:49:13 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KivN2390598; Thu, 2 Jul 2026 01:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=be11Vz
 /4Tj4N6AhiTPrAi/DkxTigmEZL20wDEzzXOys=; b=cCG9I2tnPQ4fAGmqboHnJt
 4Z+EIKAuPY2MElWheOAQGXeB4FXlzaBsFweJ4YrlPFJlctzCFuZJ+uN0tR9KDJw4
 43sQKO5fP2E1sGjiZygjXZyi/pArUjvo1IDL8NSRRqQn2WtzlJ0igawXHv5KOs3N
 FrVT2uvnkhyeAsUjgNYex+R+hqKfCBZroSKk/+0usvaFU6tWJvG6KdwxA4kg5Ui4
 03RBwR+nKYjm7vDbDF4MQiv6pdGurm+DyO2HiHV5A0ACrvL6IxwYd0eODR5IBCyx
 Kgp31/lNsBNUgFK6CNkcq1pWjq6l+Lw4Zu4LAZtg1xwFsrIr3R2fDr7TH4dddTqw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa76ve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:49:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6621Yfs7025758;
 Thu, 2 Jul 2026 01:49:10 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk9xy9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:49:10 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6621n9sK26018490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 01:49:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C64C58059;
 Thu,  2 Jul 2026 01:49:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C80EF58058;
 Thu,  2 Jul 2026 01:49:07 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.136.69]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 01:49:07 +0000 (GMT)
Message-ID: <d52bc6d7e5f763e64bc4c5db6d43928223174c53.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/6] pc-bios/s390-ccw: Add per-queue notification
 offset for multi-queue virtio configurations
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com,
 nrb@linux.ibm.com
Date: Wed, 01 Jul 2026 21:49:07 -0400
In-Reply-To: <20260630141917.673995-4-jrossi@linux.ibm.com>
References: <20260630141917.673995-1-jrossi@linux.ibm.com>
 <20260630141917.673995-4-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfX/zOdoJhChZZb
 ej3xb3nUVTppbgo0kwqAHkOcoFoJB8rGfSLFZT2zcH6dsw7FGeUrdURbwMUOCuabL5bW1EnQqgq
 lqBhD3RTwmn6DmdbHV8DsVbBTH7jo+DRN0vE/d2O0/AoE96MfRXsmYYqrXp1Qa55OX0zEW+KawL
 g5cNY9kMIQLLb3AZSZRpiErX/jtyFijd/EQ1Z3s/QyzkRWvnksu5Um8z8LVXgJYam2KkgguBeMD
 0YxqxSek2jN/IIdlZUxZDDn2p/AY4nFjXTVQfM+a5jMfEcPvc5rwntzEYZqB3UgeCnrnq11Pdaa
 y+QrnhJpOBGjUHM5UMVh/gpxOjKWcwLxqy4chqw5NCOUFwdzcXTtPB5xMezjr8RESRs5Y3mvbAG
 RM4Lao9Juh65ysFiR+CfJF2xbzZX6vxuWUY8iI8IimPphewdMQIqnQ1q/0SoMNNAPvfWEdyMTLl
 S5wYLo0W2YJ8Yc9Qt1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfX9WneEMd5SNCa
 XCK06h7Wl/qV7+gY8oQbYBVKo8K5JiOOVsSJ7O6ybAIySelvwNBXHhKu8SRjThN+61h+yK5U/Os
 6tqIJYwVgnI6agn0z7HwE/gkickI1Yw=
X-Proofpoint-GUID: dJn7si8zr7UreudaYZHqhmr0JeUiUiEv
X-Proofpoint-ORIG-GUID: dJn7si8zr7UreudaYZHqhmr0JeUiUiEv
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a45c397 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=kOaQzcC4gn6ku6mWJeYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020016
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2026-06-30 at 10:19 -0400, jrossi@linux.ibm.com wrote:
> From: Zhuoying Cai <zycai@linux.ibm.com>
>=20
> The initial support for virtio-blk-pci IPL devices used a single virt-que=
ue, but
> other device types require multiple queues, and for PCI device types this=
 also
> requires a per-queue notification offset.
>=20
> Add a PCI notify field to the VRing struct so that each queue has a uniqu=
e
> notify offset as defined in the virtio spec.
>=20
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/virtio-pci.c | 38 +++++++++++++++++++++--------------
>  pc-bios/s390-ccw/virtio-pci.h |  2 +-
>  pc-bios/s390-ccw/virtio.c     |  2 +-
>  pc-bios/s390-ccw/virtio.h     |  1 +
>  4 files changed, 26 insertions(+), 17 deletions(-)

Thank you for pulling out the bugfix from this patch. This still looks good=
.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

