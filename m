Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E73AC7114A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Jun 2025 22:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQZcK-0005hX-PQ; Sat, 14 Jun 2025 18:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1uQZcI-0005hB-RH
 for qemu-devel@nongnu.org; Sat, 14 Jun 2025 18:44:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1uQZcH-0005Z4-01
 for qemu-devel@nongnu.org; Sat, 14 Jun 2025 18:44:50 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55EBlPV4017360;
 Sat, 14 Jun 2025 22:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=owYH9+W3hRYlUWlvt3hKR83PTh8Dtql8aQ3DucLz8
 s8=; b=IEyb4tNb3RwsqtALCiP/CR45Cn040Uk9pClbzRakcHd2mP1OHrLjD06Bt
 DAd3knbBgjG/BBwH/YGxTguwFgkEM1GWFXryQcHI75t7AU5IzERUsVkkohYdJuvd
 VuWJg2rWWNpHEq0zZq6egq+jdEzFEGRFvgVE4kKDMI/FDT/qyyOn4TBVrOKhKvu0
 7LxeSrgOzBpzr/NsdbXH+xCbjGaRneU6yvrEqg6js4u6iPwKMZpjoJwxfLwOir1E
 KyMFGIUzNSHN1JbWjNhEm9PL9gCVWHTueH5cOVEl4xHDzJBez6/mua8vW4H9m/o6
 cI7LMQzOUnoR9QxAHNTkaGMdamQ1A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790s430wn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 14 Jun 2025 22:44:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55EIBoQV014912;
 Sat, 14 Jun 2025 22:44:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rpreqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 14 Jun 2025 22:44:42 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55EMifqG15336168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Jun 2025 22:44:41 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E84658068;
 Sat, 14 Jun 2025 22:44:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E10D65805D;
 Sat, 14 Jun 2025 22:44:40 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.252.235])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 14 Jun 2025 22:44:40 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: jasowang@redhat.com, akihiko.odaki@daynix.com
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH] vdpa: Allow VDPA to work on big-endian machine
Date: Sat, 14 Jun 2025 17:44:22 -0500
Message-Id: <20250614224422.1595301-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE0MDE4NSBTYWx0ZWRfX3V1TdpbZ505k
 UmgTZErHNaU/02ZWS6YZWo1SyT6+MkF6WrYTgc6A5VBaRbnCcSODbASyMonBcYVlHE7Jkkk3vpW
 msy4xOeXYrzYyO1bV2Xbd3dTQP8yF6Y0b9rd5NcvLwhDHIv2zsCfNOxEG5zy76wu/pKnfy/VjsA
 bnhBd/c0pi0VkrnjfPPpcAWdLj7MUnzpbdf8vGQeGxqCoH4p+IN4He8JFUmE95pbVtIdsdSC5fg
 M0MB/WyVOmOz7rL5EWn8TKDW7n6GhvE2Ph4VFdqLG/b1Wcw+NPoFteDAaOWfJ1V1UlGPC4opbiy
 f2SKtBy5GWWbw0tWUQaoq8vgDycQ5gIhXLHZhmkmeDqF67Yfo9a25pypH5py9XutcatCLlkA3iQ
 JQUWz2z9n4QwuADt0Rb/X37iX4+eUkGlQPgpVCh7s5ZTINf1Vb/IMZth/aBLRoOCYfrUWtJF
X-Proofpoint-ORIG-GUID: Pr2ybvRHMGMKHOtovLkNNnklvji91hEq
X-Authority-Analysis: v=2.4 cv=Qc9mvtbv c=1 sm=1 tr=0 ts=684dfb5b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=wOKiVAmTcRLR3a3dhvcA:9
X-Proofpoint-GUID: Pr2ybvRHMGMKHOtovLkNNnklvji91hEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-14_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 bulkscore=0 mlxlogscore=844
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506140185
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
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

After commit 0caed25cd171 vhost_vdpa_net_load_vlan() started seeing
VIRTIO_NET_F_CTRL_VLAN flag and making 4096 calls to the kernel with
VIRTIO_NET_CTRL_VLAN_ADD command. However, it forgot to convert the
16-bit VLAN IDs to LE format. On BE machine, the kernel calls failed
when they saw "VLAN IDs" greater than 4095, and QEMU then said:
"unable to start vhost net: 5: falling back on userspace virtio", and
VDPA became disabled.

Convert the VLAN ID to LE before putting it into virtio queue.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 net/vhost-vdpa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 58d738945d..99c9eb42b9 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1173,9 +1173,10 @@ static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
                                            struct iovec *in_cursor,
                                            uint16_t vid)
 {
+    __le16 vid_le = cpu_to_le16(vid);
     const struct iovec data = {
-        .iov_base = &vid,
-        .iov_len = sizeof(vid),
+        .iov_base = &vid_le,
+        .iov_len = sizeof(vid_le),
     };
     ssize_t r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
                                         VIRTIO_NET_CTRL_VLAN,
-- 
2.34.1


