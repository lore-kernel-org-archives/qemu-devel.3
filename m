Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD291CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 16:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4MRw-0002Vc-JR; Thu, 02 Oct 2025 12:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1v4MRj-0002R0-0B; Thu, 02 Oct 2025 12:46:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1v4MRU-0003oF-Ob; Thu, 02 Oct 2025 12:46:19 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592DcqPu018505;
 Thu, 2 Oct 2025 16:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pbhKEa
 E1DBlDRKYZ27gq35MgCt3ia1W2prQ54VRuuz4=; b=iJJlSgvJZE0txa0d60CSr3
 hwQjVm+nIEE5/WOGu3+aBuUeQgF/fRi7rwfZjQOiQ9o0ZkNwA/s7/3eiuOzFk/i4
 WKucmJ7Z+ztl91g8HbqZLfVAeHYIx6/TB4Fup9sPxNNQz5ASCxMLpXwenTHWPJM5
 NXfvd4V9gfYDtUFzUed3VTbEqqreY/kgKcZUuDnwt8y6q7Jr+svThk08syqQxfr3
 ANH22HZUi1yU/rrJt8u2SS4TSPTOPXM1uBNnWyBEaU46H6aAn0uIrpCEGfXYveiZ
 da0xSIdIZUq+idchaa8Wo3F22m1bIcNM0XS/OjJaH9cjpFxoRBAGDdVL4wRSGgIQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bhwq5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 16:45:53 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 592GSKMD008352;
 Thu, 2 Oct 2025 16:45:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bhwq5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 16:45:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 592GIiGc003325;
 Thu, 2 Oct 2025 16:45:52 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmy721d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 16:45:52 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 592GjoDD30605892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Oct 2025 16:45:51 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D91095803F;
 Thu,  2 Oct 2025 16:45:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50E0958056;
 Thu,  2 Oct 2025 16:45:48 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.134.141]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Oct 2025 16:45:48 +0000 (GMT)
Message-ID: <387abc0573ed488798ec805451a5e7e6c79b9a0b.camel@linux.ibm.com>
Subject: Re: [PATCH v2 06/18] hw: Remove unnecessary 'system/ram_addr.h' header
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jagannathan Raman	
 <jag.raman@oracle.com>, qemu-ppc@nongnu.org, Ilya Leoshkevich
 <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Jason Herne
 <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater	 <clg@redhat.com>, kvm@vger.kernel.org,
 Christian Borntraeger	 <borntraeger@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Matthew Rosato	 <mjrosato@linux.ibm.com>, Paolo
 Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>, Richard Henderson	
 <richard.henderson@linaro.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 02 Oct 2025 12:45:47 -0400
In-Reply-To: <20251001175448.18933-7-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
 <20251001175448.18933-7-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68deac41 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=aGwGTAKf3ZeqeKgWoQ8A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX5K2/3oNHL62q
 mPnN8/B+etDF9KFrdn/UxXWqa+l73ypEUWjN4e3pwvRWAfgWeBH0u51VuWlp8uLlvA17M+YHyio
 iAENZpRMES16emUC23NDKzckmhhB/rLaTLynMQ/UaOPpOXCnCh+m1frDOedv7qHt/EQMq0/i7La
 HJkcAKi+laDJ4+JQlZD0cE+ukw078y7+UJV6xgVmdT5JrcnuaSA4tbiSCktG7c1DaoA+SeLeiQ/
 uiRYtdRBmbiMRdqRyV2ShF67XGzmUPx8FclcxIK3ANbAIsC0Qhl7SWlfEBBwBmmnwXmo0XUfOeu
 TxkS0gyoY3LOG2bpxJUFeMLBAG2OD3H7s8x7O/NowuJia7oaQ+DLSM/B6PhjEKFKAD7g/tjVt2V
 Hr/oDpywz0z6gJEAZxKbafXcoM14og==
X-Proofpoint-GUID: Ip_bUE8ZxJcETWq2tmqVsME2d70jhphX
X-Proofpoint-ORIG-GUID: dQR6yCoHl9AulGC0oIbXH9W_n3wmFPRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 2025-10-01 at 19:54 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> None of these files require definition exposed by "system/ram_addr.h",
> remove its inclusion.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/ppc/spapr.c                    | 1 -
>  hw/ppc/spapr_caps.c               | 1 -
>  hw/ppc/spapr_pci.c                | 1 -
>  hw/remote/memory.c                | 1 -
>  hw/remote/proxy-memory-listener.c | 1 -
>  hw/s390x/s390-virtio-ccw.c        | 1 -
>  hw/vfio/spapr.c                   | 1 -
>  hw/virtio/virtio-mem.c            | 1 -
>  8 files changed, 8 deletions(-)
>=20

...snip...

> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d0c6e80cb05..ad2c48188a8 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -13,7 +13,6 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "system/ram_addr.h"
>  #include "system/confidential-guest-support.h"
>  #include "hw/boards.h"
>  #include "hw/s390x/sclp.h"

This was added in 9138977b18 ("s390x/kvm: Configure page size after memory =
has actually been
initialized") for the purposes of calling qemu_getrampagesize(), but that g=
ot renamed and later
moved by c6cd30fead ("system: Declare qemu_[min/max]rampagesize() in 'syste=
m/hostmem.h'"). So I
agree this is no longer needed.

Reviewed-by: Eric Farman <farman@linux.ibm.com>  # s390

