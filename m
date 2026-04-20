Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5A2F588E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEpvL-0007GG-9Y; Mon, 20 Apr 2026 10:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wEpv4-0007DX-Ts; Mon, 20 Apr 2026 10:48:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wEpv2-00043c-PP; Mon, 20 Apr 2026 10:48:14 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63JNoiBN3689187; Mon, 20 Apr 2026 14:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ggx50fiGqUmzJjEb461wAkP8w3ZYmH8lu7WYf9RqO
 0E=; b=lpo4OnVEt6eZImSxfVj7k9RcFrFLODGEjG0bJMumZiVQ5NdsTKCQ119Cu
 /aEWK63Idi0niZHIQRQXP7JdtPUykiQAC0kKGOSWNUqRfo23CgVUXPgMY4Tgbiy/
 6lFR7Iikv4L805r3vpqvh3VYYMik5mpq8G+fviFKjgPS3QhMUPc40YoQzuvU7c4G
 MFseIYM04EakEm3vecDq95U4zAyBnqyxHhIMF6NcGnww8eeT8omtlPCLdniUx9Ca
 GbJXWr1Mi7DYHsUBA6mWToxZbvOE/adV4HQp8VEACCGK3YHHBRKU7xZQUSJqSpbd
 vIIoAfFj+ZdNhkVWSPolVygSrWKCg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nf0a1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 14:48:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KEcdFZ017158;
 Mon, 20 Apr 2026 14:48:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmm9pwa15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 14:48:04 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63KEm24B32244436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Apr 2026 14:48:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCF115804E;
 Mon, 20 Apr 2026 14:48:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2C955803F;
 Mon, 20 Apr 2026 14:48:01 +0000 (GMT)
Received: from IBM-GLTZVH3.atx-us.ibm.com (unknown [9.16.58.46])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Apr 2026 14:48:01 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, cohuck@redhat.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v2 0/1] hw/s390x/ccw: Disable legacy mode
Date: Mon, 20 Apr 2026 09:47:33 -0500
Message-ID: <20260420144759.2970726-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gcNQnf-4cNApVLlKItks8yaBVd_zOqtk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE0NCBTYWx0ZWRfX5yUWSwzda8ZG
 t6o0yJnxqEtqFf40B6Z8ZBtuf5dKM7k2ucFzPsR6Inaq+O2EvkdVRdNw5zueQs75jL0Mw8/m3Cz
 j/sql+XuDPp9iiAyaFVCxwyKF/o5WO/qhli1umuI7hEgODQ1pSUVVN4YMl2jD17UtrhTDbF0goh
 CeV3j4PAgd9Ubah0d6ZZ6jLoGLrKLRvjT3xaHhUde+r01KJ3LvUQqmE53XPkPopNCFxpYFmewR5
 IH5zQsJBXwO6w3vvGZ3joXHifWHbX0xArEPCQO/0Toj9cn/OrqjiI47HB/wBh8iVCMUm9OLWeny
 pKLWgdbd3bn6YCDZCdwRGNf4t0JW7KkpoDkzs2cMrnqtRlLkXy108CiCWM47b3v1nbH9T3ISo9R
 Npddof22cqIOR0yMHiXr7fMRtpT7OCBS7IGpNYot7wiv0hSzJihSk/MnT+fUzP+SBgwb60kCajp
 xzmsX0oi1iuiuKpC3YA==
X-Proofpoint-GUID: gcNQnf-4cNApVLlKItks8yaBVd_zOqtk
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e63ca4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Tlqw0IQ_KjvEc9IBcG4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200144
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
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

Hello,

This is v2 of the patch.

Changes in v2:
- Drop RFC tag as the approach has been reviewed and agreed in principle.
- Improve comments to clarify why legacy virtio-pci is not usable on s390x
  due to lack of I/O BAR support (IO_SPACE_LIMIT is 0).

No functional changes.

RFC v1:
https://lore.kernel.org/qemu-devel/20260417154332.849664-1-jhkim@linux.ibm.com/

Thanks,
Jaehoon Kim.

Jaehoon Kim (1):
  hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+)

 hw/s390x/s390-virtio-ccw.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.50.1


