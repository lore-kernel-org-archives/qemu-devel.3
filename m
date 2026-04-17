Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67312F436B7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDl25-0004Ou-2a; Fri, 17 Apr 2026 11:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wDl1x-0004O5-TC; Fri, 17 Apr 2026 11:22:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wDl1s-00026E-26; Fri, 17 Apr 2026 11:22:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HBWITc1842962; Fri, 17 Apr 2026 15:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=jBjby11S4nFcZ9Lo87/gQFL4wW5kCiEyYupLuuLel
 f8=; b=pXcv3eoeVt+Ct0OzcWEEUx5oOzxQM0spQbenT0pP4yEO1VWClJQFD0qTj
 eFuZ5At8o7nSivddGEvKZXvhm5SKqUKOby0aofi2qJOd2qBwiXfX7JWbecYwHnKl
 yuVGpqxMEq/1z0u38i5i+NwCRC6ER7GJrR0r5v+hGzbPwtE7CfiqYwNlv2TYkxJN
 oYN7FVCqnc7KPFQvOSeDNugPkQlYLFtVHLEFUKWmoAAlUTIVnf1QIeKNPAmF5INn
 Kk/23ny5R+Xl6d96FcdGD7QmOjvFGQKfuJ+Q/qbZ1Cc0bSmIEaxSfHaqmITWJCy+
 9OnqWnKkXJr2znmzMikhfeG+c0vwQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89n38b4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 15:22:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63HDTAvk004188;
 Fri, 17 Apr 2026 15:22:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24kqn41-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 15:22:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63HFMcR253019050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Apr 2026 15:22:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D96620043;
 Fri, 17 Apr 2026 15:22:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CB5320040;
 Fri, 17 Apr 2026 15:22:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 17 Apr 2026 15:22:38 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 20BB1E05F5; Fri, 17 Apr 2026 17:22:38 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 0/1] MAINTAINERS: Update s390 trees
Date: Fri, 17 Apr 2026 17:22:35 +0200
Message-ID: <20260417152236.1305333-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1NCBTYWx0ZWRfX0ekeGc2beV5v
 515lniCM2f8dQqe8huEHYpiKMGgLA6OEVAqEnJjFPeg02DmLLTv78HnoWUEs1gFHMjxDonIYetH
 8+6MSGLI/RZ8V/g+iho5M2HVsnza0yao7qD/YcYOjcr8J1phDqjaZEY3YQI49AeDzVCr9bMy/WT
 OTBWFZIQfmRlOKQlEV7TEKabDEb2Kqmyqwuk1ec3IlJ4ybMYCADsLGRVvIVVuLUK7XE+TnedlXE
 8i/1G06aYF1q7DXgNeW5O27Tsv+EJw+2ZhXPBR53HtSzZUSRyJL2TjeT+F0KZ0dFjT5gWLGn6Un
 2iJoq3Zx8ygs0gGMTy6mOCi+gMecLypQm97UunNarW3ZvFlKL6tGViTApCYTbrtKxdvhlKSd1DH
 sMveU+WBkYPnBz1oYBpx1428uw0Fo86HClkJHzk2RhUWp95xaFFZrEdKnTOoGlDkswA/hVgqp0N
 /q2Gs13gunwElUWip5A==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69e25043 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=PyZucIbN2OmWj6MJiDsA:9
X-Proofpoint-GUID: 8oMjhYHcuO7GLKBATT6pN_VAZalxtnkm
X-Proofpoint-ORIG-GUID: 8oMjhYHcuO7GLKBATT6pN_VAZalxtnkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Hi Conny, Christian,

With the recent movement of s390 MAINTAINERS, we noticed
that the state of the s390 git trees is a bit off.

Wonder if this consolidation makes sense? Thoughts?

Eric Farman (1):
  MAINTAINERS: Update s390 trees

 MAINTAINERS | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--=20
2.51.0


