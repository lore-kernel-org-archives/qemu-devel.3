Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3CDC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 20:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKlEX-0004Ip-2Y; Fri, 21 Jun 2024 16:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1sKlER-0004Fh-7T; Fri, 21 Jun 2024 16:51:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1sKlEO-0000xI-Le; Fri, 21 Jun 2024 16:51:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LKcj2O011188;
 Fri, 21 Jun 2024 20:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 xsZDQufO58cand+4TLMk1TqP2vks7At3YTSaG6dr5K0=; b=O/JCYJsiHlD47HtI
 cj2ITYaDfnJ5aL2jrjVYtTfKFAOwLdHUSMKkkZASTHDc20yunzOIjbDJPhvZoAfY
 8Yl3r+QZ+X/g+uUpkDaG+Do4AVBv2sj8DihNv72k4nM8IAW9y1sQt3f+msTiWq8/
 1JZ15qvxzKl89aS/z0zXApLRBdwdH56a/WWR4NLnGWwYHCK3KNg8Z21Hl9eta8qA
 imnvoe4XEQ4o3O7100WoRRWrNJMdQSn4klWoNyd7kYgPJp0B5cDuVnwcq7zz90+M
 qhG81R4O86EgOwFYtxOFTAGI4osSKMqTyX8fRZIiE1zG2MWlskaXWiSekFLX6JcM
 ctjT2g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywgr200ns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 20:51:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45LKpXRL000923;
 Fri, 21 Jun 2024 20:51:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywgr200np-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 20:51:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45LJABrX019980; Fri, 21 Jun 2024 20:51:32 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrqus7uv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 20:51:32 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45LKpTsX15270606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2024 20:51:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAEC558050;
 Fri, 21 Jun 2024 20:51:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 808E058045;
 Fri, 21 Jun 2024 20:51:28 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.38.232]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Jun 2024 20:51:28 +0000 (GMT)
Message-ID: <a3531d21082e3abf3132a4c95d6c54e8973dd27e.camel@linux.ibm.com>
Subject: Re: [PATCH 0/7] pc-bios/s390-ccw: Merge the netboot loader into
 s390-ccw.img
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Collin L . Walling" <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Jason J .
 Herne" <jjherne@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Date: Fri, 21 Jun 2024 16:51:28 -0400
In-Reply-To: <20240621082422.136217-1-thuth@redhat.com>
References: <20240621082422.136217-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WX_ehhxyJtDvIjzy-e09p-gv3C6PiAd4
X-Proofpoint-ORIG-GUID: _fLu4hvfP_N3qP6cKYAjZyomUQEuCKB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_12,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=342 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406210149
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Fri, 2024-06-21 at 10:24 +0200, Thomas Huth wrote:
> We originally built a separate binary for the netboot code since it
> was considered as experimental and we could not be sure that the
> necessary SLOF module had been checked out. Time passed, the netboot
> code proved its usefulness, and the build system nowadays makes sure
> that the SLOF module is checked out if you have a s390x compiler
> available
> for building the s390-ccw bios. In fact, the possibility to build the
> s390-ccw.img without s390-netboot.img has been removed in commit
> bf6903f6944f ("pc-bios/s390-ccw: always build network bootloader")
> already.
>=20
> So it does not make too much sense anymore to keep the netboot code
> in a separate binary. To make it easier to support a more flexible
> boot process soon that supports more than one boot device via the
> bootindex properties, let's finally merge the netboot code into the
> main s390-ccw.img binary now.

Hi Thomas,

I find myself wondering about the side effects of the
s/sclp_print/printf/ changes, but I haven't come up with anything I can
put my finger on. Maybe something will come to me over the weekend, but
all-in-all I like the looks of this. So, FWIW:

Reviewed-by: Eric Farman <farman@linux.ibm.com>

>=20
> Thomas Huth (7):
> =C2=A0 pc-bios/s390-ccw: Remove duplicated LDFLAGS
> =C2=A0 hw/s390x/ipl: Provide more memory to the s390-ccw.img firmware
> =C2=A0 pc-bios/s390-ccw: Use the libc from SLOF for the main s390-ccw.img
> =C2=A0=C2=A0=C2=A0 binary, too
> =C2=A0 pc-bios/s390-ccw: Link the netboot code into the main s390-ccw.img
> =C2=A0=C2=A0=C2=A0 binary
> =C2=A0 hw/s390x: Remove the possibility to load the s390-netboot.img
> binary
> =C2=A0 pc-bios/s390-ccw: Merge netboot.mak into the main Makefile
> =C2=A0 docs/system/s390x/bootdevices: Update the documentation about
> network
> =C2=A0=C2=A0=C2=A0 booting
>=20
> =C2=A0docs/system/s390x/bootdevices.rst |=C2=A0 20 +++----
> =C2=A0pc-bios/s390-ccw/netboot.mak=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
62 ---------------------
> =C2=A0hw/s390x/ipl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 =
++--
> =C2=A0pc-bios/s390-ccw/cio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0pc-bios/s390-ccw/iplb.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
> =C2=A0pc-bios/s390-ccw/libc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 89 ----------------------------
> --
> =C2=A0pc-bios/s390-ccw/s390-ccw.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 10 +++-
> =C2=A0pc-bios/s390-ccw/virtio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0hw/s390x/ipl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 65 =
+++-------------------
> =C2=A0hw/s390x/s390-virtio-ccw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 10 +---
> =C2=A0pc-bios/s390-ccw/bootmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 4 +-
> =C2=A0pc-bios/s390-ccw/cio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0pc-bios/s390-ccw/dasd-ipl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 2 +-
> =C2=A0pc-bios/s390-ccw/jump2ipl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 2 +-
> =C2=A0pc-bios/s390-ccw/libc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 88 ----------------------------
> -
> =C2=A0pc-bios/s390-ccw/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +++--
> =C2=A0pc-bios/s390-ccw/menu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 25 ++++-----
> =C2=A0pc-bios/s390-ccw/netmain.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 15 +----
> =C2=A0pc-bios/s390-ccw/sclp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0pc-bios/s390-ccw/virtio-blkdev.c=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0pc-bios/s390-ccw/virtio-scsi.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0pc-bios/s390-ccw/virtio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0pc-bios/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0pc-bios/s390-ccw/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 69 +++++++++++++++++++----
> =C2=A0pc-bios/s390-netboot.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | Bin 67232 -> 0 bytes
> =C2=A025 files changed, 122 insertions(+), 383 deletions(-)
> =C2=A0delete mode 100644 pc-bios/s390-ccw/netboot.mak
> =C2=A0delete mode 100644 pc-bios/s390-ccw/libc.h
> =C2=A0delete mode 100644 pc-bios/s390-ccw/libc.c
> =C2=A0delete mode 100644 pc-bios/s390-netboot.img
>=20


