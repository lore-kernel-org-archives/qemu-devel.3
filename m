Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081B3CEFD10
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 21:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdEHo-0000GJ-5z; Tue, 06 Jan 2026 16:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vdEHm-00007r-7B; Tue, 06 Jan 2026 16:08:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vdEHk-0005up-Km; Tue, 06 Jan 2026 16:08:13 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 606GtBuK031185;
 Tue, 6 Jan 2026 21:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EZZeVM
 t9LOfmZpl0Jl8DKA+mDEyifxkPWCAse4rws6w=; b=Dcts4LTxOyBF0wPdZdRxai
 5Ibjfplnp+LbxLReqXuCzS57Ak1zr6yA64YJZRUc4hehwJUwjZfr0U/PFYKDwzHu
 4Xb4wElYeEAQ08oCURiYmnyBeOh2F747nh5M/b1RkJwm/QNiIHxCdYh0qPOTmeVq
 KUdWzBF4lg/VS+NREJj5ilKNrIV6vI7//YZl3YrqcAUinr3y/c6LGh7giESWgi1a
 0v6TVC8Lfna2BiR/C0guMG2n1qJX0/DlUGfsWLuxoc4YsZ9jAkw193TaJ1ykFKu8
 e+I3vEFYOMFoDXr/0yqy9CJZOBMEdTv4Tiaiwo4XpKDt/CMHUXamE3o8M3MkTMlA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshew1ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 21:08:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 606IJoTv015239;
 Tue, 6 Jan 2026 21:08:10 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfdesdt54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 21:08:10 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 606L7oPL459414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jan 2026 21:07:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69E9058062;
 Tue,  6 Jan 2026 21:08:08 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A4835805C;
 Tue,  6 Jan 2026 21:08:07 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.132.176]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jan 2026 21:08:07 +0000 (GMT)
Message-ID: <ac99b6f13b11546d0162f86823d47130be3c69fd.camel@linux.ibm.com>
Subject: Re: [PATCH 02/10] pc-bios/s390-ccw: Store boot device type and bus
 separately
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Tue, 06 Jan 2026 16:08:06 -0500
In-Reply-To: <20251210205449.2783111-3-jrossi@linux.ibm.com>
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-3-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE4MCBTYWx0ZWRfX6jtkvO56wuD3
 H4AOhp7y8ssU5TcAbNGYkYjQNL69exfUp5XDvexjymeDYpcQIpkLs7GLx0CbypP+CTR8gKkd+zc
 nGu4MNPr8QXm3dTk5fdirPRYdTEoTPfJ2OIk9c+hl8OjzmUjYxKMWiMX25D097xzNKT1Z8/IyYz
 kI57I6UqggXY3C2qHMyZub3aK05F9SQyNEMKhDHeNb+aYu4CpyjWCKaCm0MUi3SUtihB3ZuChXD
 Je5PtLtwMlKpkKRFYjC1B42T7Mszy9LgP2X5KpX8GMIF8/0+leQ00U3BijjHOmIyIqEw3hk4iYI
 tHiyAF39r0w/iqU49H65DreZq2OzH3RUCmc4k4oGzev+EBqlsmrORICWjij4bP22h8gDjuMnDI4
 aPDy6cvEB0/kbJLadrRcv3zdvQRWAD+rEgtFFszzuizfPWCqU7QOHmiUa851i7W+Itm1kV2IFfA
 MxyJEarhbBFS2dLTimg==
X-Proofpoint-GUID: zkHoeOQKFWuIF7hXYlUqNXIr_b2eVK6w
X-Proofpoint-ORIG-GUID: zkHoeOQKFWuIF7hXYlUqNXIr_b2eVK6w
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=695d79bb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=MAE6n1c2_vcFmanA-goA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601060180
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

On Wed, 2025-12-10 at 15:54 -0500, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> Store both the device type (e.g. block) and device bus (e.g. CCW) to dete=
rmine
> IPL format rather than assume all devices can be identified by CCW specif=
ic
> sense data.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  hw/s390x/ipl.h                   |  5 ----
>  include/hw/s390x/ipl/qipl.h      |  7 ++++++
>  pc-bios/s390-ccw/iplb.h          |  4 ----
>  pc-bios/s390-ccw/virtio.h        |  2 ++
>  pc-bios/s390-ccw/main.c          | 10 +++++---
>  pc-bios/s390-ccw/virtio-blkdev.c | 39 +++++++++++++++++++-------------
>  pc-bios/s390-ccw/virtio.c        | 13 +++++++----
>  7 files changed, 48 insertions(+), 32 deletions(-)

I might've suggested that this be broken up even further, to distinguish be=
tween the vdev->ipl_type
(nee iplb.pbt) and the vdev->dev_type (nee vdev->senseid.cu_model) changes,=
 and maybe even the
consolidation of the S390_IPL_TYPE_* defines, to make it more obvious that =
things are just moving
around without any actual change. But, this is honestly fine.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

