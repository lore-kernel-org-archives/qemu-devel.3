Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F777EA811F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpocL-00044v-4N; Tue, 10 Feb 2026 09:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vpocI-00044c-Vf; Tue, 10 Feb 2026 09:21:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vpocH-00057i-Bk; Tue, 10 Feb 2026 09:21:26 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A1Kblw3125577; Tue, 10 Feb 2026 14:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MbLdJS
 Uc+hqlJ+InNu+lYPOB0bEml6bU4ICH1PM8LMo=; b=V/xdikhDkZw5H3Jk841Bew
 4EU5ELke1BKw0UkOknmkSdl+XiKbnoovLiYx6YkoasNCLnVqDQnvW66cH0oMUHw0
 BEzdkCkKZtulK0r9kjF3G11ZutAmqEVhAGXGeAiXSmnhjvSWs/RQC3wuRs+rrXDK
 OKcAWFrkUdS3ajHntMsWfpz1WRdDMomi4+YhT27MIi5pBwGG9M9rp7S9PuH0xHWw
 ExHOtYXYiQDUvVn7H//nBmrXNIkNfzudHlcO0upfMHRzzg/bY7M/q3CmWl1nIcJy
 9HaLjx7/Ke8dqJE435JqFMwLWUFZz9gToZ+WdCkyR15jwJdKO+//xhWk+omQVsSA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wtgab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 14:21:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AB5Pfn019221;
 Tue, 10 Feb 2026 14:21:21 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxk1e6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 14:21:21 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61AELIsZ63897976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 14:21:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C461058064;
 Tue, 10 Feb 2026 14:21:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 589D95805A;
 Tue, 10 Feb 2026 14:21:18 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.141.124]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 14:21:18 +0000 (GMT)
Message-ID: <00f6150820cbfde824d63692fa4da432876f1e75.camel@linux.ibm.com>
Subject: Re: [PATCH] prevent null pointer dereference during zpci hot unplug
From: Eric Farman <farman@linux.ibm.com>
To: Aby Sam Ross <abysamross@ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, Farhan Ali
 <alifm@linux.ibm.com>
Date: Tue, 10 Feb 2026 09:21:17 -0500
In-Reply-To: <20260210065214.2252464-1-abysamross@ibm.com>
References: <20260210065214.2252464-1-abysamross@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698b3ee2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=1tEiuOBBNEgsjyXeiRoA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: b7hpTWytSikq7jK7MYDAwXdesDMSP9Jc
X-Proofpoint-ORIG-GUID: b7hpTWytSikq7jK7MYDAwXdesDMSP9Jc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEyMCBTYWx0ZWRfX4JnxA57DK5T7
 5r9nZxA6lxd+70CdiP9KjAC1kT0XyDKBz+6VAUOTHNthgg4/39jebzO6exl+NeSnzAaZ+bL1FZV
 +CRTB2Fsv3Sxm0C05z7QsnWmABZpZKIm3hmk4hmLUUkhOnVA8Nt21xzfxA+58OhzrleDg8tqEVa
 /vm+zD6mF7yMqnSKWiLazx2KGcne6a184zr/kQJKtuRQ2u0WT0AqAJr/GWuQ52/BDoCR2V6wwVQ
 j/hNI74hhSX0w6z6RG/+NqkBh3xNLfTbhJ/IPR/yz7kF3etYSdsyc6ehj2ZPGjM+/7lEKRwFX6L
 JA/zCh67B9nRf/dkWIr+4CNs26DlHYvZ5eq0omZivZXV5i3B1ZbfqNPmwDy1u8Ft9b3WL+FilJO
 CO7qP7WGxM+UmlPsiJz/DvZ4fNUtsjqC8LIuLF6OFaAmUrpsDZteA7CBpGVyaujAZt+P22G8fxg
 sM5O+JT6AS99MJ3N4AQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100120
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

+cc Farhan, FYI

On Tue, 2026-02-10 at 01:52 -0500, Aby Sam Ross wrote:
> vfio-pci hostdev realize during zpci hot plug fails (in `vfio_pci_realize=
()`)
> if the vfio group file in `/dev/vfio/` lacks appropriate permissions and =
the
> hostdev[/properties] addition doesn't reach the point where it could be
> associated with previously added zpci device (in `s390_pcihost_plug()`).
> As a result, zpci iommu pointer remains null. The zpci hot unplug followi=
ng the
> failed hostdev addition assumes zpci iommu pointer was assigned and tries=
 to
> make use of it to end the dma count resulting in a null pointer dereferen=
ce.
> In the non-hotplug scenario, `qdev_unplug()` for the zpci device is not c=
alled
> after hostdev addition failure and this issue is not encountered.
>=20
> Fixes: 37fa32de7073

This is usually written as:

Fixes: 37fa32de7073 ("s390x/pci: Honor DMA limits set by vfio")

> Signed-off-by: Aby Sam Ross <abysamross@ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Eric Farman <farman@linux.ibm.com>

>=20
>=20
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index b438d63c44..3166b91c46 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1248,7 +1248,7 @@ static void s390_pcihost_unplug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>          pbdev->fid =3D 0;
>          QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
>          g_hash_table_remove(s->zpci_table, &pbdev->idx);
> -        if (pbdev->iommu->dma_limit) {
> +        if (pbdev->iommu && pbdev->iommu->dma_limit) {
>              s390_pci_end_dma_count(s, pbdev->iommu->dma_limit);
>          }
>          qdev_unrealize(dev);

