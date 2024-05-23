Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D536C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 20:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAF2B-00084L-7L; Thu, 23 May 2024 16:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1sAF27-00083w-FY; Thu, 23 May 2024 16:27:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1sAF25-0004Nc-8I; Thu, 23 May 2024 16:27:27 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44NJWOS4031842; Thu, 23 May 2024 20:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/Q8Nh63N/IYGPOKYt8JILleTYmS1pjj/9hzhLTNjT5w=;
 b=hYV98WSRcCqu7RrBrk5QMHyOpAmQdDdjR8boP2Epxkt3eg4avPMdoyI+loGinybYHlL+
 YocbUoMR6xQZyiWs5UVc5osMMsoMNwdeqHMAaVYO/Jc/lhgQjrhvfKPBv0G+ibTCaDcy
 moMmivnykMiL8GZ85LiWTlJOsUBAadOo4fYgvIgX317N1wPv6ZmDkzlOQ+EFqcHblp4o
 l/cAre40tZVgN9JeK37rJMwh+b1wfvJoygDSeCM8ATWUiNcZCe6LFSU4mMj/qWuMsVvQ
 eyBMXpTG41xC5NfZdNwlBjTKRyKrnjiG61MzL8ABLM0+l6sRthMUvGXsiNyPX6lh1FnV wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yac1t84uh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 20:27:19 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44NKRJQR019703;
 Thu, 23 May 2024 20:27:19 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yac1t84ud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 20:27:19 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44NJ8MvW008123; Thu, 23 May 2024 20:27:18 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y78vmbsne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 20:27:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44NKREkh38142622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 May 2024 20:27:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACC2D58058;
 Thu, 23 May 2024 20:27:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE5B85806C;
 Thu, 23 May 2024 20:27:13 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.136.97]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 May 2024 20:27:13 +0000 (GMT)
Message-ID: <3fee9207627da81707bc8feecc9c611c545ce690.camel@linux.ibm.com>
Subject: Re: [PATCH 0/7] s390x/ccw: Error reporting cleanups
From: Eric Farman <farman@linux.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Tony
 Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 23 May 2024 16:27:13 -0400
In-Reply-To: <20240522170107.289532-1-clg@redhat.com>
References: <20240522170107.289532-1-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wnaSmWAViqQTrmpgcVOgH03e_oVlJmiC
X-Proofpoint-ORIG-GUID: 89TDCLtSZHYbKX4CRBqDAGi-fgwMZvWF
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_11,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 mlxlogscore=788
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230141
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

On Wed, 2024-05-22 at 19:01 +0200, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> The first patches of this series simply apply the practices described
> in the Rules section of the qapi/error.h file for routines taking an
> 'Error **' argument. The remaining patches are a fixup in the error
> path of vfio_ccw_realize() and some error reporting adjustements.
>=20
> Applies on top of this vfio PR :
>=20
> =C2=A0
> https://lore.kernel.org/qemu-devel/20240522095442.195243-1-clg@redhat.com
>=20
> Thanks,
>=20
> C.
>=20
> C=C3=A9dric Le Goater (6):
> =C2=A0 hw/s390x/ccw: Make s390_ccw_get_dev_info() return a bool
> =C2=A0 s390x/css: Make CCWDeviceClass::realize return bool
> =C2=A0 hw/s390x/ccw: Remove local Error variable from s390_ccw_realize()
> =C2=A0 s390x/css: Make S390CCWDeviceClass::realize return bool
> =C2=A0 vfio/ccw: Use the 'Error **errp' argument of vfio_ccw_realize()
> =C2=A0 vfio/{ap,ccw}: Use warn_report_err() for IRQ notifier registration
> =C2=A0=C2=A0=C2=A0 errors
>=20
> Zhenzhong Duan (1):
> =C2=A0 vfio/ccw: Fix the missed unrealize() call in error path
>=20
> =C2=A0hw/s390x/ccw-device.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2=
 +-
> =C2=A0include/hw/s390x/s390-ccw.h |=C2=A0 2 +-
> =C2=A0hw/s390x/ccw-device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3=
 ++-
> =C2=A0hw/s390x/s390-ccw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 29 +++++++++++++----------------
> =C2=A0hw/vfio/ap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0hw/vfio/ccw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++++++++----------
> =C2=A06 files changed, 26 insertions(+), 30 deletions(-)
>=20

Reviewed-by: Eric Farman <farman@linux.ibm.com>

