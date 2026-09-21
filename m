Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA78C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8izK-0005Ly-Rj; Mon, 21 Sep 2026 14:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz3-0005Gd-LH; Mon, 21 Sep 2026 14:43:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz1-0005zb-SR; Mon, 21 Sep 2026 14:43:21 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8aCU703753; Mon, 21 Sep 2026 18:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=1zr+1jitTlwCrsAuWLhAUMtVZhm5nHAF76ARth0In
 JY=; b=ZdXTHF9lSYkjZC/ssFCOOifLFDCmQGQiV6l3Jwo4kXll4n3UILfXCAg1e
 3IuHimYbCe/SgDJ9tpW8CXADIAC65fPJaYaMzxOZ3R9wQsZki8SoQTA82fxJMejh
 LEPffl6ZB5LgzMQvJhTPK1pNIMBEzVA2mE0seatLdkrYxG2PRlLIuD5Mr1SL6sg6
 wfuGOmQLRei34odQ863hQ6hQIxrSso6GtETN91ngC66IgxwEoCsjf5N/nwEII7dk
 6CaQmyIkZeM2r11ttd7LbN1vTDqnTNezBhKKG1Wj51WSW1Hwu0nho3UHSA6/Ahr5
 Ey1ItLZRmy2DH+TuTKpBcGt1y+6Rg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq9ypn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LFHTUx1489428; Mon, 21 Sep 2026 18:43:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq6s2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LIh9ok40239556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 18:43:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A02342004B;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8121220043;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 674C3160EE0; Mon, 21 Sep 2026 20:43:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 0/9] s390x: even more hardening fixes
Date: Mon, 21 Sep 2026 20:42:56 +0200
Message-ID: <20260921184305.3791311-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab17ac2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=G1RilveMM4ynofw92BUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX3AP3d4QZGDdj
 ob/1zjud7dphJSA8mKv2iqWh7V7Gr0xpP6eNrtPNw7qZyRopa5V7tBAs2aD2cbgA8sY7jluWYkj
 HkdoTNw1tzX/hs99zZP2NBPMkDyr2eHSrH6XsctopuTOlJK8eTM3VMtMKhHjCGr1RnC8jOwTLpm
 XZlfBHUoVd8q0rohTfb4YL3Guy+G7CNf8Lf60n0RRtTOpvO0hcZTEQdQci3YifK/GgVyWerdWzj
 SXe+pPypQxkZr54CvWOtdf9p4iTcTVeZ6xlrcqdQG5qbFcThNlPFyte5VF0PLp1q4HVvbKWUN/I
 y2w7i20q3Kvex8UtbGYe7xfs1EhlyHyqqmVPGnpLyQy8d5/o22NHfG8JbmDkr9nSyYE5PyIQymr
 qvsuuxzdvZS3vbPzGZNQmZ3tNpGQ8Pm1qXJ1lXtuo/b+fyjN1YxUcVpvBIISa2ti5wkXa+qvIV4
 fQSRGOPGeip0uMXzzQw==
X-Proofpoint-ORIG-GUID: mtwyee8nbndN-v80Ty5FiDxjnccuwQzA
X-Proofpoint-GUID: mtwyee8nbndN-v80Ty5FiDxjnccuwQzA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX2Ld/ybAg6+M+
 wDNgU717zgzG3SePw+HL+IKRYYXP7c7ZPO8Yw+faazXgh3K0y17JAyWAy6eWrnuI2JzE15C2opM
 J79yK3X8Krf2OVb5F8jCGqZt32aDsXk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210272
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A small pile of additional hardening fixes.

v1->v2:
 - Collect reviews/acks (Thanks Matt, Christian, Tony!)
 - [MR] Add fixes/stable tags to patches 1, 2, 8
 - [CB, MR] Drop fixes/stable tags from patches 5, 6
 - [CB] Patch 2: Unwind indicators upon re-set, instead of rejecting it
 - [MR] Patch 7: Use a temporary variable on g_try_realloc() call
 - [MR] Patch 8: Use CCW datastream to increment no-data count
v1: https://lore.kernel.org/qemu-devel/20260916203242.2509787-1-farman@li=
nux.ibm.com/

Eric Farman (9):
  virtio-ccw: Limit ISC to MAX_ISC
  virtio-ccw: Do not overwrite existing indicators
  virtio-ccw: Fix rc check in read configuration path
  vfio/ap: Clear error object pointer after non-fatal errors
  vfio/ccw: Clear error object pointer after non-fatal errors
  hw/intc/s390x: Fix payload to KVM_HAS_DEVICE_ATTR ioctl
  hw/intc/s390x: Fix check after g_try_realloc
  s390x/css: Use datastream pointer for checking no-data CCWs
  s390x/sclp: Reject short headers in PV case

 hw/intc/s390_flic_kvm.c |  8 +++++---
 hw/s390x/css.c          | 27 +++++++++++++++++++--------
 hw/s390x/sclp.c         |  6 ++++++
 hw/s390x/virtio-ccw.c   | 29 ++++++++++++++++++++++++++++-
 hw/vfio/ap.c            |  4 ++++
 hw/vfio/ccw.c           |  2 ++
 6 files changed, 64 insertions(+), 12 deletions(-)

--=20
2.53.0


