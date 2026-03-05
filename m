Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201AEF3D311
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 15:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyArA-0004lI-GC; Thu, 05 Mar 2026 10:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vyAr9-0004jy-6J; Thu, 05 Mar 2026 10:43:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vyAr7-0007YO-2m; Thu, 05 Mar 2026 10:43:18 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 625C7kxv719151; Thu, 5 Mar 2026 15:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SUx2q5
 cuA+AR253asGwh4fLaNOLidWmONrnXgnR1q2U=; b=AHKkOrWAYheOTZyVNzM7Sl
 cwjYZ6PRxTISK9U/sTwXcnaTac22rFMFRobpgD6FnLU2E51Gige8J615xlePy3pm
 aXDEc1xW6pgAT+oGDVDIxdNzNNag+8yCGOxk58vIa1FGcRioGsj5N9vKxcvl2oyd
 l5j06LBQ9QJOAP0TYtDIGTfiYYHkg7wUK4XMSuNpM36TGwYvYRnQu9eVz2TU5t3R
 remk5F8e6iRsEu0jFWbw8KGEhy7v7BsZflBRFW8xjJqksB+GpFIWubpisuA3wLo8
 cWqMzQaxpa4PX96mrw+bm8GKNCCs8PcTjh7mQJCSOiTw561UnGU2Fmsmwju21rbA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk43x6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 15:43:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625DYXfL011312;
 Thu, 5 Mar 2026 15:43:13 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cqau2rea2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 15:43:13 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 625FhC7U33358382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2026 15:43:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 632775805A;
 Thu,  5 Mar 2026 15:43:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B910358051;
 Thu,  5 Mar 2026 15:43:11 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.48.183]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2026 15:43:11 +0000 (GMT)
Message-ID: <265b8dd6833cfcafe2c9f338d1b64fe92d12a1ac.camel@linux.ibm.com>
Subject: Re: [PATCH v4 06/15] pc-bios/s390-ccw: Split virtio-ccw and generic
 virtio
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Thu, 05 Mar 2026 10:43:11 -0500
In-Reply-To: <20260304025917.2157032-7-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
 <20260304025917.2157032-7-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ih75B_9istnYcUXQnAz6_TgiAFippyQr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEyNSBTYWx0ZWRfX84WsW/CUoC9g
 5rS0tQzb3BTnr3BcBSRXEQOzLC4bCmMM6s4Cy0KjE4E66i10KpQJLskbm/k3W8ZDqrwuCp+OSR9
 1Zj9spyOU0Fv3B/AXhu5qd6gsqPmjkOdniYABO9WWcjTBmkgRfgNTxklSXf9wilNmhxrxx0suDu
 l6VBFUpc7f/TnAzXv0AFh6si1YluteUDe0YYlqM8Z1b+vfmmUpWYIsYpD54hi9Bs5cXvZyaO4Bx
 ZpS8gK+5bZOZnDbHdjcmMEa54OU7z/0kXNNEeFm93IFxc4wCyUH67Bez7zqtX94E9D1gAsTagri
 vmD07gCDeoc3ie+LNVlbiNO9tzCOk1tZMffy40URYeeSGww5CE3/6fKa9V/XUTkNYrRBYvlW/e5
 EUIjZstmr31j3m/ZGo1cWT3D66Lrx1Gyf/T/2nh0JUwNKwmUjeGOm0RvtOyonFIF/XL0HzD55ln
 4A8DCmK/6ObSXc4q0nw==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a9a492 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=tD79u1zcvAXxATHVNrEA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ih75B_9istnYcUXQnAz6_TgiAFippyQr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

On Tue, 2026-03-03 at 21:59 -0500, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> Separate the CCW specific virtio routines and create generic wrappers for=
 easier
> reuse of existing virtio functions with non-CCW devices.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile        |   3 +-
>  pc-bios/s390-ccw/main.c          |   8 +-
>  pc-bios/s390-ccw/netmain.c       |   2 +-
>  pc-bios/s390-ccw/s390-ccw.h      |   3 -
>  pc-bios/s390-ccw/virtio-blkdev.c |  15 +-
>  pc-bios/s390-ccw/virtio-ccw.c    | 241 +++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio-ccw.h    |  24 +++
>  pc-bios/s390-ccw/virtio-net.c    |   3 +-
>  pc-bios/s390-ccw/virtio-scsi.c   |   8 +-
>  pc-bios/s390-ccw/virtio-scsi.h   |   2 +-
>  pc-bios/s390-ccw/virtio.c        | 239 +++++-------------------------
>  pc-bios/s390-ccw/virtio.h        |   5 +-
>  12 files changed, 332 insertions(+), 221 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/virtio-ccw.c
>  create mode 100644 pc-bios/s390-ccw/virtio-ccw.h

This is some good untangling!

Reviewed-by: Eric Farman <farman@linux.ibm.com>

