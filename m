Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A87AC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 17:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thu9Y-0007no-J4; Tue, 11 Feb 2025 12:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1thszZ-0004zx-NL
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:20:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1thszX-00029E-LZ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:20:09 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BDgNKf021694;
 Tue, 11 Feb 2025 16:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=75AOCLqOvzG86tQn0BeU/zKJK/1FrvZuuOdGjJEQu
 Xc=; b=avlrXfocuhNbc4X0unk8dRhiZVBW9C81qkG8fDC25yC2IF09xLMMoGOlk
 RueJ8Rx/fBYGThWqFU2QovGasrDN026WU0y+IhVsTWM5w3A8cQoxEmJnegKkMR1h
 SsBuZYAMswIMacX55QJqu/7FGj2xCbiP1sFSSa435NK7CvbAHTWJSexpVE+fPukH
 vZSzJctRUcH1jneHBrZWf7mklqEAKi4GZYdagbZGWo5dyj4PwZqZUPjMkPsm2CXH
 MpZrA59Gz3qCRySr+0WfVui14s+tZFHgozZYfLV08xVFbhh0/aXo+uAcEhl0cVFJ
 Juf3c1dV0HqqlAadOu58ZFkt5vamg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44qwd1bh5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Feb 2025 16:20:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51BEQPtk011642;
 Tue, 11 Feb 2025 16:20:02 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pktjuum9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Feb 2025 16:20:02 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51BGK1di18023102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2025 16:20:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4B6E5806C;
 Tue, 11 Feb 2025 16:20:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 375C95805D;
 Tue, 11 Feb 2025 16:20:01 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.104.243])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Feb 2025 16:20:01 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: eperezma@redhat.com
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH] vdpa: Allow vDPA to work on big-endian machine
Date: Tue, 11 Feb 2025 10:19:23 -0600
Message-Id: <20250211161923.1477960-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ACfD_gP2YC4aYQxAupOMWBPMyU0bFXnG
X-Proofpoint-ORIG-GUID: ACfD_gP2YC4aYQxAupOMWBPMyU0bFXnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 adultscore=0 impostorscore=0 mlxlogscore=826 clxscore=1011
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110106
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 11 Feb 2025 12:34:14 -0500
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
 net/vhost-vdpa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 231b45246c..7219aa2eee 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -270,6 +270,11 @@ static bool vhost_vdpa_has_ufo(NetClientState *nc)
 
 }
 
+static int vhost_vdpa_set_vnet_le(NetClientState *nc, bool is_le)
+{
+    return 0;
+}
+
 static bool vhost_vdpa_check_peer_type(NetClientState *nc, ObjectClass *oc,
                                        Error **errp)
 {
@@ -437,6 +442,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
         .has_ufo = vhost_vdpa_has_ufo,
+        .set_vnet_le = vhost_vdpa_set_vnet_le,
         .check_peer_type = vhost_vdpa_check_peer_type,
         .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
-- 
2.34.1


