Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BFEC3ABC9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 01:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF1H4-0003zA-Gn; Tue, 13 May 2025 21:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1uF1H2-0003yP-4r; Tue, 13 May 2025 21:51:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1uF1Gz-0004cX-4s; Tue, 13 May 2025 21:51:07 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DIbL58019722;
 Wed, 14 May 2025 01:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3TmlgH
 ZALTWqS81chkCb8NRkxHLignnYMhvhlXZJoRM=; b=Dr5CmMO0SgSYH3iOX3tKOF
 L+ZyvB99RjBJ17b4b5YjQQufZ9pSXp/TajeWstYr4P2ryUTw3Egcl/QCrz79FDJ5
 fcgD/c9gsqnxFbQYYyjfK0RiwaydhKYWgdi5hztO+w11TkeSEZLLfd2t9x4+1k1o
 bEG+EHOoy/t2FuF1q+Z8jQ+lzoYJnDdb3nr/oO+D8XVzuEP7J8UxV5aMc+4+gl5k
 rTGeD+zTXvCivYfYHUuWjBdfnBJu48AYx7zxgL5e/7yLTOfiI9dL+KTJt9Yh0O6k
 ZA8VmcjuChSxjhyjWgRDLpS0ffyeefWW1gubw5PUZJDttGJLlf8iyw/sTsDc0rwA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbh79hua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 01:51:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54DM78Eh021396;
 Wed, 14 May 2025 01:51:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrhp1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 01:51:00 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54E1oxPK31982318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 01:50:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A84E58054;
 Wed, 14 May 2025 01:50:59 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F9BE5804E;
 Wed, 14 May 2025 01:50:58 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.144.77]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 01:50:57 +0000 (GMT)
Message-ID: <6e9032190e5899124829a322687f8eafb5d9898a.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/9] s390x: Remove deprecated machine types up to v4.0
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>
Date: Tue, 13 May 2025 21:50:57 -0400
In-Reply-To: <20250506062148.306084-1-thuth@redhat.com>
References: <20250506062148.306084-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YbW95xRf c=1 sm=1 tr=0 ts=6823f705 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=FyhYd2wihLo59oQhctUA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XSYuiwszhYH45_X99lf7WVnXOEeOGlw3
X-Proofpoint-ORIG-GUID: XSYuiwszhYH45_X99lf7WVnXOEeOGlw3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAwOCBTYWx0ZWRfX6DoRpYJPg10t
 CK7nRA3mDyr/Yl9M3BryhZdTsuDnuS9VuGj87LMkQMC8Uk1dBeI1V3YtzNavyu4pdv2L4eI8cPY
 NKMu0q3d2kUglNnRAT7BmJcjoYitwPX/RxM2brCfE9xvcuu7qobFDet4eLjEKD26xAf8DmsCBBA
 y0jVxlLIm/Ql8Mh8WnqbhoiKd23i4hue+6nWTPdXGEwj2kRk+cE7MKFU1z3knCSDNK4dsGsQ/k5
 IKp/aL1EkR8YCIsn8chIaXNZoXKyKEZ4yTJ9zcmbKzb+ZscD6WRJkLaKd28i7hxDqGimkiDMVGB
 BVrXMPcS840naD8ziaXTOrcbHxNib4MgINz25UmAKLP1GU7l3JBSeN1w0rBgZrGEtZKQHdxN3r5
 pIZzY8TUnkU2EDwkpr7FKiCGiHxko/Ln/RbbIiZiIIThOlVkwPX/9Rg7Omevxasszu/bOnW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=906 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140008
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 2025-05-06 at 08:21 +0200, Thomas Huth wrote:
> The machine types up to s390-ccw-virtio-4.0 are older than 6 years
> and thus, according to our support policy, are scheduled for being
> deletion now. These patches remove the machines and clean up the
> related compatibility handling that is not required anymore.
>=20
> v2:
> - Some patches are already upstream, thus dropped them from the series
> - Split the patch to remove 2.10 and 2.11 into two separate patches
>   (for consistency with other patches)
> - Fixed a problem with the QemuFeatDef feature set

Ah, I was wondering about this part in particular before you'd sent this v2=
, so now my question is
moot.

For the series:

Reviewed-by: Eric Farman <farman@linux.ibm.com>

>=20
> Thomas Huth (9):
>   hw/s390x/s390-virtio-ccw: Remove the deprecated 2.10 machine type
>   hw/s390x/s390-virtio-ccw: Remove the deprecated 2.11 machine type
>   hw/s390x/event-facility: Remove the obsolete "allow_all_mask_sizes"
>     code
>   target/s390x: Rename the qemu_V2_11 feature set to qemu_MIN
>   hw/s390x/s390-virtio-ccw: Remove the deprecated 2.12 machine type
>   hw/s390x/s390-virtio-ccw: Remove the deprecated 3.0 machine type
>   hw/s390x: Remove the obsolete hpage_1m_allowed switch
>   hw/s390x/s390-virtio-ccw: Remove the deprecated 3.1 machine type
>   hw/s390x/s390-virtio-ccw: Remove the deprecated 4.0 machine type
>=20
>  include/hw/s390x/s390-virtio-ccw.h |   4 -
>  hw/s390x/event-facility.c          |  37 +-------
>  hw/s390x/s390-virtio-ccw.c         | 131 -----------------------------
>  target/s390x/gen-features.c        |  13 +--
>  target/s390x/kvm/kvm.c             |   6 --
>  5 files changed, 4 insertions(+), 187 deletions(-)
>=20


