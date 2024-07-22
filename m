Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C5DC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 17:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVx6f-00075R-SG; Mon, 22 Jul 2024 13:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1sVx6b-00073G-Nc; Mon, 22 Jul 2024 13:45:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1sVx6Z-0000nP-5p; Mon, 22 Jul 2024 13:45:49 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MFtYQ1006313;
 Mon, 22 Jul 2024 17:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 kX8Y4wB7WhBvAtXzGO6i88j2Gw6vScTBXVWpWRs1UKY=; b=X/XEkvJHHsIf9P6T
 kSl486JZ16kAC2GhI9fHFnk3mJA/gHdyZTpgmM72mVJunGra6xZ+L8bZowH1k6ne
 /2UpPL12gHIjVcEqqIlpJIBjMcnA5Vmv7aQ6j8W6jIks1j9NwMXB1npZylCgrKYT
 3OuT3IIgdNACOIb6F3rmyrS6fzWaJJkXVG6QOQp25MbUyc/zTgoE9XiE0rTw2jKr
 idD0Y+9zWmJtDEgvGNxx+I6dJpMI8IOTchrsM7uZWHd/bXkLYvL2IaLEdcU05Nxr
 Gxk8GruvkPAzXv8lkhx95YX7REv8k6D5y9+RtcamDMgZc/oXcF1zORgRcEBcQwg2
 8IEvoQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hkxm1a4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 17:45:42 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46MHjfIq006214;
 Mon, 22 Jul 2024 17:45:41 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hkxm1a47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 17:45:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46MFsjca007136; Mon, 22 Jul 2024 17:45:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gx72emt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 17:45:40 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46MHjcF418743808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 17:45:40 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DB075805D;
 Mon, 22 Jul 2024 17:45:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E42D85805C;
 Mon, 22 Jul 2024 17:45:36 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.147.234]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jul 2024 17:45:36 +0000 (GMT)
Message-ID: <21b3a584cf28e56a3436ae57548a7ea57869d855.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] vfio/ccw: Don't initialize HOST_IOMMU_DEVICE with mdev
From: Eric Farman <farman@linux.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com, 
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 qemu-devel@nongnu.org
Date: Mon, 22 Jul 2024 13:45:36 -0400
In-Reply-To: <4369ce16-0b40-4df3-8db0-276bb0887fa0@redhat.com>
References: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
 <20240722070713.1342711-3-zhenzhong.duan@intel.com>
 <40cf2370a1838b1aa1e9eb2cfc75a0543ceb45bd.camel@linux.ibm.com>
 <3072c39e-fd1b-4cc1-a189-2aa64a1d5984@oracle.com>
 <4369ce16-0b40-4df3-8db0-276bb0887fa0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y2_DeUmJ3pwDGxoSifjJtQeGDd3KokJu
X-Proofpoint-ORIG-GUID: D8oQmBdy7T1H-rX4BcqrZtY_vCdhG02p
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_11,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220130
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Mon, 2024-07-22 at 17:36 +0200, C=C3=A9dric Le Goater wrote:
> On 7/22/24 17:09, Joao Martins wrote:
> > On 22/07/2024 15:57, Eric Farman wrote:
> > > On Mon, 2024-07-22 at 15:07 +0800, Zhenzhong Duan wrote:
> > > > mdevs aren't "physical" devices and when asking for backing IOMMU i=
nfo,
> > > > it fails the entire provisioning of the guest. Fix that by setting
> > > > vbasedev->mdev true so skipping HostIOMMUDevice initialization in t=
he
> > > > presence of mdevs.
> > >=20
> > > Hmm, picking the two commits that Cedric mentioned in his cover-lette=
r reply [1] doesn't "fail the entire provisioning of the guest" for me.
> > >=20
> > > Applying this patch on top of that causes the call from vfio_attach_d=
evice() to hiod_legacy_vfio_realize() to be skipped, which seems odd. What =
am I missing?
> > >=20
> > > [1] https://lore.kernel.org/qemu-devel/4c9a184b-514c-4276-95ca-9ed866=
23b9a4@redhat.com/
> > >=20
> >=20
> > If you are using IOMMUFD
> >=20

