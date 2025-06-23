Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF48C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 13:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThZQ-00072F-Ht; Mon, 23 Jun 2025 09:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1uThZN-00071j-Kx
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:50:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1uThZK-000637-9u
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:50:45 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NBMEqt007523;
 Mon, 23 Jun 2025 13:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=00rZ/v
 B+GiQOBvr+MCQoAA+AZOOxQtSQ34RvG4VCl9g=; b=UT1GezeMVM9LnPM0O92c1O
 5g60g8JPpRPNThFcuDMG5819NA1tdXZmQzrqNAOVILI6zc7aMqwvO36S0/1pi7nk
 QOm/faf4JymymZh+mrziJv59dJqW0C5HWMrlRKNAsX/yysYUlllHmJOlakS55hbW
 dFDOYoga0XxrbvC+xcve5hIdiFpxhgIFQyeF4o7aWpb8T1VgvbIc9UM/Bj5lkxOO
 lDWQ+Nzpd/9uPv2s4cYpSbx6il0kRsWmPKj5zTb3vNKjE2+u54CEjFtC9qB4r3jO
 JHNhALmBQGsJwwkpV1wE55niNt6urEq0LcwWgrJyR0DdmAqyzKOFsRNqiHQts4Uw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2t53e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 13:50:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55NDCqRU023145;
 Mon, 23 Jun 2025 13:50:35 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2t538-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 13:50:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCb9Vo014748;
 Mon, 23 Jun 2025 13:50:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s26q4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 13:50:34 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55NDoSD129753996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 13:50:28 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82D775805B;
 Mon, 23 Jun 2025 13:50:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51D2258055;
 Mon, 23 Jun 2025 13:50:32 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.77.138]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Jun 2025 13:50:32 +0000 (GMT)
Message-ID: <0a0ff51b023df5e627981225bf229b4de0f9112b.camel@linux.ibm.com>
Subject: Re: [PATCH V5 27/38] vfio/iommufd: add vfio_device_free_name
From: Eric Farman <farman@linux.ibm.com>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater	
 <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum	
 <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas	
 <farosas@suse.de>
Date: Mon, 23 Jun 2025 09:50:31 -0400
In-Reply-To: <1749569991-25171-28-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-28-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=68595bab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=SK52Fxje_ui11fC3wEIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4MiBTYWx0ZWRfX09lhJLmvEL3y
 9LiTkWdbK8Jkb7Jd7l02XOdyxZlfx5I1LkF82LFkyPfSYl7l5++Wm8SDYvWNHpw8gbuQj5Zi+Si
 INjQA02dZTVMYT43nfsUr40IqMU2yEgrd6K9pLV9tdTpw6FndgOjXygoH7UwvlEvpG+w+Wh/wMt
 HDbfFYSTg4l7THiNmCYPUxaFVA2fPjmQgTMPVG/H9qql9P6XkeyqQI5bTgymkQ65X6uWOqd03+D
 a7YH8ayq+ezuFua4nlw1aBQvsqKATpkcAXA2qz4kZ2XqsRSwzkJcuTT1/kt+iT9BQLj3LcGNC5p
 v69J25UuJkt4cct1tnHd0WXC83WqcZbADJ0uFea25xfIZBSzU9citya9rIdfmSU4ss2et7ZV8GY
 3mzNFdWwrLyIE4HPiETGulGRyU/YURT1pgUK8K9jqcDbWHALLRiDp0x1uxFq/NKldPK/fny8
X-Proofpoint-GUID: NxSbDFh3LBLaEtOHAzWZyF6t_4_jFxYv
X-Proofpoint-ORIG-GUID: 8rsiJx9_qIoXp7v9WFPLaGdyXfnfLsjl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230082
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

On Tue, 2025-06-10 at 08:39 -0700, Steve Sistare wrote:
> Define vfio_device_free_name to free the name created by
> vfio_device_get_name.  A subsequent patch will do more there.
> No functional change.
>=20
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/hw/vfio/vfio-device.h | 1 +
>  hw/vfio/ap.c                  | 2 +-
>  hw/vfio/ccw.c                 | 2 +-
>  hw/vfio/device.c              | 5 +++++
>  hw/vfio/pci.c                 | 2 +-
>  hw/vfio/platform.c            | 2 +-
>  6 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.=
h
> index 6eb6f21..321b442 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -227,6 +227,7 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, in=
t index,
> =20
>  /* Returns 0 on success, or a negative errno. */
>  bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
> +void vfio_device_free_name(VFIODevice *vbasedev);
>  void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **e=
rrp);
>  void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops=
,
>                        DeviceState *dev, bool ram_discard);
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 785c0a0..013bd59 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -180,7 +180,7 @@ static void vfio_ap_realize(DeviceState *dev, Error *=
*errp)
> =20
>  error:
>      error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
> -    g_free(vbasedev->name);
> +    vfio_device_free_name(vbasedev);
>  }
> =20
>  static void vfio_ap_unrealize(DeviceState *dev)

^^^
I suspect you want to convert the g_free call of the VFIODevice name here a=
s well.

> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index cea9d6e..903b8b0 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -619,7 +619,7 @@ out_io_notifier_err:
>  out_region_err:
>      vfio_device_detach(vbasedev);
>  out_attach_dev_err:
> -    g_free(vbasedev->name);
> +    vfio_device_free_name(vbasedev);
>  out_unrealize:
>      if (cdc->unrealize) {
>          cdc->unrealize(cdev);

Similarly, the matching g_free call in vfio_ccw_unrealize

Thanks,
Eric

