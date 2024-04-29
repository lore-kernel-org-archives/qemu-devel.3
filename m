Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D18C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1PGb-0002So-Jm; Mon, 29 Apr 2024 07:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1s1PGZ-0002ST-FU
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:33:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1s1PGW-0006VA-59
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:33:50 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TBQHfT029170
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 11:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+3jrbCc9MXYLEIAkU4Ah57QoD82HkGxZX9TiIaDUBYk=;
 b=azvUwH63Ba4TmN8UFHNCIIDqSrW3bP8TrpkyCpdUMBhlut1zWsolYzXf6XMQ6S1zaCOb
 R1qEdtJuE/nA/LRvAMyikkGsaqGTlGCgt74+HNLFfdY88uDZ9i668ZOdXCZYa6Figfdq
 b6p1MpQ1/Ug8aXRii4WYudh6RJdCabe4g3YChh3PI31NcdEl9Eh1aUGFWsOAigmkD+i0
 Pho8h1BYs3benAYTmlf/JsB4sCh1HaGxAFtVfyHiSaNuKNm4fBR8NOlNj762vRKjqA7u
 EnLB0ZlpEnap3EnftStM61rOzVKu1zN/ZfsoSbn5NhDqGm+9/uAUAjapjWoD8qqx+NRp 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xtans00n4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 11:33:45 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TBXjln008222
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 11:33:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xtans00n2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 11:33:45 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TBMoiQ027539; Mon, 29 Apr 2024 11:33:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsc3071kc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 11:33:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43TBXdZw47710492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 11:33:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10E652004F;
 Mon, 29 Apr 2024 11:33:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D82992004E;
 Mon, 29 Apr 2024 11:33:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Apr 2024 11:33:38 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>
Subject: [PATCH 1/1] vhost-vsock: add VIRTIO_F_RING_PACKED to feaure_bits
Date: Mon, 29 Apr 2024 13:33:34 +0200
Message-Id: <20240429113334.2454197-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jnqO2yt2-GNumyLD97PcNzNXCQRAT1RK
X-Proofpoint-ORIG-GUID: 2Gb89QXn9lUS0SXZhZeMHfExvjXZEmke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_08,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290073
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
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

Not having VIRTIO_F_RING_PACKED in feature_bits[] is a problem when the
vhost-vsock device does not offer the feature bit VIRTIO_F_RING_PACKED
but the in QEMU device is configured to try to use the packed layout
(the virtio property "packed" is on).

As of today, the  Linux kernel vhost-vsock device does not support the
packed queue layout (as vhost does not support packed), and does not
offer VIRTIO_F_RING_PACKED. Thus when for example a vhost-vsock-ccw is
used with packed=on, VIRTIO_F_RING_PACKED ends up being negotiated,
despite the fact that the device does not actually support it, and
one gets to keep the pieces.

Fixes: 74b3e46630 ("virtio: add property to enable packed virtqueue")
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---

This is a minimal fix, that follows the current patterns in the
codebase, and not necessarily the best one.

I don't quite understand why vhost_get_features() works the way
it works. Fortunately it is documented, so let me quote the
documentation.

"""
/**
 * vhost_get_features() - return a sanitised set of feature bits
 * @hdev: common vhost_dev structure
 * @feature_bits: pointer to terminated table of feature bits
 * @features: original feature set
 *
 * This returns a set of features bits that is an intersection of what
 * is supported by the vhost backend (hdev->features), the supported
 * feature_bits and the requested feature set.
 */
uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
                            uint64_t features);
"""

Based on this I would expect the following statement to be true: if a
feature bit is not in feature_bits then the corresponding bit in the
return value is guaranteed to be not set (regardless of the values of
the 3rd arguments and hdev->features).

The implementation however does the following: if the feature bit is not
listed in feature_bits (2nd argument) then the corresponding bit in the
return value is set iff the corresponding bit in the 3rd argument
(features) is set (i.e. it does not matter what hdev->features and thus
the vhost backend says).

The documentation however does kind of state, that feature_bits is
supposed to contain the supported features. And under the assumption
that feature bit not in feature_bits implies that the corresponding bit
must not be set in the 3rd argument (features), then even with the
current implementation we do end up with the intersection of the three
as stated. And then vsock would be at fault for violating that
assumption, and my fix would be the best thing to do -- I guess.

Is the implementation the way it is for a good reason, I can't judge
that with certainty for myself.

But I'm pretty convinced that the current approach is fragile,
especially for the feature bits form the range 24 to 40, as those are
not specific to a device.

BTW vsock also lacks VIRTIO_F_ACCESS_PLATFORM, and VIRTIO_F_RING_RESET
as well while vhost-net has both.

If our design is indeed to make the individual devices responsible for
having a complete list of possible features in feature_bits, then at
least having a common macro for the non-device specific features would
make sense to me.

On the other hand, I'm also very happy to send a patch which changes the
behavior of vhost_get_features(), should the community decide that the
current behavior does not make all that much sense -- I lean towards:
probably it does not make much sense, but things like
VIRTIO_F_ACCESS_PLATFORM, which are mandatory feature bits, need careful
consideration, because there vhost can't do so we just won't offer it
and proceed on our merry way is not the right behavior.

Please comment!

Regards,
Halil
---
 hw/virtio/vhost-vsock-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index 12ea87d7a7..fd88df2560 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -22,6 +22,7 @@
 const int feature_bits[] = {
     VIRTIO_VSOCK_F_SEQPACKET,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_RING_PACKED,
     VHOST_INVALID_FEATURE_BIT
 };
 

base-commit: fd87be1dada5672f877e03c2ca8504458292c479
-- 
2.40.1


