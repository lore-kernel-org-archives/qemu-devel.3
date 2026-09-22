Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372D2C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96vN-0000Ey-N9; Tue, 22 Sep 2026 16:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tu-00081t-36; Tue, 22 Sep 2026 16:15:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tr-0007fe-5u; Tue, 22 Sep 2026 16:15:37 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7Rdx3447527; Tue, 22 Sep 2026 20:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=qyRP9gix4X7Wva7VD
 C0mSmWL3CSHNCxNFONlLaz7Krw=; b=oes62qCwtlH59yh+F//Gd9CD58wlsgIq9
 rCzmZCc7foMtAFpLRnUr1TGkmUxgAIzQRml/KMRKdiqvffC9ZEWmcWwcG6aXyAV1
 2nljzmgO7Rz/JGDOVt8tp5LgVk39jwi/bXf/LewRMUdZ5QcxU6q2876C6P9d7RBu
 TzedfjdTNRb7EFTQGeNlRc6gquwBGy9insI+xHz5U8ITH4vdiZ27EQwViHzIDqDM
 3SbOP2w0NZpSWjfrLnuKGx84qN0xzghhblIh36dgw4cl8Moxm8os8ucHR3ToQZOw
 GPMDMlQH+BY2Eq5sWWbz9k2Sgx1374z6CjjTFHgExV/qffpHa3Ieg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1qsh2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHWEe1972713; Tue, 22 Sep 2026 20:15:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkdw1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MKFR8C26935668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 20:15:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 958EC2004D;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 791D62004B;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 62E40161539; Tue, 22 Sep 2026 22:15:27 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 3/9] virtio-ccw: Fix rc check in read configuration path
Date: Tue, 22 Sep 2026 22:15:19 +0200
Message-ID: <20260922201526.2383047-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922201526.2383047-1-farman@linux.ibm.com>
References: <20260922201526.2383047-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fXkTB_ux423T4xZx6yWtY9rTa3fY6pdh
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab2e1e4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=uiMiztMkydEs4ieJCJEA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX+chpqejnXT3G
 P9TcRJQyGdQGGnxHyMewOpaRW3u7tyBu+AWyoRr3O63xHwlmDbwatcPvMk/aDytWGTIhf0BgsWe
 caFAfowCgieR87yUA8RPSNodX3F0uZ0=
X-Proofpoint-GUID: fXkTB_ux423T4xZx6yWtY9rTa3fY6pdh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfXwTmNNKm/9FHE
 Z6OgCl9towVxO/SKaY0+JZ07sP6UL7dyd084l+4ZLuDLPVCofKSASzLFi32aXigFjB/S+8Nb32d
 ZjXruv725gkQAXzaEXdeSrXPuGRmPDiJ7ntt4XjajgfiMj3cIdeFTmuld2j1Ao7wfUrIoqwmvtD
 nXhl/7oWPjlleU3vIXXhTfvFoDv7ONFNJrCs96aRvNnJNKgqgKPG+IxF6nO0HYeyJpV1AS7gHM/
 Lc9Gn7owvWnO1bb3Yzwl9+PQ8K27/aVXEsMS0v+I+ztNlCjiU8xR0Hz55Q76g0DA+diDfRFx6yD
 DASt/ctmpjz6IrFP3krcDXBeUfnYLb8IfoR3oPfaUhXtzWzpgugM1Or49YXGPMSjUtvSCozRUD2
 dGn9azIsaUHdZ3biOxiCGrPrqYgB4iQs5LzwXxSOVOeLKesNQBswCF1LaY9ZQleoIF6ceUgDt+I
 BgOXmGu2EUw7Xr5JJQA==
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

Both the read and write config paths use wrappers around cds->op_handler,
depending on the direction the I/O is flowing. But they expect opposite
values in the returned variable to indicate success.

Fix this by unifying those checks, where CCW_CMD_READ_CONF needs to
see !ret as success. The end result is some erroneous data in the
SCSW response data, but the overall success/failure is correct.

Cc: qemu-stable@nongnu.org
Fixes: d895d25ae2 ("s390x: css: report errors from ccw_dstream_read/write=
")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/virtio-ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index f46f936150..11441e56c1 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -475,7 +475,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         } else {
             virtio_bus_get_vdev_config(&dev->bus, vdev->config);
             ret =3D ccw_dstream_write_buf(&sch->cds, vdev->config, len);
-            if (ret) {
+            if (!ret) {
                 sch->curr_status.scsw.count =3D ccw.count - len;
             }
         }
--=20
2.53.0