Which is not the case in defconfig.

> >  it will fail the entire provisioning i.e. GET_HW_INFO
> > fails because there's no actual device/IOMMU you can probe hardware inf=
ormation
> > from and you can't start a guest. This happened at least for me in x86 =
vfio-pci
> > mdevs (or at least I reproduced it when trying to test mdev_tty)
> >=20
> > But if you don't support IOMMUFD, then it probably makes no difference =
as type1
> > doesn't do anything particularly special besides initializing some stat=
ic data.

This was my concern. The static data doesn't look particularly exciting, bu=
t it does seem strange to
be skipping over it in the non-iommufd case now.

> > The realize is skipped because you technically don't have a physical ho=
st IOMMU
> > directly behind the mdev, but rather some parent function related softw=
are
> > entity doing that for you.
> >=20
> > Zhengzhong noticed there were some other mdevs aside from vfio-pci and =
in an
> > attempt to prevent regression elsewhere it posted for the other mdevs i=
n qemu.
>=20
>=20
> yes. I confirm with :
>=20
>    -device vfio-ap,id=3Dhostdev0,sysfsdev=3D/sys/bus/mdev/devices/8eb8351=
a-e656-4187-b773-fea4e926310d,iommufd=3Diommufd0 \
>    -object iommufd,id=3Diommufd0 \
>    -trace 'iommufd*'
>=20
> iommufd_cdev_getfd  /dev/vfio/devices/vfio4 (fd=3D28)

Ah, right... Need to enable iommufd AND vfio_device_cdev to get into this p=
otential situation. I
guess this is better than random failures down the road.

Acked-by: Eric Farman <farman@linux.ibm.com>

> iommufd_backend_connect fd=3D27 owned=3D1 users=3D1
> iommufd_cdev_connect_and_bind  [iommufd=3D27] Successfully bound device 8=
eb8351a-e656-4187-b773-fea4e926310d (fd=3D28): output devid=3D1
> iommufd_backend_alloc_ioas  iommufd=3D27 ioas=3D2
> iommufd_cdev_alloc_ioas  [iommufd=3D27] new IOMMUFD container with ioasid=
=3D2
> iommufd_cdev_attach_ioas_hwpt  [iommufd=3D27] Successfully attached devic=
e 8eb8351a-e656-4187-b773-fea4e926310d (28) to id=3D2
> iommufd_backend_map_dma  iommufd=3D27 ioas=3D2 iova=3D0x0 size=3D0x200000=
000 addr=3D0x3fd9ff00000 readonly=3D0 (0)
> iommufd_cdev_device_info  8eb8351a-e656-4187-b773-fea4e926310d (28) num_i=
rqs=3D1 num_regions=3D0 flags=3D33
> iommufd_cdev_detach_ioas_hwpt  [iommufd=3D27] Successfully detached 8eb83=
51a-e656-4187-b773-fea4e926310d
> iommufd_backend_unmap_dma  iommufd=3D27 ioas=3D2 iova=3D0x0 size=3D0x2000=
00000 (0)
> iommufd_backend_free_id  iommufd=3D27 id=3D2 (0)
> iommufd_backend_disconnect fd=3D-1 users=3D0
>=20
> qemu-kvm: -device vfio-ap,id=3Dhostdev0,sysfsdev=3D/sys/bus/mdev/devices/=
8eb8351a-e656-4187-b773-fea4e926310d,iommufd=3Diommufd0: vfio 8eb8351a-e656=
-4187-b773-fea4e926310d: Failed to get hardware info: No such file or direc=
tory
>=20
>=20
>=20
> Thanks,
>=20
> C.
>=20
>=20


