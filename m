Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A681C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVuU2-0006Je-Ih; Mon, 22 Jul 2024 10:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1sVuTs-0006G3-BX; Mon, 22 Jul 2024 10:57:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1sVuTq-0002TZ-H2; Mon, 22 Jul 2024 10:57:40 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MDdhpn012728;
 Mon, 22 Jul 2024 14:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 U+li4814Q9tCvcATyXlLiN6X75BCNwmJCNROeIUF478=; b=oxNhBg9G6+xmdDhX
 fggPUc+HjAlK9I2oD8NnZz/ICXAaVn+C88R8mVCP28E9EQUVFhSqp/oguVtMhOjj
 os7nhV2/VzNstgMSaBYFY8hyz5AomY2jppw/AVpW63AnKFnvMgsSaNc87SuQbF5z
 6hMS4xFDaxHFGHWJezqK1Q9TW2x6Dn/knMQc5g9O0k+OYLKBTNS1KyhdvVrmSqtJ
 S5v6ro/PCQ9N/VXHGqWAU2WUFhCiOD0BQD3dUqd78BYA31SCRK2Sy5GmUoDPnsh3
 NPT7IQT7PHJXKeFh84v3HRistJ2lmJWceBgD5widDOxHqZtvo6rnt6O3/7q/kd3M
 gdHiPQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40gpxhbaaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 14:57:33 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46MEvXLV032628;
 Mon, 22 Jul 2024 14:57:33 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40gpxhbaag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 14:57:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46MCGRFa007099; Mon, 22 Jul 2024 14:57:32 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gx72dx6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 14:57:32 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46MEvTqO14352946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 14:57:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EA9D58055;
 Mon, 22 Jul 2024 14:57:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB69858061;
 Mon, 22 Jul 2024 14:57:28 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.147.234]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jul 2024 14:57:28 +0000 (GMT)
Message-ID: <40cf2370a1838b1aa1e9eb2cfc75a0543ceb45bd.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] vfio/ccw: Don't initialize HOST_IOMMU_DEVICE with mdev
From: Eric Farman <farman@linux.ibm.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, chao.p.peng@intel.com, Thomas Huth
 <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, "open
 list:S390 general arch..." <qemu-s390x@nongnu.org>
Date: Mon, 22 Jul 2024 10:57:28 -0400
In-Reply-To: <20240722070713.1342711-3-zhenzhong.duan@intel.com>
References: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
 <20240722070713.1342711-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WiS15as8IekzDVB7Bs2plpRM5mw9zzXF
X-Proofpoint-GUID: 1pwDMugAvwBohLEG1Yw7GE3jHpQJj0Kk
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 phishscore=0 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220112
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 2024-07-22 at 15:07 +0800, Zhenzhong Duan wrote:
> mdevs aren't "physical" devices and when asking for backing IOMMU info,
> it fails the entire provisioning of the guest. Fix that by setting
> vbasedev->mdev true so skipping HostIOMMUDevice initialization in the
> presence of mdevs.

Hmm, picking the two commits that Cedric mentioned in his cover-letter repl=
y [1] doesn't "fail the entire provisioning of the guest" for me.

Applying this patch on top of that causes the call from vfio_attach_device(=
) to hiod_legacy_vfio_realize() to be skipped, which seems odd. What am I m=
issing?

[1] https://lore.kernel.org/qemu-devel/4c9a184b-514c-4276-95ca-9ed86623b9a4=
@redhat.com/

>=20
> Fixes: 930589520128 ("vfio/iommufd: Implement HostIOMMUDeviceClass::reali=
ze() handler")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/ccw.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 1f8e1272c7..70934b01d5 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -675,6 +675,9 @@ static void vfio_ccw_instance_init(Object *obj)
>      VFIOCCWDevice *vcdev =3D VFIO_CCW(obj);
>      VFIODevice *vbasedev =3D &vcdev->vdev;
> =20
> +    /* CCW device is mdev type device */
> +    vbasedev->mdev =3D true;
> +
>      /*
>       * All vfio-ccw devices are believed to operate in a way compatible =
with
>       * discarding of memory in RAM blocks, ie. pages pinned in the host =
are


