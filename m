Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D616EA8127
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpp8o-0005k8-0M; Tue, 10 Feb 2026 09:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vpp8m-0005jY-L4; Tue, 10 Feb 2026 09:55:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vpp8k-0004LC-OM; Tue, 10 Feb 2026 09:55:00 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A21Nfg3344155; Tue, 10 Feb 2026 14:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gHUoZt
 tWxSEUQNz+dUS7dZSKOv5+a2RExS0mTiY2WX0=; b=VreDOT1idRDaA7bfh9pTXy
 vyjgr0QuK+LHydREZ2Gir2g+GAb4yfNIFM9ZzlI4GvNWE/gm0SyWXC96Crmdx0nU
 zVd7SwM/ESSOeBQP9bY765jcLyXctA/U3cskZW631sJO2zhh3Jb3AQ6gdVfDmiUc
 5lwZUK8LrDxqvzUF3pnBudHIPgjSakRNJKpBG9r0ozpTvJ44dTzofUbXe4W/EXoY
 KO9UBSpTdz2s/8u8TAJuzf+GHiRbacDOghK9sqms+rZRN/9aY3Mbn99kX3pdsGTr
 eBlaxt7P5kgtP2AIwPO1bizgq2te+bxXi3/7H0B7qDz8GtsvCikUX+tEekqazlRw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696utm5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 14:54:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AAWHoV013013;
 Tue, 10 Feb 2026 14:54:55 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7k9m7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 14:54:55 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61AEsqs915008510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 14:54:53 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DE9E5806A;
 Tue, 10 Feb 2026 14:54:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18A3558066;
 Tue, 10 Feb 2026 14:54:52 +0000 (GMT)
Received: from [9.61.181.57] (unknown [9.61.181.57])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 14:54:51 +0000 (GMT)
Message-ID: <c63fddd6-a6de-4ebe-a852-054efc7665cb@linux.ibm.com>
Date: Tue, 10 Feb 2026 09:54:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] prevent null pointer dereference during zpci hot unplug
To: Aby Sam Ross <abysamross@ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, farman@linux.ibm.com
References: <20260210065214.2252464-1-abysamross@ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260210065214.2252464-1-abysamross@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEyNSBTYWx0ZWRfX4IaEelnllHOw
 Ucsh7cIS+EuCRHLq/QfWk/pCCgihEeQBFc7jYd4nESf/miyEYTgcUCRnMdENSuBsBXLL92c02gS
 dBnf5OpKDv9GbvV1sgu7qOUy2NC3+BxC4drJT/5udgXy4gqtCa3fl1bHlNPYWxJ+wjGcI7mkKjK
 Rp/43Kq0z3Kb/3WeuymdrTVgmGoVCniMQhtVHWoqFE0hT6qACfGsJLIgAY3x/gVejXSnfaZurF2
 U5T+r1v/SS/9H5iCUv14hwpZ+xH4CfZApJPlOSJlVM+p0b6/1wpQLy/CJzwJ1/jy8oER/5ziIqx
 fZJ5lyWmIgUz1a2FeENtu6SD7SZLrHdKSMG5fIwo38moLyT0sRxRf2zmATNWcTBoDeTY9fVl2YM
 Itan9gSlxiOQepAi4pI0iOiShm1xKSqdoVRgK9TZNZmdR+yphGgGblDz4S2IOFdu7UYHREzLEHN
 B8rgo2rnNKkujjeuEzw==
X-Proofpoint-ORIG-GUID: DTKlctiK5KM5EgLjz2YmB4GY4xfv_zzL
X-Proofpoint-GUID: DTKlctiK5KM5EgLjz2YmB4GY4xfv_zzL
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698b46bf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=W8kXh9nesr2d972dOLkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100125
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/10/26 1:52 AM, Aby Sam Ross wrote:
> vfio-pci hostdev realize during zpci hot plug fails (in `vfio_pci_realize()`)
> if the vfio group file in `/dev/vfio/` lacks appropriate permissions and the
> hostdev[/properties] addition doesn't reach the point where it could be
> associated with previously added zpci device (in `s390_pcihost_plug()`).
> As a result, zpci iommu pointer remains null. The zpci hot unplug following the
> failed hostdev addition assumes zpci iommu pointer was assigned and tries to
> make use of it to end the dma count resulting in a null pointer dereference.
> In the non-hotplug scenario, `qdev_unplug()` for the zpci device is not called
> after hostdev addition failure and this issue is not encountered.
> 
> Fixes: 37fa32de7073

Fixes: 37fa32de70 ("s390x/pci: Honor DMA limits set by vfio")

> Signed-off-by: Aby Sam Ross <abysamross@ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index b438d63c44..3166b91c46 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1248,7 +1248,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          pbdev->fid = 0;
>          QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
>          g_hash_table_remove(s->zpci_table, &pbdev->idx);
> -        if (pbdev->iommu->dma_limit) {
> +        if (pbdev->iommu && pbdev->iommu->dma_limit) {

Looks reasonable.  I also reproduced with a quick chmod against /dev/vfio/vfio.  I also verified coldplug is unaffected as you described.

I took a look at other instances where we use pbdev->iommu without checking for non-null and AFAICT these are all otherwise after the device would be plugged and thus pbdev->iommu would be valid.

So, while updating that fixes tag feel free to add:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Thanks! 

