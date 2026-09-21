Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B87C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8izL-0005Mt-9o; Mon, 21 Sep 2026 14:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz4-0005Gf-Kx; Mon, 21 Sep 2026 14:43:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz2-0005zv-0D; Mon, 21 Sep 2026 14:43:22 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8Er24193462; Mon, 21 Sep 2026 18:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vRIXMRakBGJfbZE8Z
 DtYsNbMqHwAb87+JJN6vShZ2FI=; b=BmxgpMAa6EkBPy/6JCD5o7FC5HiNqbg+J
 TWeiBdvohYElKMPH/40sxWQCZii9KmhDXXKRYgsuU/nUqJ4bA8lCDJmGrgUOLSko
 D4k3E/tzx/CZCmseeatUZhhEyWsxpi392JcG5hTVjWRMUbc7oW0if1khaFHDjF2W
 LngbB9i/79w3Bns3Bm95sZYbiQbuLE+W2vy1Q/XyrvTcv9EartE4TJ3uyw5iA2Pq
 Vc78r1u11Kq5VshynXZOSZnWpaui3i3D8hCOfn0T03GSTTK4qIWsvBo30jCXi1gh
 GTWakZQp/4z50Z37I9pEXQqcsl8yLGZaxwzQN/l4Zqe4DkqxNXv4w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1j78v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LFHZe31451443; Mon, 21 Sep 2026 18:43:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gpjg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LIh9Oi45351312
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 18:43:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCB252004E;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADB952004B;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 70774162260; Mon, 21 Sep 2026 20:43:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 5/9] vfio/ccw: Clear error object pointer after non-fatal
 errors
Date: Mon, 21 Sep 2026 20:43:01 +0200
Message-ID: <20260921184305.3791311-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921184305.3791311-1-farman@linux.ibm.com>
References: <20260921184305.3791311-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GdMdESW48vDzgt2Xj7eoXAUKzolVs_Zn
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab17ac2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=WuYEg3pJWr1ZmXxL5igA:9
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX20DCUwp/OjUm
 aqXwy5d+bi3DVODQzN3GaSQApKjxn4gna+VldUkeQSAeFztFEogZq6IE5P7CjplHg9Ev1RWttjN
 64494B0Gj+VR2e3wqXvusrH2sZfvPXY=
X-Proofpoint-GUID: GdMdESW48vDzgt2Xj7eoXAUKzolVs_Zn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX7U3t5eDRFd0E
 IwPJyU0irHUnjU5Mwu7s5WxegenAT6NofX8nQRslNr7uN+TXXqdD3YEnCjZvTxIfeOvPyL5DZ8f
 Nx0DW8pOMAjWwart4nxkspaxpr0xv9zQ9Ap1/Cfc90NXa/A1XGeKdTNqYMod77Y/pbOdEjG5ZID
 n3/jKoK1Zrv3TirTLixpD5i7T8QXOVNvop/rvl5aHVPvIE6CkeNV4EGqFV5KFsYpub9Bp07PDXb
 oeVRh+0s9hIZlId/nvlQHWTvpkJ61G2YyDAzA4yq4b1e2+wQg/Yhm3caw4yYz/YtBJBRMOnoFnN
 ZXcWssmy/FZhUWfrSC5N0Avml7FJV9ko2gkMqiXsgH0Tnxvwm7sqgbj96lCsnE0ZCs+C8noFm66
 eA5cZAmoeho396pNNYnID3yTbDg8uY4KNz5ivCcvA2kV6IEtehkfs1rR7KS03aXT7oOKN9eol2j
 tljb+Sf5Cm5bmlcFPtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210272
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

Just like in vfio/ap, there is a non-fatal message that could be
generated, with a stale pointer in the error object variable.

Unlike vfio/ap, there is no secondary message that could attempt
to use it. Clear it in the same way, in case that ever changes.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/vfio/ccw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index c3dc7c1962..8e29a3ae61 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -604,8 +604,10 @@ static void vfio_ccw_realize(DeviceState *dev, Error=
 **errp)
         /*
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operatio=
n.
+         * Clear the pointer, since the warning will release it.
          */
         warn_report_err(err);
+        err =3D NULL;
     }
=20
     return;
--=20
2.53.0


