Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8AAC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96vU-0000K8-8Y; Tue, 22 Sep 2026 16:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tv-000828-Gj; Tue, 22 Sep 2026 16:15:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tq-0007fc-Ta; Tue, 22 Sep 2026 16:15:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI78VO3447122; Tue, 22 Sep 2026 20:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=RZJq60FfHcar2HU6Bwd0TPlt37EUFJpo/nLMF95Hm
 c4=; b=PDx6hZTe+sH6bvdrAixuPkO5pKU/6mzylJPsF1Lwo/dvNGYP7ar1z8oPz
 5tg7O7ys1xXwTiAZstu8ktEtGvR9sMIPM5/zahEtKB99ffcn/AkCUFfhmJv0f4S1
 Q85QTspIGrtE9LoYHX96qsqNXIfMG1DyqIS5ypl8wr2C1D2byLJLqc8k4yicgQsZ
 DLKnxGt2/WXIQjd6GcAuQc9kV/b5Jqnc8cFq8LiQNLX8Vv+lpdlVQ3IArItQNj3s
 IwDhHl4tWa8SnlyRvhZexFZQCv+B0sLjYd1sSNe2EPQ/RSuZlSLj1WbdIF2flMX1
 YQ0VZHK/bFQB05BSM73MqPz+jSmrA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1qsh3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHZhf4187977; Tue, 22 Sep 2026 20:15:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dyb3mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MKFRDZ41943450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 20:15:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9244D2004E;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73C9020043;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 5C80B161298; Tue, 22 Sep 2026 22:15:27 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 0/9] s390x: even more hardening fixes
Date: Tue, 22 Sep 2026 22:15:16 +0200
Message-ID: <20260922201526.2383047-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T9YzQdWWsrjSNNg-5TVmglW7YiPbLzsT
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab2e1e4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=G1RilveMM4ynofw92BUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfXy95j2aCTgLPn
 D4faXfcTSO6E6WNBxmIPjossttntOPwRxKxiUqWnWFDR2IyNNSVSkvtbLhJFa6mBTleQkgjd+um
 mLqzCiW1UITBpWz+w7ldKj4lLhreNtQ=
X-Proofpoint-GUID: T9YzQdWWsrjSNNg-5TVmglW7YiPbLzsT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX0UMR2D6IJPPV
 +BZhfK/96CDTcR9Fa0iXumWCuN8Ue2QejAxcIWWS+G+EU2RBtqWO9KN/7esI3GA9RFMi0EZzWHx
 V+3C2/CxHerMTqErmB8MagMwDOZACcmG4OPdwvhCt5sDRsACH0E0rBcK1N4sIOVWVoSUE5ev+wo
 tV/eFSLg9PSRQQccZqf97HtO2Yyk/Ieu3lwMdodd44PW67Eye63SjpYMapmFi3RuAP7i/H7BxZa
 0Hz+j3TnOFPhUwgfdpwcyej0GOF4S0hGiySv12ztPZ6HAI4HOTFAY2NszHggXxfghbX9tyMjPyb
 Y0sMEeWPOrMB1CNirFS4sruESazrdUAgR4lRKSvcx5ys6KUXyWYqTdTTgDlbrQfvpWr4tD9dTyV
 WvJpa1H9VqkCnmEePBB0GNrowvu1+W/A+kpkLu6EiId4zeMFEojVmkXhBeWB17FNu6PyfrljfQ8
 rxQJI+8IbJt1NiF6VaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220293
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

v2->v3:
 - Collect reviews/acks (Thanks Christian, Matt!)
 - [CB] Patch 7: Rename realloc variable to new_buf
 - [CB] Patch 8: Move check of at_byte before check of command chaining f=
lag

v1->v2: https://lore.kernel.org/qemu-devel/20260921184305.3791311-1-farma=
n@linux.ibm.com/
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
 hw/s390x/css.c          | 28 ++++++++++++++++++++--------
 hw/s390x/sclp.c         |  6 ++++++
 hw/s390x/virtio-ccw.c   | 29 ++++++++++++++++++++++++++++-
 hw/vfio/ap.c            |  4 ++++
 hw/vfio/ccw.c           |  2 ++
 6 files changed, 65 insertions(+), 12 deletions(-)

--=20
2.53.0


