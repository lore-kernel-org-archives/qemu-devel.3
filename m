Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09F0C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yqh-000844-GC; Wed, 16 Sep 2026 19:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yqY-00081z-MK; Wed, 16 Sep 2026 19:15:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yqX-0002cq-3o; Wed, 16 Sep 2026 19:15:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1u4k3041771; Wed, 16 Sep 2026 23:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dGctwv
 aUwA/t3s0uGuYh70gwFLjMBj99ozx417cKHUg=; b=s90mj4q5aIFyJh7fC7Ogy+
 MAPyhwyCEDG231ZXCfxc3RMkvc/0UnzJVN/8sEAYicJfW5U6/il6fGnsd2Fvh55N
 Te/IaOnOd0ijYWwhtVN9zUcZyi67Gq2ozCiSaR2Z/ndvRxrrIdMMFI7kHSebHQfc
 ugJ2IQQJQdgyjWALOllk+Di18s6pPBXYObp2GkDOrTm0jaaXk3unsrXhF/n8cNhE
 kpdiTEkqxn0nJ6bCHEeBQ6uRhlTWuw127HpW2D7TSvxR4+w6ILBqshpIfnvie6Y7
 xW7Y2qk5m0bfb83Kxh2MyfMquGmggDS6eR6wgR9q3gO/qYPCe2FIBxecKbq60UrA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e740x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:15:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GMqn7p1713205; Wed, 16 Sep 2026 23:15:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywf0wqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:15:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GNFHwx5243590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 23:15:17 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7377258052;
 Wed, 16 Sep 2026 23:15:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC98C58050;
 Wed, 16 Sep 2026 23:15:16 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2026 23:15:16 +0000 (GMT)
Message-ID: <f98c67a6-b5e7-48f8-a774-76b6617766bf@linux.ibm.com>
Date: Wed, 16 Sep 2026 19:15:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] virtio-ccw: Do not overwrite existing indicators
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-3-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260916203242.2509787-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX4XHSmA6GNbsF
 fnLRHC1uigJ1/4LIFo3DgT6x2f8ixb5mYHjzShLqPLgi1e74B9Ux1tWhJ2K/z0oBjyR3Fj7GM4X
 m0PBot1raqZPHStGdTya15fnAHs/d2t1IGVAMqjNr/YWQB3WppxEjWb9yBztccNwcAK/6Oz0mBh
 b4wgMduurOUOKE9VlLkmeE8uok6U/4EpRC8FcEo9Ny6/grG2m1RsPH3UJxRt86MVbZOpXXb4XFk
 E1ttEAtpiqCEPQbbnXJIPa9IntZhSqYMp6XyDMvBgUJK2kFGLH6XLR2f+oL9vIo8JohLx3Q02Tm
 jzWV3jd7LtxWOh3ZydTPp6s7e7BSNzPK6+ozUu2tyWtWFpk/frEDlviOEX2UlO8YVczygSNAN5A
 SCLkr9KfguEhcoGVwJ3zlgd5PjMiiLSHY0BCvVi7wH3lzl0+NbM3jnY2H6CJOzCh74Jyu8qHPWz
 Vp+sKUA8KfdgJI1yj/A==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aab2307 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=cEUPhHmS8o58IKH7ITkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PZV-Z3pUC6IVyxGWxGhoiFHaDVtj8Sbv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX6jBu+SYA3RO5
 wW7v56+IAZ8/JDSLC9WDAO93eB9IcE5eM1+nUgETmK5UX3YsphYZ+Hcv3xqzQD4gVRbqWviImpa
 Ysp0DXe2qhE1J7yWOk2jICfAnTkbMWg=
X-Proofpoint-GUID: PZV-Z3pUC6IVyxGWxGhoiFHaDVtj8Sbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160322
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 9/16/26 4:32 PM, Eric Farman wrote:
> The various indicators pointers allow them to be overwritten,
> but leak any existing structs that might be there. The adapter
> indicators path checks that it isn't converting from regular
> to thin interrupts, but a check in the reverse direction isn't
> performed.

guest-triggered memory leak = fixes/stable?

I think
7bca3892cb ("s390x/virtio-ccw: reference-counted indicators")
when we started doing dynamic allocation

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> 
> Rather than unwinding the existing allocations to allow additional
> assignments, just reject these duplicates.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  hw/s390x/virtio-ccw.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index eb6378ea4c..d700db405b 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -565,6 +565,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>              ret = -EINVAL;
>              break;
>          }
> +        if (dev->indicators) {
> +            /* Do not set without un-setting first */
> +            ret = -ENOSYS;
> +            break;
> +        }
>          if (sch->thinint_active) {
>              /* Trigger a command reject. */
>              ret = -ENOSYS;
> @@ -599,6 +604,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>              ret = -EINVAL;
>              break;
>          }
> +        if (dev->indicators2) {
> +            /* Do not set without un-setting first */
> +            ret = -ENOSYS;
> +            break;
> +        }
>          if (!ccw.cda) {
>              ret = -EFAULT;
>          } else {
> @@ -657,7 +667,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>          }
>          if (!ccw.cda) {
>              ret = -EFAULT;
> -        } else if (dev->indicators && !sch->thinint_active) {
> +        } else if (dev->indicators || dev->summary_indicator) {
>              /* Trigger a command reject. */
>              ret = -ENOSYS;
>          } else {


