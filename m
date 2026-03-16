Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61931F53D69
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 15:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w29jx-0008Jz-HG; Mon, 16 Mar 2026 11:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1w29jj-0008Ia-5N; Mon, 16 Mar 2026 11:20:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1w29jh-0000yy-00; Mon, 16 Mar 2026 11:20:06 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62G7tEmq3113932; Mon, 16 Mar 2026 15:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6JdU6x
 tkY9nITSHQsJ/KCJBw8gz6IeYGP5k4UMXbC9w=; b=I0/J06BlvLKb7ziH72vypG
 TGMWwURIHukQVHEF69a4BBpUeSN+2R6yTxjsCD022SC773VIVqWKhooyB0heuDmP
 Z7Q/NAlxRLwdLlYRwx3eSbx5NNi7vV8byDxbGru4guATYRsg66T0As5A+Wv5IzTk
 LUsDBVD2Jtx52rYYCP0stGF6Ztd9Vjukj8cNJJExB4Asq4EFGI/K4055ebFigtOs
 jAVZ4DaOmR4mF6a6HM+oHmdwsGJRecFX8pblka961p7XoBHCGLBq8MLvcnUXZbq7
 iQdQ/tROSSwGvpbFflA+wuSzBBxBhgnKG2ZgE0mc3kWjJ8mGS8rzK3aZLstxaApg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs0g4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 15:20:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GAWmes028720;
 Mon, 16 Mar 2026 15:19:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk58ug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 15:19:59 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62GFJvKY37356240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2026 15:19:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6706958056;
 Mon, 16 Mar 2026 15:19:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FC235805E;
 Mon, 16 Mar 2026 15:19:56 +0000 (GMT)
Received: from [9.61.145.197] (unknown [9.61.145.197])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Mar 2026 15:19:56 +0000 (GMT)
Message-ID: <7d9cd1af-dceb-4cae-bddf-c4c48d5aeacc@linux.ibm.com>
Date: Mon, 16 Mar 2026 11:19:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] util/event_notifier: fix error handling for
 event_notifier_init callers
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "open list:vfio-ap" <qemu-s390x@nongnu.org>
References: <20260311183432.214960-1-viking4@gmail.com>
 <20260311183432.214960-4-viking4@gmail.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260311183432.214960-4-viking4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b81fa0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=vFS0-BjGtX1mcMrYKmcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: s5uf-4WCMYcaC91Fs3RaXJLUwV6yTgnW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExNCBTYWx0ZWRfX1npwnocY3peg
 vvBmWPSiUhOi1rN4aSpMF03609qBvpWzvv2MOl1uWRQrA29LxSBHgQVnKyoqebd3WGD/9b9dKh/
 Woz9PXs/p6QcKE9RAVdzt5otn1ETtWWuVMMm6O2WodHDxIAAXbaVu9sLdCZ8lelix7KkssE8oJE
 ocnD/Sdi1za89eBWDhOGJCbxORNMj2e/KiwbGlfWgg880DXWZImupltSyqdyQ0DBC3HWu9FzW8a
 z8r3/bvEakk45zfZX+ZwUnCglK1QHTCTcPBHN/WDbmYtjuitLayFAbbsatrnxmNtGDxYcqRA3ab
 nOkjoJP2A4Sw6fEsAROQ3wntVd5RQxNbDBHkAtCSSH82j98O1vLa4uFg6NE+ZjKbc6qNoA2dRGq
 vplgNVD1Nul47Hkj9gn1cjThLctwrb3Y+2F+JW2edB5Eg1BNrCRP/MGRyxYRiq/xsUPEjAHTH30
 WQBMvWFevnGQGhR/K3A==
X-Proofpoint-GUID: 54c_ZAH88pvGg0hRd5KuKOqoiEBYgg0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160114
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On 3/11/26 2:34 PM, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
> 
> Check return value of event_notifier_init() and return early on
> failure instead of continuing with invalid state.
> - Use ret < 0 to handle negative return value.
> - No functional changes.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> Acked-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  hw/hyperv/hyperv.c     |  4 ++--
>  hw/hyperv/vmbus.c      |  4 ++--
>  hw/remote/proxy.c      | 15 +++++++++++++--
>  hw/vfio/ap.c           |  2 +-
>  hw/vfio/ccw.c          |  2 +-
>  hw/vfio/pci-quirks.c   |  2 +-
>  hw/vfio/pci.c          |  2 +-
>  hw/virtio/vhost-vdpa.c |  4 ++--
>  8 files changed, 23 insertions(+), 12 deletions(-)
> 

[...]

>      memset(&msg, 0, sizeof(MPQemuMsg));
>      msg.cmd = MPQEMU_CMD_SET_IRQFD;
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index e58a0169af..5c8f305653 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -180,7 +180,7 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>          return false;
>      }
>  
> -    if (event_notifier_init(notifier, 0)) {
> +    if (event_notifier_init(notifier, 0) < 0) {
>          error_setg_errno(errp, errno,
>                           "vfio: Unable to init event notifier for irq (%d)",
>                           irq);
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 2251facb35..ce9c014e6a 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -418,7 +418,7 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>          return false;
>      }
>  
> -    if (event_notifier_init(notifier, 0)) {
> +    if (event_notifier_init(notifier, 0) < 0) {
>          error_setg_errno(errp, errno,
>                           "vfio: Unable to init event notifier for irq (%d)",
>                           irq);

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



