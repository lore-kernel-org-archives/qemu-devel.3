Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED062C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 19:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlYO1-0005bp-0p; Fri, 21 Feb 2025 14:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tlYNz-0005bc-8g
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 14:08:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tlYNx-0003yV-KC
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 14:08:31 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LIMkN1032068;
 Fri, 21 Feb 2025 19:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=hIOK3cSCCNw3u3O49ckJ4jLTqzgyGcJ+6tGCIl4X/
 BI=; b=R4k0VPTjOJz7jx9BU8+r5BDeRiAqpvsz4OrLcG7EqqCrPDpoCOXQyw+RN
 xvTnZAoCENWsMyMrfuEZu2hS9wLI7PG4frWMeFet88C8YNBccemnlzv99RzPQ5ev
 AyqFECBsV7h6qCVyu1T9mN9TqXXj3RbHTTrYyRn27NHYedn45tOgo9zXeGvaA57H
 64a9p63CyX/ymaGUydR7IhwmQ4Su1jb5kz19W3H//XAKTfZZVT+UK89R1zzOtYw+
 UodYY2Ns3WQ96QTvFSVEynxzzQuWC/qmwSzVG/B9FRA0s4kE8C3YuOqjcq2RyfGe
 JrJC3NShRV57K1hjS976xrr3L6JRA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xgb0ckb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 19:08:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51LIgwoH009646;
 Fri, 21 Feb 2025 19:08:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03yhq1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 19:08:26 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51LJ8PsK25100846
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Feb 2025 19:08:25 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7759B5804E;
 Fri, 21 Feb 2025 19:08:25 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED7645803F;
 Fri, 21 Feb 2025 19:08:24 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.243.178])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Feb 2025 19:08:24 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: jasowang@redhat.com, mst@redhat.com
Cc: eperezma@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v2] vdpa: Allow vDPA to work on big-endian machine
Date: Fri, 21 Feb 2025 13:07:33 -0600
Message-Id: <20250221190733.490308-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nbWz9C0ar1_m_5-LRq8PDF6Ul1MELYAz
X-Proofpoint-ORIG-GUID: nbWz9C0ar1_m_5-LRq8PDF6Ul1MELYAz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=886
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add .set_vnet_le() function that always returns success, assuming that
vDPA h/w always implements LE data format. Otherwise, QEMU disables vDPA and
outputs the message:
"backend does not support LE vnet headers; falling back on userspace virtio"

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
Changes in V2: Add code comment.

 net/vhost-vdpa.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 231b45246c..6e7cec4d45 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -270,6 +270,18 @@ static bool vhost_vdpa_has_ufo(NetClientState *nc)
 
 }
 
+/*
+ * FIXME: vhost_vdpa doesn't have an API to "set h/w endianness". But it's
+ * reasonable to assume that h/w is LE by default, because LE is what
+ * virtio 1.0 and later ask for. So, this function just says "yes, the h/w is
+ * LE". Otherwise, on a BE machine, higher-level code would mistakely think
+ * the h/w is BE and can't support VDPA for a virtio 1.0 client.
+ */
+static int vhost_vdpa_set_vnet_le(NetClientState *nc, bool enable)
+{
+    return 0;
+}
+
 static bool vhost_vdpa_check_peer_type(NetClientState *nc, ObjectClass *oc,
                                        Error **errp)
 {
@@ -437,6 +449,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
         .has_ufo = vhost_vdpa_has_ufo,
+        .set_vnet_le = vhost_vdpa_set_vnet_le,
         .check_peer_type = vhost_vdpa_check_peer_type,
         .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
-- 
2.34.1


